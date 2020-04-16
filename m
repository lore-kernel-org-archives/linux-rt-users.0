Return-Path: <SRS0=egP0=6A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD4FC2D0EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 08:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5ACC206F9
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 08:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441215AbgDPIOZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441179AbgDPIN2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Apr 2020 04:13:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BFC061A0C;
        Thu, 16 Apr 2020 01:13:27 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jOzeH-0000Rs-4N; Thu, 16 Apr 2020 10:13:25 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT] printk: console must not schedule for drivers
References: <20200406212217.2323-1-john.ogness@linutronix.de>
        <20200415163416.r3fce3g5kokm4bub@linutronix.de>
Date:   Thu, 16 Apr 2020 10:13:23 +0200
In-Reply-To: <20200415163416.r3fce3g5kokm4bub@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Wed, 15 Apr 2020 18:34:16 +0200")
Message-ID: <87o8rrg864.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-15, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> Even though the printk kthread is always preemptible, it is still not
>> allowed to call cond_resched() from within console drivers. The
>> task may become non-preemptible in the console driver call chain. For
>> example, vt_console_print() takes a spinlock and then can call into
>> fbcon_redraw(), which can conditionally invoke cond_resched():
>> 
>> BUG: sleeping function called from invalid context at
>> kernel/printk/printk.c:2322
>> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 177, name: printk
>> CPU: 0 PID: 177 Comm: printk Not tainted 5.6.2-00011-ga536059557f1d9 #1
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1
>> 04/01/2014
>> Call Trace:
>>  dump_stack+0x66/0x8b
>>  ___might_sleep+0x102/0x120
>>  console_conditional_schedule+0x24/0x30
>>  fbcon_redraw+0x96/0x1c0
>>  ? fbcon_cursor+0x100/0x190
>>  fbcon_scroll+0x556/0xd70
>>  con_scroll+0x147/0x1e0
>>  lf+0x9e/0xb0
>>  vt_console_print+0x253/0x3d0
>>  printk_kthread_func+0x1d5/0x3b0
>> 
>> Disable cond_resched() for the call into the console drivers.
>
> Interesting. So you get a report and I don't?

Apparently only the patch author was notified. The reporter should
include all the people tagged in the patch. I'll send him an email about
this.

> - So before the re-rewrite, console_unlock() set this 0 before
>   invoking the console drivers so it was always 0. I assume it was
>   called with disabled interrupts.

Correct.

> - Is there a scenario in fbcon where this function is invoked and
>   console_may_schedule is not 0?

Yes. The ttys/consoles are invoked through other call chains not related
to printk. Since console_lock() can sleep, any caller of console_lock()
_should_ be allowed to perform the cond_resched(). (The printk thread is
an exception here!)

Here is one call chain I picked out:

tty_io.c:tty_write_message()
    mutex_lock()
    tty->ops->write() -> usb-serial.c:serial_write()
        port->serial->type->write() -> vt.c:con_write()
            do_con_write()
                console_lock()
                    console_may_schedule = 1;
                console_conditional_schedule();
                    cond_resched();

From the mutex_lock() we can see that we are in a non-atomic context. In
this case it is OK to call console_lock() and cond_resched().

John Ogness
