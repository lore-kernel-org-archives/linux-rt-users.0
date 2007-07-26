From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Question] Hooks for scheduler tracing (CFS)
Date: Thu, 26 Jul 2007 13:05:04 +0200
Message-ID: <20070726110504.GB7673@elte.hu>
References: <3efb10970707161246se06ab22i32872cfe6fa4f2f6@mail.gmail.com> <1184615557.2698.3.camel@laptopd505.fenrus.org> <20070726072858.GC13061@in.ibm.com> <20070726073520.GA12206@elte.hu> <20070726074957.GA19398@in.ibm.com> <20070726075353.GA19885@elte.hu> <20070726095948.GB19398@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arjan van de Ven <arjan@infradead.org>, linux@bohmer.net,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	mathieu.desnoyers@polymtl.ca
To: Ankita Garg <ankita@in.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:50370 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756590AbXGZLFX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 07:05:23 -0400
Content-Disposition: inline
In-Reply-To: <20070726095948.GB19398@in.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Ankita Garg <ankita@in.ibm.com> wrote:

>         local_irq_save(flags);
>         buf = _stp_chan->buf[smp_processor_id()];
>         if (unlikely(buf->offset + length > _stp_chan->subbuf_size))
>                 length = relay_switch_subbuf(buf, length);
>         memcpy(buf->data + buf->offset, data, length);
>         buf->offset += length;
>         local_irq_restore(flags);

oh, what a fine piece of s^H^H :-/ Who in their right mind calls this 
from _tracing_ code:

                smp_mb();
                if (waitqueue_active(&buf->read_wait))
                        /*
                         * Calling wake_up_interruptible() from here
                         * will deadlock if we happen to be logging
                         * from the scheduler (trying to re-grab
                         * rq->lock), so defer it.
                         */
                        __mod_timer(&buf->timer, jiffies + 1);

and the comment is utter rubbish: __mod_timer() can lock up just as 
much. Just use an adaptive-polling method to drive the draining of the 
relay buffer, instead of mucking with timers from within the tracing 
code. Whoever implemented this has absolutely zero clue i have to say 
...

the smp_mb() is rubbish too.

could you try the patch below, does it fix the problem?

	Ingo

------------------------------------->
Subject: relay: fix timer madness
From: Ingo Molnar <mingo@elte.hu>

remove timer calls (!!!) from deep within the tracing infrastructure.
This was totally bogus code that can cause lockups and worse.
Poll the buffer every 2 jiffies for now.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/relay.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

Index: linux-rt-rebase.q/kernel/relay.c
===================================================================
--- linux-rt-rebase.q.orig/kernel/relay.c
+++ linux-rt-rebase.q/kernel/relay.c
@@ -319,6 +319,10 @@ static void wakeup_readers(unsigned long
 {
 	struct rchan_buf *buf = (struct rchan_buf *)data;
 	wake_up_interruptible(&buf->read_wait);
+	/*
+	 * Stupid polling for now:
+	 */
+	mod_timer(&buf->timer, jiffies + 1);
 }
 
 /**
@@ -336,6 +340,7 @@ static void __relay_reset(struct rchan_b
 		init_waitqueue_head(&buf->read_wait);
 		kref_init(&buf->kref);
 		setup_timer(&buf->timer, wakeup_readers, (unsigned long)buf);
+		mod_timer(&buf->timer, jiffies + 1);
 	} else
 		del_timer_sync(&buf->timer);
 
@@ -604,15 +609,6 @@ size_t relay_switch_subbuf(struct rchan_
 		buf->subbufs_produced++;
 		buf->dentry->d_inode->i_size += buf->chan->subbuf_size -
 			buf->padding[old_subbuf];
-		smp_mb();
-		if (waitqueue_active(&buf->read_wait))
-			/*
-			 * Calling wake_up_interruptible() from here
-			 * will deadlock if we happen to be logging
-			 * from the scheduler (trying to re-grab
-			 * rq->lock), so defer it.
-			 */
-			__mod_timer(&buf->timer, jiffies + 1);
 	}
 
 	old = buf->data;
