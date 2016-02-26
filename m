From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [4.4-rt PATCH] trace: use rcuidle version for preemptoff_hist
 trace point
Date: Fri, 26 Feb 2016 09:54:10 -0500
Message-ID: <20160226095410.35b2aa67@gandalf.local.home>
References: <1456262603-10075-1-git-send-email-yang.shi@windriver.com>
	<20160226102513.GB8318@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, Yang Shi <yang.shi@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160226102513.GB8318@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 26 Feb 2016 11:25:13 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Steven, does this change look reasonable to you? I remember we had a
> discussion about this.

I'm still very nervous about having tracepoints in the preemptirqsoff
section. But that's not relevant to this patch.

I'm fine with it. Go ahead and apply it if it doesn't break anything ;-)

-- Steve

> 
> * Yang Shi | 2016-02-23 13:23:23 [-0800]:
> 
> >When running -rt kernel with both PREEMPT_OFF_HIST and LOCKDEP enabled,
> >the below error is reported:
> >
