From: Bo Hansen <bh@newtec.dk>
Subject: Re: hrtimer problem on AT91RM9200
Date: Fri, 21 Aug 2009 15:16:50 +0200
Message-ID: <4A8E9E42.6080802@newtec.dk>
References: <e420e28bcde8a6aa151902eb0f798c63@newtec.dk> <3efb10970908191121u3e88d35fs2606dcb76d877ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:53352 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932095AbZHUNQu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Aug 2009 09:16:50 -0400
In-Reply-To: <3efb10970908191121u3e88d35fs2606dcb76d877ac@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Remy,

Thank you for clarifying the setup.
The TC-block example was just what I was looking for.
I have the timer working so I'll give it a try and see if I
can fit it for our system.

Thank you for your time.

Best regards,
Bo

Remy Bohmer wrote:
> Hi,
>
>   
>> The Timer counter library sounds interesting - I previously took a look
>> at the source, but I miss some examples of how to use it. Do you know
>> anywhere I can find some beside tcb_clksrc.c?
>>     
>
> Mailinglist archives?
>
> But here is an example that produces a 400Hz (configurable) interrupt.
> -------------------------------------------------------------------------------------
> #include <linux/atmel_tc.h>
>
> static struct atmel_tc *tc;
> static int              tc_clk_id = 0; /* 0..2 (3 timers per TC-block) */
> static int              tc_blk_id = 1; /* 0..1 (2 TC-blocks on rm9200,
> 0 is used by clocksrc/clockevent */
> static int              tc_timer_freq = 400; /* HZ */
>
> static irqreturn_t tc_timer_interrupt(int irq, void *dummy)
> {
>         void __iomem    *tcaddr = tc->regs;
>         unsigned int    sr = __raw_readl(tcaddr + ATMEL_TC_REG(tc_clk_id, SR));
>
>         if (sr & ATMEL_TC_CPCS) {
>                 wakeup_my_thread(); /* Here you must wakeup your
> RT-thread (use wake_up_process() !!! )*/
>                 return IRQ_HANDLED;
>         }
>         return IRQ_NONE;
> }
>
> static struct irqaction tc_irqaction = {
>        .name           = "periodic-tc-timer",
>        .flags          = IRQF_NODELAY | IRQF_DISABLED,
>        .handler        = tc_timer_interrupt,
> };
>
> void install_tc_periodic_interrupt(void)
> {
>         void __iomem    *tcaddr;
>         int             rate;
>         int             res;
>
>         /* allocate the timer block */
>         tc = atmel_tc_alloc(tc_blk_id, tc_irqaction.name);
>         if (!tc) {
>                 printk(KERN_ERR "can't alloc TC\n");
>                 return -ENODEV;
>         }
>
>         tcaddr = tc->regs;
>
>         res = setup_irq(tc->irq[tc_clk_id], &tc_irqaction);
>         if (res) {
>                 printk(KERN_ERR "%s: Failed to install timer interrupt:%i\n",
>                         __func__, res);
>                 return res;
>         }
>
>         clk_enable(tc->clk[tc_clk_id]);
>
>         rate = clk_get_rate(tc->clk[tc_clk_id]);
>
>         /* Stop only the timer we will use */
>         __raw_writel(0xff, tcaddr + ATMEL_TC_REG(tc_clk_id, IDR));
>         __raw_writel(ATMEL_TC_CLKDIS, tcaddr + ATMEL_TC_REG(tc_clk_id, CCR));
>
>         /* Use MCK/8 (->CLOCK2), count up to RC, then irq and restart */
>         __raw_writel(ATMEL_TC_TIMER_CLOCK2
>                         | ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO,
>                         tcaddr + ATMEL_TC_REG(tc_clk_id, CMR));
>
>         __raw_writel((rate/8) / tc_timer_freq,
>                                 tcaddr + ATMEL_TC_REG(tc_clk_id, RC));
>
>         /* Enable clock and interrupts on RC compare */
>         __raw_writel(ATMEL_TC_CPCS, tcaddr + ATMEL_TC_REG(tc_clk_id, IER));
>
>         /* go go gadget! */
>         __raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
>                         tcaddr + ATMEL_TC_REG(tc_clk_id, CCR));
>         printk(KERN_INFO "TC interrupt source installed.\n");
> }
> -------------------------------------------------------------------------------------
>
>   
>> Correct me if I'm wrong but using TC you still have the RT patch applied,
>> but just disabled HRT/dynticks?
>>     
>
> Yes indeed. We use the RT-patch on these processors without
> HRT/dynticks. We only use the OS/Posix-timers for non-realtime
> applications, so CONFIG_HZ can be set low to reduce the timer
> interrupt load.
>
>   
>> Do you have any idea of the overhead of TC@1ms compared with
>> CONFIG_HZ=1000?
>>     
>
> The difference between the 2 is that the kernel does not need to
> handle all the elapsed timers on every timer interrupt, but instead
> just waking up a single thread.
> FYI, I made measurements of it some time ago that shows what happens
> on a single timer interrupt on this processor, and I attached a
> screenshot to this mail.
>
> Have fun!
>
> Remy
>   
>
> ------------------------------------------------------------------------
>
