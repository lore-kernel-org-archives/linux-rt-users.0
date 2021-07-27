Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9745C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 23:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8515B60F9E
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Jul 2021 23:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhG0XIS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Jul 2021 19:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232198AbhG0XIR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Jul 2021 19:08:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF79F60EB2;
        Tue, 27 Jul 2021 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627427297;
        bh=fGzQ1yxz3VodJVrSOBzAcSVWcjc+avK52D1CDLlbVEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGjLo5NK3LAP03NixFWTa/BVZ0L+YJ8vcQXLdfXsz/VIGe2B0qk684NU5Q0AQJmSW
         JBUY/FQtGmx/2CsyIf21zVm0fhs8xBAw18Duo0myWqc+xGnINpjwsOLuhkVH6XdpsC
         k8lz89BOs5lR+0fmScyn4rAWRcTwQFWHgqknjVwfOOyjwVCZYcxUPuSjuBNDvADPbs
         uC5fh5f2eSmLo+VYMMn6Z6/N/CMgPIZxO27xBNBkIxUECfDdLV3Jj+K/zf+Vdt8B9m
         8r7LA5Ek1jascxDILuJhUFvxttj2E+fdT+0NZbcX4cN7J84d/IGnGR9/qLZsDeVTbj
         0a0HV9Vzw/dAA==
Date:   Wed, 28 Jul 2021 01:08:14 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20210727230814.GC283787@lothringen>
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
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
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

I fear that won't work. We really need any caller of rcu_rdp_is_offloaded()
on the local rdp to have preemption disabled and not just migration disabled,
because we must protect against concurrent offloaded state changes.

The offloaded state is changed by a workqueue that executes on the target rdp.

Here is a practical example where it matters:

           CPU 0
           -----
           // =======> task rcuc running
           rcu_core {
	       rcu_nocb_lock_irqsave(rdp, flags) {
                   if (!rcu_segcblist_is_offloaded(rdp->cblist)) {
		       // is not offloaded right now, so it's going
                       // to just disable IRQs. Oh no wait:
           // preemption
           // ========> workqueue running
           rcu_nocb_rdp_offload();
           // ========> task rcuc resume
	               local_irq_disable();
                   }
               }
	       ....
       	       rcu_nocb_unlock_irqrestore(rdp, flags) {
                   if (rcu_segcblist_is_offloaded(rdp->cblist)) {
                       // is offloaded right now so:
                       raw_spin_unlock_irqrestore(rdp, flags);

And that will explode because that's an impaired unlock on nocb_lock.
