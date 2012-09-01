
firmware.elf:     формат файла elf32-littlearm


Дизассемблирование раздела .text:

08000000 <vector_table>:
 8000000:	2001bffc 	strdcs	fp, [r1], -ip
 8000004:	08000641 	stmdaeq	r0, {r0, r6, r9, sl}
 8000008:	0800062d 	stmdaeq	r0, {r0, r2, r3, r5, r9, sl}
 800000c:	08000631 	stmdaeq	r0, {r0, r4, r5, r9, sl}
 8000010:	08000635 	stmdaeq	r0, {r0, r2, r4, r5, r9, sl}
 8000014:	08000639 	stmdaeq	r0, {r0, r3, r4, r5, r9, sl}
 8000018:	0800063d 	stmdaeq	r0, {r0, r2, r3, r4, r5, r9, sl}
	...
 80000b8:	08000645 	stmdaeq	r0, {r0, r2, r6, r9, sl}
	...

08000188 <xputc>:
 8000188:	280a      	cmp	r0, #10
 800018a:	b510      	push	{r4, lr}
 800018c:	4604      	mov	r4, r0
 800018e:	d005      	beq.n	800019c <xputc+0x14>
 8000190:	4b04      	ldr	r3, [pc, #16]	; (80001a4 <xputc+0x1c>)
 8000192:	681b      	ldr	r3, [r3, #0]
 8000194:	b10b      	cbz	r3, 800019a <xputc+0x12>
 8000196:	4620      	mov	r0, r4
 8000198:	4798      	blx	r3
 800019a:	bd10      	pop	{r4, pc}
 800019c:	200d      	movs	r0, #13
 800019e:	f7ff fff3 	bl	8000188 <xputc>
 80001a2:	e7f5      	b.n	8000190 <xputc+0x8>
 80001a4:	20000008 	andcs	r0, r0, r8

080001a8 <xputs>:
 80001a8:	b510      	push	{r4, lr}
 80001aa:	4604      	mov	r4, r0
 80001ac:	7800      	ldrb	r0, [r0, #0]
 80001ae:	b128      	cbz	r0, 80001bc <xputs+0x14>
 80001b0:	f7ff ffea 	bl	8000188 <xputc>
 80001b4:	f814 0f01 	ldrb.w	r0, [r4, #1]!
 80001b8:	2800      	cmp	r0, #0
 80001ba:	d1f9      	bne.n	80001b0 <xputs+0x8>
 80001bc:	bd10      	pop	{r4, pc}
 80001be:	bf00      	nop

080001c0 <xvprintf>:
 80001c0:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
 80001c4:	4604      	mov	r4, r0
 80001c6:	b085      	sub	sp, #20
 80001c8:	468a      	mov	sl, r1
 80001ca:	f04f 0b2d 	mov.w	fp, #45	; 0x2d
 80001ce:	7820      	ldrb	r0, [r4, #0]
 80001d0:	b138      	cbz	r0, 80001e2 <xvprintf+0x22>
 80001d2:	2825      	cmp	r0, #37	; 0x25
 80001d4:	d008      	beq.n	80001e8 <xvprintf+0x28>
 80001d6:	3401      	adds	r4, #1
 80001d8:	f7ff ffd6 	bl	8000188 <xputc>
 80001dc:	7820      	ldrb	r0, [r4, #0]
 80001de:	2800      	cmp	r0, #0
 80001e0:	d1f7      	bne.n	80001d2 <xvprintf+0x12>
 80001e2:	b005      	add	sp, #20
 80001e4:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
 80001e8:	7860      	ldrb	r0, [r4, #1]
 80001ea:	2830      	cmp	r0, #48	; 0x30
 80001ec:	f000 8105 	beq.w	80003fa <xvprintf+0x23a>
 80001f0:	282d      	cmp	r0, #45	; 0x2d
 80001f2:	f000 8106 	beq.w	8000402 <xvprintf+0x242>
 80001f6:	3402      	adds	r4, #2
 80001f8:	2300      	movs	r3, #0
 80001fa:	f1a0 0230 	sub.w	r2, r0, #48	; 0x30
 80001fe:	b2d2      	uxtb	r2, r2
 8000200:	2600      	movs	r6, #0
 8000202:	2a09      	cmp	r2, #9
 8000204:	d80e      	bhi.n	8000224 <xvprintf+0x64>
 8000206:	4622      	mov	r2, r4
 8000208:	2600      	movs	r6, #0
 800020a:	eb06 0686 	add.w	r6, r6, r6, lsl #2
 800020e:	eb00 0646 	add.w	r6, r0, r6, lsl #1
 8000212:	f812 0b01 	ldrb.w	r0, [r2], #1
 8000216:	3e30      	subs	r6, #48	; 0x30
 8000218:	f1a0 0130 	sub.w	r1, r0, #48	; 0x30
 800021c:	b2c9      	uxtb	r1, r1
 800021e:	2909      	cmp	r1, #9
 8000220:	4614      	mov	r4, r2
 8000222:	d9f2      	bls.n	800020a <xvprintf+0x4a>
 8000224:	f1a0 0c6c 	sub.w	ip, r0, #108	; 0x6c
 8000228:	f1dc 0200 	rsbs	r2, ip, #0
 800022c:	eb42 020c 	adc.w	r2, r2, ip
 8000230:	284c      	cmp	r0, #76	; 0x4c
 8000232:	bf08      	it	eq
 8000234:	f042 0201 	orreq.w	r2, r2, #1
 8000238:	b11a      	cbz	r2, 8000242 <xvprintf+0x82>
 800023a:	f814 0b01 	ldrb.w	r0, [r4], #1
 800023e:	f043 0304 	orr.w	r3, r3, #4
 8000242:	2800      	cmp	r0, #0
 8000244:	d0cd      	beq.n	80001e2 <xvprintf+0x22>
 8000246:	2860      	cmp	r0, #96	; 0x60
 8000248:	bf86      	itte	hi
 800024a:	f1a0 0120 	subhi.w	r1, r0, #32
 800024e:	b2c9      	uxtbhi	r1, r1
 8000250:	4601      	movls	r1, r0
 8000252:	f1a1 0242 	sub.w	r2, r1, #66	; 0x42
 8000256:	2a16      	cmp	r2, #22
 8000258:	f200 80c2 	bhi.w	80003e0 <xvprintf+0x220>
 800025c:	e8df f012 	tbh	[pc, r2, lsl #1]
 8000260:	00c600bd 	strheq	r0, [r6], #13
 8000264:	00c000c3 	sbceq	r0, r0, r3, asr #1
 8000268:	00c000c0 	sbceq	r0, r0, r0, asr #1
 800026c:	00c000c0 	sbceq	r0, r0, r0, asr #1
 8000270:	00c000c0 	sbceq	r0, r0, r0, asr #1
 8000274:	00c000c0 	sbceq	r0, r0, r0, asr #1
 8000278:	00a700c0 	adceq	r0, r7, r0, asr #1
 800027c:	00c000c0 	sbceq	r0, r0, r0, asr #1
 8000280:	007900c0 	rsbseq	r0, r9, r0, asr #1
 8000284:	00c300c0 	sbceq	r0, r3, r0, asr #1
 8000288:	00c000c0 	sbceq	r0, r0, r0, asr #1
 800028c:	f04f0017 			; <UNDEFINED> instruction: 0xf04f0017
 8000290:	0c10      	lsrs	r0, r2, #16
 8000292:	075a      	lsls	r2, r3, #29
 8000294:	f8da 7000 	ldr.w	r7, [sl]
 8000298:	f10a 0a04 	add.w	sl, sl, #4
 800029c:	f100 8090 	bmi.w	80003c0 <xvprintf+0x200>
 80002a0:	2944      	cmp	r1, #68	; 0x44
 80002a2:	f000 808d 	beq.w	80003c0 <xvprintf+0x200>
 80002a6:	f04f 0e00 	mov.w	lr, #0
 80002aa:	e000      	b.n	80002ae <xvprintf+0xee>
 80002ac:	46ae      	mov	lr, r5
 80002ae:	fbb7 f1fc 	udiv	r1, r7, ip
 80002b2:	fb0c 7211 	mls	r2, ip, r1, r7
 80002b6:	b2d2      	uxtb	r2, r2
 80002b8:	2a09      	cmp	r2, #9
 80002ba:	460f      	mov	r7, r1
 80002bc:	d905      	bls.n	80002ca <xvprintf+0x10a>
 80002be:	2878      	cmp	r0, #120	; 0x78
 80002c0:	bf14      	ite	ne
 80002c2:	2507      	movne	r5, #7
 80002c4:	2527      	moveq	r5, #39	; 0x27
 80002c6:	18aa      	adds	r2, r5, r2
 80002c8:	b2d2      	uxtb	r2, r2
 80002ca:	3100      	adds	r1, #0
 80002cc:	bf18      	it	ne
 80002ce:	2101      	movne	r1, #1
 80002d0:	f10e 0501 	add.w	r5, lr, #1
 80002d4:	3230      	adds	r2, #48	; 0x30
 80002d6:	2d0f      	cmp	r5, #15
 80002d8:	bf8c      	ite	hi
 80002da:	2100      	movhi	r1, #0
 80002dc:	f001 0101 	andls.w	r1, r1, #1
 80002e0:	f80d 200e 	strb.w	r2, [sp, lr]
 80002e4:	2900      	cmp	r1, #0
 80002e6:	d1e1      	bne.n	80002ac <xvprintf+0xec>
 80002e8:	071a      	lsls	r2, r3, #28
 80002ea:	bf41      	itttt	mi
 80002ec:	aa04      	addmi	r2, sp, #16
 80002ee:	1955      	addmi	r5, r2, r5
 80002f0:	f805 bc10 	strbmi.w	fp, [r5, #-16]
 80002f4:	f10e 0502 	addmi.w	r5, lr, #2
 80002f8:	f013 0f01 	tst.w	r3, #1
 80002fc:	bf0c      	ite	eq
 80002fe:	f04f 0920 	moveq.w	r9, #32
 8000302:	f04f 0930 	movne.w	r9, #48	; 0x30
 8000306:	079b      	lsls	r3, r3, #30
 8000308:	bf48      	it	mi
 800030a:	462f      	movmi	r7, r5
 800030c:	d410      	bmi.n	8000330 <xvprintf+0x170>
 800030e:	1c6f      	adds	r7, r5, #1
 8000310:	42b5      	cmp	r5, r6
 8000312:	d20d      	bcs.n	8000330 <xvprintf+0x170>
 8000314:	4648      	mov	r0, r9
 8000316:	f7ff ff37 	bl	8000188 <xputc>
 800031a:	46a8      	mov	r8, r5
 800031c:	e002      	b.n	8000324 <xvprintf+0x164>
 800031e:	4648      	mov	r0, r9
 8000320:	f7ff ff32 	bl	8000188 <xputc>
 8000324:	f108 0801 	add.w	r8, r8, #1
 8000328:	45b0      	cmp	r8, r6
 800032a:	d3f8      	bcc.n	800031e <xvprintf+0x15e>
 800032c:	1b73      	subs	r3, r6, r5
 800032e:	18ff      	adds	r7, r7, r3
 8000330:	3d01      	subs	r5, #1
 8000332:	f81d 0005 	ldrb.w	r0, [sp, r5]
 8000336:	f7ff ff27 	bl	8000188 <xputc>
 800033a:	2d00      	cmp	r5, #0
 800033c:	d1f8      	bne.n	8000330 <xvprintf+0x170>
 800033e:	42b7      	cmp	r7, r6
 8000340:	f4bf af45 	bcs.w	80001ce <xvprintf+0xe>
 8000344:	2020      	movs	r0, #32
 8000346:	3701      	adds	r7, #1
 8000348:	f7ff ff1e 	bl	8000188 <xputc>
 800034c:	42be      	cmp	r6, r7
 800034e:	d8f9      	bhi.n	8000344 <xvprintf+0x184>
 8000350:	e73d      	b.n	80001ce <xvprintf+0xe>
 8000352:	f8da 8000 	ldr.w	r8, [sl]
 8000356:	2501      	movs	r5, #1
 8000358:	f898 7000 	ldrb.w	r7, [r8]
 800035c:	f10a 0a04 	add.w	sl, sl, #4
 8000360:	b13f      	cbz	r7, 8000372 <xvprintf+0x1b2>
 8000362:	4642      	mov	r2, r8
 8000364:	2700      	movs	r7, #0
 8000366:	f812 1f01 	ldrb.w	r1, [r2, #1]!
 800036a:	3701      	adds	r7, #1
 800036c:	2900      	cmp	r1, #0
 800036e:	d1fa      	bne.n	8000366 <xvprintf+0x1a6>
 8000370:	1c7d      	adds	r5, r7, #1
 8000372:	0799      	lsls	r1, r3, #30
 8000374:	d40d      	bmi.n	8000392 <xvprintf+0x1d2>
 8000376:	42b7      	cmp	r7, r6
 8000378:	d247      	bcs.n	800040a <xvprintf+0x24a>
 800037a:	2020      	movs	r0, #32
 800037c:	f7ff ff04 	bl	8000188 <xputc>
 8000380:	e003      	b.n	800038a <xvprintf+0x1ca>
 8000382:	2020      	movs	r0, #32
 8000384:	f7ff ff00 	bl	8000188 <xputc>
 8000388:	463d      	mov	r5, r7
 800038a:	1c6f      	adds	r7, r5, #1
 800038c:	42b5      	cmp	r5, r6
 800038e:	d3f8      	bcc.n	8000382 <xvprintf+0x1c2>
 8000390:	1c7d      	adds	r5, r7, #1
 8000392:	4640      	mov	r0, r8
 8000394:	f7ff ff08 	bl	80001a8 <xputs>
 8000398:	42b7      	cmp	r7, r6
 800039a:	d301      	bcc.n	80003a0 <xvprintf+0x1e0>
 800039c:	e717      	b.n	80001ce <xvprintf+0xe>
 800039e:	461d      	mov	r5, r3
 80003a0:	2020      	movs	r0, #32
 80003a2:	f7ff fef1 	bl	8000188 <xputc>
 80003a6:	1c6b      	adds	r3, r5, #1
 80003a8:	42ae      	cmp	r6, r5
 80003aa:	d8f8      	bhi.n	800039e <xvprintf+0x1de>
 80003ac:	e70f      	b.n	80001ce <xvprintf+0xe>
 80003ae:	075a      	lsls	r2, r3, #29
 80003b0:	f8da 7000 	ldr.w	r7, [sl]
 80003b4:	f04f 0c08 	mov.w	ip, #8
 80003b8:	f10a 0a04 	add.w	sl, sl, #4
 80003bc:	f57f af70 	bpl.w	80002a0 <xvprintf+0xe0>
 80003c0:	f1a1 0544 	sub.w	r5, r1, #68	; 0x44
 80003c4:	4269      	negs	r1, r5
 80003c6:	eb41 0105 	adc.w	r1, r1, r5
 80003ca:	ea11 71d7 	ands.w	r1, r1, r7, lsr #31
 80003ce:	f43f af6a 	beq.w	80002a6 <xvprintf+0xe6>
 80003d2:	427f      	negs	r7, r7
 80003d4:	f043 0308 	orr.w	r3, r3, #8
 80003d8:	e765      	b.n	80002a6 <xvprintf+0xe6>
 80003da:	f04f 0c02 	mov.w	ip, #2
 80003de:	e758      	b.n	8000292 <xvprintf+0xd2>
 80003e0:	f7ff fed2 	bl	8000188 <xputc>
 80003e4:	e6f3      	b.n	80001ce <xvprintf+0xe>
 80003e6:	f04f 0c0a 	mov.w	ip, #10
 80003ea:	e752      	b.n	8000292 <xvprintf+0xd2>
 80003ec:	f89a 0000 	ldrb.w	r0, [sl]
 80003f0:	f10a 0a04 	add.w	sl, sl, #4
 80003f4:	f7ff fec8 	bl	8000188 <xputc>
 80003f8:	e6e9      	b.n	80001ce <xvprintf+0xe>
 80003fa:	78a0      	ldrb	r0, [r4, #2]
 80003fc:	2301      	movs	r3, #1
 80003fe:	3403      	adds	r4, #3
 8000400:	e6fb      	b.n	80001fa <xvprintf+0x3a>
 8000402:	78a0      	ldrb	r0, [r4, #2]
 8000404:	2302      	movs	r3, #2
 8000406:	3403      	adds	r4, #3
 8000408:	e6f7      	b.n	80001fa <xvprintf+0x3a>
 800040a:	462f      	mov	r7, r5
 800040c:	3501      	adds	r5, #1
 800040e:	e7c0      	b.n	8000392 <xvprintf+0x1d2>

08000410 <xfputs>:
 8000410:	b570      	push	{r4, r5, r6, lr}
 8000412:	4c07      	ldr	r4, [pc, #28]	; (8000430 <xfputs+0x20>)
 8000414:	6826      	ldr	r6, [r4, #0]
 8000416:	6020      	str	r0, [r4, #0]
 8000418:	7808      	ldrb	r0, [r1, #0]
 800041a:	b130      	cbz	r0, 800042a <xfputs+0x1a>
 800041c:	460d      	mov	r5, r1
 800041e:	f7ff feb3 	bl	8000188 <xputc>
 8000422:	f815 0f01 	ldrb.w	r0, [r5, #1]!
 8000426:	2800      	cmp	r0, #0
 8000428:	d1f9      	bne.n	800041e <xfputs+0xe>
 800042a:	6026      	str	r6, [r4, #0]
 800042c:	bd70      	pop	{r4, r5, r6, pc}
 800042e:	bf00      	nop
 8000430:	20000008 	andcs	r0, r0, r8

08000434 <xprintf>:
 8000434:	b40f      	push	{r0, r1, r2, r3}
 8000436:	b500      	push	{lr}
 8000438:	b083      	sub	sp, #12
 800043a:	a904      	add	r1, sp, #16
 800043c:	f851 0b04 	ldr.w	r0, [r1], #4
 8000440:	9101      	str	r1, [sp, #4]
 8000442:	f7ff febd 	bl	80001c0 <xvprintf>
 8000446:	b003      	add	sp, #12
 8000448:	f85d eb04 	ldr.w	lr, [sp], #4
 800044c:	b004      	add	sp, #16
 800044e:	4770      	bx	lr

08000450 <xsprintf>:
 8000450:	b40e      	push	{r1, r2, r3}
 8000452:	b530      	push	{r4, r5, lr}
 8000454:	b082      	sub	sp, #8
 8000456:	ab05      	add	r3, sp, #20
 8000458:	f853 5b04 	ldr.w	r5, [r3], #4
 800045c:	f240 0400 	movw	r4, #0
 8000460:	4602      	mov	r2, r0
 8000462:	f2c2 0400 	movt	r4, #8192	; 0x2000
 8000466:	4619      	mov	r1, r3
 8000468:	4628      	mov	r0, r5
 800046a:	6022      	str	r2, [r4, #0]
 800046c:	9301      	str	r3, [sp, #4]
 800046e:	f7ff fea7 	bl	80001c0 <xvprintf>
 8000472:	6822      	ldr	r2, [r4, #0]
 8000474:	2300      	movs	r3, #0
 8000476:	7013      	strb	r3, [r2, #0]
 8000478:	6023      	str	r3, [r4, #0]
 800047a:	b002      	add	sp, #8
 800047c:	e8bd 4030 	ldmia.w	sp!, {r4, r5, lr}
 8000480:	b003      	add	sp, #12
 8000482:	4770      	bx	lr

08000484 <xfprintf>:
 8000484:	b40e      	push	{r1, r2, r3}
 8000486:	b570      	push	{r4, r5, r6, lr}
 8000488:	b083      	sub	sp, #12
 800048a:	ab07      	add	r3, sp, #28
 800048c:	f240 0408 	movw	r4, #8
 8000490:	f853 6b04 	ldr.w	r6, [r3], #4
 8000494:	f2c2 0400 	movt	r4, #8192	; 0x2000
 8000498:	6825      	ldr	r5, [r4, #0]
 800049a:	4602      	mov	r2, r0
 800049c:	4619      	mov	r1, r3
 800049e:	4630      	mov	r0, r6
 80004a0:	6022      	str	r2, [r4, #0]
 80004a2:	9301      	str	r3, [sp, #4]
 80004a4:	f7ff fe8c 	bl	80001c0 <xvprintf>
 80004a8:	6025      	str	r5, [r4, #0]
 80004aa:	b003      	add	sp, #12
 80004ac:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 80004b0:	b003      	add	sp, #12
 80004b2:	4770      	bx	lr

080004b4 <put_dump>:
 80004b4:	b570      	push	{r4, r5, r6, lr}
 80004b6:	461c      	mov	r4, r3
 80004b8:	4606      	mov	r6, r0
 80004ba:	4826      	ldr	r0, [pc, #152]	; (8000554 <put_dump+0xa0>)
 80004bc:	4615      	mov	r5, r2
 80004be:	f7ff ffb9 	bl	8000434 <xprintf>
 80004c2:	2c02      	cmp	r4, #2
 80004c4:	d008      	beq.n	80004d8 <put_dump+0x24>
 80004c6:	2c04      	cmp	r4, #4
 80004c8:	d015      	beq.n	80004f6 <put_dump+0x42>
 80004ca:	2c01      	cmp	r4, #1
 80004cc:	d022      	beq.n	8000514 <put_dump+0x60>
 80004ce:	200a      	movs	r0, #10
 80004d0:	e8bd 4070 	ldmia.w	sp!, {r4, r5, r6, lr}
 80004d4:	f7ff be58 	b.w	8000188 <xputc>
 80004d8:	f836 1b02 	ldrh.w	r1, [r6], #2
 80004dc:	481e      	ldr	r0, [pc, #120]	; (8000558 <put_dump+0xa4>)
 80004de:	f7ff ffa9 	bl	8000434 <xprintf>
 80004e2:	3d01      	subs	r5, #1
 80004e4:	d0f3      	beq.n	80004ce <put_dump+0x1a>
 80004e6:	f836 1b02 	ldrh.w	r1, [r6], #2
 80004ea:	481b      	ldr	r0, [pc, #108]	; (8000558 <put_dump+0xa4>)
 80004ec:	f7ff ffa2 	bl	8000434 <xprintf>
 80004f0:	3d01      	subs	r5, #1
 80004f2:	d1f1      	bne.n	80004d8 <put_dump+0x24>
 80004f4:	e7eb      	b.n	80004ce <put_dump+0x1a>
 80004f6:	f856 1b04 	ldr.w	r1, [r6], #4
 80004fa:	4818      	ldr	r0, [pc, #96]	; (800055c <put_dump+0xa8>)
 80004fc:	f7ff ff9a 	bl	8000434 <xprintf>
 8000500:	3d01      	subs	r5, #1
 8000502:	d0e4      	beq.n	80004ce <put_dump+0x1a>
 8000504:	f856 1b04 	ldr.w	r1, [r6], #4
 8000508:	4814      	ldr	r0, [pc, #80]	; (800055c <put_dump+0xa8>)
 800050a:	f7ff ff93 	bl	8000434 <xprintf>
 800050e:	3d01      	subs	r5, #1
 8000510:	d1f1      	bne.n	80004f6 <put_dump+0x42>
 8000512:	e7dc      	b.n	80004ce <put_dump+0x1a>
 8000514:	2d00      	cmp	r5, #0
 8000516:	dd18      	ble.n	800054a <put_dump+0x96>
 8000518:	2400      	movs	r4, #0
 800051a:	5d31      	ldrb	r1, [r6, r4]
 800051c:	4810      	ldr	r0, [pc, #64]	; (8000560 <put_dump+0xac>)
 800051e:	3401      	adds	r4, #1
 8000520:	f7ff ff88 	bl	8000434 <xprintf>
 8000524:	42ac      	cmp	r4, r5
 8000526:	d1f8      	bne.n	800051a <put_dump+0x66>
 8000528:	2020      	movs	r0, #32
 800052a:	f7ff fe2d 	bl	8000188 <xputc>
 800052e:	2400      	movs	r4, #0
 8000530:	5d30      	ldrb	r0, [r6, r4]
 8000532:	3401      	adds	r4, #1
 8000534:	f1a0 0320 	sub.w	r3, r0, #32
 8000538:	b2db      	uxtb	r3, r3
 800053a:	2b5e      	cmp	r3, #94	; 0x5e
 800053c:	bf88      	it	hi
 800053e:	202e      	movhi	r0, #46	; 0x2e
 8000540:	f7ff fe22 	bl	8000188 <xputc>
 8000544:	42ac      	cmp	r4, r5
 8000546:	d1f3      	bne.n	8000530 <put_dump+0x7c>
 8000548:	e7c1      	b.n	80004ce <put_dump+0x1a>
 800054a:	2020      	movs	r0, #32
 800054c:	f7ff fe1c 	bl	8000188 <xputc>
 8000550:	e7bd      	b.n	80004ce <put_dump+0x1a>
 8000552:	bf00      	nop
 8000554:	080006c0 	stmdaeq	r0, {r6, r7, r9, sl}
 8000558:	080006d0 	stmdaeq	r0, {r4, r6, r7, r9, sl}
 800055c:	080006d8 	stmdaeq	r0, {r3, r4, r6, r7, r9, sl}
 8000560:	080006c8 	stmdaeq	r0, {r3, r6, r7, r9, sl}

08000564 <work>:
 8000564:	f44f 5360 	mov.w	r3, #14336	; 0x3800
 8000568:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800056c:	6b19      	ldr	r1, [r3, #48]	; 0x30
 800056e:	f44f 6240 	mov.w	r2, #3072	; 0xc00
 8000572:	f041 010a 	orr.w	r1, r1, #10
 8000576:	6319      	str	r1, [r3, #48]	; 0x30
 8000578:	6c19      	ldr	r1, [r3, #64]	; 0x40
 800057a:	f2c4 0202 	movt	r2, #16386	; 0x4002
 800057e:	f041 0104 	orr.w	r1, r1, #4
 8000582:	6419      	str	r1, [r3, #64]	; 0x40
 8000584:	6c58      	ldr	r0, [r3, #68]	; 0x44
 8000586:	f44f 6180 	mov.w	r1, #1024	; 0x400
 800058a:	f040 0010 	orr.w	r0, r0, #16
 800058e:	6458      	str	r0, [r3, #68]	; 0x44
 8000590:	6813      	ldr	r3, [r2, #0]
 8000592:	f2c4 0102 	movt	r1, #16386	; 0x4002
 8000596:	f043 5380 	orr.w	r3, r3, #268435456	; 0x10000000
 800059a:	6013      	str	r3, [r2, #0]
 800059c:	680b      	ldr	r3, [r1, #0]
 800059e:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80005a2:	f443 5300 	orr.w	r3, r3, #8192	; 0x2000
 80005a6:	600b      	str	r3, [r1, #0]
 80005a8:	6a0b      	ldr	r3, [r1, #32]
 80005aa:	f2c4 0201 	movt	r2, #16385	; 0x4001
 80005ae:	f043 63e0 	orr.w	r3, r3, #117440512	; 0x7000000
 80005b2:	620b      	str	r3, [r1, #32]
 80005b4:	2385      	movs	r3, #133	; 0x85
 80005b6:	8113      	strh	r3, [r2, #8]
 80005b8:	8991      	ldrh	r1, [r2, #12]
 80005ba:	f44f 6300 	mov.w	r3, #2048	; 0x800
 80005be:	b289      	uxth	r1, r1
 80005c0:	f041 0108 	orr.w	r1, r1, #8
 80005c4:	8191      	strh	r1, [r2, #12]
 80005c6:	8991      	ldrh	r1, [r2, #12]
 80005c8:	f2c4 0300 	movt	r3, #16384	; 0x4000
 80005cc:	b289      	uxth	r1, r1
 80005ce:	f441 5100 	orr.w	r1, r1, #8192	; 0x2000
 80005d2:	8191      	strh	r1, [r2, #12]
 80005d4:	f643 627f 	movw	r2, #15999	; 0x3e7f
 80005d8:	851a      	strh	r2, [r3, #40]	; 0x28
 80005da:	f44f 72fa 	mov.w	r2, #500	; 0x1f4
 80005de:	62da      	str	r2, [r3, #44]	; 0x2c
 80005e0:	8999      	ldrh	r1, [r3, #12]
 80005e2:	f44f 4261 	mov.w	r2, #57600	; 0xe100
 80005e6:	b289      	uxth	r1, r1
 80005e8:	f041 0101 	orr.w	r1, r1, #1
 80005ec:	8199      	strh	r1, [r3, #12]
 80005ee:	8819      	ldrh	r1, [r3, #0]
 80005f0:	f2ce 0200 	movt	r2, #57344	; 0xe000
 80005f4:	b289      	uxth	r1, r1
 80005f6:	f041 0101 	orr.w	r1, r1, #1
 80005fa:	8019      	strh	r1, [r3, #0]
 80005fc:	f04f 4380 	mov.w	r3, #1073741824	; 0x40000000
 8000600:	6013      	str	r3, [r2, #0]
 8000602:	e7fe      	b.n	8000602 <work+0x9e>

08000604 <usart_sendb>:
 8000604:	8803      	ldrh	r3, [r0, #0]
 8000606:	061b      	lsls	r3, r3, #24
 8000608:	d5fc      	bpl.n	8000604 <usart_sendb>
 800060a:	8081      	strh	r1, [r0, #4]
 800060c:	4770      	bx	lr
 800060e:	bf00      	nop

08000610 <ser1_sendb>:
 8000610:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8000614:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8000618:	8819      	ldrh	r1, [r3, #0]
 800061a:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 800061e:	0609      	lsls	r1, r1, #24
 8000620:	f2c4 0201 	movt	r2, #16385	; 0x4001
 8000624:	d5f8      	bpl.n	8000618 <ser1_sendb+0x8>
 8000626:	8090      	strh	r0, [r2, #4]
 8000628:	4770      	bx	lr
 800062a:	bf00      	nop

0800062c <nmi_handler>:
 800062c:	e7fe      	b.n	800062c <nmi_handler>
 800062e:	bf00      	nop

08000630 <hard_fault_handler>:
 8000630:	e7fe      	b.n	8000630 <hard_fault_handler>
 8000632:	bf00      	nop

08000634 <mem_manage_handler>:
 8000634:	e7fe      	b.n	8000634 <mem_manage_handler>
 8000636:	bf00      	nop

08000638 <bus_fault_handler>:
 8000638:	e7fe      	b.n	8000638 <bus_fault_handler>
 800063a:	bf00      	nop

0800063c <usage_fault_handler>:
 800063c:	e7fe      	b.n	800063c <usage_fault_handler>
 800063e:	bf00      	nop

08000640 <reset_handler>:
 8000640:	f7ff bf90 	b.w	8000564 <work>

08000644 <tim4_irq_hanlder>:
 8000644:	4b13      	ldr	r3, [pc, #76]	; (8000694 <tim4_irq_hanlder+0x50>)
 8000646:	b510      	push	{r4, lr}
 8000648:	6819      	ldr	r1, [r3, #0]
 800064a:	2964      	cmp	r1, #100	; 0x64
 800064c:	d81f      	bhi.n	800068e <tim4_irq_hanlder+0x4a>
 800064e:	3101      	adds	r1, #1
 8000650:	f44f 6400 	mov.w	r4, #2048	; 0x800
 8000654:	f2c4 0400 	movt	r4, #16384	; 0x4000
 8000658:	8a22      	ldrh	r2, [r4, #16]
 800065a:	480f      	ldr	r0, [pc, #60]	; (8000698 <tim4_irq_hanlder+0x54>)
 800065c:	6019      	str	r1, [r3, #0]
 800065e:	4b0f      	ldr	r3, [pc, #60]	; (800069c <tim4_irq_hanlder+0x58>)
 8000660:	6018      	str	r0, [r3, #0]
 8000662:	07d3      	lsls	r3, r2, #31
 8000664:	d512      	bpl.n	800068c <tim4_irq_hanlder+0x48>
 8000666:	f44f 6340 	mov.w	r3, #3072	; 0xc00
 800066a:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800066e:	695a      	ldr	r2, [r3, #20]
 8000670:	480b      	ldr	r0, [pc, #44]	; (80006a0 <tim4_irq_hanlder+0x5c>)
 8000672:	f482 4280 	eor.w	r2, r2, #16384	; 0x4000
 8000676:	615a      	str	r2, [r3, #20]
 8000678:	460b      	mov	r3, r1
 800067a:	460a      	mov	r2, r1
 800067c:	f7ff feda 	bl	8000434 <xprintf>
 8000680:	8a23      	ldrh	r3, [r4, #16]
 8000682:	f023 0301 	bic.w	r3, r3, #1
 8000686:	041b      	lsls	r3, r3, #16
 8000688:	0c1b      	lsrs	r3, r3, #16
 800068a:	8223      	strh	r3, [r4, #16]
 800068c:	bd10      	pop	{r4, pc}
 800068e:	2101      	movs	r1, #1
 8000690:	e7de      	b.n	8000650 <tim4_irq_hanlder+0xc>
 8000692:	bf00      	nop
 8000694:	20000004 	andcs	r0, r0, r4
 8000698:	08000611 	stmdaeq	r0, {r0, r4, r9, sl}
 800069c:	20000008 	andcs	r0, r0, r8
 80006a0:	080006e0 	stmdaeq	r0, {r5, r6, r7, r9, sl}

080006a4 <usart_sends>:
 80006a4:	b538      	push	{r3, r4, r5, lr}
 80006a6:	460c      	mov	r4, r1
 80006a8:	7809      	ldrb	r1, [r1, #0]
 80006aa:	4605      	mov	r5, r0
 80006ac:	b131      	cbz	r1, 80006bc <usart_sends+0x18>
 80006ae:	4628      	mov	r0, r5
 80006b0:	f7ff ffa8 	bl	8000604 <usart_sendb>
 80006b4:	f814 1f01 	ldrb.w	r1, [r4, #1]!
 80006b8:	2900      	cmp	r1, #0
 80006ba:	d1f8      	bne.n	80006ae <usart_sends+0xa>
 80006bc:	bd38      	pop	{r3, r4, r5, pc}
 80006be:	bf00      	nop
 80006c0:	6c383025 	ldcvs	0, cr3, [r8], #-148	; 0xffffff6c
 80006c4:	00002058 	andeq	r2, r0, r8, asr r0
 80006c8:	32302520 	eorscc	r2, r0, #32, 10	; 0x8000000
 80006cc:	00000058 	andeq	r0, r0, r8, asr r0
 80006d0:	34302520 	ldrtcc	r2, [r0], #-1312	; 0x520
 80006d4:	00000058 	andeq	r0, r0, r8, asr r0
 80006d8:	38302520 	ldmdacc	r0!, {r5, r8, sl, sp}
 80006dc:	0000584c 	andeq	r5, r0, ip, asr #16
 80006e0:	6e756f63 	cdpvs	15, 7, cr6, cr5, cr3, {3}
 80006e4:	3a726574 	bcc	9c99cbc <__text_end+0x1c995c4>
 80006e8:	20642520 	rsbcs	r2, r4, r0, lsr #10
 80006ec:	7825203a 	stmdavc	r5!, {r1, r3, r4, r5, sp}
 80006f0:	25203a20 	strcs	r3, [r0, #-2592]!	; 0xa20
 80006f4:	00000a62 	andeq	r0, r0, r2, ror #20

Дизассемблирование раздела .bss:

20000000 <outptr>:
20000000:	00000000 	andeq	r0, r0, r0

20000004 <counter.2132>:
20000004:	00000000 	andeq	r0, r0, r0

20000008 <xfunc_out>:
20000008:	00000000 	andeq	r0, r0, r0

Дизассемблирование раздела .debug_info:

00000000 <.debug_info>:
       0:	000003a4 	andeq	r0, r0, r4, lsr #7
       4:	00000002 	andeq	r0, r0, r2
       8:	01040000 	mrseq	r0, (UNDEF: 4)
       c:	0000006d 	andeq	r0, r0, sp, rrx
      10:	00008201 	andeq	r8, r0, r1, lsl #4
      14:	0000ad00 	andeq	sl, r0, r0, lsl #26
      18:	00018800 	andeq	r8, r1, r0, lsl #16
      1c:	00056408 	andeq	r6, r5, r8, lsl #8
      20:	00000008 	andeq	r0, r0, r8
      24:	008c0200 	addeq	r0, ip, r0, lsl #4
      28:	28020000 	stmdacs	r2, {}	; <UNPREDICTABLE>
      2c:	00000030 	andeq	r0, r0, r0, lsr r0
      30:	00005d03 	andeq	r5, r0, r3, lsl #26
      34:	00030400 	andeq	r0, r3, r0, lsl #8
      38:	0000004a 	andeq	r0, r0, sl, asr #32
      3c:	0000dc04 	andeq	sp, r0, r4, lsl #24
      40:	00004a00 	andeq	r4, r0, r0, lsl #20
      44:	00230200 	eoreq	r0, r3, r0, lsl #4
      48:	04050001 	streq	r0, [r5], #-1
      4c:	00005f02 	andeq	r5, r0, r2, lsl #30
      50:	25660200 	strbcs	r0, [r6, #-512]!	; 0x200
      54:	06000000 	streq	r0, [r0], -r0
      58:	00004001 	andeq	r4, r0, r1
      5c:	011a0100 	tsteq	sl, r0, lsl #2
      60:	08000188 	stmdaeq	r0, {r3, r7, r8}
      64:	080001a8 	stmdaeq	r0, {r3, r5, r7, r8}
      68:	00000000 	andeq	r0, r0, r0
      6c:	0000007e 	andeq	r0, r0, lr, ror r0
      70:	01006307 	tsteq	r0, r7, lsl #6
      74:	00007e1a 	andeq	r7, r0, sl, lsl lr
      78:	00002000 	andeq	r2, r0, r0
      7c:	01080000 	mrseq	r0, (UNDEF: 8)
      80:	00005808 	andeq	r5, r0, r8, lsl #16
      84:	9b010600 	blls	4188c <vector_table-0x7fbe774>
      88:	01000000 	mrseq	r0, (UNDEF: 0)
      8c:	01a8012c 			; <UNDEFINED> instruction: 0x01a8012c
      90:	01be0800 			; <UNDEFINED> instruction: 0x01be0800
      94:	003e0800 	eorseq	r0, lr, r0, lsl #16
      98:	00ae0000 	adceq	r0, lr, r0
      9c:	73070000 	movwvc	r0, #28672	; 0x7000
      a0:	01007274 	tsteq	r0, r4, ror r2
      a4:	0000ae2d 	andeq	sl, r0, sp, lsr #28
      a8:	00005e00 	andeq	r5, r0, r0, lsl #28
      ac:	04090000 	streq	r0, [r9], #-0
      b0:	000000b4 	strheq	r0, [r0], -r4
      b4:	00007e0a 	andeq	r7, r0, sl, lsl #28
      b8:	00460b00 	subeq	r0, r6, r0, lsl #22
      bc:	58010000 	stmdapl	r1, {}	; <UNPREDICTABLE>
      c0:	0001c001 	andeq	ip, r1, r1
      c4:	00041008 	andeq	r1, r4, r8
      c8:	00007c08 	andeq	r7, r0, r8, lsl #24
      cc:	00017100 	andeq	r7, r1, r0, lsl #2
      d0:	6d660700 	stclvs	7, cr0, [r6, #-0]
      d4:	59010074 	stmdbpl	r1, {r2, r4, r5, r6}
      d8:	000000ae 	andeq	r0, r0, lr, lsr #1
      dc:	000000a8 	andeq	r0, r0, r8, lsr #1
      e0:	70726107 	rsbsvc	r6, r2, r7, lsl #2
      e4:	4c5a0100 	ldfmie	f0, [sl], {-0}
      e8:	77000000 	strvc	r0, [r0, -r0]
      ec:	0c000001 	stceq	0, cr0, [r0], {1}
      f0:	5d010072 	stcpl	0, cr0, [r1, #-456]	; 0xfffffe38
      f4:	00000171 	andeq	r0, r0, r1, ror r1
      f8:	00000233 	andeq	r0, r0, r3, lsr r2
      fc:	0100690c 	tsteq	r0, ip, lsl #18
     100:	0001715d 	andeq	r7, r1, sp, asr r1
     104:	00025d00 	andeq	r5, r2, r0, lsl #26
     108:	006a0c00 	rsbeq	r0, sl, r0, lsl #24
     10c:	01715d01 	cmneq	r1, r1, lsl #26
     110:	029d0000 	addseq	r0, sp, #0
     114:	770c0000 	strvc	r0, [ip, -r0]
     118:	715d0100 	cmpvc	sp, r0, lsl #2
     11c:	58000001 	stmdapl	r0, {r0}
     120:	0c000003 	stceq	0, cr0, [r0], {3}
     124:	5d010066 	stcpl	0, cr0, [r1, #-408]	; 0xfffffe68
     128:	00000171 	andeq	r0, r0, r1, ror r1
     12c:	00000377 	andeq	r0, r0, r7, ror r3
     130:	0100760c 	tsteq	r0, ip, lsl #12
     134:	0001785e 	andeq	r7, r1, lr, asr r8
     138:	0003da00 	andeq	sp, r3, r0, lsl #20
     13c:	00730d00 	rsbseq	r0, r3, r0, lsl #26
     140:	017f5f01 	cmneq	pc, r1, lsl #30
     144:	91020000 	mrsls	r0, (UNDEF: 2)
     148:	00630c48 	rsbeq	r0, r3, r8, asr #24
     14c:	007e5f01 	rsbseq	r5, lr, r1, lsl #30
     150:	040e0000 	streq	r0, [lr], #-0
     154:	640c0000 	strvs	r0, [ip], #-0
     158:	7e5f0100 	rdfvce	f0, f7, f0
     15c:	79000000 	stmdbvc	r0, {}	; <UNPREDICTABLE>
     160:	0c000004 	stceq	0, cr0, [r0], {4}
     164:	5f010070 	svcpl	0x00010070
     168:	0000018f 	andeq	r0, r0, pc, lsl #3
     16c:	0000050c 	andeq	r0, r0, ip, lsl #10
     170:	07040800 	streq	r0, [r4, -r0, lsl #16]
     174:	00000338 	andeq	r0, r0, r8, lsr r3
     178:	33070408 	movwcc	r0, #29704	; 0x7408
     17c:	0e000003 	cdpeq	0, 0, cr0, cr0, cr3, {0}
     180:	0000007e 	andeq	r0, r0, lr, ror r0
     184:	0000018f 	andeq	r0, r0, pc, lsl #3
     188:	0001710f 	andeq	r7, r1, pc, lsl #2
     18c:	09000f00 	stmdbeq	r0, {r8, r9, sl, fp}
     190:	00007e04 	andeq	r7, r0, r4, lsl #28
     194:	a1010600 	tstge	r1, r0, lsl #12
     198:	01000000 	mrseq	r0, (UNDEF: 0)
     19c:	04100135 	ldreq	r0, [r0], #-309	; 0x135
     1a0:	04340800 	ldrteq	r0, [r4], #-2048	; 0x800
     1a4:	05360800 	ldreq	r0, [r6, #-2048]!	; 0x800
     1a8:	01db0000 	bicseq	r0, fp, r0
     1ac:	a8100000 	ldmdage	r0, {}	; <UNPREDICTABLE>
     1b0:	01000000 	mrseq	r0, (UNDEF: 0)
     1b4:	0001ee36 	andeq	lr, r1, r6, lsr lr
     1b8:	00055600 	andeq	r5, r5, r0, lsl #12
     1bc:	74730700 	ldrbtvc	r0, [r3], #-1792	; 0x700
     1c0:	37010072 	smlsdxcc	r1, r2, r0, r0
     1c4:	000000ae 	andeq	r0, r0, lr, lsr #1
     1c8:	00000578 	andeq	r0, r0, r8, ror r5
     1cc:	0066700c 	rsbeq	r7, r6, ip
     1d0:	01ee3a01 	mvneq	r3, r1, lsl #20
     1d4:	058b0000 	streq	r0, [fp]
     1d8:	11000000 	mrsne	r0, (UNDEF: 0)
     1dc:	0001e701 	andeq	lr, r1, r1, lsl #14
     1e0:	01e71200 	mvneq	r1, r0, lsl #4
     1e4:	08000000 	stmdaeq	r0, {}	; <UNPREDICTABLE>
     1e8:	004f0801 	subeq	r0, pc, r1, lsl #16
     1ec:	04090000 	streq	r0, [r9], #-0
     1f0:	000001db 	ldrdeq	r0, [r0], -fp
     1f4:	00d40106 	sbcseq	r0, r4, r6, lsl #2
     1f8:	a5010000 	strge	r0, [r1, #-0]
     1fc:	00043401 	andeq	r3, r4, r1, lsl #8
     200:	00045008 	andeq	r5, r4, r8
     204:	0005ad08 	andeq	sl, r5, r8, lsl #26
     208:	00022b00 	andeq	r2, r2, r0, lsl #22
     20c:	6d661300 	stclvs	3, cr1, [r6, #-0]
     210:	a6010074 			; <UNDEFINED> instruction: 0xa6010074
     214:	000000ae 	andeq	r0, r0, lr, lsr #1
     218:	14709102 	ldrbtne	r9, [r0], #-258	; 0x102
     21c:	7072610d 	rsbsvc	r6, r2, sp, lsl #2
     220:	4caa0100 	stfmis	f0, [sl]
     224:	02000000 	andeq	r0, r0, #0
     228:	06006491 			; <UNDEFINED> instruction: 0x06006491
     22c:	00000001 	andeq	r0, r0, r1
     230:	01b30100 			; <UNDEFINED> instruction: 0x01b30100
     234:	08000450 	stmdaeq	r0, {r4, r6, sl}
     238:	08000484 	stmdaeq	r0, {r2, r7, sl}
     23c:	000005e5 	andeq	r0, r0, r5, ror #11
     240:	00000271 	andeq	r0, r0, r1, ror r2
     244:	00001c10 	andeq	r1, r0, r0, lsl ip
     248:	8fb40100 	svchi	0x00b40100
     24c:	1d000001 	stcne	0, cr0, [r0, #-4]
     250:	13000006 	movwne	r0, #6
     254:	00746d66 	rsbseq	r6, r4, r6, ror #26
     258:	00aeb501 	adceq	fp, lr, r1, lsl #10
     25c:	91020000 	mrsls	r0, (UNDEF: 2)
     260:	610d1474 	tstvs	sp, r4, ror r4
     264:	01007072 	tsteq	r0, r2, ror r0
     268:	00004cb9 			; <UNDEFINED> instruction: 0x00004cb9
     26c:	64910200 	ldrvs	r0, [r1], #512	; 0x200
     270:	79010600 	stmdbvc	r1, {r9, sl}
     274:	01000000 	mrseq	r0, (UNDEF: 0)
     278:	048401c7 	streq	r0, [r4], #455	; 0x1c7
     27c:	04b40800 	ldrteq	r0, [r4], #2048	; 0x800
     280:	063b0800 	ldrteq	r0, [fp], -r0, lsl #16
     284:	02c50000 	sbceq	r0, r5, #0
     288:	a8100000 	ldmdage	r0, {}	; <UNPREDICTABLE>
     28c:	01000000 	mrseq	r0, (UNDEF: 0)
     290:	0001eec8 	andeq	lr, r1, r8, asr #29
     294:	00067300 	andeq	r7, r6, r0, lsl #6
     298:	6d661300 	stclvs	3, cr1, [r6, #-0]
     29c:	c9010074 	stmdbgt	r1, {r2, r4, r5, r6}
     2a0:	000000ae 	andeq	r0, r0, lr, lsr #1
     2a4:	14749102 	ldrbtne	r9, [r4], #-258	; 0x102
     2a8:	7072610d 	rsbsvc	r6, r2, sp, lsl #2
     2ac:	4ccd0100 	stfmie	f0, [sp], {0}
     2b0:	02000000 	andeq	r0, r0, #0
     2b4:	700c5c91 	mulvc	ip, r1, ip
     2b8:	ce010066 	cdpgt	0, 0, cr0, cr1, cr6, {3}
     2bc:	000001ee 	andeq	r0, r0, lr, ror #3
     2c0:	00000691 	muleq	r0, r1, r6
     2c4:	09010600 	stmdbeq	r1, {r9, sl}
     2c8:	01000000 	mrseq	r0, (UNDEF: 0)
     2cc:	04b401e1 	ldrteq	r0, [r4], #481	; 0x1e1
     2d0:	05640800 	strbeq	r0, [r4, #-2048]!	; 0x800
     2d4:	06b30800 	ldrteq	r0, [r3], r0, lsl #16
     2d8:	034e0000 	movteq	r0, #57344	; 0xe000
     2dc:	1c100000 	ldcne	0, cr0, [r0], {-0}
     2e0:	01000000 	mrseq	r0, (UNDEF: 0)
     2e4:	00034ee2 	andeq	r4, r3, r2, ror #29
     2e8:	0006d300 	andeq	sp, r6, r0, lsl #6
     2ec:	003b1000 	eorseq	r1, fp, r0
     2f0:	e3010000 	movw	r0, #4096	; 0x1000
     2f4:	00000178 	andeq	r0, r0, r8, ror r1
     2f8:	000006fc 	strdeq	r0, [r0], -ip
     2fc:	6e656c07 	cdpvs	12, 6, cr6, cr5, cr7, {0}
     300:	55e40100 	strbpl	r0, [r4, #256]!	; 0x100
     304:	0f000003 	svceq	0x00000003
     308:	10000007 	andne	r0, r0, r7
     30c:	00000067 	andeq	r0, r0, r7, rrx
     310:	0355e501 	cmpeq	r5, #4194304	; 0x400000
     314:	078d0000 	streq	r0, [sp, r0]
     318:	690c0000 	stmdbvs	ip, {}	; <UNPREDICTABLE>
     31c:	55e80100 	strbpl	r0, [r8, #256]!	; 0x100
     320:	c1000003 	tstgt	r0, r3
     324:	15000007 	strne	r0, [r0, #-7]
     328:	01007062 	tsteq	r0, r2, rrx
     32c:	00035ce9 	andeq	r5, r3, r9, ror #25
     330:	70730c00 	rsbsvc	r0, r3, r0, lsl #24
     334:	67ea0100 	strbvs	r0, [sl, r0, lsl #2]!
     338:	03000003 	movweq	r0, #3
     33c:	0c000008 	stceq	0, cr0, [r0], {8}
     340:	0100706c 	tsteq	r0, ip, rrx
     344:	000379eb 	andeq	r7, r3, fp, ror #19
     348:	00081600 	andeq	r1, r8, r0, lsl #12
     34c:	04090000 	streq	r0, [r9], #-0
     350:	00000354 	andeq	r0, r0, r4, asr r3
     354:	05041716 	streq	r1, [r4, #-1814]	; 0x716
     358:	00746e69 	rsbseq	r6, r4, r9, ror #28
     35c:	03620409 	cmneq	r2, #150994944	; 0x9000000
     360:	e70a0000 	str	r0, [sl, -r0]
     364:	09000001 	stmdbeq	r0, {r0}
     368:	00036d04 	andeq	r6, r3, r4, lsl #26
     36c:	03720a00 	cmneq	r2, #0, 20
     370:	02080000 	andeq	r0, r8, #0
     374:	00002807 	andeq	r2, r0, r7, lsl #16
     378:	7f040900 	svcvc	0x00040900
     37c:	0a000003 	beq	390 <vector_table-0x7fffc70>
     380:	00000178 	andeq	r0, r0, r8, ror r1
     384:	00002118 	andeq	r2, r0, r8, lsl r1
     388:	8f140100 	svchi	0x00140100
     38c:	05000001 	streq	r0, [r0, #-1]
     390:	00000003 	andeq	r0, r0, r3
     394:	00121920 	andseq	r1, r2, r0, lsr #18
     398:	13010000 	movwne	r0, #4096	; 0x1000
     39c:	000001ee 	andeq	r0, r0, lr, ror #3
     3a0:	08030501 	stmdaeq	r3, {r0, r8, sl}
     3a4:	00200000 	eoreq	r0, r0, r0
     3a8:	00000a9e 	muleq	r0, lr, sl
     3ac:	013a0002 	teqeq	sl, r2
     3b0:	01040000 	mrseq	r0, (UNDEF: 4)
     3b4:	0000006d 	andeq	r0, r0, sp, rrx
     3b8:	0002b101 	andeq	fp, r2, r1, lsl #2
     3bc:	0000ad00 	andeq	sl, r0, r0, lsl #26
     3c0:	00056400 	andeq	r6, r5, r0, lsl #8
     3c4:	00060408 	andeq	r0, r6, r8, lsl #8
     3c8:	0001e908 	andeq	lr, r1, r8, lsl #18
     3cc:	09390200 	ldmdbeq	r9!, {r9}
     3d0:	03040000 	movweq	r0, #16384	; 0x4000
     3d4:	0002609e 	muleq	r2, lr, r0
     3d8:	06e60300 	strbteq	r0, [r6], r0, lsl #6
     3dc:	03720000 	cmneq	r2, #0
     3e0:	0000026c 	andeq	r0, r0, ip, ror #4
     3e4:	05420374 	strbeq	r0, [r2, #-884]	; 0x374
     3e8:	03750000 	cmneq	r5, #0
     3ec:	00000826 	andeq	r0, r0, r6, lsr #16
     3f0:	08430376 	stmdaeq	r3, {r1, r2, r4, r5, r6, r8, r9}^
     3f4:	037b0000 	cmneq	fp, #0
     3f8:	00000809 	andeq	r0, r0, r9, lsl #16
     3fc:	0227037c 	eoreq	r0, r7, #124, 6	; 0xf0000001
     400:	037e0000 	cmneq	lr, #0
     404:	000007c3 	andeq	r0, r0, r3, asr #15
     408:	050e037f 	streq	r0, [lr, #-895]	; 0x37f
     40c:	03000000 	movweq	r0, #0
     410:	00000583 	andeq	r0, r0, r3, lsl #11
     414:	029c0301 	addseq	r0, ip, #67108864	; 0x4000000
     418:	03020000 	movweq	r0, #8192	; 0x2000
     41c:	00000405 	andeq	r0, r0, r5, lsl #8
     420:	01bf0303 			; <UNDEFINED> instruction: 0x01bf0303
     424:	03040000 	movweq	r0, #16384	; 0x4000
     428:	0000024f 	andeq	r0, r0, pc, asr #4
     42c:	01ca0305 	biceq	r0, sl, r5, lsl #6
     430:	03060000 	movweq	r0, #24576	; 0x6000
     434:	00000772 	andeq	r0, r0, r2, ror r7
     438:	04720307 	ldrbteq	r0, [r2], #-775	; 0x307
     43c:	03080000 	movweq	r0, #32768	; 0x8000
     440:	000008fb 	strdeq	r0, [r0], -fp
     444:	05680309 	strbeq	r0, [r8, #-777]!	; 0x309
     448:	030a0000 	movweq	r0, #40960	; 0xa000
     44c:	000001ad 	andeq	r0, r0, sp, lsr #3
     450:	05ef030b 	strbeq	r0, [pc, #779]!	; 763 <vector_table-0x7fff89d>
     454:	030c0000 	movweq	r0, #49152	; 0xc000
     458:	00000361 	andeq	r0, r0, r1, ror #6
     45c:	08dc030d 	ldmeq	ip, {r0, r2, r3, r8, r9}^
     460:	030e0000 	movweq	r0, #57344	; 0xe000
     464:	000004ba 			; <UNDEFINED> instruction: 0x000004ba
     468:	0196030f 	orrseq	r0, r6, pc, lsl #6
     46c:	03100000 	tsteq	r0, #0
     470:	0000072d 	andeq	r0, r0, sp, lsr #14
     474:	058c0311 	streq	r0, [ip, #785]	; 0x311
     478:	03120000 	tsteq	r2, #0
     47c:	000005d9 	ldrdeq	r0, [r0], -r9
     480:	06010313 			; <UNDEFINED> instruction: 0x06010313
     484:	03140000 	tsteq	r4, #0
     488:	00000391 	muleq	r0, r1, r3
     48c:	01470315 	cmpeq	r7, r5, lsl r3
     490:	03160000 	tsteq	r6, #0
     494:	00000836 	andeq	r0, r0, r6, lsr r8
     498:	030c0317 	movweq	r0, #49943	; 0xc317
     49c:	03180000 	tsteq	r8, #0
     4a0:	0000092b 	andeq	r0, r0, fp, lsr #18
     4a4:	05500319 	ldrbeq	r0, [r0, #-793]	; 0x319
     4a8:	031a0000 	tsteq	sl, #0
     4ac:	0000070c 	andeq	r0, r0, ip, lsl #14
     4b0:	07da031b 	bfieq	r0, fp, #6, #21
     4b4:	031c0000 	tsteq	ip, #0
     4b8:	000004b0 			; <UNDEFINED> instruction: 0x000004b0
     4bc:	017e031d 	cmneq	lr, sp, lsl r3
     4c0:	031e0000 	tsteq	lr, #0
     4c4:	000005c4 	andeq	r0, r0, r4, asr #11
     4c8:	07aa031f 			; <UNDEFINED> instruction: 0x07aa031f
     4cc:	03200000 	teqeq	r0, #0
     4d0:	00000499 	muleq	r0, r9, r4
     4d4:	015f0321 	cmpeq	pc, r1, lsr #6
     4d8:	03220000 	teqeq	r2, #0
     4dc:	00000302 	andeq	r0, r0, r2, lsl #6
     4e0:	08c30323 	stmiaeq	r3, {r0, r1, r5, r8, r9}^
     4e4:	03240000 	teqeq	r4, #0
     4e8:	000006bd 			; <UNDEFINED> instruction: 0x000006bd
     4ec:	03da0325 	bicseq	r0, sl, #-1811939328	; 0x94000000
     4f0:	03260000 	teqeq	r6, #0
     4f4:	0000091f 	andeq	r0, r0, pc, lsl r9
     4f8:	01fa0327 	mvnseq	r0, r7, lsr #6
     4fc:	03280000 	teqeq	r8, #0
     500:	0000062b 	andeq	r0, r0, fp, lsr #12
     504:	02330329 	eorseq	r0, r3, #-1543503872	; 0xa4000000
     508:	032a0000 	teqeq	sl, #0
     50c:	00000209 	andeq	r0, r0, r9, lsl #4
     510:	04ed032b 	strbteq	r0, [sp], #811	; 0x32b
     514:	032c0000 	teqeq	ip, #0
     518:	0000084f 	andeq	r0, r0, pc, asr #16
     51c:	0720032d 	streq	r0, [r0, -sp, lsr #6]!
     520:	032e0000 	teqeq	lr, #0
     524:	0000034f 	andeq	r0, r0, pc, asr #6
     528:	0768032f 	strbeq	r0, [r8, -pc, lsr #6]!
     52c:	03300000 	teqeq	r0, #0
     530:	00000134 	andeq	r0, r0, r4, lsr r1
     534:	05b00331 	ldreq	r0, [r0, #817]!	; 0x331
     538:	03320000 	teqeq	r2, #0
     53c:	000004a6 	andeq	r0, r0, r6, lsr #9
     540:	02440333 	subeq	r0, r4, #-872415232	; 0xcc000000
     544:	03340000 	teqeq	r4, #0
     548:	000006ce 	andeq	r0, r0, lr, asr #13
     54c:	07870335 			; <UNDEFINED> instruction: 0x07870335
     550:	03360000 	teqeq	r6, #0
     554:	000008d2 	ldrdeq	r0, [r0], -r2
     558:	016c0337 	cmneq	ip, r7, lsr r3
     55c:	03380000 	teqeq	r8, #0
     560:	000006fa 	strdeq	r0, [r0], -sl
     564:	02ea0339 	rsceq	r0, sl, #-469762048	; 0xe4000000
     568:	033a0000 	teqeq	sl, #0
     56c:	000008b1 			; <UNDEFINED> instruction: 0x000008b1
     570:	0530033b 	ldreq	r0, [r0, #-827]!	; 0x33b
     574:	033c0000 	teqeq	ip, #0
     578:	00000962 	andeq	r0, r0, r2, ror #18
     57c:	0188033d 	orreq	r0, r8, sp, lsr r3
     580:	033e0000 	teqeq	lr, #0
     584:	000008ee 	andeq	r0, r0, lr, ror #17
     588:	089e033f 	ldmeq	lr, {r0, r1, r2, r3, r4, r5, r8, r9}
     58c:	00c00000 	sbceq	r0, r0, r0
     590:	00051803 	andeq	r1, r5, r3, lsl #16
     594:	0300c100 	movweq	ip, #256	; 0x100
     598:	00000383 	andeq	r0, r0, r3, lsl #7
     59c:	bd0300c2 	stclt	0, cr0, [r3, #-776]	; 0xfffffcf8
     5a0:	c3000002 	movwgt	r0, #2
     5a4:	01220300 	teqeq	r2, r0, lsl #6
     5a8:	00c40000 	sbceq	r0, r4, r0
     5ac:	00069e03 	andeq	r9, r6, r3, lsl #28
     5b0:	0300c500 	movweq	ip, #1280	; 0x500
     5b4:	000003c8 	andeq	r0, r0, r8, asr #7
     5b8:	b70300c6 	strlt	r0, [r3, -r6, asr #1]
     5bc:	c7000007 	strgt	r0, [r0, -r7]
     5c0:	06b00300 	ldrteq	r0, [r0], r0, lsl #6
     5c4:	00c80000 	sbceq	r0, r8, r0
     5c8:	0003f203 	andeq	pc, r3, r3, lsl #4
     5cc:	0300c900 	movweq	ip, #2304	; 0x900
     5d0:	0000090b 	andeq	r0, r0, fp, lsl #18
     5d4:	e70300ca 	str	r0, [r3, -sl, asr #1]
     5d8:	cb000001 	blgt	5e4 <vector_table-0x7fffa1c>
     5dc:	07ec0300 	strbeq	r0, [ip, r0, lsl #6]!
     5e0:	00cc0000 	sbceq	r0, ip, r0
     5e4:	00041303 	andeq	r1, r4, r3, lsl #6
     5e8:	0300cd00 	movweq	ip, #3328	; 0xd00
     5ec:	000000e1 	andeq	r0, r0, r1, ror #1
     5f0:	550300ce 	strpl	r0, [r3, #-206]	; 0xce
     5f4:	cf000001 	svcgt	0x00000001
     5f8:	00eb0300 	rsceq	r0, fp, r0, lsl #6
     5fc:	00d00000 	sbcseq	r0, r0, r0
     600:	00095903 	andeq	r5, r9, r3, lsl #18
     604:	0000d100 	andeq	sp, r0, r0, lsl #2
     608:	0003be04 	andeq	fp, r3, r4, lsl #28
     60c:	25fc0300 	ldrbcs	r0, [ip, #768]!	; 0x300
     610:	05000000 	streq	r0, [r0, #-0]
     614:	00580801 	subseq	r0, r8, r1, lsl #16
     618:	02050000 	andeq	r0, r5, #0
     61c:	00068005 	andeq	r8, r6, r5
     620:	02940400 	addseq	r0, r4, #0, 8
     624:	07040000 	streq	r0, [r4, -r0]
     628:	00000284 	andeq	r0, r0, r4, lsl #5
     62c:	69050406 	stmdbvs	r5, {r1, r2, sl}
     630:	0500746e 	streq	r7, [r0, #-1134]	; 0x46e
     634:	05000508 	streq	r0, [r0, #-1288]	; 0x508
     638:	cc040000 	stcgt	0, cr0, [r4], {-0}
     63c:	04000004 	streq	r0, [r0], #-4
     640:	00029d0a 	andeq	r9, r2, sl, lsl #26
     644:	08010500 	stmdaeq	r1, {r8, sl}
     648:	0000004f 	andeq	r0, r0, pc, asr #32
     64c:	0005e604 	andeq	lr, r5, r4, lsl #12
     650:	af0b0400 	svcge	0x000b0400
     654:	05000002 	streq	r0, [r0, #-2]
     658:	00280702 	eoreq	r0, r8, r2, lsl #14
     65c:	93040000 	movwls	r0, #16384	; 0x4000
     660:	04000002 	streq	r0, [r0], #-2
     664:	0002c10c 	andeq	ip, r2, ip, lsl #2
     668:	07040500 	streq	r0, [r4, -r0, lsl #10]
     66c:	00000338 	andeq	r0, r0, r8, lsr r3
     670:	2e070805 	cdpcs	8, 0, cr0, cr7, cr5, {0}
     674:	07000003 	streq	r0, [r0, -r3]
     678:	2f020e04 	svccs	0x00020e04
     67c:	0003a701 	andeq	sl, r3, r1, lsl #14
     680:	02b80800 	adcseq	r0, r8, #0, 16
     684:	31020000 	mrscc	r0, (UNDEF: 2)
     688:	0003b701 	andeq	fp, r3, r1, lsl #14
     68c:	00230200 	eoreq	r0, r3, r0, lsl #4
     690:	00063a08 	andeq	r3, r6, r8, lsl #20
     694:	01320200 	teqeq	r2, r0, lsl #4
     698:	000003bc 			; <UNDEFINED> instruction: 0x000003bc
     69c:	08202302 	stmdaeq	r0!, {r1, r8, r9, sp}
     6a0:	000008ac 	andeq	r0, r0, ip, lsr #17
     6a4:	cc013302 	stcgt	3, cr3, [r1], {2}
     6a8:	03000003 	movweq	r0, #3
     6ac:	08018023 	stmdaeq	r1, {r0, r1, r5, pc}
     6b0:	000002e1 	andeq	r0, r0, r1, ror #5
     6b4:	bc013402 	cfstrslt	mvf3, [r1], {2}
     6b8:	03000003 	movweq	r0, #3
     6bc:	0801a023 	stmdaeq	r1, {r0, r1, r5, sp, pc}
     6c0:	00000906 	andeq	r0, r0, r6, lsl #18
     6c4:	d1013502 	tstle	r1, r2, lsl #10
     6c8:	03000003 	movweq	r0, #3
     6cc:	08028023 	stmdaeq	r2, {r0, r1, r5, pc}
     6d0:	0000064e 	andeq	r0, r0, lr, asr #12
     6d4:	bc013602 	stclt	6, cr3, [r1], {2}
     6d8:	03000003 	movweq	r0, #3
     6dc:	0802a023 	stmdaeq	r2, {r0, r1, r5, sp, pc}
     6e0:	00000595 	muleq	r0, r5, r5
     6e4:	d6013702 	strle	r3, [r1], -r2, lsl #14
     6e8:	03000003 	movweq	r0, #3
     6ec:	08038023 	stmdaeq	r3, {r0, r1, r5, pc}
     6f0:	00000658 	andeq	r0, r0, r8, asr r6
     6f4:	bc013802 	stclt	8, cr3, [r1], {2}
     6f8:	03000003 	movweq	r0, #3
     6fc:	0803a023 	stmdaeq	r3, {r0, r1, r5, sp, pc}
     700:	000008cd 	andeq	r0, r0, sp, asr #17
     704:	db013902 	blle	4eb14 <vector_table-0x7fb14ec>
     708:	03000003 	movweq	r0, #3
     70c:	08048023 	stmdaeq	r4, {r0, r1, r5, pc}
     710:	00000662 	andeq	r0, r0, r2, ror #12
     714:	e0013a02 	and	r3, r1, r2, lsl #20
     718:	03000003 	movweq	r0, #3
     71c:	0904a023 	stmdbeq	r4, {r0, r1, r5, sp, pc}
     720:	02005049 	andeq	r5, r0, #73	; 0x49
     724:	0400013b 	streq	r0, [r0], #-315	; 0x13b
     728:	23030000 	movwcs	r0, #12288	; 0x3000
     72c:	6c080680 	stcvs	6, cr0, [r8], {128}	; 0x80
     730:	02000006 	andeq	r0, r0, #6
     734:	0405013c 	streq	r0, [r5], #-316	; 0x13c
     738:	23030000 	movwcs	r0, #12288	; 0x3000
     73c:	180807f0 	stmdane	r8, {r4, r5, r6, r7, r8, r9, sl}
     740:	02000006 	andeq	r0, r0, #6
     744:	0416013d 	ldreq	r0, [r6], #-317	; 0x13d
     748:	23030000 	movwcs	r0, #12288	; 0x3000
     74c:	0a001c80 	beq	7954 <vector_table-0x7ff86ac>
     750:	000002b6 			; <UNDEFINED> instruction: 0x000002b6
     754:	000003b7 			; <UNDEFINED> instruction: 0x000003b7
     758:	0002c10b 	andeq	ip, r2, fp, lsl #2
     75c:	0c000700 	stceq	7, cr0, [r0], {-0}
     760:	000003a7 	andeq	r0, r0, r7, lsr #7
     764:	0002b60a 	andeq	fp, r2, sl, lsl #12
     768:	0003cc00 	andeq	ip, r3, r0, lsl #24
     76c:	02c10b00 	sbceq	r0, r1, #0, 22
     770:	00170000 	andseq	r0, r7, r0
     774:	0003a70c 	andeq	sl, r3, ip, lsl #14
     778:	03a70c00 			; <UNDEFINED> instruction: 0x03a70c00
     77c:	a70c0000 	strge	r0, [ip, -r0]
     780:	0c000003 	stceq	0, cr0, [r0], {3}
     784:	000003a7 	andeq	r0, r0, r7, lsr #7
     788:	0002b60a 	andeq	fp, r2, sl, lsl #12
     78c:	0003f000 	andeq	pc, r3, r0
     790:	02c10b00 	sbceq	r0, r1, #0, 22
     794:	00370000 	eorseq	r0, r7, r0
     798:	0002920a 	andeq	r9, r2, sl, lsl #4
     79c:	00040000 	andeq	r0, r4, r0
     7a0:	02c10b00 	sbceq	r0, r1, #0, 22
     7a4:	00ef0000 	rsceq	r0, pc, r0
     7a8:	0003f00c 	andeq	pc, r3, ip
     7ac:	02b60a00 	adcseq	r0, r6, #0, 20
     7b0:	04160000 	ldreq	r0, [r6], #-0
     7b4:	c10d0000 	mrsgt	r0, (UNDEF: 13)
     7b8:	83000002 	movwhi	r0, #2
     7bc:	b60c0002 	strlt	r0, [ip], -r2
     7c0:	0e000002 	cdpeq	0, 0, cr0, cr0, cr2, {0}
     7c4:	0000077d 	andeq	r0, r0, sp, ror r7
     7c8:	cf013e02 	svcgt	0x00013e02
     7cc:	0a000002 	beq	7dc <vector_table-0x7fff824>
     7d0:	000002b6 			; <UNDEFINED> instruction: 0x000002b6
     7d4:	00000437 	andeq	r0, r0, r7, lsr r4
     7d8:	0002c10b 	andeq	ip, r2, fp, lsl #2
     7dc:	0c000100 	stfeqs	f0, [r0], {-0}
     7e0:	000002a4 	andeq	r0, r0, r4, lsr #5
     7e4:	0002790c 	andeq	r7, r2, ip, lsl #18
     7e8:	03280f00 	teqeq	r8, #0, 30
     7ec:	04e1029b 	strbteq	r0, [r1], #667	; 0x29b
     7f0:	ff080000 			; <UNDEFINED> instruction: 0xff080000
     7f4:	03000003 	movweq	r0, #3
     7f8:	0416029d 	ldreq	r0, [r6], #-669	; 0x29d
     7fc:	23020000 	movwcs	r0, #8192	; 0x2000
     800:	07190800 	ldreq	r0, [r9, -r0, lsl #16]
     804:	9e030000 	cdpls	0, 0, cr0, cr3, cr0, {0}
     808:	00041602 	andeq	r1, r4, r2, lsl #12
     80c:	04230200 	strteq	r0, [r3], #-512	; 0x200
     810:	0005d108 	andeq	sp, r5, r8, lsl #2
     814:	029f0300 	addseq	r0, pc, #0, 6
     818:	00000416 	andeq	r0, r0, r6, lsl r4
     81c:	08082302 	stmdaeq	r8, {r1, r8, r9, sp}
     820:	000003b8 			; <UNDEFINED> instruction: 0x000003b8
     824:	1602a003 	strne	sl, [r2], -r3
     828:	02000004 	andeq	r0, r0, #4
     82c:	49090c23 	stmdbmi	r9, {r0, r1, r5, sl, fp}
     830:	03005244 	movweq	r5, #580	; 0x244
     834:	041602a1 	ldreq	r0, [r6], #-673	; 0x2a1
     838:	23020000 	movwcs	r0, #8192	; 0x2000
     83c:	444f0910 	strbmi	r0, [pc], #-2320	; 844 <vector_table-0x7fff7bc>
     840:	a2030052 	andge	r0, r3, #82	; 0x52
     844:	00041602 	andeq	r1, r4, r2, lsl #12
     848:	14230200 	strtne	r0, [r3], #-512	; 0x200
     84c:	00080308 	andeq	r0, r8, r8, lsl #6
     850:	02a30300 	adceq	r0, r3, #0, 6
     854:	00000437 	andeq	r0, r0, r7, lsr r4
     858:	08182302 	ldmdaeq	r8, {r1, r8, r9, sp}
     85c:	000007fd 	strdeq	r0, [r0], -sp
     860:	3702a403 	strcc	sl, [r2, -r3, lsl #8]
     864:	02000004 	andeq	r0, r0, #4
     868:	74081a23 	strvc	r1, [r8], #-2595	; 0xa23
     86c:	03000009 	movweq	r0, #9
     870:	041602a5 	ldreq	r0, [r6], #-677	; 0x2a5
     874:	23020000 	movwcs	r0, #8192	; 0x2000
     878:	4641091c 			; <UNDEFINED> instruction: 0x4641091c
     87c:	a6030052 			; <UNDEFINED> instruction: 0xa6030052
     880:	0004e102 	andeq	lr, r4, r2, lsl #2
     884:	20230200 	eorcs	r0, r3, r0, lsl #4
     888:	04270c00 	strteq	r0, [r7], #-3072	; 0xc00
     88c:	9d0e0000 	stcls	0, cr0, [lr, #-0]
     890:	03000007 	movweq	r0, #7
     894:	044102a7 	strbeq	r0, [r1], #-679	; 0x2a7
     898:	880f0000 	stmdahi	pc, {}	; <UNPREDICTABLE>
     89c:	bf02ea03 	svclt	0x0002ea03
     8a0:	09000006 	stmdbeq	r0, {r1, r2}
     8a4:	03005243 	movweq	r5, #579	; 0x243
     8a8:	041602ec 	ldreq	r0, [r6], #-748	; 0x2ec
     8ac:	23020000 	movwcs	r0, #8192	; 0x2000
     8b0:	07950800 	ldreq	r0, [r5, r0, lsl #16]
     8b4:	ed030000 	stc	0, cr0, [r3, #-0]
     8b8:	00041602 	andeq	r1, r4, r2, lsl #12
     8bc:	04230200 	strteq	r0, [r3], #-512	; 0x200
     8c0:	00079808 	andeq	r9, r7, r8, lsl #16
     8c4:	02ee0300 	rsceq	r0, lr, #0, 6
     8c8:	00000416 	andeq	r0, r0, r6, lsl r4
     8cc:	09082302 	stmdbeq	r8, {r1, r8, r9, sp}
     8d0:	00524943 	subseq	r4, r2, r3, asr #18
     8d4:	1602ef03 	strne	lr, [r2], -r3, lsl #30
     8d8:	02000004 	andeq	r0, r0, #4
     8dc:	6b080c23 	blvs	203970 <vector_table-0x7dfc690>
     8e0:	03000009 	movweq	r0, #9
     8e4:	041602f0 	ldreq	r0, [r6], #-752	; 0x2f0
     8e8:	23020000 	movwcs	r0, #8192	; 0x2000
     8ec:	060f0810 			; <UNDEFINED> instruction: 0x060f0810
     8f0:	f1030000 			; <UNDEFINED> instruction: 0xf1030000
     8f4:	00041602 	andeq	r1, r4, r2, lsl #12
     8f8:	14230200 	strtne	r0, [r3], #-512	; 0x200
     8fc:	0003af08 	andeq	sl, r3, r8, lsl #30
     900:	02f20300 	rscseq	r0, r2, #0, 6
     904:	00000416 	andeq	r0, r0, r6, lsl r4
     908:	08182302 	ldmdaeq	r8, {r1, r8, r9, sp}
     90c:	0000063a 	andeq	r0, r0, sl, lsr r6
     910:	b602f303 	strlt	pc, [r2], -r3, lsl #6
     914:	02000002 	andeq	r0, r0, #2
     918:	90081c23 	andls	r1, r8, r3, lsr #24
     91c:	03000004 	movweq	r0, #4
     920:	041602f4 	ldreq	r0, [r6], #-756	; 0x2f4
     924:	23020000 	movwcs	r0, #8192	; 0x2000
     928:	013e0820 	teqeq	lr, r0, lsr #16
     92c:	f5030000 			; <UNDEFINED> instruction: 0xf5030000
     930:	00041602 	andeq	r1, r4, r2, lsl #12
     934:	24230200 	strtcs	r0, [r3], #-512	; 0x200
     938:	00064408 	andeq	r4, r6, r8, lsl #8
     93c:	02f60300 	rscseq	r0, r6, #0, 6
     940:	00000427 	andeq	r0, r0, r7, lsr #8
     944:	08282302 	stmdaeq	r8!, {r1, r8, r9, sp}
     948:	000002c9 	andeq	r0, r0, r9, asr #5
     94c:	1602f703 	strne	pc, [r2], -r3, lsl #14
     950:	02000004 	andeq	r0, r0, #4
     954:	e4083023 	str	r3, [r8], #-35	; 0x23
     958:	03000007 	movweq	r0, #7
     95c:	041602f8 	ldreq	r0, [r6], #-760	; 0x2f8
     960:	23020000 	movwcs	r0, #8192	; 0x2000
     964:	043f0834 	ldrteq	r0, [pc], #-2100	; 96c <vector_table-0x7fff694>
     968:	f9030000 			; <UNDEFINED> instruction: 0xf9030000
     96c:	00041602 	andeq	r1, r4, r2, lsl #12
     970:	38230200 	stmdacc	r3!, {r9}
     974:	00064e08 	andeq	r4, r6, r8, lsl #28
     978:	02fa0300 	rscseq	r0, sl, #0, 6
     97c:	000002b6 			; <UNDEFINED> instruction: 0x000002b6
     980:	083c2302 	ldmdaeq	ip!, {r1, r8, r9, sp}
     984:	000000f9 	strdeq	r0, [r0], -r9
     988:	1602fb03 	strne	pc, [r2], -r3, lsl #22
     98c:	02000004 	andeq	r0, r0, #4
     990:	a8084023 	stmdage	r8, {r0, r1, r5, lr}
     994:	03000005 	movweq	r0, #5
     998:	041602fc 	ldreq	r0, [r6], #-764	; 0x2fc
     99c:	23020000 	movwcs	r0, #8192	; 0x2000
     9a0:	06580844 	ldrbeq	r0, [r8], -r4, asr #16
     9a4:	fd030000 	stc2	0, cr0, [r3, #-0]
     9a8:	00042702 	andeq	r2, r4, r2, lsl #14
     9ac:	48230200 	stmdami	r3!, {r9}
     9b0:	0005ba08 	andeq	fp, r5, r8, lsl #20
     9b4:	02fe0300 	rscseq	r0, lr, #0, 6
     9b8:	00000416 	andeq	r0, r0, r6, lsl r4
     9bc:	08502302 	ldmdaeq	r0, {r1, r8, r9, sp}^
     9c0:	0000021d 	andeq	r0, r0, sp, lsl r2
     9c4:	1602ff03 	strne	pc, [r2], -r3, lsl #30
     9c8:	02000004 	andeq	r0, r0, #4
     9cc:	d0085423 	andle	r5, r8, r3, lsr #8
     9d0:	03000007 	movweq	r0, #7
     9d4:	04160300 	ldreq	r0, [r6], #-768	; 0x300
     9d8:	23020000 	movwcs	r0, #8192	; 0x2000
     9dc:	06620858 			; <UNDEFINED> instruction: 0x06620858
     9e0:	01030000 	mrseq	r0, (UNDEF: 3)
     9e4:	0002b603 	andeq	fp, r2, r3, lsl #12
     9e8:	5c230200 	sfmpl	f0, 4, [r3], #-0
     9ec:	00052608 	andeq	r2, r5, r8, lsl #12
     9f0:	03020300 	movweq	r0, #8960	; 0x2300
     9f4:	00000416 	andeq	r0, r0, r6, lsl r4
     9f8:	08602302 	stmdaeq	r0!, {r1, r8, r9, sp}^
     9fc:	00000118 	andeq	r0, r0, r8, lsl r1
     a00:	16030303 	strne	r0, [r3], -r3, lsl #6
     a04:	02000004 	andeq	r0, r0, #4
     a08:	6c086423 	cfstrsvs	mvf6, [r8], {35}	; 0x23
     a0c:	03000006 	movweq	r0, #6
     a10:	04270304 	strteq	r0, [r7], #-772	; 0x304
     a14:	23020000 	movwcs	r0, #8192	; 0x2000
     a18:	01a80868 			; <UNDEFINED> instruction: 0x01a80868
     a1c:	05030000 	streq	r0, [r3, #-0]
     a20:	00041603 	andeq	r1, r4, r3, lsl #12
     a24:	70230200 	eorvc	r0, r3, r0, lsl #4
     a28:	52534309 	subspl	r4, r3, #603979776	; 0x24000000
     a2c:	03060300 	movweq	r0, #25344	; 0x6300
     a30:	00000416 	andeq	r0, r0, r6, lsl r4
     a34:	08742302 	ldmdaeq	r4!, {r1, r8, r9, sp}^
     a38:	00000676 	andeq	r0, r0, r6, ror r6
     a3c:	27030703 	strcs	r0, [r3, -r3, lsl #14]
     a40:	02000004 	andeq	r0, r0, #4
     a44:	d6087823 	strle	r7, [r8], -r3, lsr #16
     a48:	03000002 	movweq	r0, #2
     a4c:	04160308 	ldreq	r0, [r6], #-776	; 0x308
     a50:	23030000 	movwcs	r0, #12288	; 0x3000
     a54:	1b080180 	blne	20105c <vector_table-0x7dfefa4>
     a58:	03000008 	movweq	r0, #8
     a5c:	04160309 	ldreq	r0, [r6], #-777	; 0x309
     a60:	23030000 	movwcs	r0, #12288	; 0x3000
     a64:	0e000184 	adfeqd	f0, f0, f4
     a68:	000003e6 	andeq	r0, r0, r6, ror #7
     a6c:	f2030a03 	vpmax.s8	d0, d3, d3
     a70:	0f000004 	svceq	0x00000004
     a74:	03760354 	cmneq	r6, #84, 6	; 0x50000001
     a78:	000008ef 	andeq	r0, r0, pc, ror #17
     a7c:	31524309 	cmpcc	r2, r9, lsl #6
     a80:	03780300 	cmneq	r8, #0, 6
     a84:	00000437 	andeq	r0, r0, r7, lsr r4
     a88:	08002302 	stmdaeq	r0, {r1, r8, r9, sp}
     a8c:	0000063a 	andeq	r0, r0, sl, lsr r6
     a90:	a4037903 	strge	r7, [r3], #-2307	; 0x903
     a94:	02000002 	andeq	r0, r0, #2
     a98:	43090223 	movwmi	r0, #37411	; 0x9223
     a9c:	03003252 	movweq	r3, #594	; 0x252
     aa0:	0437037a 	ldrteq	r0, [r7], #-890	; 0x37a
     aa4:	23020000 	movwcs	r0, #8192	; 0x2000
     aa8:	06440804 	strbeq	r0, [r4], -r4, lsl #16
     aac:	7b030000 	blvc	c0ab4 <vector_table-0x7f3f54c>
     ab0:	0002a403 	andeq	sl, r2, r3, lsl #8
     ab4:	06230200 	strteq	r0, [r3], -r0, lsl #4
     ab8:	0004e808 	andeq	lr, r4, r8, lsl #16
     abc:	037c0300 	cmneq	ip, #0, 6
     ac0:	00000437 	andeq	r0, r0, r7, lsr r4
     ac4:	08082302 	stmdaeq	r8, {r1, r8, r9, sp}
     ac8:	0000064e 	andeq	r0, r0, lr, asr #12
     acc:	a4037d03 	strge	r7, [r3], #-3331	; 0xd03
     ad0:	02000002 	andeq	r0, r0, #2
     ad4:	1f080a23 	svcne	0x00080a23
     ad8:	03000004 	movweq	r0, #4
     adc:	0437037e 	ldrteq	r0, [r7], #-894	; 0x37e
     ae0:	23020000 	movwcs	r0, #8192	; 0x2000
     ae4:	0658080c 	ldrbeq	r0, [r8], -ip, lsl #16
     ae8:	7f030000 	svcvc	0x00030000
     aec:	0002a403 	andeq	sl, r2, r3, lsl #8
     af0:	0e230200 	cdpeq	2, 2, cr0, cr3, cr0, {0}
     af4:	00525309 	subseq	r5, r2, r9, lsl #6
     af8:	37038003 	strcc	r8, [r3, -r3]
     afc:	02000004 	andeq	r0, r0, #4
     b00:	62081023 	andvs	r1, r8, #35	; 0x23
     b04:	03000006 	movweq	r0, #6
     b08:	02a40381 	adceq	r0, r4, #67108866	; 0x4000002
     b0c:	23020000 	movwcs	r0, #8192	; 0x2000
     b10:	47450912 	smlaldmi	r0, r5, r2, r9
     b14:	82030052 	andhi	r0, r3, #82	; 0x52
     b18:	00043703 	andeq	r3, r4, r3, lsl #14
     b1c:	14230200 	strtne	r0, [r3], #-512	; 0x200
     b20:	00066c08 	andeq	r6, r6, r8, lsl #24
     b24:	03830300 	orreq	r0, r3, #0, 6
     b28:	000002a4 	andeq	r0, r0, r4, lsr #5
     b2c:	08162302 	ldmdaeq	r6, {r1, r8, r9, sp}
     b30:	00000101 	andeq	r0, r0, r1, lsl #2
     b34:	37038403 	strcc	r8, [r3, -r3, lsl #8]
     b38:	02000004 	andeq	r0, r0, #4
     b3c:	76081823 	strvc	r1, [r8], -r3, lsr #16
     b40:	03000006 	movweq	r0, #6
     b44:	02a40385 	adceq	r0, r4, #335544322	; 0x14000002
     b48:	23020000 	movwcs	r0, #8192	; 0x2000
     b4c:	02fc081a 	rscseq	r0, ip, #1703936	; 0x1a0000
     b50:	86030000 	strhi	r0, [r3], -r0
     b54:	00043703 	andeq	r3, r4, r3, lsl #14
     b58:	1c230200 	sfmne	f0, 4, [r3], #-0
     b5c:	00034508 	andeq	r4, r3, r8, lsl #10
     b60:	03870300 	orreq	r0, r7, #0, 6
     b64:	000002a4 	andeq	r0, r0, r4, lsr #5
     b68:	081e2302 	ldmdaeq	lr, {r1, r8, r9, sp}
     b6c:	0000028e 	andeq	r0, r0, lr, lsl #5
     b70:	37038803 	strcc	r8, [r3, -r3, lsl #16]
     b74:	02000004 	andeq	r0, r0, #4
     b78:	8a082023 	bhi	208c0c <vector_table-0x7df73f4>
     b7c:	03000006 	movweq	r0, #6
     b80:	02a40389 	adceq	r0, r4, #603979778	; 0x24000002
     b84:	23020000 	movwcs	r0, #8192	; 0x2000
     b88:	4e430922 	cdpmi	9, 4, cr0, cr3, cr2, {1}
     b8c:	8a030054 	bhi	c0ce4 <vector_table-0x7f3f31c>
     b90:	00041603 	andeq	r1, r4, r3, lsl #12
     b94:	24230200 	strtcs	r0, [r3], #-512	; 0x200
     b98:	43535009 	cmpmi	r3, #9
     b9c:	038b0300 	orreq	r0, fp, #0, 6
     ba0:	00000437 	andeq	r0, r0, r7, lsr r4
     ba4:	08282302 	stmdaeq	r8!, {r1, r8, r9, sp}
     ba8:	00000694 	muleq	r0, r4, r6
     bac:	a4038c03 	strge	r8, [r3], #-3075	; 0xc03
     bb0:	02000002 	andeq	r0, r0, #2
     bb4:	41092a23 	tstmi	r9, r3, lsr #20
     bb8:	03005252 	movweq	r5, #594	; 0x252
     bbc:	0416038d 	ldreq	r0, [r6], #-909	; 0x38d
     bc0:	23020000 	movwcs	r0, #8192	; 0x2000
     bc4:	4352092c 	cmpmi	r2, #44, 18	; 0xb0000
     bc8:	8e030052 	mcrhi	0, 0, r0, cr3, cr2, {2}
     bcc:	00043703 	andeq	r3, r4, r3, lsl #14
     bd0:	30230200 	eorcc	r0, r3, r0, lsl #4
     bd4:	00086708 	andeq	r6, r8, r8, lsl #14
     bd8:	038f0300 	orreq	r0, pc, #0, 6
     bdc:	000002a4 	andeq	r0, r0, r4, lsr #5
     be0:	08322302 	ldmdaeq	r2!, {r1, r8, r9, sp}
     be4:	000002d1 	ldrdeq	r0, [r0], -r1
     be8:	16039003 	strne	r9, [r3], -r3
     bec:	02000004 	andeq	r0, r0, #4
     bf0:	d4083423 	strle	r3, [r8], #-1059	; 0x423
     bf4:	03000004 	movweq	r0, #4
     bf8:	04160391 	ldreq	r0, [r6], #-913	; 0x391
     bfc:	23020000 	movwcs	r0, #8192	; 0x2000
     c00:	02dc0838 	sbcseq	r0, ip, #56, 16	; 0x380000
     c04:	92030000 	andls	r0, r3, #0
     c08:	00041603 	andeq	r1, r4, r3, lsl #12
     c0c:	3c230200 	sfmcc	f0, 4, [r3], #-0
     c10:	0004d908 	andeq	sp, r4, r8, lsl #18
     c14:	03930300 	orrseq	r0, r3, #0, 6
     c18:	00000416 	andeq	r0, r0, r6, lsl r4
     c1c:	08402302 	stmdaeq	r0, {r1, r8, r9, sp}^
     c20:	000002ac 	andeq	r0, r0, ip, lsr #5
     c24:	37039403 	strcc	r9, [r3, -r3, lsl #8]
     c28:	02000004 	andeq	r0, r0, #4
     c2c:	72084423 	andvc	r4, r8, #587202560	; 0x23000000
     c30:	03000008 	movweq	r0, #8
     c34:	02a40395 	adceq	r0, r4, #1409286146	; 0x54000002
     c38:	23020000 	movwcs	r0, #8192	; 0x2000
     c3c:	43440946 	movtmi	r0, #18758	; 0x4946
     c40:	96030052 			; <UNDEFINED> instruction: 0x96030052
     c44:	00043703 	andeq	r3, r4, r3, lsl #14
     c48:	48230200 	stmdami	r3!, {r9}
     c4c:	00087d08 	andeq	r7, r8, r8, lsl #26
     c50:	03970300 	orrseq	r0, r7, #0, 6
     c54:	000002a4 	andeq	r0, r0, r4, lsr #5
     c58:	084a2302 	stmdaeq	sl, {r1, r8, r9, sp}^
     c5c:	000006c9 	andeq	r0, r0, r9, asr #13
     c60:	37039803 	strcc	r9, [r3, -r3, lsl #16]
     c64:	02000004 	andeq	r0, r0, #4
     c68:	88084c23 	stmdahi	r8, {r0, r1, r5, sl, fp, lr}
     c6c:	03000008 	movweq	r0, #8
     c70:	02a40399 	adceq	r0, r4, #1677721602	; 0x64000002
     c74:	23020000 	movwcs	r0, #8192	; 0x2000
     c78:	524f094e 	subpl	r0, pc, #1277952	; 0x138000
     c7c:	039a0300 	orrseq	r0, sl, #0, 6
     c80:	00000437 	andeq	r0, r0, r7, lsr r4
     c84:	08502302 	ldmdaeq	r0, {r1, r8, r9, sp}^
     c88:	00000893 	muleq	r0, r3, r8
     c8c:	a4039b03 	strge	r9, [r3], #-2819	; 0xb03
     c90:	02000002 	andeq	r0, r0, #2
     c94:	0e005223 	cdpeq	2, 0, cr5, cr0, cr3, {1}
     c98:	00000282 	andeq	r0, r0, r2, lsl #5
     c9c:	cb039c03 	blgt	e7cb0 <vector_table-0x7f18350>
     ca0:	0f000006 	svceq	0x00000006
     ca4:	03a2031c 			; <UNDEFINED> instruction: 0x03a2031c
     ca8:	000009d5 	ldrdeq	r0, [r0], -r5
     cac:	00525309 	subseq	r5, r2, r9, lsl #6
     cb0:	3703a403 	strcc	sl, [r3, -r3, lsl #8]
     cb4:	02000004 	andeq	r0, r0, #4
     cb8:	3a080023 	bcc	200d4c <vector_table-0x7dff2b4>
     cbc:	03000006 	movweq	r0, #6
     cc0:	02a403a5 	adceq	r0, r4, #-1811939326	; 0x94000002
     cc4:	23020000 	movwcs	r0, #8192	; 0x2000
     cc8:	52440902 	subpl	r0, r4, #32768	; 0x8000
     ccc:	03a60300 			; <UNDEFINED> instruction: 0x03a60300
     cd0:	00000437 	andeq	r0, r0, r7, lsr r4
     cd4:	08042302 	stmdaeq	r4, {r1, r8, r9, sp}
     cd8:	00000644 	andeq	r0, r0, r4, asr #12
     cdc:	a403a703 	strge	sl, [r3], #-1795	; 0x703
     ce0:	02000002 	andeq	r0, r0, #2
     ce4:	42090623 	andmi	r0, r9, #36700160	; 0x2300000
     ce8:	03005252 	movweq	r5, #594	; 0x252
     cec:	043703a8 	ldrteq	r0, [r7], #-936	; 0x3a8
     cf0:	23020000 	movwcs	r0, #8192	; 0x2000
     cf4:	064e0808 	strbeq	r0, [lr], -r8, lsl #16
     cf8:	a9030000 	stmdbge	r3, {}	; <UNPREDICTABLE>
     cfc:	0002a403 	andeq	sl, r2, r3, lsl #8
     d00:	0a230200 	beq	8c1508 <vector_table-0x773eaf8>
     d04:	31524309 	cmpcc	r2, r9, lsl #6
     d08:	03aa0300 			; <UNDEFINED> instruction: 0x03aa0300
     d0c:	00000437 	andeq	r0, r0, r7, lsr r4
     d10:	080c2302 	stmdaeq	ip, {r1, r8, r9, sp}
     d14:	00000658 	andeq	r0, r0, r8, asr r6
     d18:	a403ab03 	strge	sl, [r3], #-2819	; 0xb03
     d1c:	02000002 	andeq	r0, r0, #2
     d20:	43090e23 	movwmi	r0, #40483	; 0x9e23
     d24:	03003252 	movweq	r3, #594	; 0x252
     d28:	043703ac 	ldrteq	r0, [r7], #-940	; 0x3ac
     d2c:	23020000 	movwcs	r0, #8192	; 0x2000
     d30:	06620810 			; <UNDEFINED> instruction: 0x06620810
     d34:	ad030000 	stcge	0, cr0, [r3, #-0]
     d38:	0002a403 	andeq	sl, r2, r3, lsl #8
     d3c:	12230200 	eorne	r0, r3, #0, 4
     d40:	33524309 	cmpcc	r2, #603979776	; 0x24000000
     d44:	03ae0300 			; <UNDEFINED> instruction: 0x03ae0300
     d48:	00000437 	andeq	r0, r0, r7, lsr r4
     d4c:	08142302 	ldmdaeq	r4, {r1, r8, r9, sp}
     d50:	0000066c 	andeq	r0, r0, ip, ror #12
     d54:	a403af03 	strge	sl, [r3], #-3843	; 0xf03
     d58:	02000002 	andeq	r0, r0, #2
     d5c:	67081623 	strvs	r1, [r8, -r3, lsr #12]
     d60:	03000002 	movweq	r0, #2
     d64:	043703b0 	ldrteq	r0, [r7], #-944	; 0x3b0
     d68:	23020000 	movwcs	r0, #8192	; 0x2000
     d6c:	06760818 			; <UNDEFINED> instruction: 0x06760818
     d70:	b1030000 	mrslt	r0, (UNDEF: 3)
     d74:	0002a403 	andeq	sl, r2, r3, lsl #8
     d78:	1a230200 	bne	8c1580 <vector_table-0x773ea80>
     d7c:	04240e00 	strteq	r0, [r4], #-3584	; 0xe00
     d80:	b2030000 	andlt	r0, r3, #0
     d84:	0008fb03 	andeq	pc, r8, r3, lsl #22
     d88:	05041000 	streq	r1, [r4, #-0]
     d8c:	000a4a09 	andeq	r4, sl, r9, lsl #20
     d90:	04320300 	ldrteq	r0, [r2], #-768	; 0x300
     d94:	03000000 	movweq	r0, #0
     d98:	00000573 	andeq	r0, r0, r3, ror r5
     d9c:	07580301 	ldrbeq	r0, [r8, -r1, lsl #6]
     da0:	03020000 	movweq	r0, #8192	; 0x2000
     da4:	00000107 	andeq	r0, r0, r7, lsl #2
     da8:	039f0303 	orrseq	r0, pc, #201326592	; 0xc000000
     dac:	03040000 	movweq	r0, #16384	; 0x4000
     db0:	00000373 	andeq	r0, r0, r3, ror r3
     db4:	061d0305 	ldreq	r0, [sp], -r5, lsl #6
     db8:	03060000 	movweq	r0, #24576	; 0x6000
     dbc:	00000447 	andeq	r0, r0, r7, asr #8
     dc0:	01d50307 	bicseq	r0, r5, r7, lsl #6
     dc4:	03080000 	movweq	r0, #32768	; 0x8000
     dc8:	00000459 	andeq	r0, r0, r9, asr r4
     dcc:	07440309 	strbeq	r0, [r4, -r9, lsl #6]
     dd0:	030a0000 	movweq	r0, #40960	; 0xa000
     dd4:	0000059a 	muleq	r0, sl, r5
     dd8:	093e030b 	ldmdbeq	lr!, {r0, r1, r3, r8, r9}
     ddc:	030c0000 	movweq	r0, #49152	; 0xc000
     de0:	00000258 	andeq	r0, r0, r8, asr r2
     de4:	04de030d 	ldrbeq	r0, [lr], #781	; 0x30d
     de8:	030e0000 	movweq	r0, #57344	; 0xe000
     dec:	0000047d 	andeq	r0, r0, sp, ror r4
     df0:	1f11000f 	svcne	0x0011000f
     df4:	02000003 	andeq	r0, r0, #3
     df8:	0301042f 	movweq	r0, #5167	; 0x142f
     dfc:	00000a65 	andeq	r0, r0, r5, ror #20
     e00:	00093912 	andeq	r3, r9, r2, lsl r9
     e04:	042f0200 	strteq	r0, [pc], #-512	; e0c <vector_table-0x7fff1f4>
     e08:	00000260 	andeq	r0, r0, r0, ror #4
     e0c:	3f011300 	svccc	0x00011300
     e10:	01000007 	tsteq	r0, r7
     e14:	0005640e 	andeq	r6, r5, lr, lsl #8
     e18:	00060408 	andeq	r0, r6, r8, lsl #8
     e1c:	007d0208 	rsbseq	r0, sp, r8, lsl #4
     e20:	00000a93 	muleq	r0, r3, sl
     e24:	000a4a14 	andeq	r4, sl, r4, lsl sl
     e28:	0005e200 	andeq	lr, r5, r0, lsl #4
     e2c:	00000008 	andeq	r0, r0, r8
     e30:	15290100 	strne	r0, [r9, #-256]!	; 0x100
     e34:	00000a58 	andeq	r0, r0, r8, asr sl
     e38:	1600001e 			; <UNDEFINED> instruction: 0x1600001e
     e3c:	000006d9 	ldrdeq	r0, [r0], -r9
     e40:	3c051a02 	stccc	10, cr1, [r5], {2}
     e44:	01000004 	tsteq	r0, r4
     e48:	020d0001 	andeq	r0, sp, #1
     e4c:	00020000 	andeq	r0, r2, r0
     e50:	00000259 	andeq	r0, r0, r9, asr r2
     e54:	006d0104 	rsbeq	r0, sp, r4, lsl #2
     e58:	9b010000 	blls	40e60 <vector_table-0x7fbf1a0>
     e5c:	ad000009 	stcge	0, cr0, [r0, #-36]	; 0xffffffdc
     e60:	04000000 	streq	r0, [r0], #-0
     e64:	2a080006 	bcs	200e84 <vector_table-0x7dff17c>
     e68:	3d080006 	stccc	0, cr0, [r8, #-24]	; 0xffffffe8
     e6c:	02000003 	andeq	r0, r0, #3
     e70:	00580801 	subseq	r0, r8, r1, lsl #16
     e74:	02020000 	andeq	r0, r2, #0
     e78:	00068005 	andeq	r8, r6, r5
     e7c:	02940300 	addseq	r0, r4, #0, 6
     e80:	07020000 	streq	r0, [r2, -r0]
     e84:	0000003e 	andeq	r0, r0, lr, lsr r0
     e88:	69050404 	stmdbvs	r5, {r2, sl}
     e8c:	0200746e 	andeq	r7, r0, #1845493760	; 0x6e000000
     e90:	05000508 	streq	r0, [r0, #-1288]	; 0x508
     e94:	01020000 	mrseq	r0, (UNDEF: 2)
     e98:	00004f08 	andeq	r4, r0, r8, lsl #30
     e9c:	05e60300 	strbeq	r0, [r6, #768]!	; 0x300
     ea0:	0b020000 	bleq	80ea8 <vector_table-0x7f7f158>
     ea4:	0000005e 	andeq	r0, r0, lr, asr r0
     ea8:	28070202 	stmdacs	r7, {r1, r9}
     eac:	03000000 	movweq	r0, #0
     eb0:	00000293 	muleq	r0, r3, r2
     eb4:	00700c02 	rsbseq	r0, r0, r2, lsl #24
     eb8:	04020000 	streq	r0, [r2], #-0
     ebc:	00033807 	andeq	r3, r3, r7, lsl #16
     ec0:	07080200 	streq	r0, [r8, -r0, lsl #4]
     ec4:	0000032e 	andeq	r0, r0, lr, lsr #6
     ec8:	00005305 	andeq	r5, r0, r5, lsl #6
     ecc:	00330500 	eorseq	r0, r3, r0, lsl #10
     ed0:	1c060000 	stcne	0, cr0, [r6], {-0}
     ed4:	6203a203 	andvs	sl, r3, #805306368	; 0x30000000
     ed8:	07000001 	streq	r0, [r0, -r1]
     edc:	03005253 	movweq	r5, #595	; 0x253
     ee0:	007e03a4 	rsbseq	r0, lr, r4, lsr #7
     ee4:	23020000 	movwcs	r0, #8192	; 0x2000
     ee8:	063a0800 	ldrteq	r0, [sl], -r0, lsl #16
     eec:	a5030000 	strge	r0, [r3, #-0]
     ef0:	00005303 	andeq	r5, r0, r3, lsl #6
     ef4:	02230200 	eoreq	r0, r3, #0, 4
     ef8:	00524407 	subseq	r4, r2, r7, lsl #8
     efc:	7e03a603 	cfmadd32vc	mvax0, mvfx10, mvfx3, mvfx3
     f00:	02000000 	andeq	r0, r0, #0
     f04:	44080423 	strmi	r0, [r8], #-1059	; 0x423
     f08:	03000006 	movweq	r0, #6
     f0c:	005303a7 	subseq	r0, r3, r7, lsr #7
     f10:	23020000 	movwcs	r0, #8192	; 0x2000
     f14:	52420706 	subpl	r0, r2, #1572864	; 0x180000
     f18:	a8030052 	stmdage	r3, {r1, r4, r6}
     f1c:	00007e03 	andeq	r7, r0, r3, lsl #28
     f20:	08230200 	stmdaeq	r3!, {r9}
     f24:	00064e08 	andeq	r4, r6, r8, lsl #28
     f28:	03a90300 			; <UNDEFINED> instruction: 0x03a90300
     f2c:	00000053 	andeq	r0, r0, r3, asr r0
     f30:	070a2302 	streq	r2, [sl, -r2, lsl #6]
     f34:	00315243 	eorseq	r5, r1, r3, asr #4
     f38:	7e03aa03 	vmlavc.f32	s20, s6, s6
     f3c:	02000000 	andeq	r0, r0, #0
     f40:	58080c23 	stmdapl	r8, {r0, r1, r5, sl, fp}
     f44:	03000006 	movweq	r0, #6
     f48:	005303ab 	subseq	r0, r3, fp, lsr #7
     f4c:	23020000 	movwcs	r0, #8192	; 0x2000
     f50:	5243070e 	subpl	r0, r3, #3670016	; 0x380000
     f54:	ac030032 	stcge	0, cr0, [r3], {50}	; 0x32
     f58:	00007e03 	andeq	r7, r0, r3, lsl #28
     f5c:	10230200 	eorne	r0, r3, r0, lsl #4
     f60:	00066208 	andeq	r6, r6, r8, lsl #4
     f64:	03ad0300 			; <UNDEFINED> instruction: 0x03ad0300
     f68:	00000053 	andeq	r0, r0, r3, asr r0
     f6c:	07122302 	ldreq	r2, [r2, -r2, lsl #6]
     f70:	00335243 	eorseq	r5, r3, r3, asr #4
     f74:	7e03ae03 	cdpvc	14, 0, cr10, cr3, cr3, {0}
     f78:	02000000 	andeq	r0, r0, #0
     f7c:	6c081423 	cfstrsvs	mvf1, [r8], {35}	; 0x23
     f80:	03000006 	movweq	r0, #6
     f84:	005303af 	subseq	r0, r3, pc, lsr #7
     f88:	23020000 	movwcs	r0, #8192	; 0x2000
     f8c:	02670816 	rsbeq	r0, r7, #1441792	; 0x160000
     f90:	b0030000 	andlt	r0, r3, r0
     f94:	00007e03 	andeq	r7, r0, r3, lsl #28
     f98:	18230200 	stmdane	r3!, {r9}
     f9c:	00067608 	andeq	r7, r6, r8, lsl #12
     fa0:	03b10300 			; <UNDEFINED> instruction: 0x03b10300
     fa4:	00000053 	andeq	r0, r0, r3, asr r0
     fa8:	001a2302 	andseq	r2, sl, r2, lsl #6
     fac:	00042409 	andeq	r2, r4, r9, lsl #8
     fb0:	03b20300 			; <UNDEFINED> instruction: 0x03b20300
     fb4:	00000088 	andeq	r0, r0, r8, lsl #1
     fb8:	0979010a 	ldmdbeq	r9!, {r1, r3, r8}^
     fbc:	0b010000 	bleq	40fc4 <vector_table-0x7fbf03c>
     fc0:	01930101 	orrseq	r0, r3, r1, lsl #2
     fc4:	950b0000 	strls	r0, [fp, #-0]
     fc8:	01000009 	tsteq	r0, r9
     fcc:	0001930b 	andeq	r9, r1, fp, lsl #6
     fd0:	09850b00 	stmibeq	r5, {r8, r9, fp}
     fd4:	0b010000 	bleq	40fdc <vector_table-0x7fbf024>
     fd8:	00000025 	andeq	r0, r0, r5, lsr #32
     fdc:	62040c00 	andvs	r0, r4, #0, 24
     fe0:	0d000001 	stceq	0, cr0, [r0, #-4]
     fe4:	0000016e 	andeq	r0, r0, lr, ror #2
     fe8:	08000604 	stmdaeq	r0, {r2, r9, sl}
     fec:	0800060e 	stmdaeq	r0, {r1, r2, r3, r9, sl}
     ff0:	bc007d02 	stclt	13, cr7, [r0], {2}
     ff4:	0e000001 	cdpeq	0, 0, cr0, cr0, cr1, {0}
     ff8:	0000017c 	andeq	r0, r0, ip, ror r1
     ffc:	870e5001 	strhi	r5, [lr, -r1]
    1000:	01000001 	tsteq	r0, r1
    1004:	010f0051 	qaddeq	r0, r1, pc	; <UNPREDICTABLE>
    1008:	0000098a 	andeq	r0, r0, sl, lsl #19
    100c:	10011001 	andne	r1, r1, r1
    1010:	2a080006 	bcs	201030 <vector_table-0x7dfefd0>
    1014:	02080006 	andeq	r0, r8, #6
    1018:	0202007d 	andeq	r0, r2, #125	; 0x7d
    101c:	85100000 	ldrhi	r0, [r0, #-0]
    1020:	01000009 	tsteq	r0, r9
    1024:	00004c10 	andeq	r4, r0, r0, lsl ip
    1028:	11500100 	cmpne	r0, r0, lsl #2
    102c:	0000016e 	andeq	r0, r0, lr, ror #2
    1030:	08000610 	stmdaeq	r0, {r4, r9, sl}
    1034:	08000628 	stmdaeq	r0, {r3, r5, r9, sl}
    1038:	870e1101 	strhi	r1, [lr, -r1, lsl #2]
    103c:	01000001 	tsteq	r0, r1
    1040:	017c1250 	cmneq	ip, r0, asr r2
    1044:	10000000 	andne	r0, r0, r0
    1048:	00004001 	andeq	r4, r0, r1
    104c:	0006d913 	andeq	sp, r6, r3, lsl r9
    1050:	051a0400 	ldreq	r0, [sl, #-1024]	; 0x400
    1054:	00000083 	andeq	r0, r0, r3, lsl #1
    1058:	b8000101 	stmdalt	r0, {r0, r8}
    105c:	02000004 	andeq	r0, r0, #4
    1060:	00035f00 	andeq	r5, r3, r0, lsl #30
    1064:	6d010400 	cfstrsvs	mvf0, [r1, #-0]
    1068:	01000000 	mrseq	r0, (UNDEF: 0)
    106c:	00000a1d 	andeq	r0, r0, sp, lsl sl
    1070:	000000ad 	andeq	r0, r0, sp, lsr #1
    1074:	0800062c 	stmdaeq	r0, {r2, r3, r5, r9, sl}
    1078:	080006a4 	stmdaeq	r0, {r2, r5, r7, r9, sl}
    107c:	00000453 	andeq	r0, r0, r3, asr r4
    1080:	58080102 	stmdapl	r8, {r1, r8}
    1084:	02000000 	andeq	r0, r0, #0
    1088:	06800502 	streq	r0, [r0], r2, lsl #10
    108c:	94030000 	strls	r0, [r3], #-0
    1090:	02000002 	andeq	r0, r0, #2
    1094:	00003e07 	andeq	r3, r0, r7, lsl #28
    1098:	05040400 	streq	r0, [r4, #-1024]	; 0x400
    109c:	00746e69 	rsbseq	r6, r4, r9, ror #28
    10a0:	00050802 	andeq	r0, r5, r2, lsl #16
    10a4:	02000005 	andeq	r0, r0, #5
    10a8:	004f0801 	subeq	r0, pc, r1, lsl #16
    10ac:	e6030000 	str	r0, [r3], -r0
    10b0:	02000005 	andeq	r0, r0, #5
    10b4:	00005e0b 	andeq	r5, r0, fp, lsl #28
    10b8:	07020200 	streq	r0, [r2, -r0, lsl #4]
    10bc:	00000028 	andeq	r0, r0, r8, lsr #32
    10c0:	00029303 	andeq	r9, r2, r3, lsl #6
    10c4:	700c0200 	andvc	r0, ip, r0, lsl #4
    10c8:	02000000 	andeq	r0, r0, #0
    10cc:	03380704 	teqeq	r8, #4, 14	; 0x100000
    10d0:	08020000 	stmdaeq	r2, {}	; <UNPREDICTABLE>
    10d4:	00032e07 	andeq	r2, r3, r7, lsl #28
    10d8:	00650500 	rsbeq	r0, r5, r0, lsl #10
    10dc:	65060000 	strvs	r0, [r6, #-0]
    10e0:	93000000 	movwls	r0, #0
    10e4:	07000000 	streq	r0, [r0, -r0]
    10e8:	00000070 	andeq	r0, r0, r0, ror r0
    10ec:	53050001 	movwpl	r0, #20481	; 0x5001
    10f0:	05000000 	streq	r0, [r0, #-0]
    10f4:	00000033 	andeq	r0, r0, r3, lsr r0
    10f8:	9b032808 	blls	cb120 <vector_table-0x7f34ee0>
    10fc:	00013d02 	andeq	r3, r1, r2, lsl #26
    1100:	03ff0900 	mvnseq	r0, #0, 18
    1104:	9d030000 	stcls	0, cr0, [r3, #-0]
    1108:	00007e02 	andeq	r7, r0, r2, lsl #28
    110c:	00230200 	eoreq	r0, r3, r0, lsl #4
    1110:	00071909 	andeq	r1, r7, r9, lsl #18
    1114:	029e0300 	addseq	r0, lr, #0, 6
    1118:	0000007e 	andeq	r0, r0, lr, ror r0
    111c:	09042302 	stmdbeq	r4, {r1, r8, r9, sp}
    1120:	000005d1 	ldrdeq	r0, [r0], -r1
    1124:	7e029f03 	cdpvc	15, 0, cr9, cr2, cr3, {0}
    1128:	02000000 	andeq	r0, r0, #0
    112c:	b8090823 	stmdalt	r9, {r0, r1, r5, fp}
    1130:	03000003 	movweq	r0, #3
    1134:	007e02a0 	rsbseq	r0, lr, r0, lsr #5
    1138:	23020000 	movwcs	r0, #8192	; 0x2000
    113c:	44490a0c 	strbmi	r0, [r9], #-2572	; 0xa0c
    1140:	a1030052 	qaddge	r0, r2, r3
    1144:	00007e02 	andeq	r7, r0, r2, lsl #28
    1148:	10230200 	eorne	r0, r3, r0, lsl #4
    114c:	52444f0a 	subpl	r4, r4, #10, 30	; 0x28
    1150:	02a20300 	adceq	r0, r2, #0, 6
    1154:	0000007e 	andeq	r0, r0, lr, ror r0
    1158:	09142302 	ldmdbeq	r4, {r1, r8, r9, sp}
    115c:	00000803 	andeq	r0, r0, r3, lsl #16
    1160:	9302a303 	movwls	sl, #8963	; 0x2303
    1164:	02000000 	andeq	r0, r0, #0
    1168:	fd091823 	stc2	8, cr1, [r9, #-140]	; 0xffffff74
    116c:	03000007 	movweq	r0, #7
    1170:	009302a4 	addseq	r0, r3, r4, lsr #5
    1174:	23020000 	movwcs	r0, #8192	; 0x2000
    1178:	0974091a 	ldmdbeq	r4!, {r1, r3, r4, r8, fp}^
    117c:	a5030000 	strge	r0, [r3, #-0]
    1180:	00007e02 	andeq	r7, r0, r2, lsl #28
    1184:	1c230200 	sfmne	f0, 4, [r3], #-0
    1188:	5246410a 	subpl	r4, r6, #-2147483646	; 0x80000002
    118c:	02a60300 	adceq	r0, r6, #0, 6
    1190:	0000013d 	andeq	r0, r0, sp, lsr r1
    1194:	00202302 	eoreq	r2, r0, r2, lsl #6
    1198:	00008305 	andeq	r8, r0, r5, lsl #6
    119c:	079d0b00 	ldreq	r0, [sp, r0, lsl #22]
    11a0:	a7030000 	strge	r0, [r3, -r0]
    11a4:	00009d02 	andeq	r9, r0, r2, lsl #26
    11a8:	03540800 	cmpeq	r4, #0, 16
    11ac:	03720376 	cmneq	r2, #-671088639	; 0xd8000001
    11b0:	430a0000 	movwmi	r0, #40960	; 0xa000
    11b4:	03003152 	movweq	r3, #338	; 0x152
    11b8:	00930378 	addseq	r0, r3, r8, ror r3
    11bc:	23020000 	movwcs	r0, #8192	; 0x2000
    11c0:	063a0900 	ldrteq	r0, [sl], -r0, lsl #18
    11c4:	79030000 	stmdbvc	r3, {}	; <UNPREDICTABLE>
    11c8:	00005303 	andeq	r5, r0, r3, lsl #6
    11cc:	02230200 	eoreq	r0, r3, #0, 4
    11d0:	3252430a 	subscc	r4, r2, #671088640	; 0x28000000
    11d4:	037a0300 	cmneq	sl, #0, 6
    11d8:	00000093 	muleq	r0, r3, r0
    11dc:	09042302 	stmdbeq	r4, {r1, r8, r9, sp}
    11e0:	00000644 	andeq	r0, r0, r4, asr #12
    11e4:	53037b03 	movwpl	r7, #15107	; 0x3b03
    11e8:	02000000 	andeq	r0, r0, #0
    11ec:	e8090623 	stmda	r9, {r0, r1, r5, r9, sl}
    11f0:	03000004 	movweq	r0, #4
    11f4:	0093037c 	addseq	r0, r3, ip, ror r3
    11f8:	23020000 	movwcs	r0, #8192	; 0x2000
    11fc:	064e0908 	strbeq	r0, [lr], -r8, lsl #18
    1200:	7d030000 	stcvc	0, cr0, [r3, #-0]
    1204:	00005303 	andeq	r5, r0, r3, lsl #6
    1208:	0a230200 	beq	8c1a10 <vector_table-0x773e5f0>
    120c:	00041f09 	andeq	r1, r4, r9, lsl #30
    1210:	037e0300 	cmneq	lr, #0, 6
    1214:	00000093 	muleq	r0, r3, r0
    1218:	090c2302 	stmdbeq	ip, {r1, r8, r9, sp}
    121c:	00000658 	andeq	r0, r0, r8, asr r6
    1220:	53037f03 	movwpl	r7, #16131	; 0x3f03
    1224:	02000000 	andeq	r0, r0, #0
    1228:	530a0e23 	movwpl	r0, #44579	; 0xae23
    122c:	80030052 	andhi	r0, r3, r2, asr r0
    1230:	00009303 	andeq	r9, r0, r3, lsl #6
    1234:	10230200 	eorne	r0, r3, r0, lsl #4
    1238:	00066209 	andeq	r6, r6, r9, lsl #4
    123c:	03810300 	orreq	r0, r1, #0, 6
    1240:	00000053 	andeq	r0, r0, r3, asr r0
    1244:	0a122302 	beq	489e54 <vector_table-0x7b761ac>
    1248:	00524745 	subseq	r4, r2, r5, asr #14
    124c:	93038203 	movwls	r8, #12803	; 0x3203
    1250:	02000000 	andeq	r0, r0, #0
    1254:	6c091423 	cfstrsvs	mvf1, [r9], {35}	; 0x23
    1258:	03000006 	movweq	r0, #6
    125c:	00530383 	subseq	r0, r3, r3, lsl #7
    1260:	23020000 	movwcs	r0, #8192	; 0x2000
    1264:	01010916 	tsteq	r1, r6, lsl r9
    1268:	84030000 	strhi	r0, [r3], #-0
    126c:	00009303 	andeq	r9, r0, r3, lsl #6
    1270:	18230200 	stmdane	r3!, {r9}
    1274:	00067609 	andeq	r7, r6, r9, lsl #12
    1278:	03850300 	orreq	r0, r5, #0, 6
    127c:	00000053 	andeq	r0, r0, r3, asr r0
    1280:	091a2302 	ldmdbeq	sl, {r1, r8, r9, sp}
    1284:	000002fc 	strdeq	r0, [r0], -ip
    1288:	93038603 	movwls	r8, #13827	; 0x3603
    128c:	02000000 	andeq	r0, r0, #0
    1290:	45091c23 	strmi	r1, [r9, #-3107]	; 0xc23
    1294:	03000003 	movweq	r0, #3
    1298:	00530387 	subseq	r0, r3, r7, lsl #7
    129c:	23020000 	movwcs	r0, #8192	; 0x2000
    12a0:	028e091e 	addeq	r0, lr, #491520	; 0x78000
    12a4:	88030000 	stmdahi	r3, {}	; <UNPREDICTABLE>
    12a8:	00009303 	andeq	r9, r0, r3, lsl #6
    12ac:	20230200 	eorcs	r0, r3, r0, lsl #4
    12b0:	00068a09 	andeq	r8, r6, r9, lsl #20
    12b4:	03890300 	orreq	r0, r9, #0, 6
    12b8:	00000053 	andeq	r0, r0, r3, asr r0
    12bc:	0a222302 	beq	889ecc <vector_table-0x7776134>
    12c0:	00544e43 	subseq	r4, r4, r3, asr #28
    12c4:	7e038a03 	vmlavc.f32	s16, s6, s6
    12c8:	02000000 	andeq	r0, r0, #0
    12cc:	500a2423 	andpl	r2, sl, r3, lsr #8
    12d0:	03004353 	movweq	r4, #851	; 0x353
    12d4:	0093038b 	addseq	r0, r3, fp, lsl #7
    12d8:	23020000 	movwcs	r0, #8192	; 0x2000
    12dc:	06940928 	ldreq	r0, [r4], r8, lsr #18
    12e0:	8c030000 	stchi	0, cr0, [r3], {-0}
    12e4:	00005303 	andeq	r5, r0, r3, lsl #6
    12e8:	2a230200 	bcs	8c1af0 <vector_table-0x773e510>
    12ec:	5252410a 	subspl	r4, r2, #-2147483646	; 0x80000002
    12f0:	038d0300 	orreq	r0, sp, #0, 6
    12f4:	0000007e 	andeq	r0, r0, lr, ror r0
    12f8:	0a2c2302 	beq	b09f08 <vector_table-0x74f60f8>
    12fc:	00524352 	subseq	r4, r2, r2, asr r3
    1300:	93038e03 	movwls	r8, #15875	; 0x3e03
    1304:	02000000 	andeq	r0, r0, #0
    1308:	67093023 	strvs	r3, [r9, -r3, lsr #32]
    130c:	03000008 	movweq	r0, #8
    1310:	0053038f 	subseq	r0, r3, pc, lsl #7
    1314:	23020000 	movwcs	r0, #8192	; 0x2000
    1318:	02d10932 	sbcseq	r0, r1, #819200	; 0xc8000
    131c:	90030000 	andls	r0, r3, r0
    1320:	00007e03 	andeq	r7, r0, r3, lsl #28
    1324:	34230200 	strtcc	r0, [r3], #-512	; 0x200
    1328:	0004d409 	andeq	sp, r4, r9, lsl #8
    132c:	03910300 	orrseq	r0, r1, #0, 6
    1330:	0000007e 	andeq	r0, r0, lr, ror r0
    1334:	09382302 	ldmdbeq	r8!, {r1, r8, r9, sp}
    1338:	000002dc 	ldrdeq	r0, [r0], -ip
    133c:	7e039203 	cdpvc	2, 0, cr9, cr3, cr3, {0}
    1340:	02000000 	andeq	r0, r0, #0
    1344:	d9093c23 	stmdble	r9, {r0, r1, r5, sl, fp, ip, sp}
    1348:	03000004 	movweq	r0, #4
    134c:	007e0393 			; <UNDEFINED> instruction: 0x007e0393
    1350:	23020000 	movwcs	r0, #8192	; 0x2000
    1354:	02ac0940 	adceq	r0, ip, #64, 18	; 0x100000
    1358:	94030000 	strls	r0, [r3], #-0
    135c:	00009303 	andeq	r9, r0, r3, lsl #6
    1360:	44230200 	strtmi	r0, [r3], #-512	; 0x200
    1364:	00087209 	andeq	r7, r8, r9, lsl #4
    1368:	03950300 	orrseq	r0, r5, #0, 6
    136c:	00000053 	andeq	r0, r0, r3, asr r0
    1370:	0a462302 	beq	1189f80 <vector_table-0x6e76080>
    1374:	00524344 	subseq	r4, r2, r4, asr #6
    1378:	93039603 	movwls	r9, #13827	; 0x3603
    137c:	02000000 	andeq	r0, r0, #0
    1380:	7d094823 	stcvc	8, cr4, [r9, #-140]	; 0xffffff74
    1384:	03000008 	movweq	r0, #8
    1388:	00530397 			; <UNDEFINED> instruction: 0x00530397
    138c:	23020000 	movwcs	r0, #8192	; 0x2000
    1390:	06c9094a 	strbeq	r0, [r9], sl, asr #18
    1394:	98030000 	stmdals	r3, {}	; <UNPREDICTABLE>
    1398:	00009303 	andeq	r9, r0, r3, lsl #6
    139c:	4c230200 	sfmmi	f0, 4, [r3], #-0
    13a0:	00088809 	andeq	r8, r8, r9, lsl #16
    13a4:	03990300 	orrseq	r0, r9, #0, 6
    13a8:	00000053 	andeq	r0, r0, r3, asr r0
    13ac:	0a4e2302 	beq	1389fbc <vector_table-0x6c76044>
    13b0:	0300524f 	movweq	r5, #591	; 0x24f
    13b4:	0093039a 	umullseq	r0, r3, sl, r3
    13b8:	23020000 	movwcs	r0, #8192	; 0x2000
    13bc:	08930950 	ldmeq	r3, {r4, r6, r8, fp}
    13c0:	9b030000 	blls	c13c8 <vector_table-0x7f3ec38>
    13c4:	00005303 	andeq	r5, r0, r3, lsl #6
    13c8:	52230200 	eorpl	r0, r3, #0, 4
    13cc:	02820b00 	addeq	r0, r2, #0, 22
    13d0:	9c030000 	stcls	0, cr0, [r3], {-0}
    13d4:	00014e03 	andeq	r4, r1, r3, lsl #28
    13d8:	0c010c00 	stceq	12, cr0, [r1], {-0}
    13dc:	0100000a 	tsteq	r0, sl
    13e0:	9801012d 	stmdals	r1, {r0, r2, r3, r5, r8}
    13e4:	0d000003 	stceq	0, cr0, [r0, #-12]
    13e8:	000009cb 	andeq	r0, r0, fp, asr #19
    13ec:	00702e01 	rsbseq	r2, r0, r1, lsl #28
    13f0:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    13f4:	000a2701 	andeq	r2, sl, r1, lsl #14
    13f8:	01190100 	tsteq	r9, r0, lsl #2
    13fc:	0800062c 	stmdaeq	r0, {r2, r3, r5, r9, sl}
    1400:	0800062e 	stmdaeq	r0, {r1, r2, r3, r5, r9, sl}
    1404:	0e007d02 	cdpeq	13, 0, cr7, cr0, cr2, {0}
    1408:	0009b001 	andeq	fp, r9, r1
    140c:	011d0100 	tsteq	sp, r0, lsl #2
    1410:	08000630 	stmdaeq	r0, {r4, r5, r9, sl}
    1414:	08000632 	stmdaeq	r0, {r1, r4, r5, r9, sl}
    1418:	0e007d02 	cdpeq	13, 0, cr7, cr0, cr2, {0}
    141c:	0009e701 	andeq	lr, r9, r1, lsl #14
    1420:	01210100 	teqeq	r1, r0, lsl #2
    1424:	08000634 	stmdaeq	r0, {r2, r4, r5, r9, sl}
    1428:	08000636 	stmdaeq	r0, {r1, r2, r4, r5, r9, sl}
    142c:	0e007d02 	cdpeq	13, 0, cr7, cr0, cr2, {0}
    1430:	0009fa01 	andeq	pc, r9, r1, lsl #20
    1434:	01250100 	teqeq	r5, r0, lsl #2
    1438:	08000638 	stmdaeq	r0, {r3, r4, r5, r9, sl}
    143c:	0800063a 	stmdaeq	r0, {r1, r3, r4, r5, r9, sl}
    1440:	0e007d02 	cdpeq	13, 0, cr7, cr0, cr2, {0}
    1444:	0009d301 	andeq	sp, r9, r1, lsl #6
    1448:	01290100 	teqeq	r9, r0, lsl #2
    144c:	0800063c 	stmdaeq	r0, {r2, r3, r4, r5, r9, sl}
    1450:	0800063e 	stmdaeq	r0, {r1, r2, r3, r4, r5, r9, sl}
    1454:	0e007d02 	cdpeq	13, 0, cr7, cr0, cr2, {0}
    1458:	000a3301 	andeq	r3, sl, r1, lsl #6
    145c:	01140100 	tsteq	r4, r0, lsl #2
    1460:	08000640 	stmdaeq	r0, {r6, r9, sl}
    1464:	08000644 	stmdaeq	r0, {r2, r6, r9, sl}
    1468:	0f007d02 	svceq	0x00007d02
    146c:	0000037e 	andeq	r0, r0, lr, ror r3
    1470:	08000644 	stmdaeq	r0, {r2, r6, r9, sl}
    1474:	080006a4 	stmdaeq	r0, {r2, r5, r7, r9, sl}
    1478:	00000829 	andeq	r0, r0, r9, lsr #16
    147c:	00000456 	andeq	r0, r0, r6, asr r4
    1480:	00038c10 	andeq	r8, r3, r0, lsl ip
    1484:	04030500 	streq	r0, [r3], #-1280	; 0x500
    1488:	11200000 	teqne	r0, r0
    148c:	0000037e 	andeq	r0, r0, lr, ror r3
    1490:	08000666 	stmdaeq	r0, {r1, r2, r5, r6, r9, sl}
    1494:	0800068e 	stmdaeq	r0, {r1, r2, r3, r7, r9, sl}
    1498:	66122d01 	ldrvs	r2, [r2], -r1, lsl #26
    149c:	8e080006 	cdphi	0, 0, cr0, cr8, cr6, {0}
    14a0:	10080006 	andne	r0, r8, r6
    14a4:	0000038c 	andeq	r0, r0, ip, lsl #7
    14a8:	00040305 	andeq	r0, r4, r5, lsl #6
    14ac:	00002000 	andeq	r2, r0, r0
    14b0:	06d91300 	ldrbeq	r1, [r9], r0, lsl #6
    14b4:	1a040000 	bne	1014bc <vector_table-0x7efeb44>
    14b8:	00009805 	andeq	r9, r0, r5, lsl #16
    14bc:	14010100 	strne	r0, [r1], #-256	; 0x100
    14c0:	00047001 	andeq	r7, r4, r1
    14c4:	004c1500 	subeq	r1, ip, r0, lsl #10
    14c8:	16000000 	strne	r0, [r0], -r0
    14cc:	00000012 	andeq	r0, r0, r2, lsl r0
    14d0:	047d1105 	ldrbteq	r1, [sp], #-261	; 0x105
    14d4:	01010000 	mrseq	r0, (UNDEF: 1)
    14d8:	04640417 	strbteq	r0, [r4], #-1047	; 0x417
    14dc:	c3160000 	tstgt	r6, #0
    14e0:	01000009 	tsteq	r0, r9
    14e4:	0004900d 	andeq	r9, r4, sp
    14e8:	02010100 	andeq	r0, r1, #0, 2
    14ec:	03330704 	teqeq	r3, #4, 14	; 0x100000
    14f0:	a7060000 	strge	r0, [r6, -r0]
    14f4:	a7000004 	strge	r0, [r0, -r4]
    14f8:	07000004 	streq	r0, [r0, -r4]
    14fc:	00000070 	andeq	r0, r0, r0, ror r0
    1500:	04180061 	ldreq	r0, [r8], #-97	; 0x61
    1504:	0009a319 	andeq	sl, r9, r9, lsl r3
    1508:	973d0100 	ldrls	r0, [sp, -r0, lsl #2]!
    150c:	01000004 	tsteq	r0, r4
    1510:	00000305 	andeq	r0, r0, r5, lsl #6
    1514:	b7000800 	strlt	r0, [r0, -r0, lsl #16]
    1518:	02000001 	andeq	r0, r0, #1
    151c:	00049f00 	andeq	r9, r4, r0, lsl #30
    1520:	6d010400 	cfstrsvs	mvf0, [r1, #-0]
    1524:	01000000 	mrseq	r0, (UNDEF: 0)
    1528:	00000a41 	andeq	r0, r0, r1, asr #20
    152c:	000000ad 	andeq	r0, r0, sp, lsr #1
    1530:	080006a4 	stmdaeq	r0, {r2, r5, r7, r9, sl}
    1534:	080006be 	stmdaeq	r0, {r1, r2, r3, r4, r5, r7, r9, sl}
    1538:	00000589 	andeq	r0, r0, r9, lsl #11
    153c:	58080102 	stmdapl	r8, {r1, r8}
    1540:	02000000 	andeq	r0, r0, #0
    1544:	06800502 	streq	r0, [r0], r2, lsl #10
    1548:	94030000 	strls	r0, [r3], #-0
    154c:	02000002 	andeq	r0, r0, #2
    1550:	00003e07 	andeq	r3, r0, r7, lsl #28
    1554:	05040400 	streq	r0, [r4, #-1024]	; 0x400
    1558:	00746e69 	rsbseq	r6, r4, r9, ror #28
    155c:	00050802 	andeq	r0, r5, r2, lsl #16
    1560:	02000005 	andeq	r0, r0, #5
    1564:	004f0801 	subeq	r0, pc, r1, lsl #16
    1568:	e6030000 	str	r0, [r3], -r0
    156c:	02000005 	andeq	r0, r0, #5
    1570:	00005e0b 	andeq	r5, r0, fp, lsl #28
    1574:	07020200 	streq	r0, [r2, -r0, lsl #4]
    1578:	00000028 	andeq	r0, r0, r8, lsr #32
    157c:	38070402 	stmdacc	r7, {r1, sl}
    1580:	02000003 	andeq	r0, r0, #3
    1584:	032e0708 	teqeq	lr, #8, 14	; 0x200000
    1588:	53050000 	movwpl	r0, #20480	; 0x5000
    158c:	05000000 	streq	r0, [r0, #-0]
    1590:	00000033 	andeq	r0, r0, r3, lsr r0
    1594:	a2031c06 	andge	r1, r3, #1536	; 0x600
    1598:	00015703 	andeq	r5, r1, r3, lsl #14
    159c:	52530700 	subspl	r0, r3, #0, 14
    15a0:	03a40300 			; <UNDEFINED> instruction: 0x03a40300
    15a4:	00000073 	andeq	r0, r0, r3, ror r0
    15a8:	08002302 	stmdaeq	r0, {r1, r8, r9, sp}
    15ac:	0000063a 	andeq	r0, r0, sl, lsr r6
    15b0:	5303a503 	movwpl	sl, #13571	; 0x3503
    15b4:	02000000 	andeq	r0, r0, #0
    15b8:	44070223 	strmi	r0, [r7], #-547	; 0x223
    15bc:	a6030052 			; <UNDEFINED> instruction: 0xa6030052
    15c0:	00007303 	andeq	r7, r0, r3, lsl #6
    15c4:	04230200 	strteq	r0, [r3], #-512	; 0x200
    15c8:	00064408 	andeq	r4, r6, r8, lsl #8
    15cc:	03a70300 			; <UNDEFINED> instruction: 0x03a70300
    15d0:	00000053 	andeq	r0, r0, r3, asr r0
    15d4:	07062302 	streq	r2, [r6, -r2, lsl #6]
    15d8:	00525242 	subseq	r5, r2, r2, asr #4
    15dc:	7303a803 	movwvc	sl, #14339	; 0x3803
    15e0:	02000000 	andeq	r0, r0, #0
    15e4:	4e080823 	cdpmi	8, 0, cr0, cr8, cr3, {1}
    15e8:	03000006 	movweq	r0, #6
    15ec:	005303a9 	subseq	r0, r3, r9, lsr #7
    15f0:	23020000 	movwcs	r0, #8192	; 0x2000
    15f4:	5243070a 	subpl	r0, r3, #2621440	; 0x280000
    15f8:	aa030031 	bge	c16c4 <vector_table-0x7f3e93c>
    15fc:	00007303 	andeq	r7, r0, r3, lsl #6
    1600:	0c230200 	sfmeq	f0, 4, [r3], #-0
    1604:	00065808 	andeq	r5, r6, r8, lsl #16
    1608:	03ab0300 			; <UNDEFINED> instruction: 0x03ab0300
    160c:	00000053 	andeq	r0, r0, r3, asr r0
    1610:	070e2302 	streq	r2, [lr, -r2, lsl #6]
    1614:	00325243 	eorseq	r5, r2, r3, asr #4
    1618:	7303ac03 	movwvc	sl, #15363	; 0x3c03
    161c:	02000000 	andeq	r0, r0, #0
    1620:	62081023 	andvs	r1, r8, #35	; 0x23
    1624:	03000006 	movweq	r0, #6
    1628:	005303ad 	subseq	r0, r3, sp, lsr #7
    162c:	23020000 	movwcs	r0, #8192	; 0x2000
    1630:	52430712 	subpl	r0, r3, #4718592	; 0x480000
    1634:	ae030033 	mcrge	0, 0, r0, cr3, cr3, {1}
    1638:	00007303 	andeq	r7, r0, r3, lsl #6
    163c:	14230200 	strtne	r0, [r3], #-512	; 0x200
    1640:	00066c08 	andeq	r6, r6, r8, lsl #24
    1644:	03af0300 			; <UNDEFINED> instruction: 0x03af0300
    1648:	00000053 	andeq	r0, r0, r3, asr r0
    164c:	08162302 	ldmdaeq	r6, {r1, r8, r9, sp}
    1650:	00000267 	andeq	r0, r0, r7, ror #4
    1654:	7303b003 	movwvc	fp, #12291	; 0x3003
    1658:	02000000 	andeq	r0, r0, #0
    165c:	76081823 	strvc	r1, [r8], -r3, lsr #16
    1660:	03000006 	movweq	r0, #6
    1664:	005303b1 	ldrheq	r0, [r3], #-49	; 0xffffffcf
    1668:	23020000 	movwcs	r0, #8192	; 0x2000
    166c:	2409001a 	strcs	r0, [r9], #-26
    1670:	03000004 	movweq	r0, #4
    1674:	007d03b2 	ldrhteq	r0, [sp], #-50	; 0xffffffce
    1678:	010a0000 	mrseq	r0, (UNDEF: 10)
    167c:	00000a53 	andeq	r0, r0, r3, asr sl
    1680:	a4010d01 	strge	r0, [r1], #-3329	; 0xd01
    1684:	be080006 	cdplt	0, 0, cr0, cr8, cr6, {0}
    1688:	49080006 	stmdbmi	r8, {r1, r2}
    168c:	9b000008 	blls	16b4 <vector_table-0x7ffe94c>
    1690:	0b000001 	bleq	169c <vector_table-0x7ffe964>
    1694:	00000995 	muleq	r0, r5, r9
    1698:	019b0d01 	orrseq	r0, fp, r1, lsl #26
    169c:	08690000 	stmdaeq	r9!, {}^	; <UNPREDICTABLE>
    16a0:	4c0b0000 	stcmi	0, cr0, [fp], {-0}
    16a4:	0100000a 	tsteq	r0, sl
    16a8:	0001a10d 	andeq	sl, r1, sp, lsl #2
    16ac:	00088700 	andeq	r8, r8, r0, lsl #14
    16b0:	040c0000 	streq	r0, [ip], #-0
    16b4:	00000157 	andeq	r0, r0, r7, asr r1
    16b8:	01a7040c 			; <UNDEFINED> instruction: 0x01a7040c
    16bc:	250d0000 	strcs	r0, [sp, #-0]
    16c0:	0e000000 	cdpeq	0, 0, cr0, cr0, cr0, {0}
    16c4:	000006d9 	ldrdeq	r0, [r0], -r9
    16c8:	78051a04 	stmdavc	r5, {r2, r9, fp, ip}
    16cc:	01000000 	mrseq	r0, (UNDEF: 0)
    16d0:	Address 0x00000000000016d0 is out of bounds.


Дизассемблирование раздела .debug_abbrev:

00000000 <.debug_abbrev>:
   0:	25011101 	strcs	r1, [r1, #-257]	; 0x101
   4:	030b130e 	movweq	r1, #45838	; 0xb30e
   8:	110e1b0e 	tstne	lr, lr, lsl #22
   c:	10011201 	andne	r1, r1, r1, lsl #4
  10:	02000006 	andeq	r0, r0, #6
  14:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
  18:	0b3b0b3a 	bleq	ec2d08 <vector_table-0x713d2f8>
  1c:	00001349 	andeq	r1, r0, r9, asr #6
  20:	03011303 	movweq	r1, #4867	; 0x1303
  24:	3a0b0b0e 	bcc	2c2c64 <vector_table-0x7d3d39c>
  28:	010b3b0b 	tsteq	fp, fp, lsl #22
  2c:	04000013 	streq	r0, [r0], #-19
  30:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
  34:	0a381349 	beq	e04d60 <vector_table-0x71fb2a0>
  38:	00000c34 	andeq	r0, r0, r4, lsr ip
  3c:	0b000f05 	bleq	3c58 <vector_table-0x7ffc3a8>
  40:	0600000b 	streq	r0, [r0], -fp
  44:	0c3f012e 	ldfeqs	f0, [pc], #-184	; ffffff94 <_estack+0xdffe3f98>
  48:	0b3a0e03 	bleq	e8385c <vector_table-0x717c7a4>
  4c:	0c270b3b 	stceq	11, cr0, [r7], #-236	; 0xffffff14
  50:	01120111 	tsteq	r2, r1, lsl r1
  54:	13010640 	movwne	r0, #5696	; 0x1640
  58:	05070000 	streq	r0, [r7, #-0]
  5c:	3a080300 	bcc	200c64 <vector_table-0x7dff39c>
  60:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
  64:	00060213 	andeq	r0, r6, r3, lsl r2
  68:	00240800 	eoreq	r0, r4, r0, lsl #16
  6c:	0b3e0b0b 	bleq	f82ca0 <vector_table-0x707d360>
  70:	00000e03 	andeq	r0, r0, r3, lsl #28
  74:	0b000f09 	bleq	3ca0 <vector_table-0x7ffc360>
  78:	0013490b 	andseq	r4, r3, fp, lsl #18
  7c:	00260a00 	eoreq	r0, r6, r0, lsl #20
  80:	00001349 	andeq	r1, r0, r9, asr #6
  84:	03012e0b 	movweq	r2, #7691	; 0x1e0b
  88:	3b0b3a0e 	blcc	2ce8c8 <vector_table-0x7d31738>
  8c:	110c270b 	tstne	ip, fp, lsl #14
  90:	40011201 	andmi	r1, r1, r1, lsl #4
  94:	00130106 	andseq	r0, r3, r6, lsl #2
  98:	00340c00 	eorseq	r0, r4, r0, lsl #24
  9c:	0b3a0803 	bleq	e820b0 <vector_table-0x717df50>
  a0:	13490b3b 	movtne	r0, #39739	; 0x9b3b
  a4:	00000602 	andeq	r0, r0, r2, lsl #12
  a8:	0300340d 	movweq	r3, #1037	; 0x40d
  ac:	3b0b3a08 	blcc	2ce8d4 <vector_table-0x7d3172c>
  b0:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  b4:	0e00000a 	cdpeq	0, 0, cr0, cr0, cr10, {0}
  b8:	13490101 	movtne	r0, #37121	; 0x9101
  bc:	00001301 	andeq	r1, r0, r1, lsl #6
  c0:	4900210f 	stmdbmi	r0, {r0, r1, r2, r3, r8, sp}
  c4:	000b2f13 	andeq	r2, fp, r3, lsl pc
  c8:	00051000 	andeq	r1, r5, r0
  cc:	0b3a0e03 	bleq	e838e0 <vector_table-0x717c720>
  d0:	13490b3b 	movtne	r0, #39739	; 0x9b3b
  d4:	00000602 	andeq	r0, r0, r2, lsl #12
  d8:	27011511 	smladcs	r1, r1, r5, r1
  dc:	0013010c 	andseq	r0, r3, ip, lsl #2
  e0:	00051200 	andeq	r1, r5, r0, lsl #4
  e4:	00001349 	andeq	r1, r0, r9, asr #6
  e8:	03000513 	movweq	r0, #1299	; 0x513
  ec:	3b0b3a08 	blcc	2ce914 <vector_table-0x7d316ec>
  f0:	0213490b 	andseq	r4, r3, #180224	; 0x2c000
  f4:	1400000a 	strne	r0, [r0], #-10
  f8:	00000018 	andeq	r0, r0, r8, lsl r0
  fc:	03003415 	movweq	r3, #1045	; 0x415
 100:	3b0b3a08 	blcc	2ce928 <vector_table-0x7d316d8>
 104:	0013490b 	andseq	r4, r3, fp, lsl #18
 108:	00261600 	eoreq	r1, r6, r0, lsl #12
 10c:	24170000 	ldrcs	r0, [r7], #-0
 110:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 114:	0008030b 	andeq	r0, r8, fp, lsl #6
 118:	00341800 	eorseq	r1, r4, r0, lsl #16
 11c:	0b3a0e03 	bleq	e83930 <vector_table-0x717c6d0>
 120:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 124:	00000a02 	andeq	r0, r0, r2, lsl #20
 128:	03003419 	movweq	r3, #1049	; 0x419
 12c:	3b0b3a0e 	blcc	2ce96c <vector_table-0x7d31694>
 130:	3f13490b 	svccc	0x0013490b
 134:	000a020c 	andeq	r0, sl, ip, lsl #4
 138:	11010000 	mrsne	r0, (UNDEF: 1)
 13c:	130e2501 	movwne	r2, #58625	; 0xe501
 140:	1b0e030b 	blne	380d74 <vector_table-0x7c7f28c>
 144:	1201110e 	andne	r1, r1, #-2147483645	; 0x80000003
 148:	00061001 	andeq	r1, r6, r1
 14c:	01040200 	mrseq	r0, R12_usr
 150:	0b0b0e03 	bleq	2c3964 <vector_table-0x7d3c69c>
 154:	0b3b0b3a 	bleq	ec2e44 <vector_table-0x713d1bc>
 158:	00001301 	andeq	r1, r0, r1, lsl #6
 15c:	03002803 	movweq	r2, #2051	; 0x803
 160:	000d1c0e 	andeq	r1, sp, lr, lsl #24
 164:	00160400 	andseq	r0, r6, r0, lsl #8
 168:	0b3a0e03 	bleq	e8397c <vector_table-0x717c684>
 16c:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 170:	24050000 	strcs	r0, [r5], #-0
 174:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 178:	000e030b 	andeq	r0, lr, fp, lsl #6
 17c:	00240600 	eoreq	r0, r4, r0, lsl #12
 180:	0b3e0b0b 	bleq	f82db4 <vector_table-0x707d24c>
 184:	00000803 	andeq	r0, r0, r3, lsl #16
 188:	0b011307 	bleq	44dac <vector_table-0x7fbb254>
 18c:	3b0b3a05 	blcc	2ce9a8 <vector_table-0x7d31658>
 190:	00130105 	andseq	r0, r3, r5, lsl #2
 194:	000d0800 	andeq	r0, sp, r0, lsl #16
 198:	0b3a0e03 	bleq	e839ac <vector_table-0x717c654>
 19c:	1349053b 	movtne	r0, #38203	; 0x953b
 1a0:	00000a38 	andeq	r0, r0, r8, lsr sl
 1a4:	03000d09 	movweq	r0, #3337	; 0xd09
 1a8:	3b0b3a08 	blcc	2ce9d0 <vector_table-0x7d31630>
 1ac:	38134905 	ldmdacc	r3, {r0, r2, r8, fp, lr}
 1b0:	0a00000a 	beq	1e0 <vector_table-0x7fffe20>
 1b4:	13490101 	movtne	r0, #37121	; 0x9101
 1b8:	00001301 	andeq	r1, r0, r1, lsl #6
 1bc:	4900210b 	stmdbmi	r0, {r0, r1, r3, r8, sp}
 1c0:	000b2f13 	andeq	r2, fp, r3, lsl pc
 1c4:	00350c00 	eorseq	r0, r5, r0, lsl #24
 1c8:	00001349 	andeq	r1, r0, r9, asr #6
 1cc:	4900210d 	stmdbmi	r0, {r0, r2, r3, r8, sp}
 1d0:	00052f13 	andeq	r2, r5, r3, lsl pc
 1d4:	00160e00 	andseq	r0, r6, r0, lsl #28
 1d8:	0b3a0e03 	bleq	e839ec <vector_table-0x717c614>
 1dc:	1349053b 	movtne	r0, #38203	; 0x953b
 1e0:	130f0000 	movwne	r0, #61440	; 0xf000
 1e4:	3a0b0b01 	bcc	2c2df0 <vector_table-0x7d3d210>
 1e8:	01053b0b 	tsteq	r5, fp, lsl #22
 1ec:	10000013 	andne	r0, r0, r3, lsl r0
 1f0:	0b0b0104 	bleq	2c0608 <vector_table-0x7d3f9f8>
 1f4:	0b3b0b3a 	bleq	ec2ee4 <vector_table-0x713d11c>
 1f8:	00001301 	andeq	r1, r0, r1, lsl #6
 1fc:	03012e11 	movweq	r2, #7697	; 0x1e11
 200:	3b0b3a0e 	blcc	2cea40 <vector_table-0x7d315c0>
 204:	200c2705 	andcs	r2, ip, r5, lsl #14
 208:	0013010b 	andseq	r0, r3, fp, lsl #2
 20c:	00051200 	andeq	r1, r5, r0, lsl #4
 210:	0b3a0e03 	bleq	e83a24 <vector_table-0x717c5dc>
 214:	1349053b 	movtne	r0, #38203	; 0x953b
 218:	2e130000 	cdpcs	0, 1, cr0, cr3, cr0, {0}
 21c:	030c3f01 	movweq	r3, #52993	; 0xcf01
 220:	3b0b3a0e 	blcc	2cea60 <vector_table-0x7d315a0>
 224:	1201110b 	andne	r1, r1, #-1073741822	; 0xc0000002
 228:	010a4001 	tsteq	sl, r1
 22c:	14000013 	strne	r0, [r0], #-19
 230:	1331011d 	teqne	r1, #1073741831	; 0x40000007
 234:	06550152 			; <UNDEFINED> instruction: 0x06550152
 238:	0b590b58 	bleq	1642fa0 <vector_table-0x69bd060>
 23c:	05150000 	ldreq	r0, [r5, #-0]
 240:	1c133100 	ldfnes	f3, [r3], {-0}
 244:	1600000b 	strne	r0, [r0], -fp
 248:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 24c:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 250:	0c3f1349 	ldceq	3, cr1, [pc], #-292	; 134 <vector_table-0x7fffecc>
 254:	00000c3c 	andeq	r0, r0, ip, lsr ip
 258:	01110100 	tsteq	r1, r0, lsl #2
 25c:	0b130e25 	bleq	4c3af8 <vector_table-0x7b3c508>
 260:	0e1b0e03 	cdpeq	14, 1, cr0, cr11, cr3, {0}
 264:	01120111 	tsteq	r2, r1, lsl r1
 268:	00000610 	andeq	r0, r0, r0, lsl r6
 26c:	0b002402 	bleq	927c <vector_table-0x7ff6d84>
 270:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 274:	0300000e 	movweq	r0, #14
 278:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 27c:	0b3b0b3a 	bleq	ec2f6c <vector_table-0x713d094>
 280:	00001349 	andeq	r1, r0, r9, asr #6
 284:	0b002404 	bleq	929c <vector_table-0x7ff6d64>
 288:	030b3e0b 	movweq	r3, #48651	; 0xbe0b
 28c:	05000008 	streq	r0, [r0, #-8]
 290:	13490035 	movtne	r0, #36917	; 0x9035
 294:	13060000 	movwne	r0, #24576	; 0x6000
 298:	3a0b0b01 	bcc	2c2ea4 <vector_table-0x7d3d15c>
 29c:	01053b0b 	tsteq	r5, fp, lsl #22
 2a0:	07000013 	smladeq	r0, r3, r0, r0
 2a4:	0803000d 	stmdaeq	r3, {r0, r2, r3}
 2a8:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 2ac:	0a381349 	beq	e04fd8 <vector_table-0x71fb028>
 2b0:	0d080000 	stceq	0, cr0, [r8, #-0]
 2b4:	3a0e0300 	bcc	380ebc <vector_table-0x7c7f144>
 2b8:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 2bc:	000a3813 	andeq	r3, sl, r3, lsl r8
 2c0:	00160900 	andseq	r0, r6, r0, lsl #18
 2c4:	0b3a0e03 	bleq	e83ad8 <vector_table-0x717c528>
 2c8:	1349053b 	movtne	r0, #38203	; 0x953b
 2cc:	2e0a0000 	cdpcs	0, 0, cr0, cr10, cr0, {0}
 2d0:	030c3f01 	movweq	r3, #52993	; 0xcf01
 2d4:	3b0b3a0e 	blcc	2ceb14 <vector_table-0x7d314ec>
 2d8:	200c270b 	andcs	r2, ip, fp, lsl #14
 2dc:	0013010b 	andseq	r0, r3, fp, lsl #2
 2e0:	00050b00 	andeq	r0, r5, r0, lsl #22
 2e4:	0b3a0e03 	bleq	e83af8 <vector_table-0x717c508>
 2e8:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 2ec:	0f0c0000 	svceq	0x000c0000
 2f0:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 2f4:	0d000013 	stceq	0, cr0, [r0, #-76]	; 0xffffffb4
 2f8:	1331012e 	teqne	r1, #-2147483637	; 0x8000000b
 2fc:	01120111 	tsteq	r2, r1, lsl r1
 300:	13010a40 	movwne	r0, #6720	; 0x1a40
 304:	050e0000 	streq	r0, [lr, #-0]
 308:	02133100 	andseq	r3, r3, #0, 2
 30c:	0f00000a 	svceq	0x0000000a
 310:	0c3f012e 	ldfeqs	f0, [pc], #-184	; 260 <vector_table-0x7fffda0>
 314:	0b3a0e03 	bleq	e83b28 <vector_table-0x717c4d8>
 318:	0c270b3b 	stceq	11, cr0, [r7], #-236	; 0xffffff14
 31c:	01120111 	tsteq	r2, r1, lsl r1
 320:	13010a40 	movwne	r0, #6720	; 0x1a40
 324:	05100000 	ldreq	r0, [r0, #-0]
 328:	3a0e0300 	bcc	380f30 <vector_table-0x7c7f0d0>
 32c:	490b3b0b 	stmdbmi	fp, {r0, r1, r3, r8, r9, fp, ip, sp}
 330:	000a0213 	andeq	r0, sl, r3, lsl r2
 334:	011d1100 	tsteq	sp, r0, lsl #2
 338:	01111331 	tsteq	r1, r1, lsr r3
 33c:	0b580112 	bleq	160078c <vector_table-0x69ff874>
 340:	00000b59 	andeq	r0, r0, r9, asr fp
 344:	31000512 	tstcc	r0, r2, lsl r5
 348:	00061c13 	andeq	r1, r6, r3, lsl ip
 34c:	00341300 	eorseq	r1, r4, r0, lsl #6
 350:	0b3a0e03 	bleq	e83b64 <vector_table-0x717c49c>
 354:	1349053b 	movtne	r0, #38203	; 0x953b
 358:	0c3c0c3f 	ldceq	12, cr0, [ip], #-252	; 0xffffff04
 35c:	01000000 	mrseq	r0, (UNDEF: 0)
 360:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 364:	0e030b13 	vmoveq.32	d3[0], r0
 368:	01110e1b 	tsteq	r1, fp, lsl lr
 36c:	06100112 			; <UNDEFINED> instruction: 0x06100112
 370:	24020000 	strcs	r0, [r2], #-0
 374:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 378:	000e030b 	andeq	r0, lr, fp, lsl #6
 37c:	00160300 	andseq	r0, r6, r0, lsl #6
 380:	0b3a0e03 	bleq	e83b94 <vector_table-0x717c46c>
 384:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 388:	24040000 	strcs	r0, [r4], #-0
 38c:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 390:	0008030b 	andeq	r0, r8, fp, lsl #6
 394:	00350500 	eorseq	r0, r5, r0, lsl #10
 398:	00001349 	andeq	r1, r0, r9, asr #6
 39c:	49010106 	stmdbmi	r1, {r1, r2, r8}
 3a0:	00130113 	andseq	r0, r3, r3, lsl r1
 3a4:	00210700 	eoreq	r0, r1, r0, lsl #14
 3a8:	0b2f1349 	bleq	bc50d4 <vector_table-0x743af2c>
 3ac:	13080000 	movwne	r0, #32768	; 0x8000
 3b0:	3a0b0b01 	bcc	2c2fbc <vector_table-0x7d3d044>
 3b4:	01053b0b 	tsteq	r5, fp, lsl #22
 3b8:	09000013 	stmdbeq	r0, {r0, r1, r4}
 3bc:	0e03000d 	cdpeq	0, 0, cr0, cr3, cr13, {0}
 3c0:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 3c4:	0a381349 	beq	e050f0 <vector_table-0x71faf10>
 3c8:	0d0a0000 	stceq	0, cr0, [sl, #-0]
 3cc:	3a080300 	bcc	200fd4 <vector_table-0x7dff02c>
 3d0:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 3d4:	000a3813 	andeq	r3, sl, r3, lsl r8
 3d8:	00160b00 	andseq	r0, r6, r0, lsl #22
 3dc:	0b3a0e03 	bleq	e83bf0 <vector_table-0x717c410>
 3e0:	1349053b 	movtne	r0, #38203	; 0x953b
 3e4:	2e0c0000 	cdpcs	0, 0, cr0, cr12, cr0, {0}
 3e8:	030c3f01 	movweq	r3, #52993	; 0xcf01
 3ec:	3b0b3a0e 	blcc	2cec2c <vector_table-0x7d313d4>
 3f0:	200c270b 	andcs	r2, ip, fp, lsl #14
 3f4:	0013010b 	andseq	r0, r3, fp, lsl #2
 3f8:	00340d00 	eorseq	r0, r4, r0, lsl #26
 3fc:	0b3a0e03 	bleq	e83c10 <vector_table-0x717c3f0>
 400:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 404:	2e0e0000 	cdpcs	0, 0, cr0, cr14, cr0, {0}
 408:	030c3f00 	movweq	r3, #52992	; 0xcf00
 40c:	3b0b3a0e 	blcc	2cec4c <vector_table-0x7d313b4>
 410:	110c270b 	tstne	ip, fp, lsl #14
 414:	40011201 	andmi	r1, r1, r1, lsl #4
 418:	0f00000a 	svceq	0x0000000a
 41c:	1331012e 	teqne	r1, #-2147483637	; 0x8000000b
 420:	01120111 	tsteq	r2, r1, lsl r1
 424:	13010640 	movwne	r0, #5696	; 0x1640
 428:	34100000 	ldrcc	r0, [r0], #-0
 42c:	02133100 	andseq	r3, r3, #0, 2
 430:	1100000a 	tstne	r0, sl
 434:	1331011d 	teqne	r1, #1073741831	; 0x40000007
 438:	01120111 	tsteq	r2, r1, lsl r1
 43c:	0b590b58 	bleq	16431a4 <vector_table-0x69bce5c>
 440:	0b120000 	bleq	480448 <vector_table-0x7b7fbb8>
 444:	12011101 	andne	r1, r1, #1073741824	; 0x40000000
 448:	13000001 	movwne	r0, #1
 44c:	0e030034 	mcreq	0, 0, r0, cr3, cr4, {1}
 450:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 454:	0c3f1349 	ldceq	3, cr1, [pc], #-292	; 338 <vector_table-0x7fffcc8>
 458:	00000c3c 	andeq	r0, r0, ip, lsr ip
 45c:	27011514 	smladcs	r1, r4, r5, r1
 460:	0013010c 	andseq	r0, r3, ip, lsl #2
 464:	00051500 	andeq	r1, r5, r0, lsl #10
 468:	00001349 	andeq	r1, r0, r9, asr #6
 46c:	03003416 	movweq	r3, #1046	; 0x416
 470:	3b0b3a0e 	blcc	2cecb0 <vector_table-0x7d31350>
 474:	3f13490b 	svccc	0x0013490b
 478:	000c3c0c 	andeq	r3, ip, ip, lsl #24
 47c:	000f1700 	andeq	r1, pc, r0, lsl #14
 480:	13490b0b 	movtne	r0, #39691	; 0x9b0b
 484:	0f180000 	svceq	0x00180000
 488:	000b0b00 	andeq	r0, fp, r0, lsl #22
 48c:	00341900 	eorseq	r1, r4, r0, lsl #18
 490:	0b3a0e03 	bleq	e83ca4 <vector_table-0x717c35c>
 494:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 498:	0a020c3f 	beq	8359c <vector_table-0x7f7ca64>
 49c:	01000000 	mrseq	r0, (UNDEF: 0)
 4a0:	0e250111 	mcreq	1, 1, r0, cr5, cr1, {0}
 4a4:	0e030b13 	vmoveq.32	d3[0], r0
 4a8:	01110e1b 	tsteq	r1, fp, lsl lr
 4ac:	06100112 			; <UNDEFINED> instruction: 0x06100112
 4b0:	24020000 	strcs	r0, [r2], #-0
 4b4:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 4b8:	000e030b 	andeq	r0, lr, fp, lsl #6
 4bc:	00160300 	andseq	r0, r6, r0, lsl #6
 4c0:	0b3a0e03 	bleq	e83cd4 <vector_table-0x717c32c>
 4c4:	13490b3b 	movtne	r0, #39739	; 0x9b3b
 4c8:	24040000 	strcs	r0, [r4], #-0
 4cc:	3e0b0b00 	vmlacc.f64	d0, d11, d0
 4d0:	0008030b 	andeq	r0, r8, fp, lsl #6
 4d4:	00350500 	eorseq	r0, r5, r0, lsl #10
 4d8:	00001349 	andeq	r1, r0, r9, asr #6
 4dc:	0b011306 	bleq	450fc <vector_table-0x7fbaf04>
 4e0:	3b0b3a0b 	blcc	2ced14 <vector_table-0x7d312ec>
 4e4:	00130105 	andseq	r0, r3, r5, lsl #2
 4e8:	000d0700 	andeq	r0, sp, r0, lsl #14
 4ec:	0b3a0803 	bleq	e82500 <vector_table-0x717db00>
 4f0:	1349053b 	movtne	r0, #38203	; 0x953b
 4f4:	00000a38 	andeq	r0, r0, r8, lsr sl
 4f8:	03000d08 	movweq	r0, #3336	; 0xd08
 4fc:	3b0b3a0e 	blcc	2ced3c <vector_table-0x7d312c4>
 500:	38134905 	ldmdacc	r3, {r0, r2, r8, fp, lr}
 504:	0900000a 	stmdbeq	r0, {r1, r3}
 508:	0e030016 	mcreq	0, 0, r0, cr3, cr6, {0}
 50c:	053b0b3a 	ldreq	r0, [fp, #-2874]!	; 0xb3a
 510:	00001349 	andeq	r1, r0, r9, asr #6
 514:	3f012e0a 	svccc	0x00012e0a
 518:	3a0e030c 	bcc	381150 <vector_table-0x7c7eeb0>
 51c:	270b3b0b 	strcs	r3, [fp, -fp, lsl #22]
 520:	1201110c 	andne	r1, r1, #12, 2
 524:	01064001 	tsteq	r6, r1
 528:	0b000013 	bleq	57c <vector_table-0x7fffa84>
 52c:	0e030005 	cdpeq	0, 0, cr0, cr3, cr5, {0}
 530:	0b3b0b3a 	bleq	ec3220 <vector_table-0x713cde0>
 534:	06021349 	streq	r1, [r2], -r9, asr #6
 538:	0f0c0000 	svceq	0x000c0000
 53c:	490b0b00 	stmdbmi	fp, {r8, r9, fp}
 540:	0d000013 	stceq	0, cr0, [r0, #-76]	; 0xffffffb4
 544:	13490026 	movtne	r0, #36902	; 0x9026
 548:	340e0000 	strcc	r0, [lr], #-0
 54c:	3a0e0300 	bcc	381154 <vector_table-0x7c7eeac>
 550:	49053b0b 	stmdbmi	r5, {r0, r1, r3, r8, r9, fp, ip, sp}
 554:	3c0c3f13 	stccc	15, cr3, [ip], {19}
 558:	0000000c 	andeq	r0, r0, ip

Дизассемблирование раздела .debug_loc:

00000000 <.debug_loc>:
   0:	00000000 	andeq	r0, r0, r0
   4:	00000004 	andeq	r0, r0, r4
   8:	007d0002 	rsbseq	r0, sp, r2
   c:	00000004 	andeq	r0, r0, r4
  10:	00000020 	andeq	r0, r0, r0, lsr #32
  14:	087d0002 	ldmdaeq	sp!, {r1}^
	...
  24:	00000008 	andeq	r0, r0, r8
  28:	14500001 	ldrbne	r0, [r0], #-1
  2c:	16000000 	strne	r0, [r0], -r0
  30:	01000000 	mrseq	r0, (UNDEF: 0)
  34:	00005000 	andeq	r5, r0, r0
  38:	00000000 	andeq	r0, r0, r0
  3c:	00200000 	eoreq	r0, r0, r0
  40:	00220000 	eoreq	r0, r2, r0
  44:	00020000 	andeq	r0, r2, r0
  48:	0022007d 	eoreq	r0, r2, sp, ror r0
  4c:	00360000 	eorseq	r0, r6, r0
  50:	00020000 	andeq	r0, r2, r0
  54:	0000087d 	andeq	r0, r0, sp, ror r8
  58:	00000000 	andeq	r0, r0, r0
  5c:	00200000 	eoreq	r0, r0, r0
  60:	00260000 	eoreq	r0, r6, r0
  64:	00010000 	andeq	r0, r1, r0
  68:	00002650 	andeq	r2, r0, r0, asr r6
  6c:	00002800 	andeq	r2, r0, r0, lsl #16
  70:	54000100 	strpl	r0, [r0], #-256	; 0x100
	...
  7c:	00000038 	andeq	r0, r0, r8, lsr r0
  80:	0000003c 	andeq	r0, r0, ip, lsr r0
  84:	007d0002 	rsbseq	r0, sp, r2
  88:	0000003c 	andeq	r0, r0, ip, lsr r0
  8c:	00000040 	andeq	r0, r0, r0, asr #32
  90:	247d0002 	ldrbtcs	r0, [sp], #-2
  94:	00000040 	andeq	r0, r0, r0, asr #32
  98:	00000288 	andeq	r0, r0, r8, lsl #5
  9c:	387d0002 	ldmdacc	sp!, {r1}^
	...
  a8:	00000038 	andeq	r0, r0, r8, lsr r0
  ac:	00000046 	andeq	r0, r0, r6, asr #32
  b0:	46500001 	ldrbmi	r0, [r0], -r1
  b4:	48000000 	stmdami	r0, {}	; <UNPREDICTABLE>
  b8:	01000000 	mrseq	r0, (UNDEF: 0)
  bc:	00485400 	subeq	r5, r8, r0, lsl #8
  c0:	004a0000 	subeq	r0, sl, r0
  c4:	00030000 	andeq	r0, r3, r0
  c8:	549f0174 	ldrpl	r0, [pc], #372	; d0 <vector_table-0x7ffff30>
  cc:	56000000 	strpl	r0, [r0], -r0
  d0:	01000000 	mrseq	r0, (UNDEF: 0)
  d4:	00565400 	subseq	r5, r6, r0, lsl #8
  d8:	005a0000 	subseq	r0, sl, r0
  dc:	00030000 	andeq	r0, r3, r0
  e0:	629f0174 	addsvs	r0, pc, #116, 2
  e4:	70000000 	andvc	r0, r0, r0
  e8:	03000000 	movweq	r0, #0
  ec:	9f027400 	svcls	0x00027400
  f0:	00000070 	andeq	r0, r0, r0, ror r0
  f4:	00000082 	andeq	r0, r0, r2, lsl #1
  f8:	82540001 	subshi	r0, r4, #1
  fc:	8e000000 	cdphi	0, 0, cr0, cr0, cr0, {0}
 100:	01000000 	mrseq	r0, (UNDEF: 0)
 104:	008e5200 	addeq	r5, lr, r0, lsl #4
 108:	009a0000 	addseq	r0, sl, r0
 10c:	00010000 	andeq	r0, r1, r0
 110:	00009a54 	andeq	r9, r0, r4, asr sl
 114:	00009c00 	andeq	r9, r0, r0, lsl #24
 118:	52000100 	andpl	r0, r0, #0, 2
 11c:	0000009c 	muleq	r0, ip, r0
 120:	000000b6 	strheq	r0, [r0], -r6
 124:	b6540001 	ldrblt	r0, [r4], -r1
 128:	ba000000 	blt	130 <vector_table-0x7fffed0>
 12c:	03000000 	movweq	r0, #0
 130:	9f7f7400 	svcls	0x007f7400
 134:	000000ba 	strheq	r0, [r0], -sl
 138:	00000272 	andeq	r0, r0, r2, ror r2
 13c:	72540001 	subsvc	r0, r4, #1
 140:	78000002 	stmdavc	r0, {r1}
 144:	03000002 	movweq	r0, #2
 148:	9f027400 	svcls	0x00027400
 14c:	00000278 	andeq	r0, r0, r8, ror r2
 150:	0000027a 	andeq	r0, r0, sl, ror r2
 154:	7a540001 	bvc	1500160 <vector_table-0x6affea0>
 158:	80000002 	andhi	r0, r0, r2
 15c:	03000002 	movweq	r0, #2
 160:	9f027400 	svcls	0x00027400
 164:	00000280 	andeq	r0, r0, r0, lsl #5
 168:	00000288 	andeq	r0, r0, r8, lsl #5
 16c:	00540001 	subseq	r0, r4, r1
 170:	00000000 	andeq	r0, r0, r0
 174:	38000000 	stmdacc	r0, {}	; <UNPREDICTABLE>
 178:	42000000 	andmi	r0, r0, #0
 17c:	01000000 	mrseq	r0, (UNDEF: 0)
 180:	00425100 	subeq	r5, r2, r0, lsl #2
 184:	00460000 	subeq	r0, r6, r0
 188:	00030000 	andeq	r0, r3, r0
 18c:	46049351 			; <UNDEFINED> instruction: 0x46049351
 190:	53000000 	movwpl	r0, #0
 194:	03000000 	movweq	r0, #0
 198:	04935a00 	ldreq	r5, [r3], #2560	; 0xa00
 19c:	00000054 	andeq	r0, r0, r4, asr r0
 1a0:	0000005a 	andeq	r0, r0, sl, asr r0
 1a4:	935a0003 	cmpls	sl, #3
 1a8:	00005a04 	andeq	r5, r0, r4, lsl #20
 1ac:	00009400 	andeq	r9, r0, r0, lsl #8
 1b0:	51000100 	mrspl	r0, (UNDEF: 16)
 1b4:	0000009c 	muleq	r0, ip, r0
 1b8:	000000c6 	andeq	r0, r0, r6, asr #1
 1bc:	14510001 	ldrbne	r0, [r1], #-1
 1c0:	18000001 	stmdane	r0, {r0}
 1c4:	05000001 	streq	r0, [r0, #-1]
 1c8:	9f7c7a00 	svcls	0x007c7a00
 1cc:	01ca0493 			; <UNDEFINED> instruction: 0x01ca0493
 1d0:	01d80000 	bicseq	r0, r8, r0
 1d4:	00030000 	andeq	r0, r3, r0
 1d8:	d804935a 	stmdale	r4, {r1, r3, r4, r6, r8, r9, ip, pc}
 1dc:	34000001 	strcc	r0, [r0], #-1
 1e0:	03000002 	movweq	r0, #2
 1e4:	04935a00 	ldreq	r5, [r3], #2560	; 0xa00
 1e8:	00000234 	andeq	r0, r0, r4, lsr r2
 1ec:	00000238 	andeq	r0, r0, r8, lsr r2
 1f0:	7c7a0005 	ldclvc	0, cr0, [sl], #-20	; 0xffffffec
 1f4:	3804939f 	stmdacc	r4, {r0, r1, r2, r3, r4, r7, r8, r9, ip, pc}
 1f8:	6c000002 	stcvs	0, cr0, [r0], {2}
 1fc:	03000002 	movweq	r0, #2
 200:	04935a00 	ldreq	r5, [r3], #2560	; 0xa00
 204:	0000026c 	andeq	r0, r0, ip, ror #4
 208:	00000272 	andeq	r0, r0, r2, ror r2
 20c:	935a0003 	cmpls	sl, #3
 210:	00027204 	andeq	r7, r2, r4, lsl #4
 214:	00028200 	andeq	r8, r2, r0, lsl #4
 218:	5a000300 	bpl	e20 <vector_table-0x7fff1e0>
 21c:	02820493 	addeq	r0, r2, #-1828716544	; 0x93000000
 220:	02880000 	addeq	r0, r8, #0
 224:	00030000 	andeq	r0, r3, r0
 228:	0004935a 	andeq	r9, r4, sl, asr r3
 22c:	00000000 	andeq	r0, r0, r0
 230:	06000000 	streq	r0, [r0], -r0
 234:	0a000001 	beq	240 <vector_table-0x7fffdc0>
 238:	02000001 	andeq	r0, r0, #1
 23c:	0a9f4000 	beq	fe7d0244 <_estack+0xde7b4248>
 240:	91000001 	tstls	r0, r1
 244:	01000001 	tsteq	r0, r1
 248:	02305c00 	eorseq	r5, r0, #0, 24
 24c:	02520000 	subseq	r0, r2, #0
 250:	00010000 	andeq	r0, r1, r0
 254:	0000005c 	andeq	r0, r0, ip, asr r0
 258:	00000000 	andeq	r0, r0, r0
 25c:	00011e00 	andeq	r1, r1, r0, lsl #28
 260:	00012400 	andeq	r2, r1, r0, lsl #8
 264:	30000200 	andcc	r0, r0, r0, lsl #4
 268:	0001249f 	muleq	r1, pc, r4	; <UNPREDICTABLE>
 26c:	00012600 	andeq	r2, r1, r0, lsl #12
 270:	55000100 	strpl	r0, [r0, #-256]	; 0x100
 274:	00000126 	andeq	r0, r0, r6, lsr #2
 278:	0000014c 	andeq	r0, r0, ip, asr #2
 27c:	4c5e0001 	mrrcmi	0, 0, r0, lr, cr1
 280:	68000001 	stmdavs	r0, {r0}
 284:	01000001 	tsteq	r0, r1
 288:	01705500 	cmneq	r0, r0, lsl #10
 28c:	01ca0000 	biceq	r0, sl, r0
 290:	00010000 	andeq	r0, r1, r0
 294:	00000055 	andeq	r0, r0, r5, asr r0
 298:	00000000 	andeq	r0, r0, r0
 29c:	00017000 	andeq	r7, r1, r0
 2a0:	00018800 	andeq	r8, r1, r0, lsl #16
 2a4:	55000100 	strpl	r0, [r0, #-256]	; 0x100
 2a8:	00000188 	andeq	r0, r0, r8, lsl #3
 2ac:	00000196 	muleq	r0, r6, r1
 2b0:	a8570001 	ldmdage	r7, {r0}^
 2b4:	b6000001 	strlt	r0, [r0], -r1
 2b8:	01000001 	tsteq	r0, r1
 2bc:	01b65700 			; <UNDEFINED> instruction: 0x01b65700
 2c0:	01bc0000 			; <UNDEFINED> instruction: 0x01bc0000
 2c4:	00030000 	andeq	r0, r3, r0
 2c8:	d89f0177 	ldmle	pc, {r0, r1, r2, r4, r5, r6, r8}	; <UNPREDICTABLE>
 2cc:	de000001 	cdple	0, 0, cr0, cr0, cr1, {0}
 2d0:	02000001 	andeq	r0, r0, #1
 2d4:	e49f3000 	ldr	r3, [pc], #0	; 2dc <vector_table-0x7fffd24>
 2d8:	ee000001 	cdp	0, 0, cr0, cr0, cr1, {0}
 2dc:	01000001 	tsteq	r0, r1
 2e0:	01ee5700 	mvneq	r5, r0, lsl #14
 2e4:	01fa0000 	mvnseq	r0, r0
 2e8:	00010000 	andeq	r0, r1, r0
 2ec:	0001fa55 	andeq	pc, r1, r5, asr sl	; <UNPREDICTABLE>
 2f0:	00020200 	andeq	r0, r2, r0, lsl #4
 2f4:	57000100 	strpl	r0, [r0, -r0, lsl #2]
 2f8:	00000202 	andeq	r0, r0, r2, lsl #4
 2fc:	00000204 	andeq	r0, r0, r4, lsl #4
 300:	04550001 	ldrbeq	r0, [r5], #-1
 304:	10000002 	andne	r0, r0, r2
 308:	01000002 	tsteq	r0, r2
 30c:	02105700 	andseq	r5, r0, #0, 14
 310:	02160000 	andseq	r0, r6, #0
 314:	00010000 	andeq	r0, r1, r0
 318:	00021655 	andeq	r1, r2, r5, asr r6
 31c:	00021800 	andeq	r1, r2, r0, lsl #16
 320:	53000100 	movwpl	r0, #256	; 0x100
 324:	00000218 	andeq	r0, r0, r8, lsl r2
 328:	00000220 	andeq	r0, r0, r0, lsr #4
 32c:	20550001 	subscs	r0, r5, r1
 330:	26000002 	strcs	r0, [r0], -r2
 334:	01000002 	tsteq	r0, r2
 338:	02825300 	addeq	r5, r2, #0, 6
 33c:	02860000 	addeq	r0, r6, #0
 340:	00010000 	andeq	r0, r1, r0
 344:	00028655 	andeq	r8, r2, r5, asr r6
 348:	00028800 	andeq	r8, r2, r0, lsl #16
 34c:	57000100 	strpl	r0, [r0, -r0, lsl #2]
	...
 358:	00000072 	andeq	r0, r0, r2, ror r0
 35c:	00000082 	andeq	r0, r0, r2, lsl #1
 360:	9f300002 	svcls	0x00300002
 364:	00000090 	muleq	r0, r0, r0
 368:	0000009c 	muleq	r0, ip, r0
 36c:	00560001 	subseq	r0, r6, r1
 370:	00000000 	andeq	r0, r0, r0
 374:	60000000 	andvs	r0, r0, r0
 378:	72000000 	andvc	r0, r0, #0
 37c:	02000000 	andeq	r0, r0, #0
 380:	729f3000 	addsvc	r3, pc, #0
 384:	80000000 	andhi	r0, r0, r0
 388:	01000001 	tsteq	r0, r1
 38c:	01ca5300 	biceq	r5, sl, r0, lsl #6
 390:	01f70000 	mvnseq	r0, r0
 394:	00010000 	andeq	r0, r1, r0
 398:	00022653 	andeq	r2, r2, r3, asr r6
 39c:	00025b00 	andeq	r5, r2, r0, lsl #22
 3a0:	53000100 	movwpl	r0, #256	; 0x100
 3a4:	0000025e 	andeq	r0, r0, lr, asr r2
 3a8:	0000026f 	andeq	r0, r0, pc, ror #4
 3ac:	72530001 	subsvc	r0, r3, #1
 3b0:	7a000002 	bvc	3c0 <vector_table-0x7fffc40>
 3b4:	02000002 	andeq	r0, r0, #2
 3b8:	7a9f3100 	bvc	fe7cc7c0 <_estack+0xde7b07c4>
 3bc:	82000002 	andhi	r0, r0, #2
 3c0:	02000002 	andeq	r0, r0, #2
 3c4:	829f3200 	addshi	r3, pc, #0, 4
 3c8:	88000002 	stmdahi	r0, {r1}
 3cc:	01000002 	tsteq	r0, r2
 3d0:	00005300 	andeq	r5, r0, r0, lsl #6
 3d4:	00000000 	andeq	r0, r0, r0
 3d8:	011e0000 	tsteq	lr, r0
 3dc:	01340000 	teqeq	r4, r0
 3e0:	00010000 	andeq	r0, r1, r0
 3e4:	00013457 	andeq	r3, r1, r7, asr r4
 3e8:	00014400 	andeq	r4, r1, r0, lsl #8
 3ec:	51000100 	mrspl	r0, (UNDEF: 16)
 3f0:	00000144 	andeq	r0, r0, r4, asr #2
 3f4:	00000184 	andeq	r0, r0, r4, lsl #3
 3f8:	38570001 	ldmdacc	r7, {r0}^
 3fc:	52000002 	andpl	r0, r0, #2
 400:	01000002 	tsteq	r0, r2
 404:	00005700 	andeq	r5, r0, r0, lsl #14
 408:	00000000 	andeq	r0, r0, r0
 40c:	00480000 	subeq	r0, r8, r0
 410:	004a0000 	subeq	r0, sl, r0
 414:	00010000 	andeq	r0, r1, r0
 418:	00005650 	andeq	r5, r0, r0, asr r6
 41c:	00005a00 	andeq	r5, r0, r0, lsl #20
 420:	50000100 	andpl	r0, r0, r0, lsl #2
 424:	00000062 	andeq	r0, r0, r2, rrx
 428:	00000082 	andeq	r0, r0, r2, lsl #1
 42c:	90500001 	subsls	r0, r0, r1
 430:	9c000000 	stcls	0, cr0, [r0], {-0}
 434:	01000000 	mrseq	r0, (UNDEF: 0)
 438:	00ba5000 	adcseq	r5, sl, r0
 43c:	018e0000 	orreq	r0, lr, r0
 440:	00010000 	andeq	r0, r1, r0
 444:	0001ca50 	andeq	ip, r1, r0, asr sl
 448:	0001f400 	andeq	pc, r1, r0, lsl #8
 44c:	50000100 	andpl	r0, r0, r0, lsl #2
 450:	00000226 	andeq	r0, r0, r6, lsr #4
 454:	0000025b 	andeq	r0, r0, fp, asr r2
 458:	5e500001 	cdppl	0, 5, cr0, cr0, cr1, {0}
 45c:	68000002 	stmdavs	r0, {r1}
 460:	01000002 	tsteq	r0, r2
 464:	02725000 	rsbseq	r5, r2, #0
 468:	02880000 	addeq	r0, r8, #0
 46c:	00010000 	andeq	r0, r1, r0
 470:	00000050 	andeq	r0, r0, r0, asr r0
 474:	00000000 	andeq	r0, r0, r0
 478:	0000be00 	andeq	fp, r0, r0, lsl #28
 47c:	0000c800 	andeq	ip, r0, r0, lsl #16
 480:	50000100 	andpl	r0, r0, r0, lsl #2
 484:	000000c8 	andeq	r0, r0, r8, asr #1
 488:	0000011e 	andeq	r0, r0, lr, lsl r1
 48c:	24510001 	ldrbcs	r0, [r1], #-1
 490:	26000001 	strcs	r0, [r0], -r1
 494:	03000001 	movweq	r0, #1
 498:	9f507200 	svcls	0x00507200
 49c:	00000130 	andeq	r0, r0, r0, lsr r1
 4a0:	00000140 	andeq	r0, r0, r0, asr #2
 4a4:	42520001 	subsmi	r0, r2, #1
 4a8:	4e000001 	cdpmi	0, 0, cr0, cr0, cr1, {0}
 4ac:	01000001 	tsteq	r0, r1
 4b0:	014e5200 	mrseq	r5, SPSR_fiq
 4b4:	01620000 	cmneq	r2, r0
 4b8:	00030000 	andeq	r0, r3, r0
 4bc:	7e9f5072 	mrcvc	0, 4, r5, cr15, cr2, {3}
 4c0:	ca000001 	bgt	4cc <vector_table-0x7fffb34>
 4c4:	01000001 	tsteq	r0, r1
 4c8:	01ca5900 	biceq	r5, sl, r0, lsl #18
 4cc:	01de0000 	bicseq	r0, lr, r0
 4d0:	00010000 	andeq	r0, r1, r0
 4d4:	00022651 	andeq	r2, r2, r1, asr r6
 4d8:	00023e00 	andeq	r3, r2, r0, lsl #28
 4dc:	51000100 	mrspl	r0, (UNDEF: 16)
 4e0:	0000023e 	andeq	r0, r0, lr, lsr r2
 4e4:	00000252 	andeq	r0, r0, r2, asr r2
 4e8:	c4750004 	ldrbtgt	r0, [r5], #-4
 4ec:	02529f00 	subseq	r9, r2, #0, 30
 4f0:	025b0000 	subseq	r0, fp, #0
 4f4:	00010000 	andeq	r0, r1, r0
 4f8:	00025e51 	andeq	r5, r2, r1, asr lr
 4fc:	00026f00 	andeq	r6, r2, r0, lsl #30
 500:	51000100 	mrspl	r0, (UNDEF: 16)
	...
 50c:	000001d8 	ldrdeq	r0, [r0], -r8
 510:	000001f7 	strdeq	r0, [r0], -r7
 514:	7c7a0002 	ldclvc	0, cr0, [sl], #-8
 518:	000001f7 	strdeq	r0, [r0], -r7
 51c:	00000226 	andeq	r0, r0, r6, lsr #4
 520:	82580001 	subshi	r0, r8, #1
 524:	88000002 	stmdahi	r0, {r1}
 528:	01000002 	tsteq	r0, r2
 52c:	00005800 	andeq	r5, r0, r0, lsl #16
 530:	00000000 	andeq	r0, r0, r0
 534:	02880000 	addeq	r0, r8, #0
 538:	028a0000 	addeq	r0, sl, #0
 53c:	00020000 	andeq	r0, r2, r0
 540:	028a007d 	addeq	r0, sl, #125	; 0x7d
 544:	02ac0000 	adceq	r0, ip, #0
 548:	00020000 	andeq	r0, r2, r0
 54c:	0000107d 	andeq	r1, r0, sp, ror r0
 550:	00000000 	andeq	r0, r0, r0
 554:	02880000 	addeq	r0, r8, #0
 558:	02920000 	addseq	r0, r2, #0
 55c:	00010000 	andeq	r0, r1, r0
 560:	00029250 	andeq	r9, r2, r0, asr r2
 564:	00029600 	andeq	r9, r2, r0, lsl #12
 568:	03000500 	movweq	r0, #1280	; 0x500
 56c:	20000008 	andcs	r0, r0, r8
	...
 578:	00000288 	andeq	r0, r0, r8, lsl #5
 57c:	00000296 	muleq	r0, r6, r2
 580:	00510001 	subseq	r0, r1, r1
 584:	00000000 	andeq	r0, r0, r0
 588:	8e000000 	cdphi	0, 0, cr0, cr0, cr0, {0}
 58c:	96000002 	strls	r0, [r0], -r2
 590:	05000002 	streq	r0, [r0, #-2]
 594:	00080300 	andeq	r0, r8, r0, lsl #6
 598:	02962000 	addseq	r2, r6, #0
 59c:	02ac0000 	adceq	r0, ip, #0
 5a0:	00010000 	andeq	r0, r1, r0
 5a4:	00000056 	andeq	r0, r0, r6, asr r0
 5a8:	00000000 	andeq	r0, r0, r0
 5ac:	0002ac00 	andeq	sl, r2, r0, lsl #24
 5b0:	0002ae00 	andeq	sl, r2, r0, lsl #28
 5b4:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 5b8:	0002ae00 	andeq	sl, r2, r0, lsl #28
 5bc:	0002b000 	andeq	fp, r2, r0
 5c0:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 5c4:	0002b010 	andeq	fp, r2, r0, lsl r0
 5c8:	0002b200 	andeq	fp, r2, r0, lsl #4
 5cc:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 5d0:	0002b214 	andeq	fp, r2, r4, lsl r2
 5d4:	0002c800 	andeq	ip, r2, r0, lsl #16
 5d8:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 5dc:	00000020 	andeq	r0, r0, r0, lsr #32
 5e0:	00000000 	andeq	r0, r0, r0
 5e4:	0002c800 	andeq	ip, r2, r0, lsl #16
 5e8:	0002ca00 	andeq	ip, r2, r0, lsl #20
 5ec:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 5f0:	0002ca00 	andeq	ip, r2, r0, lsl #20
 5f4:	0002cc00 	andeq	ip, r2, r0, lsl #24
 5f8:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 5fc:	0002cc0c 	andeq	ip, r2, ip, lsl #24
 600:	0002ce00 	andeq	ip, r2, r0, lsl #28
 604:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 608:	0002ce18 	andeq	ip, r2, r8, lsl lr
 60c:	0002fc00 	andeq	pc, r2, r0, lsl #24
 610:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 614:	00000020 	andeq	r0, r0, r0, lsr #32
 618:	00000000 	andeq	r0, r0, r0
 61c:	0002c800 	andeq	ip, r2, r0, lsl #16
 620:	0002e200 	andeq	lr, r2, r0, lsl #4
 624:	50000100 	andpl	r0, r0, r0, lsl #2
 628:	000002e2 	andeq	r0, r0, r2, ror #5
 62c:	000002e9 	andeq	r0, r0, r9, ror #5
 630:	00520001 	subseq	r0, r2, r1
 634:	00000000 	andeq	r0, r0, r0
 638:	fc000000 	stc2	0, cr0, [r0], {-0}
 63c:	fe000002 	cdp2	0, 0, cr0, cr0, cr2, {0}
 640:	02000002 	andeq	r0, r0, #2
 644:	fe007d00 	cdp2	13, 0, cr7, cr0, cr0, {0}
 648:	00000002 	andeq	r0, r0, r2
 64c:	02000003 	andeq	r0, r0, #3
 650:	000c7d00 	andeq	r7, ip, r0, lsl #26
 654:	02000003 	andeq	r0, r0, #3
 658:	02000003 	andeq	r0, r0, #3
 65c:	021c7d00 	andseq	r7, ip, #0, 26
 660:	2c000003 	stccs	0, cr0, [r0], {3}
 664:	02000003 	andeq	r0, r0, #3
 668:	00287d00 	eoreq	r7, r8, r0, lsl #26
 66c:	00000000 	andeq	r0, r0, r0
 670:	fc000000 	stc2	0, cr0, [r0], {-0}
 674:	18000002 	stmdane	r0, {r1}
 678:	01000003 	tsteq	r0, r3
 67c:	03185000 	tsteq	r8, #0
 680:	031f0000 	tsteq	pc, #0
 684:	00010000 	andeq	r0, r1, r0
 688:	00000052 	andeq	r0, r0, r2, asr r0
 68c:	00000000 	andeq	r0, r0, r0
 690:	00031200 	andeq	r1, r3, r0, lsl #4
 694:	00031f00 	andeq	r1, r3, r0, lsl #30
 698:	03000500 	movweq	r0, #1280	; 0x500
 69c:	20000008 	andcs	r0, r0, r8
 6a0:	0000031f 	andeq	r0, r0, pc, lsl r3
 6a4:	0000032c 	andeq	r0, r0, ip, lsr #6
 6a8:	00550001 	subseq	r0, r5, r1
 6ac:	00000000 	andeq	r0, r0, r0
 6b0:	2c000000 	stccs	0, cr0, [r0], {-0}
 6b4:	2e000003 	cdpcs	0, 0, cr0, cr0, cr3, {0}
 6b8:	02000003 	andeq	r0, r0, #3
 6bc:	2e007d00 	cdpcs	13, 0, cr7, cr0, cr0, {0}
 6c0:	dc000003 	stcle	0, cr0, [r0], {3}
 6c4:	02000003 	andeq	r0, r0, #3
 6c8:	00107d00 	andseq	r7, r0, r0, lsl #26
 6cc:	00000000 	andeq	r0, r0, r0
 6d0:	2c000000 	stccs	0, cr0, [r0], {-0}
 6d4:	34000003 	strcc	r0, [r0], #-3
 6d8:	01000003 	tsteq	r0, r3
 6dc:	03345000 	teqeq	r4, #0
 6e0:	03460000 	movteq	r0, #24576	; 0x6000
 6e4:	00010000 	andeq	r0, r1, r0
 6e8:	00038c56 	andeq	r8, r3, r6, asr ip
 6ec:	0003dc00 	andeq	sp, r3, r0, lsl #24
 6f0:	56000100 	strpl	r0, [r0], -r0, lsl #2
	...
 6fc:	0000032c 	andeq	r0, r0, ip, lsr #6
 700:	00000339 	andeq	r0, r0, r9, lsr r3
 704:	00510001 	subseq	r0, r1, r1
 708:	00000000 	andeq	r0, r0, r0
 70c:	2c000000 	stccs	0, cr0, [r0], {-0}
 710:	39000003 	stmdbcc	r0, {r0, r1}
 714:	01000003 	tsteq	r0, r3
 718:	03395200 	teqeq	r9, #0, 4
 71c:	035a0000 	cmpeq	sl, #0
 720:	00010000 	andeq	r0, r1, r0
 724:	00035a55 	andeq	r5, r3, r5, asr sl
 728:	00035c00 	andeq	r5, r3, r0, lsl #24
 72c:	75000300 	strvc	r0, [r0, #-768]	; 0x300
 730:	035c9f7f 	cmpeq	ip, #508	; 0x1fc
 734:	03680000 	cmneq	r8, #0
 738:	00010000 	andeq	r0, r1, r0
 73c:	00036855 	andeq	r6, r3, r5, asr r8
 740:	00036a00 	andeq	r6, r3, r0, lsl #20
 744:	75000300 	strvc	r0, [r0, #-768]	; 0x300
 748:	036a9f7f 	cmneq	sl, #508	; 0x1fc
 74c:	03780000 	cmneq	r8, #0
 750:	00010000 	andeq	r0, r1, r0
 754:	00037855 	andeq	r7, r3, r5, asr r8
 758:	00037a00 	andeq	r7, r3, r0, lsl #20
 75c:	75000300 	strvc	r0, [r0, #-768]	; 0x300
 760:	037a9f7f 	cmneq	sl, #508	; 0x1fc
 764:	03860000 	orreq	r0, r6, #0
 768:	00010000 	andeq	r0, r1, r0
 76c:	00038655 	andeq	r8, r3, r5, asr r6
 770:	00038800 	andeq	r8, r3, r0, lsl #16
 774:	75000300 	strvc	r0, [r0, #-768]	; 0x300
 778:	03889f7f 	orreq	r9, r8, #508	; 0x1fc
 77c:	03dc0000 	bicseq	r0, ip, #0
 780:	00010000 	andeq	r0, r1, r0
 784:	00000055 	andeq	r0, r0, r5, asr r0
 788:	00000000 	andeq	r0, r0, r0
 78c:	00032c00 	andeq	r2, r3, r0, lsl #24
 790:	00033900 	andeq	r3, r3, r0, lsl #18
 794:	53000100 	movwpl	r0, #256	; 0x100
 798:	00000339 	andeq	r0, r0, r9, lsr r3
 79c:	00000346 	andeq	r0, r0, r6, asr #6
 7a0:	50540001 	subspl	r0, r4, r1
 7a4:	92000003 	andls	r0, r0, #3
 7a8:	01000003 	tsteq	r0, r3
 7ac:	03c25400 	biceq	r5, r2, #0, 8
 7b0:	03dc0000 	bicseq	r0, ip, #0
 7b4:	00010000 	andeq	r0, r1, r0
 7b8:	00000054 	andeq	r0, r0, r4, asr r0
 7bc:	00000000 	andeq	r0, r0, r0
 7c0:	00038c00 	andeq	r8, r3, r0, lsl #24
 7c4:	00039200 	andeq	r9, r3, r0, lsl #4
 7c8:	30000200 	andcc	r0, r0, r0, lsl #4
 7cc:	00039c9f 	muleq	r3, pc, ip	; <UNPREDICTABLE>
 7d0:	0003a600 	andeq	sl, r3, r0, lsl #12
 7d4:	54000100 	strpl	r0, [r0], #-256	; 0x100
 7d8:	000003a6 	andeq	r0, r0, r6, lsr #7
 7dc:	000003a8 	andeq	r0, r0, r8, lsr #7
 7e0:	9f300002 	svcls	0x00300002
 7e4:	000003bc 			; <UNDEFINED> instruction: 0x000003bc
 7e8:	000003c2 	andeq	r0, r0, r2, asr #7
 7ec:	c2540001 	subsgt	r0, r4, #1
 7f0:	dc000003 	stcle	0, cr0, [r0], {3}
 7f4:	02000003 	andeq	r0, r0, #3
 7f8:	009f3000 	addseq	r3, pc, r0
 7fc:	00000000 	andeq	r0, r0, r0
 800:	50000000 	andpl	r0, r0, r0
 804:	6e000003 	cdpvs	0, 0, cr0, cr0, cr3, {0}
 808:	01000003 	tsteq	r0, r3
 80c:	00005600 	andeq	r5, r0, r0, lsl #12
 810:	00000000 	andeq	r0, r0, r0
 814:	036e0000 	cmneq	lr, #0
 818:	038c0000 	orreq	r0, ip, #0
 81c:	00010000 	andeq	r0, r1, r0
 820:	00000056 	andeq	r0, r0, r6, asr r0
 824:	00000000 	andeq	r0, r0, r0
 828:	00001800 	andeq	r1, r0, r0, lsl #16
 82c:	00001c00 	andeq	r1, r0, r0, lsl #24
 830:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 834:	00001c00 	andeq	r1, r0, r0, lsl #24
 838:	00007800 	andeq	r7, r0, r0, lsl #16
 83c:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 840:	00000008 	andeq	r0, r0, r8
	...
 84c:	00000200 	andeq	r0, r0, r0, lsl #4
 850:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 854:	00000200 	andeq	r0, r0, r0, lsl #4
 858:	00001a00 	andeq	r1, r0, r0, lsl #20
 85c:	7d000200 	sfmvc	f0, 4, [r0, #-0]
 860:	00000010 	andeq	r0, r0, r0, lsl r0
	...
 86c:	00000a00 	andeq	r0, r0, r0, lsl #20
 870:	50000100 	andpl	r0, r0, r0, lsl #2
 874:	0000000a 	andeq	r0, r0, sl
 878:	0000001a 	andeq	r0, r0, sl, lsl r0
 87c:	00550001 	subseq	r0, r5, r1
	...
 888:	06000000 	streq	r0, [r0], -r0
 88c:	01000000 	mrseq	r0, (UNDEF: 0)
 890:	00065100 	andeq	r5, r6, r0, lsl #2
 894:	000a0000 	andeq	r0, sl, r0
 898:	00010000 	andeq	r0, r1, r0
 89c:	00000054 	andeq	r0, r0, r4, asr r0
 8a0:	00000000 	andeq	r0, r0, r0
	...

Дизассемблирование раздела .debug_aranges:

00000000 <.debug_aranges>:
   0:	0000001c 	andeq	r0, r0, ip, lsl r0
   4:	00000002 	andeq	r0, r0, r2
   8:	00040000 	andeq	r0, r4, r0
   c:	00000000 	andeq	r0, r0, r0
  10:	08000188 	stmdaeq	r0, {r3, r7, r8}
  14:	000003dc 	ldrdeq	r0, [r0], -ip
	...
  20:	0000001c 	andeq	r0, r0, ip, lsl r0
  24:	03a80002 			; <UNDEFINED> instruction: 0x03a80002
  28:	00040000 	andeq	r0, r4, r0
  2c:	00000000 	andeq	r0, r0, r0
  30:	08000564 	stmdaeq	r0, {r2, r5, r6, r8, sl}
  34:	000000a0 	andeq	r0, r0, r0, lsr #1
	...
  40:	0000001c 	andeq	r0, r0, ip, lsl r0
  44:	0e4a0002 	cdpeq	0, 4, cr0, cr10, cr2, {0}
  48:	00040000 	andeq	r0, r4, r0
  4c:	00000000 	andeq	r0, r0, r0
  50:	08000604 	stmdaeq	r0, {r2, r9, sl}
  54:	00000026 	andeq	r0, r0, r6, lsr #32
	...
  60:	0000001c 	andeq	r0, r0, ip, lsl r0
  64:	105b0002 	subsne	r0, fp, r2
  68:	00040000 	andeq	r0, r4, r0
  6c:	00000000 	andeq	r0, r0, r0
  70:	0800062c 	stmdaeq	r0, {r2, r3, r5, r9, sl}
  74:	00000078 	andeq	r0, r0, r8, ror r0
	...
  80:	0000001c 	andeq	r0, r0, ip, lsl r0
  84:	15170002 	ldrne	r0, [r7, #-2]
  88:	00040000 	andeq	r0, r4, r0
  8c:	00000000 	andeq	r0, r0, r0
  90:	080006a4 	stmdaeq	r0, {r2, r5, r7, r9, sl}
  94:	0000001a 	andeq	r0, r0, sl, lsl r0
	...

Дизассемблирование раздела .debug_line:

00000000 <.debug_line>:
   0:	000001e5 	andeq	r0, r0, r5, ror #3
   4:	00710002 	rsbseq	r0, r1, r2
   8:	01020000 	mrseq	r0, (UNDEF: 2)
   c:	000d0efb 	strdeq	r0, [sp], -fp
  10:	01010101 	tsteq	r1, r1, lsl #2
  14:	01000000 	mrseq	r0, (UNDEF: 0)
  18:	2f010000 	svccs	0x00010000
  1c:	2f727375 	svccs	0x00727375
  20:	2f62696c 	svccs	0x0062696c
  24:	2f636367 	svccs	0x00636367
  28:	2d6d7261 	sfmcs	f7, 2, [sp, #-388]!	; 0xfffffe7c
  2c:	74666f73 	strbtvc	r6, [r6], #-3955	; 0xf73
  30:	616f6c66 	cmnvs	pc, r6, ror #24
  34:	696c2d74 	stmdbvs	ip!, {r2, r4, r5, r6, r8, sl, fp, sp}^
  38:	2d78756e 	cfldr64cs	mvdx7, [r8, #-440]!	; 0xfffffe48
  3c:	65756e67 	ldrbvs	r6, [r5, #-3687]!	; 0xe67
  40:	2f696261 	svccs	0x00696261
  44:	2e362e34 	mrccs	14, 1, r2, cr6, cr4, {1}
  48:	6e692f33 	mcrvs	15, 3, r2, cr9, cr3, {1}
  4c:	64756c63 	ldrbtvs	r6, [r5], #-3171	; 0xc63
  50:	78000065 	stmdavc	r0, {r0, r2, r5, r6}
  54:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
  58:	632e6674 	teqvs	lr, #116, 12	; 0x7400000
  5c:	00000000 	andeq	r0, r0, r0
  60:	61647473 	smcvs	18243	; 0x4743
  64:	682e6772 	stmdavs	lr!, {r1, r4, r5, r6, r8, r9, sl, sp, lr}
  68:	00000100 	andeq	r0, r0, r0, lsl #2
  6c:	6975623c 	ldmdbvs	r5!, {r2, r3, r4, r5, r9, sp, lr}^
  70:	692d746c 	pushvs	{r2, r3, r5, r6, sl, ip, sp, lr}
  74:	00003e6e 	andeq	r3, r0, lr, ror #28
  78:	00000000 	andeq	r0, r0, r0
  7c:	01880205 	orreq	r0, r8, r5, lsl #4
  80:	1a030800 	bne	c2088 <vector_table-0x7f3df78>
  84:	201f1301 	andscs	r1, pc, r1, lsl #6
  88:	02002721 	andeq	r2, r0, #8650752	; 0x840000
  8c:	3c060104 	stfccs	f0, [r6], {4}
  90:	01040200 	mrseq	r0, R12_usr
  94:	3c790306 	ldclcc	3, cr0, [r9], #-24	; 0xffffffe8
  98:	20661303 	rsbcs	r1, r6, r3, lsl #6
  9c:	032d2f21 	teqeq	sp, #33, 30	; 0x84
  a0:	034a662c 	movteq	r6, #42540	; 0xa62c
  a4:	032000c0 	teqeq	r0, #192	; 0xc0
  a8:	21212e47 	teqcs	r1, r7, asr #28
  ac:	212b232c 	teqcs	fp, ip, lsr #6
  b0:	032e3e03 	teqeq	lr, #3, 28	; 0x30
  b4:	3f213c47 	svccc	0x00213c47
  b8:	09031f38 	stmdbeq	r3, {r3, r4, r5, r8, r9, sl, fp, ip}
  bc:	04020020 	streq	r0, [r2], #-32
  c0:	02008302 	andeq	r8, r0, #134217728	; 0x8000000
  c4:	00490204 	subeq	r0, r9, r4, lsl #4
  c8:	2f020402 	svccs	0x00020402
  cc:	02040200 	andeq	r0, r4, #0, 4
  d0:	4cad681f 	stcmi	8, cr6, [sp], #124	; 0x7c
  d4:	12036730 	andne	r6, r3, #48, 14	; 0xc00000
  d8:	0034c808 	eorseq	ip, r4, r8, lsl #16
  dc:	06020402 	streq	r0, [r2], -r2, lsl #8
  e0:	40410674 	submi	r0, r1, r4, ror r6
  e4:	211f591e 	tstcs	pc, lr, lsl r9	; <UNPREDICTABLE>
  e8:	01040200 	mrseq	r0, R12_usr
  ec:	68062006 	stmdavs	r6, {r1, r2, sp}
  f0:	2f573d3b 	svccs	0x00573d3b
  f4:	0075832f 	rsbseq	r8, r5, pc, lsr #6
  f8:	06010402 	streq	r0, [r1], -r2, lsl #8
  fc:	02005874 	andeq	r5, r0, #116, 16	; 0x740000
 100:	063c0204 	ldrteq	r0, [ip], -r4, lsl #4
 104:	4a7fba03 	bmi	1fee918 <vector_table-0x60116e8>
 108:	2000c603 	andcs	ip, r0, r3, lsl #12
 10c:	01040200 	mrseq	r0, R12_usr
 110:	04020021 	streq	r0, [r2], #-33	; 0x21
 114:	02007501 	andeq	r7, r0, #4194304	; 0x400000
 118:	3c060204 	sfmcc	f0, 4, [r6], {4}
 11c:	745b0306 	ldrbvc	r0, [fp], #-774	; 0x306
 120:	002f3b2f 	eoreq	r3, pc, pc, lsr #22
 124:	06020402 	streq	r0, [r2], -r2, lsl #8
 128:	0200583c 	andeq	r5, r0, #60, 16	; 0x3c0000
 12c:	21060104 	tstcs	r6, r4, lsl #2
 130:	02002e06 	andeq	r2, r0, #6, 28	; 0x60
 134:	4a2e0104 	bmi	b8054c <vector_table-0x747fab4>
 138:	02040200 	andeq	r0, r4, #0, 4
 13c:	21063c4a 	tstcs	r6, sl, asr #24
 140:	0402003d 	streq	r0, [r2], #-61	; 0x3d
 144:	064a0602 	strbeq	r0, [sl], -r2, lsl #12
 148:	03741203 	cmneq	r4, #805306368	; 0x30000000
 14c:	0b033c75 	bleq	cf328 <vector_table-0x7f30cd8>
 150:	0402002e 	streq	r0, [r2], #-46	; 0x2e
 154:	21914b06 	orrscs	r4, r1, r6, lsl #22
 158:	033c7003 	teqeq	ip, #3
 15c:	03383c09 	teqeq	r8, #2304	; 0x900
 160:	69033c79 	stmdbvs	r3, {r0, r3, r4, r5, r6, sl, fp, ip, sp}
 164:	0f034d74 	svceq	0x00034d74
 168:	7fbc034a 	svcvc	0x00bc034a
 16c:	212f243c 	teqcs	pc, ip, lsr r4	; <UNPREDICTABLE>
 170:	214c2d3d 	cmpcs	ip, sp, lsr sp
 174:	4a00e703 	bmi	39d88 <vector_table-0x7fc6278>
 178:	3021403c 	eorcc	r4, r1, ip, lsr r0
 17c:	2a403c60 	bcs	100f304 <vector_table-0x6ff0cfc>
 180:	222b3124 	eorcs	r3, fp, #36, 2
 184:	213d3121 	teqcs	sp, r1, lsr #2
 188:	29253c60 	stmdbcs	r5!, {r5, r6, sl, fp, ip, sp}
 18c:	09033733 	stmdbeq	r3, {r0, r1, r4, r5, r8, r9, sl, ip, sp}
 190:	21222b20 	teqcs	r2, r0, lsr #22
 194:	0e032131 	mcreq	1, 0, r2, cr3, cr1, {1}
 198:	03352058 	teqeq	r5, #88	; 0x58
 19c:	30272079 	eorcc	r2, r7, r9, ror r0
 1a0:	21661703 	cmncs	r6, r3, lsl #14
 1a4:	0402002d 	streq	r0, [r2], #-45	; 0x2d
 1a8:	2e750301 	cdpcs	3, 7, cr0, cr5, cr1, {0}
 1ac:	01040200 	mrseq	r0, R12_usr
 1b0:	00592d59 	subseq	r2, r9, r9, asr sp
 1b4:	41010402 	tstmi	r1, r2, lsl #8
 1b8:	01040200 	mrseq	r0, R12_usr
 1bc:	00592d59 	subseq	r2, r9, r9, asr sp
 1c0:	03010402 	movweq	r0, #5122	; 0x1402
 1c4:	2e063c70 	mcrcs	12, 0, r3, cr6, cr0, {3}
 1c8:	02040200 	andeq	r0, r4, #0, 4
 1cc:	02002106 	andeq	r2, r0, #-2147483647	; 0x80000001
 1d0:	002d0204 	eoreq	r0, sp, r4, lsl #4
 1d4:	21020402 	tstcs	r2, r2, lsl #8
 1d8:	02040200 	andeq	r0, r4, #0, 4
 1dc:	213d302d 	teqcs	sp, sp, lsr #32
 1e0:	3b81211f 	blcc	fe048664 <_estack+0xde02c668>
 1e4:	01000d02 	tsteq	r0, r2, lsl #26
 1e8:	00015001 	andeq	r5, r1, r1
 1ec:	fe000200 	cdp2	2, 0, cr0, cr0, cr0, {0}
 1f0:	02000000 	andeq	r0, r0, #0
 1f4:	0d0efb01 	vstreq	d15, [lr, #-4]
 1f8:	01010100 	mrseq	r0, (UNDEF: 17)
 1fc:	00000001 	andeq	r0, r0, r1
 200:	01000001 	tsteq	r0, r1
 204:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 208:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 20c:	2f2e2e2f 	svccs	0x002e2e2f
 210:	336d7473 	cmncc	sp, #1929379840	; 0x73000000
 214:	74732f32 	ldrbtvc	r2, [r3], #-3890	; 0xf32
 218:	6b6e696c 	blvs	1b9a7d0 <vector_table-0x6465830>
 21c:	6178652f 	cmnvs	r8, pc, lsr #10
 220:	656c706d 	strbvs	r7, [ip, #-109]!	; 0x6d
 224:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 228:	74735f73 	ldrbtvc	r5, [r3], #-3955	; 0xf73
 22c:	6e692f6d 	cdpvs	15, 6, cr2, cr9, cr13, {3}
 230:	6f632f63 	svcvs	0x00632f63
 234:	735f6572 	cmpvc	pc, #478150656	; 0x1c800000
 238:	6f707075 	svcvs	0x00707075
 23c:	2e007472 	mcrcs	4, 0, r7, cr0, cr2, {3}
 240:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 244:	2f2e2e2f 	svccs	0x002e2e2f
 248:	732f2e2e 	teqvc	pc, #736	; 0x2e0
 24c:	32336d74 	eorscc	r6, r3, #116, 26	; 0x1d00
 250:	6c74732f 	ldclvs	3, cr7, [r4], #-188	; 0xffffff44
 254:	2f6b6e69 	svccs	0x006b6e69
 258:	6d617865 	stclvs	8, cr7, [r1, #-404]!	; 0xfffffe6c
 25c:	2f656c70 	svccs	0x00656c70
 260:	7362696c 	cmnvc	r2, #108, 18	; 0x1b0000
 264:	6d74735f 	ldclvs	3, cr7, [r4, #-380]!	; 0xfffffe84
 268:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 26c:	7665642f 	strbtvc	r6, [r5], -pc, lsr #8
 270:	5f656369 	svcpl	0x00656369
 274:	70707573 	rsbsvc	r7, r0, r3, ror r5
 278:	0074726f 	rsbseq	r7, r4, pc, ror #4
 27c:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 280:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 284:	2f2e2e2f 	svccs	0x002e2e2f
 288:	336d7473 	cmncc	sp, #1929379840	; 0x73000000
 28c:	74732f32 	ldrbtvc	r2, [r3], #-3890	; 0xf32
 290:	6b6e696c 	blvs	1b9a848 <vector_table-0x64657b8>
 294:	6178652f 	cmnvs	r8, pc, lsr #10
 298:	656c706d 	strbvs	r7, [ip, #-109]!	; 0x6d
 29c:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 2a0:	74735f73 	ldrbtvc	r5, [r3], #-3955	; 0xf73
 2a4:	6e692f6d 	cdpvs	15, 6, cr2, cr9, cr13, {3}
 2a8:	61622f63 	cmnvs	r2, r3, ror #30
 2ac:	00006573 	andeq	r6, r0, r3, ror r5
 2b0:	6b726f77 	blvs	1c9c094 <vector_table-0x6363f6c>
 2b4:	0000632e 	andeq	r6, r0, lr, lsr #6
 2b8:	6f630000 	svcvs	0x00630000
 2bc:	635f6572 	cmpvs	pc, #478150656	; 0x1c800000
 2c0:	682e346d 	stmdavs	lr!, {r0, r2, r3, r5, r6, sl, ip, sp}
 2c4:	00000100 	andeq	r0, r0, r0, lsl #2
 2c8:	336d7473 	cmncc	sp, #1929379840	; 0x73000000
 2cc:	78346632 	ldmdavc	r4!, {r1, r4, r5, r9, sl, sp, lr}
 2d0:	00682e78 	rsbeq	r2, r8, r8, ror lr
 2d4:	73000002 	movwvc	r0, #2
 2d8:	6e696474 	mcrvs	4, 3, r6, cr9, cr4, {3}
 2dc:	00682e74 	rsbeq	r2, r8, r4, ror lr
 2e0:	67000003 	strvs	r0, [r0, -r3]
 2e4:	5f6f6970 	svcpl	0x006f6970
 2e8:	682e6661 	stmdavs	lr!, {r0, r5, r6, r9, sl, sp, lr}
 2ec:	00000000 	andeq	r0, r0, r0
 2f0:	02050000 	andeq	r0, r5, #0
 2f4:	08000564 	stmdaeq	r0, {r2, r5, r6, r8, sl}
 2f8:	14010d03 	strne	r0, [r1], #-3331	; 0xd03
 2fc:	2e7a035e 	mrccs	3, 3, r0, cr10, cr14, {2}
 300:	3e2a243e 	mcrcc	4, 1, r2, cr10, cr14, {1}
 304:	223e2a24 	eorscs	r2, lr, #36, 20	; 0x24000
 308:	2a243e2c 	bcs	90fbc0 <vector_table-0x76f0440>
 30c:	3e2c223e 	mcrcc	2, 1, r2, cr12, cr14, {1}
 310:	4b2b2330 	blmi	ac8fd8 <vector_table-0x7537028>
 314:	3e4c2c22 	cdpcc	12, 4, cr2, cr12, cr2, {1}
 318:	0302043e 	movweq	r0, #9278	; 0x243e
 31c:	0420088d 	strteq	r0, [r0], #-2189	; 0x88d
 320:	77f30301 	ldrbvc	r0, [r3, r1, lsl #6]!
 324:	02044c2e 	andeq	r4, r4, #11776	; 0x2e00
 328:	20088b03 	andcs	r8, r8, r3, lsl #22
 32c:	f5030104 			; <UNDEFINED> instruction: 0xf5030104
 330:	02042e77 	andeq	r2, r4, #1904	; 0x770
 334:	4a088b03 	bmi	222f48 <vector_table-0x7ddd0b8>
 338:	01000402 	tsteq	r0, r2, lsl #8
 33c:	00011201 	andeq	r1, r1, r1, lsl #4
 340:	f2000200 	vhsub.s8	d0, d0, d0
 344:	02000000 	andeq	r0, r0, #0
 348:	0d0efb01 	vstreq	d15, [lr, #-4]
 34c:	01010100 	mrseq	r0, (UNDEF: 17)
 350:	00000001 	andeq	r0, r0, r1
 354:	01000001 	tsteq	r0, r1
 358:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 35c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 360:	2f2e2e2f 	svccs	0x002e2e2f
 364:	336d7473 	cmncc	sp, #1929379840	; 0x73000000
 368:	74732f32 	ldrbtvc	r2, [r3], #-3890	; 0xf32
 36c:	6b6e696c 	blvs	1b9a924 <vector_table-0x64656dc>
 370:	6178652f 	cmnvs	r8, pc, lsr #10
 374:	656c706d 	strbvs	r7, [ip, #-109]!	; 0x6d
 378:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 37c:	74735f73 	ldrbtvc	r5, [r3], #-3955	; 0xf73
 380:	6e692f6d 	cdpvs	15, 6, cr2, cr9, cr13, {3}
 384:	61622f63 	cmnvs	r2, r3, ror #30
 388:	2e006573 	cfrshl64cs	mvdx0, mvdx3, r6
 38c:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 390:	2f2e2e2f 	svccs	0x002e2e2f
 394:	732f2e2e 	teqvc	pc, #736	; 0x2e0
 398:	32336d74 	eorscc	r6, r3, #116, 26	; 0x1d00
 39c:	6c74732f 	ldclvs	3, cr7, [r4], #-188	; 0xffffff44
 3a0:	2f6b6e69 	svccs	0x006b6e69
 3a4:	6d617865 	stclvs	8, cr7, [r1, #-404]!	; 0xfffffe6c
 3a8:	2f656c70 	svccs	0x00656c70
 3ac:	7362696c 	cmnvc	r2, #108, 18	; 0x1b0000
 3b0:	6d74735f 	ldclvs	3, cr7, [r4, #-380]!	; 0xfffffe84
 3b4:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 3b8:	7665642f 	strbtvc	r6, [r5], -pc, lsr #8
 3bc:	5f656369 	svcpl	0x00656369
 3c0:	70707573 	rsbsvc	r7, r0, r3, ror r5
 3c4:	0074726f 	rsbseq	r7, r4, pc, ror #4
 3c8:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 3cc:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 3d0:	2f2e2e2f 	svccs	0x002e2e2f
 3d4:	336d7473 	cmncc	sp, #1929379840	; 0x73000000
 3d8:	74732f32 	ldrbtvc	r2, [r3], #-3890	; 0xf32
 3dc:	6b6e696c 	blvs	1b9a994 <vector_table-0x646566c>
 3e0:	6178652f 	cmnvs	r8, pc, lsr #10
 3e4:	656c706d 	strbvs	r7, [ip, #-109]!	; 0x6d
 3e8:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 3ec:	74735f73 	ldrbtvc	r5, [r3], #-3955	; 0xf73
 3f0:	6e692f6d 	cdpvs	15, 6, cr2, cr9, cr13, {3}
 3f4:	6f632f63 	svcvs	0x00632f63
 3f8:	735f6572 	cmpvc	pc, #478150656	; 0x1c800000
 3fc:	6f707075 	svcvs	0x00707075
 400:	00007472 	andeq	r7, r0, r2, ror r4
 404:	72617375 	rsbvc	r7, r1, #-738197503	; 0xd4000001
 408:	00632e74 	rsbeq	r2, r3, r4, ror lr
 40c:	73000000 	movwvc	r0, #0
 410:	6e696474 	mcrvs	4, 3, r6, cr9, cr4, {3}
 414:	00682e74 	rsbeq	r2, r8, r4, ror lr
 418:	73000001 	movwvc	r0, #1
 41c:	32336d74 	eorscc	r6, r3, #116, 26	; 0x1d00
 420:	78783466 	ldmdavc	r8!, {r1, r2, r5, r6, sl, ip, sp}^
 424:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 428:	6f630000 	svcvs	0x00630000
 42c:	635f6572 	cmpvs	pc, #478150656	; 0x1c800000
 430:	682e346d 	stmdavs	lr!, {r0, r2, r3, r5, r6, sl, ip, sp}
 434:	00000300 	andeq	r0, r0, r0, lsl #6
 438:	02050000 	andeq	r0, r5, #0
 43c:	08000604 	stmdaeq	r0, {r2, r9, sl}
 440:	00010a03 	andeq	r0, r1, r3, lsl #20
 444:	13010402 	movwne	r0, #5122	; 0x1402
 448:	0e30213d 	mrceq	1, 1, r2, cr0, cr13, {1}
 44c:	010225ad 	smlatbeq	r2, sp, r5, r2
 450:	32010100 	andcc	r0, r1, #0, 2
 454:	02000001 	andeq	r0, r0, #1
 458:	00010100 	andeq	r0, r1, r0, lsl #2
 45c:	fb010200 	blx	40c66 <vector_table-0x7fbf39a>
 460:	01000d0e 	tsteq	r0, lr, lsl #26
 464:	00010101 	andeq	r0, r1, r1, lsl #2
 468:	00010000 	andeq	r0, r1, r0
 46c:	2e2e0100 	sufcse	f0, f6, f0
 470:	2f2e2e2f 	svccs	0x002e2e2f
 474:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 478:	74732f2e 	ldrbtvc	r2, [r3], #-3886	; 0xf2e
 47c:	2f32336d 	svccs	0x0032336d
 480:	696c7473 	stmdbvs	ip!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 484:	652f6b6e 	strvs	r6, [pc, #-2926]!	; fffff91e <_estack+0xdffe3922>
 488:	706d6178 	rsbvc	r6, sp, r8, ror r1
 48c:	6c2f656c 	cfstr32vs	mvfx6, [pc], #-432	; 2e4 <vector_table-0x7fffd1c>
 490:	5f736269 	svcpl	0x00736269
 494:	2f6d7473 	svccs	0x006d7473
 498:	2f636e69 	svccs	0x00636e69
 49c:	65736162 	ldrbvs	r6, [r3, #-354]!	; 0x162
 4a0:	2f2e2e00 	svccs	0x002e2e00
 4a4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 4a8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 4ac:	6d74732f 	ldclvs	3, cr7, [r4, #-188]!	; 0xffffff44
 4b0:	732f3233 	teqvc	pc, #805306371	; 0x30000003
 4b4:	6e696c74 	mcrvs	12, 3, r6, cr9, cr4, {3}
 4b8:	78652f6b 	stmdavc	r5!, {r0, r1, r3, r5, r6, r8, r9, sl, fp, sp}^
 4bc:	6c706d61 	ldclvs	13, cr6, [r0], #-388	; 0xfffffe7c
 4c0:	696c2f65 	stmdbvs	ip!, {r0, r2, r5, r6, r8, r9, sl, fp, sp}^
 4c4:	735f7362 	cmpvc	pc, #-2013265919	; 0x88000001
 4c8:	692f6d74 	stmdbvs	pc!, {r2, r4, r5, r6, r8, sl, fp, sp, lr}	; <UNPREDICTABLE>
 4cc:	642f636e 	strtvs	r6, [pc], #-878	; 4d4 <vector_table-0x7fffb2c>
 4d0:	63697665 	cmnvs	r9, #105906176	; 0x6500000
 4d4:	75735f65 	ldrbvc	r5, [r3, #-3941]!	; 0xf65
 4d8:	726f7070 	rsbvc	r7, pc, #112	; 0x70
 4dc:	2e2e0074 	mcrcs	0, 1, r0, cr14, cr4, {3}
 4e0:	2f2e2e2f 	svccs	0x002e2e2f
 4e4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 4e8:	74732f2e 	ldrbtvc	r2, [r3], #-3886	; 0xf2e
 4ec:	2f32336d 	svccs	0x0032336d
 4f0:	696c7473 	stmdbvs	ip!, {r0, r1, r4, r5, r6, sl, ip, sp, lr}^
 4f4:	652f6b6e 	strvs	r6, [pc, #-2926]!	; fffff98e <_estack+0xdffe3992>
 4f8:	706d6178 	rsbvc	r6, sp, r8, ror r1
 4fc:	6c2f656c 	cfstr32vs	mvfx6, [pc], #-432	; 354 <vector_table-0x7fffcac>
 500:	5f736269 	svcpl	0x00736269
 504:	2f6d7473 	svccs	0x006d7473
 508:	2f636e69 	svccs	0x00636e69
 50c:	65726f63 	ldrbvs	r6, [r2, #-3939]!	; 0xf63
 510:	7075735f 	rsbsvc	r7, r5, pc, asr r3
 514:	74726f70 	ldrbtvc	r6, [r2], #-3952	; 0xf70
 518:	74730000 	ldrbtvc	r0, [r3], #-0
 51c:	75747261 	ldrbvc	r7, [r4, #-609]!	; 0x261
 520:	00632e70 	rsbeq	r2, r3, r0, ror lr
 524:	73000000 	movwvc	r0, #0
 528:	6e696474 	mcrvs	4, 3, r6, cr9, cr4, {3}
 52c:	00682e74 	rsbeq	r2, r8, r4, ror lr
 530:	73000001 	movwvc	r0, #1
 534:	32336d74 	eorscc	r6, r3, #116, 26	; 0x1d00
 538:	78783466 	ldmdavc	r8!, {r1, r2, r5, r6, sl, ip, sp}^
 53c:	0200682e 	andeq	r6, r0, #3014656	; 0x2e0000
 540:	6f630000 	svcvs	0x00630000
 544:	635f6572 	cmpvs	pc, #478150656	; 0x1c800000
 548:	682e346d 	stmdavs	lr!, {r0, r2, r3, r5, r6, sl, ip, sp}
 54c:	00000300 	andeq	r0, r0, r0, lsl #6
 550:	69727078 	ldmdbvs	r2!, {r3, r4, r5, r6, ip, sp, lr}^
 554:	2e66746e 	cdpcs	4, 6, cr7, cr6, cr14, {3}
 558:	00000068 	andeq	r0, r0, r8, rrx
 55c:	05000000 	streq	r0, [r0, #-0]
 560:	00062c02 	andeq	r2, r6, r2, lsl #24
 564:	01180308 	tsteq	r8, r8, lsl #6
 568:	32323232 	eorscc	r3, r2, #536870915	; 0x20000003
 56c:	152e6b03 	strne	r6, [lr, #-2819]!	; 0xb03
 570:	2e170311 	mrccs	3, 0, r0, cr7, cr1, {0}
 574:	4e221e14 	mcrmi	14, 1, r1, cr2, cr4, {0}
 578:	2f211f57 	svccs	0x00211f57
 57c:	3e1e5a30 	mrccc	10, 0, r5, cr14, cr0, {1}
 580:	7476034c 	ldrbtvc	r0, [r6], #-844	; 0x34c
 584:	01000b02 	tsteq	r0, r2, lsl #22
 588:	00011401 	andeq	r1, r1, r1, lsl #8
 58c:	f5000200 			; <UNDEFINED> instruction: 0xf5000200
 590:	02000000 	andeq	r0, r0, #0
 594:	0d0efb01 	vstreq	d15, [lr, #-4]
 598:	01010100 	mrseq	r0, (UNDEF: 17)
 59c:	00000001 	andeq	r0, r0, r1
 5a0:	01000001 	tsteq	r0, r1
 5a4:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 5a8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 5ac:	2f2e2e2f 	svccs	0x002e2e2f
 5b0:	336d7473 	cmncc	sp, #1929379840	; 0x73000000
 5b4:	74732f32 	ldrbtvc	r2, [r3], #-3890	; 0xf32
 5b8:	6b6e696c 	blvs	1b9ab70 <vector_table-0x6465490>
 5bc:	6178652f 	cmnvs	r8, pc, lsr #10
 5c0:	656c706d 	strbvs	r7, [ip, #-109]!	; 0x6d
 5c4:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 5c8:	74735f73 	ldrbtvc	r5, [r3], #-3955	; 0xf73
 5cc:	6e692f6d 	cdpvs	15, 6, cr2, cr9, cr13, {3}
 5d0:	61622f63 	cmnvs	r2, r3, ror #30
 5d4:	2e006573 	cfrshl64cs	mvdx0, mvdx3, r6
 5d8:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 5dc:	2f2e2e2f 	svccs	0x002e2e2f
 5e0:	732f2e2e 	teqvc	pc, #736	; 0x2e0
 5e4:	32336d74 	eorscc	r6, r3, #116, 26	; 0x1d00
 5e8:	6c74732f 	ldclvs	3, cr7, [r4], #-188	; 0xffffff44
 5ec:	2f6b6e69 	svccs	0x006b6e69
 5f0:	6d617865 	stclvs	8, cr7, [r1, #-404]!	; 0xfffffe6c
 5f4:	2f656c70 	svccs	0x00656c70
 5f8:	7362696c 	cmnvc	r2, #108, 18	; 0x1b0000
 5fc:	6d74735f 	ldclvs	3, cr7, [r4, #-380]!	; 0xfffffe84
 600:	636e692f 	cmnvs	lr, #770048	; 0xbc000
 604:	7665642f 	strbtvc	r6, [r5], -pc, lsr #8
 608:	5f656369 	svcpl	0x00656369
 60c:	70707573 	rsbsvc	r7, r0, r3, ror r5
 610:	0074726f 	rsbseq	r7, r4, pc, ror #4
 614:	2e2f2e2e 	cdpcs	14, 2, cr2, cr15, cr14, {1}
 618:	2e2e2f2e 	cdpcs	15, 2, cr2, cr14, cr14, {1}
 61c:	2f2e2e2f 	svccs	0x002e2e2f
 620:	336d7473 	cmncc	sp, #1929379840	; 0x73000000
 624:	74732f32 	ldrbtvc	r2, [r3], #-3890	; 0xf32
 628:	6b6e696c 	blvs	1b9abe0 <vector_table-0x6465420>
 62c:	6178652f 	cmnvs	r8, pc, lsr #10
 630:	656c706d 	strbvs	r7, [ip, #-109]!	; 0x6d
 634:	62696c2f 	rsbvs	r6, r9, #12032	; 0x2f00
 638:	74735f73 	ldrbtvc	r5, [r3], #-3955	; 0xf73
 63c:	6e692f6d 	cdpvs	15, 6, cr2, cr9, cr13, {3}
 640:	6f632f63 	svcvs	0x00632f63
 644:	735f6572 	cmpvc	pc, #478150656	; 0x1c800000
 648:	6f707075 	svcvs	0x00707075
 64c:	00007472 	andeq	r7, r0, r2, ror r4
 650:	5f727473 	svcpl	0x00727473
 654:	6c697475 	cfstrdvs	mvd7, [r9], #-468	; 0xfffffe2c
 658:	0000632e 	andeq	r6, r0, lr, lsr #6
 65c:	74730000 	ldrbtvc	r0, [r3], #-0
 660:	746e6964 	strbtvc	r6, [lr], #-2404	; 0x964
 664:	0100682e 	tsteq	r0, lr, lsr #16
 668:	74730000 	ldrbtvc	r0, [r3], #-0
 66c:	6632336d 	ldrtvs	r3, [r2], -sp, ror #6
 670:	2e787834 	mrccs	8, 3, r7, cr8, cr4, {1}
 674:	00020068 	andeq	r0, r2, r8, rrx
 678:	726f6300 	rsbvc	r6, pc, #0, 6
 67c:	6d635f65 	stclvs	15, cr5, [r3, #-404]!	; 0xfffffe6c
 680:	00682e34 	rsbeq	r2, r8, r4, lsr lr
 684:	00000003 	andeq	r0, r0, r3
 688:	a4020500 	strge	r0, [r2], #-1280	; 0x500
 68c:	03080006 	movweq	r0, #32774	; 0x8006
 690:	2120010c 	teqcs	r0, ip, lsl #2
 694:	0200211f 	andeq	r2, r0, #-1073741817	; 0xc0000007
 698:	20060204 	andcs	r0, r6, r4, lsl #4
 69c:	01000802 	tsteq	r0, r2, lsl #16
 6a0:	Address 0x00000000000006a0 is out of bounds.


Дизассемблирование раздела .debug_str:

00000000 <.debug_str>:
   0:	72707378 	rsbsvc	r7, r0, #120, 6	; 0xe0000001
   4:	66746e69 	ldrbtvs	r6, [r4], -r9, ror #28
   8:	74757000 	ldrbtvc	r7, [r5], #-0
   c:	6d75645f 	cfldrdvs	mvd6, [r5, #-380]!	; 0xfffffe84
  10:	66780070 			; <UNDEFINED> instruction: 0x66780070
  14:	5f636e75 	svcpl	0x00636e75
  18:	0074756f 	rsbseq	r7, r4, pc, ror #10
  1c:	66667562 	strbtvs	r7, [r6], -r2, ror #10
  20:	74756f00 	ldrbtvc	r6, [r5], #-3840	; 0xf00
  24:	00727470 	rsbseq	r7, r2, r0, ror r4
  28:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
  2c:	6e752074 	mrcvs	0, 3, r2, cr5, cr4, {3}
  30:	6e676973 	mcrvs	9, 3, r6, cr7, cr3, {3}
  34:	69206465 	stmdbvs	r0!, {r0, r2, r5, r6, sl, sp, lr}
  38:	6100746e 	tstvs	r0, lr, ror #8
  3c:	00726464 	rsbseq	r6, r2, r4, ror #8
  40:	74757078 	ldrbtvc	r7, [r5], #-120	; 0x78
  44:	76780063 	ldrbtvc	r0, [r8], -r3, rrx
  48:	6e697270 	mcrvs	2, 3, r7, cr9, cr0, {3}
  4c:	75006674 	strvc	r6, [r0, #-1652]	; 0x674
  50:	6769736e 	strbvs	r7, [r9, -lr, ror #6]!
  54:	2064656e 	rsbcs	r6, r4, lr, ror #10
  58:	72616863 	rsbvc	r6, r1, #6488064	; 0x630000
  5c:	765f5f00 	ldrbvc	r5, [pc], -r0, lsl #30
  60:	696c5f61 	stmdbvs	ip!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
  64:	77007473 	smlsdxvc	r0, r3, r4, r7
  68:	68746469 	ldmdavs	r4!, {r0, r3, r5, r6, sl, sp, lr}^
  6c:	554e4700 	strbpl	r4, [lr, #-1792]	; 0x700
  70:	34204320 	strtcc	r4, [r0], #-800	; 0x320
  74:	332e362e 	teqcc	lr, #48234496	; 0x2e00000
  78:	70667800 	rsbvc	r7, r6, r0, lsl #16
  7c:	746e6972 	strbtvc	r6, [lr], #-2418	; 0x972
  80:	70780066 	rsbsvc	r0, r8, r6, rrx
  84:	746e6972 	strbtvc	r6, [lr], #-2418	; 0x972
  88:	00632e66 	rsbeq	r2, r3, r6, ror #28
  8c:	6e675f5f 	mcrvs	15, 3, r5, cr7, cr15, {2}
  90:	765f6375 			; <UNDEFINED> instruction: 0x765f6375
  94:	696c5f61 	stmdbvs	ip!, {r0, r5, r6, r8, r9, sl, fp, ip, lr}^
  98:	78007473 	stmdavc	r0, {r0, r1, r4, r5, r6, sl, ip, sp, lr}
  9c:	73747570 	cmnvc	r4, #112, 10	; 0x1c000000
  a0:	70667800 	rsbvc	r7, r6, r0, lsl #16
  a4:	00737475 	rsbseq	r7, r3, r5, ror r4
  a8:	636e7566 	cmnvs	lr, #427819008	; 0x19800000
  ac:	6f682f00 	svcvs	0x00682f00
  b0:	6e2f656d 	cfsh64vs	mvdx6, mvdx15, #61
  b4:	732f7369 	teqvc	pc, #-1543503871	; 0xa4000001
  b8:	32336d74 	eorscc	r6, r3, #116, 26	; 0x1d00
  bc:	6534662f 	ldrvs	r6, [r4, #-1583]!	; 0x62f
  c0:	706d6178 	rsbvc	r6, sp, r8, ror r1
  c4:	2f73656c 	svccs	0x0073656c
  c8:	752d3630 	strvc	r3, [sp, #-1584]!	; 0x630
  cc:	74726173 	ldrbtvc	r6, [r2], #-371	; 0x173
  d0:	2d37302f 	ldccs	0, cr3, [r7, #-188]!	; 0xffffff44
  d4:	69727078 	ldmdbvs	r2!, {r3, r4, r5, r6, ip, sp, lr}^
  d8:	0066746e 	rsbeq	r7, r6, lr, ror #8
  dc:	70615f5f 	rsbvc	r5, r1, pc, asr pc
  e0:	4d434400 	cfstrdmi	mvd4, [r3, #-0]
  e4:	52495f49 	subpl	r5, r9, #292	; 0x124
  e8:	48006e51 	stmdami	r0, {r0, r4, r6, r9, sl, fp, sp, lr}
  ec:	5f485341 	svcpl	0x00485341
  f0:	5f474e52 	svcpl	0x00474e52
  f4:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
  f8:	42504100 	subsmi	r4, r0, #0, 2
  fc:	524e4531 	subpl	r4, lr, #205520896	; 0xc400000
 100:	4d434300 	stclmi	3, cr4, [r3, #-0]
 104:	47003152 	smlsdmi	r0, r2, r1, r3
 108:	5f4f4950 	svcpl	0x004f4950
 10c:	5f334641 	svcpl	0x00334641
 110:	384d4954 	stmdacc	sp, {r2, r4, r6, r8, fp, lr}^
 114:	0031315f 	eorseq	r3, r1, pc, asr r1
 118:	32425041 	subcc	r5, r2, #65	; 0x41
 11c:	4e45504c 	cdpmi	0, 4, cr5, cr5, cr12, {2}
 120:	4d440052 	stclmi	0, cr0, [r4, #-328]	; 0xfffffeb8
 124:	535f3241 	cmppl	pc, #268435460	; 0x10000004
 128:	61657274 	smcvs	22308	; 0x5724
 12c:	495f356d 	ldmdbmi	pc, {r0, r2, r3, r5, r6, r8, sl, ip, sp}^	; <UNPREDICTABLE>
 130:	006e5152 	rsbeq	r5, lr, r2, asr r1
 134:	4f494453 	svcmi	0x00494453
 138:	5152495f 	cmppl	r2, pc, asr r9
 13c:	5041006e 	subpl	r0, r1, lr, rrx
 140:	53523242 	cmppl	r2, #536870916	; 0x20000004
 144:	43005254 	movwmi	r5, #596	; 0x254
 148:	5f314e41 	svcpl	0x00314e41
 14c:	5f454353 	svcpl	0x00454353
 150:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 154:	59524300 	ldmdbpl	r2, {r8, r9, lr}^
 158:	52495f50 	subpl	r5, r9, #80, 30	; 0x140
 15c:	49006e51 	stmdbmi	r0, {r0, r4, r6, r9, sl, fp, sp, lr}
 160:	5f324332 	svcpl	0x00324332
 164:	495f5245 	ldmdbmi	pc, {r0, r2, r6, r9, ip, lr}^	; <UNPREDICTABLE>
 168:	006e5152 	rsbeq	r5, lr, r2, asr r1
 16c:	32414d44 	subcc	r4, r1, #68, 26	; 0x1100
 170:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
 174:	306d6165 	rsbcc	r6, sp, r5, ror #2
 178:	5152495f 	cmppl	r2, pc, asr r9
 17c:	4954006e 	ldmdbmi	r4, {r1, r2, r3, r5, r6}^
 180:	495f344d 	ldmdbmi	pc, {r0, r2, r3, r6, sl, ip, sp}^	; <UNPREDICTABLE>
 184:	006e5152 	rsbeq	r5, lr, r2, asr r1
 188:	5f485445 	svcpl	0x00485445
 18c:	50554b57 	subspl	r4, r5, r7, asr fp
 190:	5152495f 	cmppl	r2, pc, asr r9
 194:	4d44006e 	stclmi	0, cr0, [r4, #-440]	; 0xfffffe48
 198:	535f3141 	cmppl	pc, #1073741840	; 0x40000010
 19c:	61657274 	smcvs	22308	; 0x5724
 1a0:	495f356d 	ldmdbmi	pc, {r0, r2, r3, r5, r6, r8, sl, ip, sp}^	; <UNPREDICTABLE>
 1a4:	006e5152 	rsbeq	r5, lr, r2, asr r1
 1a8:	52434442 	subpl	r4, r3, #1107296256	; 0x42000000
 1ac:	414d4400 	cmpmi	sp, r0, lsl #8
 1b0:	74535f31 	ldrbvc	r5, [r3], #-3889	; 0xf31
 1b4:	6d616572 	cfstr64vs	mvdx6, [r1, #-456]!	; 0xfffffe38
 1b8:	52495f30 	subpl	r5, r9, #48, 30	; 0xc0
 1bc:	46006e51 			; <UNDEFINED> instruction: 0x46006e51
 1c0:	4853414c 	ldmdami	r3, {r2, r3, r6, r8, lr}^
 1c4:	5152495f 	cmppl	r2, pc, asr r9
 1c8:	5845006e 	stmdapl	r5, {r1, r2, r3, r5, r6}^
 1cc:	5f304954 	svcpl	0x00304954
 1d0:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 1d4:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
 1d8:	46415f4f 	strbmi	r5, [r1], -pc, asr #30
 1dc:	53555f38 	cmppl	r5, #56, 30	; 0xe0
 1e0:	34545241 	ldrbcc	r5, [r4], #-577	; 0x241
 1e4:	4f00365f 	svcmi	0x0000365f
 1e8:	485f4754 	ldmdami	pc, {r2, r4, r6, r8, r9, sl, lr}^	; <UNPREDICTABLE>
 1ec:	50455f53 	subpl	r5, r5, r3, asr pc
 1f0:	4e495f31 	mcrmi	15, 2, r5, cr9, cr1, {1}
 1f4:	5152495f 	cmppl	r2, pc, asr r9
 1f8:	5845006e 	stmdapl	r5, {r1, r2, r3, r5, r6}^
 1fc:	35314954 	ldrcc	r4, [r1, #-2388]!	; 0x954
 200:	5f30315f 	svcpl	0x0030315f
 204:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 208:	4d495400 	cfstrdmi	mvd5, [r9, #-0]
 20c:	52425f38 	subpl	r5, r2, #56, 30	; 0xe0
 210:	49545f4b 	ldmdbmi	r4, {r0, r1, r3, r6, r8, r9, sl, fp, ip, lr}^
 214:	5f32314d 	svcpl	0x0032314d
 218:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 21c:	42484100 	submi	r4, r8, #0, 2
 220:	45504c32 	ldrbmi	r4, [r0, #-3122]	; 0xc32
 224:	5000524e 	andpl	r5, r0, lr, asr #4
 228:	53646e65 	cmnpl	r4, #1616	; 0x650
 22c:	52495f56 	subpl	r5, r9, #344	; 0x158
 230:	4f006e51 	svcmi	0x00006e51
 234:	465f4754 			; <UNDEFINED> instruction: 0x465f4754
 238:	4b575f53 	blmi	15d7f8c <vector_table-0x6a28074>
 23c:	495f5055 	ldmdbmi	pc, {r0, r2, r4, r6, ip, lr}^	; <UNPREDICTABLE>
 240:	006e5152 	rsbeq	r5, lr, r2, asr r1
 244:	54524155 	ldrbpl	r4, [r2], #-341	; 0x155
 248:	52495f34 	subpl	r5, r9, #52, 30	; 0xd0
 24c:	52006e51 	andpl	r6, r0, #1296	; 0x510
 250:	495f4343 	ldmdbmi	pc, {r0, r1, r6, r8, r9, lr}^	; <UNPREDICTABLE>
 254:	006e5152 	rsbeq	r5, lr, r2, asr r1
 258:	4f495047 	svcmi	0x00495047
 25c:	3146415f 	cmpcc	r6, pc, asr r1
 260:	43445f33 	movtmi	r5, #20275	; 0x4f33
 264:	4700494d 	strmi	r4, [r0, -sp, asr #18]
 268:	00525054 	subseq	r5, r2, r4, asr r0
 26c:	6f6d654d 	svcvs	0x006d654d
 270:	614d7972 	hvcvs	55186	; 0xd792
 274:	6567616e 	strbvs	r6, [r7, #-366]!	; 0x16e
 278:	746e656d 	strbtvc	r6, [lr], #-1389	; 0x56d
 27c:	5152495f 	cmppl	r2, pc, asr r9
 280:	4954006e 	ldmdbmi	r4, {r1, r2, r3, r5, r6}^
 284:	79545f4d 	ldmdbvc	r4, {r0, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
 288:	65446570 	strbvs	r6, [r4, #-1392]	; 0x570
 28c:	43430066 	movtmi	r0, #12390	; 0x3066
 290:	75005245 	strvc	r5, [r0, #-581]	; 0x245
 294:	33746e69 	cmncc	r4, #1680	; 0x690
 298:	00745f32 	rsbseq	r5, r4, r2, lsr pc
 29c:	504d4154 	subpl	r4, sp, r4, asr r1
 2a0:	4154535f 	cmpmi	r4, pc, asr r3
 2a4:	495f504d 	ldmdbmi	pc, {r0, r2, r3, r6, ip, lr}^	; <UNPREDICTABLE>
 2a8:	006e5152 	rsbeq	r5, lr, r2, asr r1
 2ac:	52544442 	subspl	r4, r4, #1107296256	; 0x42000000
 2b0:	726f7700 	rsbvc	r7, pc, #0, 14
 2b4:	00632e6b 	rsbeq	r2, r3, fp, ror #28
 2b8:	52455349 	subpl	r5, r5, #603979777	; 0x24000001
 2bc:	47544f00 	ldrbmi	r4, [r4, -r0, lsl #30]
 2c0:	5f53465f 	svcpl	0x0053465f
 2c4:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 2c8:	42484100 	submi	r4, r8, #0, 2
 2cc:	524e4531 	subpl	r4, lr, #205520896	; 0xc400000
 2d0:	52434300 	subpl	r4, r3, #0, 6
 2d4:	53530031 	cmppl	r3, #49	; 0x31
 2d8:	00524743 	subseq	r4, r2, r3, asr #14
 2dc:	33524343 	cmpcc	r2, #201326593	; 0xc000001
 2e0:	45535200 	ldrbmi	r5, [r3, #-512]	; 0x200
 2e4:	44455652 	strbmi	r5, [r5], #-1618	; 0x652
 2e8:	4d440031 	stclmi	0, cr0, [r4, #-196]	; 0xffffff3c
 2ec:	535f3241 	cmppl	pc, #268435460	; 0x10000004
 2f0:	61657274 	smcvs	22308	; 0x5724
 2f4:	495f326d 	ldmdbmi	pc, {r0, r2, r3, r5, r6, r9, ip, sp}^	; <UNPREDICTABLE>
 2f8:	006e5152 	rsbeq	r5, lr, r2, asr r1
 2fc:	524d4343 	subpl	r4, sp, #201326593	; 0xc000001
 300:	50530032 	subspl	r0, r3, r2, lsr r0
 304:	495f3149 	ldmdbmi	pc, {r0, r3, r6, r8, ip, sp}^	; <UNPREDICTABLE>
 308:	006e5152 	rsbeq	r5, lr, r2, asr r1
 30c:	314d4954 	cmpcc	sp, r4, asr r9
 310:	4b52425f 	blmi	1490c94 <vector_table-0x6b6f36c>
 314:	4d49545f 	cfstrdmi	mvd5, [r9, #-380]	; 0xfffffe84
 318:	52495f39 	subpl	r5, r9, #57, 30	; 0xe4
 31c:	4e006e51 	mcrmi	14, 0, r6, cr0, cr1, {2}
 320:	5f434956 	svcpl	0x00434956
 324:	62616e45 	rsbvs	r6, r1, #1104	; 0x450
 328:	5249656c 	subpl	r6, r9, #108, 10	; 0x1b000000
 32c:	6f6c0051 	svcvs	0x006c0051
 330:	6c20676e 	stcvs	7, cr6, [r0], #-440	; 0xfffffe48
 334:	20676e6f 	rsbcs	r6, r7, pc, ror #28
 338:	69736e75 	ldmdbvs	r3!, {r0, r2, r4, r5, r6, r9, sl, fp, sp, lr}^
 33c:	64656e67 	strbtvs	r6, [r5], #-3687	; 0xe67
 340:	746e6920 	strbtvc	r6, [lr], #-2336	; 0x920
 344:	53455200 	movtpl	r5, #20992	; 0x5200
 348:	45565245 	ldrbmi	r5, [r6, #-581]	; 0x245
 34c:	44003744 	strmi	r3, [r0], #-1860	; 0x744
 350:	5f31414d 	svcpl	0x0031414d
 354:	65727453 	ldrbvs	r7, [r2, #-1107]!	; 0x453
 358:	5f376d61 	svcpl	0x00376d61
 35c:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 360:	414d4400 	cmpmi	sp, r0, lsl #8
 364:	74535f31 	ldrbvc	r5, [r3], #-3889	; 0xf31
 368:	6d616572 	cfstr64vs	mvdx6, [r1, #-456]!	; 0xfffffe38
 36c:	52495f32 	subpl	r5, r9, #50, 30	; 0xc8
 370:	47006e51 	smlsdmi	r0, r1, lr, r6
 374:	5f4f4950 	svcpl	0x004f4950
 378:	5f354641 	svcpl	0x00354641
 37c:	31495053 	qdaddcc	r5, r3, r9
 380:	4300325f 	movwmi	r3, #607	; 0x25f
 384:	5f324e41 	svcpl	0x00324e41
 388:	5f454353 	svcpl	0x00454353
 38c:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 390:	4e414300 	cdpmi	3, 4, cr4, cr1, cr0, {0}
 394:	58525f31 	ldmdapl	r2, {r0, r4, r5, r8, r9, sl, fp, ip, lr}^
 398:	52495f31 	subpl	r5, r9, #49, 30	; 0xc4
 39c:	47006e51 	smlsdmi	r0, r1, lr, r6
 3a0:	5f4f4950 	svcpl	0x004f4950
 3a4:	5f344641 	svcpl	0x00344641
 3a8:	31433249 	cmpcc	r3, r9, asr #4
 3ac:	4100335f 	tstmi	r0, pc, asr r3
 3b0:	52334248 	eorspl	r4, r3, #72, 4	; 0x80000004
 3b4:	00525453 	subseq	r5, r2, r3, asr r4
 3b8:	44505550 	ldrbmi	r5, [r0], #-1360	; 0x550
 3bc:	52490052 	subpl	r0, r9, #82	; 0x52
 3c0:	545f6e51 	ldrbpl	r6, [pc], #-3665	; 3c8 <vector_table-0x7fffc38>
 3c4:	00657079 	rsbeq	r7, r5, r9, ror r0
 3c8:	32414d44 	subcc	r4, r1, #68, 26	; 0x1100
 3cc:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
 3d0:	376d6165 	strbcc	r6, [sp, -r5, ror #2]!
 3d4:	5152495f 	cmppl	r2, pc, asr r9
 3d8:	5355006e 	cmppl	r5, #110	; 0x6e
 3dc:	32545241 	subscc	r5, r4, #268435460	; 0x10000004
 3e0:	5152495f 	cmppl	r2, pc, asr r9
 3e4:	4352006e 	cmpmi	r2, #110	; 0x6e
 3e8:	79545f43 	ldmdbvc	r4, {r0, r1, r6, r8, r9, sl, fp, ip, lr}^
 3ec:	65446570 	strbvs	r6, [r4, #-1392]	; 0x570
 3f0:	32490066 	subcc	r0, r9, #102	; 0x66
 3f4:	455f3343 	ldrbmi	r3, [pc, #-835]	; b9 <vector_table-0x7ffff47>
 3f8:	52495f52 	subpl	r5, r9, #328	; 0x148
 3fc:	4d006e51 	stcmi	14, cr6, [r0, #-324]	; 0xfffffebc
 400:	5245444f 	subpl	r4, r5, #1325400064	; 0x4f000000
 404:	43545200 	cmpmi	r4, #0, 4
 408:	554b575f 	strbpl	r5, [fp, #-1887]	; 0x75f
 40c:	52495f50 	subpl	r5, r9, #80, 30	; 0x140
 410:	4f006e51 	svcmi	0x00006e51
 414:	485f4754 	ldmdami	pc, {r2, r4, r6, r8, r9, sl, lr}^	; <UNPREDICTABLE>
 418:	52495f53 	subpl	r5, r9, #332	; 0x14c
 41c:	44006e51 	strmi	r6, [r0], #-3665	; 0xe51
 420:	00524549 	subseq	r4, r2, r9, asr #10
 424:	52415355 	subpl	r5, r1, #1409286145	; 0x54000001
 428:	79545f54 	ldmdbvc	r4, {r2, r4, r6, r8, r9, sl, fp, ip, lr}^
 42c:	65446570 	strbvs	r6, [r4, #-1392]	; 0x570
 430:	50470066 	subpl	r0, r7, r6, rrx
 434:	415f4f49 	cmpmi	pc, r9, asr #30
 438:	535f3046 	cmppl	pc, #70	; 0x46
 43c:	41005359 	tstmi	r0, r9, asr r3
 440:	45334248 	ldrmi	r4, [r3, #-584]!	; 0x248
 444:	4700524e 	strmi	r5, [r0, -lr, asr #4]
 448:	5f4f4950 	svcpl	0x004f4950
 44c:	5f374641 	svcpl	0x00374641
 450:	52415355 	subpl	r5, r1, #1409286145	; 0x54000001
 454:	335f3154 	cmpcc	pc, #84, 2
 458:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
 45c:	46415f4f 	strbmi	r5, [r1], -pc, asr #30
 460:	41435f39 	cmpmi	r3, r9, lsr pc
 464:	325f314e 	subscc	r3, pc, #-2147483629	; 0x80000013
 468:	4d49545f 	cfstrdmi	mvd5, [r9, #-380]	; 0xfffffe84
 46c:	315f3231 	cmpcc	pc, r1, lsr r2	; <UNPREDICTABLE>
 470:	58450034 	stmdapl	r5, {r2, r4, r5}^
 474:	5f324954 	svcpl	0x00324954
 478:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 47c:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
 480:	46415f30 			; <UNDEFINED> instruction: 0x46415f30
 484:	455f3531 	ldrbmi	r3, [pc, #-1329]	; ffffff5b <_estack+0xdffe3f5f>
 488:	544e4556 	strbpl	r4, [lr], #-1366	; 0x556
 48c:	0054554f 	subseq	r5, r4, pc, asr #10
 490:	31425041 	cmpcc	r2, r1, asr #32
 494:	52545352 	subspl	r5, r4, #1207959553	; 0x48000001
 498:	43324900 	teqmi	r2, #0, 18
 49c:	56455f32 			; <UNDEFINED> instruction: 0x56455f32
 4a0:	5152495f 	cmppl	r2, pc, asr r9
 4a4:	5053006e 	subspl	r0, r3, lr, rrx
 4a8:	495f3349 	ldmdbmi	pc, {r0, r3, r6, r8, r9, ip, sp}^	; <UNPREDICTABLE>
 4ac:	006e5152 	rsbeq	r5, lr, r2, asr r1
 4b0:	334d4954 	movtcc	r4, #55636	; 0xd954
 4b4:	5152495f 	cmppl	r2, pc, asr r9
 4b8:	4d44006e 	stclmi	0, cr0, [r4, #-440]	; 0xfffffe48
 4bc:	535f3141 	cmppl	pc, #1073741840	; 0x40000010
 4c0:	61657274 	smcvs	22308	; 0x5724
 4c4:	495f346d 	ldmdbmi	pc, {r0, r2, r3, r5, r6, sl, ip, sp}^	; <UNPREDICTABLE>
 4c8:	006e5152 	rsbeq	r5, lr, r2, asr r1
 4cc:	746e6975 	strbtvc	r6, [lr], #-2421	; 0x975
 4d0:	00745f38 	rsbseq	r5, r4, r8, lsr pc
 4d4:	32524343 	subscc	r4, r2, #201326593	; 0xc000001
 4d8:	52434300 	subpl	r4, r3, #0, 6
 4dc:	50470034 	subpl	r0, r7, r4, lsr r0
 4e0:	415f4f49 	cmpmi	pc, r9, asr #30
 4e4:	00343146 	eorseq	r3, r4, r6, asr #2
 4e8:	52434d53 	subpl	r4, r3, #5312	; 0x14c0
 4ec:	4d495400 	cfstrdmi	mvd5, [r9, #-0]
 4f0:	50555f38 	subspl	r5, r5, r8, lsr pc
 4f4:	4d49545f 	cfstrdmi	mvd5, [r9, #-380]	; 0xfffffe84
 4f8:	495f3331 	ldmdbmi	pc, {r0, r4, r5, r8, r9, ip, sp}^	; <UNPREDICTABLE>
 4fc:	006e5152 	rsbeq	r5, lr, r2, asr r1
 500:	676e6f6c 	strbvs	r6, [lr, -ip, ror #30]!
 504:	6e6f6c20 	cdpvs	12, 6, cr6, cr15, cr0, {1}
 508:	6e692067 	cdpvs	0, 6, cr2, cr9, cr7, {3}
 50c:	57570074 			; <UNDEFINED> instruction: 0x57570074
 510:	495f4744 	ldmdbmi	pc, {r2, r6, r8, r9, sl, lr}^	; <UNPREDICTABLE>
 514:	006e5152 	rsbeq	r5, lr, r2, asr r1
 518:	324e4143 	subcc	r4, lr, #-1073741808	; 0xc0000010
 51c:	3158525f 	cmpcc	r8, pc, asr r2
 520:	5152495f 	cmppl	r2, pc, asr r9
 524:	5041006e 	subpl	r0, r1, lr, rrx
 528:	504c3142 	subpl	r3, ip, r2, asr #2
 52c:	00524e45 	subseq	r4, r2, r5, asr #28
 530:	32414d44 	subcc	r4, r1, #68, 26	; 0x1100
 534:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
 538:	346d6165 	strbtcc	r6, [sp], #-357	; 0x165
 53c:	5152495f 	cmppl	r2, pc, asr r9
 540:	7542006e 	strbvc	r0, [r2, #-110]	; 0x6e
 544:	75614673 	strbvc	r4, [r1, #-1651]!	; 0x673
 548:	495f746c 	ldmdbmi	pc, {r2, r3, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
 54c:	006e5152 	rsbeq	r5, lr, r2, asr r1
 550:	314d4954 	cmpcc	sp, r4, asr r9
 554:	4752545f 			; <UNDEFINED> instruction: 0x4752545f
 558:	4d4f435f 	stclmi	3, cr4, [pc, #-380]	; 3e4 <vector_table-0x7fffc1c>
 55c:	4d49545f 	cfstrdmi	mvd5, [r9, #-380]	; 0xfffffe84
 560:	495f3131 	ldmdbmi	pc, {r0, r4, r5, r8, ip, sp}^	; <UNPREDICTABLE>
 564:	006e5152 	rsbeq	r5, lr, r2, asr r1
 568:	49545845 	ldmdbmi	r4, {r0, r2, r6, fp, ip, lr}^
 56c:	52495f34 	subpl	r5, r9, #52, 30	; 0xd0
 570:	47006e51 	smlsdmi	r0, r1, lr, r6
 574:	5f4f4950 	svcpl	0x004f4950
 578:	5f314641 	svcpl	0x00314641
 57c:	314d4954 	cmpcc	sp, r4, asr r9
 580:	5000325f 	andpl	r3, r0, pc, asr r2
 584:	495f4456 	ldmdbmi	pc, {r1, r2, r4, r6, sl, lr}^	; <UNPREDICTABLE>
 588:	006e5152 	rsbeq	r5, lr, r2, asr r1
 58c:	5f434441 	svcpl	0x00434441
 590:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 594:	50434900 	subpl	r4, r3, r0, lsl #18
 598:	50470052 	subpl	r0, r7, r2, asr r0
 59c:	415f4f49 	cmpmi	pc, r9, asr #30
 5a0:	5f313146 	svcpl	0x00313146
 5a4:	00485445 	subeq	r5, r8, r5, asr #8
 5a8:	32425041 	subcc	r5, r2, #65	; 0x41
 5ac:	00524e45 	subseq	r4, r2, r5, asr #28
 5b0:	354d4954 	strbcc	r4, [sp, #-2388]	; 0x954
 5b4:	5152495f 	cmppl	r2, pc, asr r9
 5b8:	4841006e 	stmdami	r1, {r1, r2, r3, r5, r6}^
 5bc:	504c3142 	subpl	r3, ip, r2, asr #2
 5c0:	00524e45 	subseq	r4, r2, r5, asr #28
 5c4:	31433249 	cmpcc	r3, r9, asr #4
 5c8:	5f56455f 	svcpl	0x0056455f
 5cc:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 5d0:	50534f00 	subspl	r4, r3, r0, lsl #30
 5d4:	52444545 	subpl	r4, r4, #289406976	; 0x11400000
 5d8:	4e414300 	cdpmi	3, 4, cr4, cr1, cr0, {0}
 5dc:	58545f31 	ldmdapl	r4, {r0, r4, r5, r8, r9, sl, fp, ip, lr}^
 5e0:	5152495f 	cmppl	r2, pc, asr r9
 5e4:	6975006e 	ldmdbvs	r5!, {r1, r2, r3, r5, r6}^
 5e8:	3631746e 	ldrtcc	r7, [r1], -lr, ror #8
 5ec:	4400745f 	strmi	r7, [r0], #-1119	; 0x45f
 5f0:	5f31414d 	svcpl	0x0031414d
 5f4:	65727453 	ldrbvs	r7, [r2, #-1107]!	; 0x453
 5f8:	5f316d61 	svcpl	0x00316d61
 5fc:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 600:	4e414300 	cdpmi	3, 4, cr4, cr1, cr0, {0}
 604:	58525f31 	ldmdapl	r2, {r0, r4, r5, r8, r9, sl, fp, ip, lr}^
 608:	52495f30 	subpl	r5, r9, #48, 30	; 0xc0
 60c:	41006e51 	tstmi	r0, r1, asr lr
 610:	52324248 	eorspl	r4, r2, #72, 4	; 0x80000004
 614:	00525453 	subseq	r5, r2, r3, asr r4
 618:	52495453 	subpl	r5, r9, #1392508928	; 0x53000000
 61c:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
 620:	46415f4f 	strbmi	r5, [r1], -pc, asr #30
 624:	50535f36 	subspl	r5, r3, r6, lsr pc
 628:	52003349 	andpl	r3, r0, #603979777	; 0x24000001
 62c:	415f4354 	cmpmi	pc, r4, asr r3	; <UNPREDICTABLE>
 630:	6d72616c 	ldfvse	f6, [r2, #-432]!	; 0xfffffe50
 634:	5152495f 	cmppl	r2, pc, asr r9
 638:	4552006e 	ldrbmi	r0, [r2, #-110]	; 0x6e
 63c:	56524553 			; <UNDEFINED> instruction: 0x56524553
 640:	00304445 	eorseq	r4, r0, r5, asr #8
 644:	45534552 	ldrbmi	r4, [r3, #-1362]	; 0x552
 648:	44455652 	strbmi	r5, [r5], #-1618	; 0x652
 64c:	45520031 	ldrbmi	r0, [r2, #-49]	; 0x31
 650:	56524553 			; <UNDEFINED> instruction: 0x56524553
 654:	00324445 	eorseq	r4, r2, r5, asr #8
 658:	45534552 	ldrbmi	r4, [r3, #-1362]	; 0x552
 65c:	44455652 	strbmi	r5, [r5], #-1618	; 0x652
 660:	45520033 	ldrbmi	r0, [r2, #-51]	; 0x33
 664:	56524553 			; <UNDEFINED> instruction: 0x56524553
 668:	00344445 	eorseq	r4, r4, r5, asr #8
 66c:	45534552 	ldrbmi	r4, [r3, #-1362]	; 0x552
 670:	44455652 	strbmi	r5, [r5], #-1618	; 0x652
 674:	45520035 	ldrbmi	r0, [r2, #-53]	; 0x35
 678:	56524553 			; <UNDEFINED> instruction: 0x56524553
 67c:	00364445 	eorseq	r4, r6, r5, asr #8
 680:	726f6873 	rsbvc	r6, pc, #7536640	; 0x730000
 684:	6e692074 	mcrvs	0, 3, r2, cr9, cr4, {3}
 688:	45520074 	ldrbmi	r0, [r2, #-116]	; 0x74
 68c:	56524553 			; <UNDEFINED> instruction: 0x56524553
 690:	00384445 	eorseq	r4, r8, r5, asr #8
 694:	45534552 	ldrbmi	r4, [r3, #-1362]	; 0x552
 698:	44455652 	strbmi	r5, [r5], #-1618	; 0x652
 69c:	4d440039 	stclmi	0, cr0, [r4, #-228]	; 0xffffff1c
 6a0:	535f3241 	cmppl	pc, #268435460	; 0x10000004
 6a4:	61657274 	smcvs	22308	; 0x5724
 6a8:	495f366d 	ldmdbmi	pc, {r0, r2, r3, r5, r6, r9, sl, ip, sp}^	; <UNPREDICTABLE>
 6ac:	006e5152 	rsbeq	r5, lr, r2, asr r1
 6b0:	33433249 	movtcc	r3, #12873	; 0x3249
 6b4:	5f56455f 	svcpl	0x0056455f
 6b8:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 6bc:	41535500 	cmpmi	r3, r0, lsl #10
 6c0:	5f315452 	svcpl	0x00315452
 6c4:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 6c8:	414d4400 	cmpmi	sp, r0, lsl #8
 6cc:	41550052 	cmpmi	r5, r2, asr r0
 6d0:	5f355452 	svcpl	0x00355452
 6d4:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 6d8:	4d544900 	ldclmi	9, cr4, [r4, #-0]
 6dc:	4278525f 	rsbsmi	r5, r8, #-268435451	; 0xf0000005
 6e0:	65666675 	strbvs	r6, [r6, #-1653]!	; 0x675
 6e4:	6f4e0072 	svcvs	0x004e0072
 6e8:	73614d6e 	cmnvc	r1, #7040	; 0x1b80
 6ec:	6c62616b 	stfvse	f6, [r2], #-428	; 0xfffffe54
 6f0:	746e4965 	strbtvc	r4, [lr], #-2405	; 0x965
 6f4:	5152495f 	cmppl	r2, pc, asr r9
 6f8:	4d44006e 	stclmi	0, cr0, [r4, #-440]	; 0xfffffe48
 6fc:	535f3241 	cmppl	pc, #268435460	; 0x10000004
 700:	61657274 	smcvs	22308	; 0x5724
 704:	495f316d 	ldmdbmi	pc, {r0, r2, r3, r5, r6, r8, ip, sp}^	; <UNPREDICTABLE>
 708:	006e5152 	rsbeq	r5, lr, r2, asr r1
 70c:	314d4954 	cmpcc	sp, r4, asr r9
 710:	5f43435f 	svcpl	0x0043435f
 714:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 718:	59544f00 	ldmdbpl	r4, {r8, r9, sl, fp, lr}^
 71c:	00524550 	subseq	r4, r2, r0, asr r5
 720:	384d4954 	stmdacc	sp, {r2, r4, r6, r8, fp, lr}^
 724:	5f43435f 	svcpl	0x0043435f
 728:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 72c:	414d4400 	cmpmi	sp, r0, lsl #8
 730:	74535f31 	ldrbvc	r5, [r3], #-3889	; 0xf31
 734:	6d616572 	cfstr64vs	mvdx6, [r1, #-456]!	; 0xfffffe38
 738:	52495f36 	subpl	r5, r9, #54, 30	; 0xd8
 73c:	77006e51 	smlsdvc	r0, r1, lr, r6
 740:	006b726f 	rsbeq	r7, fp, pc, ror #4
 744:	4f495047 	svcmi	0x00495047
 748:	3146415f 	cmpcc	r6, pc, asr r1
 74c:	544f5f30 	strbpl	r5, [pc], #-3888	; 754 <vector_table-0x7fff8ac>
 750:	53465f47 	movtpl	r5, #28487	; 0x6f47
 754:	0053485f 	subseq	r4, r3, pc, asr r8
 758:	4f495047 	svcmi	0x00495047
 75c:	3246415f 	subcc	r4, r6, #-1073741801	; 0xc0000017
 760:	4d49545f 	cfstrdmi	mvd5, [r9, #-380]	; 0xfffffe84
 764:	00355f33 	eorseq	r5, r5, r3, lsr pc
 768:	434d5346 	movtmi	r5, #54086	; 0xd346
 76c:	5152495f 	cmppl	r2, pc, asr r9
 770:	5845006e 	stmdapl	r5, {r1, r2, r3, r5, r6}^
 774:	5f314954 	svcpl	0x00314954
 778:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 77c:	49564e00 	ldmdbmi	r6, {r9, sl, fp, lr}^
 780:	79545f43 	ldmdbvc	r4, {r0, r1, r6, r8, r9, sl, fp, ip, lr}^
 784:	54006570 	strpl	r6, [r0], #-1392	; 0x570
 788:	5f364d49 	svcpl	0x00364d49
 78c:	5f434144 	svcpl	0x00434144
 790:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 794:	4c4c5000 	marmi	acc0, r5, ip
 798:	52474643 	subpl	r4, r7, #70254592	; 0x4300000
 79c:	49504700 	ldmdbmi	r0, {r8, r9, sl, lr}^
 7a0:	79545f4f 	ldmdbvc	r4, {r0, r1, r2, r3, r6, r8, r9, sl, fp, ip, lr}^
 7a4:	65446570 	strbvs	r6, [r4, #-1392]	; 0x570
 7a8:	32490066 	subcc	r0, r9, #102	; 0x66
 7ac:	455f3143 	ldrbmi	r3, [pc, #-323]	; 671 <vector_table-0x7fff98f>
 7b0:	52495f52 	subpl	r5, r9, #328	; 0x148
 7b4:	55006e51 	strpl	r6, [r0, #-3665]	; 0xe51
 7b8:	54524153 	ldrbpl	r4, [r2], #-339	; 0x153
 7bc:	52495f36 	subpl	r5, r9, #54, 30	; 0xd8
 7c0:	53006e51 	movwpl	r6, #3665	; 0xe51
 7c4:	69547379 	ldmdbvs	r4, {r0, r3, r4, r5, r6, r8, r9, ip, sp, lr}^
 7c8:	495f6b63 	ldmdbmi	pc, {r0, r1, r5, r6, r8, r9, fp, sp, lr}^	; <UNPREDICTABLE>
 7cc:	006e5152 	rsbeq	r5, lr, r2, asr r1
 7d0:	33424841 	movtcc	r4, #10305	; 0x2841
 7d4:	4e45504c 	cdpmi	0, 4, cr5, cr5, cr12, {2}
 7d8:	49540052 	ldmdbmi	r4, {r1, r4, r6}^
 7dc:	495f324d 	ldmdbmi	pc, {r0, r2, r3, r6, r9, ip, sp}^	; <UNPREDICTABLE>
 7e0:	006e5152 	rsbeq	r5, lr, r2, asr r1
 7e4:	32424841 	subcc	r4, r2, #4259840	; 0x410000
 7e8:	00524e45 	subseq	r4, r2, r5, asr #28
 7ec:	5f47544f 	svcpl	0x0047544f
 7f0:	575f5348 	ldrbpl	r5, [pc, -r8, asr #6]
 7f4:	5f50554b 	svcpl	0x0050554b
 7f8:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 7fc:	52534200 	subspl	r4, r3, #0, 4
 800:	42004852 	andmi	r4, r0, #5373952	; 0x520000
 804:	4c525253 	lfmmi	f5, 2, [r2], {83}	; 0x53
 808:	62654400 	rsbvs	r4, r5, #0, 8
 80c:	6f4d6775 	svcvs	0x004d6775
 810:	6f74696e 	svcvs	0x0074696e
 814:	52495f72 	subpl	r5, r9, #456	; 0x1c8
 818:	50006e51 	andpl	r6, r0, r1, asr lr
 81c:	32494c4c 	subcc	r4, r9, #76, 24	; 0x4c00
 820:	47464353 	smlsldmi	r4, r6, r3, r3
 824:	73550052 	cmpvc	r5, #82	; 0x52
 828:	46656761 	strbtmi	r6, [r5], -r1, ror #14
 82c:	746c7561 	strbtvc	r7, [ip], #-1377	; 0x561
 830:	5152495f 	cmppl	r2, pc, asr r9
 834:	5845006e 	stmdapl	r5, {r1, r2, r3, r5, r6}^
 838:	5f394954 	svcpl	0x00394954
 83c:	52495f35 	subpl	r5, r9, #53, 30	; 0xd4
 840:	53006e51 	movwpl	r6, #3665	; 0xe51
 844:	6c614356 	stclvs	3, cr4, [r1], #-344	; 0xfffffea8
 848:	52495f6c 	subpl	r5, r9, #108, 30	; 0x1b0
 84c:	54006e51 	strpl	r6, [r0], #-3665	; 0xe51
 850:	5f384d49 	svcpl	0x00384d49
 854:	5f475254 	svcpl	0x00475254
 858:	5f4d4f43 	svcpl	0x004d4f43
 85c:	314d4954 	cmpcc	sp, r4, asr r9
 860:	52495f34 	subpl	r5, r9, #52, 30	; 0xd0
 864:	52006e51 	andpl	r6, r0, #1296	; 0x510
 868:	52455345 	subpl	r5, r5, #335544321	; 0x14000001
 86c:	31444556 	cmpcc	r4, r6, asr r5
 870:	45520030 	ldrbmi	r0, [r2, #-48]	; 0x30
 874:	56524553 			; <UNDEFINED> instruction: 0x56524553
 878:	31314445 	teqcc	r1, r5, asr #8
 87c:	53455200 	movtpl	r5, #20992	; 0x5200
 880:	45565245 	ldrbmi	r5, [r6, #-581]	; 0x245
 884:	00323144 	eorseq	r3, r2, r4, asr #2
 888:	45534552 	ldrbmi	r4, [r3, #-1362]	; 0x552
 88c:	44455652 	strbmi	r5, [r5], #-1618	; 0x652
 890:	52003331 	andpl	r3, r0, #-1006632960	; 0xc4000000
 894:	52455345 	subpl	r5, r5, #335544321	; 0x14000001
 898:	31444556 	cmpcc	r4, r6, asr r5
 89c:	41430034 	cmpmi	r3, r4, lsr r0
 8a0:	525f324e 	subspl	r3, pc, #-536870908	; 0xe0000004
 8a4:	495f3058 	ldmdbmi	pc, {r3, r4, r6, ip, sp}^	; <UNPREDICTABLE>
 8a8:	006e5152 	rsbeq	r5, lr, r2, asr r1
 8ac:	52454349 	subpl	r4, r5, #603979777	; 0x24000001
 8b0:	414d4400 	cmpmi	sp, r0, lsl #8
 8b4:	74535f32 	ldrbvc	r5, [r3], #-3890	; 0xf32
 8b8:	6d616572 	cfstr64vs	mvdx6, [r1, #-456]!	; 0xfffffe38
 8bc:	52495f33 	subpl	r5, r9, #51, 30	; 0xcc
 8c0:	53006e51 	movwpl	r6, #3665	; 0xe51
 8c4:	5f324950 	svcpl	0x00324950
 8c8:	6e515249 	cdpvs	2, 5, cr5, cr1, cr9, {2}
 8cc:	42414900 	submi	r4, r1, #0, 18
 8d0:	49540052 	ldmdbmi	r4, {r1, r4, r6}^
 8d4:	495f374d 	ldmdbmi	pc, {r0, r2, r3, r6, r8, r9, sl, ip, sp}^	; <UNPREDICTABLE>
 8d8:	006e5152 	rsbeq	r5, lr, r2, asr r1
 8dc:	31414d44 	cmpcc	r1, r4, asr #26
 8e0:	7274535f 	rsbsvc	r5, r4, #2080374785	; 0x7c000001
 8e4:	336d6165 	cmncc	sp, #1073741849	; 0x40000019
 8e8:	5152495f 	cmppl	r2, pc, asr r9
 8ec:	4143006e 	cmpmi	r3, lr, rrx
 8f0:	545f324e 	ldrbpl	r3, [pc], #-590	; 8f8 <vector_table-0x7fff708>
 8f4:	52495f58 	subpl	r5, r9, #88, 30	; 0x160
 8f8:	45006e51 	strmi	r6, [r0, #-3665]	; 0xe51
 8fc:	33495458 	movtcc	r5, #37976	; 0x9458
 900:	5152495f 	cmppl	r2, pc, asr r9
 904:	5349006e 	movtpl	r0, #36974	; 0x906e
 908:	4f005250 	svcmi	0x00005250
 90c:	485f4754 	ldmdami	pc, {r2, r4, r6, r8, r9, sl, lr}^	; <UNPREDICTABLE>
 910:	50455f53 	subpl	r5, r5, r3, asr pc
 914:	554f5f31 	strbpl	r5, [pc, #-3889]	; fffff9eb <_estack+0xdffe39ef>
 918:	52495f54 	subpl	r5, r9, #84, 30	; 0x150
 91c:	55006e51 	strpl	r6, [r0, #-3665]	; 0xe51
 920:	54524153 	ldrbpl	r4, [r2], #-339	; 0x153
 924:	52495f33 	subpl	r5, r9, #51, 30	; 0xcc
 928:	54006e51 	strpl	r6, [r0], #-3665	; 0xe51
 92c:	5f314d49 	svcpl	0x00314d49
 930:	545f5055 	ldrbpl	r5, [pc], #-85	; 938 <vector_table-0x7fff6c8>
 934:	30314d49 	eorscc	r4, r1, r9, asr #26
 938:	5152495f 	cmppl	r2, pc, asr r9
 93c:	5047006e 	subpl	r0, r7, lr, rrx
 940:	415f4f49 	cmpmi	pc, r9, asr #30
 944:	5f323146 	svcpl	0x00323146
 948:	434d5346 	movtmi	r5, #54086	; 0xd346
 94c:	4944535f 	stmdbmi	r4, {r0, r1, r2, r3, r4, r6, r8, r9, ip, lr}^
 950:	544f5f4f 	strbpl	r5, [pc], #-3919	; 958 <vector_table-0x7fff6a8>
 954:	53485f47 	movtpl	r5, #36679	; 0x8f47
 958:	55504600 	ldrbpl	r4, [r0, #-1536]	; 0x600
 95c:	5152495f 	cmppl	r2, pc, asr r9
 960:	5445006e 	strbpl	r0, [r5], #-110	; 0x6e
 964:	52495f48 	subpl	r5, r9, #72, 30	; 0x120
 968:	41006e51 	tstmi	r0, r1, asr lr
 96c:	52314248 	eorspl	r4, r1, #72, 4	; 0x80000004
 970:	00525453 	subseq	r5, r2, r3, asr r4
 974:	524b434c 	subpl	r4, fp, #76, 6	; 0x30000001
 978:	61737500 	cmnvs	r3, r0, lsl #10
 97c:	735f7472 	cmpvc	pc, #1912602624	; 0x72000000
 980:	62646e65 	rsbvs	r6, r4, #1616	; 0x650
 984:	74796200 	ldrbtvc	r6, [r9], #-512	; 0x200
 988:	65730065 	ldrbvs	r0, [r3, #-101]!	; 0x65
 98c:	735f3172 	cmpvc	pc, #-2147483620	; 0x8000001c
 990:	62646e65 	rsbvs	r6, r4, #1616	; 0x650
 994:	41535500 	cmpmi	r3, r0, lsl #10
 998:	75005452 	strvc	r5, [r0, #-1106]	; 0x452
 99c:	74726173 	ldrbtvc	r6, [r2], #-371	; 0x173
 9a0:	7600632e 	strvc	r6, [r0], -lr, lsr #6
 9a4:	6f746365 	svcvs	0x00746365
 9a8:	61745f72 	cmnvs	r4, r2, ror pc
 9ac:	00656c62 	rsbeq	r6, r5, r2, ror #24
 9b0:	64726168 	ldrbtvs	r6, [r2], #-360	; 0x168
 9b4:	7561665f 	strbvc	r6, [r1, #-1631]!	; 0x65f
 9b8:	685f746c 	ldmdavs	pc, {r2, r3, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
 9bc:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
 9c0:	5f007265 	svcpl	0x00007265
 9c4:	61747365 	cmnvs	r4, r5, ror #6
 9c8:	63006b63 	movwvs	r6, #2915	; 0xb63
 9cc:	746e756f 	strbtvc	r7, [lr], #-1391	; 0x56f
 9d0:	75007265 	strvc	r7, [r0, #-613]	; 0x265
 9d4:	65676173 	strbvs	r6, [r7, #-371]!	; 0x173
 9d8:	7561665f 	strbvc	r6, [r1, #-1631]!	; 0x65f
 9dc:	685f746c 	ldmdavs	pc, {r2, r3, r5, r6, sl, ip, sp, lr}^	; <UNPREDICTABLE>
 9e0:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
 9e4:	6d007265 	sfmvs	f7, 4, [r0, #-404]	; 0xfffffe6c
 9e8:	6d5f6d65 	ldclvs	13, cr6, [pc, #-404]	; 85c <vector_table-0x7fff7a4>
 9ec:	67616e61 	strbvs	r6, [r1, -r1, ror #28]!
 9f0:	61685f65 	cmnvs	r8, r5, ror #30
 9f4:	656c646e 	strbvs	r6, [ip, #-1134]!	; 0x46e
 9f8:	75620072 	strbvc	r0, [r2, #-114]!	; 0x72
 9fc:	61665f73 	smcvs	26099	; 0x65f3
 a00:	5f746c75 	svcpl	0x00746c75
 a04:	646e6168 	strbtvs	r6, [lr], #-360	; 0x168
 a08:	0072656c 	rsbseq	r6, r2, ip, ror #10
 a0c:	346d6974 	strbtcc	r6, [sp], #-2420	; 0x974
 a10:	7172695f 	cmnvc	r2, pc, asr r9
 a14:	6e61685f 	mcrvs	8, 3, r6, cr1, cr15, {2}
 a18:	7265646c 	rsbvc	r6, r5, #108, 8	; 0x6c000000
 a1c:	61747300 	cmnvs	r4, r0, lsl #6
 a20:	70757472 	rsbsvc	r7, r5, r2, ror r4
 a24:	6e00632e 	cdpvs	3, 0, cr6, cr0, cr14, {1}
 a28:	685f696d 	ldmdavs	pc, {r0, r2, r3, r5, r6, r8, fp, sp, lr}^	; <UNPREDICTABLE>
 a2c:	6c646e61 	stclvs	14, cr6, [r4], #-388	; 0xfffffe7c
 a30:	72007265 	andvc	r7, r0, #1342177286	; 0x50000006
 a34:	74657365 	strbtvc	r7, [r5], #-869	; 0x365
 a38:	6e61685f 	mcrvs	8, 3, r6, cr1, cr15, {2}
 a3c:	72656c64 	rsbvc	r6, r5, #100, 24	; 0x6400
 a40:	72747300 	rsbsvc	r7, r4, #0, 6
 a44:	6974755f 	ldmdbvs	r4!, {r0, r1, r2, r3, r4, r6, r8, sl, ip, sp, lr}^
 a48:	00632e6c 	rsbeq	r2, r3, ip, ror #28
 a4c:	66667562 	strbtvs	r7, [r6], -r2, ror #10
 a50:	75007265 	strvc	r7, [r0, #-613]	; 0x265
 a54:	74726173 	ldrbtvc	r6, [r2], #-371	; 0x173
 a58:	6e65735f 	mcrvs	3, 3, r7, cr5, cr15, {2}
 a5c:	Address 0x0000000000000a5c is out of bounds.


Дизассемблирование раздела .comment:

00000000 <.comment>:
   0:	3a434347 	bcc	10d0d24 <vector_table-0x6f2f2dc>
   4:	65472820 	strbvs	r2, [r7, #-2080]	; 0x820
   8:	6f6f746e 	svcvs	0x006f746e
   c:	362e3420 	strtcc	r3, [lr], -r0, lsr #8
  10:	7020332e 	eorvc	r3, r0, lr, lsr #6
  14:	2c332e31 	ldccs	14, cr2, [r3], #-196	; 0xffffff3c
  18:	65697020 	strbvs	r7, [r9, #-32]!
  1c:	352e302d 	strcc	r3, [lr, #-45]!	; 0x2d
  20:	2029322e 	eorcs	r3, r9, lr, lsr #4
  24:	2e362e34 	mrccs	14, 1, r2, cr6, cr4, {1}
  28:	Address 0x0000000000000028 is out of bounds.


Дизассемблирование раздела .ARM.attributes:

00000000 <.ARM.attributes>:
   0:	00003041 	andeq	r3, r0, r1, asr #32
   4:	61656100 	cmnvs	r5, r0, lsl #2
   8:	01006962 	tsteq	r0, r2, ror #18
   c:	00000026 	andeq	r0, r0, r6, lsr #32
  10:	726f4305 	rsbvc	r4, pc, #335544320	; 0x14000000
  14:	2d786574 	cfldr64cs	mvdx6, [r8, #-464]!	; 0xfffffe30
  18:	0600334d 	streq	r3, [r0], -sp, asr #6
  1c:	094d070a 	stmdbeq	sp, {r1, r3, r8, r9, sl}^
  20:	14041202 	strne	r1, [r4], #-514	; 0x202
  24:	17011501 	strne	r1, [r1, -r1, lsl #10]
  28:	19011803 	stmdbne	r1, {r0, r1, fp, ip}
  2c:	1e021a01 	vmlane.f32	s2, s4, s2
  30:	Address 0x0000000000000030 is out of bounds.


Дизассемблирование раздела .debug_frame:

00000000 <.debug_frame>:
   0:	0000000c 	andeq	r0, r0, ip
   4:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
   8:	7c020001 	stcvc	0, cr0, [r2], {1}
   c:	000d0c0e 	andeq	r0, sp, lr, lsl #24
  10:	00000014 	andeq	r0, r0, r4, lsl r0
  14:	00000000 	andeq	r0, r0, r0
  18:	08000188 	stmdaeq	r0, {r3, r7, r8}
  1c:	00000020 	andeq	r0, r0, r0, lsr #32
  20:	8e080e42 	cdphi	14, 0, cr0, cr8, cr2, {2}
  24:	00028401 	andeq	r8, r2, r1, lsl #8
  28:	00000014 	andeq	r0, r0, r4, lsl r0
  2c:	00000000 	andeq	r0, r0, r0
  30:	080001a8 	stmdaeq	r0, {r3, r5, r7, r8}
  34:	00000016 	andeq	r0, r0, r6, lsl r0
  38:	8e080e41 	cdphi	14, 0, cr0, cr8, cr1, {2}
  3c:	00028401 	andeq	r8, r2, r1, lsl #8
  40:	00000024 	andeq	r0, r0, r4, lsr #32
  44:	00000000 	andeq	r0, r0, r0
  48:	080001c0 	stmdaeq	r0, {r6, r7, r8}
  4c:	00000250 	andeq	r0, r0, r0, asr r2
  50:	8e240e42 	cdphi	14, 2, cr0, cr4, cr2, {2}
  54:	8a028b01 	bhi	a2c60 <vector_table-0x7f5d3a0>
  58:	88048903 	stmdahi	r4, {r0, r1, r8, fp, pc}
  5c:	86068705 	strhi	r8, [r6], -r5, lsl #14
  60:	84088507 	strhi	r8, [r8], #-1287	; 0x507
  64:	380e4209 	stmdacc	lr, {r0, r3, r9, lr}
  68:	00000018 	andeq	r0, r0, r8, lsl r0
  6c:	00000000 	andeq	r0, r0, r0
  70:	08000410 	stmdaeq	r0, {r4, sl}
  74:	00000024 	andeq	r0, r0, r4, lsr #32
  78:	8e100e41 	cdphi	14, 1, cr0, cr0, cr1, {2}
  7c:	85028601 	strhi	r8, [r2, #-1537]	; 0x601
  80:	00048403 	andeq	r8, r4, r3, lsl #8
  84:	00000020 	andeq	r0, r0, r0, lsr #32
  88:	00000000 	andeq	r0, r0, r0
  8c:	08000434 	stmdaeq	r0, {r2, r4, r5, sl}
  90:	0000001c 	andeq	r0, r0, ip, lsl r0
  94:	83100e41 	tsthi	r0, #1040	; 0x410
  98:	81028201 	tsthi	r2, r1, lsl #4
  9c:	41048003 	tstmi	r4, r3
  a0:	058e140e 	streq	r1, [lr, #1038]	; 0x40e
  a4:	00200e41 	eoreq	r0, r0, r1, asr #28
  a8:	00000024 	andeq	r0, r0, r4, lsr #32
  ac:	00000000 	andeq	r0, r0, r0
  b0:	08000450 	stmdaeq	r0, {r4, r6, sl}
  b4:	00000034 	andeq	r0, r0, r4, lsr r0
  b8:	830c0e41 	movwhi	r0, #52801	; 0xce41
  bc:	81028201 	tsthi	r2, r1, lsl #4
  c0:	180e4103 	stmdane	lr, {r0, r1, r8, lr}
  c4:	0585048e 	streq	r0, [r5, #1166]	; 0x48e
  c8:	0e410684 	cdpeq	6, 4, cr0, cr1, cr4, {4}
  cc:	00000020 	andeq	r0, r0, r0, lsr #32
  d0:	00000024 	andeq	r0, r0, r4, lsr #32
  d4:	00000000 	andeq	r0, r0, r0
  d8:	08000484 	stmdaeq	r0, {r2, r7, sl}
  dc:	00000030 	andeq	r0, r0, r0, lsr r0
  e0:	830c0e41 	movwhi	r0, #52801	; 0xce41
  e4:	81028201 	tsthi	r2, r1, lsl #4
  e8:	1c0e4103 	stfnes	f4, [lr], {3}
  ec:	0586048e 	streq	r0, [r6, #1166]	; 0x48e
  f0:	07840685 	streq	r0, [r4, r5, lsl #13]
  f4:	00280e41 	eoreq	r0, r8, r1, asr #28
  f8:	00000018 	andeq	r0, r0, r8, lsl r0
  fc:	00000000 	andeq	r0, r0, r0
 100:	080004b4 	stmdaeq	r0, {r2, r4, r5, r7, sl}
 104:	000000b0 	strheq	r0, [r0], -r0	; <UNPREDICTABLE>
 108:	8e100e41 	cdphi	14, 1, cr0, cr0, cr1, {2}
 10c:	85028601 	strhi	r8, [r2, #-1537]	; 0x601
 110:	00048403 	andeq	r8, r4, r3, lsl #8
 114:	0000000c 	andeq	r0, r0, ip
 118:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 11c:	7c020001 	stcvc	0, cr0, [r2], {1}
 120:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 124:	0000000c 	andeq	r0, r0, ip
 128:	00000114 	andeq	r0, r0, r4, lsl r1
 12c:	08000564 	stmdaeq	r0, {r2, r5, r6, r8, sl}
 130:	000000a0 	andeq	r0, r0, r0, lsr #1
 134:	0000000c 	andeq	r0, r0, ip
 138:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 13c:	7c020001 	stcvc	0, cr0, [r2], {1}
 140:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 144:	0000000c 	andeq	r0, r0, ip
 148:	00000134 	andeq	r0, r0, r4, lsr r1
 14c:	08000604 	stmdaeq	r0, {r2, r9, sl}
 150:	0000000a 	andeq	r0, r0, sl
 154:	0000000c 	andeq	r0, r0, ip
 158:	00000134 	andeq	r0, r0, r4, lsr r1
 15c:	08000610 	stmdaeq	r0, {r4, r9, sl}
 160:	0000001a 	andeq	r0, r0, sl, lsl r0
 164:	0000000c 	andeq	r0, r0, ip
 168:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 16c:	7c020001 	stcvc	0, cr0, [r2], {1}
 170:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 174:	0000000c 	andeq	r0, r0, ip
 178:	00000164 	andeq	r0, r0, r4, ror #2
 17c:	0800062c 	stmdaeq	r0, {r2, r3, r5, r9, sl}
 180:	00000002 	andeq	r0, r0, r2
 184:	0000000c 	andeq	r0, r0, ip
 188:	00000164 	andeq	r0, r0, r4, ror #2
 18c:	08000630 	stmdaeq	r0, {r4, r5, r9, sl}
 190:	00000002 	andeq	r0, r0, r2
 194:	0000000c 	andeq	r0, r0, ip
 198:	00000164 	andeq	r0, r0, r4, ror #2
 19c:	08000634 	stmdaeq	r0, {r2, r4, r5, r9, sl}
 1a0:	00000002 	andeq	r0, r0, r2
 1a4:	0000000c 	andeq	r0, r0, ip
 1a8:	00000164 	andeq	r0, r0, r4, ror #2
 1ac:	08000638 	stmdaeq	r0, {r3, r4, r5, r9, sl}
 1b0:	00000002 	andeq	r0, r0, r2
 1b4:	0000000c 	andeq	r0, r0, ip
 1b8:	00000164 	andeq	r0, r0, r4, ror #2
 1bc:	0800063c 	stmdaeq	r0, {r2, r3, r4, r5, r9, sl}
 1c0:	00000002 	andeq	r0, r0, r2
 1c4:	0000000c 	andeq	r0, r0, ip
 1c8:	00000164 	andeq	r0, r0, r4, ror #2
 1cc:	08000640 	stmdaeq	r0, {r6, r9, sl}
 1d0:	00000004 	andeq	r0, r0, r4
 1d4:	00000014 	andeq	r0, r0, r4, lsl r0
 1d8:	00000164 	andeq	r0, r0, r4, ror #2
 1dc:	08000644 	stmdaeq	r0, {r2, r6, r9, sl}
 1e0:	00000060 	andeq	r0, r0, r0, rrx
 1e4:	8e080e42 	cdphi	14, 0, cr0, cr8, cr2, {2}
 1e8:	00028401 	andeq	r8, r2, r1, lsl #8
 1ec:	0000000c 	andeq	r0, r0, ip
 1f0:	ffffffff 			; <UNDEFINED> instruction: 0xffffffff
 1f4:	7c020001 	stcvc	0, cr0, [r2], {1}
 1f8:	000d0c0e 	andeq	r0, sp, lr, lsl #24
 1fc:	00000018 	andeq	r0, r0, r8, lsl r0
 200:	000001ec 	andeq	r0, r0, ip, ror #3
 204:	080006a4 	stmdaeq	r0, {r2, r5, r7, r9, sl}
 208:	0000001a 	andeq	r0, r0, sl, lsl r0
 20c:	8e100e41 	cdphi	14, 1, cr0, cr0, cr1, {2}
 210:	84028501 	strhi	r8, [r2], #-1281	; 0x501
 214:	00048303 	andeq	r8, r4, r3, lsl #6

Дизассемблирование раздела .debug_ranges:

00000000 <.debug_ranges>:
   0:	0000007e 	andeq	r0, r0, lr, ror r0
   4:	00000082 	andeq	r0, r0, r2, lsl #1
   8:	0000008c 	andeq	r0, r0, ip, lsl #1
   c:	00000090 	muleq	r0, r0, r0
  10:	00000098 	muleq	r0, r8, r0
  14:	000000a0 	andeq	r0, r0, r0, lsr #1
	...
