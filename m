From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: 4.9-rt: uprev notes, incremental uprev, adding bisection ability
Date: Wed, 28 Dec 2016 23:09:48 -0500
Message-ID: <20161229040948.GE16148@windriver.com>
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

TL;DR: incremental -rt patch uprev from 4.8-rt to the new 4.9-rt
covering 175 touch down points on mainline merges & tags by Linus;
useful for rt developers and bugfixers to research and bisect with.

If you just want the bisect points generated on your machine, then:

    mkdir rt-test
    cd rt-test
    # clone mainline or clone from a local copy with >=4.9 tags in it.
    git clone /path/to/my/existing/mainline/linux linux-rt-bisect
    git clone git://git.kernel.org/pub/scm/linux/kernel/git/paulg/4.9-rt-patches.git

    cd linux-rt-bisect
    ../4.9-rt-patches/scripts/create-branches.sh

  ------ end TL;DR ------ 8< -------- end TL;DR ------

Now that 4.9-rt1 is out there, we can do what was done[1] for 4.8-rt
and create an incremental uprev to get an idea of what mainline
merges impacted the patches in the preempt-rt series to bring more
clarity into what conflicts arose:

https://git.kernel.org/cgit/linux/kernel/git/paulg/4.9-rt-patches.git

The usual suspects have impact to rt:  scheduler changes in tip, x86
changes in tip, CPU hotplug (this time) in tip, large "patch bombs"
from akpm, and even somewhat net-next content from davem.


Points of interest:
-------------------

lglocks:  -removed from mainline, so we get to drop the -rt
	extensions to that support.  However -rt specific users need
	to be converted to something else; e.g. see the new /* XXX */
	in cpu_stopper_thread, where an lglock used to be used.

thread_info: -x86 dabbled with THREAD_INFO_IN_TASK then disabled it
	again before rc2.  With the benefit of hindsight, we can
	take the disable commit and temporarily backport it so that
	we essentially never have it in task, which means saving a
	whole lot of mess in the preempt_lazy patches for nothing.
	(see Add / Delete patch marked with "*" at end of this post)

new/removed patches:  -there were six new patches added and 16
	patches removed.  A couple of the "removed" patches were not
	really removed, but instead squished as fixups into another
	related patch.

Further details can be found at the end of this post, where the merges
and the patches they impacted are listed.  A majority of the changes
are just basic context refresh -- updating the patch to match the
changes in the surrounding code without changing what the patch
really is doing.

One can also inspect the commit logs in the above git repo since the
baseline v4.8.15-rt10 commit.

Sanity boot testing was done on RT_FULL for x86-64 along the way on
selected "high risk" merges, like those listed above.  The final
result is that the patches at the end of the incremental uprev here
match the patches of v4.9-rt1 just recently released.


Bisecting to find new issues in 4.9-rt:
---------------------------------------

The other benefit of this is that it allows one to quasi-bisect the
preempt-rt (treated as a whole) across the some 15,000 patches that
make up the new 4.9 content.  This allowed me to solve several bugs
in 4.8-rt that I would have had an extrememly hard time to solve in
any other way.  I won't repeat every detail of how this process
makes sense, since I've documented that in the past[2].

The 15,000 odd commits of 4.9 made it to mainline via ~165 merges
from Linus between 4.8 and v4.9-rc1 (the merge window) where we can
apply the -rt patches and see which feature merges cause disruption
to the -rt patches.

Not every feature/maintainer-merge causes issues with the -rt patch
queue: I had to create just over 50 commits to the v4.8.15-rt10
baseline in order to have about 30 possible series of patches to
cover all those 165 merges from 4.8 to mainline 4.9-rc1.

Since Linux development has a lot less commits in rc2, rc3, ...
rc8, and final 4.9 -- those tags represent the remaining bisection
points that can be created and used from this repo.  I didn't do
per-merge patch application testng post-rc1 (just as was done for
the 4.8-rt incremental uprev earlier) since it would be pointless.

 ---

Quick recap on how to use this repo to do merge level bisect:

1) Full list of feature merges in mainline repo you can test on:
	git log --oneline --merges --author=Torvalds  \
	    --reverse ^v4.8 v4.9-rc1

