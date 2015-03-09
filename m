From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: CONFIG_PREEMPT_RT local_softirq_pending warning when ISR blocks
Date: Mon, 9 Mar 2015 17:08:45 +0100
Message-ID: <20150309160845.GE13768@linutronix.de>
References: <CAGt3f4na1EMtViiLym3JnzGbOGSMXwy9puOccOyrOWKjd4QOnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Austin Schuh <austin@peloton-tech.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Brian Silverman <brian@peloton-tech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGt3f4na1EMtViiLym3JnzGbOGSMXwy9puOccOyrOWKjd4QOnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Brian Silverman | 2015-03-05 00:16:20 [-0500]:

>Beforehand, 000 is spending most of its time in interrupts, but bash
>is doing something related to memory management on it in between.
>            bash-14721 [000] ......1  6854.629126: rt_spin_lock <-free=
_pcppages_bulk
>            bash-14721 [000] ....1.1  6854.629126: mm_page_pcpu_drain:=
 page=3Dffffea000fa1aa40 pfn=3D4097705 order=3D0 migratetype=3D1
>            bash-14721 [000] ......1  6854.629127: get_pfnblock_flags_=
mask <-free_pcppages_bulk
>            bash-14721 [000] ......1  6854.629127: __mod_zone_page_sta=
te <-free_pcppages_bulk
>            bash-14721 [000] ....1.1  6854.629127: mm_page_pcpu_drain:=
 page=3Dffffea000f572ac0 pfn=3D4021419 order=3D0 migratetype=3D0
>            bash-14721 [000] ......1  6854.629128: get_pfnblock_flags_=
mask <-free_pcppages_bulk
>            bash-14721 [000] ......1  6854.629128: __mod_zone_page_sta=
te <-free_pcppages_bulk
>... # lots more virtually identical repetitions of those last 3 lines
>            bash-14721 [000] ....1.1  6854.629139: mm_page_pcpu_drain:=
 page=3Dffffea000f481a80 pfn=3D4005994 order=3D0 migratetype=3D1
>            bash-14721 [000] ......1  6854.629139: get_pfnblock_flags_=
mask <-free_pcppages_bulk
You free memory and hold the zone->lock

>            bash-14721 [000] d.....1  6854.629139: do_IRQ <-ret_from_i=
ntr
>            bash-14721 [000] d.....1  6854.629139: irq_enter <-do_IRQ
>... # wakes up the can1 ISR thread on 001 and the can0 one on 000
>(same physical IRQ line)
>            bash-14721 [000] d...3.1  6854.629261: sched_switch: prev_=
comm=3Dbash prev_pid=3D14721 prev_prio=3D120 prev_state=3DR+ =3D=3D> ne=
xt_comm=3Dirq/18-can0 next_pid=3D2015 next_prio=3D28

I would assume that this one raises NET_RX softirq. But at the bottom
you have the irq handler on the other CPU which confuses me=E2=80=A6

>... # runs the can0 ISR
>     irq/18-can0-2015  [000] d...3..  6854.629283: sched_switch: prev_=
comm=3Dirq/18-can0 prev_pid=3D2015 prev_prio=3D28 prev_state=3DS =3D=3D=
> next_comm=3Dksoftirqd/0 next_pid=3D3 next_prio=3D98
>...
>     ksoftirqd/0-3     [000] ....1.1  6854.629291: softirq_entry: vec=3D=
1 [action=3DTIMER]
>...
>     ksoftirqd/0-3     [000] ....1.1  6854.629293: softirq_exit: vec=3D=
1 [action=3DTIMER]
only the timer since nobody raised NET_RX

>...
>     ksoftirqd/0-3     [000] .......  6854.629298: schedule <-smpboot_=
thread_fn ...
>     ksoftirqd/0-3     [000] d...3..  6854.629304: sched_switch: prev_=
comm=3Dksoftirqd/0 prev_pid=3D3 prev_prio=3D98 prev_state=3DS =3D=3D> n=
ext_comm=3Dbash next_pid=3D14721 next_prio=3D28
>...
>            bash-14721 [000] d...1.1  6854.629308: smp_trace_reschedul=
e_interrupt <-trace_reschedule_interrupt
># Actually unnecessary schedule IPI from 001?
>            bash-14721 [000] d...1.1  6854.629309: irq_enter <-smp_tra=
ce_reschedule_interrupt
>...
>            bash-14721 [000] ....1.1  6854.629316: __tick_nohz_task_sw=
itch <-__schedule
>            bash-14721 [000] ......1  6854.629316: __mod_zone_page_sta=
te <-free_pcppages_bulk
>            bash-14721 [000] ....1.1  6854.629317: mm_page_pcpu_drain:=
 page=3Dffffea000f57a900 pfn=3D4021924 order=3D0 migratetype=3D0
