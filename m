From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/3] Fix latency histogram after "hrtimer: Set expiry time before
 switch_hrtimer_base()"
Date: Wed, 02 Jul 2014 15:52:22 -0400
Message-ID: <20140702195231.674381938@goodmis.org>
References: <20140702195220.872585955@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	stable-rt@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:30394 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754913AbaGBTwd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Jul 2014 15:52:33 -0400
Content-Disposition: inline; filename=0002-Fix-latency-histogram-after-hrtimer-Set-expiry-time-.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.10.44-rt46-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

In an rt-kernel with CONFIG_MISSED_TIMER_OFFSETS_HIST enabled,
__hrtimer_start_range_ns() now crashes, as new_base is not assigned
before it is used.

Tested-by: Carsten Emde <C.Emde@osadl.org>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/hrtimer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index f7a3a7a5a61b..1defbda1def8 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1102,6 +1102,11 @@ int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 #endif
 	}
 
+	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
+
+	/* Switch the timer base, if necessary: */
+	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
+
 #ifdef CONFIG_MISSED_TIMER_OFFSETS_HIST
 	{
 		ktime_t now = new_base->get_time();
@@ -1113,11 +1118,6 @@ int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	}
 #endif
 
-	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
-
-	/* Switch the timer base, if necessary: */
-	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
