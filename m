From: Kirill Tkhai <tkhai@yandex.ru>
Subject: Re:[PATCH]sched/rt: Do not try to push tasks if pinned task switches to RT
Date: Tue, 29 Jan 2013 13:13:37 +0400
Message-ID: <446051359450817@web10d.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	lizefan@huawei.com, jovi.zhangwei@huawei.com
To: Libo Chen <chenlibo.3@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



> From: Libo Chen <libo.chen@huawei.com>
>=20
> On 2013-1-29 4:23, Kirill Tkhai wrote:
>=20
>> Just switched pinned task is not able to be pushed. If the rq had ha=
d
>> several RT tasks before they have already been considered as candida=
tes
>> to be pushed (or pulled).
>>
>> Signed-off-by: Kirill V Tkhai <tkhai@yandex.ru>
>> CC: Steven Rostedt <rostedt@goodmis.org>
>> CC: Ingo Molnar <mingo@kernel.org>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: linux-rt-users <linux-rt-users@vger.kernel.org>
>> ---
>> kernel/sched/rt.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 4e8f0f4..5f7d92b 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -1925,9 +1925,9 @@ static void switched_to_rt(struct rq *rq, stru=
ct task_struct *p)
>> */
>> if (p->on_rq && rq->curr !=3D p) {
>> #ifdef CONFIG_SMP
>> - if (rq->rt.overloaded && push_rt_task(rq) &&
>> + if (rq->rt.overloaded && p->nr_cpus_allowed > 1 &&
>> /* Don't resched if we changed runqueues */
>> - rq !=3D task_rq(p))
>> + push_rt_task(rq) && rq !=3D task_rq(p))
>=20
> I think you worry about it was excess to call push_rt_task, since the=
 task of p->nr_cpus_allowed=3D1 can`t be pushed. is that right?

Sure.

>=20
> The task of p->nr_cpus_allowed =3D1 would`t be added to pushable_task=
s list =EF=BC=88see the enqueue_task_rt()=EF=BC=89and this push_rt_task=
() need to push other tasks when rt.overloaded.

If rq has already had 2 or more pushable tasks and we try to add a pinn=
ed task then call of push_rt_task will just waste a time.

>=20
> So I don`t agree this patch.
>=20
>> check_resched =3D 0;
>> #endif /* CONFIG_SMP */
>> if (check_resched && p->prio < rq->curr->prio)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html


 --=20
