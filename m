From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [ANNOUNCE] 4.8-rc5-rt1 beta
Date: Tue, 6 Sep 2016 14:25:08 -0400
Message-ID: <20160906182508.GB9950@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is a carry forward of the -rt patches off v4.6.7-rt11 through
mainline commits of v4.7 and up to the current v4.8-rc5.

https://git.kernel.org/cgit/linux/kernel/git/paulg/4.8-rt-patches.git

The repository only contains patches; this is aimed at being a
stepping stone for developers who are experimenting with -rt and/or
patching and building their own kernel trees.  End users who have not
created their own trees before really should stick with v4.6-rt.

To be explicitly clear -- this does NOT imply any level of support,
or any commitment to release an "official" -rt on any particular
kernel version by anyone, myself included.

This repo is meant to give more visibility into how the mainline
commits since 4.6 will impact the existing 4.6-rt patches.  This is
achieved by updating the -rt patches in lock step with the new
content as it was/is merged by Linus.  The branches exist as fast
forward work off of Sebastian's 4.6 patch history on the v4.6-rt.

Patch conflicts/issues of interest 
----------------------------------

What follows is probably only of interest to a select handful of
people who are routinely hands on with the patches.  It is a
summary of the changes of interest; all of which are part of the
above repo history, i.e.

   git whatchanged v4.7-rt..v4.8-rt

but ignoring the more basic patch refresh steps with just simple
context changes or obvious fixups.


  Patch conflicts/issues of interest 4.6 --> 4.7
  ----------------------------------------------

-v4.7 introduced a lot of users of down_write_killable which wasn't
 implemented for -rt (rwsem_rt.h), so I created one.  (see new patch
 rt-create-down_write_killable.patch -- local commit 14625e96ff085f),
 it probably warrants a look see from other people smarter than me.

-Al Viro added a 2nd user of down_read_non_owner into NFS unlink.
 Previously it was just bcache and Sebastian just made that depend on
 !RT_FULL (md-disable-bcache.patch).  So we'll need to decide what to
 with that; I just ignored NFS for now, since it is horrible anyway.
 (see upstream commit 884be175351e73c)

-there was considerable rummaging around in mm/page_alloc.c that caused
 the two -rt patches in there to need more hands on refresh work than
 normal, but everything seems OK AFAICT.

-task_rq_lock was expanded to take a struct rq_flags instead of the
 conventional lock flags; updated the patches to match (see upstream
 eb58075149b7f030 by peterz)

-dcache.h gained an implicit include issue; probably can upstream the
 trivial fix right away; didn't investigate whether there are
 configs on mainline where it also breaks. (fixes d9171b9345261e ?)

-about eight patches appeared upstream and were droppred from -rt.

-I initially renamed a couple patches to match the default name as
 given by "git format-patch" but since that prevents ease of viewing
 the "diff of a patch" as a double check on the patch refresh, I
 stopped doing that after the 1st two or three patches.


  Patch conflicts/issues of interest 4.7 --> 4.8
  ----------------------------------------------

-all the timer wheel rework being present in mainline meant we got
 to drop those patches from the -rt queue; about 21 patches in all.
 (11b68271256f28999 in this repo.)

-the amount of stuff living in thread_info was being scaled back by
 luto (see upstream 13d4ea097d18b419) and as part of that the
 GET_THREAD_INFO macro got nuked.  I temporarily reintroduced it
 close to the use case of x86 preempt lazy (local ID 822cf4179e6f)
 while we possibly reconsider where TIF_LAZY ends up living.

-another implicit include issue popped up, this time in the header
 include/linux/rbtree_augmented.h (local patch added in commit
 97cd8b0eeed6, fixes upstream commit c1adf20052d80); needs sending.

-the net patch that replaced some per-cpu stuff with a variable
 in current had macros in dev.c for the RT vs. non-RT case; now
 filter.c needs those same macros, so they moved to netdevice.h
 where the other shared macro was already (local ID 8ff5e6ee96b
 file net-move-xmit_recursion-to-per-task-variable-on-RT.patch)

-I dropped the two scsi-fcoe-* patches; it appears that what they
 were trying to fix on -rt will be fixed biy upstream 4b9bc86d5a99
 but it probably warrants a second look by someone else.

-the ARM at91 clksrc change has been temporarily dropped, after
 upstream got re-written to incorporate return values etc.  It
 had already been dragged along kicking and screaming from 3.x
 days and probably needs love from someone with real hardware.

-another 3 patches made it upstream, (not counting ones mentioned
 above) including the CR3 preempt issue fixed by Sebastian

Process details:
----------------
Rather than jump them forward all at once and then try and deal with
all the new issues at once, I walked them forward step by step through
the merges performed by Linus in each 2wk window leading up to the
rc1 tag (where all the ~12k new commits appear).  I've detailed this
exact same process in more detail in the past here:

	https://lwn.net/Articles/431364/

This 4.8 was done the same way.  So when you see two tags like these:

	rt-v4.7-3404-ge831101a73fb
	rt-v4.7-5222-g468fc7ed5537

you can checkout the patches on tag rt-v4.7-3404-ge831101a73fb and
know they will apply to any merge authored by Linus that lies
between merge v4.7-3404-ge831101a73fb and any Linus merge prior to
the merge at v4.7-5222-g468fc7ed5537.  This enables one to actually
bisect the complete uprev without having to deal with patch failures.

The list of merges is trivially created with something like:
   git log --oneline --reverse --merges --author=Torvalds v4.7..v4.8-rc1

Sanity boot tested on x86-64 SMP with what is largely a defconfig,
but with RT_FULL=y and NFS=n.
