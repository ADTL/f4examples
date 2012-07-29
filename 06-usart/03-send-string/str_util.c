/*-----------------------------------------------------------------------------
* Author: Boris Vinogradov(nis) : no111u3@gmail.com
* File: str_util.c
* Type: C code file
* Project: f4examples/01-gpio/00-base
* 2012
*-----------------------------------------------------------------------------*/
/* include headers */
#include "stm32f4xx.h"
/* extern functions */
extern usart_sendb(USART_TypeDef * USART, char byte);
/* USARTx send string */
void usart_sends(USART_TypeDef * USART, const char * buffer) {
    while (*buffer) usart_sendb(USART, *buffer++);
}