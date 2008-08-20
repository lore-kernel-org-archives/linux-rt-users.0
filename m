From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rt Kconfig.preempt fixes
Date: Wed, 20 Aug 2008 12:10:13 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0808201207470.27481@gandalf.stny.rr.com>
References: <520f0cf10808010639y4c1a19a7kff429827d26dc8e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: John Kacur <jkacur@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760006AbYHTQLJ@vger.kernel.org>
In-Reply-To: <520f0cf10808010639y4c1a19a7kff429827d26dc8e9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Fri, 1 Aug 2008, John Kacur wrote:

> This is a non-critical patch, that makes configuring an rt kernel a
> little nicer.
> Comments are welcome of course.
> 
> Signed-off-by: John Kacur <jkacur at gmail dot com>
> 
> This patch makes the following changes.
> 1. Hides the visibility of PREEMPT_SOFTIRQS and PREEMPT_HARDIRQS if PREEMPT_RT
> (Complete Preemption) is choosen, since these values are then set (selected) to
> be "y".
> 
> 2. Changes the PREEMPT_HARDIRQS to depend on PREEMPT_SOFTIRQS instead of
> forcing PREEMPT_SOFTIRQS to y if PREEMPT_HARDIRQS is choosen. (this is somewhat
> an abuse of select)
> 
> 3. Minor spelling fix. (tat to that)
> 


Hi John,

Thanks, but instead of this:

 depends on PREEMPT_RT != y

could you do:

 depends on !PREEMPT_RT


-- Steve