>            bash-14721 [000] ......1  6854.629317: get_pfnblock_flags_=
mask <-free_pcppages_bulk
>            bash-14721 [000] ......1  6854.629317: __mod_zone_page_sta=
te <-free_pcppages_bulk
and it continues cleaning up memory.

>... # more of this like it was doing before
>I don't see it unlocking the problematic mutex before the trace ends.
>
>The relevant part for 001 starts while it's running the can1 ISR.
>     irq/18-can1-7228  [001] ....1.1  6854.629275: netif_rx: dev=3Dcan=
1 skbaddr=3Dffff880412d8fc00 len=3D16
>     irq/18-can1-7228  [001] ......1  6854.629275: migrate_disable <-n=
etif_rx_internal
>     irq/18-can1-7228  [001] ......2  6854.629275: enqueue_to_backlog =
<-netif_rx_internal

enqueue_to_backlog() looks like packet reception so this should be
handled in napi so I assume we run in NET_RX softirq

>     irq/18-can1-7228  [001] d.....2  6854.629276: _raw_spin_lock <-en=
queue_to_backlog
>     irq/18-can1-7228  [001] d...1.2  6854.629276: __raise_softirq_irq=
off <-enqueue_to_backlog
>     irq/18-can1-7228  [001] d...1.2  6854.629276: do_raise_softirq_ir=
qoff <-__raise_softirq_irqoff
>     irq/18-can1-7228  [001] d...2.2  6854.629276: softirq_raise: vec=3D=
3 [action=3DNET_RX]
>... # continues handling the can1 interrupt
>     irq/18-can1-7228  [001] ......6  6854.629286: rt_spin_lock <-get_=
page_from_freelist
>     irq/18-can1-7228  [001] ......6  6854.629287: rt_spin_lock_slowlo=
ck <-get_page_from_freelist
>     irq/18-can1-7228  [001] ......6  6854.629287: _raw_spin_lock <-rt=
_spin_lock_slowlock
>     irq/18-can1-7228  [001] ....1.6  6854.629287: __try_to_take_rt_mu=
tex <-rt_spin_lock_slowlock
>     irq/18-can1-7228  [001] ....1.6  6854.629287: _raw_spin_lock_irq =
<-rt_spin_lock_slowlock
>     irq/18-can1-7228  [001] d...2.6  6854.629288: _raw_spin_unlock_ir=
q <-rt_spin_lock_slowlock
>     irq/18-can1-7228  [001] ....1.6  6854.629288: task_blocks_on_rt_m=
utex <-rt_spin_lock_slowlock

it might be zone->lock it goes after. It boosts the bash process which
seems to free memory so it would make sense.

>... # rt_mutex/scheduling stuff
>     irq/18-can1-7228  [001] d...4.6  6854.629291: sched_pi_setprio: c=
omm=3Dbash pid=3D14721 oldprio=3D120 newprio=3D28
>... # more scheduler stuff
>     irq/18-can1-7228  [001] d...3.6  6854.629299: native_smp_send_res=
chedule <-rt_mutex_setprio
>... # more scheduler stuff
>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_fair=
 <-__schedule
>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_stop=
 <-__schedule
>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_dl <=
-__schedule
>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_rt <=
-__schedule
>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_fair=
 <-__schedule
>     irq/18-can1-7228  [001] d...2.6  6854.629308: pick_next_task_idle=
 <-__schedule
>     irq/18-can1-7228  [001] d...3.6  6854.629308: sched_switch: prev_=
comm=3Dirq/18-can1 prev_pid=3D7228 prev_prio=3D28 prev_state=3DD =3D=3D=
>
>next_comm=3Dswapper/1 next_pid=3D0 next_prio=3D120
>...
>          <idle>-0     [001] d...1..  6854.629319: softirq_check_pendi=
ng_idle <-tick_nohz_idle_enter
>My tracing_off() call is in softirq_check_pending_idle, so that's it.

It looks like your softirq for net_rx is getting a packet and then afte=
r
raising NET_RX (again?) it blocks on a lock. In order to get this lock
it boosts and schedules bash. It gets runable but on the other CPU. On
CPU1 there is nothig going is nothing going and the only runable task i=
s
the idle thread. And this is probably where the warning is written
because we go to idle while we should process a softirq instead.

>Thanks,
>Brian Silverman

Sebastian
