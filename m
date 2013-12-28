From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [ANNOUNCE] 3.12.6-rt9
Date: Sat, 28 Dec 2013 05:33:38 +0100
Message-ID: <1388205218.5387.97.camel@marge.simpson.net>
References: <20131223225017.GA8623@linutronix.de>
	 <20131227200024.GA19505@opentech.at>
	 <1388201449.5387.70.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1388201449.5387.70.camel@marge.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2013-12-28 at 04:30 +0100, Mike Galbraith wrote:

> Watchdog barked at two such spots..

btw, lockdep doesn't grumble about that (didn't stare at annotation,
don't speak lockdep well).  I fixed it up to not take it's toys and go
home in a snit at boot (rt_mutex debug offends it methinks), but it
didn't gripe.
