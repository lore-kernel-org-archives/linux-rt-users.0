Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487FFC4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 16:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2065A61B97
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 16:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhG0QYD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhG0QYC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jul 2021 12:24:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A869461B96;
        Tue, 27 Jul 2021 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627403042;
        bh=Ffx/4O59u5b+9VZUiul6boaYE12c631vF/S8JIot1Go=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=U7j/ZhdydU58Pwnn/TKcb9cHWrS+jc5uVJs6/vqwSuGt/O41ikF5w3hmdeq9z/8fS
         FI3q+on0XddcEkd+XxTcWoQIUQANj4+1h5e2Pw9ndog22uE7KbucKB9cJrCKY1YVbf
         vA154cuthbtkRpKOGuNan3pnzpXdedLqA5I2zFYpervejvw5eYjTIv4F7fucexGzy8
         C0aenzO0jdLInebFA1mL0eCWaKI7/eeoZaoO9H+LJHdQR1d/4M+W1zr1eaaMYGrEgK
         XGztI3Pu2U/Pu5EQe6m1iypsrFsBD5QGoZmIoZgjJEGwT+GqUdW3DX0LL3OelznBcv
         TQ596hw1VPhTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 83BDB5C099F; Tue, 27 Jul 2021 09:24:02 -0700 (PDT)
Date:   Tue, 27 Jul 2021 09:24:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/3] rcu/nocb: Check for migratability rather than pure
 preemptability
Message-ID: <20210727162402.GB4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721115118.729943-1-valentin.schneider@arm.com>
 <20210721115118.729943-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721115118.729943-3-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jul 21, 2021 at 12:51:17PM +0100, Valentin Schneider wrote:
> Running v5.13-rt1 on my arm64 Juno board triggers:
> 
> [    0.156302] =============================
> [    0.160416] WARNING: suspicious RCU usage
> [    0.164529] 5.13.0-rt1 #20 Not tainted
> [    0.168300] -----------------------------
> [    0.172409] kernel/rcu/tree_plugin.h:69 Unsafe read of RCU_NOCB offloaded state!
> [    0.179920]
> [    0.179920] other info that might help us debug this:
> [    0.179920]
> [    0.188037]
> [    0.188037] rcu_scheduler_active = 1, debug_locks = 1
> [    0.194677] 3 locks held by rcuc/0/11:
> [    0.198448] #0: ffff00097ef10cf8 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip (./include/linux/rcupdate.h:662 kernel/softirq.c:171)
> [    0.208709] #1: ffff80001205e5f0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock (kernel/locking/spinlock_rt.c:43 (discriminator 4))
> [    0.217134] #2: ffff80001205e5f0 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip (kernel/softirq.c:169)
> [    0.226428]
> [    0.226428] stack backtrace:
> [    0.230889] CPU: 0 PID: 11 Comm: rcuc/0 Not tainted 5.13.0-rt1 #20
> [    0.237100] Hardware name: ARM Juno development board (r0) (DT)
> [    0.243041] Call trace:
> [    0.245497] dump_backtrace (arch/arm64/kernel/stacktrace.c:163)
> [    0.249185] show_stack (arch/arm64/kernel/stacktrace.c:219)
> [    0.252522] dump_stack (lib/dump_stack.c:122)
> [    0.255947] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6439)
> [    0.260328] rcu_rdp_is_offloaded (kernel/rcu/tree_plugin.h:69 kernel/rcu/tree_plugin.h:58)
> [    0.264537] rcu_core (kernel/rcu/tree.c:2332 kernel/rcu/tree.c:2398 kernel/rcu/tree.c:2777)
> [    0.267786] rcu_cpu_kthread (./include/linux/bottom_half.h:32 kernel/rcu/tree.c:2876)
> [    0.271644] smpboot_thread_fn (kernel/smpboot.c:165 (discriminator 3))
> [    0.275767] kthread (kernel/kthread.c:321)
> [    0.279013] ret_from_fork (arch/arm64/kernel/entry.S:1005)
> 
> In this case, this is the RCU core kthread accessing the local CPU's
> rdp. Before that, rcu_cpu_kthread() invokes local_bh_disable().
> 
> Under !CONFIG_PREEMPT_RT (and rcutree.use_softirq=0), this ends up
> incrementing the preempt_count, which satisfies the "local non-preemptible
> read" of rcu_rdp_is_offloaded().
> 
> Under CONFIG_PREEMPT_RT however, this becomes
> 
>   local_lock(&softirq_ctrl.lock)
> 
> which, under the same config, is migrate_disable() + rt_spin_lock().
> This *does* prevent the task from migrating away, but not in a way
> rcu_rdp_is_offloaded() can notice. Note that the invoking task is an
> smpboot thread, and thus cannot be migrated away in the first place.
> 
> Check is_pcpu_safe() here rather than preemptible().
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_plugin.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index ad0156b86937..6c3c4100da83 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -70,8 +70,7 @@ static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
>  		!(lockdep_is_held(&rcu_state.barrier_mutex) ||
>  		  (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_held()) ||
>  		  rcu_lockdep_is_held_nocb(rdp) ||
> -		  (rdp == this_cpu_ptr(&rcu_data) &&
> -		   !(IS_ENABLED(CONFIG_PREEMPT_COUNT) && preemptible())) ||
> +		  (rdp == this_cpu_ptr(&rcu_data) && is_pcpu_safe()) ||
>  		  rcu_current_is_nocb_kthread(rdp) ||
>  		  rcu_running_nocb_timer(rdp)),
>  		"Unsafe read of RCU_NOCB offloaded state"
> -- 
> 2.25.1
> 
