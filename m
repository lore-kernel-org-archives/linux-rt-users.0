From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: Networking latency issue on 2.6.33.7-rt29 kernel
Date: Wed, 24 Nov 2010 09:54:53 +0100
Message-ID: <AANLkTimzu3fM4_PaxSqrmUuYoZheDNjf5yVPmhJh=Yzz@mail.gmail.com>
References: <AANLkTi=7_zBakGaCys6FpLO8BbZKKX0sYb7Y6RBU8_bB@mail.gmail.com>
	<0016e65a0784be92790495bd73d5@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48321 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab0KXJBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Nov 2010 04:01:49 -0500
Received: by wyb28 with SMTP id 28so9254322wyb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Nov 2010 01:01:47 -0800 (PST)
In-Reply-To: <0016e65a0784be92790495bd73d5@google.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/11/23  <jhautbois@gmail.com>:
> Some precisions :
>
> I am working on a MPC5200 board.
> Packets are transfered thanks to a transparent bridge.
> This is an L2 proprietary protocol.
>
> Le , Jean-Michel Hautbois <jhautbois@gmail.com> a =C3=A9crit=C2=A0:
>> Hi,
>>
>>
>>
>> I have a latency issue using the linux-2.6.33.7-rt29 kernel.
>>
>> Here is my setup :
>>
>>
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Boar=
d 1| | Board 2|
>>
>> PC --> =C2=A0 --> eth->wifi->wifi->eth --> =C2=A0 --> PC
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 |_ tap =C2=A0----------DAG------- tap_|
>>
>>
>>
>> The measure is done thanks to external TAP devices.
>>
>>
>>
>> The DAG card is on another PC and does the measure.
>>
>> But it is an "out of the box" measure and this is done only after I
>>
>> stop the capture by merging pcap files and using timestamps.
>>
>>
>>
>> The issue, now...
>>
>>
>>
>> As you can see on the following two pictures, at least two events
>>
>> occur during my test.
>>
>> http://rostedt.homelinux.com/rt-jitter/latencies_1500us_rt_cable_noi=
p7.png
>>
>> http://rostedt.homelinux.com/rt-jitter/latencies_1500us_rt_cable_noi=
p8.png
>>
>>
>>
>> Each graph is representing the latency in =C2=B5s vs. the packet num=
ber.
>>
>> Each packet is separated from the previous one by 1500=C2=B5s.
>>
>> I don't have any IP address configured (I removed the loopback and a=
ll
>>
>> other interfaces are configured using ifconfig 0.0.0.0).
>>
>>
>>
>> The problem occurs in PREEMPT_RT and PREEMPT_DESKTOP.
>>
>> The period is bigger when I change HZ (I am currently using HZ=3D100=
0).
>>
>> Hrtimers are configured, but even when not using it, the problem is =
the
>> same.
>>
>>
>>
>> I have done many many tests, removing timers, changing frequencies, =
etc.
>>
>> I also tried to change priority of my processes associated with
>>
>> sirq-rx, sirq-tx, and the interrupts.
>>
>>
>>
>> I can't find the cause.
>>
>> If you have *any* idea, thanks in advance !
>>
>>
>>
>> Here are the timers after the test associated to the picture named
>>
>> "latencies_1500us_rt_cable_noip8.png" :
>>
>>
>>
>> Board 1 (eth -> wifi) :
>>
>> -----------------------
>>
>> Sample period: 1654.752 s
>>
>> =C2=A01654753, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 hrtimer_st=
art_range_ns (tick_sched_timer)
>>
>> =C2=A01655, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 __enqueue_rt_=
entity (sched_rt_period_timer)
>>
>> =C2=A01649, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phy=
_state_machine (delayed_work_timer_fn)
>>
>> =C2=A01650, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msl=
eep (process_timeout)
>>
>> =C2=A0824, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msle=
ep (process_timeout)
>>
>> =C2=A0275, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 arm_supers_tim=
er (sync_supers_timer_fn)
>>
>> =C2=A0330, =C2=A0 =C2=A080 bdi-default =C2=A0 =C2=A0 =C2=A0bdi_forke=
r_task (process_timeout)
>>
>> =C2=A0109D, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nei=
gh_periodic_work (delayed_work_timer_fn)
>>
>> =C2=A027D, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rt_w=
orker_func (delayed_work_timer_fn)
>>
>> =C2=A0 26, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 dev_watchdog (=
dev_watchdog)
>>
>> =C2=A0 26, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 dev_watchdog (=
dev_watchdog)
>>
>> =C2=A0 13, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 peer_check_exp=
ire (peer_check_expire)
>>
>> =C2=A0 =C2=A05, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 rekey_seq_generator (delayed_work_timer_fn)
>>
>> =C2=A0 =C2=A02, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 inet_frag=
_secret_rebuild
>>
>> (inet_frag_secret_rebuild)
>>
>> =C2=A0 1D, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 rt_secret_rebu=
ild (rt_secret_rebuild)
>>
>> 1661345 total events, 1003.107 events/sec
>>
>>
>>
>> Board 2 (wifi -> eth) :
>>
>> -----------------------
>>
>> Sample period: 1649.636 s
>>
>> =C2=A01649636, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 hrtimer_st=
art_range_ns (tick_sched_timer)
>>
>> =C2=A01650, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 __enqueue_rt_=
entity (sched_rt_period_timer)
>>
>> =C2=A01644, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phy=
_state_machine (delayed_work_timer_fn)
>>
>> =C2=A01644, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msl=
eep (process_timeout)
>>
>> =C2=A0822, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msle=
ep (process_timeout)
>>
>> =C2=A0329, =C2=A0 =C2=A080 bdi-default =C2=A0 =C2=A0 =C2=A0bdi_forke=
r_task (process_timeout)
>>
>> =C2=A0274, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 arm_supers_tim=
er (sync_supers_timer_fn)
>>
>> =C2=A0108D, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nei=
gh_periodic_work (delayed_work_timer_fn)
>>
>> =C2=A0 27, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 dev_watchdog (=
dev_watchdog)
>>
>> =C2=A0 27, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 dev_watchdog (=
dev_watchdog)
>>
>> =C2=A026D, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rt_w=
orker_func (delayed_work_timer_fn)
>>
>> =C2=A0 13, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 peer_check_exp=
ire (peer_check_expire)
>>
>> =C2=A0 =C2=A04, =C2=A0 =C2=A015 events/0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 rekey_seq_generator (delayed_work_timer_fn)
>>
>> =C2=A0 =C2=A01, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 inet_frag=
_secret_rebuild
>>
>> (inet_frag_secret_rebuild)
>>
>> =C2=A0 1D, =C2=A0 =C2=A0 4 sirq-timer/0 =C2=A0 =C2=A0 rt_secret_rebu=
ild (rt_secret_rebuild)
>>
>> 1656207 total events, 1003.603 events/sec
>>
>>
>>
>> And here is my ifconfig on each board :
>>
>>
>>
>> Board 1 (eth -> wifi) :
>>
>> -----------------------
>>
>> ath0 =C2=A0 =C2=A0 =C2=A0Link encap:Ethernet =C2=A0HWaddr 00:0B:6B:2=
=46:9F:8A
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 ov=
erruns:0 frame:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:3866892 errors:0 droppe=
d:0 overruns:0 carrier:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes:=
777245292 (741.2 MiB)
>>
>>
>>
>> br0 =C2=A0 =C2=A0 =C2=A0 Link encap:Ethernet =C2=A0HWaddr 00:0B:6B:2=
=46:9F:8A
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING NOARP =C2=A0M=
TU:1500 =C2=A0Metric:1
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 ov=
erruns:0 frame:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 ov=
erruns:0 carrier:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes:=
0 (0.0 B)
>>
>>
>>
>> eth0 =C2=A0 =C2=A0 =C2=A0Link encap:Ethernet =C2=A0HWaddr 00:10:02:0=
=46:B8:06
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:3866892 errors:0 droppe=
d:0 overruns:0 frame:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 ov=
erruns:0 carrier:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:1000
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:792712860 (755.9 MiB) =C2=
=A0TX bytes:0 (0.0 B)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interrupt:133 Base address:0x3000
>>
>>
>>
>> wifi0 =C2=A0 =C2=A0 Link encap:UNSPEC =C2=A0HWaddr
>>
>> 00-0B-6B-2F-9F-8A-00-00-00-00-00-00-00-00-00-00
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 ov=
erruns:0 frame:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:3866892 errors:0 droppe=
d:0 overruns:0 carrier:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:199
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes:=
912586512 (870.3 MiB)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interrupt:66
>>
>>
>>
>>
>>
>> Board 2 (wifi -> eth) :
>>
>> -----------------------
>>
>> ath0 =C2=A0 =C2=A0 =C2=A0Link encap:Ethernet =C2=A0HWaddr 00:0B:6B:2=
=46:A0:14
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:3818800 errors:0 droppe=
d:0 overruns:0 frame:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 ov=
erruns:0 carrier:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:767578800 (732.0 MiB) =C2=
=A0TX bytes:0 (0.0 B)
>>
>>
>>
>> br0 =C2=A0 =C2=A0 =C2=A0 Link encap:Ethernet =C2=A0HWaddr 00:0B:6B:2=
=46:A0:14
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING NOARP =C2=A0M=
TU:1500 =C2=A0Metric:1
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 ov=
erruns:0 frame:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 ov=
erruns:0 carrier:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes:=
0 (0.0 B)
>>
>>
>>
>> eth0 =C2=A0 =C2=A0 =C2=A0Link encap:Ethernet =C2=A0HWaddr 00:10:02:0=
=46:B8:05
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:0 errors:0 dropped:0 ov=
erruns:0 frame:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:3818800 errors:0 droppe=
d:0 overruns:0 carrier:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:1000
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:0 (0.0 B) =C2=A0TX bytes:=
782854000 (746.5 MiB)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interrupt:133 Base address:0x3000
>>
>>
>>
>> wifi0 =C2=A0 =C2=A0 Link encap:UNSPEC =C2=A0HWaddr
>>
>> 00-0B-6B-2F-A0-14-00-00-00-00-00-00-00-00-00-00
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0UP BROADCAST RUNNING MULTICAST =C2=
=A0MTU:1500 =C2=A0Metric:1
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX packets:3818800 errors:0 droppe=
d:0 overruns:0 frame:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TX packets:0 errors:0 dropped:0 ov=
erruns:0 carrier:0
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0collisions:0 txqueuelen:199
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RX bytes:901236800 (859.4 MiB) =C2=
=A0TX bytes:0 (0.0 B)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Interrupt:66
>>
>>
>>
>> JM
>>

