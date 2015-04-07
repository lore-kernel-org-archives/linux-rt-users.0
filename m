From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 07 Apr 2015 13:01:24 +0200
Message-ID: <1428404484.3152.58.camel@gmail.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
	 <1428369962-74723-1-git-send-email-tmac@hp.com>
	 <1428369962-74723-2-git-send-email-tmac@hp.com>
	 <20150406215959.4e8ad37b@grimm.local.home>
	 <1428383383.3152.5.camel@gmail.com>
	 <20150407102912.GK23123@twins.programming.kicks-ass.net>
	 <1428403756.3152.56.camel@gmail.com>
	 <20150407105607.GK21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150407105607.GK21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-04-07 at 12:56 +0200, Peter Zijlstra wrote:
> On Tue, Apr 07, 2015 at 12:49:16PM +0200, Mike Galbraith wrote:
> > If you have a spot where it'd be nice to do that despite it being 
> > somewhat (koff).. discouraged shall we say, you have to do 
> > something 
> > funky.  Thomas had a patch to not raise sirq unconditionally for -
> > rt 
> > to let nohz_full work, but it needs a lock that's converted to an 
> > rtmutex in -rt, and which doesn't want to be un-converted.  Ergo, 
> > get 
> > funky.
> 
> I should probably back away slowly at this point.. but got a 
> reference
> to a thread that explains the 'problem'?

https://lkml.org/lkml/2015/4/6/434
