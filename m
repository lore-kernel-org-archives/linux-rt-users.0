From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [ANNOUNCE] 3.0-rt4
Date: Thu, 28 Jul 2011 21:36:52 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107282123380.2660@ionos>
References: <alpine.LFD.2.02.1107272222420.2660@ionos> <4E31B59F.1000607@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Wessel <jason.wessel@windriver.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57868 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab1G1Tgz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 15:36:55 -0400
In-Reply-To: <4E31B59F.1000607@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 28 Jul 2011, Fernando Lopez-Lezcano wrote:

> On 07/27/2011 02:37 PM, Thomas Gleixner wrote:
> > Dear RT Folks,
> > 
> > I'm pleased to announce the 3.0-rt4 release.
> 
> Testing rt5 (lenovo dual core laptop running fc15, kernel based on koji's
> 3.0.0 build plus rt5)...
> ----
> [    0.000000] =============================================
> [    0.000000] [ INFO: possible recursive locking detected ]
> [    0.000000] 3.0.0-1.rt5.1.fc15.ccrma.i686.rtPAE #1
> [    0.000000] ---------------------------------------------
> [    0.000000] swapper/0 is trying to acquire lock:
> [    0.000000]  (&parent->list_lock){+.+...}, at: [<c04fb406>]
> __cache_free+0x43/0xc3
> [    0.000000]
> [    0.000000] but task is already holding lock:
> [    0.000000]  (&parent->list_lock){+.+...}, at: [<c04fc538>]
> do_tune_cpucache+0xf2/0x2bb
> [    0.000000]
> [    0.000000] other info that might help us debug this:
> [    0.000000]  Possible unsafe locking scenario:
> [    0.000000]
> [    0.000000]        CPU0
> [    0.000000]        ----
> [    0.000000]   lock(&parent->list_lock);
> [    0.000000]   lock(&parent->list_lock);

That's a know issue. Fix is being worked on. I can't find the thread
right now, but it's weird some interaction of debug options
(DEBUG_OBJECTS, DEBUG_SLAB ...) Peter ???
 
> (I guess because HIGHMEM is disabled the computer only finds 800M+ of LOWMEM
> and that is all top reports - total installed is 4G)

Yes, that's the state for now until someone fixes it :)

Thanks,

	tglx
