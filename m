Return-Path: <SRS0=A69s=XA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA418C43331
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Sep 2019 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E5B206A1
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Sep 2019 15:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbfIEPlR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:41:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43309 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbfIEPlQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Sep 2019 11:41:16 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i5tsp-0003gO-Lc; Thu, 05 Sep 2019 17:41:15 +0200
Date:   Thu, 5 Sep 2019 17:41:15 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Martin.Wirth@dlr.de
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Long latencies during disk-io
Message-ID: <20190905154115.mnid6rue65x6vvt6@linutronix.de>
References: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-03 07:23:35 [+0000], Martin.Wirth@dlr.de wrote:
> Hi,
Hi,

…
>  /proc/irq interface the latencies are gone. The real-time priority of the digitizer IRQ handler
>  is set to 53 and that of the corresponding user space thread to 51. The ahci interrupt
>  thread is at the standard value of 50.     
> 
> Although I now have the solution to put the ahci-handler on a different processor, I would
> like to know if it is expected behavior that the ahci interrupt handler blocks other interrupt 
> threads of higher priority for more than one millisecond?

Based on the CPU split via proc/irq you describe here I assume that
both devices (ahci and the digitizer cards) do not share an interrupt
line.
In that case both handlers are independent and should not affect each
other. Running on the same CPU, the AHCI handler can be interrupt by
another thread (with a higher priority) if that interrupt line was
raised while the AHCI handler was active.

So based on that, the "digitizer IRQ handler" should run first, followed
by the user space thread, followed by the AHCI interrupt.

> Another observation which I cannot understand though, is that a concurrent 
> cyclictest -m -Sp98 -i200 -h400 -n
> run does not show the latencies...

you have here "-p98" while the other two threads have priority 53 and
51. So that is a difference unless there is nothing between 53 and 51.
But if you disable the "digitizer card(s)" then with -p51 you should be
close to that setup with cyclictest.

If there are no spikes in cyclictest then there must be something
after the threaded handler runs that delays the user space task. Some
tracing should help to figure out what happens between the hardware
interrupt and the context switch to the user task.

> Cheers,
> 
> Martin

Sebastian
