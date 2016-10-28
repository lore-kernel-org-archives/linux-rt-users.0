From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Implement complete_all() with swait
Date: Fri, 28 Oct 2016 09:37:09 -0400
Message-ID: <20161028093709.2e931e34@gandalf.local.home>
References: <8d1cf9fc-4f09-7185-1cc6-a681262a20f2@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nicholas Mc Guire <der.herr@hofr.at>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d1cf9fc-4f09-7185-1cc6-a681262a20f2@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 28 Oct 2016 09:17:04 +0200
Daniel Wagner <wagi@monom.org> wrote:

> 
> So I went through the list of users and tried to identify which of them 
> is going to make troubles. I found 4 users which are using 
> complete_all() while IRQs are disabled. The rest looks like it just 
> would work nice. I already fixed up a bunch of drivers which use 
> complete_all() just to make really sure the single waiter is woken up. 
> This list does only contain proper complete_all() users.
> 

I wonder if we can just create a separate thread or workqueue that
performs the complete all, and have the callers of complete_all() that
are currently under irqs disabled simply wake up the thread/workqueue
to perform the complete_all() with interrupts enabled?

-- Steve
