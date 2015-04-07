From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 7 Apr 2015 12:56:07 +0200
Message-ID: <20150407105607.GK21418@twins.programming.kicks-ass.net>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
 <1428369962-74723-1-git-send-email-tmac@hp.com>
 <1428369962-74723-2-git-send-email-tmac@hp.com>
 <20150406215959.4e8ad37b@grimm.local.home>
 <1428383383.3152.5.camel@gmail.com>
 <20150407102912.GK23123@twins.programming.kicks-ass.net>
 <1428403756.3152.56.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38531 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbbDGK4S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2015 06:56:18 -0400
Content-Disposition: inline
In-Reply-To: <1428403756.3152.56.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 07, 2015 at 12:49:16PM +0200, Mike Galbraith wrote:
> If you have a spot where it'd be nice to do that despite it being 
> somewhat (koff).. discouraged shall we say, you have to do something 
> funky.  Thomas had a patch to not raise sirq unconditionally for -rt 
> to let nohz_full work, but it needs a lock that's converted to an 
> rtmutex in -rt, and which doesn't want to be un-converted.  Ergo, get 
> funky.

I should probably back away slowly at this point.. but got a reference
to a thread that explains the 'problem'?
