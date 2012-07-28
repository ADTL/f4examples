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
    /* enable led & usart port*/
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN | RCC_AHB1ENR_GPIOBEN;
    /* enable tim4 */
    RCC->APB1ENR |= RCC_APB1ENR_TIM4EN;
    /* enable usart1 */
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN;
    /* set red led pin to output state */
    LED_PORT->MODER |= GPIO_MODER_MODER14_0;
    /* setup usart1 pins to af mode */
    GPIOB->MODER |= GPIO_MODER_MODER6_1;
    /* select af block usart1..3(af7 function) to usart pins */
    GPIOB->AFR[0] |= (GPIO_AF7_USART1_3 << GPIO_AFP6);
    /* usart1 setup baudrate */ /** 115200 baud 16MHz/16/115200 = 8.68 */
    USART1->BRR = (8 << 4) + 5;
    /* usart1 enable block and enable tx line */
    USART1->CR1 |= USART_CR1_TE;
    USART1->CR1 |= USART_CR1_UE;
    /* tim4 setup presc */
    TIM4->PSC = 16000 - 1;
    /* tim4 setup preload reg */
    TIM4->ARR = 500;
    /* tim4 enable update interrupt */
    TIM4->DIER |= TIM_DIER_UIE;
    /* tim4 enable clock */
    TIM4->CR1 |= TIM_CR1_CEN;
    /* nvic enable tim4 irq */
    NVIC_EnableIRQ(TIM4_IRQn);
    /* infinity loop */
    while (1);
}