I have done some tests using two different HZ values with
CONFIG_PREEMPT_DESKTOP.
Here are the results :
With HZ=3D1000
http://picasaweb.google.com/lh/photo/ltb6hZvfssCFN0uF1iscP5MU3g7ObZTPqz=
WaaCIpUqI?feat=3Ddirectlink
With HZ=3D250
http://picasaweb.google.com/lh/photo/H9mKcM-Tarfumezbu8IJUZMU3g7ObZTPqz=
WaaCIpUqI?feat=3Ddirectlink

It seems to be related to a timer, maybe the scheduler itself...
Here is my ps result (on busybox) after the HZ=3D250 test :
PID   USER     TIME   COMMAND
    1 root       0:02 init
    2 root       0:00 [kthreadd]
    3 root       0:00 [sirq-high/0]
    4 root       0:21 [sirq-timer/0]
    5 root       0:00 [sirq-net-tx/0]
    6 root       3:08 [sirq-net-rx/0]
    7 root       0:00 [sirq-block/0]
    8 root       0:00 [sirq-block-iopo]
    9 root       1:56 [sirq-tasklet/0]
   10 root       0:00 [sirq-sched/0]
   11 root       0:00 [sirq-hrtimer/0]
   12 root       0:22 [sirq-rcu/0]
   13 root       0:00 [posixcputmr/0]
   14 root       0:00 [desched/0]
   15 root       0:00 [events/0]
   16 root       0:00 [khelper]
   19 root       0:00 [async/mgr]
   78 root       0:00 [sync_supers]
   80 root       0:00 [bdi-default]
   81 root       0:00 [kblockd/0]
  105 root       0:00 [kswapd0]
  106 root       0:00 [aio/0]
  107 root       0:00 [crypto/0]
  128 root       0:00 [mtdblockd]
  188 root       0:00 [irq/144-i2c-mpc]
  192 root       0:00 [kstriped]
  194 root       0:00 [ksnapd]
  198 root       0:00 [irq/139-mpc52xx]
  216 root       0:00 [jffs2_gcd_mtd14]
  221 root       0:00 /usr/bin/update 1
  240 root       1:00 [irq/66-wifi%d]
  257 root       0:00 [irq/133-mpc52xx]
  258 root       1:10 [irq/192-mpc52xx]
  259 root       0:00 [irq/193-mpc52xx]
  280 root       0:00 dropbear
  281 root       0:00 -/bin/sh
  308 root       0:00 ps
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
