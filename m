From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 5/5] allow preemption in slab_alloc_node and slab_free
Date: Fri, 14 Feb 2014 15:07:29 +0100
Message-ID: <20140214140729.GI28438@linutronix.de>
References: <20140210154016.GF20017@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140210154016.GF20017@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Nicholas Mc Guire | 2014-02-10 16:40:16 [+0100]:

>__slab_alloc is only called from slub.c:slab_alloc_node
>it runs with local irqs disabled so it can't be pushed off this CPU
>asynchronously, the preempt_disable/enable is thus not needed.
>Aside from that the later this_cpu_cmpxchg_double would catch such a 
>migration event anyay.

Not sure what to do with this one. You do write a longer chapter why it
is okay to drop the preemption disable section and that
this_cpu_cmpxchg_double() would catch it. And I didn't figure out so
far why need to keep preemption disabled while looking at c->tid but not
at c->page.
However, it seems that Christoph Lameter found it important to add a
note in the comment that this preemption disable here is important.
Looking at commit 7cccd80 ("slub: tid must be retrieved from the percpu
area of the current processor") it seems that Steven Rostedt run into
trouble and now we have that preemption_disable() here.

So if you really get better performance and you haven't seen anything
bad happen then you might want to check with Lameter & Rostedt about
your patch and getting it merged upstream.
The commit I mentioned is upstream since v3.11-rc1 and I can see it in
v3.8-RT tree so it looks serious.
I fail to see it in v3.2-RT, Steven, isn't this something we want there,
too?

Sebastian
