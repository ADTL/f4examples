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
/* work */
void work() {
    /* enable led port */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
    /* set led pins to output state */
    LED_PORT->MODER |=
        GPIO_MODER_MODER12_0 | GPIO_MODER_MODER13_0 |
        GPIO_MODER_MODER14_0 | GPIO_MODER_MODER15_0;
    /* get reset flags */
    unsigned int flags = RCC->CSR;
    /* clear nothing bits */
    flags &= ~(1 << 24 | 1 << 1 | 1 << 0);
    /* enable led for needed flags */
    switch (flags) {
        /* hardware reset */
        case RCC_CSR_PADRSTF:
            LED_PORT->ODR |= RED_LED;
            break;
        /* another reset */
        default:
            LED_PORT->ODR |= ALL_LEDS;
            break;
    }
    /* clear reset flags */
    RCC->CSR |= RCC_CSR_RMVF;
    /* infinity loop */
    while (1);
}