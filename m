From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel
 BUG at kernel/locking/rtmutex.c:997!
Date: Thu, 26 Feb 2015 09:06:10 -0500
Message-ID: <20150226090610.7eb0ac61@gandalf.local.home>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
	<1424395866-81589-2-git-send-email-tmac@hp.com>
	<20150223133719.2b7c604e@gandalf.local.home>
	<54EBC2DB.3050904@hp.com>
	<20150223195743.546b2ef0@grimm.local.home>
	<20150226135630.GD12992@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150226135630.GD12992@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 26 Feb 2015 14:56:30 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> I am not sure if we want keep doing that. The only reason why we grab
> the lock in the first place was to check if there is a timer pending
> and we run on the isolated CPU. It should not matter for the other CPUs,
> right?
> So instead going further that road, what about storing base->next_timer
> someplace so it can be obtained via atomic_read() for the isolated CPUs?
> 

If we can pull that off and remove all rtmutex trylocks from hardirq
context, I would much rather do that.

This hocus pocus coding is just going to lead us down the path of the
black arts. I already have a black cat, so I'm good to go.

-- Steve
