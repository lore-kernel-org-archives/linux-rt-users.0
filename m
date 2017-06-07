From: Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT V2] sched: Prevent task state corruption by spurious
 lock wakeup
Date: Wed, 7 Jun 2017 22:18:50 +0200
Message-ID: <20170607201849.6a7jfpdmtwqwfvfh@linutronix.de>
References: <alpine.DEB.2.20.1706021834070.1899@nanos>
 <alpine.DEB.2.20.1706030940220.2228@nanos>
 <alpine.DEB.2.20.1706061412290.1885@nanos>
 <alpine.DEB.2.20.1706061419150.1885@nanos>
 <20170606162815.jdurd7xa75fw57g7@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathias Koehrer <mathias.koehrer@etas.com>,
        David Hauck <davidh@netacquire.com>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170606162815.jdurd7xa75fw57g7@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-06 18:28:15 [+0200], Peter Zijlstra wrote:
> Subject: sched: Remove TASK_ALL
> 
> It's unused:
> 
> $ git grep "\<TASK_ALL\>" | wc -l
> 1
> 
> And dangerous, kill the bugger.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied for RT but please take this upstream, too.

Sebastian
