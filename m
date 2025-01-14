Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC21C229602
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850527; cv=none; b=UJ2mSjrP38mSNt1lgy/h54yDl5VfYOtIt+BKzRdoNHdW8VbK1g+8N6nkMtKrjmjEecw3TrgzVHJ5PIDuySp9mn0bW13DOeMFm3GD5Ga/4Jzxl7r689jdikhzPGpDGAStou6HzfcZbwPUV9v7V0z207KtYGGiYPX6YRNqIbu94sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850527; c=relaxed/simple;
	bh=ODZ3APGhbOy1iNzfKtR7XViYqrpF1Ohq/ZgkivTxYkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nt2JomRZS1JzHkASGj8ICLNvRNk6Org9swv6GiHJWdEFYvUxMP0yWPugEoXIboruiv5c9IcxkX9VCbnhrPaflfCDSP+1AKHMFEmtNFwToID0bacJK2HSJejbbl6rPmjzRHwZCz1QiuceY2lOTlYIKZxxIBMZPWOKHhVHv0f7S4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=rffzv/Gd; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="rffzv/Gd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736850522; x=1737455322; i=efault@gmx.de;
	bh=BSsHzBHd6UbmT1FaBEkrCM1SFmuQq9T5wW9jH1VOBFU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rffzv/GdIQFGYZ8CVFLHOKCxxtVBKBxP4T0OmY+QCNdjXTQy/MTix6rr/KoMCSkJ
	 rF46aOg1/ciykKMXr2hn3Tsg2Z1coA+0zUIxwJCBiyCTrp6szUboe8jHBgBPGOK0y
	 erMKPlmxWbXulUZM/s93yK5yI/U3JB8DmlP5/2Y8NsnFpXGCj00DeSqH91XN/bD9u
	 ZTHjfSBzbY6NRd2jIJ9tZLvyKa/9XKuLUeYQQmvq/3JZzHr5wEFCty76nPBjvMQ/p
	 sfXNqKl/Zrjl/vVji+vDeRS9eDbchwnZBsmVNkrsc/TwD/5v0nM/gPgLU5xcmDuLf
	 TBJFr1IZZjfInmpuoA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.184]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeQr-1u2BqM3cvb-00MFyd; Tue, 14
 Jan 2025 11:28:42 +0100
Message-ID: <f3960a1aa11022f4e049d62b738b4989974e73db.camel@gmx.de>
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
From: Mike Galbraith <efault@gmx.de>
To: Florian Paul Schmidt <mista.tapas@gmx.net>, Leon Woestenberg
	 <leon@sidebranch.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org
Date: Tue, 14 Jan 2025 11:28:40 +0100
In-Reply-To: <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
	 <84bjx6h2kd.fsf@jogness.linutronix.de>
	 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
	 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
	 <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IXN1Sbh24KCXzDDSd3dCIFd99f+JS5w2v/hekHgTaZhRFS6w+fE
 Y4ulXsJhWshFWAbZe30f/eVx6UgPeLts1iX34xEd+m7b6vyRxmCHpOkkcA8q3+VC9JpBfYj
 dLD7ehQUTHS+Ie4mtxH03dujQTVSRDM71zVmN/0cqmpd2SPoItD9an3N/Ibdx8jEZZ2KJks
 A7u0AFbQz0Zld0qKw4jIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n/p1LtTSOSs=;j/78dam02jBK/l7arb7ucXUjTeR
 d8nHXmnNUVmJD/2c+50Ob594l9WhoZcwjnK6YAeDYp3CBQkb3sRjr8yVx6+DAxCfYe5iKvOsp
 dvGo4Pv3gremDclrChcz+UON0rbWjuf3/KjQhtWKxEvkLsrAJOhpvdTqyWkMbdTphVWmUFp1M
 fS1bzLxvh2cwmTkcMeLnV158aAQHfHglaMay59BAcboN9hICPyfcTePdia8lkgvOV+oc6fEcG
 GpMoZpVNfO4EzZhI5MWes+1JDp7qTV7BXIpIbW/x+zpR4XickwoBMjFvi3JPrb9WTXrBUKPWi
 AG4UDLr4T/XHDKA2+BCn+xpueEH8zhOtgPzO3ixSsQS04hKqwjlhn0oOf3qhxake5DJ8/C76c
 G/g5cEcfah2ZXYiUk4z6n/BraI18Oe3XYo3nhX6UqqsT8Pxbv5gbV79yeIXnJFLItOC31Pzzm
 avf6uXWoB3w9tfzXNRRHl2Xyknl9kdPA5CosbrluF15MWbLNCRGAqCu958J5FGZ7HBhaTYABR
 KW6DnSCZOgDrqDnzoqRtz0jota4nWONba9taUKBaV3Ok2PJ7yPOyK09WiE3ODfpvyp3gASnPV
 BvQc3AibMavpxnPTYWO+3mmugfTzzDn4ds8WeqQpcJi/xfTa9nQqqHQdLGoWvSsRJjANrFgj0
 nvYip0AmmIvaSNyr6yaEWP7GUqanoFKQe15cpGVkDMJC1UeXCT2bHLcUiswIUQTJaGb7aNqrQ
 8yEh8g5oPq3S4nUgwEc3IkgnO0kiJyLwG5KYiv2NoxRvfBLYIz/XN5ZvEm4QEwf965JIL1hQ+
 jw/wWtdE2+SXtoKVZt3fmzFF3tbyzbONu1Th8+DDdzDrXgGNSJjXk7t2wblfHIQpYILX+4ULE
 aj2autV1MmhadgH/wlgYq68l8qCxCb/HLkKiiPLevFGR5J/ao+V0rlT6jo4FxQydx9xM7O7Be
 fV5yNCEEdDfy/yhlx46pcwTVy3i1uQcL0GRk9QbwhVKV4xnk0GW212No9ycvQHWcxjD3Uq8A2
 Ra2F8Y/xLAmn25h+1hOg1xrfjHYWXHWu+QrKhSXSDiF+29CN/SlOGTjSt4TGDsMV+AYZPzr8D
 HVn3PhyWCji4N2EjTd9YHhpsBOifO2

On Sun, 2025-01-12 at 16:14 +0100, Florian Paul Schmidt wrote:
> Hi again!
>
> On 22/12/2024 11:32, Leon Woestenberg wrote:
> > You could consider using isolated CPU cores, which should give you
> > much lower latencies, if you have full control over the application
> > logic.
>
> OK, I got around to playing with isolcpus. As a first attempt I added
>
> isolcpus=3D1,2,3
>
> to my kernel commandline and tried
>
> stress -m 1 --vm-stride 16 --vm-bytes 512000000 --vm-keep -c 1
>
> and it ran on core 0 maxxing it out. So, all fine and dandy up to
> this point. Then I went on to run cyclictest on the isolated core:
>
> sudo cyclictest=C2=A0 -m -p 95 -a 1,2,3 -t 3
>
> But I get enormous latencies:
>
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 2.98 3.08 2.95 3/222 134837
>
> T: 0 (134706) P:95 I:1000 C:=C2=A0=C2=A0 4824 Min:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1 Act:=C2=A0=C2=A0=C2=A0 3 Avg:=C2=A0=C2=A0=C2=A0 8 Max:=C2=A0=
=C2=A0=C2=A0=C2=A0 518
> T: 1 (134707) P:95 I:1500 C:=C2=A0=C2=A0 3215 Min:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1 Act:=C2=A0=C2=A0=C2=A0 1 Avg:=C2=A0=C2=A0=C2=A0 8 Max:=C2=A0=
=C2=A0=C2=A0=C2=A0 566
> T: 2 (134708) P:95 I:2000 C:=C2=A0=C2=A0 2411 Min:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1 Act:=C2=A0=C2=A0=C2=A0 1 Avg:=C2=A0=C2=A0=C2=A0 9 Max:=C2=A0=
=C2=A0=C2=A0=C2=A0 503
>
> Side note: I get these enormous latencies also without cpu
> isolation and this particular stress test (albeit with -c 4 and -m 4
> - so the stressor running on all cores.) But I would have expected
> the core isolation to mitigate this somewhat. Here's the really
> surprising thing though. If I run
>
> sudo cyclictest=C2=A0 -m -p 95 -a 0,1,2,3 -t 4
>
> then I get these enormous latencies on cores 1,2 and 3 but not on
> core 0:

