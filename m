From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: 3.8.10-rt6 : Observing high latency as
 preempt_schedule_irq:__schedule is not getting called
Date: Tue, 21 May 2013 07:01:24 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F190B3B04F2@039-SN2MPN1-012.039d.mgd.msft.net>
References: <AC83832D6324604BB08FAE5A33553F190B386F60@039-SN2MPN1-013.039d.mgd.msft.net>
 <AC83832D6324604BB08FAE5A33553F190B388AD8@039-SN2MPN1-013.039d.mgd.msft.net>
 <AC83832D6324604BB08FAE5A33553F190B3B0367@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dev Manish-R65866 <R65866@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Srivastava Rajan-B34330 <B34330@freescale.com>
To: Jain Priyanka-B32167 <B32167@freescale.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:3250
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754457Ab3EUHAu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 May 2013 03:00:50 -0400
In-Reply-To: <AC83832D6324604BB08FAE5A33553F190B3B0367@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Setup: Single core PowerPC, 32-bit platform , Linux3.8.10-rt6

'preempt_schedule_irq()'  is a function which generally gets called whi=
le exiting from IRQ context to call __schedule so that preemption oppor=
tunities do not get missed.
I have added print just above call to __schedule()

(START)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3891f97..1f423c5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3350,6 +3350,7 @@ asmlinkage void __sched preempt_schedule_irq(void=
)
        do {
                add_preempt_count(PREEMPT_ACTIVE);
                local_irq_enable();
+               printk("%s\n",__FUNCTION__);
                __schedule();
                local_irq_disable();
                sub_preempt_count(PREEMPT_ACTIVE);
(END)

As none of instance of this print is coming in kernel dump, it seems th=
at 'preempt_schedule_irq:__schedule' is not getting called.
So preemption opportunities while exiting from IRQ context(exception ha=
ndling) are getting missed leading to increase in latencies.

There are several changes in Kernel around this code specially the LAZY=
_PREEMPT feature, so I am not able to root-cause the exact issue. Pleas=
e help me in fixing this.

Regards
Priyanka


> -----Original Message-----
> From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> owner@vger.kernel.org] On Behalf Of Jain Priyanka-B32167
> Sent: Tuesday, May 21, 2013 11:13 AM
> To: linux-rt-users@vger.kernel.org; Steven Rostedt
> Subject: RE: 3.8.10-rt6 : Observing high latency as timer_interrupt i=
s
> taking longer to exit
>=20
> Furthur debug analysis
>=20
> I am running cylictest with following settings:
> ./cyclictest -a -n -p 99 -c 1 -d 0 -O latency-format -b 600 --
> tracer=3Dfunction_graph
>=20
>=20
> It seems that even if 'N' (need rescheduled bit) is set in current ta=
sk
> and preemption disabled count is zero, context switching to highest
> priority task which is cyclictest thread in this case is not happenin=
g
> immediately. It is getting delayed adding to latency. Trace capture
> attached.
>=20
> Please help me in identifying what can be the issue.
>=20
> Regards
> Priyanka
>=20
> > -----Original Message-----
> > From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> > owner@vger.kernel.org] On Behalf Of Jain Priyanka-B32167
> > Sent: Wednesday, May 15, 2013 3:49 PM
> > To: linux-rt-users@vger.kernel.org
> > Subject: RE: 3.8.10-rt6 : Observing high latency as timer_interrupt=
 is
> > taking longer to exit
> >
> > Hi,
> >
> > I have further debug the issue.
> >
> > The increase in latency issue is observed when kworker is in execut=
ion
> > and timer_interrupt(hardirq) arrives.
> > Upon completion of timer_interrupt, previous context should have
> > immediately got restored.
> > But a large time-gap (varying from 50us to 200us) is observed in
> > restoration of kworker task.
> > e.g in below context, 195us gap is observed in timer_interrupt_exit
> > and timer_start (kworker).
> >
> > In complete trace, I have seen multiple entries of timer_interrupt.
> > But exit is taking large time gap only when it arrives in context o=
f
> > kworker.
> >
> > Looking for some pointers as help to debug the issue.
> >
> > Regards
> > Priyanka
> >
> > > -----Original Message-----
> > > From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users=
-
> > > owner@vger.kernel.org] On Behalf Of Jain Priyanka-B32167
> > > Sent: Tuesday, May 14, 2013 4:10 PM
> > > To: linux-rt-users@vger.kernel.org
> > > Subject: 3.8.10-rt6 : Observing high latency as timer_interrupt i=
s
> > > taking longer to exit
> > >
> > > Hi,
> > >
> > > I am running PREEMPT_RT =A0kernel on single-core PowerPC based
> > > platform and using cyclictest tool to measure latency.
> > >
> > > Earlier I have used 2.6.33.9-rt31, With that kernel, latency has
> > > always remained below 50us irrespective of the traffic.
> > > With 3.8.10-rt6, latency is shooting beyond 200us irrespective of
> > > the traffic - no load, heavy traffic conditions included. Issue i=
s
> > > generally reproduced within 10 minutes of run
> > >
> > > When I tried to debug the issue using ftrace, I am observing that=
 it
