From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: RE: 3.8.10-rt6 : Observing high latency as
 preempt_schedule_irq:__schedule is not getting called
Date: Tue, 28 May 2013 04:01:57 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F190B3B849B@039-SN2MPN1-012.039d.mgd.msft.net>
References: <AC83832D6324604BB08FAE5A33553F190B386F60@039-SN2MPN1-013.039d.mgd.msft.net>
 <AC83832D6324604BB08FAE5A33553F190B388AD8@039-SN2MPN1-013.039d.mgd.msft.net>
 <AC83832D6324604BB08FAE5A33553F190B3B0367@039-SN2MPN1-012.039d.mgd.msft.net>
 <AC83832D6324604BB08FAE5A33553F190B3B04F2@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:56978
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761Ab3E1ECT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 May 2013 00:02:19 -0400
In-Reply-To: <AC83832D6324604BB08FAE5A33553F190B3B04F2@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


=46ound the issue in arch/powerpc/kernel/entry_32.S.

Submitted below patch to linuxppc-dev@lists.ozlabs.org to fix this issu=
e
--------------------------------------------------
[PATCH] powerpc/32bit:Store temporary result in r0 instead of r8

While returning from exception handling in case of PREEMPT enabled, _TI=
=46_NEED_RESCHED bit is checked in TI_FLAGS (thread_info flag) of curre=
nt task. Only if this bit is set, it should continue with the process o=
f calling preempt_schedule_irq() to schedule highest priority task if a=
vailable.
   =20
Current code assumes that r8 contains TI_FLAGS and check this for _TIF_=
NEED_RESCHED, but as r8 is modified in the code which executes before t=
his check, r8 no longer contains the expected TI_FLAGS information.
   =20
As a result check for comparison with _TIF_NEED_RESCHED was failing eve=
n if NEED_RESCHED bit is set in the current thread_info flag. Due to th=
is,
preempt_schedule_irq() and in turn scheduler was not getting called eve=
n if highest priority task is ready for execution.
   =20
So, store temporary results in r0 instead of r8 to prevent r8 from gett=
ing modified as subsequent code is dependent on its value.

Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
---
arch/powerpc/kernel/entry_32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry=
_32.S index d22e73e..22b45a4 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -849,7 +849,7 @@ resume_kernel:
 	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
 	CURRENT_THREAD_INFO(r9, r1)
 	lwz	r8,TI_FLAGS(r9)
-	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
+	andis.	r0,r8,_TIF_EMULATE_STACK_STORE@h
 	beq+	1f
=20
 	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
-----------------------------------------------------------------------=
------

> -----Original Message-----
> From: Jain Priyanka-B32167
> Sent: Tuesday, May 21, 2013 12:31 PM
> To: Jain Priyanka-B32167; linux-rt-users@vger.kernel.org; Steven Rost=
edt;
> tglx@linutronix.de; Sebastian Andrzej Siewior
> Cc: Dev Manish-R65866; Aggrwal Poonam-B10812; Srivastava Rajan-B34330
> Subject: 3.8.10-rt6 : Observing high latency as
> preempt_schedule_irq:__schedule is not getting called
>=20
>=20
> Setup: Single core PowerPC, 32-bit platform , Linux3.8.10-rt6
>=20
> 'preempt_schedule_irq()'  is a function which generally gets called w=
hile
> exiting from IRQ context to call __schedule so that preemption
> opportunities do not get missed.
> I have added print just above call to __schedule()
>=20
> (START)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c index
> 3891f97..1f423c5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3350,6 +3350,7 @@ asmlinkage void __sched preempt_schedule_irq(vo=
id)
>         do {
>                 add_preempt_count(PREEMPT_ACTIVE);
>                 local_irq_enable();
> +               printk("%s\n",__FUNCTION__);
>                 __schedule();
>                 local_irq_disable();
>                 sub_preempt_count(PREEMPT_ACTIVE);
> (END)
>=20
> As none of instance of this print is coming in kernel dump, it seems =
that
> 'preempt_schedule_irq:__schedule' is not getting called.
> So preemption opportunities while exiting from IRQ context(exception
> handling) are getting missed leading to increase in latencies.
>=20
> There are several changes in Kernel around this code specially the
> LAZY_PREEMPT feature, so I am not able to root-cause the exact issue.
> Please help me in fixing this.
>=20
> Regards
> Priyanka
>=20
>=20
> > -----Original Message-----
> > From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-
> > owner@vger.kernel.org] On Behalf Of Jain Priyanka-B32167
> > Sent: Tuesday, May 21, 2013 11:13 AM
> > To: linux-rt-users@vger.kernel.org; Steven Rostedt
> > Subject: RE: 3.8.10-rt6 : Observing high latency as timer_interrupt=
 is
