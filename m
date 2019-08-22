Return-Path: <SRS0=VkLV=WS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3652C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 14:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD876233FC
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 14:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rSZqcGp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbfHVN75 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:59:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34680 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732074AbfHVN75 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 09:59:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so3743513pgc.1
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Aug 2019 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wLt0NWq/LRun0O8CoYHfgr7MSppfm5H9WYNNpPdHDeQ=;
        b=rSZqcGp9WrHx6CtcVWJdZ/3wdxjF3TASZ0HmQyWeJAXFEDvKCGwVp1CItOlyl1StqS
         fGd+XTr1rRuWOTKV1A04YRyx5LSkpGLQ6PU00AlW/sMucFcMgK8urWtoiWPPA4aJc9LD
         RODeGS4+NkQZwti+4bm2D/C6xhs9XfVWUTUsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wLt0NWq/LRun0O8CoYHfgr7MSppfm5H9WYNNpPdHDeQ=;
        b=oIj/lHxrm94JPy3NPA+wRArAlZeDZDQEjEhYjGd2AXw3xTWQn6mJY/2NBsQOtTrcn7
         HgDkeiOdlXCPkzcRsk7JB8qPweDNwZS8rOB2UT/ZW2w/3mRvUYrZxNA0pHXKs63nDlis
         laeuS1LjkLZ79er/6F9ap4d3wA5k7l1v0UCCxylrqHPARx13kFqzfZjsv6ElWTzTMv3U
         PabA7NDKzSBB430YLspKNPOo8HusxRux45qk9ePht43gfhoOFU6OVi/aNz285YvMQieM
         ePUEa2mTlJVNIr2mvh+RU+DznZleY4xWgVGje0eZJWGGv0Hzvk9Qs2QF87dq6jgQRmj2
         PKfg==
X-Gm-Message-State: APjAAAWPn6nQV7/XXK4oPEJcEzvN05B4dolm6Ux+q7KeX0FlfTUTASTk
        x91XYNAhLuy/g2uAHLnklwPk/hcjc4c=
X-Google-Smtp-Source: APXvYqxCWgKZGCyI9sd0rfUdLY2njLiZ5/9fbnN5I3LvKIHd3LZtHazb57EwVWDva8FkDIHQe5iM9Q==
X-Received: by 2002:a17:90a:77c9:: with SMTP id e9mr5316241pjs.141.1566482395826;
        Thu, 22 Aug 2019 06:59:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r6sm3727593pjb.22.2019.08.22.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 06:59:54 -0700 (PDT)
