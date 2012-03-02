From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT 7/9][RFC] [PATCH 7/9] cpu/rt: Rework cpu down for
 PREEMPT_RT
Date: Fri, 2 Mar 2012 16:20:04 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1203021618330.2742@ionos>
References: <20120301185527.064629423@goodmis.org>  <20120301190346.172835662@goodmis.org>  <alpine.LFD.2.02.1203021518501.2742@ionos> <1330701323.25686.260.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330701323.25686.260.camel@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2 Mar 2012, Steven Rostedt wrote:

> On Fri, 2012-03-02 at 15:52 +0100, Thomas Gleixner wrote:
> 
> > So no, I rather keep the current problem than applying that insanity.
> 
> Note, patches 1,2,3,5 and 6, were bugs I found while debugging hotplug.
> Please add them, they are not insanity fixes but real bug fixes.

Already queued. I'd say #4 is a bug fix as well, though I
fundamentally hate the ass backwards semantics of that new function.
 
Thanks,

	tglx