> > taking longer to exit
> >
> > Furthur debug analysis
> >
> > I am running cylictest with following settings:
> > ./cyclictest -a -n -p 99 -c 1 -d 0 -O latency-format -b 600 --
> > tracer=3Dfunction_graph
> >
> >
> > It seems that even if 'N' (need rescheduled bit) is set in current
> > task and preemption disabled count is zero, context switching to
> > highest priority task which is cyclictest thread in this case is no=
t
> > happening immediately. It is getting delayed adding to latency. Tra=
ce
> > capture attached.
> >
> > Please help me in identifying what can be the issue.
> >
> > Regards
> > Priyanka
> >
> > > -----Original Message-----
> > > From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users=
-
> > > owner@vger.kernel.org] On Behalf Of Jain Priyanka-B32167
> > > Sent: Wednesday, May 15, 2013 3:49 PM
> > > To: linux-rt-users@vger.kernel.org
> > > Subject: RE: 3.8.10-rt6 : Observing high latency as timer_interru=
pt
> > > is taking longer to exit
> > >
> > > Hi,
> > >
> > > I have further debug the issue.
> > >
> > > The increase in latency issue is observed when kworker is in
> > > execution and timer_interrupt(hardirq) arrives.
> > > Upon completion of timer_interrupt, previous context should have
> > > immediately got restored.
> > > But a large time-gap (varying from 50us to 200us) is observed in
> > > restoration of kworker task.
> > > e.g in below context, 195us gap is observed in timer_interrupt_ex=
it
> > > and timer_start (kworker).
> > >
> > > In complete trace, I have seen multiple entries of timer_interrup=
t.
> > > But exit is taking large time gap only when it arrives in context=
 of
> > > kworker.
> > >
> > > Looking for some pointers as help to debug the issue.
> > >
> > > Regards
> > > Priyanka
> > >
> > > > -----Original Message-----
> > > > From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-use=
rs-
> > > > owner@vger.kernel.org] On Behalf Of Jain Priyanka-B32167
> > > > Sent: Tuesday, May 14, 2013 4:10 PM
> > > > To: linux-rt-users@vger.kernel.org
> > > > Subject: 3.8.10-rt6 : Observing high latency as timer_interrupt=
 is
> > > > taking longer to exit
> > > >
> > > > Hi,
> > > >
> > > > I am running PREEMPT_RT =A0kernel on single-core PowerPC based
> > > > platform and using cyclictest tool to measure latency.
> > > >
> > > > Earlier I have used 2.6.33.9-rt31, With that kernel, latency ha=
s
> > > > always remained below 50us irrespective of the traffic.
> > > > With 3.8.10-rt6, latency is shooting beyond 200us irrespective =
of
> > > > the traffic - no load, heavy traffic conditions included. Issue=
 is
