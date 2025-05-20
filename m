Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E24280CFC;
	Tue, 20 May 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770764; cv=none; b=PFqlILntroN9+T2hUXtUegixkhrfFBQNVKZX2AhthLvweCY+pLPTSswneHv2iudBvqlPF+oUfO72whgDslp34szAhqq7aVjrWqGG5VCF4XAW1J2aPUvE7TxMss2W4I36OgzEaTt98PNuMXWRvZBBh1seBuQ06EIiyXOBYSNWeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770764; c=relaxed/simple;
	bh=b4RbQ84tx1XFStD4qJ3AiP2hwVNN1gTiKT6J78qPNoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awqqoAyv06pSJANfO6y2KiUivNkJ+1PKmyZYUYVFhj8nMBeNsXWkNi0IUZnvEJGittxOq42mkBqtkoJoh2lDoqp5BMWD6LEHEBVlFR2ERqx+7q2KVOOFfCBMi4fDMlvynoi9FncPXPjeHW6uBqYLxN1eK6x19YGdn5S58pNwgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF711C4CEE9;
	Tue, 20 May 2025 19:52:42 +0000 (UTC)
Date: Tue, 20 May 2025 15:53:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: fengtian guo <fengtian_guo@hotmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux RT
 Development <linux-rt-devel@lists.linux.dev>, linux-rt-users
 <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH RT] Possible spinlock deadlock in kernel/sched/rt.c
 under high load
Message-ID: <20250520155324.3968b7d4@gandalf.local.home>
In-Reply-To: <OSAPR01MB4675AD3FE11ED9C21055DE5AF59FA@OSAPR01MB4675.jpnprd01.prod.outlook.com>
References: <OSAPR01MB4675AD3FE11ED9C21055DE5AF59FA@OSAPR01MB4675.jpnprd01.prod.outlook.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Can you please not send HTML emails. One, they get blocked from all
kernel.org mailing lists, and two, they are impossible to read on a text
email client.

I'll keep the below to show you what your email looks like in text, and
also to make it get to some of the mailing lists.

Thanks,

-- Steve


On Tue, 20 May 2025 09:52:03 +0000
fengtian guo <fengtian_guo@hotmail.com> wrote:

>   1.
>=20
>=20
>   1.
> I encountered a hard deadlock issue in the RT-patched kernel (v5.10) on a=
n ARM64 arm64 32cores server, triggered by high-load stress testing with RT=
 threads.
>=20
> Open Questions=E2=80=8B=E2=80=8B
>=20
>   1.  =E2=80=8B=E2=80=8BRT Patch Specificity=E2=80=8B=E2=80=8B: Is this a=
 new RT-specific issue =EF=BC=9F or better patch for fix ?
>=20
> First Deadlock Root Cause Analysis=E2=80=8B=E2=80=8B
> The initial deadlock occurs due to =E2=80=8B=E2=80=8Bunprotected spinlock=
 access between an IRQ work thread and a hardware interrupt on the same CPU=
