From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: Networking latency issue on 2.6.33.7-rt29 kernel
Date: Wed, 24 Nov 2010 14:35:38 +0100
Message-ID: <AANLkTin6nJxLa_U61yj=a=BQapHxMoc6FFtLfwP_yma_@mail.gmail.com>
References: <AANLkTi=7_zBakGaCys6FpLO8BbZKKX0sYb7Y6RBU8_bB@mail.gmail.com>
	<0016e65a0784be92790495bd73d5@google.com>
	<AANLkTimzu3fM4_PaxSqrmUuYoZheDNjf5yVPmhJh=Yzz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55183 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754359Ab0KXNfl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Nov 2010 08:35:41 -0500
Received: by wyb28 with SMTP id 28so9477841wyb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Nov 2010 05:35:39 -0800 (PST)
In-Reply-To: <AANLkTimzu3fM4_PaxSqrmUuYoZheDNjf5yVPmhJh=Yzz@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/11/24 Jean-Michel Hautbois <jhautbois@gmail.com>:
> 2010/11/23 =C2=A0<jhautbois@gmail.com>:
>> Some precisions :
>>
>> I am working on a MPC5200 board.
>> Packets are transfered thanks to a transparent bridge.
>> This is an L2 proprietary protocol.
>>
>> Le , Jean-Michel Hautbois <jhautbois@gmail.com> a =C3=A9crit=C2=A0:
>>> Hi,
>>>
>>>
>>>
>>> I have a latency issue using the linux-2.6.33.7-rt29 kernel.
>>>
>>> Here is my setup :
>>>
>>>
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Boa=
rd 1| | Board 2|
>>>
>>> PC --> =C2=A0 --> eth->wifi->wifi->eth --> =C2=A0 --> PC
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 |_ tap =C2=A0----------DAG------- tap_|
>>>
>>>
>>>
>>> The measure is done thanks to external TAP devices.
>>>
>>>
>>>
>>> The DAG card is on another PC and does the measure.
>>>
>>> But it is an "out of the box" measure and this is done only after I
>>>
>>> stop the capture by merging pcap files and using timestamps.
>>>
>>>
>>>
>>> The issue, now...
>>>
>>>
>>>
>>> As you can see on the following two pictures, at least two events
>>>
>>> occur during my test.
>>>
>>> http://rostedt.homelinux.com/rt-jitter/latencies_1500us_rt_cable_no=
ip7.png
>>>
>>> http://rostedt.homelinux.com/rt-jitter/latencies_1500us_rt_cable_no=
ip8.png
>>>
>>>
>>>
>>> Each graph is representing the latency in =C2=B5s vs. the packet nu=
mber.
>>>
>>> Each packet is separated from the previous one by 1500=C2=B5s.
>>>
>>> I don't have any IP address configured (I removed the loopback and =
all
>>>
>>> other interfaces are configured using ifconfig 0.0.0.0).
>>>
>>>
>>>
>>> The problem occurs in PREEMPT_RT and PREEMPT_DESKTOP.
>>>
>>> The period is bigger when I change HZ (I am currently using HZ=3D10=
00).
>>>
>>> Hrtimers are configured, but even when not using it, the problem is=
 the
>>> same.
>>>
>>>
>>>
>>> I have done many many tests, removing timers, changing frequencies,=
 etc.
