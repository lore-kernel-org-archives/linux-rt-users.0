From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re: [PATCH]sched/rt: Do not try to push tasks if pinned task switches to RT
Date: Wed, 12 Mar 2014 16:23:48 +0400
Message-ID: <3618231394627028@web10g.yandex.ru>
References: <4451359470707@web16g.yandex.ru> <20140312061833.3a43aa64@gandalf.local.home> <20140312103942.GB5321@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140312103942.GB5321@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

12.03.2014, 14:39, "Nicholas Mc Guire" <der.herr@hofr.at>:
> On Wed, 12 Mar 2014, Steven Rostedt wrote:
>
>> =9APeter,
>>
>> =9AI'm going through my inbox (over a year old), and found this patc=
h from
>> =9AKirill. It looks fine to me. You can apply it with my
>>
>> =9A=9A=9AAcked-by: Steven Rostedt <rostedt@goodmis.org>
>>
>> =9A-- Steve
>>
>> =9A[PATCH]sched/rt: Do not try to push tasks if pinned task switches=
 to RT
>>
>> =9AJust switched pinned task is not able to be pushed. If the rq had=
 had
>> =9Aseveral RT tasks before they have already been considered as cand=
idates
>> =9Ato be pushed (or pulled).
>>
>> =9ASigned-off-by: Kirill V Tkhai <tkhai@yandex.ru>
>> =9ACC: Steven Rostedt <rostedt@goodmis.org>
>> =9ACC: Ingo Molnar <mingo@kernel.org>
>> =9ACC: Peter Zijlstra <peterz@infradead.org>
>> =9ACC: linux-rt-users <linux-rt-users@vger.kernel.org>
>> =9A---
>> =9A=9Akernel/sched/rt.c | =9A=9A=9A4 ++--
>> =9A=9A1 files changed, 2 insertions(+), 2 deletions(-)
>> =9Adiff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> =9Aindex 4e8f0f4..5aab032 100644
>> =9A--- a/kernel/sched/rt.c
>> =9A+++ b/kernel/sched/rt.c
>> =9A@@ -1925,9 +1925,9 @@ static void switched_to_rt(struct rq *rq, s=
truct task_struct *p)
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A*/
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aif (p->on_rq && rq->curr !=3D p) {
>> =9A=9A#ifdef CONFIG_SMP
>> =9A- if (rq->rt.overloaded && push_rt_task(rq) &&
>> =9A+ if (p->nr_cpus_allowed > 1 && rq->rt.overloaded &&
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A/*=
 Don't resched if we changed runqueues */
>> =9A- =9A=9A=9Arq !=3D task_rq(p))
>> =9A+ =9A=9A=9Apush_rt_task(rq) && rq !=3D task_rq(p))
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A=9Acheck_resched =3D 0;
>> =9A=9A#endif /* CONFIG_SMP */
>> =9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9Aif (check_resc=
hed && p->prio < rq->curr->prio)
>
> would there not need to be a check for p->migrate_disable ?
> push_rt_task() is not checking and so a high prio RT task
> preemting a low prio RT task in a migrate_disable() section
> would actually push it off this cpu ? atleast I did not
> find why that would not happen.

Hi, Nicholas!

p is not rq->curr, so its p->migrate_disable state is already updated a=
nd
it can't be pushed (nr_cpus_allowed =3D=3D 1 and it's not pushable).

(If I understand right, that you worry about this).

Kirill

> thx!
> hofrat
