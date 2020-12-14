Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A5C1B0D8
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 11:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C2222ADC
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Dec 2020 11:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407299AbgLNLiQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 06:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407860AbgLNLiG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Dec 2020 06:38:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC6C0613D3
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2020 03:37:25 -0800 (PST)
Date:   Mon, 14 Dec 2020 12:37:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607945844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fc/G+7cRG5TbPKEPeJHtAlwlQhMjwMJvsTaHzxXhU9s=;
        b=tWW3Yr4F9wBl0rWf7YCGGEnT+C/WsnN3NnAE9V/9Rofc0vsQvBaq8iiIaVPdndfCtFdNxX
        HMGShY888kxJe15fN8nR03SBtz394daNhqhYxxt+vZDfutksDa7+nX9AuNN9QzqcOZjIJB
        B4tg+HX/nKw0xSaFUcE4flNRtudxbbz/LVviopql7xkwwx02BRuSPyaJ8Hqz2VIAEXD+B9
        8jpbpWsPRb6QgNicKXp7zG6ktPA4MKpMiI9hsgPmufBA+6ftJc//aGd67kn03bMyG77k+9
        0KkzPllrPAERIIw0pOP3yNf+2RV3zWPPPtpBCgB9uHGFo5UsDIRd/0ssXQcAEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607945844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fc/G+7cRG5TbPKEPeJHtAlwlQhMjwMJvsTaHzxXhU9s=;
        b=5FLdy2tGjhuGp9PaAxTPiXVJHvVxQW6RfV2bYLETFLjl7EFdGG08uGAsZG7gUAS36VpQfu
        EArH3AY70WKkJ6AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: RT kernel testing with stress-ng and scheduling while in atomic
 bugs.
Message-ID: <20201214113722.iman6afnqvhtgcw4@linutronix.de>
References: <b9317e8c-d5d9-e440-6c32-f9c26ad4ef10@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b9317e8c-d5d9-e440-6c32-f9c26ad4ef10@canonical.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-12-07 12:43:47 [+0000], Colin Ian King wrote:
> Hi,
Hi,

> Questions:
>=20
> 1. Are these issues expected?
I haven't seen it, it is not expected. It hasn't been reported so far.

> 2. Is there an official way to report my bug findings?

Report it to the list, keep me in Cc:, please.

> 3. I am keen to debug and fix these issues, have RT folk got some advice
> on how to start debugging these kind of issues?

Based on the backtrace (and please tell your client to not break lines
while pasting bactraces / logs since it makes them hard to read):

>  BUG: scheduling while atomic: stress-ng-fstat/47271/0x00000002
>  CPU: 4 PID: 47271 Comm: stress-ng-fstat Not tainted 5.10.0-6-realtime #7
=E2=80=A6
>  Call Trace:
>  __schedule_bug.cold+0x4a/0x5b
>   __schedule+0x50d/0x6b0
>   ? task_blocks_on_rt_mutex+0x29a/0x390
>  preempt_schedule_lock+0x24/0x50
>  rt_spin_lock_slowlock_locked+0x11b/0x2c0
>  rt_spin_lock_slowlock+0x57/0x90
>   rt_spin_lock+0x30/0x40
>   alloc_pid+0x1bc/0x400

alloc_pid() acquired a spinlock_t somewhere while the context was
"atomic". The output seems to lack details. Like the "scheduling while
atomic" should also contain (somwhere) "atomic: x irqs disabled: x"
which is missing. Also I would expect to see preemption level in your
backtrace.

Anyway. Something made the context atomic (like preempt_disable()) and
then you attempted to acquire a lock at alloc_pid+0x1bc/0x400. While
looking at the code, alloc_pid() should be preemptible. On PREEMPT_RT
spin_lock() does not disable preemption so you should remain
preemtible().
=20
Sebastian
