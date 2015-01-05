From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Dynamic rt_mutexes?
Date: Mon, 5 Jan 2015 14:37:19 -0500
Message-ID: <20150105143719.6a49b127@gandalf.local.home>
References: <CAF7YWnzxUr6sgULqOzJ549k3Rt2PaW56dJPXJBnMqkHSJNnAGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, mingo@kernel.org,
	RT <linux-rt-users@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Mike Holmes <mike.holmes@linaro.org>,
	Raj Murali <raj.murali@linaro.org>
To: Gary Robertson <gary.robertson@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:49879 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753459AbbAETpS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Jan 2015 14:45:18 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 19129172AF4
	for <linux-rt-users@vger.kernel.org>; Mon,  5 Jan 2015 19:37:23 +0000 (UTC)
In-Reply-To: <CAF7YWnzxUr6sgULqOzJ549k3Rt2PaW56dJPXJBnMqkHSJNnAGw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 5 Jan 2015 11:53:43 -0600
Gary Robertson <gary.robertson@linaro.org> wrote:

> As a latecomer to this list and the detailed history of RT patch
> development, I apologize if this is an old and previously discounted idea -
> but - in light of the impending discontinuation of professionally
> subsidized support for the RT patch set I felt maybe this question needs
> asking...
> 
> The transformation of kernel locking primitives via the macros in the RT
> patch set was and remains a brilliant piece of work... kudos to you all for
> that contribution!
> 
> However, as we are all painfully aware, the impact of that transformation
> on code which runs outside of a schedulable context creates a huge
> maintenance burden,
> since such code has to be modified to avoid encounters with rt_mutexes
> resulting from the
> spinlock transformation.
> 
> It occurs to me that if the behavior of the transformed locking primitives
> could be made
> more transparent then the added maintenance burden might be avoided.
> 
> The gist of the idea is that the rt_mutex code could assess at runtime
> whether the lock-seeking caller was in an execution context which could
> safely sleep, and could then behave accordingly.
> If the caller couldn't sleep then the rt_mutex code would 'spin' while
> waiting to acquire the lock,
> rather than putting the caller to sleep.  The existing 'sleeping lock'
> behavior
> would be manifested only for those callers in a schedulable context.
> 
> I think this 'dynamic waiting method' should make the lock transformation
> more or less
> transparent to existing code regardless of its execution context,
> and might yield similar improvements in latency reduction and determinism
> without having to rewrite spinlock calls made from critical sections in
> existing code.
> 
> The big question as I see it is whether the caller's schedulability can be
> determined reliably enough to support such a decision at the time the lock
> is sought...
> and I don't have comprehensive enough knowledge of the current kernel code
> to be certain this is the case - despite the presence of diagnostic macros
> to warn of
> such scenarios.
> 
> SO I thought I would quickly poll the experts as to the feasibility of such
> an approach before investing too much time in attempting to research or
> implement it.
> 
> If the caller's execution context cannot be assessed reliably enough to
> catch all possible
> 'scheduling while atomic' scenarios when the caller seeks to acquire an
> rt_mutex,
> then this approach obviously won't work.  If there are other factors I am
> missing which might
> prevent this approach from working I would appreciate a quick dismissal of
> the idea and
> - hopefully - some hints as to why it wouldn't work.

I'll answer this here. It wont work.

The problem isn't that the current runtime context we can't schedule or
not. The problem is if something did schedule that holds the lock the
current context can't schedule for. Then you are stuck. Spinning wont
help. In fact, it will just make it worse.

A lock really can't be "OK to schedule here but not OK to schedule
there". The point being, we can't spin on a lock that is held by a task
that isn't running. The system isn't designed to handle such a
paradigm. You can either always schedule out, or always spin, you can't
mix and match.

The "adaptive" locks do spin and schedule. But they can also do both in
all locations. That is, a task will spin as long as the owner of the
lock is still running, since it will probably not be worth going
through the overhead of a schedule if the running task could release it
at any moment. But once the owner goes to sleep, there's no point in
spinning (in fact, it could cause deadlocks). It must too sleep as well.

How could you have a deadlock? Well, if you never sleep, what happens
if the owner was preempted by the task that wants the lock, and the
owner is pinned to that CPU? The task that is spinning is preventing
the owner from releasing the lock, and now that task will spin forever.

This idea has come up before, and it creates more holes to the system
than it can fill.

-- Steve


> 
> BUT - if it could work - this approach might make the macro-based kernel
> lock transformation
> transparent enough to make it easier to merge into the mainstream kernel.
> 
> Thanks again for your contributions, hard work and dedication to Linux
> real-time support.
> I'll be looking forward to any replies you may offer.
> 
> Gary Robertson
> 
> Real-time engineer, Linaro Networking Group

