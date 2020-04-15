Return-Path: <SRS0=USbd=57=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0897FC3815B
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42FF2051A
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Apr 2020 16:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416145AbgDOQeV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416090AbgDOQeT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Apr 2020 12:34:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F90C061A0C;
        Wed, 15 Apr 2020 09:34:19 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOkzQ-0006Uc-V3; Wed, 15 Apr 2020 18:34:17 +0200
Date:   Wed, 15 Apr 2020 18:34:16 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT] printk: console must not schedule for drivers
Message-ID: <20200415163416.r3fce3g5kokm4bub@linutronix.de>
References: <20200406212217.2323-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406212217.2323-1-john.ogness@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-06 23:22:17 [+0200], John Ogness wrote:
> Even though the printk kthread is always preemptible, it is still not
> allowed to call cond_resched() from within console drivers. The
> task may become non-preemptible in the console driver call chain. For
> example, vt_console_print() takes a spinlock and then can call into
> fbcon_redraw(), which can conditionally invoke cond_resched():
> 
> BUG: sleeping function called from invalid context at kernel/printk/printk.c:2322
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 177, name: printk
> CPU: 0 PID: 177 Comm: printk Not tainted 5.6.2-00011-ga536059557f1d9 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> Call Trace:
>  dump_stack+0x66/0x8b
>  ___might_sleep+0x102/0x120
>  console_conditional_schedule+0x24/0x30
>  fbcon_redraw+0x96/0x1c0
>  ? fbcon_cursor+0x100/0x190
>  fbcon_scroll+0x556/0xd70
>  con_scroll+0x147/0x1e0
>  lf+0x9e/0xb0
>  vt_console_print+0x253/0x3d0
>  printk_kthread_func+0x1d5/0x3b0
> 
> Disable cond_resched() for the call into the console drivers.

Interesting. So you get a report and I don't?

I have also patch related questions :)
- So before the re-rewrite, console_unlock() set this 0 before invoking
  the console drivers so it was always 0. I assume it was called with
  disabled interrupts.

- Is there a scenario in fbcon where this function is invoked and
  console_may_schedule is not 0?

Sebastian
