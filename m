From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: 3.8.10-rt6 : Observing high latency as timer_interrupt is taking
 longer to exit
Date: Tue, 14 May 2013 10:40:29 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F190B386F60@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:15289
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627Ab3ENKkO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 May 2013 06:40:14 -0400
Received: from mail28-db8 (localhost [127.0.0.1])	by mail28-db8-R.bigfish.com
 (Postfix) with ESMTP id A831E2C0940	for <linux-rt-users@vger.kernel.org>;
 Tue, 14 May 2013 10:40:11 +0000 (UTC)
Received: from DB8EHSMHS006.bigfish.com (unknown [10.174.8.237])	by
 mail28-db8.bigfish.com (Postfix) with ESMTP id B6112C0045	for
 <linux-rt-users@vger.kernel.org>; Tue, 14 May 2013 10:40:09 +0000 (UTC)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am running PREEMPT_RT =A0kernel on single-core PowerPC based platform=
 and using cyclictest tool to measure latency.

Earlier I have used 2.6.33.9-rt31, With that kernel, latency has always=
 remained below 50us irrespective of the traffic.=20
With 3.8.10-rt6, latency is shooting beyond 200us irrespective of the t=
raffic - no load, heavy traffic conditions included. Issue is generally=
 reproduced within 10 minutes of run

When I tried to debug the issue using ftrace, I am observing that it is=
 taking 200us for transition from timer_interrupt_exit(interrupts disab=
led) to timer_start =A0in Kworker/-297 thread.
I have tried multiple times and always observed similar trace. Please h=
elp me in debugging the issue.

Trace Logs:

