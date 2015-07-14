From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/6] Fix possible exit on error without releasing mutex
Date: Tue, 14 Jul 2015 17:59:59 +0200
Message-ID: <20150714155959.GE21820@linutronix.de>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
 <1436531131-9186-3-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:32973 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbbGNQAA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 12:00:00 -0400
Content-Disposition: inline
In-Reply-To: <1436531131-9186-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* John Kacur | 2015-07-10 14:25:27 [+0200]:

>diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
>index aaa36c362445..1d1cc58fae54 100644
>--- a/src/pi_tests/pi_stress.c
>+++ b/src/pi_tests/pi_stress.c
>@@ -727,17 +727,24 @@ void *low_priority(void *arg)
> 		status = pthread_barrier_wait(&p->locked_barrier);
> 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
> 			pi_error
>-			    ("low_priority[%d]: pthread_barrier_wait(locked): %x\n",
>-			     p->id, status);
>+				("low_priority[%d]: pthread_barrier_wait(locked): %x\n",
>+				 p->id, status);
>+			/* release the mutex */
>+			pi_debug("low_priority[%d]: unlocking mutex\n", p->id);
>+			pthread_mutex_unlock(&p->mutex);
> 			return NULL;
> 		}
>+
> 		/* wait for priority boost */
> 		pi_debug("low_priority[%d]: entering elevated wait\n", p->id);
> 		status = pthread_barrier_wait(&p->elevate_barrier);
> 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
> 			pi_error
>-			    ("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
>-			     p->id, status);
>+				("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
>+				 p->id, status);
>+			/* release the mutex */
>+			pi_debug("low_priority[%d]: unlocking mutex\n", p->id);
>+			pthread_mutex_unlock(&p->mutex);
> 			return NULL;
> 		}
> 

What about having an out: label which does all the clean up at one spot
instead of doing copy/paste here and there?

Sebastian
