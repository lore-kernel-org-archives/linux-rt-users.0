From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: CONFIG_PREEMPT_RT local_softirq_pending warning when ISR blocks
Date: Mon, 9 Mar 2015 20:36:27 -0400
Message-ID: <CAGt3f4k0d5LRwuec1gpm=+NW325OskPxZbuTroEBSO9d1MMZaQ@mail.gmail.com>
References: <CAGt3f4na1EMtViiLym3JnzGbOGSMXwy9puOccOyrOWKjd4QOnQ@mail.gmail.com>
 <20150309160845.GE13768@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Austin Schuh <austin@peloton-tech.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150309160845.GE13768@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Mar 9, 2015 at 12:08 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> * Brian Silverman | 2015-03-05 00:16:20 [-0500]:
>
>>Beforehand, 000 is spending most of its time in interrupts, but bash
>>is doing something related to memory management on it in between.
>>            bash-14721 [000] ......1  6854.629126: rt_spin_lock <-fre=
e_pcppages_bulk
>>            bash-14721 [000] ....1.1  6854.629126: mm_page_pcpu_drain=
: page=3Dffffea000fa1aa40 pfn=3D4097705 order=3D0 migratetype=3D1
>>            bash-14721 [000] ......1  6854.629127: get_pfnblock_flags=
_mask <-free_pcppages_bulk
>>            bash-14721 [000] ......1  6854.629127: __mod_zone_page_st=
ate <-free_pcppages_bulk
>>            bash-14721 [000] ....1.1  6854.629127: mm_page_pcpu_drain=
: page=3Dffffea000f572ac0 pfn=3D4021419 order=3D0 migratetype=3D0
>>            bash-14721 [000] ......1  6854.629128: get_pfnblock_flags=
_mask <-free_pcppages_bulk
>>            bash-14721 [000] ......1  6854.629128: __mod_zone_page_st=
ate <-free_pcppages_bulk
>>... # lots more virtually identical repetitions of those last 3 lines
>>            bash-14721 [000] ....1.1  6854.629139: mm_page_pcpu_drain=
: page=3Dffffea000f481a80 pfn=3D4005994 order=3D0 migratetype=3D1
>>            bash-14721 [000] ......1  6854.629139: get_pfnblock_flags=
_mask <-free_pcppages_bulk
> You free memory and hold the zone->lock
>
>>            bash-14721 [000] d.....1  6854.629139: do_IRQ <-ret_from_=
intr
>>            bash-14721 [000] d.....1  6854.629139: irq_enter <-do_IRQ
>>... # wakes up the can1 ISR thread on 001 and the can0 one on 000
>>(same physical IRQ line)
>>            bash-14721 [000] d...3.1  6854.629261: sched_switch: prev=
_comm=3Dbash prev_pid=3D14721 prev_prio=3D120 prev_state=3DR+ =3D=3D> n=
ext_comm=3Dirq/18-can0 next_pid=3D2015 next_prio=3D28
>
> I would assume that this one raises NET_RX softirq. But at the bottom
> you have the irq handler on the other CPU which confuses me=E2=80=A6

There wasn't actually any traffic on can0 for this test, so it didn't.
The can0 ISR only makes a few reads/writes to the device, never
calling netif_rx.

The can1 handler (which actually raises a NET_RX softirq) runs on 001
because it's pinned there.

>
>>... # runs the can0 ISR
>>     irq/18-can0-2015  [000] d...3..  6854.629283: sched_switch: prev=
_comm=3Dirq/18-can0 prev_pid=3D2015 prev_prio=3D28 prev_state=3DS =3D=3D=
> next_comm=3Dksoftirqd/0 next_pid=3D3 next_prio=3D98
>>...
>>     ksoftirqd/0-3     [000] ....1.1  6854.629291: softirq_entry: vec=
=3D1 [action=3DTIMER]
>>...
>>     ksoftirqd/0-3     [000] ....1.1  6854.629293: softirq_exit: vec=3D=
1 [action=3DTIMER]
> only the timer since nobody raised NET_RX

Correct. I included that as context for what 000 spent its time doing
with the lock held, not implying that it's incorrect.

