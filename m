Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA8C43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 14:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiFXOaN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiFXOaL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 10:30:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9D54F8E
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 07:30:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656081008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FtHmj78thggLIde8KI+6DxWPjsxUI42VWnYLUsvgeiU=;
        b=plcY/B2AJKFr60gctIe+F6fJ03HPv7qnrnPxyO5GWuJjqmta1lmr4M+gU7RnONT7uQaKRY
        Tr6gbAaE7quvwJ9Vc+DPdHagid7yUXJNuBxknUzxoyH0gcECAjwOIWSrss8H9rJ0fA6iTk
        MJfAoufkJF4/c2EKGUCh5DqggFAy7fdC4XMMmnIdcKkb4H3+mD1WM68fEaOdwy/4HyVPHp
        dkWwq6Hih07JK4qa2TZuehP3dHRMRHs5VR+lettpWbYhu335Eo8AixDbJ0+TL8jXzwyl0f
        2LGQC38SSo8KcoWy1hPUmc5YrFjd4jcjd9zqQszZIMla068rOfl9nVHEw2R1Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656081008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FtHmj78thggLIde8KI+6DxWPjsxUI42VWnYLUsvgeiU=;
        b=OFyIKyOe+zkPnu/Y7Hm2yEoCIjWuFbBwVycG77qjziwf0wGklNgqBBoZ/ia353htRR9B9l
        mN5oPSvP4acH5PDg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
In-Reply-To: <YrWPiwtk0kAWxXI9@linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
 <YrV4795StT13AUC+@linutronix.de>
 <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
 <YrWPiwtk0kAWxXI9@linutronix.de>
Date:   Fri, 24 Jun 2022 16:36:07 +0206
Message-ID: <87wnd616ds.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-24, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> (gdb) list *vprintk_store+0x3cc
>> 0xffffffff8114283c is in vprintk_store (kernel/printk/printk.c:2280).
>> warning: Source file is more recent than executable.
>> 2275            u32 caller_id;
>> 2276            u16 text_len;
>> 2277            int ret = 0;
>> 2278            u64 ts_nsec;
>> 2279
>> 2280            if (!printk_enter_irqsave(recursion_ptr, irqflags))
>> 2281                    return 0;
>> 2282
>> 2283            /*
>> 2284             * Since the duration of printk() can vary depending on the message
>> (gdb)
>
> Why do we need to keep interrupts disabled for vsnprintf()?

vsnprintf is printing the current CPU local clock and the current CPU
ID. Are you recommending we split printk_enter_irqsave() into various
preempt_disable() and local_irq_save() calls?

As to this the actual problem reported in this thread, I believe this
patch solves it:

https://lore.kernel.org/lkml/20220609121709.12939-1-Jason@zx2c4.com

John Ogness
