From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: [PATCH RT 1/2] softirq: Avoid "local_softirq_pending" messages
 if ksoftirqd is blocked
Date: Tue, 19 Feb 2019 15:58:26 +0100
Message-ID: <20190219145826.GH21785@localhost.localdomain>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

On 18/02/19 17:31, Sebastian Andrzej Siewior wrote:
> If the ksoftirqd thread has a softirq pending and is blocked on the
> `local_softirq_locks' lock then softirq_check_pending_idle() won't
> complain because the "lock owner" will mask away this softirq from the
> mask of pending softirqs.
> If ksoftirqd has an additional softirq pending then it won't be masked
> out because we never look at ksoftirqd's mask.
> 
> If there are still pending softirqs while going to idle check
> ksoftirqd's and ktimersfotd's mask before complaining about unhandled
> softirqs.
> 
> Cc: stable-rt@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I've been seeing those messages while running some stress tests (hog
tasks pinned to CPUs).

Have yet to see them after I applied this patch earlier this morning (it
usually took not much time to reproduce).

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

- Juri
