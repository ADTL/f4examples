/*-----------------------------------------------------------------------------
* Author: Boris Vinogradov(nis) : no111u3@gmail.com
* File: work.h
* Type: C header file
* Project: f4examples/01-gpio/00-base
* 2012
*-----------------------------------------------------------------------------*/
/* defines */
/** define led port */
#define LED_PORT GPIOD
/** define led pins */
#define GREEN_LED (1 << 12)
#define ORANGE_LED (1 << 13)
#define RED_LED	(1 << 14)
#define BLUE_LED (1 << 15)
#define ALL_LEDS (GREEN_LED | ORANGE_LED | RED_LED | BLUE_LED)
/** define button port */
#define BUT_PORT GPIOA
/** define button pins */
#define BUT1 1
