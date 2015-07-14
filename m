From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/6] Fix possible exit on error without releasing mutex
Date: Tue, 14 Jul 2015 23:03:11 +0200 (CEST)
Message-ID: <alpine.LFD.2.11.1507142253010.14459@riemann>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com> <1436531131-9186-3-git-send-email-jkacur@redhat.com> <20150714155959.GE21820@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:34330 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbbGNVDM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Jul 2015 17:03:12 -0400
Received: by widjy10 with SMTP id jy10so2838703wid.1
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jul 2015 14:03:11 -0700 (PDT)
In-Reply-To: <20150714155959.GE21820@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 14 Jul 2015, Sebastian Andrzej Siewior wrote:

> * John Kacur | 2015-07-10 14:25:27 [+0200]:
> 
> >diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> >index aaa36c362445..1d1cc58fae54 100644
> >--- a/src/pi_tests/pi_stress.c
> >+++ b/src/pi_tests/pi_stress.c
> >@@ -727,17 +727,24 @@ void *low_priority(void *arg)
> > 		status = pthread_barrier_wait(&p->locked_barrier);
> > 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
> > 			pi_error
> >-			    ("low_priority[%d]: pthread_barrier_wait(locked): %x\n",
> >-			     p->id, status);
> >+				("low_priority[%d]: pthread_barrier_wait(locked): %x\n",
> >+				 p->id, status);
> >+			/* release the mutex */
> >+			pi_debug("low_priority[%d]: unlocking mutex\n", p->id);
> >+			pthread_mutex_unlock(&p->mutex);
> > 			return NULL;
> > 		}
> >+
> > 		/* wait for priority boost */
> > 		pi_debug("low_priority[%d]: entering elevated wait\n", p->id);
> > 		status = pthread_barrier_wait(&p->elevate_barrier);
> > 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
> > 			pi_error
> >-			    ("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
> >-			     p->id, status);
> >+				("low_priority[%d]: pthread_barrier_wait(elevate): %x\n",
> >+				 p->id, status);
> >+			/* release the mutex */
> >+			pi_debug("low_priority[%d]: unlocking mutex\n", p->id);
> >+			pthread_mutex_unlock(&p->mutex);
> > 			return NULL;
> > 		}
> > 
> 
> What about having an out: label which does all the clean up at one spot
> instead of doing copy/paste here and there?
> 

The thought did cross my mind, there are certainly some classic parts of 
the kernel in which that provides a clean solution, but I'm not sure it's 
really better here.

We're talking about two unusual spots that basically are
line 1: print debug message
line 2: unlock the mutex
line 3: return null

With two spots that's a total of six lines, and the flow of control is 
quite clear.

Your method we have an out with 
line 1: out_label:
line 2: print debug message
line 3: unlock the mutex
line 4: return null

And then in two spots we have to do the
spot 1: goto out_label
spot 2: goto out_label

So the total number of lines is also six, but the flow of control isn't 
quite as clear.

It would make more sense if it was just part of the normal sequence in 
cleaning-up, but it isn't because for the other clean-up tasks we've
already released the mutex. Also, in case you are thinking that is a 
little odd, don't forget that this program purposely does some slightly 
odd things in order to intentionally trigger priority inversions.

That all being said, if you see a cleaner way to do this, I'll certainly
take a patch, but for now, I'm just going to supress the complaints from
the coverage tools.

John
