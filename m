From: Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [patch RT 0/4] rwsem/rt: Lift the single reader restriction
Date: Tue, 4 Apr 2017 16:01:02 +0200
Message-ID: <20170404140102.t3u3hki6y2gtltzm@linutronix.de>
References: <20170401105058.958246042@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: LKML <linux-kernel@vger.kernel.org>,
        RT-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Wargreen <wargreen@lebib.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170401105058.958246042@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-04-01 12:50:58 [+0200], Thomas Gleixner wrote:
> R/W semaphores in RT do not allow multiple readers because a writer
> blocking on the sempahore would have deal with all the readers in terms of
> priority or budget inheritance. While multi reader priority boosting would
> be possible (it has been attempted before), multi reader budget inheritance
> is impossible.
…
> It cures the Radeon mess, lowers the contention on mmap_sem for certain
> workloads and did not have any negative impact in our initial testing on RT
> behaviour.
> 
> I think it's worth to expose it to a wider audience of users for testing,
> so we can figure out it whether there are dragons lurking.

series applied.

> Thanks,
> 
> 	tglx

Sebastian
