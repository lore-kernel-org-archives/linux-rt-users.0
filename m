From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: High latencies on MPC5200 with patch-2.6.24-rc5-rt1
Date: Fri, 11 Jan 2008 10:22:34 +0100
Message-ID: <4787355A.5090203@grandegger.com>
References: <47834CB7.1030102@grandegger.com> <20080110000124.GW3177@pengutronix.de> <47861ACE.9060301@grandegger.com> <200801101648.05550.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030306010207000301030904"
Cc: linux-rt-users@vger.kernel.org,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <johnstul@us.ibm.com>
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:43124 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760921AbYAKJWj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jan 2008 04:22:39 -0500
In-Reply-To: <200801101648.05550.jbe@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030306010207000301030904
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hi Jürgen,

Juergen Beisert wrote:
> On Thursday 10 January 2008 14:17, Wolfgang Grandegger wrote:
>> Hi Robert,
>>
>> Robert Schwebel wrote:
>>> Wolfgang,
>>>
>>> On Wed, Jan 09, 2008 at 11:51:07PM +0100, Robert Schwebel wrote:
>>>> Throwing in the versions from 2.6.23.3-rt5 doesn't help, the effect
>>>> stays the same. So I assume it is a side effect.
>>> Can you test the following patch by John Stulz (thanks to John for the
>>> quick help on irc!), which fixes the issues on my board:
>>>
>>> ----------8<----------
>>> Index: linux-2.6.24-rc5/arch/powerpc/kernel/time.c
>>> ===================================================================
>>> --- linux-2.6.24-rc5.orig/arch/powerpc/kernel/time.c
>>> +++ linux-2.6.24-rc5/arch/powerpc/kernel/time.c
>>> @@ -773,7 +773,7 @@ void update_vsyscall(struct timespec *wa
>>>  	stamp_xsec = (u64) xtime.tv_nsec * XSEC_PER_SEC;
>>>  	do_div(stamp_xsec, 1000000000);
>>>  	stamp_xsec += (u64) xtime.tv_sec * XSEC_PER_SEC;
>>> -	update_gtod(clock->cycle_last, stamp_xsec, t2x);
>>> +	update_gtod(clock->cycle_last-clock->cycle_accumulated, stamp_xsec,
>>> t2x); }
>>>
>>>  void update_vsyscall_tz(void)
>>> ----------8<----------
>>>
>>> With this patch ontop of 2.6.24-rc5-rt1 plus the board support patches
>>> for the phyCORE-MPC5200B-tiny, I get this result from cyclictest, again
>>> under "(while true; do hackbench 10; done) &" load:
>>>
>>> T: 0 (  867) P:80 I:   10000 C:  105002 Min:      31 Act:      48 Avg:   
>>>   51 Max:      92
>> Unfortunately, it doesn't really help on my Icecube board.
>>
>> bash-3.00# ./cyclictest -n -p80 -i1000
>> 129.85 93.18 38.05 4/45 6354
>> 130.41 162.23 83.05 3/49 8395
>> T: 0 ( 4621) P:80 I:1000 C: 477097 Min:     25 Act:   64 Avg:   67 Max:
>>     286
>>
>> bash-3.00# ./hackbench 10
>> Time: 95.402
>>
>> Could you run your cyclictest much longer?
>>
>> And hackbench takes ages, already without running cyclictest:
> 
> Did your read http://lkml.org/lkml/2007/12/7/181 ? Don't know if it is 
> relevant here.

Seems somehow related but my -rt kernel already selects SLAB:

  $ cat init/Kconfig
  ...
  config SLUB
        bool "SLUB (Unqueued Allocator)"
        depends on !PREEMPT_RT

With SLUB re-enabled I get the attached interesting oops.

Wolfgang.


--------------030306010207000301030904
Content-Type: text/x-log;
 name="oops.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.log"

[    5.287422] BUG: sleeping function called from invalid context IRQ-192(735) at kernel/rtmutex.c:638
[    5.296678] in_atomic():0 [00000000], irqs_disabled():1
[    5.302009] Call Trace:
[    5.304501] [c39e1e50] [c000919c] show_stack+0x50/0x190 (unreliable)
[    5.311024] [c39e1e80] [c001b3c4] __might_sleep+0xec/0x110
[    5.316652] [c39e1e90] [c0207ad8] __lock_text_start+0x88/0xa0
[    5.322531] [c39e1ea0] [c007c2a8] __slab_alloc+0x3cc/0x644
[    5.328141] [c39e1ed0] [c007cf70] __kmalloc_track_caller+0xdc/0xe4
[    5.334461] [c39e1ef0] [c01803e4] __alloc_skb+0x60/0x120
[    5.339910] [c39e1f10] [c01561c8] mpc52xx_fec_rx_interrupt+0x180/0x308
[    5.346587] [c39e1f40] [c0051620] handle_IRQ_event+0x6c/0x110
[    5.352471] [c39e1f70] [c0051fac] thread_simple_irq+0x88/0x114
[    5.358434] [c39e1f90] [c0052364] do_irqd+0x32c/0x3ac
[    5.363597] [c39e1fd0] [c003ad28] kthread+0x84/0x8c
[    5.368590] [c39e1ff0] [c0010b90] kernel_thread+0x44/0x60

--------------030306010207000301030904--
