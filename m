From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [PATCH] sched/rt: Decrease number of calls of push_rt_task() in push_rt_tasks()
Date: Fri, 01 Feb 2013 01:57:54 +0400
Message-ID: <313901359669474@web15h.yandex.ru>
References: <2016751359330408@web20f.yandex.ru> <1359648490.17639.107.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359648490.17639.107.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



31.01.2013, 20:08, "Steven Rostedt" <rostedt@goodmis.org>:
> On Mon, 2013-01-28 at 03:46 +0400, Kirill Tkhai wrote:
>
>> =9AThe patch aims to decrease the number of calls of push_rt_task()
>> =9Ain push_rt_tasks().
>>
>> =9AIt's not necessary to push more than 'num_online_cpus() - 1' task=
s.
>> =9AIf just pushed task doesn't leave its new CPU during our local ca=
ll
>> =9Aof push_rt_tasks() than we won't push another task to the CPU.
>> =9AIf it leave or change priority than it will pull new task by itse=
lf.
>
> I'm curious. Have you hit situations where this was an issue? Or was
> this just discovered by code review?

No, I did't hit this situation. It's impossible to hook every situation=
=2E

Thanks for your explanation.

Kirill

>
> -- Steve
>
>> =9ASigned-off-by: Kirill V Tkhai <tkhai@yandex.ru>
>> =9ACC: Steven Rostedt <rostedt@goodmis.org>
>> =9ACC: Ingo Molnar <mingo@kernel.org>
>> =9ACC: Peter Zijlstra <peterz@infradead.org>
>> =9ACC: linux-rt-users <linux-rt-users@vger.kernel.org>
>> =9A---
>> =9A=9Akernel/sched/rt.c | =9A=9A=9A4 +++-
>> =9A=9A1 file changed, 3 insertions(+), 1 deletion(-)
>> =9Adiff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> =9Aindex 4e8f0f4..edf046d 100644
>> =9A--- a/kernel/sched/rt.c
>> =9A+++ b/kernel/sched/rt.c
>> =9A@@ -1703,8 +1703,10 @@ out:
>>
>> =9A=9Astatic void push_rt_tasks(struct rq *rq)
>> =9A=9A{
>> =9A+ int num_cpus =3D num_online_cpus() - 1;
>> =9A+
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A/* push_rt_task will return true if it=
 moved an RT */
>> =9A- while (push_rt_task(rq))
>> =9A+ while (push_rt_task(rq) && --num_cpus > 0)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A;
>> =9A=9A}
