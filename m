From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: [PATCH] Re: mq_timedrecieve timeout accuracy
Date: Mon, 29 Mar 2010 17:08:25 +0200
Message-ID: <4BB0C269.9050408@osadl.org>
References: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>	 <8226231.1269436934345.JavaMail.ngmail@webmail10.arcor-online.net>	 <6d09081c1003240637w28ee6861tfcef4c7876ef3e40@mail.gmail.com>	 <6d09081c1003240703o19ad3dffx20abae9d15e2d0b@mail.gmail.com> <6d09081c1003240846s31fa5917p470f8936a39662f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000504090000040206040601"
Cc: "M. Koehrer" <mathias_koehrer@arcor.de>,
	linux-rt-users@vger.kernel.org, rachana.rao@in.abb.com,
	Thomas Gleixner <tglx@linutronix.de>
To: Pradyumna Sampath <pradysam@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:40798 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753202Ab0C2PKS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Mar 2010 11:10:18 -0400
In-Reply-To: <6d09081c1003240846s31fa5917p470f8936a39662f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000504090000040206040601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Prady,

> [..] Ok, as promised.
> 
> Here is a dirty hack that I made which basically resulted in 2 things.
> 1) My test programs accurace really really improved. The timeout on
> the mq_timedrecieve this time around within the tune of 20-30uS.
> 2) My actual application exploded all over the place, with mq_*
> functions complaining of timing out etc etc .. Just a bad messup.
> 
> So (1) confirms that sched_hrtimeout could be a good idea. (2)
> Confirms that this patch is really terrible and it would be great if
> someone could either come up with something that is more robust or I
> will be happy to take suggestions on where and how I should make
> changes.
Does the attached patch work for you?

- Fixed error handling
- Replaced schedule_timeout() with schedule_hrtimeout()
- Let schedule_hrtimeout() handle expired timers

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

--------------000504090000040206040601
Content-Type: text/x-patch;
 name="fix-mqueue-and-use-hrtimer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fix-mqueue-and-use-hrtimer.patch"

--- ipc/mqueue-orig.c	2010-03-29 13:59:14.410923036 +0200
+++ ipc/mqueue.c	2010-03-29 16:38:51.650616863 +0200
@@ -428,10 +428,16 @@
  * sr: SEND or RECV
  */
 static int wq_sleep(struct mqueue_inode_info *info, int sr,
-			long timeout, struct ext_wait_queue *ewp)
+			struct timespec *timeout, struct ext_wait_queue *ewp)
 {
 	int retval;
 	signed long time;
+	ktime_t *expires = NULL, to;
+
+	if (timeout != NULL) {
+		to = timespec_to_ktime(*timeout);
+		expires = &to;
+	}
 
 	wq_add(info, sr, ewp);
 
@@ -439,7 +445,7 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		spin_unlock(&info->lock);
-		time = schedule_timeout(timeout);
+		time = schedule_hrtimeout(expires, HRTIMER_MODE_ABS);
 
 		while (ewp->state == STATE_PENDING)
 			cpu_relax();
@@ -551,33 +557,6 @@
 	wake_up(&info->wait_q);
 }
 
-static long prepare_timeout(struct timespec *p)
-{
-	struct timespec nowts;
-	long timeout;
-
-	if (p) {
-		if (unlikely(p->tv_nsec < 0 || p->tv_sec < 0
-			|| p->tv_nsec >= NSEC_PER_SEC))
-			return -EINVAL;
-		nowts = CURRENT_TIME;
-		/* first subtract as jiffies can't be too big */
-		p->tv_sec -= nowts.tv_sec;
-		if (p->tv_nsec < nowts.tv_nsec) {
-			p->tv_nsec += NSEC_PER_SEC;
-			p->tv_sec--;
-		}
-		p->tv_nsec -= nowts.tv_nsec;
-		if (p->tv_sec < 0)
-			return 0;
-
-		timeout = timespec_to_jiffies(p) + 1;
-	} else
-		return MAX_SCHEDULE_TIMEOUT;
-
-	return timeout;
-}
-
 static void remove_notification(struct mqueue_inode_info *info)
 {
 	if (info->notify_owner != NULL &&
@@ -861,7 +840,6 @@
 	struct msg_msg *msg_ptr;
 	struct mqueue_inode_info *info;
 	struct timespec ts, *p = NULL;
-	long timeout;
 	int ret;
 
 	if (u_abs_timeout) {
@@ -875,7 +853,6 @@
 		return -EINVAL;
 
 	audit_mq_sendrecv(mqdes, msg_len, msg_prio, p);
-	timeout = prepare_timeout(p);
 
 	ret = -EBADF;
 	filp = fget(mqdes);
@@ -912,14 +889,17 @@
 		if (filp->f_flags & O_NONBLOCK) {
 			spin_unlock(&info->lock);
 			ret = -EAGAIN;
-		} else if (unlikely(timeout < 0)) {
-			spin_unlock(&info->lock);
-			ret = timeout;
 		} else {
-			wait.task = current;
-			wait.msg = (void *) msg_ptr;
-			wait.state = STATE_NONE;
-			ret = wq_sleep(info, SEND, timeout, &wait);
+			if (p && unlikely(ts.tv_nsec < 0 || ts.tv_sec < 0 ||
+			    ts.tv_nsec >= NSEC_PER_SEC)) {
+				spin_unlock(&info->lock);
+                	        ret = -EINVAL;
+			} else {
+				wait.task = current;
+				wait.msg = (void *) msg_ptr;
+				wait.state = STATE_NONE;
+				ret = wq_sleep(info, SEND, p, &wait);
+			}
 		}
 		if (ret < 0)
 			free_msg(msg_ptr);
@@ -947,7 +927,6 @@
 		size_t, msg_len, unsigned int __user *, u_msg_prio,
 		const struct timespec __user *, u_abs_timeout)
 {
-	long timeout;
 	ssize_t ret;
 	struct msg_msg *msg_ptr;
 	struct file *filp;
@@ -964,7 +943,6 @@
 	}
 
 	audit_mq_sendrecv(mqdes, msg_len, 0, p);
-	timeout = prepare_timeout(p);
 
 	ret = -EBADF;
 	filp = fget(mqdes);
@@ -991,16 +969,17 @@
 		if (filp->f_flags & O_NONBLOCK) {
 			spin_unlock(&info->lock);
 			ret = -EAGAIN;
-			msg_ptr = NULL;
-		} else if (unlikely(timeout < 0)) {
-			spin_unlock(&info->lock);
-			ret = timeout;
-			msg_ptr = NULL;
 		} else {
-			wait.task = current;
-			wait.state = STATE_NONE;
-			ret = wq_sleep(info, RECV, timeout, &wait);
-			msg_ptr = wait.msg;
+			if (p && unlikely(ts.tv_nsec < 0 || ts.tv_sec < 0 ||
+			    ts.tv_nsec >= NSEC_PER_SEC)) {
+				spin_unlock(&info->lock);
+                	        ret = -EINVAL;
+			} else {
+				wait.task = current;
+				wait.state = STATE_NONE;
+				ret = wq_sleep(info, RECV, p, &wait);
+				msg_ptr = wait.msg;
+			}
 		}
 	} else {
 		msg_ptr = msg_get(info);

--------------000504090000040206040601--
