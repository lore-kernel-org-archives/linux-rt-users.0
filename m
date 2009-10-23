From: Dinakar Guniguntala <dino@in.ibm.com>
Subject: [patch -rt] Fix infinite loop with 2.6.31.4-rt14 V2
Date: Sat, 24 Oct 2009 01:38:58 +0530
Message-ID: <20091023200858.GA7011@in.ibm.com>
References: <20091023134700.GA5578@in.ibm.com> <4AE1D802.6050906@us.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56982 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829AbZJWUJA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 23 Oct 2009 16:09:00 -0400
Content-Disposition: inline
In-Reply-To: <4AE1D802.6050906@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Application threads calling futex_wait_requeue_pi run in an infinite loop
in the kernel if the futex value changes during the call. The following
patch fixes the problem.

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Darren Hart <dvhltc@us.ibm.com>

---
 kernel/futex.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6.31.4-rt14-lbf-f1/kernel/futex.c
===================================================================
--- linux-2.6.31.4-rt14-lbf-f1.orig/kernel/futex.c
+++ linux-2.6.31.4-rt14-lbf-f1/kernel/futex.c
@@ -2188,6 +2188,12 @@ retry:
 	spin_lock(&hb->lock);
 	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
 	spin_unlock(&hb->lock);
+	if (ret == -EAGAIN) {
+		/* Retry on spurious wakeup */
+		put_futex_key(fshared, &q.key);
+		put_futex_key(fshared, &key2);
+		goto retry;
+	}
 	if (ret)
 		goto out_put_keys;
 
@@ -2264,9 +2270,6 @@ out_put_keys:
 out_key2:
 	put_futex_key(fshared, &key2);
 
-	/* Spurious wakeup ? */
-	if (ret == -EAGAIN)
-		goto retry;
 out:
 	if (to) {
 		hrtimer_cancel(&to->timer);
