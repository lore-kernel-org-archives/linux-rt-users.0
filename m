From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Problem with hrtimer_cancel() does not cancel timer
Date: Wed, 1 Mar 2017 16:01:04 +0100
Message-ID: <20170301150103.4ttnvz72d4jsgui6@linutronix.de>
References: <20170218011522.09d42119@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, zlobin_d@redlab-i.ru
To: Alexander Gerasiov <gq@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39921 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdCAPfD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Mar 2017 10:35:03 -0500
Content-Disposition: inline
In-Reply-To: <20170218011522.09d42119@brick.gerasiov.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-18 01:15:22 [+0300], Alexander Gerasiov wrote:
> Hello folks,
Hi,

> I met some problem with preempt version of kernel 4.4.
> 
> I have hrtimer which runs callback, it forwards time and returns
> HRTIMER_RESTART. Very common scheme. When I stop the routine I call
> hrtimer_cancel(). It should wait for callback completion if any and
> unqueue any future timers.

Could you please check if the hunk here fixes the problem you see?

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -455,7 +455,10 @@ static inline int hrtimer_is_queued(struct hrtimer *timer)
  */
 static inline int hrtimer_callback_running(const struct hrtimer *timer)
 {
-	return timer->base->cpu_base->running == timer;
+	if ((timer->base->cpu_base->running == timer) ||
+	    (timer->base->cpu_base->running_soft == timer))
+		return 1;
+	return 0;
 }
 
 /* Forward a hrtimer so it expires after now: */

Sebastian
