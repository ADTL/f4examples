/*-----------------------------------------------------------------------------
* Author: Boris Vinogradov(nis) : no111u3@gmail.com
* File: startup.c
* Type: C code file
* Project: f4examples/01-gpio/00-base
* 2012
*-----------------------------------------------------------------------------*/
/* include headers */
#include "stm32f4xx.h"
/* external vars */
extern unsigned long _estack;
extern void work();
/* prototypes of functions */
void reset_hander(void);
/* reset handler */
void reset_handler(void) {
    /* call working code */
    work();
}
/* nmi handler */
void nmi_handler(void) {
    if (RCC->CIR & RCC_CIR_CSSF) {
        /* fail led blink enabled and disable hse led*/
        TIM4->CCR3 = 100;
        TIM4->CCR4 = 0;
        /* reset CSSC flag */
        RCC->CIR |= RCC_CIR_CSSC;
    }
}
/* hardware fault handler */
void hard_fault_handler(void) {
    while (1);
}
/* memory management handler */
void mem_manage_handler(void) {
    while (1);
}
/* bus fault handler */
void bus_fault_handler(void) {
    while (1);
}
/* usage fault handler */
void usage_fault_handler(void) {
    while (1);
}
/* timer4 irq handler */
void tim4_irq_hanlder(void) {
    if (TIM4->SR & TIM_SR_UIF) {
        static int counter;
        char divide;
        static char direct;
        /* if enable HSI CSS enabled, return */
        if ((RCC->CFGR & RCC_CFGR_SWS) == RCC_CFGR_SWS_HSI)
            return;
        counter++;
        if (counter > 3) {
            counter = 0;
            /* switch to HSI and wait for stable*/
            RCC->CFGR &= ~RCC_CFGR_SW;
            while ((RCC->CFGR & RCC_CFGR_SWS) != RCC_CFGR_SWS_HSI);
            /* disable PLL and wait for off */
            RCC->CR &= ~RCC_CR_PLLON;
            while ((RCC->CR & RCC_CR_PLLRDY) == 1);
            /* setup PLL, enable and wait to ready */
            divide = RCC->PLLCFGR & RCC_PLLCFGR_PLLM;
            RCC->PLLCFGR &= ~RCC_PLLCFGR_PLLM;
            /* calculate new divide value */
            if (direct)
                if (divide > 8)
                    divide -= 4;
                else
                    direct = 0;
            else
                if (divide < 32)
                    divide += 4;
                else
                    direct = 1;
            RCC->PLLCFGR |= divide;
            RCC->CR |= RCC_CR_PLLON;
            while ((RCC->CR & RCC_CR_PLLRDY) == 0);
            /* select PLL for system clock and wait to select */
            RCC->CFGR &= ~RCC_CFGR_SW;
            RCC->CFGR |= RCC_CFGR_SW_PLL;
            while ((RCC->CFGR & RCC_CFGR_SWS_PLL) == 0);
        }
        /* clear status bit */
        TIM4->SR &= ~TIM_SR_UIF;
    }
}
/* table of Cortex vectors */
void *vector_table[] __attribute__ ((section(".vectors"))) = {
    &_estack,           /*! stack begin */
    /* Core interrupts */
    reset_handler,      /*!#0 cortex-m4 reset interrupt begin code of this */
    nmi_handler,        /*!#1 cortex-m4 non maskable interrupt */
    hard_fault_handler, /*!#2 cortex-m4 hardware fault interrupt */
    mem_manage_handler, /*!#3 cortex-m4 memory management interrupt */
    bus_fault_handler,  /*!#4 cortex-m4 bus fault interrupt */
    usage_fault_handler,/*!#5 cortex-m4 usage fault interrupt */
    0,                  /*!#6 reserved */
    0,                  /*!#7 reserved */
    0,                  /*!#8 reserved */
    0,                  /*!#9 reserved */
    0,                  /*!#10 cortex-m4 system service interrupt */
    0,                  /*!#11 cortex-m4 debug monitor interrupt */
    0,                  /*!#12 reserved */
    0,                  /*!#13 cortex-m4 penable request for system service interrupt */
    0,                  /*!#14 cortex-m4 system tick timer interrupt */
    /* External Interrupts */
    0,                  /*!%0 Window WatchDog              */                                        
    0,                  /*!%1 PVD through EXTI Line detection */                        
    0,                  /*!%2 Tamper and TimeStamps through the EXTI line */            
    0,                  /*!%3 RTC Wakeup through the EXTI line */                      
    0,                  /*!%4 FLASH                        */                                          
    0,                  /*!%5 RCC                          */                                            
    0,                  /*!%6 EXTI Line0                   */                        
    0,                  /*!%7 EXTI Line1                   */                          
    0,                  /*!%8 EXTI Line2                   */                          
    0,                  /*!%9 EXTI Line3                   */                          
    0,                  /*!%10 EXTI Line4                   */                          
    0,                  /*!%11 DMA1 Stream 0                */                  
    0,                  /*!%12 DMA1 Stream 1                */                   
    0,                  /*!%13 DMA1 Stream 2                */                   
    0,                  /*!%14 DMA1 Stream 3                */                   
    0,                  /*!%15 DMA1 Stream 4                */                   
    0,                  /*!%16 DMA1 Stream 5                */                   
    0,                  /*!%17 DMA1 Stream 6                */                   
    0,                  /*!%18 ADC1, ADC2 and ADC3s         */                   
    0,                  /*!%19 CAN1 TX                      */                         
    0,                  /*!%20 CAN1 RX0                     */                          
    0,                  /*!%21 CAN1 RX1                     */                          
    0,                  /*!%22 CAN1 SCE                     */                          
    0,                  /*!%23 External Line[9:5]s          */                          
    0,                  /*!%24 TIM1 Break and TIM9          */         
    0,                  /*!%25 TIM1 Update and TIM10        */         
    0,                  /*!%26 TIM1 Trigger and Commutation and TIM11 */
    0,                  /*!%27 TIM1 Capture Compare         */                          
    0,                  /*!%28 TIM2                         */                   
    0,                  /*!%29 TIM3                         */                   
    tim4_irq_hanlder,   /*!%30 TIM4                         */                   
    0,                  /*!%31 I2C1 Event                   */                          
    0,                  /*!%32 I2C1 Error                   */                          
    0,                  /*!%33 I2C2 Event                   */                          
    0,                  /*!%34 I2C2 Error                   */                            
    0,                  /*!%35 SPI1                         */                   
    0,                  /*!%36 SPI2                         */                   
    0,                  /*!%37 USART1                       */                   
    0,                  /*!%38 USART2                       */                   
    0,                  /*!%39 USART3                       */                   
    0,                  /*!%40 External Line[15:10]s        */                          
    0,                  /*!%41 RTC Alarm (A and B) through EXTI Line */                 
    0,                  /*!%42 USB OTG FS Wakeup through EXTI line */                       
    0,                  /*!%43 TIM8 Break and TIM12         */         
    0,                  /*!%44 TIM8 Update and TIM13        */         
    0,                  /*!%45 TIM8 Trigger and Commutation and TIM14 */
    0,                  /*!%46 TIM8 Capture Compare         */                          
    0,                  /*!%47 DMA1 Stream7                 */                          
    0,                  /*!%48 FSMC                         */                   
    0,                  /*!%49 SDIO                         */                   
    0,                  /*!%50 TIM5                         */                   
    0,                  /*!%51 SPI3                         */                   
    0,                  /*!%52 UART4                        */                   
    0,                  /*!%53 UART5                        */                   
    0,                  /*!%54 TIM6 and DAC1&2 underrun errors */                   
    0,                  /*!%55 TIM7                         */
    0,                  /*!%56 DMA2 Stream 0                */                   
    0,                  /*!%57 DMA2 Stream 1                */                   
    0,                  /*!%58 DMA2 Stream 2                */                   
    0,                  /*!%59 DMA2 Stream 3                */                   
    0,                  /*!%60 DMA2 Stream 4                */                   
    0,                  /*!%61 Ethernet                     */                   
    0,                  /*!%62 Ethernet Wakeup through EXTI line */                     
    0,                  /*!%63 CAN2 TX                      */                          
    0,                  /*!%64 CAN2 RX0                     */                          
    0,                  /*!%65 CAN2 RX1                     */                          
    0,                  /*!%66 CAN2 SCE                     */                          
    0,                  /*!%67 USB OTG FS                   */                   
    0,                  /*!%68 DMA2 Stream 5                */                   
    0,                  /*!%69 DMA2 Stream 6                */                   
    0,                  /*!%70 DMA2 Stream 7                */                   
    0,                  /*!%71 USART6                       */                    
    0,                  /*!%72 I2C3 event                   */                          
    0,                  /*!%73 I2C3 error                   */                          
    0,                  /*!%74 USB OTG HS End Point 1 Out   */                   
    0,                  /*!%75 USB OTG HS End Point 1 In    */                   
    0,                  /*!%76 USB OTG HS Wakeup through EXTI */                         
    0,                  /*!%77 USB OTG HS                   */                   
    0,                  /*!%78 DCMI                         */                   
    0,                  /*!%79 CRYP crypto                  */                   
    0,                  /*!%80 Hash and Rng                 */
    0,                  /*!%81 FPU                          */
};
