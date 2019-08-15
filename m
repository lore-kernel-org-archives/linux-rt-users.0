Return-Path: <SRS0=hjoW=WL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BB8C3A589
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95984206C1
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 13:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfHONmv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:42:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39805 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732438AbfHONmv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Aug 2019 09:42:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyG1g-0005ka-CE; Thu, 15 Aug 2019 15:42:48 +0200
Date:   Thu, 15 Aug 2019 15:42:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Paul Thomas <pthomas8589@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
Message-ID: <20190815134248.abwbufgwh4zybj4g@linutronix.de>
References: <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
 <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
 <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
 <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
 <20190814112656.z3de2rgbqzpaquz5@linutronix.de>
 <CAD56B7ezpaONhXCddu6RTE33-iXG7+J=xf417xu_uT-YKPV6RQ@mail.gmail.com>
 <20190815082955.olo3phbqj6disk3q@linutronix.de>
 <87a7ca4nh6.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87a7ca4nh6.fsf@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-15 14:33:41 [+0200], John Ogness wrote:
> On 2019-08-15, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >> The attachment is here:
> >> https://bugzilla.kernel.org/attachment.cgi?id=284391
> >
> > both traces have `printk' in it. Could you please explain what it is
> > doing?  It should print something to the console. The printk code in
> > v4.19 vs later changed and now (by default) ERR levels are printed
> > immediately and will cause latency spikes.
> >
> > This would explain the spike but I don't understand how lazy preempt
> > is related here.
> 
> Where in this trace is there a latency spike? I could not see one.

|   printk-873     1....111 84243670us : cdns_uart_console_putchar <-uart_console_write
|   printk-873     1....111 84243711us : cdns_uart_console_putchar <-uart_console_write
|   printk-873     1d...111 84243731us : gic_handle_irq <-el1_irq
…
|   printk-873     1dN..111 84243791us : idle_cpu <-irq_exit
|   printk-873     1dN..111 84243792us : rcu_irq_exit <-irq_exit
|   printk-873     1dN..111 84244822us : gic_handle_irq <-el1_irq

it prints. Then an interrupts arrives, gets handled, wakes cyclictest.
But instead switching to cyclictest from the irq_exit it gets back to
printing and another interrupt arrives. And then it says that preempt
disable, migrate disable, lazy preempt disable is all one. But
preemption should be enabled. Looking at the whole trace, the preemption
counter is always >= 1 so this might be arm64 specific increment during
recording.

> Emergency messages are not involved here. You can see at 84239098us that
Right, we don't have that. Let me boot my arm64, print something and
check how it goes…

> John Ogness

Sebastian
