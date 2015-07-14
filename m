From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] 4.1.2-rt1
Date: Tue, 14 Jul 2015 15:40:28 +0200
Message-ID: <20150714134028.GA21820@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.1.2-rt1 patch set.

The move from 4.0 to 4.1 was rather smooth, so we took the time for
some overdue cleanups and restructuring of the patch queue.

1) Patch folding

   - Fold all fixlets into the proper patches

   - Consolidate the patches which change the same piece of code over
     and over (e.g. add/revert/redo).

   These patches were mostly kept to be easily picked up for stable.

2) Dropping obsolete patches

   Some patches have been superseeded by different upstream changes,
   so the RT variant is redundant.

3) Changelogs

   Quite some patches had no or useless changelogs. We updated them
   all. Each patch has now a From+Subject+Date field. That means "git
   quiltimport" will produce now the same commit id for each patch (as
   long as the commit author and date remain unchanged).

4) Reordering

   The patches got reordered in topics, so patches related to the same
   subsystem or problem space are grouped together.

5) Ability to build and boot

   Each step in the queue now builds with RT=n and RT=y. All steps
   boot with RT=n. With RT=y the functionality is obviously dependent
   on all patches, so a boot bisectability can not be achieved.

As of now we provide a git tree with the RT changes as well. The tree
is similar structured as Stevens stable RT tree. For each kernel
version we provide 3 branches:

 linux-m.n.y-rt

	This branch starts when we move to a new kernel version. After
	the first release this branch gets only incremental updates
	(either from the mainline stable tree or from updates to the
	rt patch queue)

 linux-m.n.y-rt-rebase

	This branch is rebased when a new stable version or a new RT
	patch queue is available. The RT patch queue is applied on top
	of the latest mainline stable version.

 linux-m.n.y-queue
 
	This branch contains the revisions of the rt patch queue -
	patches and series file.

Known issues:
 
- My AMD box throws a lot of "cpufreq_stat_notifier_trans: No
  policy found" warnings after boot. It is gone after manually
  setting the policy (to something else than reported).

- bcache is disabled.

- CPU hotplug works in general. Steven's test script however
  deadlocks usually on the second invocation.

- xor / raid_pq
  I had max latency jumping up to 67563us on one CPU while the next
  lower max was 58us. I tracked it down to module's init code of
  xor and raid_pq. Both disable preemption while measuring the
  performance of the individual implementation.

The git URLs for this release are

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.1.y-rt
    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.1.y-rt-rebase
    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.1.y-rt-patches

The RT patch against 4.1.2 can be found here:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patch-4.1.2-rt1.patch.xz

The split quilt queue is available at:

    https://www.kernel.org/pub/linux/kernel/projects/rt/4.1/patches-4.1.2-rt1.tar.xz

Sebastian
