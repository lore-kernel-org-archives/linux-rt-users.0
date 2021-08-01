Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37CBC4338F
	for <linux-rt-users@archiver.kernel.org>; Sun,  1 Aug 2021 15:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A576B610A5
	for <linux-rt-users@archiver.kernel.org>; Sun,  1 Aug 2021 15:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhHAPPq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 1 Aug 2021 11:15:46 -0400
Received: from mout.gmx.net ([212.227.15.19]:39551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbhHAPPq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 1 Aug 2021 11:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627830892;
        bh=YSIlQsKSoA7Muj+bsvyxbASqYJwAEDxmJLy1hYVZyZs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=baALA9nUv8bg/FQLGD9+CdebPizxBntP4gs1P+XyJp9Aulto8KiLC3T/EpzJ020Tr
         1dIXAe+kk4iGie8UBzqls3oMGiw2gZW1MQIAB1qf++0rU0WpRv3VypF0wffkOeb/fR
         OAPRdXVyyfCyLjmukbgKotdo0GECpyjDPAN7NPnE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.118]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1nEMaA49zd-014Uif; Sun, 01
 Aug 2021 17:14:52 +0200
Message-ID: <ed1d5f9ec17a5b8d758c234562dad47cfc872ed8.camel@gmx.de>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sun, 01 Aug 2021 17:14:49 +0200
In-Reply-To: <6fce881efc3d8c24a5172528fe1f46ec2ddc0607.camel@gmx.de>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
         <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
         <87pmuzsf1p.ffs@tglx>
         <6fce881efc3d8c24a5172528fe1f46ec2ddc0607.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1YG2yx6MueHvSKLHiLYYGJgo6sGe2vMoM5r0jQPqEWBhlYzwaR0
 ClZUAv3Nbp8LgxgPH95SUSLKAiQ0gt223iMKJHRqnYpEFaEim7hx66/ExkIkf69k2B/0Zg6
 vYNm3/HsjHdYAIRqk+iFdL+GREb+TwGWPS+iw6owp1hNGur7QFjEWft1SiuheN2e8Xv63Hg
 4oq5JzqFhcxocR7sAYxpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eOVOb2rq6bs=:PH30eOTsxp3BPEczLOPhHz
 FnhMfWVJ40eDtkrjmbihlsMZGYB+Lr79dAKRtElKpfVCsvsQIBMtL+qcfLfa2lVHQlOH9OKtc
 b/203uDVtCh/6Wuy/+X8lMJP+Rk4mZEcT+1HOAFncNip7Kj8MrkbseVXMYAjL3Si/gM8wXoJI
 R35DRmj+TDpaFUCpYXan6FBAaPssTcf5OGu75IryBaReCTtgTEwdw8q38phSig4JWucjlsv8i
 HVaBISBp2ttQENL10DpmJ6FRs5d8OyuPrh5WM9qqdhmQU7fgywoGyvzhLN3fkTc4p2YntdXuy
 KVV8dKtY14OXKLR2CgtT+ZE1Wuvw+geza7QsqbHCiBtbJGw6a6CaWVLqoAjzN7WOHNIb1Xh8M
 aaFEdGux3gWDDvONmoBNnT1srqrvQJsD5c8QzSCZ3kH98ImNhRB3OP9lq9jZGryxHySpZNpuM
 dPfx7yOUwPCq6fOBi2+G+C05H4ioI9UIl6YuLD09Q2fbkoF/BpAvagL2Luqm1OVvWsXk0anqV
 /xZ+CVroRoAD+uD644kauxg/rXggHrZEg4s6SNh86iLjkkBzJwEW25lXjipqJR0xL1/TpKJ1p
 DTcCphKojMmOXRZ/d+O5nPiT75wkvw04bLnn49i1UbHz2EusXZQFWHJ11lYs6oLD8HwHtZUOr
 Qlo4HXn49WXUZYMlMKa3PUuf9Htf/AOx/MFYeONu7GL277FNwD9hMEjK9c0ldee7a/WMmgky9
 Ke+9RLKFlbqsxv8aB1zzkZbDcoxarpmC0nb+Rl+L46COKJIdgcxptsYrcdBoWg1WOfEINEAWR
 sHQSCGRunoa9Els9VTSzSqA7ISAV6/iGkooGOj3497RmOfpSBHkOpJO/G0muy7wYYEh00cFP0
 vftZ2sy/7w8fZXGg0knmB14sJq/D2cKr3Lbcp/SMuirr267eEBQ97ULOogk5Rub/8iZJGNFfV
 tm/jjME+5b/AHZikEBYXKH6tswhrqQGFE1EUW6yq1kWwL8W74vvue5Q6NuJUjUuAifdT97R6G
 ep6I02BIyznk37+u6euueUDbEBakrgwg6inZh1zMrJ13U3FCeYapNNNddk2mJGvlrewctfyf8
 q+WorXVcUVnYPOXft2oG9fiArzn+4Q+882U
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, 2021-08-01 at 05:36 +0200, Mike Galbraith wrote:
> On Fri, 2021-07-30 at 22:49 +0200, Thomas Gleixner wrote:
> > >
> > > First symptom is KDE/Plasma's task manager going comatose.=C2=A0 Not=
ice soon
> >
> > KDE/Plasma points at the new fangled rtmutex based ww_mutex from
> > Peter.
>
> Seems not.=C2=A0 When booting KVM box with nomodeset, there's exactly on=
e
> early boot ww_mutex lock/unlock, ancient history at the failure point.

