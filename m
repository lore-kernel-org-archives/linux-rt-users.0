From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Fix the processing of optional options for cyclictest
Date: Sun, 6 Jul 2008 19:33:01 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0807061925430.3862@apollo.tec.linutronix.de>
References: <520f0cf10806270110l5b3199ablc936c38f4bcf24eb@mail.gmail.com>  <c384c5ea0806270734p73c68871k5dec8d1ad25afaff@mail.gmail.com>  <Pine.LNX.4.58.0806271157001.20917@gandalf.stny.rr.com>  <48651013.2070704@gmail.com>
 <520f0cf10806271222g37dd75c0gafe578c6d4ef5339@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <clark.williams@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Leon Woestenberg <leon.woestenberg@gmail.com>,
	linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:56492 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbYGFRdS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 6 Jul 2008 13:33:18 -0400
In-Reply-To: <520f0cf10806271222g37dd75c0gafe578c6d4ef5339@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 27 Jun 2008, John Kacur wrote:
> On Fri, Jun 27, 2008 at 6:06 PM, Clark Williams
> <clark.williams@gmail.com> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Steven Rostedt wrote:
> >> 5B
> >>
> >> On Fri, 27 Jun 2008, Leon Woestenberg wrote:
> >>
> >>> Hello,
> >>>
> >>> I still found it strange that the RTWiki mentions "-t NUM" as if it
> >>> works, so the manual page of cyclictest and the wiki needs a review
> >>> too.
> >>
> >> It doesn't?
> >>
> >> Then again I must have an old version of cyclictest, because both -t5 and
> >> -t 5 work for me.
> >>
> >> -- Steve
> >>
> >
> > You do. The current source in Thomas's git tree exhibits this
> > behavior, because of the way getopt() handles optional arguments.
> >
> > Clark
> 
> Right the extra-code is only necessary for the processing of optional
> arguments, so without checking the history of the program, I would
> assume that the NUM argument to -t was not optional in the past. Now
> it is optional because -t without arguments implies threads =
> max_cpus. I made some very minor edits to the wiki a little while ago
> to reflect this but the Wiki page does need to updated more, I think
> the usage file corresponds a lot more closely to the actual behaviour.
> 
> crap, I see I left of the signed-off-by: John Kacur <jkacur@gmail.com>
> line on the patch, do I need to resubmit it?

Grmbl, was going to ask that, but did not find you on IRC and I
committed it _before_ reading this mail. 

I applied it with two tweaks:

1) Your patch was line wrapped :(

2) I fixed the info for -a NUM. We pin the threads to exactly the CPU
specified with NUM

Pushed out to git and released 0.23.

Thanks,

	tglx
