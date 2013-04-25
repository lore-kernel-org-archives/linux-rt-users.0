From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.4.41-rt55-feat1
Date: Thu, 25 Apr 2013 14:36:14 +0200
Message-ID: <1366893374.6139.5.camel@marge.simpson.net>
References: <1366760662.9609.176.camel@gandalf.local.home>
	 <2156546.QlsX0XyPQz@dabox> <51792277.8000205@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Tim Sander <tim.sander@hbm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51792277.8000205@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2013-04-25 at 14:32 +0200, Sebastian Andrzej Siewior wrote: 
> On 04/25/2013 01:14 PM, Tim Sander wrote:
> > Hi 
> > 
> > I just wanted to test this release but it fails to compile with the the 
> > following error:
> > 
> > kernel/hrtimer.c: In function '__hrtimer_start_range_ns':
> > kernel/hrtimer.c:1045:7: error: implicit declaration of function 
> > 'hrtimer_rt_defer'
> > kernel/hrtimer.c: At top level:
> > kernel/hrtimer.c:1416:12: error: static declaration of 'hrtimer_rt_defer' 
> > follows non-static declaration
> > kernel/hrtimer.c:1045:10: note: previous implicit declaration of 
> > 'hrtimer_rt_defer' was here
> > 
> > The kernelconfig is attached.
> 
> You do not have CONFIG_HIGH_RES_TIMERS defined. Is this on purpose?

git@marge:~/linux-2.6> ls -1 arch/arm/configs|wc -l
122
git@marge:~/linux-2.6> grep -IR CONFIG_HIGH_RES_TIMERS arch/arm/configs|wc -l
31

Oh.  Sniff, poor little things.

hrtimer: fix hrtimer free zone build bug

Signed-off-by: Mike Galbraith <bitbucket@online.de>

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 2328c04..31d57a2 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1036,7 +1036,7 @@ int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 		&& hrtimer_enqueue_reprogram(timer, new_base)) {
 
 		if (wakeup
-#ifdef CONFIG_PREEMPT_RT_BASE
+#if defined(CONFIG_PREEMPT_RT_BASE) && defined(CONFIG_HIGH_RES_TIMERS)
 		    /*
 		     * Move softirq based timers away from the rbtree in
 		     * case it expired already. Otherwise we would have a