This seems rather odd, one core diddling memory is the worst case.  Any
arm experts out there know why that would be?

pi5, locked at 2.4GHz:

taskset -c 3 stress -m 1 --vm-bytes 1G --vm-stride 16 --vm-keep --timeout =
60s;killall cyclictest

T: 0 (23157) P:99 I:1000 C:  63421 Min:      1 Act:   12 Avg:   27 Max:   =
 1378
T: 1 (23158) P:99 I:1500 C:  42327 Min:      1 Act:   32 Avg:   29 Max:   =
 1734
T: 2 (23159) P:99 I:2000 C:  31744 Min:      1 Act:   18 Avg:   28 Max:   =
 1353
T: 3 (23160) P:99 I:2500 C:  25393 Min:      1 Act:   11 Avg:    6 Max:   =
   39

With all cores diddling ram, things are far from lovely, but cyclictest
wakeup latency improves drastically.  As you increase the number of
diddlers 1 -> 4, the latency numbers improve until you get all the way
up to.. merely awful.

stress -m 4 --vm-bytes 1G --vm-stride 16 --vm-keep --timeout 60s;killall c=
yclictest

T: 0 (23276) P:99 I:1000 C:  62706 Min:      1 Act:   49 Avg:   48 Max:   =
  220
T: 1 (23277) P:99 I:1500 C:  41800 Min:      1 Act:   53 Avg:   62 Max:   =
  274
T: 2 (23278) P:99 I:2000 C:  31348 Min:      1 Act:   45 Avg:   65 Max:   =
  302
T: 3 (23279) P:99 I:2500 C:  25077 Min:      1 Act:   32 Avg:   54 Max:   =
  175

Trace of 4 diddler run below, timewarp plagued single diddler trace
below that.  Single diddler timewarps go away if you reduce the size
enough, I just stopped poking the thing at 1G.

cyclictest reports markedly higher latency than the ftrace measured
wakeup -> task switch latency in all cases.. as if it has to slog
through miles of mud on the way to reading the damn clock.

Bottom line seems to be don't do that to dinky/cute/cheap boards :)

High speed scroll or skip recommended.

# tracer: wakeup_RT (only traces prio=3D99)
#
# wakeup_RT latency trace v1.1.5 on 6.13.0-rc6-v8-rt
# --------------------------------------------------------------------
# latency: 234 us, #272/272, CPU#3 | (M:PREEMPT_RT VP:0, KP:0, SP:0 HP:0 #=
P:4)
#    -----------------
#    | task: cyclictest-17297 (uid:0 nice:0 policy:1 rt_prio:99)
#    -----------------
#
#                    _------=3D> CPU#
#                   / _-----=3D> irqs-off/BH-disabled
#                  | / _----=3D> need-resched
#                  || / _---=3D> hardirq/softirq
#                  ||| / _--=3D> preempt-depth
#                  |||| / _-=3D> migrate-disable
#                  ||||| /     delay
#  cmd     pid     |||||| time  |   caller
#     \   /        ||||||  \    |    /
  stress-17318     3dNh4.    4us :    17318:120:R   + [003]   17297:  0:R =
cyclictest
  stress-17318     3dNh4.   11us : try_to_wake_up <-wake_up_process
  stress-17318     3dNh3.   12us : task_woken_rt <-ttwu_do_activate
  stress-17318     3dNh3.   13us : _raw_spin_unlock <-try_to_wake_up
  stress-17318     3dNh3.   13us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh2.   14us : _raw_spin_unlock_irqrestore <-try_to_wa=
ke_up
  stress-17318     3dNh2.   14us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  stress-17318     3dNh1.   14us : preempt_count_sub <-try_to_wake_up
  stress-17318     3dNh..   15us : _raw_spin_lock_irq <-__hrtimer_run_queu=
es
  stress-17318     3dNh..   15us : preempt_count_add <-_raw_spin_lock_irq
  stress-17318     3dNh1.   18us : hrtimer_update_next_event <-hrtimer_int=
errupt
  stress-17318     3dNh1.   18us : __hrtimer_next_event_base <-hrtimer_upd=
ate_next_event
  stress-17318     3dNh1.   20us : __hrtimer_next_event_base <-hrtimer_upd=
ate_next_event
  stress-17318     3dNh1.   21us : _raw_spin_unlock_irqrestore <-hrtimer_i=
nterrupt
  stress-17318     3dNh1.   21us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  stress-17318     3dNh..   21us : tick_program_event <-hrtimer_interrupt
  stress-17318     3dNh..   23us : clockevents_program_event <-tick_progra=
m_event
  stress-17318     3dNh..   24us : ktime_get <-clockevents_program_event
  stress-17318     3dNh..   25us : arch_counter_read <-ktime_get
  stress-17318     3dNh..   25us : arch_timer_set_next_event_phys <-clocke=
vents_program_event
  stress-17318     3dNh..   26us : gic_eoimode1_eoi_irq <-handle_percpu_de=
vid_irq
  stress-17318     3dNh..   31us : generic_handle_domain_irq <-gic_handle_=
irq
  stress-17318     3dNh..   32us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  stress-17318     3dNh..   32us : __rcu_read_lock <-__irq_resolve_mapping
  stress-17318     3dNh..   34us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  stress-17318     3dNh..   37us : handle_fasteoi_irq <-generic_handle_dom=
ain_irq
  stress-17318     3dNh..   37us : _raw_spin_lock <-handle_fasteoi_irq
  stress-17318     3dNh..   38us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.   39us : handle_irq_event <-handle_fasteoi_irq
  stress-17318     3dNh1.   40us : _raw_spin_unlock <-handle_irq_event
  stress-17318     3dNh1.   40us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..   41us : __handle_irq_event_percpu <-handle_irq_=
event
  stress-17318     3dNh..   44us : irq_default_primary_handler <-__handle_=
irq_event_percpu
  stress-17318     3dNh..   45us : __irq_wake_thread <-__handle_irq_event_=
percpu
  stress-17318     3dNh..   46us : wake_up_process <-__irq_wake_thread
  stress-17318     3dNh..   46us : try_to_wake_up <-wake_up_process
  stress-17318     3dNh..   47us : preempt_count_add <-try_to_wake_up
  stress-17318     3dNh1.   47us : _raw_spin_lock_irqsave <-try_to_wake_up
  stress-17318     3dNh1.   48us : preempt_count_add <-_raw_spin_lock_irqs=
