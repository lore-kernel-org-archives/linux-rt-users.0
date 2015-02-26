From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel
 BUG at kernel/locking/rtmutex.c:997!
Date: Thu, 26 Feb 2015 14:56:30 +0100
Message-ID: <20150226135630.GD12992@linutronix.de>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
 <1424395866-81589-2-git-send-email-tmac@hp.com>
 <20150223133719.2b7c604e@gandalf.local.home>
 <54EBC2DB.3050904@hp.com>
 <20150223195743.546b2ef0@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150223195743.546b2ef0@grimm.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2015-02-23 19:57:43 [-0500]:

>On Mon, 23 Feb 2015 17:16:27 -0700
>Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com> wrote:
>> If I'm not mistaken, another reason could also be due to the rate of the
>> timer interrupt, in the case that the mutex is highly contested IH could
>> stall the non-real-time requester for a long time, even to the point of
>> the cpu is perceived as hung.
>
>Perhaps we should just have trylocks fail if there are other waiters.
>As it wont slow down the high priority task. And doing that would
>probably even help other rt tasks that are blocked on the lock waiting
>for a release. Why make those tasks wait more if even a higher priority
>task is simply doing a trylock and can safely fail it. At least we
>could do that if the task trying to get the lock is a interrupt.

What happened so far? The events I remember:
- we gained FULL_NO_HZ
- people started to isolate CPUs and push their work / RT tasks there
- it has been noticed that the kernel is raising the timer softirq even
  there is nothing going on once the softirq was started.
- tglx came with a patch which could go mainline if solves the problem.
- this patch did not make its way upstream (yet) and I pulled it into
  -RT. Isn't this a problem in mainline, too? Why isn't there anyone
  screaming?
- we had dead locks because the inner-lock of the sleeping was not safe
  to be used from hardirq context. #1
- we had boxes freezing on startup and not making progress due to missed
  irq_work wakeups. #2
- we had a deadlock splat on UP because the trylock failed. This was
  fixed by only allowing this feature on SMP (since it only makes sense
  with isolated CPUs). #3
- Now since the rtmutex rework we have dead lock splats which BUG()s the
  systems. #4

The four problems we had/have so far are -RT specific but still
plainfull when I think back.
rtmutex wasn't made to be accessed from hardirq context. That is where we
use the rawlocks. One problem that we still have and Peter pointer out
around #1 is about owner boosting if the lock is held in hardirq context
and the wrong owner is recorded. This problem was ignored so far.

Using a fake task as you suggest in irq context and ignoring would
somehow fix the boosting problem and avoid the deadlock we see now.

I am not sure if we want keep doing that. The only reason why we grab
the lock in the first place was to check if there is a timer pending
and we run on the isolated CPU. It should not matter for the other CPUs,
right?
So instead going further that road, what about storing base->next_timer
someplace so it can be obtained via atomic_read() for the isolated CPUs?

>-- Steve

Sebastian
