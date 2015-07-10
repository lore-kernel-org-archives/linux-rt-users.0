From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/6] Fix possible exit on error without releasing mutex
Date: Fri, 10 Jul 2015 14:25:27 +0200
Message-ID: <1436531131-9186-3-git-send-email-jkacur@redhat.com>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35167 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbbGJMZp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 08:25:45 -0400
Received: by wgjx7 with SMTP id x7so247801899wgj.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2015 05:25:44 -0700 (PDT)
In-Reply-To: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Coverage tools indicate that there are two spots where the function
low_priority() could exit without releasing the mutex.

Since the only error that pthread_barrier_wait is supposed to give is
EINVAL when the barrier is not an initialized barrier object, the
chances of this happinning seem remote. However, if we are going to
test for the error and potentially exit, then we should release the
mutex too.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index aaa36c362445..1d1cc58fae54 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -727,17 +727,24 @@ void *low_priority(void *arg)
 		status = pthread_barrier_wait(&p->locked_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 			pi_error
-			    ("low_priority[%d]: pthread_barrier_wait(locked): %x\n",
-			     p->id, status);
+				("low_priority[%d]: pthread_barrier_wait(locked): %x\n",
+				 p->id, status);
+			/* release the mutex */
+			pi_debug("low_priority[%d]: unlocking mutex\n", p->id);
+			pthread_mutex_unlock(&p->mutex);
 			return NULL;
 		}
+
 		/* wait for priority boost */
 		pi_debug("low_priority[%d]: entering elevated wait\n", p->id);
 		status = pthread_barrier_wait(&p->elevate_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 			pi_error
-			    ("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
-			     p->id, status);
+				("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
+				 p->id, status);
+			/* release the mutex */
+			pi_debug("low_priority[%d]: unlocking mutex\n", p->id);
+			pthread_mutex_unlock(&p->mutex);
 			return NULL;
 		}
 
-- 
1.8.3.1

