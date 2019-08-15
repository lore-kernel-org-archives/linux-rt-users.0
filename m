Return-Path: <SRS0=hjoW=WL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27837C3A589
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 14:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032312084D
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 14:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfHOOT0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:19:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39882 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbfHOOT0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Aug 2019 10:19:26 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyGb5-0006Xa-Mr; Thu, 15 Aug 2019 16:19:23 +0200
Date:   Thu, 15 Aug 2019 16:19:23 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Paul Thomas <pthomas8589@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
Message-ID: <20190815141923.yu6obojglb2hjsia@linutronix.de>
References: <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
 <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
 <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
 <20190814112656.z3de2rgbqzpaquz5@linutronix.de>
 <CAD56B7ezpaONhXCddu6RTE33-iXG7+J=xf417xu_uT-YKPV6RQ@mail.gmail.com>
 <20190815082955.olo3phbqj6disk3q@linutronix.de>
 <87a7ca4nh6.fsf@linutronix.de>
 <20190815134248.abwbufgwh4zybj4g@linutronix.de>
 <CAD56B7eFQfvq6cWnT6um4M2Y7LAr5tz0=PvpeWM=QfwAU6pFyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAD56B7eFQfvq6cWnT6um4M2Y7LAr5tz0=PvpeWM=QfwAU6pFyA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-15 09:52:56 [-0400], Paul Thomas wrote:
> > > Emergency messages are not involved here. You can see at 84239098us that
> > Right, we don't have that. Let me boot my arm64, print something and
> > check how it goes…
> Thanks! Nothing too crazy is happening with printk in my setup. Mostly
> I just see systemd messages like this:
> [55458.630872] systemd-journald[1072]: Sent WATCHDOG=1 notification.
> [55578.632076] systemd-journald[1072]: Sent WATCHDOG=1 notification.

so that explains it. Here, I have

|           printk-106   [001] ....111   610.156787: pl011_read <-pl011_console_putchar
|           printk-106   [001] d..h211   610.156788: irq_find_mapping <-__handle_domain_irq
…
|           printk-106   [001] dN.h211   610.156812: preempt_count_sub <-irq_exit
|           printk-106   [001] .N..111   610.156813: pl011_read <-pl011_console_putchar
|       cyclictest-802   [001] d...3..   610.156815: finish_task_switch <-__schedule

so it seems to works but I *think* that at 610.156813 shouldn't be there
and it should switch to cyclictest. But if it is the broken irq-exit
path then this should fix it:

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 63c6960262861..27a16c2711981 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -649,13 +649,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 alternative_else_nop_endif
 
 	cbz	x24, 1f					// (need_resched + count) == 0
-	cbnz	w24, 2f					// count != 0
-
-	ldr	w24, [tsk, #TSK_TI_PREEMPT_LAZY]	// get preempt lazy count
-	cbnz	w24, 2f					// preempt lazy count != 0
-
-	ldr	x0, [tsk, #TSK_TI_FLAGS]		// get flags
-	tbz	x0, #TIF_NEED_RESCHED_LAZY, 2f		// needs rescheduling?
+	b	2f					// count != 0
 1:
 	bl	preempt_schedule_irq		// irq en/disable is done inside
 2:

> -Paul

Sebastian
