From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt] softirq: Move ksoftirqd_running() under
 !CONFIG_PREEMPT_RT_FULL
Date: Fri, 20 Jan 2017 18:21:09 +0100
Message-ID: <20170120172109.4mcissz3n65uba5a@linutronix.de>
References: <20161223163213.szj43nv7rnelkbty@linutronix.de>
 <1483172410.9872.2.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483172410.9872.2.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2016-12-31 09:20:10 [+0100], Mike Galbraith wrote:
> 
> Otherwise, ktimersoftd may not be awakened when it has work to do.

so the problem is that we have two softirq threads and we only check
the state of the "normal" one even if we would have also the schedule
the second one. 
The approach looks good, applied.

> [   84.087571] NOHZ: local_softirq_pending 02
> [   84.087593] NOHZ: local_softirq_pending 02
> [   84.087598] NOHZ: local_softirq_pending 02
> [   84.087904] NOHZ: local_softirq_pending 02
> [   84.088526] NOHZ: local_softirq_pending 02
> [   84.088899] NOHZ: local_softirq_pending 02
> [   84.089463] NOHZ: local_softirq_pending 02
> [  115.013470] NOHZ: local_softirq_pending 02
> [  115.013601] NOHZ: local_softirq_pending 02
> [  115.013709] NOHZ: local_softirq_pending 02
> 
> Signed-off-by: Mike Galbraith <efault@gmx.de>

Sebastian
