From: Bo Hansen <bh@newtec.dk>
Subject: Re: hrtimer problem on AT91RM9200
Date: Thu, 10 Sep 2009 08:44:11 +0200
Message-ID: <4AA8A03B.2050804@newtec.dk>
References: <4A8BEF09.2080300@newtec.dk> <20090820195200.GA3331@pengutronix.de> <4A8E99C7.6080106@newtec.dk> <20090903141217.GB22289@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060202080409010300060802"
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:47256 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755167AbZIJGoK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Sep 2009 02:44:10 -0400
In-Reply-To: <20090903141217.GB22289@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060202080409010300060802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe,

Sorry for my late reply.

I only get the initialization line:
************** at91rm9200_timer_init: shift=32, mult=140737,
min_delta_ns=61036, minclc=2  

I have attached the kernel panic.

Best regards,
Bo


Uwe Kleine-König wrote:
> Hello,
>
> On Fri, Aug 21, 2009 at 02:57:43PM +0200, Bo Hansen wrote:
>   
>> Hi Uwe,
>>
>> I cannot find anything in the dmesg or serial output regarding the
>> WARN_ON_ONCE(...)
>> I guess the WARN_ON_ONCE(...) should show up in dmesg output?
>>
>> What puzzles me is that I tried the CONFIG_DEBUG_BUGVERBOSE=y
>> also when I enabled CONFIG_DEBUG_INFO. When I do
>> this I don't get the kernel panic. Is this somehow related to the
>> WARN_ON_ONCE?
>>
>> Attachments only sent to Uwe - anybody are welcome to get a copy.
>>     
> Hhhhmm, clkevt32k_next_event is called with delta=1 which hits
> BUG_ON(delta < 2).
>
> I calculated the clockeventdevice parameters by hand, and the numbers
> look good:
>
> 	clkevt.shift = 32
> 	clkevt.mult = div_sc(AT91_SLOW_CLOCK, NSEC_PER_SEC, clkevt.shift)
> 		= (32768 << 32) / 1000000000
> 		= 140737
> 	clkevt.min_delta_ns = clockevent_delta2ns(2, &clkevt) + 1
> 		= (2 << clkevt.shift) / clkevt.mult + 1
> 		= (2 << 32) / 140737 + 1
> 		= 61036
> 	min_delta = (clkevt.min_delta_ns * mult) >> clkevt.shift
> 		= (61036 * 140737) >> 32
> 		= 2
>
> Can you please apply the patch below, reproduce and provide the two
> lines of output resulting from the two added printks?
>
> Best regards
> Uwe
>
> diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
> index 1ff1bda..83a7379 100644
> --- a/arch/arm/mach-at91/at91rm9200_time.c
> +++ b/arch/arm/mach-at91/at91rm9200_time.c
> @@ -136,7 +136,13 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
>  	u32		alm;
>  	int		status = 0;
>  
> -	BUG_ON(delta < 2);
> +	if (unlikely(delta < 2)) {
> +		pr_emerg("************** %s: shift=%d, mult=%lu, "
> +				"min_delta_ns=%lu, dev=%pS\n", __func__,
> +				dev->shift, dev->mult,
> +				dev->min_delta_ns, dev);
> +		BUG();
> +	}
>  
>  	/* Use "raw" primitives so we behave correctly on RT kernels. */
>  	raw_local_irq_save(flags);
> @@ -205,6 +211,18 @@ void __init at91rm9200_timer_init(void)
>  	clkevt.mult = div_sc(AT91_SLOW_CLOCK, NSEC_PER_SEC, clkevt.shift);
>  	clkevt.max_delta_ns = clockevent_delta2ns(AT91_ST_ALMV, &clkevt);
>  	clkevt.min_delta_ns = clockevent_delta2ns(2, &clkevt) + 1;
> +
> +	{
> +		unsigned long long clc = (int64_t)clkevt.min_delta_ns *
> +			clkevt.mult;
> +
> +		clc >>= clkevt.shift;
> +
> +		pr_info("************** %s: shift=%d, mult=%lu, "
> +				"min_delta_ns=%lu, minclc=%llu\n", __func__,
> +				clkevt.shift, clkevt.mult,
> +				clkevt.min_delta_ns, clc);
> +	}
>  	clkevt.cpumask = cpumask_of(0);
>  	clockevents_register_device(&clkevt);
>  
>
>
>
>
>   

