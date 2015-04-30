From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: [PATCH][RT] xfs: Disable preemption when grabbing all icsb
 counter locks
Date: Thu, 30 Apr 2015 11:40:07 -0700
Message-ID: <CANGgnMZSiNXRxESzdCCU9F-aAc_sa0nfBFqSdX3t4W8ThpwVhA@mail.gmail.com>
References: <20150430123303.30f5bd12@gandalf.local.home> <20150430180721.GX5029@twins.programming.kicks-ass.net>
 <20150430143226.061202df@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Dave Chinner <david@fromorbit.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150430143226.061202df@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Apr 30, 2015 at 11:32 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 30 Apr 2015 20:07:21 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>> The irony, this is distinctly non deterministic code you're putting
>> under a RT specific preempt_disable ;-)
>
> I know :-(
>
> Unfortunately, a RT behaving fix would be much more invasive and would
> probably require the help of the xfs folks. For now, this just prevents
> a live lock that can happen and halt the system, where it becomes
> deterministic catastrophe.
>
> -- Steve

Would it work to instead create a lock to replace the
preempt_enable_rt/preempt_disable_rt pair in XFS?
