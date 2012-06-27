/*-----------------------------------------------------------------------------
* Author: Boris Vinogradov(nis) : no111u3@gmail.com
* File: work.c
* Type: C code file
* Project: f4examples/01-gpio/00-base
* 2012
*-----------------------------------------------------------------------------*/
/* include headers */
#include "stm32f4xx.h"
#include "work.h"
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
    /* infinity loop */
    while (1) {
        /* if button pressed */
        if (BUT_PORT->IDR & BUT1) {
            /* enable leds */
            LED_PORT->ODR |= ALL_LEDS;
            /* wait while button pressed */
            while (BUT_PORT->IDR & BUT1);
            /* disable leds */
            LED_PORT->ODR &= ~ALL_LEDS;
        }
    }
}