=E2=80=8B=E2=80=8B. Here is the critical path:
> =E2=80=8B=E2=80=8BDeadlock Sequence=E2=80=8B=E2=80=8B
>=20
>   1.  =E2=80=8B=E2=80=8BIRQ Work Thread Context=E2=80=8B=E2=80=8B (RT pri=
ority):
>=20
> irq_work =E2=86=92 rto_push_irq_work_func =E2=86=92 raw_spin_lock(&rq->lo=
ck) =E2=86=92 push_rt_task
>=20
>      *   The rto_push_irq_work_func thread acquires rq->lock =E2=80=8B=E2=
=80=8Bwithout disabling interrupts=E2=80=8B=E2=80=8B.
>   2.  =E2=80=8B=E2=80=8BHardware Interrupt Context=E2=80=8B=E2=80=8B (Clo=
ck timer):
>=20
>=20
> hrtimer_interrupt =E2=86=92 __hrtimer_run_queues =E2=86=92 _run_hrtimer =
=E2=86=92 hrtimer_wakeup =E2=86=92 try_to_wake_up =E2=86=92 ttwu_queue =E2=
=86=92 raw_spin_lock(&rq->lock)
>=20
>      *   The clock interrupt preempts the IRQ work thread =E2=80=8B=E2=80=
=8Bwhile it holds rq->lock=E2=80=8B=E2=80=8B.
>      *   The interrupt handler attempts to acquire the same rq->lock via =
ttwu_queue, causing a =E2=80=8B=E2=80=8Bdouble-lock deadlock=E2=80=8B=E2=80=
=8B.
>=20
>=20
>   1.
> After analysis, the deadlock arises from spinlock contention between inte=
rrupt contexts (e.g., hrtimer_interrupt) and thread contexts (e.g., rto_pus=
h_irq_work_func).
>=20
>=20
>   1.
>=20
>=20
> [871.101301][ C6] NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
> [871.101302][ C12] NMI watchdog: Watchdog detected hard LOCKUP on cpu 12
> [871.103274][ C31] NMI watchdog: Watchdog detected hard LOCKUP on cpu 31
> [871.101302][ C12] NMI watchdog: Watchdog detected hard LOCKUP on cpu 12
> [871.101414][ C12] pstate: 00400089 (nzcv daIf +PAN -UAO -TCO BTYPE=3D---)
> [871.101426][ C12] sp : ffff800010063cf0
> [871.101408][ C12] CPU: 12 PID: 97 Comm: irq_work/12 Kdump: loaded Tainte=
d: G
> [871.101416][ C12] pc : native_queued_spin_lock_slowpath+0x188/0x354
> [871.101422][ C12] lr : _raw_spin_lock+0x7c/0x8c
> [871.101476][ C12] Call trace:
> [871.101477][ C12] native_queued_spin_lock_slowpath+0x188/0x354
> [871.101479][ C12] _raw_spin_lock+0x7c/0x8c
> [871.101482][ C12] ttwu_queue+0x58/0x154
> [871.101485][ C12] try_to_wake_up+0x1e4/0x4e0
> [871.101488][ C12] wake_up_process+0x20/0x30
> [871.101490][ C12] hrtimer_wakeup+0x28/0x40
> [871.101493][ C12] _run_hrtimer+0x84/0x304
> [871.101495][ C12] _hrtimer_run_queues+0xfb8/0x15c
> [871.101497][ C12] hrtimer_interrupt+0xfc/0x2d0
> [871.101500][ C12] arch_timer_handler_phys+0x3c/0x50
> [871.101504][ C12] handle_percpu_devid_irq+0xac/0x2b0
> [871.101508][ C12] _handle_domain_irq+0xb8/0x13c
> [871.101511][ C12] gic_handle_irq+0x78/0x2d0
> [871.101513][ C12] el1_irq+0xb8/0x180
> [871.101515][ C12] find_lowest_rq+0x0/0x26c
> [871.101517][ C12] rto_push_irq_work_func+0x180/0x1ec
> [871.101519][ C12] irq_work_single+0x38/0xb4
> [871.101522][ C12] irq_work_run_list+0x48/0x60
> [871.101525][ C12] run_irq_workd+0x30/0x40
> [871.101527][ C12] smpboot_thread_fn+0x278/0x300
> [871.101530][ C12] kthread+0x170/0x19c
> [871.101532][ C12] ret_from_fork+0x10/0x18
> [871.103274][ C31] NMI watchdog: Watchdog detected hard LOCKUP on cpu 31
> [871.103326][ C31] CPU: 31 PID: 8897 Comm: stress-ng-cpu Kdump: loaded Ta=
inted: G
> [871.103330][ C31] pstate: 00400089 (nzcv daIf +PAN -UAO -TCO BTYPE=3D---)
> [871.103332][ C31] pc : native_queued_spin_lock_slowpath+0x254/0x354
> [871.103336][ C31] lr : native_queued_spin_lock_slowpath+0xc4/0x354
> [871.103338][ C31] sp : ffff8000100fbd00
> [871.103339][ C31] x29: ffff8000100fbd00 x28: ffff748fb7dbb6c0
> [871.103341][ C31] x27: 0000000000000000 x26: ffffbfc0c4eeee30
> [871.103343][ C31] x25: ffffbfc0c4ef6e38 x24: ffffbfc0c4ef7800
> [871.103345][ C31] x23: ffffbfc0c4eeee30 x22: 000000000800000
> [871.103347][ C31] x21: ffffbfc0c4bde2c0 x20: ffff748fb7ff62c0
> [871.103349][ C31] x19: ffff748fb7dbb480 x18: 0000000000000000
> [871.103350][ C31] x17: 0000000000000000 x16: 0000000000000000
> [871.103352][ C31] x15: 0000000000000000 x14: 0000000000000000
> [871.103354][ C31] x13: 0000000000000000 x12: 000000000000040
> [871.103355][ C31] x11: 0000002d03aa232c x10: 000000000011af2
> [871.103357][ C31] x9 : ffffbfc0c45d0de0 x8 : 00000000000002f
> [871.103359][ C31] x7 : 0000000000000000 x6 : 0000000000000000
> [871.103361][ C31] x5 : 0000000000000000 x4 : ffff748fb7ff62c0
> [871.103362][ C31] x3 : 0000000001c0101 x2 : ffffbfc0c4e10001
> [871.103364][ C31] x1 : 0000000000000000 x0 : 0000000000000000
> [871.103366][ C31] Call trace:
> [871.103367][ C31] native_queued_spin_lock_slowpath+0x254/0x354
> [871.103369][ C31] _raw_spin_lock+0x7c/0x8c
> [871.103372][ C31] do_sched_rt_period_timer+0x118/0x3a0
> [871.103374][ C31] sched_rt_period_timer+0x6c/0x150
> [871.103376][ C31] _run_hrtimer+0x84/0x304
> [871.103378][ C31] _hrtimer_run_queues+0xfb8/0x15c
> [871.103380][ C31] hrtimer_interrupt+0xfc/0x2d0
> [871.103382][ C31] arch_timer_handler_phys+0x3c/0x50
> [871.103385][ C31] handle_percpu_devid_irq+0xac/0x2b0
> [871.103388][ C31] _handle_domain_irq+0xb8/0x13c
> [871.103390][ C31] gic_handle_irq+0x78/0x2d0
> [871.103392][ C31] el0_irq_naked+0x50/0x58
> [871.101301][ C6] NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
> [871.101414][ C6] pstate: 80400089 (Nzcv daIf +PAN -UAO -TCO BTYPE=3D---)
> [871.101424][ C6] sp : ffff80001cfbbbf0
> [871.101474][ C6]
> [871.101416][ C6] pc : native_queued_spin_lock_slowpath+0x220/0x354
> [871.101422][ C6] lr : native_queued_spin_lock_slowpath+0xc4/0x354
> [871.101408][ C6] CPU: 6 PID: 3170 Comm: dm_sched_thd Kdump: loaded Taint=
ed: G
> [871.101475][ C6] Call trace:
> [871.101476][ C6] native_queued_spin_lock_slowpath+0x220/0x354
> [871.101479][ C6] _raw_spin_lock+0x7c/0x8c
> [871.101483][ C6] ttwu_queue+0x58/0x154
> [871.101486][ C6] try_to_wake_up+0x1e4/0x4e0
> [871.101488][ C6] _wake_up_q+0xb8/0xf0
> [871.101491][ C6] futex_wake+0x178/0x1bc
> [871.101493][ C6] do_futex+0x148/0x1cc
> [871.101496][ C6] _arm64_sys_futex+0x120/0x1a0
> [871.101498][ C6] el0_svc_common.constprop.0+0x7c/0x1b4
> [871.101501][ C6] do_el0_svc+0x2c/0x9c
> [871.101504][ C6] el0_svc+0x20/0x30
> [871.101506][ C6] el0_sync_handler+0xb0/0xb4
> [871.101508][ C6] el0_sync+0x160/0x180
> [871.101510][ C6] Kernel panic - not syncing:
> [871.101511][ C6] Hard LOCKUP
> [871.101512][ C6] CPU: 6 PID: 3170 Comm: dm_sched_thd Kdump: loaded Taint=
ed: G
> 10.0-60.18.0.rt62.50.kl.aarch64 #1
> [871.101515][ C6] Call trace:
> [871.101516][ C6] dump_backtrace+0x0/0x1e4
> [871.101518][ C6] show_stack+0x20/0x2c
> [871.101519][ C6] dump_stack+0xd0/0x134
> [871.101522][ C6] panic+0xd4/0x3c4
> [871.101525][ C6] add_taint+0x0/0xbc
> [871.101528][ C6] watchdog_hardlockup_check+0x108/0x1a0
> [871.101531][ C6] sdei_watchdog_callback+0x94/0xd0
> [871.101534][ C6] sdei_event_handler+0x28/0x84
> [871.101538][ C6] _sdei_handler+0x88/0x150
> [109 ][871.101534][ C6] sdei_event_handler+0x28/0x84
> [110 ][871.101538][ C6] _sdei_handler+0x88/0x150
> [111 ][871.101539][ C6] _sdei_handler+0x30/0x60
> [112 ][871.101541][ C6] _sdei_asm_handler+0xbc/0x16c
> [113 ][871.101541][ C6] native_queued_spin_lock_slowpath+0x220/0x354
> [114 ][871.101544][ C6] _raw_spin_lock+0x7c/0x8c
> [115 ][871.101547][ C6] ttwu_queue+0x58/0x154
> [116 ][871.101549][ C6] try_to_wake_up+0x1e4/0x4e0
> [117 ][871.101551][ C6] _wake_up_q+0xb8/0xf0
> [118 ][871.101553][ C6] futex_wake+0x178/0x1bc
> [119 ][871.101555][ C6] do_futex+0x148/0x1cc
> [120 ][871.101556][ C6] _arm64_sys_futex+0x120/0x1a0
> [121 ][871.101558][ C6] el0_svc_common.constprop.0+0x7c/0x1b4
>=20
>=20
>=20
>   1.
> Drift version1  patch
>=20
>=20
>   1.
> kernel/sched/rt.c | 89 ++++++++++++++++++++++++++++++++++++++++----------=
-----------
> 1 file changed, 54 insertions(+), 35 deletions(-)
>=20
> @@ -2127,6 +2137,9 @@ void rto_push_irq_work_func(struct irq_work *work)
>     struct rq *rq;
>     int cpu;
>  + unsigned long flags;
>  + u64 start_ts, end_ts, spend =3D 0;
>  + int mycpu =3D raw_smp_processor_id();
>=20
>     rq =3D this_rq();
> @@ -2135,19 +2148,24 @@ void rto_push_irq_work_func(struct irq_work *work)
>     * When it gets updated, a check is made if a push is possible.
>     */
>     if (has_pushable_tasks(rq)) {
>   -      raw_spin_lock(&rq->lock);
>   +      raw_spin_lock_irqsave(&rq->lock, flags);
>   +      start_ts =3D ktime_get_ns();
>         while (push_rt_task(rq, true))
>             ;
>   -     raw_spin_unlock(&rq->lock);
>   +      end_ts =3D ktime_get_ns();
>   +     raw_spin_unlock_irqrestore(&rq->lock, flags);
>   +     spend =3D end_ts - start_ts;
>     }
>=20
>=20
>=20
>=20
>=20
> A2
>=20
>   1.  =E2=80=8B=E2=80=8BRevised Fix (v2)=E2=80=8B=E2=80=8B:
>      *   =E2=80=8B=E2=80=8BImprovement=E2=80=8B=E2=80=8B: replace all raw=
 spinlock with irq disable (e.g., root_domain->rto_lock).
