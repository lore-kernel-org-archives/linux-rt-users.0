Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A93C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  1 Apr 2022 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbiDAJ30 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 1 Apr 2022 05:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344534AbiDAJ3Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Apr 2022 05:29:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27DD221B8D;
        Fri,  1 Apr 2022 02:27:36 -0700 (PDT)
Date:   Fri, 1 Apr 2022 11:27:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648805255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A0QKk4sUzoou0ZzWNfIYO9gsM92vo3rk5/SdxP8/yFE=;
        b=e9+em635APgoLqssrsv6kFNM75RsNlQAv0MsUxvgiqWXD8/j4F3AIoPIocvLF1Lc6gXaYY
        FbnLq63KQRyyUDXHKYLI6MjPyJLQAv0uG3eEetRUpvuREyfaYCm/POibLyYF2VFzsKOsFv
        9tDFJQpyu9KXKvqJE0q26abyN993UsmcSHbqC73BO/HJP7PBjoZysa2Gk/wtPOG91MP98Y
        PVoefEZhmXUKORjwu/tdlb4C69j+j6reJeT/LuoFRFmxXQwB7cTqdMU1EFPnSCQYb8qI93
        8AqRFFv1wG1EZINoFijF4jWRrBBLva3n62AZvPtmB/9VhZ0I2hpp9BSP2RrHIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648805255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A0QKk4sUzoou0ZzWNfIYO9gsM92vo3rk5/SdxP8/yFE=;
        b=I9QggolMgGWvvv1Prp90zDbdUwXY8WlunqftW8bYyXz78KlQ4Uv9IpHuhCn3/sMwK5+OzJ
        /WDegpZUTGzSxCBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] kasan: Fix sleeping function called from invalid context
 in PREEMPT_RT
Message-ID: <YkbFhgN1jZPTMfnS@linutronix.de>
References: <20220401091006.2100058-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220401091006.2100058-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-04-01 17:10:06 [+0800], Zqiang wrote:
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> preempt_count: 1, expected: 0
> ...........
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.1-rt16-yocto-preempt-rt #22
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> Call Trace:
> <TASK>
> dump_stack_lvl+0x60/0x8c
> dump_stack+0x10/0x12
>  __might_resched.cold+0x13b/0x173
> rt_spin_lock+0x5b/0xf0
>  ___cache_free+0xa5/0x180
> qlist_free_all+0x7a/0x160
> per_cpu_remove_cache+0x5f/0x70
> smp_call_function_many_cond+0x4c4/0x4f0
> on_each_cpu_cond_mask+0x49/0xc0
> kasan_quarantine_remove_cache+0x54/0xf0
> kasan_cache_shrink+0x9/0x10
> kmem_cache_shrink+0x13/0x20
> acpi_os_purge_cache+0xe/0x20
> acpi_purge_cached_objects+0x21/0x6d
> acpi_initialize_objects+0x15/0x3b
> acpi_init+0x130/0x5ba
> do_one_initcall+0xe5/0x5b0
> kernel_init_freeable+0x34f/0x3ad
> kernel_init+0x1e/0x140
> ret_from_fork+0x22/0x30
> 
> When the kmem_cache_shrink() be called, the IPI was triggered, the
> ___cache_free() is called in IPI interrupt context, the local lock
> or spin lock will be acquired. on PREEMPT_RT kernel, these lock is
> replaced with sleepbale rt spin lock, so the above problem is triggered.
> fix it by migrating the release action from the IPI interrupt context
> to the task context on RT kernel.

I haven't seen that while playing with kasan. Is this new?
Could we fix in a way that we don't involve freeing memory from in-IRQ?
This could trigger a lockdep splat if the local-lock in SLUB is acquired
from in-IRQ context on !PREEMPT_RT.

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Sebastian
