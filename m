From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: RT patches against v2.6.27-rc7 available
Date: Mon, 29 Sep 2008 23:32:50 -0400
Message-ID: <20080930033248.GA24480@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org, rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [128.224.252.2] ([128.224.252.2]:47141 "EHLO
	yow-pgortmak-d1.corp.ad.wrs.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751073AbYI3Dcy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Sep 2008 23:32:54 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've completed a carry forward of the 26rt9 broken out patchset onto
the 2.6.27-rc7 kernel.  There were a lot of changes in 2.6.27, so this
wasn't just a simple case of having all the patches magically work as-is.

I've done this by maintaining the existing series file and patch ordering
and patch content as much as possible.  I've used guilt (quilt for git)
since I wanted to try and maximize the usefulness to both the folks that
want to work with the series and folks that want to work with git.  I've
also annotated the series file with the conflicts (commit IDs) and details
of the conflicts so that others can hopefully extract value from this
carry forward if they want to look at it patch by patch.

There are several objectives that I'm hoping to cover with this:

  -assist the maintainers by hopefully saving them some of the gruntwork
   of the basic carry forward task, so that folks who know this stuff
   much better than I do can focus on features and technical issues.

  -provide early access to an RT tree, so that we can get early visibility
   into the issues that the new content from 2.6.27 bring to the surface.

  -allow folks who maintain different arches or different eval boards
   with less frequently used drivers to get early insight into how their
   boards/drivers will work, and hopefully contribute back fixes.

  -continue to keep the series carried forward to tip so that we essentially
   have a "linux-rt-next" and thus we get close to immediate feedback on
   how upstream changes impact the existing patchset.

  -capitalize on the "linux-rt-next" aspect of things in terms of hopefully
   making it easier to cherry pick bits from the 400 odd patches for
   mainline inclusion and thus reduce the preempt_rt patch footprint.

I'm open to suggestions on how to tailor this in a way that makes it
the most benefit to the folks doing the real work.  At the moment, I'd
figured on making both the broken out patch sets and the git tree with
them all applied as a reasonable starting point.

I'm not expecting anyone to adopt this wholesale in favour of dropping
whatever they are currently working on -- since say if I was in Steven's
shoes, I'd probably also be thinking "who is this chucklehead and why
should I even assume he can manage to merge anything without completely
making a mess."  Folks would be completely justified in thinking that,
and I'd actually be more suprised if they weren't initially suspicious.

With this in mind, it is why I annotated the series file with commit IDs
of upstream patches.  Even if a person doesn't see any value in the merged
patches, I'm hoping that the references of the upstream commits that cause
issues with the existing patches will save time if a person decides to do
an independent carry forward.  And a comparison of two independent carry
forwards would still have the benefit of flushing out some hidden items.
All my annotations in the series file start with PG, so it is clear what
I've added to the existing file; there are comments at the top that help
lay out what was done as well.  Long term, the PG comments can go, but
in the interim, I wanted to capture this metadata for people somehow.

I started with carrying forward 26rt6 onto 27rc1, then onto rc2...rc6,
and once done that, I brought in the additions for rt7, rt8 and rt9. The
move from rc6->rc7 was pretty much a no-op; all the work was in rc1..rc4.
The series file shows which conflicts appeared at which points.  I also
have the series files for each rcN along the way, if anyone wants those or
sees value in those intermediate steps, let me know.

Some patches only required some basic context modifications to become
usable again, but things like the  __raw_spin_foo() --> __ticket_spin_foo(),
the merge of various 32 and 64 bit files for x86, the required use of
early_initcall for several things, and the netdev locking changes made
things interesting and non trivial (at least from my point of view...)

I'm getting this out now, since I've got it carried forward and booting
on a basic old P4 box.  There are still things I want to do (e.g. non-x86
testing, etc; see below) but I think it is now at a point where it can be
a useful shared resource for folks to examine, poke at, kick the tires etc.  

I'll follow up tomorrow with a discussion of some of the patches that had
interesting aspects and/or warrant a highlight to ensure I've done the
right thing with them; it would be too much to include that here.


Location:
---------

The broken out patches and series file can be obtained from here:

	git://opensource1.windriver.com/people/paulg/rt/patches

A fully patched 2.6.27-rc7 git tree can be had from here:

	git://opensource1.windriver.com/people/paulg/rt/linux-2.6

The latter is just the result of applying the broken out patches with guilt,
and then committing the series file on the end as a useful reference.
I intend to clean up some of the patch headers so that patch attribution
in git comes out giving the proper credit - that is also on my todo list...
(Note: pre-patched tree is on branch "v2.6.27-rc7-26rt9" and not "master".)

As I mentioned earlier, I'm happy to take feedback on how this can be
tailored to be a more useful resource to those who are doing the real work
on the code -- there are folks out there who clearly have a much better
understanding of RT than I do, and as such I'd like this be something
of real value to them -- just to be clear, I don't have any interest
(or the skill) for this to be a separate project, or fork or similar.

Thanks,
Paul.