>      *
> =E2=80=8B
>      *   =E2=80=8B=E2=80=8BAttachments=E2=80=8B=E2=80=8B:
>         *
>  second_patch.txt (revised fix) - sorry this is not original patch but fr=
om my screen shot convert to text so some - or + is not regconized correctl=
y (If needed I will create new patch)
>         *
> second_deadlock_dump_after_patch1.txt  (updated backtrace) I just get par=
t of backtrace when panic
>=20
> Test Results and Fix Progress=E2=80=8B=E2=80=8B
> =E2=80=8B=E2=80=8B1. Pre-Fix: Severe System Crashes=E2=80=8B=E2=80=8B
>=20
>   *   =E2=80=8B=E2=80=8BTest Parameters=E2=80=8B=E2=80=8B:
>=20
> bash
>=20
>=20
> cyclictest -i 1000  # Default priority testing
> stress-ng --rt 0 --rt-period 1000000 --rt-runtime 500000  # Baseline stre=
ss test
>=20
>   *   =E2=80=8B=E2=80=8BResults=E2=80=8B=E2=80=8B:
>      *   System crashed or rebooted within =E2=80=8B=E2=80=8B10=E2=80=931=
5 minutes=E2=80=8B=E2=80=8B.
>      *   Crash call stacks indicated contention on rq->lock (see attachme=
nt crash-log-v0.txt).
>=20
> ________________________________
> =E2=80=8B=E2=80=8B2. First Patch (patch-v1): Significant Stability Improv=
ement=E2=80=8B=E2=80=8B
>=20
>   *   =E2=80=8B=E2=80=8BPatch Changes=E2=80=8B=E2=80=8B:
>      *   Used raw_spin_lock_irqsave in critical paths (e.g., rto_push_irq=
_work_func) to disable interrupts.
>      *   Resolved lock contention between interrupt and thread contexts o=
n the same CPU.
>   *   =E2=80=8B=E2=80=8BTest Parameters=E2=80=8B=E2=80=8B:
>=20
> bash
>=20
> cyclictest -i 10    # High-frequency testing
> stress-ng --rt 4 --rt-period 100000 --rt-runtime 90000  # High-load RT ta=
sks
>=20
>   *   =E2=80=8B=E2=80=8BResults=E2=80=8B=E2=80=8B:
>      *   =E2=80=8B=E2=80=8BNo crashes for 3 hours=E2=80=8B=E2=80=8B under=
 normal stress tests.