ave
  stress-17318     3dNh2.   52us : kthread_is_per_cpu <-is_cpu_allowed
  stress-17318     3dNh2.   54us : ttwu_queue_wakelist <-try_to_wake_up
  stress-17318     3dNh2.   54us : preempt_count_add <-try_to_wake_up
  stress-17318     3dNh3.   54us : _raw_spin_lock <-try_to_wake_up
  stress-17318     3dNh3.   55us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh4.   55us : preempt_count_sub <-try_to_wake_up
  stress-17318     3dNh3.   56us : update_rq_clock <-try_to_wake_up
  stress-17318     3dNh3.   56us : ttwu_do_activate <-try_to_wake_up
  stress-17318     3dNh3.   57us : enqueue_task <-ttwu_do_activate
  stress-17318     3dNh3.   59us : enqueue_task_rt <-enqueue_task
  stress-17318     3dNh3.   59us : dequeue_rt_stack <-enqueue_task_rt
  stress-17318     3dNh3.   61us : wakeup_preempt <-ttwu_do_activate
  stress-17318     3dNh3.   61us : __resched_curr.constprop.0 <-wakeup_pre=
empt
  stress-17318     3dNh3.   65us : task_woken_rt <-ttwu_do_activate
  stress-17318     3dNh3.   65us : _raw_spin_unlock <-try_to_wake_up
  stress-17318     3dNh3.   66us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh2.   66us : _raw_spin_unlock_irqrestore <-try_to_wa=
ke_up
  stress-17318     3dNh2.   66us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  stress-17318     3dNh1.   67us : preempt_count_sub <-try_to_wake_up
  stress-17318     3dNh..   68us : add_interrupt_randomness <-handle_irq_e=
vent
  stress-17318     3dNh..   69us : fast_mix <-add_interrupt_randomness
  stress-17318     3dNh..   74us : add_timer_on <-add_interrupt_randomness
  stress-17318     3dNh..   75us : lock_timer_base <-add_timer_on
  stress-17318     3dNh..   76us : _raw_spin_lock_irqsave <-lock_timer_bas=
e
  stress-17318     3dNh..   77us : preempt_count_add <-_raw_spin_lock_irqs=
ave
  stress-17318     3dNh1.   79us : calc_wheel_index <-add_timer_on
  stress-17318     3dNh1.   82us : enqueue_timer <-add_timer_on
  stress-17318     3dNh1.   83us : _raw_spin_unlock_irqrestore <-add_timer=
_on
  stress-17318     3dNh1.   84us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  stress-17318     3dNh..   84us : note_interrupt <-handle_irq_event
  stress-17318     3dNh..   85us : _raw_spin_lock <-handle_irq_event
  stress-17318     3dNh..   85us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.   88us : irq_chip_eoi_parent <-handle_fasteoi_ir=
q
  stress-17318     3dNh1.   90us : irq_chip_eoi_parent <-irq_chip_eoi_pare=
nt
  stress-17318     3dNh1.   91us : gic_eoimode1_eoi_irq <-irq_chip_eoi_par=
ent
  stress-17318     3dNh1.   92us : _raw_spin_unlock <-handle_fasteoi_irq
  stress-17318     3dNh1.   92us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..   96us : generic_handle_domain_irq <-gic_handle_=
irq
  stress-17318     3dNh..   96us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  stress-17318     3dNh..   96us : __rcu_read_lock <-__irq_resolve_mapping
  stress-17318     3dNh..   96us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  stress-17318     3dNh..   97us : handle_fasteoi_irq <-generic_handle_dom=
ain_irq
  stress-17318     3dNh..   98us : _raw_spin_lock <-handle_fasteoi_irq
  stress-17318     3dNh..   98us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.   99us : handle_irq_event <-handle_fasteoi_irq
  stress-17318     3dNh1.   99us : _raw_spin_unlock <-handle_irq_event
  stress-17318     3dNh1.   99us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  100us : __handle_irq_event_percpu <-handle_irq_=
event
  stress-17318     3dNh..  100us : irq_default_primary_handler <-__handle_=
irq_event_percpu
  stress-17318     3dNh..  100us : __irq_wake_thread <-__handle_irq_event_=
percpu
  stress-17318     3dNh..  100us : add_interrupt_randomness <-handle_irq_e=
vent
  stress-17318     3dNh..  101us : fast_mix <-add_interrupt_randomness
  stress-17318     3dNh..  101us : note_interrupt <-handle_irq_event
  stress-17318     3dNh..  102us : _raw_spin_lock <-handle_irq_event
  stress-17318     3dNh..  102us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  103us : irq_chip_eoi_parent <-handle_fasteoi_ir=
q
  stress-17318     3dNh1.  104us : irq_chip_eoi_parent <-irq_chip_eoi_pare=
nt
  stress-17318     3dNh1.  104us : gic_eoimode1_eoi_irq <-irq_chip_eoi_par=
ent
  stress-17318     3dNh1.  106us : _raw_spin_unlock <-handle_fasteoi_irq
  stress-17318     3dNh1.  106us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  111us : generic_handle_domain_irq <-gic_handle_=
irq
  stress-17318     3dNh..  111us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  stress-17318     3dNh..  114us : __rcu_read_lock <-__irq_resolve_mapping
  stress-17318     3dNh..  114us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  stress-17318     3dNh..  115us : handle_fasteoi_irq <-generic_handle_dom=
ain_irq
  stress-17318     3dNh..  115us : _raw_spin_lock <-handle_fasteoi_irq
  stress-17318     3dNh..  115us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  116us : handle_irq_event <-handle_fasteoi_irq
  stress-17318     3dNh1.  116us : _raw_spin_unlock <-handle_irq_event
  stress-17318     3dNh1.  116us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  116us : __handle_irq_event_percpu <-handle_irq_=
event
  stress-17318     3dNh..  117us : irq_default_primary_handler <-__handle_=
irq_event_percpu
  stress-17318     3dNh..  117us : __irq_wake_thread <-__handle_irq_event_=
percpu
  stress-17318     3dNh..  117us : add_interrupt_randomness <-handle_irq_e=
vent
  stress-17318     3dNh..  118us : fast_mix <-add_interrupt_randomness
  stress-17318     3dNh..  118us : note_interrupt <-handle_irq_event
  stress-17318     3dNh..  120us : _raw_spin_lock <-handle_irq_event
  stress-17318     3dNh..  120us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  120us : irq_chip_eoi_parent <-handle_fasteoi_ir=
q
  stress-17318     3dNh1.  121us : irq_chip_eoi_parent <-irq_chip_eoi_pare=
nt
  stress-17318     3dNh1.  122us : gic_eoimode1_eoi_irq <-irq_chip_eoi_par=
ent
  stress-17318     3dNh1.  125us : _raw_spin_unlock <-handle_fasteoi_irq
  stress-17318     3dNh1.  125us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  129us : generic_handle_domain_irq <-gic_handle_=
irq
  stress-17318     3dNh..  129us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  stress-17318     3dNh..  130us : __rcu_read_lock <-__irq_resolve_mapping
  stress-17318     3dNh..  130us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  stress-17318     3dNh..  130us : handle_fasteoi_irq <-generic_handle_dom=
ain_irq
  stress-17318     3dNh..  130us : _raw_spin_lock <-handle_fasteoi_irq
  stress-17318     3dNh..  131us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  131us : handle_irq_event <-handle_fasteoi_irq
  stress-17318     3dNh1.  131us : _raw_spin_unlock <-handle_irq_event
  stress-17318     3dNh1.  132us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  132us : __handle_irq_event_percpu <-handle_irq_=
event
  stress-17318     3dNh..  133us : irq_default_primary_handler <-__handle_=
irq_event_percpu
  stress-17318     3dNh..  134us : __irq_wake_thread <-__handle_irq_event_=
percpu
  stress-17318     3dNh..  134us : add_interrupt_randomness <-handle_irq_e=
vent
  stress-17318     3dNh..  135us : fast_mix <-add_interrupt_randomness
  stress-17318     3dNh..  135us : note_interrupt <-handle_irq_event
  stress-17318     3dNh..  135us : _raw_spin_lock <-handle_irq_event
  stress-17318     3dNh..  135us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  136us : irq_chip_eoi_parent <-handle_fasteoi_ir=
