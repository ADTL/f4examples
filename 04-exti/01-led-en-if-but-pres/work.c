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
    /* enable led & button port */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN | RCC_AHB1ENR_GPIOAEN;
    /* set led pins to output state */
    LED_PORT->MODER |=
        GPIO_MODER_MODER12_0 | GPIO_MODER_MODER13_0 |
        GPIO_MODER_MODER14_0 | GPIO_MODER_MODER15_0;
    /* pull-up button io */
    BUT_PORT->PUPDR |= GPIO_PUPDR_PUPDR0_1;
    /* route exti0 to pa0 */
    SYSCFG->EXTICR[0] |= SYSCFG_EXTICR1_EXTI0_PA;
    /* setup exti0 to rising edge */
    EXTI->RTSR |= EXTI_RTSR_TR0;
    /* setup exti0 to failing edge */
    EXTI->FTSR |= EXTI_FTSR_TR0;
    /* enable exti0 interrupt */
    EXTI->IMR |= EXTI_IMR_MR0;
    /* nvic enable exti0 irq */
    NVIC_EnableIRQ(EXTI0_IRQn);
    /* infinity loop */
    while (1);
}