>      *   =E2=80=8B=E2=80=8BCrash after 2.7 hours=E2=80=8B=E2=80=8B under =
extreme testing (cyclictest -i 1) (see crash-log-v1.txt).
>      *   =E2=80=8B=E2=80=8BRoot Cause=E2=80=8B=E2=80=8B: Global lock (roo=
t_domain->rto_lock) etc in cross-CPU operations.
>=20
> ________________________________
> =E2=80=8B=E2=80=8B3. Second Patch (patch-v2): Full Stability Under Extrem=
e Load=E2=80=8B=E2=80=8B
>=20
>   *
> =E2=80=8B=E2=80=8B
>   *   =E2=80=8B=E2=80=8BTest Parameters=E2=80=8B=E2=80=8B:
>=20
> bash
>=20
>=20
> cyclictest -i 1     # Extreme frequency testing (1=CE=BCs interval)
> stress-ng --rt 8 --rt-period 50000 --rt-runtime 45000  # Maximum RT task =
load
>=20
>   *   =E2=80=8B=E2=80=8BResults=E2=80=8B=E2=80=8B:
>      *   =E2=80=8B=E2=80=8BSystem remained stable for 18+ hours=E2=80=8B=
=E2=80=8B with zero crashes.
>      *   All test cases passed (see test-log-v2.txt).
>=20
>=20
>=20
> Best Regards
> Fengtian

