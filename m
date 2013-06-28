From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: don't clear PF_THREAD_BOUND in select_fallback_rq
Date: Fri, 28 Jun 2013 13:57:18 +0200
Message-ID: <51CD7A1E.2000308@linutronix.de>
References: <5178F0DE.8030808@huawei.com> <20130607205048.GA22550@linutronix.de> <20130607205917.GA3395@linutronix.de> <51C519A6.4090902@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	zhangwei <jovi.zhangwei@huawei.com>, bitbucket@online.de
To: Qiang Huang <h.huangqiang@huawei.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45828 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab3F1L5V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Jun 2013 07:57:21 -0400
In-Reply-To: <51C519A6.4090902@huawei.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/22/2013 05:27 AM, Qiang Huang wrote:

>> The only way I lose this flag is by starting a workqueue on a CPU wh=
ich
>> if offline. Now that is wrong. I am not sure if the workqueue re-use=
s
>=20
> How do you judge a thread lost PF_THREAD_BOUND flag or not?

I have a printk in the code path you want to kill.
>=20
> My way is:
> # for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
=E2=80=A6snip=E2=80=A6

> As you can see, many kernel threads' affinity can be changed, which w=
ere
> supposed to be attached to only one cpu, most of them are kworkers, a=
s
> well as some other kernel threads.

Yes, I see your output but I can't reproduce it here.

> After applying my patch, turns out:
=E2=80=A6snip=E2=80=A6

> These changing all failed. We can't change the cpu affinity of those
> threads which are attached to only one cpu.
>=20
> I don't kown if that's enought to say many threads' PF_THREAD_BOUND f=
lag
> is cleared which should not be. But your patches definitely not resol=
ve
> this problem, the taskset result is similar to my first one. I don't =
know
> if this is the direct reason for the hung problem, but this is truly =
a
> problem, right?

So it seems that you lose your flag but I don't know how. I only lose
it for threads which are woken up shortly before exit.

> And my test shows the same thing, after applying your patches, my
> cgroup_fj test will still cause system hung, after reboot, log messag=
e
> shows the same as I sent before:
> ...
=E2=80=A6snip=E2=80=A6

> ...
>=20
> So right now, my patch is still my only solution.
>=20
> One thing need to be clear, my test is on 3.4.45-rt60, but I think al=
l 3.4-rt
> versions have this problem.

Oh boy. We have too many RT trees. Can you retest you problem on latest
v3.8 and see if it there a problem, too?
I just booted
"Linux sq 3.4.41-rt55 #5 SMP PREEMPT RT Fri Jun 28 13:44:38 CEST 2013
x86_64 GNU/Linux"

and I have a Script doing:

|for pid in $(ps -e -o pid);
|do
|        taskset -p -c 6,7 $pid >/dev/null 2>&1
|        if [ $? -eq 0 ]
|        then
|                C=3D"$(cat /proc/$pid/cmdline)"
|                if [ -z "$C" ]
|                then
|                        echo "Okay: $(cat /proc/$pid/comm)"
|                fi
|        fi
|done


which is basically your test. It will print each kernel thread on which
the affinity change went well. There are no kworker, no migration
threads, no softirqs. Just kthreadd, irq/* and so on.
So I still have no idea how and why you lose this flag and I still
can't reproduce it.
The interesting part is, why do your threads lose their flag and mine
don't.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
