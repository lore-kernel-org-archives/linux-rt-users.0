From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: [PATCH v3] lockdep: Make MAX_STACK_TRACE_ENTRIES
	 configurable.
Date: Wed, 21 Apr 2010 05:47:07 -0600
Message-ID: <4BCEAD7B0200005A0006513E@soto.provo.novell.com>
References: <alpine.LFD.2.00.1004161329030.11320@localhost.localdomain>
 <alpine.LFD.2.00.1004161727000.11320@localhost.localdomain>
 <alpine.LFD.2.00.1004191841230.6259@localhost>
 <20100420140941.d085007d.akpm@linux-foundation.org>
 <alpine.LFD.2.00.1004211309560.6646@localhost>
 <1271849823.1776.87.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	"Clark Williams" <williams@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
To: "Peter Zijlstra" <peterz@infradead.org>,
	"John Kacur" <jkacur@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1271849823.1776.87.camel@laptop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

>>> On 4/21/2010 at 07:37 AM, in message <1271849823.1776.87.camel@laptop>, Peter
Zijlstra <peterz@infradead.org> wrote: 
> On Wed, 2010-04-21 at 13:12 +0200, John Kacur wrote:
>> 
>> Certain configurations that have LOCKDEP turned on, run into the limit
>> where the MAX_STACK_TRACE_ENTRIES are too small. Rather than simply
>> turning of the locking correctness validator let the user configure this
>> value to something reasonable for their system.
> 
> I'm not sure its worth having a CONFIG_ value for this, that'll just be
> yet another random value nobody knows what to do with.
> 
> Do you actually have a machine that reproduces this? Can you see how
> many classes, avg stacktraces per class and the avg entries per
> stacktrace there are?
> 
> Also, is there's lots of classes, are there many with a similar name?
> 
> That is, is it a valid depletion or is there something wonkey with those
> setups?

Hi John, Peter.

I am not sure if Johns solution is the right/best one per se, but I can attest
that I used to hit this problem _all_ the time and it was somewhat annoying
to need to patch the kernel on all of my machines to fix it.  I realize that I
perhaps do not represent the average user, but it was a pain-point for me.
FWIW, John's patch would indeed make my life easier since I tend to share the
.config between builds.

Kind Regards,
-Greg

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
