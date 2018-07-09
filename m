From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: cgroup trace events acquire sleeping locks
Date: Mon, 9 Jul 2018 22:22:15 +0200
Message-ID: <20180709202214.h2t5t3ndx6xqtrtg@linutronix.de>
References: <20180703140750.1dab75ef@tagon>
 <20180706174745.hwvnwojzfbmp7ma5@linutronix.de>
 <20180708203600.2edf24e2@tagon>
 <20180709163805.ai4ljzaj3i73ypx4@linutronix.de>
 <20180709150154.66843cba@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tglx@linutronix.de, Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709150154.66843cba@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2018-07-09 15:01:54 [-0400], Steven Rostedt wrote:
> > which is the trace_cgroup_rmdir() trace event in cgroup_rmdir(). The
> > trace event invokes cgroup_path() which acquires a spin_lock_t and this
> > is invoked within a preempt_disable()ed section. 
> 
> Correct. And I wish no trace event took spin locks.

is there an easy way to detect this? I mean instead hitting the trace
event with debug enabled and doing a review of each of them.

> > It says "Preemption disabled at" migrate_enable() but this is not true.
> > A printk() just before the lock reports preempt_count() of two and
> > sometimes one. I *think*
> > - one is from rcu_read_lock_sched_notrace() in __DO_TRACE()
> > - the second is from preempt_disable_notrace() in ring_buffer_lock_reserve()
> > 
> > I would prefer not to turn kernfs_rename_lock into raw_spin_lock_t. We
> > had a similar problem with a i915 trace event which eventually vanished
> > (and before I just disabled it).
> > 
> > So how likely are chances that we can use rcu_read_lock() in __DO_TRACE()?
> 
> Not very.

Is there a reason for this? I don't think this is documented. I changed
it to the "normal" RCU read section and it appeared to work :)

> > And how likely are chances that the preempt_disable() in
> > ring_buffer_lock_reserve() could be avoided while the trace event is
> > invoked?
> 
> Even less likely. The design of the ring buffer is based on not being
> able to be preempted.

I was expecting this.

> > I guess nothing of this is easy peasy. Any suggestions?
> > 
> 
> One solution, albeit not so pretty, is to move the grabbing of the
> path, outside the trace event. But this should work.

okay, wasn't aware of the trace_cgroup_##type##_enabled() magic. Yes,
this should work. Do you mind posting this upstream?

> -- Steve

Sebastian
