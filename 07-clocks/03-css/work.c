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
    /* enable led port */
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
    /* enable tim4 */
    RCC->APB1ENR |= RCC_APB1ENR_TIM4EN;
    /* set led pins to af state */
    LED_PORT->MODER |=
        GPIO_MODER_MODER12_1 | GPIO_MODER_MODER13_1 |
        GPIO_MODER_MODER14_1 | GPIO_MODER_MODER15_1;
    /* select af block - tim3..5(af2 function) to led pins */
    LED_PORT->AFR[1] |= (GPIO_AF2_TIM3_5 << GPIO_AFP12) | (GPIO_AF2_TIM3_5 << GPIO_AFP13) |
        (GPIO_AF2_TIM3_5 << GPIO_AFP14) | (GPIO_AF2_TIM3_5 << GPIO_AFP15);
    /* tim4 setup presc */
    TIM4->PSC = 16000 - 1;
    /* tim4 setup preload reg */
    TIM4->ARR = 1000;
    /* tim4 load values to ccr1..4 */
    TIM4->CCR1 = 500;
    TIM4->CCR2 = 0;
    TIM4->CCR3 = 0;
    TIM4->CCR4 = 1000;
    /* tim4 setup cc chanel1..4 */
    TIM4->CCMR1 |= TIM_CCMR1_OC1M_1 | TIM_CCMR1_OC1M_2 | TIM_CCMR1_OC2M_1 | TIM_CCMR1_OC2M_2;
    TIM4->CCMR2 |= TIM_CCMR2_OC3M_1 | TIM_CCMR2_OC3M_2 | TIM_CCMR2_OC4M_1 | TIM_CCMR2_OC4M_2;
    /* tim4 setup cc chanel1..4 to corresponding output pin */
    TIM4->CCER |= TIM_CCER_CC1E | TIM_CCER_CC2E | TIM_CCER_CC3E | TIM_CCER_CC4E;
    /* enable CSS */
    RCC->CR |= RCC_CR_CSSON;
    /* enable HSE and wait to ready */
    RCC->CR |= RCC_CR_HSEON;
    while ((RCC->CR & RCC_CR_HSERDY) == 0);
    /* switch to HSE */
    RCC->CFGR &= ~RCC_CFGR_SW;
    RCC->CFGR |= RCC_CFGR_SW_HSE;
    while ((RCC->CFGR & RCC_CFGR_SWS_HSE) == 0);
    /* pll configuration */
    RCC->PLLCFGR &= ~(RCC_PLLCFGR_PLLM | RCC_PLLCFGR_PLLN);
    RCC->PLLCFGR |= (64 << 6) | 32;
    /* switch plls clock to hse */
    RCC->PLLCFGR |= RCC_PLLCFGR_PLLSRC_HSE;
    /* pll enable */
    RCC->CR |= RCC_CR_PLLON;
    /* enable flash wait to 2 ws */
    FLASH->ACR |= FLASH_ACR_LATENCY_2WS;
    /* wait to ready pll and switch to it */
    while ((RCC->CR && RCC_CR_PLLRDY) == 0);
    RCC->CFGR &= ~RCC_CFGR_SW;
    RCC->CFGR |= RCC_CFGR_SW_PLL;
    while ((RCC->CFGR & RCC_CFGR_SWS_PLL) == 0);
    /* tim4 enable update interrupt */
    TIM4->DIER |= TIM_DIER_UIE;
    /* tim4 enable clock */
    TIM4->CR1 |= TIM_CR1_CEN;
    /* tim4 enable irq */
    NVIC_EnableIRQ(TIM4_IRQn);
    /* infinity loop */
    while (1);
}