From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Re: 3.12.6-rt9 on AM335x (armv7)
Date: Wed, 08 Jan 2014 09:06:53 +0100
Message-ID: <52CD071D.9060207@ma-fu.de>
References: <52C44448.3030405@ma-fu.de> <15611103.51LOkxSQt9@dabox> <52CC6F94.6070906@ma-fu.de> <10785809.PZUZGWPMgY@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Tim Sander <tim@krieglstein.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:41865 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbaAHIGu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Jan 2014 03:06:50 -0500
In-Reply-To: <10785809.PZUZGWPMgY@hydra>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tim,

I already linked to trace for a 2508us run in a previous post. Here is =
the
most interesting section. A added two comments:

=2E..
ksoftirq-3       0dN..311 83809806626us+: lock_acquire: c1194890 &rq->l=
ock

#
# Typically rt_tuntime_lock is kept for only a few us:
#

ksoftirq-3       0dN..411 83809806633us+: lock_acquire: c1194cc8 &rt_rq=
->rt_runtime_lock
ksoftirq-3       0dN..411 83809806638us+: lock_release: c1194cc8 &rt_rq=
->rt_runtime_lock
ksoftirq-3       0d...311 83809806644us+: sched_switch: prev_comm=3Dkso=
ftirqd/0 prev_pid=3D3 prev_prio=3D98 prev_state=3DR+ =3D=3D> next_comm=3D=
cyclictest next_pid=3D1126 next_prio=3D0
ksoftirq-3       0d...311 83809806649us+: lock_release: c1194890 &rq->l=
ock
ksoftirq-3       0d...311 83809806653us+: lock_acquire: c0852178 read r=
cu_read_lock
ksoftirq-3       0d...311 83809806658us+: lock_release: c0852178 rcu_re=
ad_lock
cyclicte-1126    0d...3.. 83809806662us+: lock_acquire: c1194890 &rq->l=
ock
cyclicte-1126    0d...3.. 83809806666us+: lock_release: c1194890 &rq->l=
ock
cyclicte-1126    0d...2.. 83809806672us+: lock_acquire: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0d...2.. 83809806677us+: lock_release: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0....1.. 83809806681us+: sys_exit: NR 265 =3D 0
cyclicte-1126    0....1.. 83809806687us+: sys_enter: NR 263 (1, b6fc884=
0, 0, 0, 4c, 0)
cyclicte-1126    0....1.. 83809806691us+: sys_exit: NR 263 =3D 0
cyclicte-1126    0....1.. 83809806698us+: sys_enter: NR 265 (1, 1, b6fc=
8848, 0, 1, 0)
cyclicte-1126    0....1.. 83809806702us+: hrtimer_init: hrtimer=3Dcd0a5=
f10 clockid=3DCLOCK_MONOTONIC mode=3DHRTIMER_MODE_ABS
cyclicte-1126    0d...2.. 83809806707us+: lock_acquire: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0d...2.. 83809806712us+: hrtimer_start: hrtimer=3Dcd0a=
5f10 function=3Dhrtimer_wakeup expires=3D83809801188363 softexpires=3D8=
3809801188363
cyclicte-1126    0d...2.. 83809806717us+: hrtimer_cancel: hrtimer=3Dcd0=
a5f10
cyclicte-1126    0d...2.. 83809806721us+: lock_release: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0d...2.. 83809806726us+: lock_acquire: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0d...2.. 83809806730us+: lock_release: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0....1.. 83809806734us+: sys_exit: NR 265 =3D 0
cyclicte-1126    0....1.. 83809806739us+: sys_enter: NR 263 (1, b6fc884=
0, 0, 0, bf, 0)
cyclicte-1126    0....1.. 83809806742us+: sys_exit: NR 263 =3D 0
cyclicte-1126    0....1.. 83809806747us+: sys_enter: NR 265 (1, 1, b6fc=
8848, 0, 1, 0)
cyclicte-1126    0....1.. 83809806750us+: hrtimer_init: hrtimer=3Dcd0a5=
f10 clockid=3DCLOCK_MONOTONIC mode=3DHRTIMER_MODE_ABS
cyclicte-1126    0d...2.. 83809806754us+: lock_acquire: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0d...2.. 83809806758us+: hrtimer_start: hrtimer=3Dcd0a=
5f10 function=3Dhrtimer_wakeup expires=3D83809801388363 softexpires=3D8=
3809801388363
cyclicte-1126    0d...2.. 83809806764us+: lock_release: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0....2.. 83809806769us+: rcu_utilization: Start contex=
t switch
cyclicte-1126    0....2.. 83809806772us+: rcu_utilization: End context =
switch
cyclicte-1126    0d...3.. 83809806775us+: lock_acquire: c1194890 &rq->l=
ock
cyclicte-1126    0d...4.. 83809806781us+: lock_acquire: c1194cc8 &rt_rq=
->rt_runtime_lock
cyclicte-1126    0d...4.. 83809806786us+: lock_release: c1194cc8 &rt_rq=
->rt_runtime_lock
cyclicte-1126    0d...3.. 83809806797us+: sched_switch: prev_comm=3Dcyc=
lictest prev_pid=3D1126 prev_prio=3D0 prev_state=3DS =3D=3D> next_comm=3D=
ksoftirqd/0 next_pid=3D3 next_prio=3D98
cyclicte-1126    0d...3.. 83809806801us+: lock_release: c1194890 &rq->l=
ock
cyclicte-1126    0d...3.. 83809806805us+: lock_acquire: c0852178 read r=
cu_read_lock
cyclicte-1126    0d...3.. 83809806810us+: lock_release: c0852178 rcu_re=
ad_lock
ksoftirq-3       0d...311 83809806814us+: lock_acquire: c1194890 &rq->l=
ock
ksoftirq-3       0d...311 83809806819us+: lock_release: c1194890 &rq->l=
ock
ksoftirq-3       0....111 83809806827us+: softirq_entry: vec=3D1 [actio=
n=3DTIMER]
ksoftirq-3       0d...212 83809806836us+: lock_acquire: c0893b50 &(&(&b=
ase->lock)->lock)->wait_lock
ksoftirq-3       0d...212 83809806841us+: lock_release: c0893b50 &(&(&b=
ase->lock)->lock)->wait_lock
ksoftirq-3       0d...112 83809806846us+: lock_acquire: c0893b74 &base-=
>lock
ksoftirq-3       0....112 83809806855us+: timer_cancel: timer=3Dc088873=
8
ksoftirq-3       0d...112 83809806858us+: lock_release: c0893b74 &base-=
>lock
ksoftirq-3       0d...212 83809806862us+: lock_acquire: c0893b50 &(&(&b=
ase->lock)->lock)->wait_lock
ksoftirq-3       0d...212 83809806867us+: lock_release: c0893b50 &(&(&b=
ase->lock)->lock)->wait_lock
ksoftirq-3       0d...111 83809806873us+: lock_acquire: ce075e20 (&(&tb=
l->gc_work)->timer)
ksoftirq-3       0....111 83809806882us+: timer_expire_entry: timer=3Dc=
0888738 function=3Ddelayed_work_timer_fn now=3D8350980
ksoftirq-3       0d...111 83809806888us+: lock_acquire: c0852178 read r=
cu_read_lock
ksoftirq-3       0d...212 83809806896us+: lock_acquire: c1194210 &(&(&p=
ool->lock)->lock)->wait_lock
ksoftirq-3       0d..h312 83809806904us+: lock_acquire: ce009470 &irq_d=
esc_lock_class
ksoftirq-3       0d..h412 83809806910us+: lock_acquire: ce00f210 &gc->l=
ock
ksoftirq-3       0d..h412 83809806915us+: lock_release: ce00f210 &gc->l=
ock
ksoftirq-3       0d..h412 83809806919us+: lock_acquire: ce00f210 &gc->l=
ock
ksoftirq-3       0d..h412 83809806923us+: lock_release: ce00f210 &gc->l=
ock
ksoftirq-3       0d..h312 83809806927us+: lock_release: ce009470 &irq_d=
esc_lock_class
ksoftirq-3       0d..h212 83809806931us+: irq_handler_entry: irq=3D84 n=
ame=3Dgp_timer
ksoftirq-3       0d..h312 83809806934us+: lock_acquire: c1191990 hrtime=
r_bases.lock
ksoftirq-3       0d..h312 83809806940us+: hrtimer_cancel: hrtimer=3Dcd0=
a5f10
ksoftirq-3       0d..h312 83809806944us+: lock_release: c1191990 hrtime=
r_bases.lock
ksoftirq-3       0d..h212 83809806948us+: hrtimer_expire_entry: hrtimer=
=3Dcd0a5f10 function=3Dhrtimer_wakeup now=3D83809801429280
ksoftirq-3       0d..h312 83809806952us+: lock_acquire: ce08f2f4 &p->pi=
_lock
ksoftirq-3       0d..h412 83809806957us+: lock_acquire: c1194890 &rq->l=
ock
ksoftirq-3       0dN.h412 83809806966us+: sched_wakeup: comm=3Dcyclicte=
st pid=3D1126 prio=3D0 success=3D1 target_cpu=3D000
ksoftirq-3       0dN.h412 83809806970us+: lock_release: c1194890 &rq->l=
ock
ksoftirq-3       0dN.h312 83809806975us+: lock_release: ce08f2f4 &p->pi=
_lock
ksoftirq-3       0dN.h212 83809806979us+: hrtimer_expire_exit: hrtimer=3D=
cd0a5f10
ksoftirq-3       0dN.h312 83809806982us+: lock_acquire: c1191990 hrtime=
r_bases.lock
ksoftirq-3       0dN.h312 83809806987us+: lock_release: c1191990 hrtime=
r_bases.lock
ksoftirq-3       0dN.h212 83809806993us+: irq_handler_exit: irq=3D84 re=
t=3Dhandled
ksoftirq-3       0dN.h312 83809806997us+: lock_acquire: ce009470 &irq_d=
esc_lock_class
ksoftirq-3       0dN.h412 83809807002us+: lock_acquire: ce00f210 &gc->l=
ock
ksoftirq-3       0dN.h412 83809807006us+: lock_release: ce00f210 &gc->l=
ock
ksoftirq-3       0dN.h312 83809807011us+: lock_release: ce009470 &irq_d=
esc_lock_class
ksoftirq-3       0dN..212 83809807019us+: lock_release: c1194210 &(&(&p=
ool->lock)->lock)->wait_lock
ksoftirq-3       0.N..212 83809807024us+: rcu_utilization: Start contex=
t switch
ksoftirq-3       0dN..312 83809807029us+: lock_acquire: c0854ed0 rcu_no=
de_0
ksoftirq-3       0dN..312 83809807076us+: lock_release: c0854ed0 rcu_no=
de_0
ksoftirq-3       0.N..212 83809807083us+: rcu_utilization: End context =
switch
ksoftirq-3       0dN..312 83809807087us+: lock_acquire: c1194890 &rq->l=
ock

