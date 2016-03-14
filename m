From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Old split quilt queues
Date: Mon, 14 Mar 2016 02:31:31 -0400
Message-ID: <20160314063131.GT23251@windriver.com>
References: <569D6AE1.2090301@ramses-pyramidenbau.de>
 <alpine.DEB.2.11.1601202151200.3575@nanos>
 <56AA25D6.3070701@ramses-pyramidenbau.de>
 <alpine.DEB.2.11.1601291210330.3886@nanos>
 <56ABAE2A.2030902@ramses-pyramidenbau.de>
 <alpine.DEB.2.11.1601292053330.3886@nanos>
 <CAP=VYLo5HxhWhxzSNoFki4Wb7maSOduWnNHMpzZja3Hdu7=k5g@mail.gmail.com>
 <56DD62EB.4000101@ramses-pyramidenbau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:56220 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754689AbcCNGbt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Mar 2016 02:31:49 -0400
Content-Disposition: inline
In-Reply-To: <56DD62EB.4000101@ramses-pyramidenbau.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: Old split quilt queues] On 07/03/2016 (Mon 12:15) Ralf Ramsauer wrote:

> Hi Paul,
> 
> On 03/07/16 04:42, Paul Gortmaker wrote:
> > On Fri, Jan 29, 2016 at 2:56 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> On Fri, 29 Jan 2016, Ralf Ramsauer wrote:
> >>> As I expected, inside that repo are a lot of tags for the various -rt
> >>> versions.
> >>> First I thought, RT would make use of rebasing, like:
> >>>   - Rebase onto the next kernel version and drop unnecessary commits
> >>> (e.g. patches that went upstream)
> >>>   - Do some additional changes
> >>>   - Export vA.B.C...vA.B.C-rtX as split quilt queue
> >>>
> >>> But afaict, (at least on the old rt-history), you made a lot of merges
> >>> from rt/* branches and added tags describing the -rt version. Then you
> >>> went on merging against master in order to keep up with upstream.
> >>>
> >>> Given that, how do you create a split quilt queue, that applies against
> >>> an upstream tag?
> >>>
> >>> For example, let's take the first RT Tag of rt-history: v2.6.31-rc6-rt2
> >>> How would you create a split quilt queue, that applies against v2.6.31-rc6?
> >>>
> >>> (I need to extract all those split quilt queues RT version<->base
> >>> upstream version)
> >> As I said before: That was an experiment whether git is usable as a tool to
> >> manage something complex as rt. It turned out, that it's not. I recreated a
> >> new quilt queue after I abondoned git for rt.
> >>
> >> So creating split queues is going to be a very interesting and tedious
> >> detective work.
> > Just stumbled upon this older discussion now by happenstance.
> >
> > I can say with experience that it is exactly that:  tedious.
> I bet!
> >
> > 2.6.33 split queue:
> >
> > http://www.spinics.net/lists/linux-rt-users/msg06310.html
> >
> > 2.6.34 split queue:
> >
> > http://permalink.gmane.org/gmane.linux.kernel/1109036
> Oh my god, that must have been some agonizing days back in 2011 :-)
> 
> I tried the same, but eventually stopped linearizing the patch stack
> after a few hours as there was no real chance of fast success...

Yeah, it is not something you are going to bang out in a couple of
hours.

> >
> > The repo I referenced in the above doesn't seem to exist anymore
> > on kernel.org - although I don't explicitly recall deleting it.  Maybe
> > that was fallout from when kernel.org got hacked?
> >
> > But I am guessing I probably still have a local copy somewhere that
> > could be used to repopulate if anyone really cared about that old stuff.
> If you still have access to those old versions, I'd appreciate if you
> would let me know, anything helps!

I've restored it so that the links in the above post should be working
again as they did five years ago.

http://git.kernel.org/cgit/linux/kernel/git/paulg/rt-patches.git

> 
> Just out of curiosity: Do you still remember how long it took you to
> linearize those stacks? As I already mentioned, I gave up after a few
> hours .-)

I don't really recall exactly, but feel free to mine into the git repo
to look at the start commit date and go from there.  Pretty sure the
unit of measure will be in "days" and not "hours"...

Paul.
--

> 
> Cheers
>   Ralf
> >
> > I don't recall if I implicitly made a 2.6.31 series in the march forward to
> > the 2.6.33 but since 31 didn't have merges (aside from stable stuff)
> > that series would probably be reasonably easy to construct.
> >
> > Paul.
> > --
> >
> >> Thanks,
> >>
> >>         tglx
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Ralf Ramsauer
> PGP: 0x8F10049B
> 
> 