2) Tags in this 4.9-rt patch repo look like:
	rt-v4.8-101-g7af8a0f80888
	rt-v4.8-304-g4b978934a440
	rt-v4.8-373-g00bcf5cdd6c0
	rt-v4.8-558-ge606d81d2d95
	rt-v4.8-627-gaf79ad2b1f33
	 [...]
	rt-v4.8-12632-ga379f71a30dd
	rt-v4.8-14088-g6b25e21fa6f2
	rt-v4.8-15054-g9ffc66941df2
	rt-v4.9-rc1
	rt-v4.9-rc2
	 [...]
	rt-v4.9-rc8
	rt-v4.9

3) Say you want to test -rt on this merge from #1:
	"af79ad2b1f33 Merge branch 'sched-core-for-linus' ..."
   You run "git describe af79ad2b1f33" and get:
	v4.8-627-gaf79ad2b1f33
   No problem, you check out the patches tagged in #2 with the
   matching name.  These will apply to that merge as a baseline.

4) Or, you did as in #3 but you have a merge that doesn't have a
   matching tag in the patch repo released here, like:
	v4.8-346-gde956b8f45b3
   The patches you want to use are on tag "rt-v4.8-304-g4b978934a440"
   since "304" is the highest mainline commit count to your "346"
   commit count without going over (think "Price is Right".)  The
   "304" will cover Linus merges 304-->372 inclusive. You don't use
   "373" since that is only for 373-->557 inclusive.

5) Check out your merge commit on mainline repo from #1.  Check out
   your patch tag from #3/#4 in the -rt patch repo.  Apply the
   patches in the series file of the patch repo to mainline just
   as you would any other series of patches.

Or you can use the script in the repo to automatically generate all
of the rt bisect points (can take 4h on a reasonably fast machine).


Links:
------
[1] https://lkml.kernel.org/r/20160906182508.GB9950@windriver.com

[2] https://lwn.net/Articles/431364/


Summary of merges that impacted the -rt patch set:
--------------------------------------------------

[commits since v4.8]    A=add    M=modify    D=delete

[101] 7af8a0f8 Merge tag 'arm64-upstream' of arm64/linux
  M arch-arm64-Add-lazy-preempt-support.patch
  M localversion.patch (reset to "rt0")

[304] 4b978934 Merge branch 'core-rcu-for-linus' of tip/tip
  M patch-to-introduce-rcu-bh-qs-where-safe-from-softirq.patch
  M rcu-merge-rcu-bh-into-rcu-preempt-for-rt.patch

[373] 00bcf5cd Merge branch 'locking-core-for-linus' of tip/tip
  D lglocks-rt.patch
  D lockinglglocks_Use_preempt_enabledisable_nort.patch
  D stomp-machine-create-lg_global_trylock_relax-primiti.patch
  D stomp-machine-use-lg_global_trylock_relax-to-dead-wi.patch
  M stop-machine-raw-lock.patch

[558] e606d81d Merge branch 'ras-core-for-linus' of tip/tip
  M x86-mce-timer-hrtimer.patch
  M x86-mce-use-swait-queue-for-mce-wakeups.patch

[627] af79ad2b Merge branch 'sched-core-for-linus' of tip/tip
  M cpu-rt-rework-cpu-down.patch
  M workqueue-distangle-from-rq-lock.patch
  M introduce_migrate_disable_cpu_light.patch

[728] 1a4a2bc4 Merge branch 'x86-asm-for-linus' of tip/tip
  M x86-preempt-lazy.patch
* A sched-core-x86-Make-struct-thread_info-arch-specific.patch
  D dump-stack-don-t-disable-preemption-during-trace.patch
  M sched-rt-mutex-wakeup.patch
  M introduce_migrate_disable_cpu_light.patch

[759] a6c4e4cd Merge branch 'x86-platform-for-linus' of tip/tip
  M x86-UV-raw_spinlock-conversion.patch

[773] 8e4ef638 Merge branch 'x86-vdso-for-linus' of tip/tip
  M oleg-signal-rt-fix.patch

[869] 999dcbe2 Merge branch 'irq-core-for-linus' of tip/tip
  M softirq-split-locks.patch