q
  stress-17318     3dNh1.  137us : irq_chip_eoi_parent <-irq_chip_eoi_pare=
nt
  stress-17318     3dNh1.  137us : gic_eoimode1_eoi_irq <-irq_chip_eoi_par=
ent
  stress-17318     3dNh1.  138us : _raw_spin_unlock <-handle_fasteoi_irq
  stress-17318     3dNh1.  138us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  140us : generic_handle_domain_irq <-gic_handle_=
irq
  stress-17318     3dNh..  140us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  stress-17318     3dNh..  140us : __rcu_read_lock <-__irq_resolve_mapping
  stress-17318     3dNh..  141us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  stress-17318     3dNh..  141us : handle_fasteoi_irq <-generic_handle_dom=
ain_irq
  stress-17318     3dNh..  141us : _raw_spin_lock <-handle_fasteoi_irq
  stress-17318     3dNh..  142us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  142us : handle_irq_event <-handle_fasteoi_irq
  stress-17318     3dNh1.  142us : _raw_spin_unlock <-handle_irq_event
  stress-17318     3dNh1.  143us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  143us : __handle_irq_event_percpu <-handle_irq_=
event
  stress-17318     3dNh..  144us : irq_default_primary_handler <-__handle_=
irq_event_percpu
  stress-17318     3dNh..  144us : __irq_wake_thread <-__handle_irq_event_=
percpu
  stress-17318     3dNh..  145us : add_interrupt_randomness <-handle_irq_e=
vent
  stress-17318     3dNh..  145us : fast_mix <-add_interrupt_randomness
  stress-17318     3dNh..  145us : note_interrupt <-handle_irq_event
  stress-17318     3dNh..  145us : _raw_spin_lock <-handle_irq_event
  stress-17318     3dNh..  145us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  146us : irq_chip_eoi_parent <-handle_fasteoi_ir=
q
  stress-17318     3dNh1.  146us : irq_chip_eoi_parent <-irq_chip_eoi_pare=
nt
  stress-17318     3dNh1.  147us : gic_eoimode1_eoi_irq <-irq_chip_eoi_par=
ent
  stress-17318     3dNh1.  148us : _raw_spin_unlock <-handle_fasteoi_irq
  stress-17318     3dNh1.  148us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  150us : generic_handle_domain_irq <-gic_handle_=
irq
  stress-17318     3dNh..  150us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  stress-17318     3dNh..  150us : __rcu_read_lock <-__irq_resolve_mapping
  stress-17318     3dNh..  151us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  stress-17318     3dNh..  151us : handle_fasteoi_irq <-generic_handle_dom=
ain_irq
  stress-17318     3dNh..  151us : _raw_spin_lock <-handle_fasteoi_irq
  stress-17318     3dNh..  152us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  152us : handle_irq_event <-handle_fasteoi_irq
  stress-17318     3dNh1.  152us : _raw_spin_unlock <-handle_irq_event
  stress-17318     3dNh1.  152us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  153us : __handle_irq_event_percpu <-handle_irq_=
event
  stress-17318     3dNh..  153us : irq_default_primary_handler <-__handle_=
irq_event_percpu
  stress-17318     3dNh..  153us : __irq_wake_thread <-__handle_irq_event_=
percpu
  stress-17318     3dNh..  154us : add_interrupt_randomness <-handle_irq_e=
vent
  stress-17318     3dNh..  154us : fast_mix <-add_interrupt_randomness
  stress-17318     3dNh..  155us : note_interrupt <-handle_irq_event
  stress-17318     3dNh..  155us : _raw_spin_lock <-handle_irq_event
  stress-17318     3dNh..  155us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  155us : irq_chip_eoi_parent <-handle_fasteoi_ir=
q
  stress-17318     3dNh1.  155us : irq_chip_eoi_parent <-irq_chip_eoi_pare=
nt
  stress-17318     3dNh1.  156us : gic_eoimode1_eoi_irq <-irq_chip_eoi_par=
ent
  stress-17318     3dNh1.  157us : _raw_spin_unlock <-handle_fasteoi_irq
  stress-17318     3dNh1.  158us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  160us : generic_handle_domain_irq <-gic_handle_=
irq
  stress-17318     3dNh..  160us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  stress-17318     3dNh..  160us : __rcu_read_lock <-__irq_resolve_mapping
  stress-17318     3dNh..  161us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  stress-17318     3dNh..  161us : handle_fasteoi_irq <-generic_handle_dom=
ain_irq
  stress-17318     3dNh..  161us : _raw_spin_lock <-handle_fasteoi_irq
  stress-17318     3dNh..  162us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  162us : handle_irq_event <-handle_fasteoi_irq
  stress-17318     3dNh1.  163us : _raw_spin_unlock <-handle_irq_event
  stress-17318     3dNh1.  163us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  163us : __handle_irq_event_percpu <-handle_irq_=
event
  stress-17318     3dNh..  164us : irq_default_primary_handler <-__handle_=
irq_event_percpu
  stress-17318     3dNh..  164us : __irq_wake_thread <-__handle_irq_event_=
percpu
  stress-17318     3dNh..  165us : add_interrupt_randomness <-handle_irq_e=
vent
  stress-17318     3dNh..  167us : fast_mix <-add_interrupt_randomness
  stress-17318     3dNh..  167us : note_interrupt <-handle_irq_event
  stress-17318     3dNh..  169us : _raw_spin_lock <-handle_irq_event
  stress-17318     3dNh..  169us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  170us : irq_chip_eoi_parent <-handle_fasteoi_ir=
q
  stress-17318     3dNh1.  171us : irq_chip_eoi_parent <-irq_chip_eoi_pare=
nt
  stress-17318     3dNh1.  171us : gic_eoimode1_eoi_irq <-irq_chip_eoi_par=
ent
  stress-17318     3dNh1.  174us : _raw_spin_unlock <-handle_fasteoi_irq
  stress-17318     3dNh1.  174us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  180us : generic_handle_domain_irq <-gic_handle_=
irq
  stress-17318     3dNh..  180us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  stress-17318     3dNh..  181us : __rcu_read_lock <-__irq_resolve_mapping
  stress-17318     3dNh..  181us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  stress-17318     3dNh..  181us : handle_fasteoi_irq <-generic_handle_dom=
ain_irq
  stress-17318     3dNh..  182us : _raw_spin_lock <-handle_fasteoi_irq
  stress-17318     3dNh..  182us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  183us : handle_irq_event <-handle_fasteoi_irq
  stress-17318     3dNh1.  183us : _raw_spin_unlock <-handle_irq_event
  stress-17318     3dNh1.  184us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  184us : __handle_irq_event_percpu <-handle_irq_=
event
  stress-17318     3dNh..  184us : irq_default_primary_handler <-__handle_=
irq_event_percpu
  stress-17318     3dNh..  184us : __irq_wake_thread <-__handle_irq_event_=
percpu
  stress-17318     3dNh..  184us : add_interrupt_randomness <-handle_irq_e=
vent
  stress-17318     3dNh..  185us : fast_mix <-add_interrupt_randomness
  stress-17318     3dNh..  185us : note_interrupt <-handle_irq_event
  stress-17318     3dNh..  186us : _raw_spin_lock <-handle_irq_event
  stress-17318     3dNh..  186us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dNh1.  186us : irq_chip_eoi_parent <-handle_fasteoi_ir=
q
  stress-17318     3dNh1.  187us : irq_chip_eoi_parent <-irq_chip_eoi_pare=
