From: Gratian Crisan <gratian.crisan@ni.com>
Subject: Re: [PATCH RT] time/hrtimer: Use softirq based wakeups for non-RT threads
Date: Thu, 05 Oct 2017 16:14:49 -0500
Message-ID: <87d161pa9i.fsf@kerf.amer.corp.natinst.com>
References: <20171004160820.27754-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gratian Crisan <gratian.crisan@ni.com>,
        Piotr Gregor <piotrgregor@rsyncme.org>, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171004160820.27754-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Sebastian Andrzej Siewior writes:

> Normal wake ups (like clock_nanosleep()) which are performed by normal
> users can easily lead to 2ms latency spikes if (enough) hrtimer wakeups
> are synchronized.
> This patch moves all hrtimers wakeups to the softirq queue unless the
> caller has a RT priority.
>
> Reported-by: Gratian Crisan <gratian.crisan@ni.com>

I can confirm this patch fixes the original problem reported.

I ran an overnight test (about 30 hours total) on two platforms using
cyclictest + hrtimer stress load: configurable number of SCHED_OTHER
threads doing random clock_nanosleep() in up to 1 mS intervals.

Without this patch the max latency recorded was:
  * on dual core, Intel Atom E3825 @ 1.33GHz: 107 uS
  * on dual core, Zynq 7020 @ 667MHz: 261 uS

With this patch the max numbers drop to:
  * on dual core, Intel Atom E3825 @ 1.33GHz: 66 uS
  * on dual core, Zynq 7020 @ 667MHz: 90 uS

The max latency numbers with this patch are in-line with expectations
for these platforms.

Thank you so much,
-Gratian
