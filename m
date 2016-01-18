From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Mon, 18 Jan 2016 21:18:28 +0100
Message-ID: <20160118201828.GE12309@linutronix.de>
References: <1453108103.4123.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453108103.4123.4.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Mike Galbraith | 2016-01-18 10:08:23 [+0100]:

>--- a/arch/x86/entry/common.c
>+++ b/arch/x86/entry/common.c
>@@ -220,14 +220,14 @@ long syscall_trace_enter(struct pt_regs
>=20
> #define EXIT_TO_USERMODE_LOOP_FLAGS				\
> 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
>-	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY)
>+	 _TIF_NEED_RESCHED_MASK | _TIF_USER_RETURN_NOTIFY)
>=20

If I read this right, the loop where this define is used
_TIF_ALLWORK_MASK in v4.1 of which _TIF_NEED_RESCHED_MASK was part of.
Adding this will reassmeble the old behaviour.
=E2=80=A6

>--- a/kernel/sched/core.c
>+++ b/kernel/sched/core.c
>@@ -3542,6 +3542,15 @@ asmlinkage __visible void __sched notrac
> 	if (likely(!preemptible()))
> 		return;
>=20
>+#ifdef CONFIG_PREEMPT_LAZY
>+	/*
>+	 * Check for lazy preemption
>+	 */
>+	if (current_thread_info()->preempt_lazy_count &&
>+	    !test_thread_flag(TIF_NEED_RESCHED))
>+		return;
>+#endif
>+

And this is a new piece. So you forbid that tasks leave the CPU if
lazy_count > 0. Let me look closed why this is happening and if this is
v4.1 =E2=80=A6 v4.4 or not.

> 	preempt_schedule_common();
> }
> NOKPROBE_SYMBOL(preempt_schedule);

Sebastian
