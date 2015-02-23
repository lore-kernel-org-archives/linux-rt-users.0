From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel
 BUG at kernel/locking/rtmutex.c:997!
Date: Mon, 23 Feb 2015 13:37:19 -0500
Message-ID: <20150223133719.2b7c604e@gandalf.local.home>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
	<1424395866-81589-2-git-send-email-tmac@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Thavatchai Makphaibulchoke <tmac@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424395866-81589-2-git-send-email-tmac@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 19 Feb 2015 18:31:05 -0700
Thavatchai Makphaibulchoke <tmac@hp.com> wrote:

> This patch fixes the problem that the ownership of a mutex acquired by an
> interrupt handler(IH) gets incorrectly attributed to the interrupted thread.
> 
> This could result in an incorrect deadlock detection in function
> rt_mutex_adjust_prio_chain(), causing thread to be killed and possibly leading
> up to a system hang.
> 
> Here is the approach taken: when calling from an interrupt handler, instead of
> attributing ownership to the interrupted task, use a reserved task_struct value
> to indicate that the owner is a interrupt handler.  This approach avoids the
> incorrect deadlock detection.
> 
> This also includes changes in several function in rtmutex.c now that the lock's
> requester may be a interrupt handler, not a real task struct.  This impacts
> the way how the lock is acquired and prioritized and decision whether to do
> the house keeping functions required for a real task struct.
> 
> The reserved task_struct values for interrupt handler are
> 
> 	current | 0x2
> 
> where current is the task_struct value of the interrupted task.
> 
> Since IH will both acquire and release the lock only during an interrupt
> handling, during which current is not changed, the reserved task_struct value
> for an IH should be distinct from another instances of IH on a different cpu.
> 
> Kernel version 3.14.25 + patch-3.14.25-rt22
> 
> Signed-off-by: T. Makphaibulchoke <tmac@hp.com>

OK, I believe I understand the issue. Perhaps it would be much better
to create a fake task per CPU that we use when grabbing locks in
interrupt mode. And make these have a priority of 0 (highest), since
they can not be preempted, they do have such a priority.

Then in the fast trylock and unlock code, we can add:

	struct task_struct *curr = current;

	if (unlikely(in_irq()))
		curr = this_cpu_read(irq_task);

This way the priority inheritance will stop when it hits this task (no
need to boost a task of highest priority), and we can leave that code
alone.

-- Steve