nt
  stress-17318     3dNh1.  187us : gic_eoimode1_eoi_irq <-irq_chip_eoi_par=
ent
  stress-17318     3dNh1.  189us : _raw_spin_unlock <-handle_fasteoi_irq
  stress-17318     3dNh1.  189us : preempt_count_sub <-_raw_spin_unlock
  stress-17318     3dNh..  191us : irq_exit_rcu <-el0_interrupt
  stress-17318     3dN...  193us : idle_cpu <-__irq_exit_rcu
  stress-17318     3dN...  194us : do_notify_resume <-el0_interrupt
  stress-17318     3.N...  195us : schedule <-do_notify_resume
  stress-17318     3dN.1.  196us : rcu_note_context_switch <-__schedule
  stress-17318     3dN.1.  198us : preempt_count_add <-__schedule
  stress-17318     3dN.2.  198us : _raw_spin_lock <-__schedule
  stress-17318     3dN.2.  199us : preempt_count_add <-_raw_spin_lock
  stress-17318     3dN.3.  200us : preempt_count_sub <-__schedule
  stress-17318     3dN.2.  200us : update_rq_clock <-__schedule
  stress-17318     3dN.2.  202us : balance_fair <-__schedule
  stress-17318     3dN.2.  203us : pick_task_stop <-__schedule
  stress-17318     3dN.2.  204us : pick_task_dl <-__schedule
  stress-17318     3dN.2.  206us : pick_task_rt <-__schedule
  stress-17318     3dN.2.  207us : put_prev_task_fair <-__schedule
  stress-17318     3dN.2.  208us : put_prev_entity <-put_prev_task_fair
  stress-17318     3dN.2.  208us : update_curr <-put_prev_entity
  stress-17318     3dN.2.  209us : update_curr_se <-update_curr
  stress-17318     3dN.2.  211us : update_min_vruntime <-update_curr
  stress-17318     3dN.2.  213us : cpuacct_charge <-update_curr
  stress-17318     3dN.2.  214us : __cgroup_account_cputime <-update_curr
  stress-17318     3dN.2.  215us : preempt_count_add <-__cgroup_account_cp=
utime
  stress-17318     3dN.3.  216us : cgroup_rstat_updated <-__cgroup_account=
_cputime
  stress-17318     3dN.3.  216us : preempt_count_sub <-__cgroup_account_cp=
utime
  stress-17318     3dN.2.  217us : dl_server_update <-update_curr
  stress-17318     3dN.2.  218us : update_curr_dl_se <-dl_server_update
  stress-17318     3dN.2.  218us : dl_scaled_delta_exec <-update_curr_dl_s=
e
  stress-17318     3dN.2.  219us : __enqueue_entity <-put_prev_entity
  stress-17318     3dN.2.  221us : __update_load_avg_se <-update_load_avg
  stress-17318     3dN.2.  223us : __update_load_avg_cfs_rq <-update_load_=
avg
  stress-17318     3dN.2.  224us : decay_load <-__update_load_avg_cfs_rq
  stress-17318     3dN.2.  224us : decay_load <-__update_load_avg_cfs_rq
  stress-17318     3dN.2.  227us : update_rt_rq_load_avg <-set_next_task_r=
t
  stress-17318     3d..3.  232us : __schedule <-preempt_schedule_notrace
  stress-17318     3d..3.  233us :    17318:120:R =3D=3D> [003]   17297:  =
0:R cyclictest

Note time-warps and far more nutty irq holdoff.

# tracer: wakeup_RT
#
# wakeup_RT latency trace v1.1.5 on 6.13.0-rc6-v8-rt
# --------------------------------------------------------------------
# latency: 1316 us, #273/273, CPU#1 | (M:PREEMPT_RT VP:0, KP:0, SP:0 HP:0 =
#P:4)
#    -----------------
#    | task: cyclictest-15842 (uid:0 nice:0 policy:1 rt_prio:99)
#    -----------------
#
#                    _------=3D> CPU#
#                   / _-----=3D> irqs-off/BH-disabled
#                  | / _----=3D> need-resched
#                  || / _---=3D> hardirq/softirq
#                  ||| / _--=3D> preempt-depth
#                  |||| / _-=3D> migrate-disable
#                  ||||| /     delay
#  cmd     pid     |||||| time  |   caller
#     \   /        ||||||  \    |    /
  <idle>-0         1dnh5.    0us :        0:120:R   + [001]   15842:  0:R =
cyclictest
  <idle>-0         1dnh5.    1us : try_to_wake_up <-wake_up_process
  <idle>-0         1dnh4.    1us : task_woken_rt <-ttwu_do_activate
  <idle>-0         1dnh4.    1us : _raw_spin_unlock <-try_to_wake_up
  <idle>-0         1dnh4.    1us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dnh3.    1us : _raw_spin_unlock_irqrestore <-try_to_wa=
ke_up
  <idle>-0         1dnh3.    2us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  <idle>-0         1dnh2.    2us : preempt_count_sub <-try_to_wake_up
  <idle>-0         1dnh1.    2us : _raw_spin_lock_irq <-__hrtimer_run_queu=
es
  <idle>-0         1dnh1.    2us : preempt_count_add <-_raw_spin_lock_irq
  <idle>-0         1dnh2.    2us : hrtimer_update_next_event <-hrtimer_int=
errupt
  <idle>-0         1dnh2.    3us : __hrtimer_next_event_base <-hrtimer_upd=
ate_next_event
  <idle>-0         1dnh2.    3us : __hrtimer_next_event_base <-hrtimer_upd=
ate_next_event
  <idle>-0         1dnh2.    3us : _raw_spin_unlock_irqrestore <-hrtimer_i=
nterrupt
  <idle>-0         1dnh2.    3us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  <idle>-0         1dnh1.    3us : tick_program_event <-hrtimer_interrupt
  <idle>-0         1dnh1.    4us : clockevents_program_event <-tick_progra=
m_event
  <idle>-0         1dnh1.    4us : ktime_get <-clockevents_program_event
  <idle>-0         1dnh1.    4us : arch_counter_read <-ktime_get
  <idle>-0         1dnh1.    4us : arch_timer_set_next_event_phys <-clocke=
vents_program_event
  <idle>-0         1dnh1.    5us!: gic_eoimode1_eoi_irq <-handle_percpu_de=
vid_irq
  <idle>-0         1dnh1.  347us : generic_handle_domain_irq <-gic_handle_=
irq
  <idle>-0         1dnh1.  347us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  <idle>-0         1dnh1.  347us : __rcu_read_lock <-__irq_resolve_mapping
  <idle>-0         1dnh1.  347us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  <idle>-0         1dnh1.  348us : handle_percpu_devid_irq <-generic_handl=
e_domain_irq
  <idle>-0         1dnh1.  348us : ipi_handler <-handle_percpu_devid_irq
  <idle>-0         1dNh1.  348us : gic_eoimode1_eoi_irq <-handle_percpu_de=
vid_irq
  <idle>-0         1dNh1.  352us : irq_exit_rcu <-el1_interrupt
  <idle>-0         1dN.1.  352us : idle_cpu <-__irq_exit_rcu
  <idle>-0         1.N.1.  352us : arch_cpu_idle_exit <-do_idle
  <idle>-0         1.N.1.  352us : tick_nohz_idle_exit <-do_idle
  <idle>-0         1dN.1.  353us : ktime_get <-tick_nohz_idle_exit
  <idle>-0         1dN.1.  353us : arch_counter_read <-ktime_get
  <idle>-0         1dN.1.  353us : tick_do_update_jiffies64 <-tick_nohz_id=