> > > > generally reproduced within 10 minutes of run
> > > >
> > > > When I tried to debug the issue using ftrace, I am observing th=
at
> > > > it is taking 200us for transition from
> > > > timer_interrupt_exit(interrupts
> > > > disabled) to timer_start =A0in Kworker/-297 thread.
> > > > I have tried multiple times and always observed similar trace.
> > > > Please help me in debugging the issue.
> > > >
> > > > Trace Logs:
> > > >
> > > > cyclicte-3307=A0=A0=A0 0d...2.. 104489596us+: hrtimer_start:
> > > > hrtimer=3Ddfee9e98 function=3Dhrtimer_wakeup expires=3D15873659=
15748
> > > > softexpires=3D1587365865748
> > > > cyclicte-3307=A0=A0=A0 0d...3.. 104489599us+: sched_stat_runtim=
e:
> > > > comm=3Dcyclictest pid=3D3307 runtime=3D119552 [ns] vruntime=3D2=
2040816169
> > > > [ns]
> > > > cyclicte-3307=A0=A0=A0 0d...3.. 104489602us!: sched_switch:
> > > > prev_comm=3Dcyclictest prev_pid=3D3307 prev_prio=3D120 prev_sta=
te=3DS =3D=3D>
> > > > next_comm=3Dswapper next_pid=3D0 next_prio=3D120
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489732us+: timer_int=
errupt_entry:
> > > > pt_regs=3Dc086fed0
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h3.. 104489733us : hrtimer_c=
ancel:
> > > > hrtimer=3Dc0830240
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489735us+: hrtimer_e=
xpire_entry:
> > > > hrtimer=3Dc0830240 function=3Dtick_sched_timer now=3D1587356002=
980
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489741us : softirq_r=
aise: vec=3D1
> > > > [action=3DTIMER]
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489743us+: softirq_r=
aise: vec=3D9
> > > > [action=3DRCU]
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489744us+: hrtimer_e=
xpire_exit:
> > > > hrtimer=3Dc0830240
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h3.. 104489746us+: hrtimer_s=
tart:
> > > > hrtimer=3Dc0830240 function=3Dtick_sched_timer expires=3D158736=
0000000
> > > > softexpires=3D1587360000000
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d..h2.. 104489749us+: timer_int=
errupt_exit:
> > > > pt_regs=3Dc086fed0
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d...5.. 104489751us+: sched_wak=
eup:
> > > > comm=3Dksoftirqd/0
> > > > pid=3D3 prio=3D98 success=3D1 target_cpu=3D000
> > > > =A0 <idle>-0=A0=A0=A0=A0=A0=A0 0d...3.. 104489755us+: sched_swi=
tch:
> > > > prev_comm=3Dswapper prev_pid=3D0 prev_prio=3D120 prev_state=3DR=
 =3D=3D>