[918] 597f03f9 Merge branch 'smp-hotplug-for-linus' of tip/tip
  M md-raid5-percpu-handling-rt-aware.patch
  M softirq-split-timer-softirqs-out-of-ksoftirqd.patch
  M softirq-split-timer-softirqs-out-of-ksoftirqd.patch
  M softirq-preempt-fix-3-re.patch

[4177] 687ee0ad Merge davem/net-next
  M net-fix-iptable-xt-write-recseq-begin-rt-fallout.patch
  M net-Qdisc-use-a-seqlock-instead-seqcount.patch
  D skbufhead-raw-lock-free-skbs.patch
  M skbufhead-raw-lock.patch
  M mm-workingset-do-not-protect-workingset_shadow_nodes.patch

[8856] 14986a34 Merge branch 'for-linus' of ebiederm/user-namespace
  D lockdep-Quiet-gcc-about-dangerous-__builtin_return_a.patch

[9031] 95107b30 Merge tag 'trace-v4.9' of rostedt/linux-trace
  M latency-hist.patch

[10067] 513a4bef Merge branch 'for-4.9/block' of git://git.kernel.dk/linux-block
  M workqueue-use-locallock.patch
  D workqueue-use-rcu_readlock-in-put_pwq_unlocked.patch
  M block-mq-don-t-complete-requests-via-IPI.patch
  M block-mq-drop-preempt-disable.patch

[11288] b66484cd Merge branch 'akpm' (patches from Andrew)
  M sched-mmdrop-delayed.patch

[11412] 12e3d3cd Merge branch 'for-4.9/block-irq' of git://git.kernel.dk/linux-block
  M block-mq-don-t-complete-requests-via-IPI.patch

[11417] 24532f76 Merge branch 'for-4.9/block-smp' of git://git.kernel.dk/linux-block
  D blk-mq-revert-raw-locks-post-pone-notifier-to-POST_D.patchto-POST_D.patch

[12632] a379f71a Merge branch 'akpm' (patches from Andrew)
  M dm-make-rt-aware.patch
  D relay-fix-timer-madness.patch
  D ipc-msg-Implement-lockless-pipelined-wakeups.patch

[14088] 6b25e21f Merge tag 'drm-for-v4.9' of git://people.freedesktop.org/~airlied/linux
  M drmi915_Use_local_lockunlock_irq()_in_intel_pipe_update_startend().patch

[15054] 9ffc6694 Merge tag 'gcc-plugins-v4.9-rc1' of kees/linux
  D mm-page-alloc-use-local-lock-on-target-cpu.patch
  M rcu-Eliminate-softirq-processing-from-rcutree.patch
  M random-make-it-work-on-rt.patch
  M tasklet-rt-prevent-tasklets-from-going-into-infinite-spin-in-rt.patch

[v4.9-rc1] tag v4.9-rc1
  A arm-include-definition-for-cpumask_t.patch
  A btrfs-drop-trace_btrfs_all_work_done-from-normal_wor.patch
  A btrfs-swap-free-and-trace-point-in-run_ordered_work.patch
  A kernel-sched-move-stack-kprobe-clean-up-to-__put_tas.patch
  A locking-percpu-rwsem-use-swait-for-the-wating-writer.patch
  A mm-page-alloc-use-local-lock-on-target-cpu.patch
  D hwlat-detector-Don-t-ignore-threshold-module-paramet.patch
  D hwlat-detector-Update-hwlat_detector-to-add-outer-lo.patch
  D hwlat-detector-Use-thread-instead-of-stop-machine.patch
  D hwlat-detector-Use-trace_clock_local-if-available.patch
  D hwlatdetect.patch

[v4.9-rc2] tag v4.9-rc2
  M cpu-rt-make-hotplug-lock-a-sleeping-spinlock-on-rt.patch
  M cpu-rt-rework-cpu-down.patch
  A peterz-percpu-rwsem-rt.patch
* D sched-core-x86-Make-struct-thread_info-arch-specific.patch

[v4.9-rc3] tag v4.9-rc3
  M softirq-split-timer-softirqs-out-of-ksoftirqd.patch

[v4.9-rc8] tag v4.9-rc8
  M mm-workingset-do-not-protect-workingset_shadow_nodes.patch

[v4.9] tag v4.9
  M localversion.patch (set to "rt1")
  M rtmutex-futex-prepare-rt.patch