--------------060202080409010300060802
Content-Type: text/plain;
 name="100909_kernel_panic_2.6.29.6-rt23-debug-uwe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="100909_kernel_panic_2.6.29.6-rt23-debug-uwe"

Unable to handle kernel NULL pointer dereference at virtual address 00000000                                                                      
pgd = c3930000                                                                  
[00000000] *pgd=2386e031, *pte=00000000, *ppte=00000000                         
Internal error: Oops: 817 [#1] PREEMPT                                          
Modules linked in:                                                              
CPU: 0    Not tainted  (2.6.29.6-rt23 #1)                                       
PC is at clkevt32k_next_event+0x94/0xd8                                         
LR is at rt_mutex_unlock+0x10/0x14                                              
pc : [<c002efac>]    lr : [<c0256e40>]    psr: 00000093                         
sp : c3a6fc20  ip : c3a6fb30  fp : c3a6fc44                                     
r10: 00000001  r9 : 00000000  r8 : c02f6a30                                     
r7 : 00000032  r6 : 00000000  r5 : 00000001  r4 : 00000000                      
r3 : 00000000  r2 : 00010002  r1 : 60000093  r0 : 00000062                      
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user              
Control: c000717f  Table: 23930000  DAC: 00000015                               
Process cyclictest (pid: 579, stack limit = 0xc3a6e270)                         
Stack: (0xc3a6fc20 to 0xc3a70000)                                               
fc20: 0000dcaa c02f6a30 00013bc9 00000000 000225c1 00000000 c3a6fc6c c3a6fc48   
fc40: c005a20c c002ef28 00000000 0083ad27 00000032 0082d07d 00000032 c02f6a30   
fc60: c3a6fcbc c3a6fc70 c005aed4 c005a120 0082d07d 00000032 0083ad27 00000032   
fc80: 0082d07d 00000032 0082bdb6 00000032 3bccb551 00829826 00000032 00000032   
fca0: c02f9de0 00829826 00000032 c3a6e000 c3a6fcdc c3a6fcc0 c005af78 c005ae18   
fcc0: 00000001 00000000 c02f9de0 0082947f c3a6fd3c c3a6fce0 c0052188 c005af58   
fce0: 3fd06258 c02f6a30 0082947f 00000032 c3a6fd1c c02f9de0 00000001 00000000   
fd00: 0082947f 00000032 c02f9de0 198461bc c3a6fd7c c02f6a08 00010002 c3a6e000   
fd20: 00000001 00000000 00000000 00000001 c3a6fd5c c3a6fd40 c002f0a4 c0051f54   
fd40: 198461bc c02f6a08 00010002 c3a6e000 c3a6fd8c c3a6fd60 c0065168 c002f000   
fd60: 00000001 c02fa4f8 c3a6e000 c02f6a08 00000001 00000001 c3a6e000 c3a6e000   
fd80: c3a6fdac c3a6fd90 c0067908 c0065124 00000001 c0302d40 00000000 00000002   
fda0: c3a6fdcc c3a6fdb0 c002506c c0067814 00000000 ffffffff fefff000 00000001   
fdc0: c3a6fe74 c3a6fdd0 c00259dc c0025010 00000000 c3a67ef8 c3a5fef8 40000013   
fde0: 40000013 00000000 0233a240 00000032 c3a6fef8 c02f9de0 c3a6e000 c3a6fe74   
fe00: c3a67ef8 c3a6fe18 c3a47ef8 c00528a4 60000013 ffffffff 00000000 00000000   
fe20: 00000000 40000013 0233a240 00000032 00000000 00000000 c00540a8 c0054044   
fe40: 00000000 c3a6e000 c3a6fe7c 3b9aca00 00000032 00000000 00000000 00000000   
fe60: 00000000 c3a6fef8 c3a6fe94 c3a6fe78 c00529cc c0052758 00000000 00000000   
fe80: 00000001 3b9aca00 c3a6fed4 c3a6fe98 c02569ac c00529b4 00000000 00000000   
fea0: c3a6e000 00000000 c02f9de0 00000000 00000000 00000000 c3a6ff80 c3a6e000   
fec0: 00000000 00000000 c3a6ff64 c3a6fed8 c0052a8c c0256904 00000000 00000000   
fee0: 38a09550 00000000 0233a240 00000032 00000000 00000000 c0310700 00000000   
ff00: 00000000 00000000 0233a240 00000032 0233a240 00000032 c0051e68 c02f9de0   
ff20: 00000001 c3a6ff24 c3a6ff24 00000001 c3a63680 c003bf78 c3a6ff88 00000001   
ff40: 00000001 00000000 c3a6ff80 c0025f44 c3a6e000 00017690 c3a6ff7c c3a6ff68   
ff60: c004c8d0 c00529e4 c0025f44 00000001 c3a6ffa4 c3a6ff80 c004ca00 c004c8b4   
ff80: 00000032 0233a240 00000001 00000000 5396ddec 00000109 00000000 c3a6ffa8   
ffa0: c0025dc0 c004c8e4 00000001 00000000 00000001 00000001 5396ddec 00000000   
ffc0: 00000001 00000000 5396ddec 00000109 00000001 00015c60 00017690 5396ddf4   
ffe0: 00000000 5396dc50 4004680c 4004682c 60000010 00000001 00000000 00000000   
Backtrace:                                                                      
[<c002ef18>] (clkevt32k_next_event+0x0/0xd8) from [<c005a20c>] (clockevents_prog
ram_event+0xfc/0x168)                                                           
 r6:00000000 r5:000225c1 r4:00000000                                            
[<c005a110>] (clockevents_program_event+0x0/0x168) from [<c005aed4>] (tick_dev_p
rogram_event+0xcc/0xf8)                                                         
 r8:c02f6a30 r7:00000032 r6:0082d07d r5:00000032 r4:0083ad27                    
[<c005ae08>] (tick_dev_program_event+0x0/0xf8) from [<c005af78>] (tick_program_e
vent+0x30/0x3c)                                                                 
[<c005af48>] (tick_program_event+0x0/0x3c) from [<c0052188>] (hrtimer_interrupt+
0x244/0x2e8)                                                                    
 r5:0082947f r4:c02f9de0                                                        
[<c0051f44>] (hrtimer_interrupt+0x0/0x2e8) from [<c002f0a4>] (at91rm9200_timer_i
nterrupt+0xb4/0xc8)                                                             
[<c002eff0>] (at91rm9200_timer_interrupt+0x0/0xc8) from [<c0065168>] (handle_IRQ
_event+0x54/0xec)                                                               
 r6:c3a6e000 r5:00010002 r4:c02f6a08                                            
[<c0065114>] (handle_IRQ_event+0x0/0xec) from [<c0067908>] (handle_level_irq+0x1
04/0x174)                                                                       
[<c0067804>] (handle_level_irq+0x0/0x174) from [<c002506c>] (_text+0x6c/0x8c)   
 r7:00000002 r6:00000000 r5:c0302d40 r4:00000001                                
[<c0025000>] (_text+0x0/0x8c) from [<c00259dc>] (__irq_svc+0x3c/0x80)           
Exception stack(0xc3a6fdd0 to 0xc3a6fe18)                                       
fdc0:                                     00000000 c3a67ef8 c3a5fef8 40000013   
fde0: 40000013 00000000 0233a240 00000032 c3a6fef8 c02f9de0 c3a6e000 c3a6fe74   
fe00: c3a67ef8 c3a6fe18 c3a47ef8 c00528a4 60000013 ffffffff                     
 r6:00000001 r5:fefff000 r4:ffffffff                                            
[<c0052748>] (__hrtimer_start_range_ns+0x0/0x228) from [<c00529cc>] (hrtimer_sta
rt_range_ns+0x28/0x30)                                                          
[<c00529a4>] (hrtimer_start_range_ns+0x0/0x30) from [<c02569ac>] (do_nanosleep+0
xb8/0x114)                                                                      
[<c02568f4>] (do_nanosleep+0x0/0x114) from [<c0052a8c>] (hrtimer_nanosleep+0xb8/
0x140)                                                                          
[<c00529d4>] (hrtimer_nanosleep+0x0/0x140) from [<c004c8d0>] (common_nsleep+0x2c
/0x30)                                                                          
[<c004c8a4>] (common_nsleep+0x0/0x30) from [<c004ca00>] (sys_clock_nanosleep+0x1
2c/0x150)                                                                       
 r4:00000001                                                                    
[<c004c8d4>] (sys_clock_nanosleep+0x0/0x150) from [<c0025dc0>] (ret_fast_syscall
+0x0/0x2c)                                                                      
 r7:00000109 r6:5396ddec r5:00000000 r4:00000001                                
Code: e59f1040 e88d5000 eb0024fc e3a03000 (e5833000)                            
Kernel panic - not syncing: Fatal exception in interrupt 

--------------060202080409010300060802
Content-Type: text/plain;
 name="100909_kernel_panic_2.6.29.6-rt23-debug-uwe2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="100909_kernel_panic_2.6.29.6-rt23-debug-uwe2"

Unable to handle kernel NULL pointer dereference at virtual address 00000000    
pgd = c0004000                                                                  
[00000000] *pgd=00000000                                                        
Internal error: Oops: 817 [#1] PREEMPT                                          
Modules linked in:                                                              
CPU: 0    Not tainted  (2.6.29.6-rt23 #1)                                       
PC is at clkevt32k_next_event+0x94/0xd8                                         
LR is at rt_mutex_unlock+0x10/0x14                                              
pc : [<c002efac>]    lr : [<c0256e40>]    psr: 00000093                         
sp : c02f3d90  ip : c02f3ca0  fp : c02f3db4                                     
r10: 00000000  r9 : 00000000  r8 : c02f6a30                                     
r7 : 0000004a  r6 : 00000000  r5 : 00000001  r4 : 00000000                      
r3 : 00000000  r2 : 00010002  r1 : 60000093  r0 : 00000062                      
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel            
Control: c000717f  Table: 23890000  DAC: 00000017                               
Process swapper (pid: 0, stack limit = 0xc02f2270)                              
Stack: (0xc02f3d90 to 0xc02f4000)                                               
3d80:                                     0000c6c0 c02f6a30 131806f5 00000000   
3da0: 000225c1 00000000 c02f3ddc c02f3db8 c005a20c c002ef28 0000004a 13797362   
3dc0: 0000004a 13796120 0000004a c02f6a30 c02f3e2c c02f3de0 c005aed4 c005a120   
3de0: 13796120 0000004a 4f140486 00000000 00000000 c02f3e70 13796120 0000004a   
3e00: 4e6c7a07 13797362 0000004a 0000004a c02f9de0 13797362 0000004a c02f2000   
3e20: c02f3e4c c02f3e30 c005af78 c005ae18 00000001 00000000 c02f9de0 13793a86   
3e40: c02f3eac c02f3e50 c0052188 c005af58 3fd06258 c02f6a30 13793a86 0000004a   
3e60: c0065168 c02f9de0 00000001 00000000 13793a86 0000004a c02f2000 c0302d40   
3e80: c02f3e9c c02f6a08 00010002 c02f2000 00000001 00000000 00000000 00000001   
3ea0: c02f3ecc c02f3eb0 c002f0a4 c0051f54 c38eb1e0 c02f6a08 00010002 c02f2000   
3ec0: c02f3efc c02f3ed0 c0065168 c002f000 c02f3ef4 c02fa4f8 c02f2000 c02f6a08   
3ee0: 00000001 00000001 c02f2000 2001fce8 c02f3f1c c02f3f00 c0067908 c0065124   
3f00: 00000001 c0302d40 00000000 00000002 c02f3f3c c02f3f20 c002506c c0067814   
3f20: c02f3f54 ffffffff fefff000 00000001 c02f3f94 c02f3f40 c00259dc c0025010   
3f40: 00000000 00000001 c02f2000 60000013 c0026eb0 c02f2000 c02f5eb0 c03104e0   
3f60: 2001fd1c 41129200 2001fce8 c02f3f94 c02f3f98 c02f3f88 c0026ef0 c0026efc   
3f80: 60000013 ffffffff c02f3fb4 c02f3f98 c0026db0 c0026ec0 c02f2000 c031048c   
3fa0: c00222c0 c02f5ce0 c02f3fcc c02f3fb8 c02540dc c0026d70 c031048c c03195fc   
3fc0: c02f3ff4 c02f3fd0 c0008b38 c0254068 c0008594 00000000 00000000 c0021ebc   
3fe0: c0007175 c0310518 00000000 c02f3ff8 20008034 c0008970 00000000 00000000   
Backtrace:                                                                      
[<c002ef18>] (clkevt32k_next_event+0x0/0xd8) from [<c005a20c>] (clockevents_prog
ram_event+0xfc/0x168)                                                           
 r6:00000000 r5:000225c1 r4:00000000                                            
[<c005a110>] (clockevents_program_event+0x0/0x168) from [<c005aed4>] (tick_dev_p
rogram_event+0xcc/0xf8)                                                         
 r8:c02f6a30 r7:0000004a r6:13796120 r5:0000004a r4:13797362                    
[<c005ae08>] (tick_dev_program_event+0x0/0xf8) from [<c005af78>] (tick_program_e
vent+0x30/0x3c)                                                                 
[<c005af48>] (tick_program_event+0x0/0x3c) from [<c0052188>] (hrtimer_interrupt+
0x244/0x2e8)                                                                    
 r5:13793a86 r4:c02f9de0                                                        
[<c0051f44>] (hrtimer_interrupt+0x0/0x2e8) from [<c002f0a4>] (at91rm9200_timer_i
nterrupt+0xb4/0xc8)                                                             
[<c002eff0>] (at91rm9200_timer_interrupt+0x0/0xc8) from [<c0065168>] (handle_IRQ
_event+0x54/0xec)                                                               
 r6:c02f2000 r5:00010002 r4:c02f6a08                                            
[<c0065114>] (handle_IRQ_event+0x0/0xec) from [<c0067908>] (handle_level_irq+0x1
04/0x174)                                                                       
[<c0067804>] (handle_level_irq+0x0/0x174) from [<c002506c>] (_text+0x6c/0x8c)   
 r7:00000002 r6:00000000 r5:c0302d40 r4:00000001                                
[<c0025000>] (_text+0x0/0x8c) from [<c00259dc>] (__irq_svc+0x3c/0x80)           
Exception stack(0xc02f3f40 to 0xc02f3f88)                                       
3f40: 00000000 00000001 c02f2000 60000013 c0026eb0 c02f2000 c02f5eb0 c03104e0   
3f60: 2001fd1c 41129200 2001fce8 c02f3f94 c02f3f98 c02f3f88 c0026ef0 c0026efc   
3f80: 60000013 ffffffff                                                         
 r6:00000001 r5:fefff000 r4:ffffffff                                            
[<c0026eb0>] (default_idle+0x0/0x54) from [<c0026db0>] (cpu_idle+0x50/0xac)     
[<c0026d60>] (cpu_idle+0x0/0xac) from [<c02540dc>] (rest_init+0x84/0x9c)        
 r7:c02f5ce0 r6:c00222c0 r5:c031048c r4:c02f2000                                
[<c0254058>] (rest_init+0x0/0x9c) from [<c0008b38>] (start_kernel+0x1d8/0x2c8)  
 r4:c03195fc                                                                    
[<c0008960>] (start_kernel+0x0/0x2c8) from [<20008034>] (0x20008034)            
 r5:c0310518 r4:c0007175                                                        
Code: e59f1040 e88d5000 eb0024fc e3a03000 (e5833000)                            
Kernel panic - not syncing: Fatal exception in interrupt         

--------------060202080409010300060802--
