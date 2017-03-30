From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [BUG nohz]: wrong user and system time accounting
Date: Wed, 29 Mar 2017 22:14:00 -0400
Message-ID: <20170329221400.2b1e8d77@redhat.com>
References: <20170323165512.60945ac6@redhat.com>
        <CANRm+CxcgSP2-x+A822DmHLvFLzFmTptS6oYwYtwVdErTpiB=Q@mail.gmail.com>
        <1490636129.8850.76.camel@redhat.com>
        <20170328132406.7d23579c@redhat.com>
        <20170329131656.1d6cb743@redhat.com>
        <20170329221700.GB23895@lerouge>
        <CANRm+CzSCJODribK6vPhQVT=CGFX7ewT6K3mTMu4vfZv5r_8LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Frederic Weisbecker <fweisbec@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org, Rik van Riel <riel@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANRm+CzSCJODribK6vPhQVT=CGFX7ewT6K3mTMu4vfZv5r_8LA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 30 Mar 2017 06:46:30 +0800
Wanpeng Li <kernellwp@gmail.com> wrote:

> > So! Now we need to find a proper fix :o)
> >
> > Hmm, how bad would it be to revert to sched_clock() instead of jiffies in vtime_delta()?
> > We could use nanosecond granularity to check deltas but only perform an actual cputime update
> > when that delta >= TICK_NSEC. That should keep the load ok.  
> 
> Yeah, I mentioned something similar before.
> https://lkml.org/lkml/2017/3/26/138 However, Rik's commit optimized
> syscalls by not utilize sched_clock(), so if we should distinguish
> between syscalls/exceptions and irqs?

Why not use ktime_get()?

Here's the solution I was thinking about, it's mostly untested. I'm
rate limiting below TICK_NSEC because I want to avoid syncing with
the tick.

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index f3778e2b..a8b1e85 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -676,18 +676,20 @@ void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
 static u64 vtime_delta(struct task_struct *tsk)
 {
-	unsigned long now = READ_ONCE(jiffies);
+	return ktime_sub(ktime_get(), tsk->vtime_snap);
+}
 
-	if (time_before(now, (unsigned long)tsk->vtime_snap))
-		return 0;
+/* A little bit less than the tick period */
+#define VTIME_RATE_LIMIT (TICK_NSEC - 200000)
 
-	return jiffies_to_nsecs(now - tsk->vtime_snap);
+static bool vtime_should_account(struct task_struct *tsk)
+{
+	return vtime_delta(tsk) > VTIME_RATE_LIMIT;
 }
 
 static u64 get_vtime_delta(struct task_struct *tsk)
 {
-	unsigned long now = READ_ONCE(jiffies);
-	u64 delta, other;
+	u64 delta, other, now = ktime_get();
 
 	/*
 	 * Unlike tick based timing, vtime based timing never has lost
@@ -696,7 +698,7 @@ static u64 get_vtime_delta(struct task_struct *tsk)
 	 * elapsed time. Limit account_other_time to prevent rounding
 	 * errors from causing elapsed vtime to go negative.
 	 */
-	delta = jiffies_to_nsecs(now - tsk->vtime_snap);
+	delta = ktime_sub(now, tsk->vtime_snap);
 	other = account_other_time(delta);
 	WARN_ON_ONCE(tsk->vtime_snap_whence == VTIME_INACTIVE);
 	tsk->vtime_snap = now;
@@ -711,7 +713,7 @@ static void __vtime_account_system(struct task_struct *tsk)
 
 void vtime_account_system(struct task_struct *tsk)
 {
-	if (!vtime_delta(tsk))
+	if (!vtime_should_account(tsk))
 		return;
 
 	write_seqcount_begin(&tsk->vtime_seqcount);
@@ -723,7 +725,7 @@ void vtime_account_user(struct task_struct *tsk)
 {
 	write_seqcount_begin(&tsk->vtime_seqcount);
 	tsk->vtime_snap_whence = VTIME_SYS;
-	if (vtime_delta(tsk))
+	if (vtime_should_account(tsk))
 		account_user_time(tsk, get_vtime_delta(tsk));
 	write_seqcount_end(&tsk->vtime_seqcount);
 }
@@ -731,7 +733,7 @@ void vtime_account_user(struct task_struct *tsk)
 void vtime_user_enter(struct task_struct *tsk)
 {
 	write_seqcount_begin(&tsk->vtime_seqcount);
-	if (vtime_delta(tsk))
+	if (vtime_should_account(tsk))
 		__vtime_account_system(tsk);
 	tsk->vtime_snap_whence = VTIME_USER;
 	write_seqcount_end(&tsk->vtime_seqcount);
@@ -747,7 +749,7 @@ void vtime_guest_enter(struct task_struct *tsk)
 	 * that can thus safely catch up with a tickless delta.
 	 */
 	write_seqcount_begin(&tsk->vtime_seqcount);
-	if (vtime_delta(tsk))
+	if (vtime_should_account(tsk))
 		__vtime_account_system(tsk);
 	current->flags |= PF_VCPU;
 	write_seqcount_end(&tsk->vtime_seqcount);
@@ -776,7 +778,7 @@ void arch_vtime_task_switch(struct task_struct *prev)
 
 	write_seqcount_begin(&current->vtime_seqcount);
 	current->vtime_snap_whence = VTIME_SYS;
-	current->vtime_snap = jiffies;
+	current->vtime_snap = ktime_get();
 	write_seqcount_end(&current->vtime_seqcount);
 }
 
