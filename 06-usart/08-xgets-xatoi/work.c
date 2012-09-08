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
#include "xprintf.h"
void ser1_sendb(unsigned char byte);
char ser1_receiveb(void);
/* work */
void work() {
    char buffer[80];
    long var;
    
    xdev_out(ser1_sendb);
    xdev_in(ser1_receiveb);
    /* enable usart port*/
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOBEN;
    /* enable usart1 */
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN;
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
    /* infinity loop */
    while (1) {
        /* put intro char */
        xputs("# ");
        if (xgets(buffer, sizeof buffer)) {
            xprintf("# %s\n>", buffer);
            char * pBuffer;
            pBuffer = buffer;
            while (xatoi(&pBuffer, &var)) {
                xprintf(" %d", var);
            }
            xputs("\n");
        }
    }
}