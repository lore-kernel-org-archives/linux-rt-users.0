From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] net: Have __napi_schedule_irqoff() disable interrupts
 on RT
Date: Wed, 7 Dec 2016 10:10:40 +0100
Message-ID: <20161207091040.qnx3znzpffobli7c@linutronix.de>
References: <20161206175030.636989f0@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161206175030.636989f0@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-12-06 17:50:30 [-0500], Steven Rostedt wrote:
> A customer hit a crash where the napi sd->poll_list became corrupted.
> The customer had the bnx2x driver, which does a
> __napi_schedule_irqoff() in its interrupt handler. Unfortunately, when
> running with CONFIG_PREEMPT_RT_FULL, this interrupt handler is run as a
> thread and is preemptable. The call to ____napi_schedule() must be done
> with interrupts disabled to protect the per cpu softnet_data's
> poll_list, which is protected by disabling interrupts (disabling
> preemption is enough when all interrupts are threaded and
> local_bh_disable() can't preempt).
> 
> As bnx2x isn't the only driver that does this, the safest thing to do
> is to make __napi_schedule_irqoff() call __napi_schedule() instead when
> CONFIG_PREEMPT_RT_FULL is enabled, which will call local_irq_save()
> before calling ____napi_schedule().

It would work RT wise. But don't have the same problem if you boot the
kernel with threadirqs ?

Sebastian
