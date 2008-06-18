From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][resubmit] x86: enable preemption in delay
Date: Wed, 18 Jun 2008 22:42:48 +1000
Message-ID: <200806182242.49245.nickpiggin@yahoo.com.au>
References: <200805252108.25011.mitov@issp.bas.bg> <1213791416.16944.222.camel@twins> <4858C68C.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Peter Zijlstra" <peterz@infradead.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Andi Kleen" <andi-suse@firstfloor.org>,
	"Clark Williams" <clark.williams@gmail.com>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Marin Mitov" <mitov@issp.bas.bg>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>, akpm@osdl.org,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	"LKML" <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: "Gregory Haskins" <ghaskins@novell.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755453AbYFRMnb@vger.kernel.org>
In-Reply-To: <4858C68C.BA47.005A.0@novell.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday 18 June 2008 22:25, Gregory Haskins wrote:
> >>> On Wed, Jun 18, 2008 at  8:16 AM, in message

> > Yeah - migrate_disable() has been proposed several times. The reason I
> > don't like it is that is creates scheduling artefacts like latencies by
> > not being able to load-balance (and thereby complicates all that, and
> > you know we don't need more complication there).
>
> True, and good point.  But this concept would certainly be useful to avoid
> the heavyweight (w.r.t. latency) preempt-disable() in quite a few different
> areas, so if we can make it work with reasonable visibility, it might be
> nice to have.

It just seems like pretty worthless bloat to me.

There are _some_ cases where it can be used, but nobody has been
able to come up with compelling uses really. I don't think this
case is helped very much either because the logic in there using
preempt-disable is fine, isn't it?

Except that it should also have a cond_resched in it. Seems like
an ideal place to put cond_resched because it is not a fastpath.
