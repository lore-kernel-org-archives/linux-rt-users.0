From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH RT] fs: jbd2: pull your plug when waiting for space
Date: Tue, 11 Mar 2014 05:13:16 +0100
Message-ID: <1394511196.4896.29.camel@marge.simpson.net>
References: <20140221123253.GA12822@linutronix.de>
	 <1392990852.5451.178.camel@marge.simpson.net>
	 <20140310174718.GB6763@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx@linutronix.de
To: Theodore Ts'o <tytso@mit.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140310174718.GB6763@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2014-03-10 at 13:47 -0400, Theodore Ts'o wrote: 
> On Fri, Feb 21, 2014 at 02:54:12PM +0100, Mike Galbraith wrote:
> > 
> > ext3: dbench1 queues a buffer, blocks on journal mutex, it's plug is not
> > pulled.  dbench2 mutex owner is waiting for kjournald, who is waiting for
> > the buffer queued by dbench1.  Game over.
> 
> Where is in ext3/4 are we calling some function which could end up
> blocking on kjournald while we have the I/O queue plugged?  That
> sounds suspicious and potentially wrong.

I don't have the crash dumps and analysis handy, this was quite some
time ago.  Problem is that..

static inline void sched_submit_work(struct task_struct *tsk)
{
        if (!tsk->state || tsk_is_pi_blocked(tsk))
                return;
        /*
         * If we are going to sleep and we have plugged IO queued,
         * make sure to submit it to avoid deadlocks.
         */
        if (blk_needs_flush_plug(tsk))
                blk_schedule_flush_plug(tsk);
}

..tsk_is_pi_blocked(tsk) leaves us with IO queued, dependency on which
can (_did_ for ext[34] and xfs that I recall) end up with our waker
waiting on our IO.  There were other deadlock scenarios, not only the
one in the quoted text.

-Mike
