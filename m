From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [ANNOUNCE] 4.8-rc5-rt1 beta
Date: Sun, 2 Oct 2016 19:35:15 -0400
Message-ID: <20161002233515.GA18997@windriver.com>
References: <20160906182508.GB9950@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160906182508.GB9950@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[[ANNOUNCE] 4.8-rc5-rt1 beta] On 06/09/2016 (Tue 14:25) Paul Gortmaker wrote:

> This is a carry forward of the -rt patches off v4.6.7-rt11 through
> mainline commits of v4.7 and up to the current v4.8-rc5.
> 
> https://git.kernel.org/cgit/linux/kernel/git/paulg/4.8-rt-patches.git
> 

[...]

> 
>   Patch conflicts/issues of interest 4.7 --> 4.8
>   ----------------------------------------------
> 

-mainline changed the qdisc from a simple bit to a seqcount; this causes
 a splat from migrate_enable, but I didn't initially see that since the
 sanity check relies on SCHED_DEBUG=y.  This causes the -rt patch that
 faked out the lock status to splat; further details are at kernel.org:

	https://goo.gl/0fdRKR

No point in anyone else having to redo the root cause research on this a
second time;  I've updated the above repo for this and for some other mm
fallout from 4.8-rc7 in memcontrol.c so that the patches will apply for
what inevitably becomes v4.8 final in a couple hours.

That said, my original comments still apply -- this remains as a resource
for developers who track the -rt progress, and how mainline will impact
it.  The release of 4.8 in mainline does not somehow change this repo
into a stable/supported -rt release by osmosis.  If you don't regularly
manually apply and test patches, including resolving sleeping while
atomic kernel backtrace dumps, you probably should not be using this.

Paul.
