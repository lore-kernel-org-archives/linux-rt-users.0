From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Tue, 30 Oct 2007 20:17:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710302012560.4854@gandalf.stny.rr.com>
References: <11542808.1611171193777521160.JavaMail.www@wwinf6102>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:63800 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbXJaARj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 20:17:39 -0400
In-Reply-To: <11542808.1611171193777521160.JavaMail.www@wwinf6102>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


I somehow was removed from the CC list, so I didn't see it.

<rant>I hate lists that think it's best to only post to the list and tell
you to take all people off the CC list. Those are lists that are run by
people that have way too much time on their hands to be reading mailing
lists all day. Between LKML, linux-rt-users, virt, lguest, and a ton of
internal lists,  I can't keep up! When in a coding frenzy, I may
not read lists for days.</rant>


--
On Tue, 30 Oct 2007, Gerrit Binnenmars wrote:

> > Datum: 29/10/07 02:09 PM
> > Van: "Steven Rostedt"
> > Aan: "Gerrit Binnenmars"
> > CC: linux-rt-users@vger.kernel.org
> > Onderwerp : Re: CONFIG_CRITICAL_IRQSOFF_TIMING
> >
> >
> > --
> > On Sun, 28 Oct 2007, Gerrit Binnenmars wrote:
> >
> > > Hello,
> > >
> > > Can someone send me a .config file that shows the options needed to get the interrupt off
> > > timing values in preempt_max_latency, please. I only see a value of 0 in this file
> > > I am using kernel 2.6.22.1 with the corresponding rt patch.
> > >
> > > Thanks in advance,
> >
> > Make sure you have event trace and latency tracing as well as
> > "Interrupts-off critical section latency timing".
> >
> > Then you need to echo 0 > /proc/sys/kernel/preempt_max_latency.
> >
> Hello Steve,
>
> Thanks for your quick response, but the preempt_max_latency remains 0. Also the latency_hist shows no samples taken.
> Can you or someone else have a look at the corresponding CONFIG options?
>
> CONFIG_LTT_PROBE_LOCKING=m
> # CONFIG_LTT_PROBE_STACK is not set
>
> #
> # Kernel hacking
> #

[...]

> CONFIG_INTERRUPT_OFF_HIST=y
> CONFIG_CRITICAL_LATENCY_HIST=y
> CONFIG_LATENCY_HIST=y

Turn off all histograms. They will kill any measurements you are taking.
And yes, you will not get the output from latency_trace that you are
after.

-- Steve