>
>>...
>>     ksoftirqd/0-3     [000] .......  6854.629298: schedule <-smpboot=
_thread_fn ...
>>     ksoftirqd/0-3     [000] d...3..  6854.629304: sched_switch: prev=
_comm=3Dksoftirqd/0 prev_pid=3D3 prev_prio=3D98 prev_state=3DS =3D=3D> =
next_comm=3Dbash next_pid=3D14721 next_prio=3D28
>>...
>>            bash-14721 [000] d...1.1  6854.629308: smp_trace_reschedu=
le_interrupt <-trace_reschedule_interrupt
>># Actually unnecessary schedule IPI from 001?
>>            bash-14721 [000] d...1.1  6854.629309: irq_enter <-smp_tr=
ace_reschedule_interrupt
>>...
>>            bash-14721 [000] ....1.1  6854.629316: __tick_nohz_task_s=
witch <-__schedule
>>            bash-14721 [000] ......1  6854.629316: __mod_zone_page_st=
ate <-free_pcppages_bulk
>>            bash-14721 [000] ....1.1  6854.629317: mm_page_pcpu_drain=
: page=3Dffffea000f57a900 pfn=3D4021924 order=3D0 migratetype=3D0
>>            bash-14721 [000] ......1  6854.629317: get_pfnblock_flags=
_mask <-free_pcppages_bulk
>>            bash-14721 [000] ......1  6854.629317: __mod_zone_page_st=
ate <-free_pcppages_bulk
> and it continues cleaning up memory.
>
>>... # more of this like it was doing before
>>I don't see it unlocking the problematic mutex before the trace ends.
>>
>>The relevant part for 001 starts while it's running the can1 ISR.
>>     irq/18-can1-7228  [001] ....1.1  6854.629275: netif_rx: dev=3Dca=
n1 skbaddr=3Dffff880412d8fc00 len=3D16
>>     irq/18-can1-7228  [001] ......1  6854.629275: migrate_disable <-=
netif_rx_internal
>>     irq/18-can1-7228  [001] ......2  6854.629275: enqueue_to_backlog=
 <-netif_rx_internal
>
> enqueue_to_backlog() looks like packet reception so this should be
> handled in napi so I assume we run in NET_RX softirq

enqueue_to_backlog is the napi function that actually raises the NET_RX=
 softirq.

>>     irq/18-can1-7228  [001] d.....2  6854.629276: _raw_spin_lock <-e=
nqueue_to_backlog
>>     irq/18-can1-7228  [001] d...1.2  6854.629276: __raise_softirq_ir=
qoff <-enqueue_to_backlog
>>     irq/18-can1-7228  [001] d...1.2  6854.629276: do_raise_softirq_i=
rqoff <-__raise_softirq_irqoff
>>     irq/18-can1-7228  [001] d...2.2  6854.629276: softirq_raise: vec=
=3D3 [action=3DNET_RX]
This is where the softirq gets raised.

>>... # continues handling the can1 interrupt
>>     irq/18-can1-7228  [001] ......6  6854.629286: rt_spin_lock <-get=
_page_from_freelist
>>     irq/18-can1-7228  [001] ......6  6854.629287: rt_spin_lock_slowl=
ock <-get_page_from_freelist
>>     irq/18-can1-7228  [001] ......6  6854.629287: _raw_spin_lock <-r=
t_spin_lock_slowlock
>>     irq/18-can1-7228  [001] ....1.6  6854.629287: __try_to_take_rt_m=
utex <-rt_spin_lock_slowlock
>>     irq/18-can1-7228  [001] ....1.6  6854.629287: _raw_spin_lock_irq=
 <-rt_spin_lock_slowlock
>>     irq/18-can1-7228  [001] d...2.6  6854.629288: _raw_spin_unlock_i=
rq <-rt_spin_lock_slowlock
>>     irq/18-can1-7228  [001] ....1.6  6854.629288: task_blocks_on_rt_=
mutex <-rt_spin_lock_slowlock
>
> it might be zone->lock it goes after. It boosts the bash process whic=
h
> seems to free memory so it would make sense.
>
>>... # rt_mutex/scheduling stuff
>>     irq/18-can1-7228  [001] d...4.6  6854.629291: sched_pi_setprio: =
comm=3Dbash pid=3D14721 oldprio=3D120 newprio=3D28
>>... # more scheduler stuff
>>     irq/18-can1-7228  [001] d...3.6  6854.629299: native_smp_send_re=
schedule <-rt_mutex_setprio
>>... # more scheduler stuff
>>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_fai=
r <-__schedule
>>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_sto=
p <-__schedule
>>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_dl =
<-__schedule
>>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_rt =
<-__schedule
>>     irq/18-can1-7228  [001] d...2.6  6854.629307: pick_next_task_fai=
r <-__schedule
>>     irq/18-can1-7228  [001] d...2.6  6854.629308: pick_next_task_idl=
e <-__schedule
>>     irq/18-can1-7228  [001] d...3.6  6854.629308: sched_switch: prev=
_comm=3Dirq/18-can1 prev_pid=3D7228 prev_prio=3D28 prev_state=3DD =3D=3D=
>
>>next_comm=3Dswapper/1 next_pid=3D0 next_prio=3D120
>>...
>>          <idle>-0     [001] d...1..  6854.629319: softirq_check_pend=
ing_idle <-tick_nohz_idle_enter
>>My tracing_off() call is in softirq_check_pending_idle, so that's it.
>
> It looks like your softirq for net_rx is getting a packet and then af=
ter
> raising NET_RX (again?) it blocks on a lock. In order to get this loc=
k
> it boosts and schedules bash. It gets runable but on the other CPU. O=
n
> CPU1 there is nothig going is nothing going and the only runable task=
 is
> the idle thread. And this is probably where the warning is written
> because we go to idle while we should process a softirq instead.

That sounds like the issue. Doing the softirq instead of going idle in
this situation seems like it means calling thread_do_softirq() from
__schedule, but I don't know where the right place is. Can anybody
give me some help on where exactly to check for softirqs from?

Thanks,
Brian
