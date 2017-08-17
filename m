From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] hotplug, hrtimer: Migrate expired/deferred timers
 during cpu offline
Date: Thu, 17 Aug 2017 19:17:21 +0200
Message-ID: <20170817171720.jz2ok332bpxcjzme@linutronix.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
 <1501913583.7917.42.camel@gmx.de>
 <1501945043.5473.31.camel@gmx.de>
 <20170807073350.nwytftryfp34mrwi@linutronix.de>
 <1502094121.5568.22.camel@gmx.de>
 <1502186459.8042.31.camel@gmx.de>
 <1502438116.16425.18.camel@gmx.de>
 <1502439312.16425.19.camel@gmx.de>
 <1502697588.12319.199.camel@gmx.de>
 <20170817165041.3agf2btidfdcspiq@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170817165041.3agf2btidfdcspiq@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-17 18:50:42 [+0200], To Mike Galbraith wrote:
> __remove_hrtimer() shouldn't be required because it has been done
> already. It should be enough to just list_splice() one list to the
> other and raise the softirq afterwards.

Mike, can you check this please:

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 55839ff2bba6..4b9264e0d363 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1802,6 +1802,11 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 		 */
 		enqueue_hrtimer(timer, new_base);
 	}
+#ifdef CONFIG_PREEMPT_RT_BASE
+	list_splice_tail(&old_base->expired, &new_base->expired);
+	if (!list_empty(&new_base->expired))
+		raise_softirq_irqoff(HRTIMER_SOFTIRQ);
+#endif
 }
 
 int hrtimers_dead_cpu(unsigned int scpu)
-- 
2.13.2

Sebastian