le_exit
  <idle>-0         1dN.1.  353us : _raw_spin_lock <-tick_do_update_jiffies=
64
  <idle>-0         1dN.1.  353us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dN.2.  354us : calc_global_load <-tick_do_update_jiffi=
es64
  <idle>-0         1dN.2.  354us : _raw_spin_unlock <-tick_do_update_jiffi=
es64
  <idle>-0         1dN.2.  354us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dN.1.  354us : update_wall_time <-tick_do_update_jiffi=
es64
  <idle>-0         1dN.1.  355us : timekeeping_advance <-update_wall_time
  <idle>-0         1dN.1.  355us : _raw_spin_lock_irqsave <-timekeeping_ad=
vance
  <idle>-0         1dN.1.  355us : preempt_count_add <-_raw_spin_lock_irqs=
ave
  <idle>-0         1dN.2.  355us : arch_counter_read <-timekeeping_advance
  <idle>-0         1dN.2.  355us : ntp_tick_length <-timekeeping_advance
  <idle>-0         1dN.2.  356us : ntp_tick_length <-timekeeping_advance
  <idle>-0         1dN.2.  356us : timekeeping_update_from_shadow.constpro=
p.0 <-timekeeping_advance
  <idle>-0         1dN.2.  356us : ntp_get_next_leap <-timekeeping_update_=
from_shadow.constprop.0
  <idle>-0         1dN.2.  357us : update_vsyscall <-timekeeping_update_fr=
om_shadow.constprop.0
  <idle>-0         1dN.2.  357us : raw_notifier_call_chain <-timekeeping_u=
pdate_from_shadow.constprop.0
  <idle>-0         1dN.2.  357us : notifier_call_chain <-raw_notifier_call=
_chain
  <idle>-0         1dN.2.  357us : _raw_spin_unlock_irqrestore <-timekeepi=
ng_advance
  <idle>-0         1dN.2.  357us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  <idle>-0         1dN.1.  358us : timer_clear_idle <-tick_nohz_idle_exit
  <idle>-0         1dN.1.  358us : tmigr_cpu_activate <-timer_clear_idle
  <idle>-0         1dN.1.  358us : _raw_spin_lock <-tmigr_cpu_activate
  <idle>-0         1dN.1.  358us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dN.2.  358us : __tmigr_cpu_activate <-tmigr_cpu_activa=
te
  <idle>-0         1dN.2.  361us : tmigr_active_up <-__tmigr_cpu_activate
  <idle>-0         1dN.2.  361us : _raw_spin_unlock <-tmigr_cpu_activate
  <idle>-0         1dN.2.  361us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dN.1.  362us : calc_load_nohz_stop <-tick_nohz_idle_ex=
it
  <idle>-0         1dN.1.  362us : tick_nohz_restart <-tick_nohz_idle_exit
  <idle>-0         1dN.1.  362us : hrtimer_cancel <-tick_nohz_restart
  <idle>-0         1dN.1.  362us : hrtimer_active <-hrtimer_cancel
  <idle>-0         1dN.1.  362us : hrtimer_forward <-tick_nohz_restart
  <idle>-0         1dN.1.  362us : hrtimer_start_range_ns <-tick_nohz_rest=
art
  <idle>-0         1dN.1.  363us : _raw_spin_lock_irqsave <-hrtimer_start_=
range_ns
  <idle>-0         1dN.1.  363us : preempt_count_add <-_raw_spin_lock_irqs=
ave
  <idle>-0         1dN.2.  363us : enqueue_hrtimer <-hrtimer_start_range_n=
s
  <idle>-0         1dN.2.  363us : hrtimer_reprogram.constprop.0 <-hrtimer=
_start_range_ns
  <idle>-0         1dN.2.  364us : tick_program_event <-hrtimer_reprogram.=
constprop.0
  <idle>-0         1dN.2.  364us : clockevents_program_event <-tick_progra=
m_event
  <idle>-0         1dN.2.  365us : ktime_get <-clockevents_program_event
  <idle>-0         1dN.2.  365us : arch_counter_read <-ktime_get
  <idle>-0         1dN.2.  365us : arch_timer_set_next_event_phys <-clocke=
vents_program_event
  <idle>-0         1dN.2.  365us : _raw_spin_unlock_irqrestore <-hrtimer_s=
tart_range_ns
  <idle>-0         1dN.2.  365us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  <idle>-0         1dN.1.  366us : account_idle_ticks <-tick_nohz_idle_exi=
t
  <idle>-0         1dN.1.  366us : account_idle_time <-account_idle_ticks
  <idle>-0         1dN.1.  366us : irq_enter_rcu <-el1_interrupt
  <idle>-0         1dNh1.  366us : tick_irq_enter <-irq_enter_rcu
  <idle>-0         1dNh1.  367us : tick_check_oneshot_broadcast_this_cpu <=
-tick_irq_enter
  <idle>-0         1dNh1.  367us : do_interrupt_handler <-el1_interrupt
  <idle>-0         1dNh1.  367us : gic_handle_irq <-call_on_irq_stack
  <idle>-0         1dNh1.  368us : generic_handle_domain_irq <-gic_handle_=
irq
  <idle>-0         1dNh1.  368us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  <idle>-0         1dNh1.  368us : __rcu_read_lock <-__irq_resolve_mapping
  <idle>-0         1dNh1.  368us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  <idle>-0         1dNh1.  368us : handle_percpu_devid_irq <-generic_handl=
e_domain_irq
  <idle>-0         1dNh1.  369us : ipi_handler <-handle_percpu_devid_irq
  <idle>-0         1dNh1.  369us : generic_smp_call_function_single_interr=
upt <-ipi_handler
  <idle>-0         1dNh1.  369us : __flush_smp_call_function_queue <-gener=
ic_smp_call_function_single_interrupt
  <idle>-0         1dNh1.  370us : rto_push_irq_work_func <-irq_work_singl=
e
  <idle>-0         1dNh1.  370us : raw_spin_rq_lock_nested <-rto_push_irq_=
work_func
  <idle>-0         1dNh1.  370us : preempt_count_add <-raw_spin_rq_lock_ne=
sted
  <idle>-0         1dNh2.  370us : _raw_spin_lock <-raw_spin_rq_lock_neste=
d
  <idle>-0         1dNh2.  370us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dNh3.  371us : preempt_count_sub <-raw_spin_rq_lock_ne=
sted
  <idle>-0         1dNh2.  371us : push_rt_task <-rto_push_irq_work_func
  <idle>-0         1dNh2.  371us : pick_next_pushable_task <-push_rt_task
  <idle>-0         1dNh2.  371us : resched_curr <-push_rt_task
  <idle>-0         1dNh2.  371us : __resched_curr.constprop.0 <-resched_cu=
rr
  <idle>-0         1dNh2.  372us : raw_spin_rq_unlock <-rto_push_irq_work_=
func
  <idle>-0         1dNh2.  372us : _raw_spin_unlock <-raw_spin_rq_unlock
  <idle>-0         1dNh2.  372us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dNh1.  372us : _raw_spin_lock <-rto_push_irq_work_func
  <idle>-0         1dNh1.  373us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dNh2.  373us : rto_next_cpu <-rto_push_irq_work_func
  <idle>-0         1dNh2.  373us : _raw_spin_unlock <-rto_push_irq_work_fu=
nc
  <idle>-0         1dNh2.  373us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dNh1.  373us : preempt_count_add <-irq_work_queue_on
  <idle>-0         1dNh2.  374us : arch_irq_work_raise <-__irq_work_queue_=