Date:   Thu, 22 Aug 2019 09:59:53 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 3/3] rcu: Disable use_softirq on PREEMPT_RT
Message-ID: <20190822135953.GB29841@google.com>
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-4-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821231906.4224-4-swood@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 21, 2019 at 06:19:06PM -0500, Scott Wood wrote:
> Besides restoring behavior that used to be default on RT, this avoids
> a deadlock on scheduler locks:
> 
> [  136.894657] 039: ============================================
> [  136.900401] 039: WARNING: possible recursive locking detected
> [  136.906146] 039: 5.2.9-rt3.dbg+ #174 Tainted: G            E
> [  136.912152] 039: --------------------------------------------
> [  136.917896] 039: rcu_torture_rea/13474 is trying to acquire lock:
> [  136.923990] 039: 000000005f25146d
> [  136.927310] 039:  (
> [  136.929414] 039: &p->pi_lock
> [  136.932303] 039: ){-...}
> [  136.934840] 039: , at: try_to_wake_up+0x39/0x920
> [  136.939461] 039:
> but task is already holding lock:
> [  136.944425] 039: 000000005f25146d
> [  136.947745] 039:  (
> [  136.949852] 039: &p->pi_lock
> [  136.952738] 039: ){-...}
> [  136.955274] 039: , at: try_to_wake_up+0x39/0x920
> [  136.959895] 039:
> other info that might help us debug this:
> [  136.965555] 039:  Possible unsafe locking scenario:
> 
> [  136.970608] 039:        CPU0
> [  136.973493] 039:        ----
> [  136.976378] 039:   lock(
> [  136.978918] 039: &p->pi_lock
> [  136.981806] 039: );
> [  136.983911] 039:   lock(
> [  136.986451] 039: &p->pi_lock
> [  136.989336] 039: );
> [  136.991444] 039:
>  *** DEADLOCK ***
> 
> [  136.995194] 039:  May be due to missing lock nesting notation
> 
> [  137.001115] 039: 3 locks held by rcu_torture_rea/13474:
> [  137.006341] 039:  #0:
> [  137.008707] 039: 000000005f25146d
> [  137.012024] 039:  (
> [  137.014131] 039: &p->pi_lock
> [  137.017015] 039: ){-...}
> [  137.019558] 039: , at: try_to_wake_up+0x39/0x920
> [  137.024175] 039:  #1:
> [  137.026540] 039: 0000000011c8e51d
> [  137.029859] 039:  (
> [  137.031966] 039: &rq->lock
> [  137.034679] 039: ){-...}
> [  137.037217] 039: , at: try_to_wake_up+0x241/0x920
> [  137.041924] 039:  #2:
> [  137.044291] 039: 00000000098649b9
> [  137.047610] 039:  (
> [  137.049714] 039: rcu_read_lock
> [  137.052774] 039: ){....}
> [  137.055314] 039: , at: cpuacct_charge+0x33/0x1e0
> [  137.059934] 039:
> stack backtrace:
> [  137.063425] 039: CPU: 39 PID: 13474 Comm: rcu_torture_rea Kdump: loaded Tainted: G            E     5.2.9-rt3.dbg+ #174
> [  137.074197] 039: Hardware name: Intel Corporation S2600BT/S2600BT, BIOS SE5C620.86B.01.00.0763.022420181017 02/24/2018
> [  137.084886] 039: Call Trace:
> [  137.087773] 039:  <IRQ>
> [  137.090226] 039:  dump_stack+0x5e/0x8b
> [  137.093997] 039:  __lock_acquire+0x725/0x1100
> [  137.098358] 039:  lock_acquire+0xc0/0x240
> [  137.102374] 039:  ? try_to_wake_up+0x39/0x920
> [  137.106737] 039:  _raw_spin_lock_irqsave+0x47/0x90
> [  137.111534] 039:  ? try_to_wake_up+0x39/0x920
> [  137.115910] 039:  try_to_wake_up+0x39/0x920
> [  137.120098] 039:  rcu_read_unlock_special+0x65/0xb0
> [  137.124977] 039:  __rcu_read_unlock+0x5d/0x70
> [  137.129337] 039:  cpuacct_charge+0xd9/0x1e0
> [  137.133522] 039:  ? cpuacct_charge+0x33/0x1e0
> [  137.137880] 039:  update_curr+0x14b/0x420
> [  137.141894] 039:  enqueue_entity+0x42/0x370
> [  137.146080] 039:  enqueue_task_fair+0xa9/0x490
> [  137.150528] 039:  activate_task+0x5a/0xf0
> [  137.154539] 039:  ttwu_do_activate+0x4e/0x90
> [  137.158813] 039:  try_to_wake_up+0x277/0x920
> [  137.163086] 039:  irq_exit+0xb6/0xf0
> [  137.166661] 039:  smp_apic_timer_interrupt+0xe3/0x3a0
> [  137.171714] 039:  apic_timer_interrupt+0xf/0x20
> [  137.176249] 039:  </IRQ>
> [  137.178785] 039: RIP: 0010:__schedule+0x0/0x8e0
> [  137.183319] 039: Code: 00 02 48 89 43 20 e8 0f 5a 00 00 48 8d 7b 28 e8 86 f2 fd ff 31 c0 5b 5d 41 5c c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <55> 48 89 e5 41 57 41 56 49 c7 c6 c0 ca 1e 00 41 55 41 89 fd 41 54
> [  137.202498] 039: RSP: 0018:ffffc9005835fbc0 EFLAGS: 00000246
> [  137.208158] 039:  ORIG_RAX: ffffffffffffff13
> [  137.212428] 039: RAX: 0000000000000000 RBX: ffff8897c3e1bb00 RCX: 0000000000000001
> [  137.219994] 039: RDX: 0000000080004008 RSI: 0000000000000006 RDI: 0000000000000001
> [  137.227560] 039: RBP: ffff8897c3e1bb00 R08: 0000000000000000 R09: 0000000000000000
> [  137.235126] 039: R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff81001fd1
> [  137.242694] 039: R13: 0000000000000044 R14: 0000000000000000 R15: ffffc9005835fcac
> [  137.250259] 039:  ? ___preempt_schedule+0x16/0x18
> [  137.254969] 039:  preempt_schedule_common+0x32/0x80
> [  137.259846] 039:  ___preempt_schedule+0x16/0x18
> [  137.264379] 039:  rcutorture_one_extend+0x33a/0x510 [rcutorture]
> [  137.270397] 039:  rcu_torture_one_read+0x18c/0x450 [rcutorture]
> [  137.276334] 039:  rcu_torture_reader+0xac/0x1f0 [rcutorture]
> [  137.281998] 039:  ? rcu_torture_reader+0x1f0/0x1f0 [rcutorture]
> [  137.287920] 039:  kthread+0x106/0x140
> [  137.291591] 039:  ? rcu_torture_one_read+0x450/0x450 [rcutorture]
> [  137.297681] 039:  ? kthread_bind+0x10/0x10
> [  137.301783] 039:  ret_from_fork+0x3a/0x50
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> I think the prohibition on use_softirq can be dropped once RT gets the
> latest RCU code, but the question of what use_softirq should default
> to on PREEMPT_RT remains.

Independent of the question of what use_softirq should default to, could we
test RT with latest RCU code now to check if the deadlock goes away?  That
way, maybe we can find any issues in current RCU that cause scheduler
deadlocks in the situation you pointed. The reason I am asking is because
recently additional commits [1] try to prevent deadlock and it'd be nice to
ensure that other conditions are not lingering (I don't think they are but
it'd be nice to be sure).

I am happy to do such testing myself if you want, however what does it take
to apply the RT patchset to the latest mainline? Is it an achievable feat?

thanks,

 - Joel

[1]
23634ebc1d94 ("rcu: Check for wakeup-safe conditions")
25102de ("rcu: Only do rcu_read_unlock_special() wakeups if expedited")


>  kernel/rcu/tree.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index fc8b00c61b32..12036d33e2f9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -98,9 +98,16 @@ struct rcu_state rcu_state = {
>  /* Dump rcu_node combining tree at boot to verify correct setup. */
>  static bool dump_tree;
>  module_param(dump_tree, bool, 0444);
> -/* By default, use RCU_SOFTIRQ instead of rcuc kthreads. */
> +/*
> + * By default, use RCU_SOFTIRQ instead of rcuc kthreads.
> + * But, avoid RCU_SOFTIRQ on PREEMPT_RT due to pi/rq deadlocks.
> + */
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +static bool use_softirq;
> +#else
>  static bool use_softirq = 1;
>  module_param(use_softirq, bool, 0444);
> +#endif
>  /* Control rcu_node-tree auto-balancing at boot time. */
>  static bool rcu_fanout_exact;
>  module_param(rcu_fanout_exact, bool, 0444);
> -- 
> 1.8.3.1
> 
