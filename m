Return-Path: <SRS0=c1g4=R5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334BEC43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Mar 2019 10:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5D20857
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Mar 2019 10:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCZK0f (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:26:35 -0400
Received: from foss.arm.com ([217.140.101.70]:34026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZK0f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Mar 2019 06:26:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27BD11596;
        Tue, 26 Mar 2019 03:26:35 -0700 (PDT)
Received: from [10.37.9.236] (unknown [10.37.9.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B1613F614;
        Tue, 26 Mar 2019 03:26:33 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.0.3-rt1
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave P Martin <Dave.Martin@arm.com>
References: <20190320171511.icjhdlulgal2yeho@linutronix.de>
 <791056c4-3575-0bd8-031e-44d0e3b21e54@arm.com> <87tvfrs76z.fsf@linutronix.de>
 <3cb3c190-e804-982a-1c5b-8545a97379b9@arm.com> <87imw7qm2p.fsf@linutronix.de>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <28ab7caf-1ada-1c39-c2f9-cd69b2376ef8@arm.com>
Date:   Tue, 26 Mar 2019 10:26:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87imw7qm2p.fsf@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On 3/25/19 10:34 AM, John Ogness wrote:
> On 2019-03-25, Julien Grall <julien.grall@arm.com> wrote:
>> [...]
>> [    1.169151] 002: Serial: AMBA PL011 UART driver
>> [    1.254891] 002: 7ff80000.uart: ttyAMA0 at MMIO 0x7ff80000 (irq = 32, base_baud = 0) is a PL011 rev3
>> [    1.255007] 002: printk: console [ttyAMA0] enabled
> 
> The ttyAMA drivers do not have support for atomic printing, so it is not
> the new atomic feature that is causing the mangling. For your setup, all
> printk console printing is being handled within a specific context, the
> printk kernel thread.

This series is somehow making worst when using ttyAMA0. I haven't see 
any mangling with 4.19-rt.

> 
> It looks to me like some userspace application (systemd?) is writing
> directly to /dev/ttyAMA0. If the kernel is also writing to this device
> (because it is setup as a console), then the output will be
> mangled. There is no high-level synchronization between console output
> and directly writing to UART devices. Maybe you need to set your
> loglevel so that the kernel does not do the printing? For example,
> loglevel=1?

I am a bit confused with your suggestion. This would basically means I 
would not be able to see kernel warning. So this would impair any 
development on Linux-rt.

> 
> You should see this problem with older kernel versions as well.

I have tried with 4.19-rt and didn't see a similar issue. The trace 
comes pretty clean in one go. With 5.0-rt, the trace never come clean.

Cheers,

-- 
Julien Grall
