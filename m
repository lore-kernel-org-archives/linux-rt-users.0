From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] seqlock/rt: Prevent livelocks with seqlocks in RT
Date: Tue, 06 Mar 2012 07:17:37 -0500
Message-ID: <1331036257.25686.365.camel@gandalf.stny.rr.com>
References: <1331006584.25686.362.camel@gandalf.stny.rr.com>
	 <alpine.LFD.2.02.1203060911000.2742@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>, Carsten Emde <cbe@osadl.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1203060911000.2742@ionos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2012-03-06 at 09:18 +0100, Thomas Gleixner wrote:

> Errm. rt15 has 
> 
> /*
>  * Starvation safe read side for RT
>  */
> static inline unsigned read_seqbegin(seqlock_t *sl)
> {
>         unsigned ret;
> 
> repeat:
>         ret = sl->seqcount.sequence;
>         if (unlikely(ret & 1)) {
>                 /*
>                  * Take the lock and let the writer proceed (i.e. evtl
>                  * boost it), otherwise we could loop here forever.
>                  */
>                 spin_lock(&sl->lock);
>                 spin_unlock(&sl->lock);
>                 goto repeat;
>         }
>         return ret;
> }
> #endif

You're right it does!

I didn't see this as the lock up showed it was locked up in
read_seqcount_begin(), it was late and I was tired.

Here's the real fix then:

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 723274d..29ffd4f 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -177,7 +177,7 @@ typedef struct {
 /*
  * Read side functions for starting and finalizing a read side section.
  */
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPT_RT_FULL
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
 	return read_seqcount_begin(&sl->seqcount);