#
# Here comes the problem: rt_tuntime_lock is keept for more than 2000us=
:
#

ksoftirq-3       0dN..412 83809807130us!: lock_acquire: c1194cc8 &rt_rq=
->rt_runtime_lock
ksoftirq-3       0dN..412 83809809299us+: lock_release: c1194cc8 &rt_rq=
->rt_runtime_lock
ksoftirq-3       0d...312 83809809317us+: sched_switch: prev_comm=3Dkso=
ftirqd/0 prev_pid=3D3 prev_prio=3D98 prev_state=3DR+ =3D=3D> next_comm=3D=
cyclictest next_pid=3D1126 next_prio=3D0
ksoftirq-3       0d...312 83809809328us+: lock_release: c1194890 &rq->l=
ock
ksoftirq-3       0d...312 83809809338us+: lock_acquire: c0852178 read r=
cu_read_lock
ksoftirq-3       0d...312 83809809348us+: lock_release: c0852178 rcu_re=
ad_lock
cyclicte-1126    0d...3.. 83809809355us+: lock_acquire: c1194890 &rq->l=
ock
cyclicte-1126    0d...3.. 83809809363us+: lock_release: c1194890 &rq->l=
ock
cyclicte-1126    0d...2.. 83809809376us+: lock_acquire: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0d...2.. 83809809382us+: lock_release: c1191990 hrtime=
r_bases.lock
cyclicte-1126    0....1.. 83809809390us+: sys_exit: NR 265 =3D 0
cyclicte-1126    0....1.. 83809809401us+: sys_enter: NR 263 (1, b6fc884=
0, 0, 0, 2b, 0)
cyclicte-1126    0....1.. 83809809411us!: sys_exit: NR 263 =3D 0
cyclicte-1126    0....1.. 83809809512us+: sys_enter: NR 4 (5, b6fc9538,=
 22, b6fc955a, 18de8, b6fc9538)