As you've probably already surmised given it isn't the ww_mutex bits,
it's the wake_q bits.  Apply the below, 5.14-rt ceases to fail.  Take
perfectly healthy 5.13-rt, apply those bits, and it instantly begins
failing as 5.14-rt had been.

=2D--
 include/linux/sched/wake_q.h    |    7 +------
 kernel/futex.c                  |    4 ++--
 kernel/locking/rtmutex.c        |   18 +++++++++++-------
 kernel/locking/rtmutex_api.c    |    6 +++---
 kernel/locking/rtmutex_common.h |   22 +++++++++++-----------
 kernel/sched/core.c             |    4 ++--
 6 files changed, 30 insertions(+), 31 deletions(-)

=2D-- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -61,11 +61,6 @@ static inline bool wake_q_empty(struct w

 extern void wake_q_add(struct wake_q_head *head, struct task_struct *task=
);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct =
*task);
-extern void __wake_up_q(struct wake_q_head *head, unsigned int state);
-
-static inline void wake_up_q(struct wake_q_head *head)
-{
-	__wake_up_q(head, TASK_NORMAL);
-}
+extern void wake_up_q(struct wake_q_head *head);

 #endif /* _LINUX_SCHED_WAKE_Q_H */
=2D-- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1499,11 +1499,11 @@ static void mark_wake_futex(struct wake_
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_sta=
te *pi_state)
 {
+	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
+	u32 curval, newval;
 	struct rt_mutex_waiter *top_waiter;
 	struct task_struct *new_owner;
 	bool postunlock =3D false;
-	DEFINE_RT_WAKE_Q(wqh);
-	u32 curval, newval;
 	int ret =3D 0;

 	top_waiter =3D rt_mutex_top_waiter(&pi_state->pi_mutex);
=2D-- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -425,20 +425,24 @@ static __always_inline void rt_mutex_adj
 }

 /* RT mutex specific wake_q wrappers */
-static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wq=
h,
+static __always_inline void rt_mutex_wake_q_add(struct rt_mutex_wake_q_he=
ad *wqh,
 						struct rt_mutex_waiter *w)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state !=3D TASK_NORMAL) {
-		wake_q_add(&wqh->rt_head, w->task);
+		get_task_struct(w->task);
+		wqh->rtlock_task =3D w->task;
 	} else {
 		wake_q_add(&wqh->head, w->task);
 	}
 }

-static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh=
)
+static __always_inline void rt_mutex_wake_up_q(struct rt_mutex_wake_q_hea=
d *wqh)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !wake_q_empty(&wqh->rt_head))
-		__wake_up_q(&wqh->rt_head, TASK_RTLOCK_WAIT);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
+		wake_up_state(wqh->rtlock_task, TASK_RTLOCK_WAIT);
+		put_task_struct(wqh->rtlock_task);
+		wqh->rtlock_task =3D NULL;
+	}

 	if (!wake_q_empty(&wqh->head))
 		wake_up_q(&wqh->head);
