From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Mon, 20 Nov 2017 13:43:54 +0100
Message-ID: <1511181834.11475.41.camel@gmx.de>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>
         <20171117145744.t366d2ztxj2qqnco@linutronix.de>
         <1511030230.12841.42.camel@gmx.de>
         <20171120105310.zsd6kotreig6nvik@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171120105310.zsd6kotreig6nvik@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-11-20 at 11:53 +0100, Sebastian Siewior wrote:
> 
> To your question whether or not delaying IO can cause any deadlocks is
> something that I can't answer and this something that would affect !RT,
> too. I tried to add lockdep to bit-spinlocks but this does not work
> because one context acquires the lock and another does the unlock. It
> has been explained to me that no deadlocks should happen as long as
> the IO is flushed before we block/wait on a lock.

That wasn't the question (guess I didn't formulate it well).  What I
was concerned about was the possibility that the situation that caused
me to add that __migrate_disabled() qualifier might arise anew, but
with different players.

At the time, I had to add that qualifier to prevent ABBA between the
owner of q->queue_lock, who was blocked by a lock ALREADY held by the
task trying to pull its plug, who then met the locked q->queue_lock.
 Ergo the less than perfect hack to only allow pulling the plug when
NOT YET holding a spinlock.  The problem was converted spinlocks (and
added RT locks).

	-Mike
