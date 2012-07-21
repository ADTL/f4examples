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
/* external function */
extern void delay_ms(unsigned int timeout);
/* work */
void work() {
    /* enable led port */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
    /* set led pins to output state */
    LED_PORT->MODER |=
        GPIO_MODER_MODER12_0 | GPIO_MODER_MODER13_0 |
        GPIO_MODER_MODER14_0 | GPIO_MODER_MODER15_0;
    /* enable leds */
    LED_PORT->ODR |= ALL_LEDS;
    /* infinity loop */
    while (1) {
        /* wait a half second */
        delay_ms(500);
        /* switch leds */
        LED_PORT->ODR ^= ALL_LEDS;
    }
}