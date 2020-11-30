Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B571C64E8A
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D68020855
	for <linux-rt-users@archiver.kernel.org>; Mon, 30 Nov 2020 13:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsEY5TVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgK3N4z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 30 Nov 2020 08:56:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbgK3N4z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Nov 2020 08:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606744528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQtv8KiZgdd7jr6hk8MSwc0XZd64w6sYVEBFxR5bqsY=;
        b=fsEY5TVxeEW9KU2htneO678JrNZbo2GTr3iiDJILYr2vcdlKg9WVZw8y7NZYPkNhgrmqkM
        lRoEl/5IboiN5YvhOnd1tqricHNtdbVOEF1yJFC1hgW3lcu8NdU4bUQSuNyNHjnokUyAK5
        JMO6XN00VEhG5eXxLthgarbsxq7vag4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-T2Dy2jW3OT61hgEaJ6P5iA-1; Mon, 30 Nov 2020 08:55:22 -0500
X-MC-Unique: T2Dy2jW3OT61hgEaJ6P5iA-1
Received: by mail-wm1-f70.google.com with SMTP id z16so4393788wma.1
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 05:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQtv8KiZgdd7jr6hk8MSwc0XZd64w6sYVEBFxR5bqsY=;
        b=kFJ8i+kVn5uxzo5lYI06X7A+js8/qB6VuHxjChmcuZACJP0im5r06hDuDuTMBYG0KN
         wlmLM8rzeH0jFPKe8z9RPZe3WCVcVclcMPgPza4bv6TLNUx3H3EpJiEkC+HarOtXh5cs
         9FaygDtCi2P/HREjyGWvPWtjs1YFSmveA/W7v7ugleBmbUSiyCixwq39Tphc+2FB2HWY
         TL+VdsWBEqVM+ZPBKPVUTKlq4H5oz9QZbp7xq+B7wxId8rMn9aqdcdhMNtAVH1fUEhJe
         XOdN+wjmXI47arJGauDStoc+z+ZUEXBAX3hL7viVi5ydpDjzERIu+TwcxtbTS4T/Qxe3
         9fJA==
X-Gm-Message-State: AOAM531SKYyYGjq0zeOBr0r+oJMPKMkdghY3ICokdyU38HwWXg+3eFCk
        Q2ByUDbVxPXss5hMLYvpcimU2ZDgoRql2GVr/H6pLIXU3rDbB98nhHBWjA9pMsQOJ83RXiIV6A4
        W9OlqlMC77+3s1C5swJeEXYvhbTE=
X-Received: by 2002:a5d:4586:: with SMTP id p6mr29263664wrq.308.1606744521527;
        Mon, 30 Nov 2020 05:55:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBer9HKeX2ucq4GjREuzEArXJK0Vn94oNpI85I2Tf/keh1OK2G5VWNVYQQCnoVlF+zYH+UJA==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr29263634wrq.308.1606744521329;
        Mon, 30 Nov 2020 05:55:21 -0800 (PST)
Received: from x1.bristot.me (host-95-246-207-183.retail.telecomitalia.it. [95.246.207.183])
        by smtp.gmail.com with ESMTPSA id m4sm7952273wmi.41.2020.11.30.05.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 05:55:20 -0800 (PST)
Subject: Re: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alex Shi <alex.shi@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
References: <20201122201904.30940-1-valentin.schneider@arm.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <ff48cee8-6634-c04c-3a33-509ce1f92e21@redhat.com>
Date:   Mon, 30 Nov 2020 14:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201122201904.30940-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 11/22/20 9:19 PM, Valentin Schneider wrote:
> Booting a recent PREEMPT_RT kernel (v5.10-rc3-rt7-rebase) on my arm64 Juno
> leads to the idle task blocking on an RT sleeping spinlock down some
> notifier path:
> 
>   [    1.809101] BUG: scheduling while atomic: swapper/5/0/0x00000002
>   [    1.809116] Modules linked in:
>   [    1.809123] Preemption disabled at:
>   [    1.809125] secondary_start_kernel (arch/arm64/kernel/smp.c:227)
>   [    1.809146] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W         5.10.0-rc3-rt7 #168
>   [    1.809153] Hardware name: ARM Juno development board (r0) (DT)
>   [    1.809158] Call trace:
>   [    1.809160] dump_backtrace (arch/arm64/kernel/stacktrace.c:100 (discriminator 1))
>   [    1.809170] show_stack (arch/arm64/kernel/stacktrace.c:198)
>   [    1.809178] dump_stack (lib/dump_stack.c:122)
>   [    1.809188] __schedule_bug (kernel/sched/core.c:4886)
>   [    1.809197] __schedule (./arch/arm64/include/asm/preempt.h:18 kernel/sched/core.c:4913 kernel/sched/core.c:5040)
>   [    1.809204] preempt_schedule_lock (kernel/sched/core.c:5365 (discriminator 1))
>   [    1.809210] rt_spin_lock_slowlock_locked (kernel/locking/rtmutex.c:1072)
>   [    1.809217] rt_spin_lock_slowlock (kernel/locking/rtmutex.c:1110)
>   [    1.809224] rt_spin_lock (./include/linux/rcupdate.h:647 kernel/locking/rtmutex.c:1139)
>   [    1.809231] atomic_notifier_call_chain_robust (kernel/notifier.c:71 kernel/notifier.c:118 kernel/notifier.c:186)
>   [    1.809240] cpu_pm_enter (kernel/cpu_pm.c:39 kernel/cpu_pm.c:93)
>   [    1.809249] psci_enter_idle_state (drivers/cpuidle/cpuidle-psci.c:52 drivers/cpuidle/cpuidle-psci.c:129)
>   [    1.809258] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:238)
>   [    1.809267] cpuidle_enter (drivers/cpuidle/cpuidle.c:353)
>   [    1.809275] do_idle (kernel/sched/idle.c:132 kernel/sched/idle.c:213 kernel/sched/idle.c:273)
>   [    1.809282] cpu_startup_entry (kernel/sched/idle.c:368 (discriminator 1))
>   [    1.809288] secondary_start_kernel (arch/arm64/kernel/smp.c:273)
> 
> Two points worth noting:
> 
> 1) That this is conceptually the same issue as pointed out in:
>    313c8c16ee62 ("PM / CPU: replace raw_notifier with atomic_notifier")
> 2) Only the _robust() variant of atomic_notifier callchains suffer from
>    this
> 
> AFAICT only the cpu_pm_notifier_chain really needs to be changed, but
> singling it out would mean introducing a new (truly) non-blocking API. At
> the same time, callers that are fine with any blocking within the call
> chain should use blocking notifiers, so patching up all atomic_notifier's
> doesn't seem *too* crazy to me.
> 
> Fixes: 70d932985757 ("notifier: Fix broken error handling pattern")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

