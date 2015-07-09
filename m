From: Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC][PATCH] mm: ifdef out VM_BUG_ON check on PREEMPT_RT_FULL
Date: Thu, 9 Jul 2015 12:00:42 -0400
Message-ID: <20150709160042.GA7406@cmpxchg.org>
References: <20150529104815.2d2e880c@sluggy>
 <20150529142614.37792b9ff867626dcf5e0f08@linux-foundation.org>
 <20150601131452.3e04f10a@sluggy>
 <20150601190047.GA5879@cmpxchg.org>
 <20150611114042.GC16115@linutronix.de>
 <20150619180002.GB11492@cmpxchg.org>
 <20150708154432.GA31345@linutronix.de>
 <alpine.DEB.2.11.1507091616400.5134@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@glx-um.de>, linux-mm@kvack.org,
	RT <linux-rt-users@vger.kernel.org>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1507091616400.5134@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jul 09, 2015 at 05:07:42PM +0200, Thomas Gleixner wrote:
> This all or nothing protection is a real show stopper for RT, so we
> try to identify what needs protection against what and then we
> annotate those sections with proper scope markers, which turn into RT
> friendly constructs at compile time.
> 
> The name of the marker in question (event_lock) might not be the best
> choice, but that does not invalidate the general usefulness of fine
> granular protection scope markers. We certainly need to revisit the
> names which we slapped on the particular bits and pieces, and discuss
> with the subsystem experts the correctness of the scope markers, but
> that's a completely different story.

Actually, I think there was a misunderstanding.  Sebastian's patch did
not include any definition of event_lock, so it looked like this is a
global lock defined by -rt that is simply explicit about being global,
rather than a lock that specifically protects memcg event statistics.

Yeah that doesn't make a lot of sense, thinking more about it.  Sorry.

So localizing these locks for -rt is reasonable, I can see that.  That
being said, does it make sense to have such locking in mainline code?
Is there a concrete plan for process-context interrupt handlers in
mainline?  Because it'd be annoying to maintain fine-grained locking
schemes with explicit lock names in a source tree where it never
amounts to anything more than anonymous cli/sti or preempt toggling.

Maybe I still don't understand what you were proposing for mainline
and what you were proposing as the -rt solution.
