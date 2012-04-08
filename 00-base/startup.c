/*-----------------------------------------------------------------------------
* Author: Boris Vinogradov(nis) : no111u3@gmail.com
* File: startup.c
* Type: C code file
* Project: f4examples/00-base
* 2012
*-----------------------------------------------------------------------------*/
/* include headers */
#include "stm32f4xx.h"
/* external vars */
extern unsigned long _estack;
/* prototypes of functions */
void reset_hander(void);
/* reset handler */
void reset_handler(void) {
}
/* table of Cortex vectors */
void *vector_table[] __attribute__ ((section(".vectors"))) = {
    &_estack,
    reset_handler,
};