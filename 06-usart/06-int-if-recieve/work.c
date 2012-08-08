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
/* interactive menu */
void inter_menu(char command) {
    usart_sendb(USART1, command);
    switch (command) {
        case 'a':
            /* enable leds */
            LED_PORT->ODR |= ALL_LEDS;
            break;
        case 'r':
            /* switch state to red led */
            LED_PORT->ODR  ^= RED_LED;
            break;
        case 'g':
            /* switch state to green led */
            LED_PORT->ODR  ^= GREEN_LED;
            break;
        case 'b':
            /* switch state to blue led */
            LED_PORT->ODR  ^= BLUE_LED;
            break;
        case 'o':
            /* switch state to orange led */
            LED_PORT->ODR  ^= ORANGE_LED;
            break;
        case 'n':
            /* disable leds */
            LED_PORT->ODR  &= ~ALL_LEDS;
            break;
        default :
            /* undefined command */
            command = 'u';
            break;
    }
    usart_sendb(USART1, '>');
    usart_sendb(USART1, command);
    usart_sendb(USART1, '\r');
    usart_sendb(USART1, '\n');
}
void get_char(void) {
    inter_menu(usart_receiveb(USART1));
    /* put intro char */
    usart_sendb(USART1, '#');
}
/* work */
void work(void) {
    /* enable usart & led ports*/
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN | RCC_AHB1ENR_GPIODEN;
    /* enable usart1 */
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN;
    /* setup led pins to output mode */
    LED_PORT->MODER |=
        GPIO_MODER_MODER12_0 | GPIO_MODER_MODER13_0 |
        GPIO_MODER_MODER14_0 | GPIO_MODER_MODER15_0;
    /* setup usart1 pins to af mode */
    GPIOB->MODER |= GPIO_MODER_MODER6_1 | GPIO_MODER_MODER7_1;
    /* select af block usart1..3(af7 function) to usart pins */
    GPIOB->AFR[0] |= (GPIO_AF7_USART1_3 << GPIO_AFP6) | (GPIO_AF7_USART1_3 << GPIO_AFP7);
    /* usart1 setup baudrate */ /** 115200 baud 16MHz/16/115200 = 8.68 */
    USART1->BRR = (8 << 4) + 5;
    /* usart1 enable block and enable tx,rx lines */
    USART1->CR1 |= USART_CR1_TE;
    USART1->CR1 |= USART_CR1_RE;
    USART1->CR1 |= USART_CR1_UE;
    /* usart1 enable interupt if receive register not empty */
    USART1->CR1 |= USART_CR1_RXNEIE;
    /* enable interrupt */
    NVIC_EnableIRQ(USART1_IRQn);
    /* put intro char */
    usart_sendb(USART1, '#');
    /* infinity loop */
    while (1);
}