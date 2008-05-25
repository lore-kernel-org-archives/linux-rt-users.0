From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] x86: enable preemption in delay
Date: Sun, 25 May 2008 14:19:21 +0100
Message-ID: <20080525141921.79c1bdc2@core>
References: <Pine.LNX.4.58.0805242306280.3977@gandalf.stny.rr.com>
	<alpine.LFD.1.10.0805251406260.3295@apollo.tec.linutronix.de>
	<Pine.LNX.4.58.0805250915410.20625@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>, akpm@osdl.org,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <clark.williams@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Gregory Haskins <ghaskins@novell.com>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54755 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752475AbYEYNdg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 May 2008 09:33:36 -0400
In-Reply-To: <Pine.LNX.4.58.0805250915410.20625@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> And what happens when we have 10GHz boxes that can do migration in 1us,
> and the delay that is asked for is 2us. We can return early.  I don't like
> to place assumptions of this kind that can hurt with future hardware
> enhancements.

Then in the hypothetical future you fix it, and for now its clearly
documented. Th preempt botch in the current tree breaks all sorts of
existing real world setups so needs to go. (and we have people who do
stuff like mdelay(150);

Alan