> > > is taking 200us for transition from timer_interrupt_exit(interrup=
ts
> > > disabled) to timer_start =A0in Kworker/-297 thread.
> > > I have tried multiple times and always observed similar trace.
> > > Please help me in debugging the issue.
> > >
> > > Trace Logs:
> > >
> > > cyclicte-3307=A0=A0=A0 0d...2.. 104489596us+: hrtimer_start:
> > > hrtimer=3Ddfee9e98 function=3Dhrtimer_wakeup expires=3D1587365915=
748
> > > softexpires=3D1587365865748
> > > cyclicte-3307=A0=A0=A0 0d...3.. 104489599us+: sched_stat_runtime:
> > > comm=3Dcyclictest pid=3D3307 runtime=3D119552 [ns] vruntime=3D220=
40816169
> > > [ns]
> > > cyclicte-3307=A0=A0=A0 0d...3.. 104489602us!: sched_switch:
> > > prev_comm=3Dcyclictest prev_pid=3D3307 prev_prio=3D120 prev_state=
=3DS =3D=3D>
> > > next_comm=3Dswapper next_pid=3D0 next_prio=3D120
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489732us+: timer_inter=
rupt_entry:
> > > pt_regs=3Dc086fed0
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h3.. 104489733us : hrtimer_can=
cel:
> > > hrtimer=3Dc0830240
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489735us+: hrtimer_exp=
ire_entry:
> > > hrtimer=3Dc0830240 function=3Dtick_sched_timer now=3D158735600298=
0
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489741us : softirq_rai=
se: vec=3D1
> > > [action=3DTIMER]
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489743us+: softirq_rai=
se: vec=3D9
> > > [action=3DRCU]
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489744us+: hrtimer_exp=
ire_exit:
> > > hrtimer=3Dc0830240
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h3.. 104489746us+: hrtimer_sta=
rt:
> > > hrtimer=3Dc0830240 function=3Dtick_sched_timer expires=3D15873600=
00000
> > > softexpires=3D1587360000000
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489749us+: timer_inter=
rupt_exit:
> > > pt_regs=3Dc086fed0
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d...5.. 104489751us+: sched_wakeu=
p:
> > > comm=3Dksoftirqd/0
> > > pid=3D3 prio=3D98 success=3D1 target_cpu=3D000
> > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d...3.. 104489755us+: sched_switc=
h:
> > > prev_comm=3Dswapper prev_pid=3D0 prev_prio=3D120 prev_state=3DR =3D=
=3D>
> > > next_comm=3Dksoftirqd/0
> > > next_pid=3D3 next_prio=3D98
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489758us+: softirq_entry=
: vec=3D1
> > > [action=3DTIMER]
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489761us+: timer_cancel:=
 timer=3Deb260d9c
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489762us+: timer_expire_=
entry:
> > > timer=3Deb260d9c function=3Ddelayed_work_timer_fn now=3D321839
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489765us+: workqueue_que=
ue_work: work
> > > struct=3Deb260d8c function=3Dphy_state_machine workqueue=3Deb803b=
c0
> > > req_cpu=3D1 cpu=3D0
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489767us+: workqueue_act=
ivate_work:
> > > work struct eb260d8c
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0d...3.. 104489770us+: sched_wakeup:
> > > comm=3Dkworker/0:1
> > > pid=3D297 prio=3D120 success=3D1 target_cpu=3D000
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489772us : timer_expire_=
exit:
> > > timer=3Deb260d9c
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489773us : timer_cancel:=
 timer=3Deb260b9c
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489774us : timer_expire_=
entry:
> > > timer=3Deb260b9c function=3Ddelayed_work_timer_fn now=3D321839
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489775us : workqueue_que=
ue_work: work
> > > struct=3Deb260b8c function=3Dphy_state_machine workqueue=3Deb803b=
c0
> > > req_cpu=3D1 cpu=3D0
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489775us : workqueue_act=
ivate_work:
> > > work struct eb260b8c
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489777us : timer_expire_=
exit:
> > > timer=3Deb260b9c
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489778us : softirq_exit:=
 vec=3D1
> > > [action=3DTIMER]
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489779us+: softirq_entry=
: vec=3D9
> > > [action=3DRCU]
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489781us : kmem_cache_fr=
ee:
> > > call_site=3Dc00fd3e4 ptr=3Dd4f9f780
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489782us : kmem_cache_fr=
ee:
> > > call_site=3Dc0154bc0 ptr=3Deb7f8998
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489783us : kmem_cache_fr=
ee:
> > > call_site=3Dc01123ec ptr=3De9937b80
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489784us+: softirq_exit:=
 vec=3D9
