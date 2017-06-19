From: Mike Galbraith <efault@gmx.de>
Subject: Re: [ANNOUNCE] v4.11.5-rt1
Date: Mon, 19 Jun 2017 18:29:44 +0200
Message-ID: <1497889784.15817.17.camel@gmx.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
         <1497687277.6908.31.camel@gmx.de>
         <20170619085206.n2n22lpdfsoqbp5m@linutronix.de>
         <1497867291.19618.52.camel@gmx.de>
         <20170619100838.343faaee@gandalf.local.home>
         <20170619141341.m243ivutmwlzyhc4@linutronix.de>
         <20170619104131.05fdc76f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170619104131.05fdc76f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-06-19 at 10:41 -0400, Steven Rostedt wrote:
> On Mon, 19 Jun 2017 16:13:41 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> 
> > > Hmm, it shouldn't affect futexes, as it's only called by rtmutex when
> > > waiter->savestate is true. And that should always be false for futex.  
> > 
> > you still have sleeping locks like the hb-lock (which might matter in
> > case the task blocks on the lock and does not continue for some reason).
> 
> But then I'd expect this to be an issue with any spinlock in the kernel.

Thing to do is set a trap for the bugger.  I'll give that a go after I
get some beans/biscuits work done.  For the nonce, what I've reported
is all I know.

	-Mike
