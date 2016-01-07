From: Tim Sander <tim@krieglstein.org>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Thu, 07 Jan 2016 13:15:33 +0100
Message-ID: <7338469.JKJMq5kEqn@dabox>
References: <20151223225755.GA21121@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151223225755.GA21121@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian

Thanks for your christmas present :-).

Am Mittwoch, 23. Dezember 2015, 23:57:55 schrieb Sebastian Andrzej Siew=
ior:
> Please don't continue reading before christmas eve (or morning,
> depending on your schedule). If you don't celebrate christmas,
> well go ahead.
Ok, i have to admit i am a little late to the party.
> Dear RT folks!
>=20
> I'm pleased to announce the v4.4-rc6-rt1 patch set. I tested it on my
> AMD A10, 64bit. Nothing exploded so far, filesystem is still there.
> I haven't tested it on anything else. Before someone asks: this does =
not
> mean it does *not* work on ARM I simply did not try it.
With the trivial compile patch below it is working on ARM:
Specifically two Cortex A9 on a CycloneV from Altera.

The performance without load looks good:
# Total: 100000000 100000000
# Min Latencies: 00009 00009
# Avg Latencies: 00010 00010
# Max Latencies: 00022 00033

A short run with hackbench load reveals an latency "island" from 54-69=B5=
s on the first core.
There are no timer ticks with 34 to 53 =B5s delay.
# Total: 001000000 000999714
# Min Latencies: 00010 00009
# Avg Latencies: 00017 00010
# Max Latencies: 00069 00029

I will test further and report if i find strange occurences.

> If you are brave then download it, install it and have fun. If someth=
ing
> breaks, please report it. If your machine starts blinking like a
> christmas tree while using the patch then *please* send a photo.
Sorry no photos, no special blinking.
Best regards
Tim

Signed-off-by: Tim Sander <tim@krieglstein.org>

--- linux-4.4-rc6/kernel/time/hrtimer.c.orig    2016-01-06 16:56:32.573=
527206 +0100                                                           =
                                                                       =
                                                                       =
                                                                       =
       =20
+++ linux-4.4-rc6/kernel/time/hrtimer.c 2016-01-06 16:56:48.213215320 +=
0100                                                                   =
                                                                       =
                                                                       =
                                                                       =
       =20
@@ -1435,6 +1435,7 @@                                                  =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
                                                                       =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
 #endif                                                                =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
                                                                       =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
+static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);    =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
                                                                       =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
 static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, kt=
ime_t now)                                                             =
                                                                       =
                                                                       =
                                                                       =
       =20
 {                                                                     =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
@@ -1490,8 +1491,6 @@                                                  =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
                raise_softirq_irqoff(HRTIMER_SOFTIRQ);                 =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
 }                                                                     =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
                                                                       =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
-static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer);    =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
-                                                                      =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
 #ifdef CONFIG_HIGH_RES_TIMERS                                         =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
                                                                       =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
 /*                                                                    =
                                                                       =
                                                                       =
                                                                       =
                                                                       =
       =20
