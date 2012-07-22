/*-----------------------------------------------------------------------------
* Author: Boris Vinogradov(nis) : no111u3@gmail.com
* File: delay.c
* Type: C code file
* Project: f4examples/01-gpio/03-blink-led
* 2012
*-----------------------------------------------------------------------------*/
/* constans */
#define DELAY_TICS 16000000 / 1000 / 4
/* delay_ms */
void delay_ms(unsigned int timeout) {
    volatile static unsigned int counter;
    /* calculate delay */
    counter = DELAY_TICS * timeout;
    /* delay loop */
    while (counter--);
}