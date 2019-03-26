Return-Path: <SRS0=c1g4=R5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11F2C43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Mar 2019 16:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70F32070D
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Mar 2019 16:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfCZQEK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:04:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48691 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZQEK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Mar 2019 12:04:10 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1h8oYY-0000YU-5M; Tue, 26 Mar 2019 17:04:06 +0100
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
        <87imw7qm2p.fsf@linutronix.de>
        <28ab7caf-1ada-1c39-c2f9-cd69b2376ef8@arm.com>
Date:   Tue, 26 Mar 2019 17:04:04 +0100
In-Reply-To: <28ab7caf-1ada-1c39-c2f9-cd69b2376ef8@arm.com> (Julien Grall's
        message of "Tue, 26 Mar 2019 10:26:31 +0000")
Message-ID: <878sx17hcb.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Julien,

On 2019-03-26, Julien Grall <julien.grall@arm.com> wrote:
>>> [...]
>>> [    1.169151] 002: Serial: AMBA PL011 UART driver
>>> [    1.254891] 002: 7ff80000.uart: ttyAMA0 at MMIO 0x7ff80000 (irq = 32, base_baud = 0) is a PL011 rev3
>>> [    1.255007] 002: printk: console [ttyAMA0] enabled
>>
>> The ttyAMA drivers do not have support for atomic printing, so it is
>> not the new atomic feature that is causing the mangling. For your
>> setup, all printk console printing is being handled within a specific
>> context, the printk kernel thread.
>
> This series is somehow making worst when using ttyAMA0. I haven't see
> any mangling with 4.19-rt.

I will setup some tests using systemd on 4.19 and 5.0 to see if I can
see what is going on. It seems there may be some synchronization missing
between the printk kernel thread and /dev/console.

John Ogness
