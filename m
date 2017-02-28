From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [CFP] RT Users Micro-Conf at Linux Plumbers 2017
Date: Tue, 28 Feb 2017 16:04:32 -0500
Message-ID: <20170228160432.2f8eecbe@gandalf.local.home>
References: <20170227172556.28dcbbb5@gandalf.local.home>
        <20170228204121.GO1733@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbdB1VQp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Feb 2017 16:16:45 -0500
In-Reply-To: <20170228204121.GO1733@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 28 Feb 2017 14:41:21 -0600
Julia Cartwright <julia@ni.com> wrote:


> > A month later there will be a Real-Time get together in Prague, that
> > would be perfect to be able to bring together a list of issues that
> > users may have and present this to the PREEMPT_RT kernel developers.  
> 
> Having LPC host this seems a bit strange, given your defined audience
> (users vs. kernel developers).  Perhaps it would be more effective as a

I don't find it strange at all. There should be more "users" at
plumbers. LPC is about discussion and not presentations. When users and
developers get together, it should be a discussion.

> session in the Open Source Summit track, or at the very least, if
> attendees at the OSS Summit were able to attend the miniconference w/o
> the purchase of a LPC badge.

I think a badge would still be worth purchasing. Having the ability to
help influence development is a worthy goal.

> 
> > Are people willing to participate and have a discussion on what works
> > and what doesn't work with PREEMPT_RT. Be able to share horror stories
> > and work arounds with each other and perhaps come up with better
> > solutions. I will take what comes out of this with me to Prague and
> > perhaps be able to influence the development of PREEMPT_RT to address
> > any issues that arise.  
> 
> As a brainstorming of potential content, here's what I'd like to see as
> an attendee (certainly willing to present where appropriate too!):
> 
>   1. Debugging case studies:
> 
> There are a ton of debugging/visualizing/tracing tools out there
> available for finding latency problems.  Too many tools; some with
> overlapping purpose, and some better than others.  It would be an
> interesting exercise to have a few folks demonstrate the complete
> identification, debugging, and fix of a performance problem on RT,
> complete with a walkthrough of what tools were used.

Note, LPC is about discussions and not presentations or tutorials.
Although, I could submit a talk that would hopefully be a good
introduction into what the plumbers track would be like. I could maybe
get it accepted for the "shared" day (talks for both plumbers and Open
Source Summit attendees).

If you can create a discussion out of debugging tools. "Here's what I
have, is there a better way to do this?"

> 
>   2. What to consider when designing the priority scheme of your system
>      (application threads, irqthreads, RCU threads, ...)

I would turn this into something like "here's my work arounds to my
problems, are there better ways to do this?"

> 
>   3. An enumeration of "knobs" which impact RT behavior
> 
> Where knobs are any of the compile-time or run-time configuration
> parameters and how they impact determinism (I'm thinking things we've
> run into like IRQSOFF tracing, timerslack, the bizarre
> /dev/cpu_dma_latency, etc).

"here's what I've done, are there better ways to do this?"

Hmm, I'm seeing a trend here ;-)

> 
> > There's also talk about having this combined with a Safety Critical
> > session focused on PREEMPT_RT.
> >
> > Are people interesting in attending such an event? If so, I'll submit a
> > proposal for having such a Micro-Conference at Linux Plumbers. If not,
> > I wont bother wasting any time on it.  
> 
> Sounds good to me!  Let me know where I can help.

I rather have you tell us were you want to help :)

I'm looking for ideas from others. This email is just to poke peoples
brains.

-- Steve
