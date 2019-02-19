From: Juri Lelli <juri.lelli@gmail.com>
Subject: Re: [PATCH RT 1/2] softirq: Avoid "local_softirq_pending" messages
 if ksoftirqd is blocked
Date: Tue, 19 Feb 2019 17:27:41 +0100
Message-ID: <20190219162741.GI21785@localhost.localdomain>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190219145826.GH21785@localhost.localdomain>
 <20190219160606.jwjrgf6nxarnd2wt@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219160606.jwjrgf6nxarnd2wt@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 19/02/19 17:06, Sebastian Andrzej Siewior wrote:
> On 2019-02-19 15:58:26 [+0100], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > I've been seeing those messages while running some stress tests (hog
> > tasks pinned to CPUs).
> > 
> > Have yet to see them after I applied this patch earlier this morning (it
> > usually took not much time to reproduce).
> 
> So is it better or not. I kind of read this as "nothing changed".

It is better. Warning message doesn't appear anymore.
