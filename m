From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Fri, 22 Jan 2016 14:24:29 +0200
Message-ID: <56A21F7D.9070101@ti.com>
References: <1453108103.4123.4.camel@gmail.com>
 <20160118201828.GE12309@linutronix.de> <1453170597.3740.7.camel@gmail.com>
 <20160121125405.GA11749@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38071 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbcAVMYk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jan 2016 07:24:40 -0500
In-Reply-To: <20160121125405.GA11749@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/21/2016 02:54 PM, Sebastian Andrzej Siewior wrote:
> * Mike Galbraith | 2016-01-19 03:29:57 [+0100]:
>=20
>>> And this is a new piece. So you forbid that tasks leave the CPU if
>>> lazy_count > 0. Let me look closed why this is happening and if thi=
s is
>>> v4.1 =E2=80=A6 v4.4 or not.
>>
>> We should probably just add the lazy bits to preemptible().
>=20
> Subject: preempt-lazy: Add the lazy-preemption check to preempt_sched=
ule()
>=20
> Probably in the rebase onto v4.1 this check got moved into less commo=
nly used
> preempt_schedule_notrace(). This patch ensures that both functions us=
e it.
>=20
> Reported-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   kernel/sched/core.c |   36 ++++++++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 8 deletions(-)
>=20
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3461,6 +3461,30 @@ static void __sched notrace preempt_sche
>   	} while (need_resched());
>   }
>  =20
> +#ifdef CONFIG_PREEMPT_LAZY
> +/*
> + * If TIF_NEED_RESCHED is then we allow to be scheduled away since t=
his is
> + * set by a RT task. Oterwise we try to avoid beeing scheduled out a=
s long as
> + * preempt_lazy_count counter >0.
> + */
> +static int preemptible_lazy(void)
> +{
> +	if (test_thread_flag(TIF_NEED_RESCHED))
> +		return 1;
> +	if (current_thread_info()->preempt_lazy_count)
> +		return 0;
> +	return 1;
> +}
> +
> +#else
> +
> +static int preemptible_lazy(void)
> +{
> +	return 1;
> +}
> +
> +#endif
> +
>   #ifdef CONFIG_PREEMPT
>   /*
>    * this is the entry point to schedule() from in-kernel preemption
> @@ -3475,6 +3499,8 @@ asmlinkage __visible void __sched notrac
>   	 */
>   	if (likely(!preemptible()))
>   		return;
> +	if (!preemptible_lazy())
> +		return;
>  =20
>   	preempt_schedule_common();
>   }
> @@ -3501,15 +3527,9 @@ asmlinkage __visible void __sched notrac
>  =20
>   	if (likely(!preemptible()))
>   		return;
> -
> -#ifdef CONFIG_PREEMPT_LAZY
> -	/*
> -	 * Check for lazy preemption
> -	 */
> -	if (current_thread_info()->preempt_lazy_count &&
> -	    !test_thread_flag(TIF_NEED_RESCHED))
> +	if (!preemptible_lazy())
>   		return;
> -#endif
> +
>   	do {
>   		preempt_disable_notrace();
>   		/*

I can see below backtrace during boot if i backport this change in K4.1=
-rt
TI am437x-idk (UP) board.

[    0.204022] Switched to clocksource arm_global_timer
[    0.211982] ------------[ cut here ]------------
[    0.212021] WARNING: CPU: 0 PID: 3 at kernel/softirq.c:894 __tasklet=
_action+0x150/0x17c()
[    0.212027] Modules linked in:
[    0.212041] CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 4.1.15-rt11-=
00324-g52f8148-dirty #117
[    0.212046] Hardware name: Generic AM43 (Flattened Device Tree)
[    0.212052] Backtrace:=20
[    0.212080] [<c0012b50>] (dump_backtrace) from [<c0012d70>] (show_st=
ack+0x18/0x1c)
[    0.212085]  r7:c0730a84 r6:0000037e r5:00000009 r4:00000000
[    0.212112] [<c0012d58>] (show_stack) from [<c05e6940>] (dump_stack+=
0x20/0x28)
[    0.212124] [<c05e6920>] (dump_stack) from [<c003713c>] (warn_slowpa=
th_common+0x7c/0xb4)
[    0.212134] [<c00370c0>] (warn_slowpath_common) from [<c0037218>] (w=
arn_slowpath_null+0x24/0x2c)
[    0.212138]  r8:000f4240 r7:00000000 r6:c0841238 r5:00000018 r4:0000=
0006
[    0.212156] [<c00371f4>] (warn_slowpath_null) from [<c003a0a4>] (__t=
asklet_action+0x150/0x17c)
[    0.212165] [<c0039f54>] (__tasklet_action) from [<c003a138>] (taskl=
et_action+0x30/0x38)
[    0.212169]  r9:04208140 r8:c0862300 r7:000000c0 r6:c082d774 r5:0000=
0018 r4:00000006
[    0.212187] [<c003a108>] (tasklet_action) from [<c0039c2c>] (do_curr=
ent_softirqs+0x190/0x258)
[    0.212197] [<c0039a9c>] (do_current_softirqs) from [<c003a170>] (ru=
n_ksoftirqd+0x30/0x58)
[    0.212201]  r10:00000000 r9:00000000 r8:00000002 r7:c082d8f0 r6:000=
00001 r5:ee81f740
[    0.212213]  r4:ee874000
[    0.212227] [<c003a140>] (run_ksoftirqd) from [<c00534e0>] (smpboot_=
thread_fn+0x15c/0x278)
[    0.212242] [<c0053384>] (smpboot_thread_fn) from [<c00500fc>] (kthr=
ead+0xcc/0xe4)
[    0.212246]  r9:00000000 r8:00000000 r7:c0053384 r6:ee81f740 r5:ee81=
f780 r4:00000000
[    0.212265] [<c0050030>] (kthread) from [<c000f988>] (ret_from_fork+=
0x14/0x2c)
[    0.212269]  r7:00000000 r6:00000000 r5:c0050030 r4:ee81f780
[    0.212279] ---[ end trace 0000000000000001 ]---
[    0.212284] softirq: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D c037d4c4 <---- t->func
^^
# grep c037d4c4 System.map
c037d4c4 t kbd_bh

=20


--=20
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
