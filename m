From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.4-rc6-rt1
Date: Thu, 14 Jan 2016 15:17:44 +0100
Message-ID: <20160114141744.GB17776@linutronix.de>
References: <20151223225755.GA21121@linutronix.de>
 <20151231102441.581ce1e1@sluggy.hsv.redhat.com>
 <1451632781.9800.22.camel@gmail.com>
 <20160113175845.GK29964@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160113175845.GK29964@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Sebastian Andrzej Siewior | 2016-01-13 18:58:45 [+0100]:

>This is due to NO_HZ as far as I can tell. My AMD A10 in idle mode has
>0.7% utilisation of ksoftirqd/ with CONFIG_HZ_PERIODIC and with
>CONFIG_NO_HZ_FULL it shows about 25% on all CPU threads.

This should fixed it:

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1453,7 +1453,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	 * the base lock to check when the next timer is pending and so
 	 * we assume the next jiffy.
 	 */
-	return basej;
+	return basem + TICK_NSEC;
 #endif
 	spin_lock(&base->lock);
 	if (base->active_timers) {

Sebastian
