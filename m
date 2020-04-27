Return-Path: <SRS0=jUvr=6L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB924C5519B
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 09:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C36206B6
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 09:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgD0JRG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgD0JRG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Apr 2020 05:17:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD93FC0610D5;
        Mon, 27 Apr 2020 02:17:05 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jSzss-0007Mc-CP; Mon, 27 Apr 2020 11:17:02 +0200
Date:   Mon, 27 Apr 2020 11:17:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PREEMPT_RT] 8250 IRQ lockup when flooding serial console (was
 Re: [ANNOUNCE] v5.4.28-rt19)
Message-ID: <20200427091701.ezf4nule5hg6jziq@linutronix.de>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
 <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
 <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm>
 <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
 <20200423160707.hqt5wjinzcec2yig@linutronix.de>
 <20200424191945.an42attvo7pdt3qz@linutronix.de>
 <nycvar.YFH.7.76.2004242245590.19713@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <nycvar.YFH.7.76.2004242245590.19713@cbobk.fhfr.pm>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-24 22:54:51 [+0200], Jiri Kosina wrote:
> It's still wonky; with the two hunks above on top of 5.6.4-rt3 (that's 
> without the PASS_LIMIT adjustment) flooding the emulated serial console 
> still emits the splat below.
…
> So now the endless interrupt storm comes at a different point -- exactly 
> once IRQs get re-enabled in prb_unlock(). How we reach prb_unlock() from 
> serial8250_tx_chars() I still have to understand. Worth involving John?

My guess is that it is unrelated and it is simply code that
disabled/enabled interrupts at the time the NMI was was triggered.

…
> [   75.286440] 000: rcu: INFO: rcu_preempt self-detected stall on CPU
> [   75.286533] 000: rcu: 	0-....: (1 GPs behind) idle=94a/1/0x4000000000000002 softirq=0/0 fqs=5167 
> [   75.286556] 000: 	(t=21000 jiffies g=15213 q=25248)

a RCU stall but it is only one GP behind :)
My guess here would be that simply we never had the opportunity to
perform perform a GP callbacks and nobody entered a RCU critical section
(we were busy printing on the console the whole time).

So a dummy RCU section like this:

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f61f6f5426eff..5636123a90580 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1145,6 +1145,8 @@ static int irq_thread(void *data)
 		migrate_enable();
 #endif
 		wake_threads_waitq(desc);
+		rcu_read_lock();
+		rcu_read_unlock();
 	}
 
 	/*


should work given the RCU-boosting is enabled.

…
> [  134.432670] 000: irq 4: nobody cared (try booting with the "irqpoll" option)
> [  134.432685] 000: CPU: 0 PID: 1209 Comm: irq/4-ttyS0 Not tainted 5.6.4-rt19-00003-g5cf51e8702ad #16
> [  134.432690] 000: Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014

yeah. again. I'm not sure if this is good or bad. The threaded
IRQ-handler runs constantly in this scenario. The core code *thinks*
that the handler makes no progress or is stuck and so it disables it.
It is not so far fetched. It wouldn't happen on real hardware actual HW
would take more time and so not "stuck" in the handler endlessly.

In networking, we would have NAPI which then pushes the driver to the
ksofitrqd which runs at SCHED_OTHER while here the IRQ thread runs at a
RT priority. I don't think we should add something like this to the 8250
driver to deal with the situation.

Sebastian
