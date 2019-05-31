Return-Path: <SRS0=n5VO=T7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F159C04AB6
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 May 2019 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C57C26E5D
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 May 2019 19:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfEaTb3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 May 2019 15:31:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60654 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfEaTb3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 May 2019 15:31:29 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hWnFN-00075R-36; Fri, 31 May 2019 21:31:25 +0200
Date:   Fri, 31 May 2019 21:31:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.0.19-rt11
Message-ID: <20190531193124.ao2skirq6rkdrgyn@linutronix.de>
References: <20190529212638.g3gkor3n7xui5fhk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190529212638.g3gkor3n7xui5fhk@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-05-29 23:26:38 [+0200], To Thomas Gleixner wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.0.19-rt11 patch set. 
> 
> Changes since v5.0.19-rt10:
> 
>   - Ignore a warning from lockdep when lockdep is disabled for different
>     lock types.
> 
>   - Make the cpuidle an imx6 raw_spinlock_t.
> 
>   - Add a proper depends in Kconfig for Atmel's tclib based clocksource.
>     Otherwise the allmodconfig on !ATMEL fails.
> 
>   - Revert the removal of TIMER_IRQSAFE in i915 because it is required.
> 
>   - Rework the softirq code.
>     The basic idea is to have local-lock within local_bh_disable() which is
>     used for synchronisation similar to mainline. With this synchronisation
>     we can't have two softirqs processed in parallel on the same CPU. This
>     allows to remove the extra synchronisation we had.
> 
>   - Rework the workqueue code.
>     The worker_pool.lock is made to raw_spinlock_t. With this change we can
>     schedule workitems from preempt-disable sections and sections with
>     disabled interrupts. This change allows to remove all kthread_.*
>     workarounds we used to have.
> 
> Known issues
>      - A warning triggered in "rcu_note_context_switch" originated from
>        SyS_timer_gettime(). The issue was always there, it is now
>        visible. Reported by Grygorii Strashko and Daniel Wagner.
> 
>      - rcutorture is currently broken on -RT. Reported by Juri Lelli.
> 
> The delta patch against v5.0.19-rt10 is appended below and can be found here:
>  
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/incr/patch-5.0.19-rt10-rt11.patch.xz
> 
> You can get this release via the git tree at:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.0.19-rt11
> 
> The RT patch against v5.0.19 can be found here:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.19-rt11.patch.xz
> 
> The split quilt queue is available at:
> 
>     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.19-rt11.tar.xz

just noticed that this never made it to the due to large inline diff.
The diff can be looked up at

      https://git.kernel.org/rt/linux-rt-devel/d/v5.0.19-rt11/v5.0.19-rt10
 
Sebastian
