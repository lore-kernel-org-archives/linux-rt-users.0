From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [RT-3.6] trivial fixes for git-am and fix for !RT_FULL
Date: Wed, 10 Oct 2012 12:47:20 -0400
Message-ID: <20121010164719.GA14314@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60705 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662Ab2JJQre (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Oct 2012 12:47:34 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've used the 3.6 RT patches as a baseline for a git repo of patches
(identical to how stable kernels are managed) since I like how it gives
visibility into how each patch evolves and adds tracking to the series.

On that baseline I've layered on some trivial fixes (bad ordering in the
From/Subject line, missing subjects etc) that trip up git-am and would
need fixing anyway before considering them for mainlining.  Aside from
two whitespace things, these changes don't alter the final source at all.

There is one build fix which I've added for the !RT_FULL case; trivial
missing ifdef usage.

I'll keep the master branch in this repo to track directly the exact
content released by Thomas in his tarballs.  The fixes I've done are on
the v3.6.1-rt1-fixes branch that can be browsed here:

http://git.kernel.org/?p=linux/kernel/git/paulg/3.6-rt-patches.git;a=shortlog;h=refs/heads/v3.6.1-rt1-fixes

Q: Looks interesting.  How would I use this?

A: If you have been using tglx's tarballs of patches, then use of this
   is essentially identical.  You'd simply do:

    git clone git://git.kernel.org/pub/scm/linux/kernel/git/paulg/3.6-rt-patches.git
    cd 3.6-rt-patches
    git checkout v3.6.1-rt1-fixes

   and point quilt (or git-quilt-import etc) at your new dir of patches,
   just as you would have when using tglx's tarball of patches.  Or
   checkout the master branch if you want to use tglx's latest.

Paul
---

The following changes since commit 19aa1730ceb5605bf3cf6e24aeb990643a925cfc:

  RT: 3.6.1 baseline patch set (2012-10-09 19:23:14 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/3.6-rt-patches.git v3.6.1-rt1-fixes

for you to fetch changes up to 9d13f3023b994b00d649eb70a219bd57cc4ec41e:

  timer.c: integrate build fix for !RT_FULL (2012-10-09 20:26:30 -0400)

----------------------------------------------------------------
Paul Gortmaker (10):
      rename softirq-preempt-fix-3-re.txt to have a .patch suffix
      signal-rt-fix: reorder Subject and From
      fix-rt-int3-x86_32-3.2-rt: reorder Subject and From
      latency-hist: strip trailing newline
      panic-disable-random-on-rt: add Subject to the patch
      hrtimer-add-missing-debug_activate-aid: divorce from ancient announce
      rename hrtimer-add-missing-debug_activate-aid patch
      futex-requeue-pi-fix: reorder Subject and From
      ping-sysrq: fix space-before-tab warning
      timer.c: integrate build fix for !RT_FULL

 fix-rt-int3-x86_32-3.2-rt.patch                    |  2 +-
 futex-requeue-pi-fix.patch                         |  2 +-
 ...=> hrtimer-add-missing-debug_activate-aid.patch | 23 +----------
 latency-hist.patch                                 |  3 +-
 oleg-signal-rt-fix.patch                           |  2 +-
 panic-disable-random-on-rt.patch                   |  1 +
 ping-sysrq.patch                                   |  2 +-
 series                                             |  5 ++-
 ...-fix-3-re.txt => softirq-preempt-fix-3-re.patch |  0
 timer.c-fix-build-fail-for-RT_FULL.patch           | 45 ++++++++++++++++++++++
 10 files changed, 55 insertions(+), 30 deletions(-)
 rename hrtimer-add-missing-debug_activate-aid-was-re-announce-3-0-6-rt17.patch => hrtimer-add-missing-debug_activate-aid.patch (77%)
 rename softirq-preempt-fix-3-re.txt => softirq-preempt-fix-3-re.patch (100%)
 create mode 100644 timer.c-fix-build-fail-for-RT_FULL.patch