cyclicte-1126    0d...1.. 83809809520us+: lock_acquire: c0852178 read r=
cu_read_lock
cyclicte-1126    0d...1.. 83809809527us+: lock_release: c0852178 rcu_re=
ad_lock
cyclicte-1126    0d...1.. 83809809540us+: lock_acquire: ce037b6c read s=
b_writers
cyclicte-1126    0d...1.. 83809809553us+: lock_acquire: ce5a5968 &mm->m=
map_sem
cyclicte-1126    0d...2.. 83809809561us+: lock_acquire: ce5a5944 &(&((&=
mm->mmap_sem))->lock)->wait_lock
cyclicte-1126    0d...2.. 83809809568us+: lock_release: ce5a5944 &(&((&=
mm->mmap_sem))->lock)->wait_lock
cyclicte-1126    0d...211 83809809586us+: lock_acquire: ce5a5900 &(&(&m=
m->page_table_lock)->lock)->wait_lock
cyclicte-1126    0d...211 83809809592us+: lock_release: ce5a5900 &(&(&m=
m->page_table_lock)->lock)->wait_lock
cyclicte-1126    0d...111 83809809597us+: lock_acquire: ce5a5924 &mm->p=
age_table_lock
cyclicte-1126    0d...111 83809809606us+: lock_release: ce5a5924 &mm->p=
age_table_lock
cyclicte-1126    0d...211 83809809610us+: lock_acquire: ce5a5900 &(&(&m=
m->page_table_lock)->lock)->wait_lock
cyclicte-1126    0d...211 83809809615us+: lock_release: ce5a5900 &(&(&m=
m->page_table_lock)->lock)->wait_lock
cyclicte-1126    0d...1.. 83809809633us+: lock_release: ce5a5968 &mm->m=
map_sem
cyclicte-1126    0d...2.. 83809809638us+: lock_acquire: ce5a5944 &(&((&=
mm->mmap_sem))->lock)->wait_lock
cyclicte-1126    0d...2.. 83809809644us+: lock_release: ce5a5944 &(&((&=
mm->mmap_sem))->lock)->wait_lock
cyclicte-1126    0.....11 83809809650us+: tracing_mark_write: hit laten=
cy threshold (500 > 2508)
cyclicte-1126    0d...1.. 83809809663us+: lock_acquire: c0dd6b6c read &=
fsnotify_mark_srcu
cyclicte-1126    0d...1.. 83809809670us+: lock_release: c0dd6b6c &fsnot=
ify_mark_srcu
cyclicte-1126    0d...1.. 83809809675us+: lock_release: ce037b6c sb_wri=
ters
cyclicte-1126    0....1.. 83809809681us+: sys_exit: NR 4 =3D 34
cyclicte-1126    0....1.. 83809809690us+: sys_enter: NR 4 (4, fb70, 1, =
18de8, 9cc, 0)
cyclicte-1126    0d...1.. 83809809693us+: lock_acquire: c0852178 read r=
cu_read_lock
cyclicte-1126    0d...1.. 83809809708us+: lock_release: c0852178 rcu_re=
ad_lock
cyclicte-1126    0d...1.. 83809809714us+: lock_acquire: ce037b6c read s=
b_writers
cyclicte-1126    0d...1.. 83809809727us+: lock_acquire: c0855794 trace_=
types_lock
cyclicte-1126    0d...2.. 83809809734us+: lock_acquire: c0855774 trace_=
types_lock.lock.wait_lock
cyclicte-1126    0d...2.. 83809809747us : lock_release: c0855774 trace_=
types_lock.lock.wait_lock

Matthias

On 07.01.2014 23:58, Tim Sander wrote:
> Hi Matthias
>> without hackbench and frieds (idle system) I get a max. latency of a=
bout
>> 4ms. Running hackbench (default arguments, -l 1000), it  still incre=
ases up
>> to 5ms:
>>
>> ...
>> # Total: 000000193
>> # Min Latencies: 00024
>> # Avg Latencies: 00205
>> # Max Latencies: 05058
>> ...
>>
>> The obvious PM stuff is disabled. No dynamic frequency scaling, etc.
>> Really weired stuff. I already mentioned the 3.2 system with the sam=
e CPU in
>> the OSADL lab. It comes with max. latency of 118us. So I really expe=
ct
>> something similiar.
> Yeah 118 =B5s should be the right ballpark, while still a little high=
 for my=20
> taste. All cortex a8 seem to have rather high latency. The A9's seem =
much=20
> better in this respect.
>=20
> Have you seen the following:
> https://www.osadl.org/Realtime-Preempt-Kernel.kernel-rt.0.html#latenc=
yfighting
>=20
> Cyclictest has tracing support which might help finding the cause of =
the long=20
> latency.=20
>=20
> Best regards
> Tim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