local
  <idle>-0         1dNh2.  374us : smp_cross_call <-arch_irq_work_raise
  <idle>-0         1dNh2.  374us : __ipi_send_mask <-smp_cross_call
  <idle>-0         1dNh2.  375us : gic_ipi_send_mask <-__ipi_send_mask
  <idle>-0         1dNh2.  377us : preempt_count_sub <-irq_work_queue_on
  <idle>-0         1dNh1.  377us : gic_eoimode1_eoi_irq <-handle_percpu_de=
vid_irq
  <idle>-0         1dNh1.  382us : generic_handle_domain_irq <-gic_handle_=
irq
  <idle>-0         1dNh1.  382us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  <idle>-0         1dNh1.  382us : __rcu_read_lock <-__irq_resolve_mapping
  <idle>-0         1dNh1.  383us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  <idle>-0         1dNh1.  383us : handle_percpu_devid_irq <-generic_handl=
e_domain_irq
  <idle>-0         1dNh1.  383us : ipi_handler <-handle_percpu_devid_irq
  <idle>-0         1dNh1.  383us : rto_push_irq_work_func <-irq_work_singl=
e
  <idle>-0         1dNh1.  383us : raw_spin_rq_lock_nested <-rto_push_irq_=
work_func
  <idle>-0         1dNh1.  384us : preempt_count_add <-raw_spin_rq_lock_ne=
sted
  <idle>-0         1dNh2.  384us : _raw_spin_lock <-raw_spin_rq_lock_neste=
d
  <idle>-0         1dNh2.  384us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dNh3.  384us : preempt_count_sub <-raw_spin_rq_lock_ne=
sted
  <idle>-0         1dNh2.  384us : push_rt_task <-rto_push_irq_work_func
  <idle>-0         1dNh2.  384us : pick_next_pushable_task <-push_rt_task
  <idle>-0         1dNh2.  385us : resched_curr <-push_rt_task
  <idle>-0         1dNh2.  385us : __resched_curr.constprop.0 <-resched_cu=
rr
  <idle>-0         1dNh2.  385us : raw_spin_rq_unlock <-rto_push_irq_work_=
func
  <idle>-0         1dNh2.  385us : _raw_spin_unlock <-raw_spin_rq_unlock
  <idle>-0         1dNh2.  385us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dNh1.  386us : _raw_spin_lock <-rto_push_irq_work_func
  <idle>-0         1dNh1.  386us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dNh2.  386us : rto_next_cpu <-rto_push_irq_work_func
  <idle>-0         1dNh2.  386us : _raw_spin_unlock <-rto_push_irq_work_fu=
nc
  <idle>-0         1dNh2.  386us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dNh1.  387us : preempt_count_add <-irq_work_queue_on
  <idle>-0         1dNh2.  387us : arch_irq_work_raise <-__irq_work_queue_=
local
  <idle>-0         1dNh2.  387us : smp_cross_call <-arch_irq_work_raise
  <idle>-0         1dNh2.  387us : __ipi_send_mask <-smp_cross_call
  <idle>-0         1dNh2.  388us!: gic_ipi_send_mask <-__ipi_send_mask
  <idle>-0         1dNh2.  495us : preempt_count_sub <-irq_work_queue_on
  <idle>-0         1dNh1.  496us!: gic_eoimode1_eoi_irq <-handle_percpu_de=
vid_irq
  <idle>-0         1dNh1.  816us : generic_handle_domain_irq <-gic_handle_=
irq
  <idle>-0         1dNh1.  816us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  <idle>-0         1dNh1.  816us : __rcu_read_lock <-__irq_resolve_mapping
  <idle>-0         1dNh1.  816us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  <idle>-0         1dNh1.  816us : handle_percpu_devid_irq <-generic_handl=
e_domain_irq
  <idle>-0         1dNh1.  816us : ipi_handler <-handle_percpu_devid_irq
  <idle>-0         1dNh1.  817us : rto_push_irq_work_func <-irq_work_singl=
e
  <idle>-0         1dNh1.  817us : raw_spin_rq_lock_nested <-rto_push_irq_=
work_func
  <idle>-0         1dNh1.  817us : preempt_count_add <-raw_spin_rq_lock_ne=
sted
  <idle>-0         1dNh2.  817us : _raw_spin_lock <-raw_spin_rq_lock_neste=
d
  <idle>-0         1dNh2.  817us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dNh3.  818us : preempt_count_sub <-raw_spin_rq_lock_ne=
sted
  <idle>-0         1dNh2.  818us : push_rt_task <-rto_push_irq_work_func
  <idle>-0         1dNh2.  818us : pick_next_pushable_task <-push_rt_task
  <idle>-0         1dNh2.  818us : resched_curr <-push_rt_task
  <idle>-0         1dNh2.  819us : __resched_curr.constprop.0 <-resched_cu=
rr
  <idle>-0         1dNh2.  819us : raw_spin_rq_unlock <-rto_push_irq_work_=
func
  <idle>-0         1dNh2.  819us : _raw_spin_unlock <-raw_spin_rq_unlock
  <idle>-0         1dNh2.  819us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dNh1.  819us : _raw_spin_lock <-rto_push_irq_work_func
  <idle>-0         1dNh1.  820us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dNh2.  820us : rto_next_cpu <-rto_push_irq_work_func
  <idle>-0         1dNh2.  820us : _raw_spin_unlock <-rto_push_irq_work_fu=
nc
  <idle>-0         1dNh2.  820us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dNh1.  820us : sched_put_rd <-rto_push_irq_work_func
  <idle>-0         1dNh1.  820us!: gic_eoimode1_eoi_irq <-handle_percpu_de=
vid_irq
  <idle>-0         1dNh1.  966us : generic_handle_domain_irq <-gic_handle_=
irq
  <idle>-0         1dNh1.  966us : __irq_resolve_mapping <-generic_handle_=
domain_irq
  <idle>-0         1dNh1.  967us : __rcu_read_lock <-__irq_resolve_mapping
  <idle>-0         1dNh1.  968us : __rcu_read_unlock <-__irq_resolve_mappi=
ng
  <idle>-0         1dNh1.  968us : handle_percpu_devid_irq <-generic_handl=
e_domain_irq
  <idle>-0         1dNh1.  969us : arch_timer_handler_phys <-handle_percpu=
_devid_irq
  <idle>-0         1dNh1.  969us : hrtimer_interrupt <-arch_timer_handler_=
phys
  <idle>-0         1dNh1.  969us : _raw_spin_lock_irqsave <-hrtimer_interr=
upt
  <idle>-0         1dNh1.  969us : preempt_count_add <-_raw_spin_lock_irqs=
ave
  <idle>-0         1dNh2.  969us : ktime_get_update_offsets_now <-hrtimer_=
interrupt
  <idle>-0         1dNh2.  970us : arch_counter_read <-ktime_get_update_of=
fsets_now
  <idle>-0         1dNh2.  970us : __hrtimer_run_queues <-hrtimer_interrup=
t
  <idle>-0         1dNh2.  970us : _raw_spin_unlock_irqrestore <-__hrtimer=
_run_queues
  <idle>-0         1dNh2.  970us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  <idle>-0         1dNh1.  970us : tick_nohz_handler <-__hrtimer_run_queue=
s
  <idle>-0         1dNh1.  971us : ktime_get <-tick_nohz_handler
  <idle>-0         1dNh1.  971us : arch_counter_read <-ktime_get
  <idle>-0         1dNh1.  971us : update_process_times <-tick_nohz_handle=
r
  <idle>-0         1dNh1.  971us : account_process_tick <-update_process_t=
imes
  <idle>-0         1dNh1.  972us : account_idle_time <-account_process_tic=
