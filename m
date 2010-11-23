From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Networking latency issue on 2.6.33.7-rt29 kernel
Date: Tue, 23 Nov 2010 18:51:14 +0100
Message-ID: <AANLkTi=7_zBakGaCys6FpLO8BbZKKX0sYb7Y6RBU8_bB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36139 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab0KWRvS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Nov 2010 12:51:18 -0500
Received: by wyb28 with SMTP id 28so8525963wyb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Nov 2010 09:51:16 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have a latency issue using the linux-2.6.33.7-rt29 kernel.
Here is my setup :

                  | Board 1| | Board 2|
PC -->   --> eth->wifi->wifi->eth -->   --> PC
         |_ tap  ----------DAG------- tap_|

The measure is done thanks to external TAP devices.

The DAG card is on another PC and does the measure.
But it is an "out of the box" measure and this is done only after I
stop the capture by merging pcap files and using timestamps.

The issue, now...

As you can see on the following two pictures, at least two events
occur during my test.
http://rostedt.homelinux.com/rt-jitter/latencies_1500us_rt_cable_noip7.=
png
http://rostedt.homelinux.com/rt-jitter/latencies_1500us_rt_cable_noip8.=
png

Each graph is representing the latency in =C2=B5s vs. the packet number=
=2E
Each packet is separated from the previous one by 1500=C2=B5s.
I don't have any IP address configured (I removed the loopback and all
other interfaces are configured using ifconfig 0.0.0.0).

The problem occurs in PREEMPT_RT and PREEMPT_DESKTOP.
The period is bigger when I change HZ (I am currently using HZ=3D1000).
Hrtimers are configured, but even when not using it, the problem is the=
 same.

I have done many many tests, removing timers, changing frequencies, etc=
=2E
I also tried to change priority of my processes associated with
sirq-rx, sirq-tx, and the interrupts.

I can't find the cause.
If you have *any* idea, thanks in advance !

Here are the timers after the test associated to the picture named
"latencies_1500us_rt_cable_noip8.png" :

Board 1 (eth -> wifi) :
-----------------------
Sample period: 1654.752 s
 1654753,     4 sirq-timer/0     hrtimer_start_range_ns (tick_sched_tim=
er)
 1655,     4 sirq-timer/0     __enqueue_rt_entity (sched_rt_period_time=
r)
 1649,    15 events/0         phy_state_machine (delayed_work_timer_fn)
 1650,    15 events/0         msleep (process_timeout)
  824,    15 events/0         msleep (process_timeout)
  275,     4 sirq-timer/0     arm_supers_timer (sync_supers_timer_fn)
  330,    80 bdi-default      bdi_forker_task (process_timeout)
 109D,    15 events/0         neigh_periodic_work (delayed_work_timer_f=
n)
  27D,    15 events/0         rt_worker_func (delayed_work_timer_fn)
   26,     4 sirq-timer/0     dev_watchdog (dev_watchdog)
   26,     4 sirq-timer/0     dev_watchdog (dev_watchdog)
   13,     4 sirq-timer/0     peer_check_expire (peer_check_expire)
    5,    15 events/0         rekey_seq_generator (delayed_work_timer_f=
n)
    2,     4 sirq-timer/0     inet_frag_secret_rebuild
(inet_frag_secret_rebuild)
   1D,     4 sirq-timer/0     rt_secret_rebuild (rt_secret_rebuild)
1661345 total events, 1003.107 events/sec

Board 2 (wifi -> eth) :
-----------------------
Sample period: 1649.636 s
 1649636,     4 sirq-timer/0     hrtimer_start_range_ns (tick_sched_tim=
er)
 1650,     4 sirq-timer/0     __enqueue_rt_entity (sched_rt_period_time=
r)
 1644,    15 events/0         phy_state_machine (delayed_work_timer_fn)
 1644,    15 events/0         msleep (process_timeout)
  822,    15 events/0         msleep (process_timeout)
  329,    80 bdi-default      bdi_forker_task (process_timeout)
  274,     4 sirq-timer/0     arm_supers_timer (sync_supers_timer_fn)
 108D,    15 events/0         neigh_periodic_work (delayed_work_timer_f=
n)
   27,     4 sirq-timer/0     dev_watchdog (dev_watchdog)
   27,     4 sirq-timer/0     dev_watchdog (dev_watchdog)
  26D,    15 events/0         rt_worker_func (delayed_work_timer_fn)
   13,     4 sirq-timer/0     peer_check_expire (peer_check_expire)
    4,    15 events/0         rekey_seq_generator (delayed_work_timer_f=
n)
    1,     4 sirq-timer/0     inet_frag_secret_rebuild
(inet_frag_secret_rebuild)
   1D,     4 sirq-timer/0     rt_secret_rebuild (rt_secret_rebuild)
1656207 total events, 1003.603 events/sec

And here is my ifconfig on each board :

Board 1 (eth -> wifi) :
-----------------------
ath0      Link encap:Ethernet  HWaddr 00:0B:6B:2F:9F:8A
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3866892 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:777245292 (741.2 MiB)

br0       Link encap:Ethernet  HWaddr 00:0B:6B:2F:9F:8A
          UP BROADCAST RUNNING NOARP  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth0      Link encap:Ethernet  HWaddr 00:10:02:0F:B8:06
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3866892 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:792712860 (755.9 MiB)  TX bytes:0 (0.0 B)
          Interrupt:133 Base address:0x3000

wifi0     Link encap:UNSPEC  HWaddr
00-0B-6B-2F-9F-8A-00-00-00-00-00-00-00-00-00-00
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3866892 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:199
          RX bytes:0 (0.0 B)  TX bytes:912586512 (870.3 MiB)
          Interrupt:66


Board 2 (wifi -> eth) :
-----------------------
ath0      Link encap:Ethernet  HWaddr 00:0B:6B:2F:A0:14
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3818800 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:767578800 (732.0 MiB)  TX bytes:0 (0.0 B)

br0       Link encap:Ethernet  HWaddr 00:0B:6B:2F:A0:14
          UP BROADCAST RUNNING NOARP  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth0      Link encap:Ethernet  HWaddr 00:10:02:0F:B8:05
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3818800 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:782854000 (746.5 MiB)
          Interrupt:133 Base address:0x3000

wifi0     Link encap:UNSPEC  HWaddr
00-0B-6B-2F-A0-14-00-00-00-00-00-00-00-00-00-00
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3818800 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:199
          RX bytes:901236800 (859.4 MiB)  TX bytes:0 (0.0 B)
          Interrupt:66

JM
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
