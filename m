From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: CONFIG_PREEMPT_RT local_softirq_pending warning when ISR blocks
Date: Fri, 13 Mar 2015 17:38:49 +0100
Message-ID: <20150313163849.GF5592@linutronix.de>
References: <CAGt3f4na1EMtViiLym3JnzGbOGSMXwy9puOccOyrOWKjd4QOnQ@mail.gmail.com>
 <20150309160845.GE13768@linutronix.de>
 <CAGt3f4k0d5LRwuec1gpm=+NW325OskPxZbuTroEBSO9d1MMZaQ@mail.gmail.com>
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
In-Reply-To: <CAGt3f4k0d5LRwuec1gpm=+NW325OskPxZbuTroEBSO9d1MMZaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Brian Silverman | 2015-03-09 20:36:27 [-0400]:

>> It looks like your softirq for net_rx is getting a packet and then a=
fter
>> raising NET_RX (again?) it blocks on a lock. In order to get this lo=
ck
>> it boosts and schedules bash. It gets runable but on the other CPU. =
On
>> CPU1 there is nothig going is nothing going and the only runable tas=
k is
>> the idle thread. And this is probably where the warning is written
>> because we go to idle while we should process a softirq instead.
>
>That sounds like the issue. Doing the softirq instead of going idle in
>this situation seems like it means calling thread_do_softirq() from
>__schedule, but I don't know where the right place is. Can anybody
>give me some help on where exactly to check for softirqs from?

I was slightly wrong.

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
You raised the softirq but you did not wakeup softirqd. It is expected
that you process softirq(s) in irq-thread context once you leave the
interrupt thread (that is on local_bh_enable() because the thread is ru=
n
with BH off).
But this did not happen yet. While you are in your interrupt thread you
got blocked on a lock. And since your CPU is idle otherwise, the
scheduler puts the idle task on.
softirq_check_pending_idle() has a check for this kind of things but
only if the ksoftirqd itself got blocked. In your case it is a process
with BH switched off.
You wouldn't see the warning if you start a task in userland that just
loops and keeps the CPU busy :)

So. One thing I noticed from looking at the code, is that if a thread i=
s
marked IRQF_NO_SOFTIRQ_CALL() then it won't raise process softirqs at
all. This is a bug but since nobody uses IRQF_NO_SOFTIRQ_CALL nobody
noticed it so far (or nobody uses it because it is not working).

And for you. I'm not sure yet what is the best thing to do here. We
could
- teach softirq_check_pending_idle() to ignore these things because
  once the irq thread is unblocked, it will process the softirq.
- utilize the otherwise idle CPU and schedule ksoftirq with the proper
  mask.

Both isn't that easy, I think=E2=80=A6

>Thanks,
>Brian

Sebastian