k
  <idle>-0         1dNh1.  972us : hrtimer_run_queues <-update_process_tim=
es
  <idle>-0         1dNh1.  972us : tmigr_requires_handle_remote <-update_p=
rocess_times
  <idle>-0         1dNh1.  972us : get_jiffies_update <-tmigr_requires_han=
dle_remote
  <idle>-0         1dNh1.  972us : rcu_sched_clock_irq <-update_process_ti=
mes
  <idle>-0         1dNh1.  973us : rcu_is_cpu_rrupt_from_idle <-rcu_sched_=
clock_irq
  <idle>-0         1dNh1.  973us : rcu_segcblist_ready_cbs <-rcu_sched_clo=
ck_irq
  <idle>-0         1dNh1.  973us : rcu_is_cpu_rrupt_from_idle <-rcu_sched_=
clock_irq
  <idle>-0         1dNh1.  973us : sched_tick <-update_process_times
  <idle>-0         1dNh1.  974us : topology_scale_freq_tick <-sched_tick
  <idle>-0         1dNh1.  974us : preempt_count_add <-sched_tick
  <idle>-0         1dNh2.  974us : _raw_spin_lock <-sched_tick
  <idle>-0         1dNh2.  974us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dNh3.  974us : preempt_count_sub <-sched_tick
  <idle>-0         1dNh2.  975us : update_rq_clock <-sched_tick
  <idle>-0         1dNh2.  975us : task_tick_idle <-sched_tick
  <idle>-0         1dNh2.  975us : calc_global_load_tick <-sched_tick
  <idle>-0         1dNh2.  975us : task_tick_mm_cid <-sched_tick
  <idle>-0         1dNh2.  975us : _raw_spin_unlock <-sched_tick
  <idle>-0         1dNh2.  976us : preempt_count_sub <-_raw_spin_unlock
  <idle>-0         1dNh1.  976us : perf_event_task_tick <-sched_tick
  <idle>-0         1dNh1.  976us : perf_adjust_freq_unthr_context <-perf_e=
vent_task_tick
  <idle>-0         1dNh1.  976us : __rcu_read_lock <-perf_event_task_tick
  <idle>-0         1dNh1.  977us : __rcu_read_unlock <-perf_event_task_tic=
k
  <idle>-0         1dNh1.  977us : idle_cpu <-sched_tick
  <idle>-0         1dNh1.  977us : sched_balance_trigger <-sched_tick
  <idle>-0         1dNh1.  977us : nohz_balance_exit_idle <-sched_balance_=
trigger
  <idle>-0         1dNh1.  978us : __rcu_read_lock <-nohz_balance_exit_idl=
e
  <idle>-0         1dNh1.  978us : __rcu_read_unlock <-nohz_balance_exit_i=
dle
  <idle>-0         1dNh1.  978us : housekeeping_cpumask <-sched_balance_tr=
igger
  <idle>-0         1dNh1.  978us : idle_cpu <-sched_balance_trigger
  <idle>-0         1dNh1.  979us : smp_call_function_single_async <-sched_=
balance_trigger
  <idle>-0         1dNh1.  979us : preempt_count_add <-smp_call_function_s=
ingle_async
  <idle>-0         1dNh2.  979us : generic_exec_single <-smp_call_function=
_single_async
  <idle>-0         1dNh2.  979us : __smp_call_single_queue <-generic_exec_=
single
  <idle>-0         1dNh2.  980us : call_function_single_prep_ipi <-__smp_c=
all_single_queue
  <idle>-0         1dNh2.  980us : arch_send_call_function_single_ipi <-__=
smp_call_single_queue
  <idle>-0         1dNh2.  980us : smp_cross_call <-arch_send_call_functio=
n_single_ipi
  <idle>-0         1dNh2.  980us : __ipi_send_mask <-smp_cross_call
  <idle>-0         1dNh2.  980us!: gic_ipi_send_mask <-__ipi_send_mask
  <idle>-0         1dNh2. 1304us : preempt_count_sub <-smp_call_function_s=
ingle_async
  <idle>-0         1dNh1. 1305us : run_posix_cpu_timers <-update_process_t=
imes
  <idle>-0         1dNh1. 1305us : profile_tick <-tick_nohz_handler
  <idle>-0         1dNh1. 1305us : profile_pc <-profile_tick
  <idle>-0         1dNh1. 1306us : profile_pc_cb <-arch_stack_walk
  <idle>-0         1dNh1. 1306us : hrtimer_forward <-tick_nohz_handler
  <idle>-0         1dNh1. 1306us : _raw_spin_lock_irq <-__hrtimer_run_queu=
es
  <idle>-0         1dNh1. 1306us : preempt_count_add <-_raw_spin_lock_irq
  <idle>-0         1dNh2. 1306us : enqueue_hrtimer <-__hrtimer_run_queues
  <idle>-0         1dNh2. 1307us : hrtimer_update_next_event <-hrtimer_int=
errupt
  <idle>-0         1dNh2. 1307us : __hrtimer_next_event_base <-hrtimer_upd=
ate_next_event
  <idle>-0         1dNh2. 1307us : __hrtimer_next_event_base <-hrtimer_upd=
ate_next_event
  <idle>-0         1dNh2. 1307us : _raw_spin_unlock_irqrestore <-hrtimer_i=
nterrupt
  <idle>-0         1dNh2. 1307us : preempt_count_sub <-_raw_spin_unlock_ir=
qrestore
  <idle>-0         1dNh1. 1308us : tick_program_event <-hrtimer_interrupt
  <idle>-0         1dNh1. 1308us : clockevents_program_event <-tick_progra=
m_event
  <idle>-0         1dNh1. 1308us : ktime_get <-clockevents_program_event
  <idle>-0         1dNh1. 1308us : arch_counter_read <-ktime_get
  <idle>-0         1dNh1. 1309us : arch_timer_set_next_event_phys <-clocke=
vents_program_event
  <idle>-0         1dNh1. 1309us : gic_eoimode1_eoi_irq <-handle_percpu_de=
vid_irq
  <idle>-0         1dNh1. 1312us : irq_exit_rcu <-el1_interrupt
  <idle>-0         1dN.1. 1312us : idle_cpu <-__irq_exit_rcu
  <idle>-0         1.N.1. 1313us : flush_smp_call_function_queue <-do_idle
  <idle>-0         1.N.1. 1313us : schedule_idle <-do_idle
  <idle>-0         1dN.1. 1313us : rcu_note_context_switch <-__schedule
  <idle>-0         1dN.1. 1313us : preempt_count_add <-__schedule
  <idle>-0         1dN.2. 1313us : _raw_spin_lock <-__schedule
  <idle>-0         1dN.2. 1314us : preempt_count_add <-_raw_spin_lock
  <idle>-0         1dN.3. 1314us : preempt_count_sub <-__schedule
  <idle>-0         1dN.2. 1314us : update_rq_clock <-__schedule
  <idle>-0         1dN.2. 1314us : pick_task_stop <-__schedule
  <idle>-0         1dN.2. 1314us : pick_task_dl <-__schedule
  <idle>-0         1dN.2. 1315us : pick_task_rt <-__schedule
  <idle>-0         1dN.2. 1315us : put_prev_task_idle <-__schedule
  <idle>-0         1dN.2. 1315us : dl_scaled_delta_exec <-put_prev_task_id=
le
  <idle>-0         1dN.2. 1315us : update_rt_rq_load_avg <-set_next_task_r=
t
  <idle>-0         1d..3. 1316us : __schedule <-schedule_idle
  <idle>-0         1d..3. 1316us :        0:120:R =3D=3D> [001]   15842:  =
0:R cyclictest

