From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][resubmit] x86: enable preemption in delay
Date: Thu, 19 Jun 2008 03:18:07 +1000
Message-ID: <200806190318.07684.nickpiggin@yahoo.com.au>
References: <200805252108.25011.mitov@issp.bas.bg> <200806182242.49245.nickpiggin@yahoo.com.au> <Pine.LNX.4.58.0806181215120.29622@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <ghaskins@novell.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andi Kleen <andi-suse@firstfloor.org>,
	Clark Williams <clark.williams@gmail.com>,
	Marin Mitov <mitov@issp.bas.bg>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, akpm@osdl.org,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756189AbYFRRSc@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0806181215120.29622@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thursday 19 June 2008 02:16, Steven Rostedt wrote:
> On Wed, 18 Jun 2008, Nick Piggin wrote:
> > There are _some_ cases where it can be used, but nobody has been
> > able to come up with compelling uses really. I don't think this
> > case is helped very much either because the logic in there using
> > preempt-disable is fine, isn't it?
> >
> > Except that it should also have a cond_resched in it. Seems like
> > an ideal place to put cond_resched because it is not a fastpath.
>
> Does it really need a cond_resched? preempt_enable when it goes to zero
> will already check to see if it should schedule.

It doesn't really need one, but of course having one would help
non preempt kernels.