> > > > next_comm=3Dksoftirqd/0
> > > > next_pid=3D3 next_prio=3D98
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489758us+: softirq_ent=
ry: vec=3D1
> > > > [action=3DTIMER]
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489761us+: timer_cance=
l:
> > > > timer=3Deb260d9c
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489762us+: timer_expir=
e_entry:
> > > > timer=3Deb260d9c function=3Ddelayed_work_timer_fn now=3D321839
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489765us+: workqueue_q=
ueue_work: work
> > > > struct=3Deb260d8c function=3Dphy_state_machine workqueue=3Deb80=
3bc0
> > > > req_cpu=3D1 cpu=3D0
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489767us+: workqueue_a=
ctivate_work:
> > > > work struct eb260d8c
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0d...3.. 104489770us+: sched_wakeu=
p:
> > > > comm=3Dkworker/0:1
> > > > pid=3D297 prio=3D120 success=3D1 target_cpu=3D000
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489772us : timer_expir=
e_exit:
> > > > timer=3Deb260d9c
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489773us : timer_cance=
l:
> > > > timer=3Deb260b9c
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489774us : timer_expir=
e_entry:
> > > > timer=3Deb260b9c function=3Ddelayed_work_timer_fn now=3D321839
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489775us : workqueue_q=
ueue_work: work
> > > > struct=3Deb260b8c function=3Dphy_state_machine workqueue=3Deb80=
3bc0
> > > > req_cpu=3D1 cpu=3D0
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489775us : workqueue_a=
ctivate_work:
> > > > work struct eb260b8c
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489777us : timer_expir=
e_exit:
> > > > timer=3Deb260b9c
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489778us : softirq_exi=
t: vec=3D1
> > > > [action=3DTIMER]
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489779us+: softirq_ent=
ry: vec=3D9
> > > > [action=3DRCU]
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489781us : kmem_cache_=
free:
> > > > call_site=3Dc00fd3e4 ptr=3Dd4f9f780
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489782us : kmem_cache_=
free:
> > > > call_site=3Dc0154bc0 ptr=3Deb7f8998
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489783us : kmem_cache_=
free:
> > > > call_site=3Dc01123ec ptr=3De9937b80
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0....1.. 104489784us+: softirq_exi=
t: vec=3D9
> > > > [action=3DRCU]
> > > > ksoftirq-3=A0=A0=A0=A0=A0=A0 0d...3.. 104489788us+: sched_switc=
h:
> > > > prev_comm=3Dksoftirqd/0 prev_pid=3D3 prev_prio=3D98 prev_state=3D=
S =3D=3D>
> > > > next_comm=3Dkworker/0:1 next_pid=3D297 next_prio=3D120
> > > > kworker/-297=A0=A0=A0=A0 0....1.. 104489793us!: workqueue_execu=
te_start:
> > > > work struct eb260d8c: function phy_state_machine
> > > > kworker/-297=A0=A0=A0=A0 0d..h1.. 104489916us+: irq_entry:
> > > > pt_regs=3Deb917d50
> > > > kworker/-297=A0=A0=A0=A0 0d..h1.. 104489920us : irq_handler_ent=
ry: irq=3D18
> > > > name=3Dserial
> > > > kworker/-297=A0=A0=A0=A0 0d..h1.. 104489921us+: irq_handler_exi=
t: irq=3D18
> > > > ret=3Dhandled
> > > > kworker/-297=A0=A0=A0=A0 0d..h3.. 104489923us+: sched_wakeup:
> > > > comm=3Dirq/18-serial
> > > > pid=3D3267 prio=3D49 success=3D1 target_cpu=3D000
> > > > kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489925us+: irq_exit: pt_re=
gs=3Deb917d50
> > > > kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489985us+: timer_interrupt=
_entry:
> > > > pt_regs=3Deb917d60
> > > > kworker/-297=A0=A0=A0=A0 0dN.h2.. 104489987us+: hrtimer_cancel:
> > > > hrtimer=3Dd4e8de78
> > > > kworker/-297 =A0=A0=A0=A00dN.h1.. 104489989us+: hrtimer_expire_=
entry:
> > > > hrtimer=3Dd4e8de78 function=3Dhrtimer_wakeup now=3D131913516283=
5780883
> > > > kworker/-297=A0=A0=A0=A0 0dN.h3.. 104489990us : sched_wakeup:
> > > > comm=3Dcyclictest
> > > > pid=3D3308 prio=3D0 success=3D1 target_cpu=3D000
> > > > kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489992us+: hrtimer_expire_=
exit:
> > > > hrtimer=3Dd4e8de78
> > > > kworker/-297=A0=A0=A0=A0 0dN.h1.. 104489993us!: timer_interrupt=
_exit:
> > > > pt_regs=3Deb917d60
> > > > kworker/-297=A0=A0=A0=A0 0.N..1.. 104490188us+: timer_start:
> > > > timer=3Deb260d9c function=3Ddelayed_work_timer_fn expires=3D322=
089
> > > > [timeout=3D250]
> > > > kworker/-297=A0=A0=A0=A0 0dN..3.. 104490190us+: sched_stat_runt=
ime:
> > > > comm=3Dkworker/0:1 pid=3D297 runtime=3D136032 [ns] vruntime=3D2=
2037952201
> > > > [ns]
> > > > kworker/-297=A0=A0=A0=A0 0d...3.. 104490192us+: sched_switch:
> > > > prev_comm=3Dkworker/0:1 prev_pid=3D297 prev_prio=3D120 prev_sta=
te=3DR+ =3D=3D>
> > > > next_comm=3Dcyclictest next_pid=3D3308 next_prio=3D0
> > > > cyclicte-3308=A0=A0=A0 0....1.. 104490194us+: sys_exit: NR 248 =
=3D 0
> > > > cyclicte-3308=A0=A0=A0 0....1.. 104490196us+: sys_enter: NR 246=
 (0,
> > > > 487ff5e4, 0, 0, c8, f4240)
> > > > cyclicte-3308=A0=A0=A0 0....1.. 104490199us+: sys_exit: NR 246 =
=3D 0
> > > > cyclicte-3308=A0=A0=A0 0....1.. 104490228us+: mm_page_alloc:
> > > > page=3Dc0ed2920
> > > > pfn=3D195657 order=3D0 migratetype=3D2 gfp_flags=3DGFP_HIGHUSER=
_MOVABLE
> > > > cyclicte-3308=A0=A0=A0 0....1.. 104490240us+: sys_enter: NR 4 (=
5,
> > > > 488003e4, 1f, 0, 0, 20)
> > > > cyclicte-3308=A0=A0=A0 0....... 104490244us+: tracing_mark_writ=
e: hit
> > > > latency threshold (213 > 0)
> > > > cyclicte-3308=A0=A0=A0 0....1.. 104490247us+: sys_exit: NR 4 =3D=
 31
> > > > cyclicte-3308=A0=A0=A0 0....1.. 104490249us : sys_enter: NR 4 (=
4,
> > > > 100855c4, 1, 0, 0, 20)
> > > >
> > > > Regards
> > > > Priyanka
> > > >
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > linux-rt-
> > > users"
> > > > in the body of a message to majordomo@vger.kernel.org More
> > > > majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-r=
t-
> > users"
> > > in the body of a message to majordomo@vger.kernel.org More majord=
omo
> > > info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
