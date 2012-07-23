/*-----------------------------------------------------------------------------
* Author: Boris Vinogradov(nis) : no111u3@gmail.com
* File: work.c
* Type: C code file
* Project: f4examples/01-gpio/00-base
* 2012
*-----------------------------------------------------------------------------*/
/* include headers */
#include "stm32f4xx.h"
#include "core_cm4.h"
#include "work.h"
/* hardware delay and switch */
void hard_delay(void) {
    static unsigned int counter;
    counter++;
    /* wait a half second */
    if (counter > 500) {
        /* switch leds */
        LED_PORT->ODR ^= ALL_LEDS;
        counter = 0;
    }
}
/* work */
void work() {
    /* enable led & button port */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN | RCC_AHB1ENR_GPIOAEN;
    /* set led pins to output state */
    LED_PORT->MODER |=
        GPIO_MODER_MODER12_0 | GPIO_MODER_MODER13_0 |
        GPIO_MODER_MODER14_0 | GPIO_MODER_MODER15_0;
    /* pull-up button io */
    BUT_PORT->PUPDR |= GPIO_PUPDR_PUPDR0_1;
    /* enable leds */
    LED_PORT->ODR |= ALL_LEDS;
    /* setup SysTick timer */
    SysTick_Config(16000);
    /* infinity loop */
    while (1) {
        /* if button pressed */
        if (BUT_PORT->IDR & BUT1) {
            /* change status to two leds - red & green */
            LED_PORT->ODR ^= GREEN_LED | RED_LED;
            /* wait while button pressed */
            while (BUT_PORT->IDR & BUT1);
        }
    }
}