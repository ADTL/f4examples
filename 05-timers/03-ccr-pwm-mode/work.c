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
#include "gpio_af.h"
/* work */
void work() {
    /* enable led & button port */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN | RCC_AHB1ENR_GPIOAEN;
    /* enable tim4 */
    RCC->APB1ENR |= RCC_APB1ENR_TIM4EN;
    /* set led pins to af state */
    LED_PORT->MODER |=
        GPIO_MODER_MODER12_1 | GPIO_MODER_MODER13_1 |
        GPIO_MODER_MODER14_1 | GPIO_MODER_MODER15_1;
    /* select af block - tim3..5(af2 function) to led pins */
    LED_PORT->AFR[1] |= (GPIO_AF2_TIM3_5 << 28) | (GPIO_AF2_TIM3_5 << 24) |
        (GPIO_AF2_TIM3_5 << 20) | (GPIO_AF2_TIM3_5 << 16);
    /* pull-up button io */
    BUT_PORT->PUPDR |= GPIO_PUPDR_PUPDR0_1;
    /* route exti0 to pa0 */
    SYSCFG->EXTICR[0] |= SYSCFG_EXTICR1_EXTI0_PA;
    /* setup exti0 to failing edge */
    EXTI->FTSR |= EXTI_FTSR_TR0;
    /* enable exti0 interrupt */
    EXTI->IMR |= EXTI_IMR_MR0;
    /* tim4 setup presc */
    TIM4->PSC = 16000 - 1;
    /* tim4 setup preload reg */
    TIM4->ARR = 1000;
    /* tim4 load values to ccr1..4 */
    TIM4->CCR1 = 500;
    TIM4->CCR2 = 500;
    TIM4->CCR3 = 500;
    TIM4->CCR4 = 500;
    /* tim4 setup cc chanel1..4 */
    TIM4->CCMR1 |= TIM_CCMR1_OC1M_1 | TIM_CCMR1_OC1M_2 | TIM_CCMR1_OC2M_1 | TIM_CCMR1_OC2M_2;
    TIM4->CCMR2 |= TIM_CCMR2_OC3M_1 | TIM_CCMR2_OC3M_2 | TIM_CCMR2_OC4M_1 | TIM_CCMR2_OC4M_2;
    /* tim4 setup cc chanel1..4 to corresponding output pin */
    TIM4->CCER |= TIM_CCER_CC1E | TIM_CCER_CC2E | TIM_CCER_CC3E | TIM_CCER_CC4E;
    /* tim4 enable clock */
    TIM4->CR1 |= TIM_CR1_CEN;
    /* nvic enable exti0 irq */
    NVIC_EnableIRQ(EXTI0_IRQn);
    /* infinity loop */
    while (1) {
        /* enable exti0 interrupt */
        EXTI->IMR |= EXTI_IMR_MR0;
    }
}