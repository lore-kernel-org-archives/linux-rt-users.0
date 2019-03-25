Return-Path: <SRS0=5pzl=R4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0493C43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 10:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73542064A
	for <linux-rt-users@archiver.kernel.org>; Mon, 25 Mar 2019 10:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfCYKeo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:34:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45392 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbfCYKeo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Mar 2019 06:34:44 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h8MwB-00084h-EH; Mon, 25 Mar 2019 11:34:39 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: Re: [ANNOUNCE] v5.0.3-rt1
References: <20190320171511.icjhdlulgal2yeho@linutronix.de>
        <791056c4-3575-0bd8-031e-44d0e3b21e54@arm.com>
        <87tvfrs76z.fsf@linutronix.de>
        <3cb3c190-e804-982a-1c5b-8545a97379b9@arm.com>
Date:   Mon, 25 Mar 2019 11:34:38 +0100
In-Reply-To: <3cb3c190-e804-982a-1c5b-8545a97379b9@arm.com> (Julien Grall's
        message of "Mon, 25 Mar 2019 10:18:36 +0000")
Message-ID: <87imw7qm2p.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-25, Julien Grall <julien.grall@arm.com> wrote:
>>> Using 5.0.3-rt1, I get some warning message completely mangled with
>>> the rest of the output (e.g systemd message) but also between
>>> them. Some excerpt of a 500 lines lockdep warning (AFAICT the printk
>>> is not related to the printk code):
>>>
>>> [   52.294547] 005: ... which became HARDIRQ-irq-unsafe at:
>>> [   52.294553] 005: ...
>>> [   52.294554] 005:   lock_acquire+0xf8/0x318
>>> [  OK  ] Reached target
>>> t_spin_lock+0x48/0x70  lock_acquire+0xf8/0x318
>>> [0;1;39mRemote File Systems.[   52.294570] 005:   iommu_dma_map_msi_msg+0x5c/0x1
>>>
>>> [   52.296824] 005: CPU: 5 PID: 2108 Comm: ip Not tainted 5.0.3-rt1-00007-g42ede
>>> 9a0fed6 #4312] 005:  __sys_sendmsg+0x68/0xb8
>>>
>>> I understand the new series add support for "atomic" print. So I am
>>> wondering whether this issue is related to it? Is there any advice
>>> to prevent the mangling?
>> 
>> The atomic print allows important messages to be print immediately
>> (regardless of the context of the printer). This means that if any
>> other context was already printing, it will be interrupted. This
>> cannot be synchronized without causing significant scheduling
>> delays.> The atomic messages always do the interrupting and will
>> continue to the end of the line. So it should be possible to piece
>> the non-atomic messages back together. However, I am a bit confused
>> by your output. Is it possible that I could see the full boot log?
>
> I seem to have two issues. The first one is what you described above,
> the other is what looks like spurious print. I have appended the full
> boot log below.

> [...]
> [    1.169151] 002: Serial: AMBA PL011 UART driver
> [    1.254891] 002: 7ff80000.uart: ttyAMA0 at MMIO 0x7ff80000 (irq = 32, base_baud = 0) is a PL011 rev3
> [    1.255007] 002: printk: console [ttyAMA0] enabled

The ttyAMA drivers do not have support for atomic printing, so it is not
the new atomic feature that is causing the mangling. For your setup, all
printk console printing is being handled within a specific context, the
printk kernel thread.

It looks to me like some userspace application (systemd?) is writing
directly to /dev/ttyAMA0. If the kernel is also writing to this device
(because it is setup as a console), then the output will be
mangled. There is no high-level synchronization between console output
and directly writing to UART devices. Maybe you need to set your
loglevel so that the kernel does not do the printing? For example,
loglevel=1?

You should see this problem with older kernel versions as well.

> Interestingly the dmesg output does not contain any mangling.

dmesg just dumps the kernel log buffer. The log buffer is synchronized
(even for atomic writes), so it will never show the mangling.

John Ogness
