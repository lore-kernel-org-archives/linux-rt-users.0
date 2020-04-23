Return-Path: <SRS0=c0v5=6H=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006B7C55191
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 16:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF0920767
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Apr 2020 16:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgDWQHL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729386AbgDWQHK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Apr 2020 12:07:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C9EC09B040;
        Thu, 23 Apr 2020 09:07:10 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jReNX-0000y2-Et; Thu, 23 Apr 2020 18:07:07 +0200
Date:   Thu, 23 Apr 2020 18:07:07 +0200
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
Message-ID: <20200423160707.hqt5wjinzcec2yig@linutronix.de>
References: <20200330144712.cwcz5ejal4ankeoi@linutronix.de>
 <nycvar.YEU.7.76.2004231017470.4730@gjva.wvxbf.pm>
 <nycvar.YFH.7.76.2004231111550.19713@cbobk.fhfr.pm>
 <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200423104559.rgplz6rqk6sg4kz7@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-23 12:45:59 [+0200], To Jiri Kosina wrote:
> On 2020-04-23 11:12:59 [+0200], Jiri Kosina wrote:
> > On Thu, 23 Apr 2020, Jiri Kosina wrote:
> > 
> > > > I'm pleased to announce the v5.4.28-rt19 patch set. 
> > > 
> > > First, I don't believe this is necessarily a regression coming with this 
> > > particular version, but this is the first kernel where I tried this and it 
> > > crashed.
> > 
> > I just tried with 5.6.4-rt3, and I can make it explode exactly the same 
> > way:
> 
> I though I dealt with it. In the past it triggered also with threadirqs
> on !RT but this isn't the case anymore. It still explodes on RT. Let me
> look…

So it also happens with !RT, you just have to try a little harder. For
instance in drivers/tty/serial/8250/8250_core.c making the PASS_LIMIT
change apply to !RT and boom.

The IRQ4 is edge and in charge of ttyS0. It is handled by
handle_edge_irq() and after ->irq_ack(), the thread is woken up and then
we get another ->handle_edge_irq() for IRQ4. With larger PASS_LIMIT the
thread runs longer so note_interrupt() will make less IRQ_HANDLED based
on ->threads_handled_last. If it observes 100 handled within 100000
interrupts then the counters are reset again. On !RT it usually manages
to get >100 per 100000 interrupts so it appears good. On RT it gets less
and the interrupt gets disabled.

So it is not RT related, but RT triggers it more reliably (also the
PASS_LIMIT change can vanish).
I can't tell if this is a qemu bug in emulating the HW or not. I can't
reproduce it real HW. I see a second edge interrupt only after the
thread completed. I can't tell if this is because it is a real UART and
the data is flowing slower or because the edge-IRQ is not triggered
repeatedly.

Sebastian