>>>
>>> I also tried to change priority of my processes associated with
>>>
>>> sirq-rx, sirq-tx, and the interrupts.
>>>
>>>
>>>
>>> I can't find the cause.
>>>
>>> If you have *any* idea, thanks in advance !
>>>
>>>
>>>
>>> Here are the timers after the test associated to the picture named
>>>
>>> "latencies_1500us_rt_cable_noip8.png" :
>>>
>>>
>>>
>>> Board 1 (eth -> wifi) :
>>>
>>> -----------------------
>>>
>>> Sample period: 1654.752 s
>>>
>>> =C2=A01654753, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 hrtimer_s=
tart_range_ns (tick_sched_timer)
>>>
>>> =C2=A01655, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 __enqueue_rt=
_entity (sched_rt_period_timer)
>>>
>>> =C2=A01649, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ph=
y_state_machine (delayed_work_timer_fn)
>>>
>>> =C2=A01650, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ms=
leep (process_timeout)
>>>
>>> =C2=A0824, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msl=
eep (process_timeout)
>>>
>>> =C2=A0275, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 arm_supers_ti=
mer (sync_supers_timer_fn)
>>>
>>> =C2=A0330, =C2=A0 =C2=A080 bdi-default =C2=A0 =C2=A0 =C2=A0bdi_fork=
er_task (process_timeout)
>>>
>>> =C2=A0109D, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ne=
igh_periodic_work (delayed_work_timer_fn)
>>>
>>> =C2=A027D, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rt_=
worker_func (delayed_work_timer_fn)
>>>
>>> =C2=A0 26, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 dev_watchdog =
(dev_watchdog)
>>>
>>> =C2=A0 26, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 dev_watchdog =
(dev_watchdog)
>>>
>>> =C2=A0 13, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 peer_check_ex=
pire (peer_check_expire)
>>>
>>> =C2=A0 =C2=A05, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 rekey_seq_generator (delayed_work_timer_fn)
>>>
>>> =C2=A0 =C2=A02, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 inet_fra=
g_secret_rebuild
>>>
>>> (inet_frag_secret_rebuild)
>>>
>>> =C2=A0 1D, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 rt_secret_reb=
uild (rt_secret_rebuild)
>>>
>>> 1661345 total events, 1003.107 events/sec
>>>
>>>
>>>
>>> Board 2 (wifi -> eth) :
>>>
>>> -----------------------
>>>
>>> Sample period: 1649.636 s
>>>
>>> =C2=A01649636, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 hrtimer_s=
tart_range_ns (tick_sched_timer)
>>>
>>> =C2=A01650, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 __enqueue_rt=
_entity (sched_rt_period_timer)
>>>
>>> =C2=A01644, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ph=
y_state_machine (delayed_work_timer_fn)
>>>
>>> =C2=A01644, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ms=
leep (process_timeout)
>>>
>>> =C2=A0822, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msl=
eep (process_timeout)
>>>
>>> =C2=A0329, =C2=A0 =C2=A080 bdi-default =C2=A0 =C2=A0 =C2=A0bdi_fork=
er_task (process_timeout)
>>>
>>> =C2=A0274, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 arm_supers_ti=
mer (sync_supers_timer_fn)
>>>
>>> =C2=A0108D, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ne=
igh_periodic_work (delayed_work_timer_fn)
>>>
>>> =C2=A0 27, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 dev_watchdog =
(dev_watchdog)
>>>
>>> =C2=A0 27, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 dev_watchdog =
(dev_watchdog)
>>>
>>> =C2=A026D, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rt_=
worker_func (delayed_work_timer_fn)
>>>
>>> =C2=A0 13, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 peer_check_ex=
pire (peer_check_expire)
>>>
>>> =C2=A0 =C2=A04, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 rekey_seq_generator (delayed_work_timer_fn)
>>>
>>> =C2=A0 =C2=A01, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 inet_fra=
g_secret_rebuild
>>>
>>> (inet_frag_secret_rebuild)
>>>
>>> =C2=A0 1D, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 rt_secret_reb=
uild (rt_secret_rebuild)
>>>
>>> 1656207 total events, 1003.603 events/sec
>>>
>>>
>>>
>>> And here is my ifconfig on each board :
>>>
>>>
>>>
>>> Board 1 (eth -> wifi) :
>>>
>>> -----------------------
>>>
>>> ath0 =C2=A0 =C2=A0 =C2=A0Link encap:Ethernet =C2=A0HWaddr 00:0B:6B:=
2F:9F:8A
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 o=
verruns:0 frame:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:3866892 errors:0 dropp=
ed:0 overruns:0 carrier:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes=
:777245292 (741.2 MiB)
>>>
>>>
>>>
>>> br0 =C2=A0 =C2=A0 =C2=A0 Link encap:Ethernet =C2=A0HWaddr 00:0B:6B:=
2F:9F:8A
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING NOARP =C2=A0=
MTU:1500 =C2=A0Metric:1
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 o=
verruns:0 frame:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 o=
verruns:0 carrier:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes=
:0 (0.0 B)
>>>
>>>
>>>
>>> eth0 =C2=A0 =C2=A0 =C2=A0Link encap:Ethernet =C2=A0HWaddr 00:10:02:=
0F:B8:06
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:3866892 errors:0 dropp=
ed:0 overruns:0 frame:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 o=
verruns:0 carrier:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:1000
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:792712860 (755.9 MiB) =C2=
=A0TX bytes:0 (0.0 B)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interrupt:133 Base address:0x3000
>>>
>>>
>>>
>>> wifi0 =C2=A0 =C2=A0 Link encap:UNSPEC =C2=A0HWaddr
>>>
>>> 00-0B-6B-2F-9F-8A-00-00-00-00-00-00-00-00-00-00
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 o=
verruns:0 frame:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:3866892 errors:0 dropp=
ed:0 overruns:0 carrier:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:199
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes=
:912586512 (870.3 MiB)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interrupt:66
>>>
>>>
>>>
>>>
>>>
>>> Board 2 (wifi -> eth) :
>>>
>>> -----------------------
>>>
>>> ath0 =C2=A0 =C2=A0 =C2=A0Link encap:Ethernet =C2=A0HWaddr 00:0B:6B:=
2F:A0:14
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:3818800 errors:0 dropp=
ed:0 overruns:0 frame:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 o=
verruns:0 carrier:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:767578800 (732.0 MiB) =C2=
=A0TX bytes:0 (0.0 B)
>>>
>>>
>>>
>>> br0 =C2=A0 =C2=A0 =C2=A0 Link encap:Ethernet =C2=A0HWaddr 00:0B:6B:=
2F:A0:14
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING NOARP =C2=A0=
MTU:1500 =C2=A0Metric:1
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 o=
verruns:0 frame:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 o=
verruns:0 carrier:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes=
:0 (0.0 B)
>>>
>>>
>>>
>>> eth0 =C2=A0 =C2=A0 =C2=A0Link encap:Ethernet =C2=A0HWaddr 00:10:02:=
0F:B8:05
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 o=
verruns:0 frame:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:3818800 errors:0 dropp=
ed:0 overruns:0 carrier:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:1000
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes=
:782854000 (746.5 MiB)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interrupt:133 Base address:0x3000
>>>
>>>
>>>
>>> wifi0 =C2=A0 =C2=A0 Link encap:UNSPEC =C2=A0HWaddr
>>>
>>> 00-0B-6B-2F-A0-14-00-00-00-00-00-00-00-00-00-00
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:3818800 errors:0 dropp=
ed:0 overruns:0 frame:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 o=
verruns:0 carrier:0
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:199
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:901236800 (859.4 MiB) =C2=
=A0TX bytes:0 (0.0 B)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interrupt:66
>>>
>>>
>>>
>>> JM
>>>
>
> I have done some tests using two different HZ values with
> CONFIG_PREEMPT_DESKTOP.
> Here are the results :
> With HZ=3D1000
> http://picasaweb.google.com/lh/photo/ltb6hZvfssCFN0uF1iscP5MU3g7ObZTP=
qzWaaCIpUqI?feat=3Ddirectlink
> With HZ=3D250
> http://picasaweb.google.com/lh/photo/H9mKcM-Tarfumezbu8IJUZMU3g7ObZTP=
qzWaaCIpUqI?feat=3Ddirectlink
>
> It seems to be related to a timer, maybe the scheduler itself...
> Here is my ps result (on busybox) after the HZ=3D250 test :
> PID =C2=A0 USER =C2=A0 =C2=A0 TIME =C2=A0 COMMAND
> =C2=A0 =C2=A01 root =C2=A0 =C2=A0 =C2=A0 0:02 init
> =C2=A0 =C2=A02 root =C2=A0 =C2=A0 =C2=A0 0:00 [kthreadd]
> =C2=A0 =C2=A03 root =C2=A0 =C2=A0 =C2=A0 0:00 [sirq-high/0]
> =C2=A0 =C2=A04 root =C2=A0 =C2=A0 =C2=A0 0:21 [sirq-timer/0]
> =C2=A0 =C2=A05 root =C2=A0 =C2=A0 =C2=A0 0:00 [sirq-net-tx/0]
> =C2=A0 =C2=A06 root =C2=A0 =C2=A0 =C2=A0 3:08 [sirq-net-rx/0]
> =C2=A0 =C2=A07 root =C2=A0 =C2=A0 =C2=A0 0:00 [sirq-block/0]
> =C2=A0 =C2=A08 root =C2=A0 =C2=A0 =C2=A0 0:00 [sirq-block-iopo]
> =C2=A0 =C2=A09 root =C2=A0 =C2=A0 =C2=A0 1:56 [sirq-tasklet/0]
> =C2=A0 10 root =C2=A0 =C2=A0 =C2=A0 0:00 [sirq-sched/0]
> =C2=A0 11 root =C2=A0 =C2=A0 =C2=A0 0:00 [sirq-hrtimer/0]
> =C2=A0 12 root =C2=A0 =C2=A0 =C2=A0 0:22 [sirq-rcu/0]
> =C2=A0 13 root =C2=A0 =C2=A0 =C2=A0 0:00 [posixcputmr/0]
> =C2=A0 14 root =C2=A0 =C2=A0 =C2=A0 0:00 [desched/0]
> =C2=A0 15 root =C2=A0 =C2=A0 =C2=A0 0:00 [events/0]
> =C2=A0 16 root =C2=A0 =C2=A0 =C2=A0 0:00 [khelper]
> =C2=A0 19 root =C2=A0 =C2=A0 =C2=A0 0:00 [async/mgr]
> =C2=A0 78 root =C2=A0 =C2=A0 =C2=A0 0:00 [sync_supers]
> =C2=A0 80 root =C2=A0 =C2=A0 =C2=A0 0:00 [bdi-default]
> =C2=A0 81 root =C2=A0 =C2=A0 =C2=A0 0:00 [kblockd/0]
> =C2=A0105 root =C2=A0 =C2=A0 =C2=A0 0:00 [kswapd0]
> =C2=A0106 root =C2=A0 =C2=A0 =C2=A0 0:00 [aio/0]
> =C2=A0107 root =C2=A0 =C2=A0 =C2=A0 0:00 [crypto/0]
> =C2=A0128 root =C2=A0 =C2=A0 =C2=A0 0:00 [mtdblockd]
> =C2=A0188 root =C2=A0 =C2=A0 =C2=A0 0:00 [irq/144-i2c-mpc]
> =C2=A0192 root =C2=A0 =C2=A0 =C2=A0 0:00 [kstriped]
> =C2=A0194 root =C2=A0 =C2=A0 =C2=A0 0:00 [ksnapd]
> =C2=A0198 root =C2=A0 =C2=A0 =C2=A0 0:00 [irq/139-mpc52xx]
> =C2=A0216 root =C2=A0 =C2=A0 =C2=A0 0:00 [jffs2_gcd_mtd14]
> =C2=A0221 root =C2=A0 =C2=A0 =C2=A0 0:00 /usr/bin/update 1
> =C2=A0240 root =C2=A0 =C2=A0 =C2=A0 1:00 [irq/66-wifi%d]
> =C2=A0257 root =C2=A0 =C2=A0 =C2=A0 0:00 [irq/133-mpc52xx]
> =C2=A0258 root =C2=A0 =C2=A0 =C2=A0 1:10 [irq/192-mpc52xx]
> =C2=A0259 root =C2=A0 =C2=A0 =C2=A0 0:00 [irq/193-mpc52xx]
> =C2=A0280 root =C2=A0 =C2=A0 =C2=A0 0:00 dropbear
> =C2=A0281 root =C2=A0 =C2=A0 =C2=A0 0:00 -/bin/sh
> =C2=A0308 root =C2=A0 =C2=A0 =C2=A0 0:00 ps
>

=46or those who may be interested, CONFIG_TINY_RCU changes the behaviou=
r
(it was CONFIG_TREE_PREEMPT_RCU) :
http://picasaweb.google.com/lh/photo/DmKJyIv04fvnN_y0wR0_9ZMU3g7ObZTPqz=
WaaCIpUqI?feat=3Ddirectlink
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
