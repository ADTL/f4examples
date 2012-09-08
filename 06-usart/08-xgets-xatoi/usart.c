/*-----------------------------------------------------------------------------
* Author: Boris Vinogradov(nis) : no111u3@gmail.com
* File: usart.c
* Type: C code file
* Project: f4examples/06-usart/01-send-byte
* 2012
*-----------------------------------------------------------------------------*/
/* include headers */
#include "stm32f4xx.h"
/*USARTx send byte */
void usart_sendb(USART_TypeDef * USART, char byte) {
    while ((USART->SR & USART_SR_TXE) == 0);
    USART->DR = byte;
}
/*USARTx receive byte */
char usart_receiveb(USART_TypeDef * USART) {
    while ((USART->SR & USART_SR_RXNE) == 0);
    return USART->DR;
}
/*USART1 send byte */
void ser1_sendb(unsigned char byte) {
    usart_sendb(USART1, byte);
}
/*USART1 receive byte */
char ser1_receiveb(void) {
    return usart_receiveb(USART1);
}