@@ -1111,7 +1115,7 @@ static int __sched task_blocks_on_rt_mut
  *
  * Called with lock->wait_lock held and interrupts disabled.
  */
-static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
+static void __sched mark_wakeup_next_waiter(struct rt_mutex_wake_q_head *=
wqh,
 					    struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter *waiter;
@@ -1210,7 +1214,7 @@ static __always_inline int __rt_mutex_tr
  */
 static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
 {
-	DEFINE_RT_WAKE_Q(wqh);
+	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
 	unsigned long flags;

 	/* irqsave required to support early boot calls */
=2D-- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -141,7 +141,7 @@ int __sched __rt_mutex_futex_trylock(str
  * @wqh:	The wake queue head from which to get the next lock waiter
  */
 bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
-				     struct rt_wake_q_head *wqh)
+				     struct rt_mutex_wake_q_head *wqh)
 {
 	lockdep_assert_held(&lock->wait_lock);

@@ -165,7 +165,7 @@ bool __sched __rt_mutex_futex_unlock(str

 void __sched rt_mutex_futex_unlock(struct rt_mutex_base *lock)
 {
-	DEFINE_RT_WAKE_Q(wqh);
+	DEFINE_RT_MUTEX_WAKE_Q_HEAD(wqh);
 	unsigned long flags;
 	bool postunlock;

@@ -454,7 +454,7 @@ void __sched rt_mutex_adjust_pi(struct t
 /*
  * Performs the wakeup of the top-waiter and re-enables preemption.
  */
-void __sched rt_mutex_postunlock(struct rt_wake_q_head *wqh)
+void __sched rt_mutex_postunlock(struct rt_mutex_wake_q_head *wqh)
 {
 	rt_mutex_wake_up_q(wqh);
 }
=2D-- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -42,20 +42,20 @@ struct rt_mutex_waiter {
 };

 /**
- * rt_wake_q_head - Wrapper around regular wake_q_head to support
- *		    "sleeping" spinlocks on RT
- * @head:	The regular wake_q_head for sleeping lock variants
- * @rt_head:	The wake_q_head for RT lock (spin/rwlock) variants
+ * rt_mutex_wake_q_head - Wrapper around regular wake_q_head to support
+ *			  "sleeping" spinlocks on RT
+ * @head:		The regular wake_q_head for sleeping lock variants
+ * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
  */
-struct rt_wake_q_head {
+struct rt_mutex_wake_q_head {
 	struct wake_q_head	head;
-	struct wake_q_head	rt_head;
+	struct task_struct	*rtlock_task;
 };

-#define DEFINE_RT_WAKE_Q(name)						\
-	struct rt_wake_q_head name =3D {					\
+#define DEFINE_RT_MUTEX_WAKE_Q_HEAD(name)				\
+	struct rt_mutex_wake_q_head name =3D {				\
 		.head		=3D WAKE_Q_HEAD_INITIALIZER(name.head),	\
-		.rt_head	=3D WAKE_Q_HEAD_INITIALIZER(name.rt_head),\
+		.rtlock_task	=3D NULL,					\
 	}

 /*
@@ -81,9 +81,9 @@ extern int __rt_mutex_futex_trylock(stru

 extern void rt_mutex_futex_unlock(struct rt_mutex_base *lock);
 extern bool __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
-				struct rt_wake_q_head *wqh);
+				struct rt_mutex_wake_q_head *wqh);

-extern void rt_mutex_postunlock(struct rt_wake_q_head *wqh);
+extern void rt_mutex_postunlock(struct rt_mutex_wake_q_head *wqh);

 /*
  * Must be guarded because this header is included from rcu/tree_plugin.h
=2D-- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -920,7 +920,7 @@ void wake_q_add_safe(struct wake_q_head
 		put_task_struct(task);
 }

-void __wake_up_q(struct wake_q_head *head, unsigned int state)
+void wake_up_q(struct wake_q_head *head)
 {
 	struct wake_q_node *node =3D head->first;

@@ -936,7 +936,7 @@ void __wake_up_q(struct wake_q_head *hea
 		 * wake_up_process() executes a full barrier, which pairs with
 		 * the queueing in wake_q_add() so as not to miss wakeups.
 		 */
-		wake_up_state(task, state);
+		wake_up_process(task);
 		put_task_struct(task);
 	}
 }


