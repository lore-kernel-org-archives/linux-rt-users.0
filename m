From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: [PATCH] sched: fix RLIMIT_RTTIME when PI-boosting to RT
Date: Mon, 9 Mar 2015 19:29:11 -0400
Message-ID: <CAGt3f4=wOdCDnTR1xQA_vksom3RB3ZFSL8O1RZSXV2jqHBb-8w@mail.gmail.com>
References: <1424305436-6716-1-git-send-email-brian@peloton-tech.com>
 <CANGgnMaiiBDO=pYs2n7HbOMf58m0FOreSC8y8RmDvu-zdO+ibA@mail.gmail.com> <20150309173441.GG13768@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Austin Schuh <austin@peloton-tech.com>, mingo@redhat.com,
	peterz <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150309173441.GG13768@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Mar 9, 2015 at 1:34 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

> From what I can tell not beeing a sched guy is that the patch looks
> reasonable since the timeout gets only set to zero on enqueue_task_rt().
> Is there something special you do to trigger this?

I posted some test code with two threads and a shared PTHREAD_PRIO_INHERIT
mutex. It forces repeated priority boosting from SCHED_OTHER to SCHED_RR and
then spins for a bit while boosted. It eventually receives a SIGXCPU
on non-fixed kernels.
The SIGXCPU happens much faster with a CONFIG_PREEMPT_RT kernel, and does
happen eventually with CONFIG_PREEMPT_VOLUNTARY kernels.

>
> Sebastian

Thanks,
Brian
