From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] create /proc/all-interrupts
Date: Mon, 30 Jul 2007 12:32:06 -0700
Message-ID: <20070730123206.abeab890.akpm@linux-foundation.org>
References: <20070726180522.GA1486@tsunami.ccur.com>
	<46A8EE78.4040702@zytor.com>
	<1185816797.3170.1.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, Joe Korty <joe.korty@ccur.com>,
	mingo@elte.hu, tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, jason.baietto@ccur.com
To: Sven-Thorsten Dietrich <sdietrich@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43441 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757386AbXG3Tdn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 15:33:43 -0400
In-Reply-To: <1185816797.3170.1.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 30 Jul 2007 10:33:17 -0700
Sven-Thorsten Dietrich <sdietrich@novell.com> wrote:

> On Thu, 2007-07-26 at 11:56 -0700, H. Peter Anvin wrote: 
> > Joe Korty wrote:
> > > Create /proc/all-interrupts for some architectures.
> > > 
> > > Create a version of /proc/interrupts that displays _every_
> > > IRQ vector, not just those that someone thought might be
> > > interesting, and add an entry in the commentary column
> > > for those vectors which lacked such a comment.
> > > 
> > > Rationale: /proc/interrupts is not truly useful unless it
> > > displays every IRQ vector, not just those somebody thought
> > > would be interesting.  For example, since /proc/interrupts
> > > does not display the rescheduling interrupt, the occurance
> > > of rescheduling interrupt floods ends up affecting
> > > latencies, yet without an entry in /proc/interrupts, it
> > > is difficult to discern why latencies are being affected.
> > > 
> > > Rather than modify /proc/interrupts, this patch creates
> > > a new version of /proc/interrupts, on the off-chance
> > > that adding new lines to /proc/interrupts, and appending
> > > new fields to the end of old lines, might break some
> > > longstanding script.  However, these kinds of changes
> > > traditionally do not affect scripts, so it might be
> > > reasonable to fold /proc/all-interrupts back into
> > > /proc/interrupts.
> > 
> > I think that would be the right thing to do.  We have added things to
> > /proc/interrupts in the past.
> > 
> Hi Andrew,
> 
> Would it make sense to drop this patch into -mm for feedback?
> 

It's a lot of code for something which might be useful to someone sometime.

It's a bit of a crappy changelog too.  I'd at least like to see a list of
all the new fields.

It should be OK to add new lines to /proc/interrupts?  That file varies a
lot between machines adn between architectures - as long as the new lines
have similar layout it is unlikely that anything will break.



+	atomic_inc(&__get_cpu_var(irq_thermal_counts));

The patch does atomic ops on cpu-local variables.  This isn't needed, and
is expensive.

If the field is only ever modified from hard interrupt context then you can
make the field unsigned long and use plain old `foo++'.

If the field is modified from both hard-IRQ and from non-IRQ then use a
local_t and local_inc.

Or even, given that this is just a statistic and grrat precision is not
needed, use unsigned long and f++ even if that _is_ racy.  Because the
consequences of a race will just be a single lost count, which we dont'
care about enough to add the additional overhead of an atomic op.


But I'm a bit dubious about the whole thing, really.  As I said, it's a lot
of code.  More justfication is needed for its addition, I'd suggest.
