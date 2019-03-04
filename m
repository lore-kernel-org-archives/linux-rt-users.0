Return-Path: <SRS0=pHM8=RH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234ACC43381
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 22:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE864206DD
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Mar 2019 22:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfCDWB7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:01:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDWB7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Mar 2019 17:01:59 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h0vej-0001Dw-2S; Mon, 04 Mar 2019 23:01:53 +0100
Date:   Mon, 4 Mar 2019 23:01:53 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com,
        gregkh@linuxfoundation.org,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] tty/sysrq: Convert show_lock to raw_spinlock_t
Message-ID: <20190304220152.nozgclpu2jx3zgvy@linutronix.de>
References: <20190304172053.17340-1-julien.grall@arm.com>
 <545fb96e-0f07-758e-5c79-a725e74e3387@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <545fb96e-0f07-758e-5c79-a725e74e3387@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-04 17:21:57 [+0000], Julien Grall wrote:
> (CC correctly linux-rt-users)
> 
> On 04/03/2019 17:20, Julien Grall wrote:
> > At the moment show_lock is implemented using spin_lock_t and called from
> > an interrupt context on Arm64. The following backtrace was triggered by:
> > 
> > 42sh# echo l > /proc/sysrq-trigger
> > 
> > [ 4432.073756] sysrq: SysRq : Show backtrace of all active CPUs
> > [ 4432.403422] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:974
> > [ 4432.403424] sysrq: CPU6:
> > [ 4432.403426] in_atomic(): 1, irqs_disabled(): 128, pid: 2410, name: kworker/u16:2
> > 
> > [...]
> > 
> > [ 4432.403581] Call trace:
> > [ 4432.403584]  dump_backtrace+0x0/0x148
> > [ 4432.403586]  show_stack+0x14/0x20
> > [ 4432.403588]  dump_stack+0x9c/0xd4
> > [ 4432.403592]  ___might_sleep+0x1cc/0x298
> > [ 4432.403595]  rt_spin_lock+0x5c/0x70
> > [ 4432.403596]  showacpu+0x34/0x68
> > [ 4432.403599]  flush_smp_call_function_queue+0xd4/0x278
> > [ 4432.403602]  generic_smp_call_function_single_interrupt+0x10/0x18
> > [ 4432.403605]  handle_IPI+0x26c/0x668
> > [ 4432.403607]  gic_handle_irq+0x9c/0xa0
> > [ 4432.403609]  el1_irq+0xb4/0x13c
> > 
> > With RT-patches, spin_lock can now sleep and therefore cannot be used from
> > interrupt context. Use a raw_spin_lock instead to prevent the lock to
> > sleep.
> > 
> > Signed-off-by: Julien Grall <julien.grall@arm.com>

I don't have to look at this properly but this looks is wrong. 
Please CC the RT developers if you plan any changes that affects primary
only the RT tree. This change is a nop for the !RT tree.

> >   drivers/tty/sysrq.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > index 1f03078ec352..8473557c7ab2 100644
> > --- a/drivers/tty/sysrq.c
> > +++ b/drivers/tty/sysrq.c
> > @@ -208,7 +208,7 @@ static struct sysrq_key_op sysrq_showlocks_op = {
> >   #endif
> >   #ifdef CONFIG_SMP
> > -static DEFINE_SPINLOCK(show_lock);
> > +static DEFINE_RAW_SPINLOCK(show_lock);
> >   static void showacpu(void *dummy)
> >   {
> > @@ -218,10 +218,10 @@ static void showacpu(void *dummy)
> >   	if (idle_cpu(smp_processor_id()))
> >   		return;
> > -	spin_lock_irqsave(&show_lock, flags);
> > +	raw_spin_lock_irqsave(&show_lock, flags);
> >   	pr_info("CPU%d:\n", smp_processor_id());
> >   	show_stack(NULL, NULL);
> > -	spin_unlock_irqrestore(&show_lock, flags);
> > +	raw_spin_unlock_irqrestore(&show_lock, flags);
> >   }
> >   static void sysrq_showregs_othercpus(struct work_struct *dummy)
> > 

Sebastian