> > > [action=3DRCU]
> > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0d...3.. 104489788us+: sched_switch:
> > > prev_comm=3Dksoftirqd/0 prev_pid=3D3 prev_prio=3D98 prev_state=3D=
S =3D=3D>
> > > next_comm=3Dkworker/0:1 next_pid=3D297 next_prio=3D120
> > > kworker/-297=A0=A0=A0=A0 0....1.. 104489793us!: workqueue_execute=
_start:
> > > work struct eb260d8c: function phy_state_machine
> > > kworker/-297=A0=A0=A0=A0 0d..h1.. 104489916us+: irq_entry: pt_reg=
s=3Deb917d50
> > > kworker/-297=A0=A0=A0=A0 0d..h1.. 104489920us : irq_handler_entry=
: irq=3D18
> > > name=3Dserial
> > > kworker/-297=A0=A0=A0=A0 0d..h1.. 104489921us+: irq_handler_exit:=
 irq=3D18
> > > ret=3Dhandled
> > > kworker/-297=A0=A0=A0=A0 0d..h3.. 104489923us+: sched_wakeup:
> > > comm=3Dirq/18-serial
> > > pid=3D3267 prio=3D49 success=3D1 target_cpu=3D000
> > > kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489925us+: irq_exit: pt_regs=
=3Deb917d50
> > > kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489985us+: timer_interrupt_e=
ntry:
> > > pt_regs=3Deb917d60
> > > kworker/-297=A0=A0=A0=A0 0dN.h2.. 104489987us+: hrtimer_cancel:
> > > hrtimer=3Dd4e8de78
> > > kworker/-297 =A0=A0=A0=A00dN.h1.. 104489989us+: hrtimer_expire_en=
try:
> > > hrtimer=3Dd4e8de78 function=3Dhrtimer_wakeup now=3D13191351628357=
80883
> > > kworker/-297=A0=A0=A0=A0 0dN.h3.. 104489990us : sched_wakeup:
> > > comm=3Dcyclictest
> > > pid=3D3308 prio=3D0 success=3D1 target_cpu=3D000
> > > kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489992us+: hrtimer_expire_ex=
it:
> > > hrtimer=3Dd4e8de78
> > > kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489993us!: timer_interrupt_e=
xit:
> > > pt_regs=3Deb917d60
> > > kworker/-297=A0=A0=A0=A0 0.N..1.. 104490188us+: timer_start: time=
r=3Deb260d9c
> > > function=3Ddelayed_work_timer_fn expires=3D322089 [timeout=3D250]
> > > kworker/-297=A0=A0=A0=A0 0dN..3.. 104490190us+: sched_stat_runtim=
e:
> > > comm=3Dkworker/0:1 pid=3D297 runtime=3D136032 [ns] vruntime=3D220=
37952201
> > > [ns]
> > > kworker/-297=A0=A0=A0=A0 0d...3.. 104490192us+: sched_switch:
> > > prev_comm=3Dkworker/0:1 prev_pid=3D297 prev_prio=3D120 prev_state=
=3DR+ =3D=3D>
> > > next_comm=3Dcyclictest next_pid=3D3308 next_prio=3D0
> > > cyclicte-3308=A0=A0=A0 0....1.. 104490194us+: sys_exit: NR 248 =3D=
 0
> > > cyclicte-3308=A0=A0=A0 0....1.. 104490196us+: sys_enter: NR 246 (=
0,
> > > 487ff5e4, 0, 0, c8, f4240)
> > > cyclicte-3308=A0=A0=A0 0....1.. 104490199us+: sys_exit: NR 246 =3D=
 0
> > > cyclicte-3308=A0=A0=A0 0....1.. 104490228us+: mm_page_alloc: page=
=3Dc0ed2920
> > > pfn=3D195657 order=3D0 migratetype=3D2 gfp_flags=3DGFP_HIGHUSER_M=
OVABLE
> > > cyclicte-3308=A0=A0=A0 0....1.. 104490240us+: sys_enter: NR 4 (5,
> > > 488003e4, 1f, 0, 0, 20)
> > > cyclicte-3308=A0=A0=A0 0....... 104490244us+: tracing_mark_write:=
 hit
> > > latency threshold (213 > 0)
> > > cyclicte-3308=A0=A0=A0 0....1.. 104490247us+: sys_exit: NR 4 =3D =
31
> > > cyclicte-3308=A0=A0=A0 0....1.. 104490249us : sys_enter: NR 4 (4,
> > > 100855c4, 1, 0, 0, 20)
> > >
> > > Regards
> > > Priyanka
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-r=
t-
> > users"
> > > in the body of a message to majordomo@vger.kernel.org More majord=
omo
> > > info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-
> users"
> > in the body of a message to majordomo@vger.kernel.org More majordom=
o
> > info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