cyclicte-3307=A0=A0=A0 0d...2.. 104489596us+: hrtimer_start: hrtimer=3D=
dfee9e98 function=3Dhrtimer_wakeup expires=3D1587365915748 softexpires=3D=
1587365865748
cyclicte-3307=A0=A0=A0 0d...3.. 104489599us+: sched_stat_runtime: comm=3D=
cyclictest pid=3D3307 runtime=3D119552 [ns] vruntime=3D22040816169 [ns]
cyclicte-3307=A0=A0=A0 0d...3.. 104489602us!: sched_switch: prev_comm=3D=
cyclictest prev_pid=3D3307 prev_prio=3D120 prev_state=3DS =3D=3D> next_=
comm=3Dswapper next_pid=3D0 next_prio=3D120
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489732us+: timer_interrupt_e=
ntry: pt_regs=3Dc086fed0
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h3.. 104489733us : hrtimer_cancel: h=
rtimer=3Dc0830240
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489735us+: hrtimer_expire_en=
try: hrtimer=3Dc0830240 function=3Dtick_sched_timer now=3D1587356002980
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489741us : softirq_raise: ve=
c=3D1 [action=3DTIMER]
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489743us+: softirq_raise: ve=
c=3D9 [action=3DRCU]
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489744us+: hrtimer_expire_ex=
it: hrtimer=3Dc0830240
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h3.. 104489746us+: hrtimer_start: hr=
timer=3Dc0830240 function=3Dtick_sched_timer expires=3D1587360000000 so=
ftexpires=3D1587360000000
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489749us+: timer_interrupt_e=
xit: pt_regs=3Dc086fed0
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d...5.. 104489751us+: sched_wakeup: com=
m=3Dksoftirqd/0 pid=3D3 prio=3D98 success=3D1 target_cpu=3D000
=A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d...3.. 104489755us+: sched_switch: pre=
v_comm=3Dswapper prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=3D> ne=
xt_comm=3Dksoftirqd/0 next_pid=3D3 next_prio=3D98
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489758us+: softirq_entry: vec=3D=
1 [action=3DTIMER]
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489761us+: timer_cancel: timer=
=3Deb260d9c
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489762us+: timer_expire_entry:=
 timer=3Deb260d9c function=3Ddelayed_work_timer_fn now=3D321839
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489765us+: workqueue_queue_wor=
k: work struct=3Deb260d8c function=3Dphy_state_machine workqueue=3Deb80=
3bc0 req_cpu=3D1 cpu=3D0
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489767us+: workqueue_activate_=
work: work struct eb260d8c
ksoftirq-3=A0=A0=A0=A0=A0=A0 0d...3.. 104489770us+: sched_wakeup: comm=3D=
kworker/0:1 pid=3D297 prio=3D120 success=3D1 target_cpu=3D000
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489772us : timer_expire_exit: =
timer=3Deb260d9c
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489773us : timer_cancel: timer=
=3Deb260b9c
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489774us : timer_expire_entry:=
 timer=3Deb260b9c function=3Ddelayed_work_timer_fn now=3D321839
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489775us : workqueue_queue_wor=
k: work struct=3Deb260b8c function=3Dphy_state_machine workqueue=3Deb80=
3bc0 req_cpu=3D1 cpu=3D0
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489775us : workqueue_activate_=
work: work struct eb260b8c
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489777us : timer_expire_exit: =
timer=3Deb260b9c
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489778us : softirq_exit: vec=3D=
1 [action=3DTIMER]
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489779us+: softirq_entry: vec=3D=
9 [action=3DRCU]
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489781us : kmem_cache_free: ca=
ll_site=3Dc00fd3e4 ptr=3Dd4f9f780
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489782us : kmem_cache_free: ca=
ll_site=3Dc0154bc0 ptr=3Deb7f8998
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489783us : kmem_cache_free: ca=
ll_site=3Dc01123ec ptr=3De9937b80
ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489784us+: softirq_exit: vec=3D=
9 [action=3DRCU]
ksoftirq-3=A0=A0=A0=A0=A0=A0 0d...3.. 104489788us+: sched_switch: prev_=
comm=3Dksoftirqd/0 prev_pid=3D3 prev_prio=3D98 prev_state=3DS =3D=3D> n=
ext_comm=3Dkworker/0:1 next_pid=3D297 next_prio=3D120
kworker/-297=A0=A0=A0=A0 0....1.. 104489793us!: workqueue_execute_start=
: work struct eb260d8c: function phy_state_machine
kworker/-297=A0=A0=A0=A0 0d..h1.. 104489916us+: irq_entry: pt_regs=3Deb=
917d50
kworker/-297=A0=A0=A0=A0 0d..h1.. 104489920us : irq_handler_entry: irq=3D=
18 name=3Dserial
kworker/-297=A0=A0=A0=A0 0d..h1.. 104489921us+: irq_handler_exit: irq=3D=
18 ret=3Dhandled
kworker/-297=A0=A0=A0=A0 0d..h3.. 104489923us+: sched_wakeup: comm=3Dir=
q/18-serial pid=3D3267 prio=3D49 success=3D1 target_cpu=3D000
kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489925us+: irq_exit: pt_regs=3Deb9=
17d50
kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489985us+: timer_interrupt_entry: =
pt_regs=3Deb917d60
kworker/-297=A0=A0=A0=A0 0dN.h2.. 104489987us+: hrtimer_cancel: hrtimer=
=3Dd4e8de78
kworker/-297 =A0=A0=A0=A00dN.h1.. 104489989us+: hrtimer_expire_entry: h=
rtimer=3Dd4e8de78 function=3Dhrtimer_wakeup now=3D1319135162835780883
kworker/-297=A0=A0=A0=A0 0dN.h3.. 104489990us : sched_wakeup: comm=3Dcy=
clictest pid=3D3308 prio=3D0 success=3D1 target_cpu=3D000
kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489992us+: hrtimer_expire_exit: hr=
timer=3Dd4e8de78
kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489993us!: timer_interrupt_exit: p=
t_regs=3Deb917d60
kworker/-297=A0=A0=A0=A0 0.N..1.. 104490188us+: timer_start: timer=3Deb=
260d9c function=3Ddelayed_work_timer_fn expires=3D322089 [timeout=3D250=
]
kworker/-297=A0=A0=A0=A0 0dN..3.. 104490190us+: sched_stat_runtime: com=
m=3Dkworker/0:1 pid=3D297 runtime=3D136032 [ns] vruntime=3D22037952201 =
[ns]
kworker/-297=A0=A0=A0=A0 0d...3.. 104490192us+: sched_switch: prev_comm=
=3Dkworker/0:1 prev_pid=3D297 prev_prio=3D120 prev_state=3DR+ =3D=3D> n=
ext_comm=3Dcyclictest next_pid=3D3308 next_prio=3D0
cyclicte-3308=A0=A0=A0 0....1.. 104490194us+: sys_exit: NR 248 =3D 0
cyclicte-3308=A0=A0=A0 0....1.. 104490196us+: sys_enter: NR 246 (0, 487=
ff5e4, 0, 0, c8, f4240)
cyclicte-3308=A0=A0=A0 0....1.. 104490199us+: sys_exit: NR 246 =3D 0
cyclicte-3308=A0=A0=A0 0....1.. 104490228us+: mm_page_alloc: page=3Dc0e=
d2920 pfn=3D195657 order=3D0 migratetype=3D2 gfp_flags=3DGFP_HIGHUSER_M=
OVABLE
cyclicte-3308=A0=A0=A0 0....1.. 104490240us+: sys_enter: NR 4 (5, 48800=
3e4, 1f, 0, 0, 20)
cyclicte-3308=A0=A0=A0 0....... 104490244us+: tracing_mark_write: hit l=
atency threshold (213 > 0)
cyclicte-3308=A0=A0=A0 0....1.. 104490247us+: sys_exit: NR 4 =3D 31
cyclicte-3308=A0=A0=A0 0....1.. 104490249us : sys_enter: NR 4 (4, 10085=
5c4, 1, 0, 0, 20)

Regards
Priyanka=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
