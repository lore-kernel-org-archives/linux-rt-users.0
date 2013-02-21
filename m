From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH rt-3.6 0/3] Fix up mishandling of PREEMPT_RCU dependency
Date: Thu, 21 Feb 2013 14:53:31 -0500
Message-ID: <1361476414-27352-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:40269 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab3BUTyA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2013 14:54:00 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'd mentioned this when rt29 was announced, but there was yet one
more piece of the puzzle I hadn't figured out until rt30 (#4 below).

The executive summary is that we inserted an invalid dependency, but
then via another incorrect patch, reverted that dependency, and hence
it is still possible to select RT_FULL without PREEMPT_RCU.  We can
dump two patches from the queue by cleaning this up.

This commit message (from #2 below):

   PREEMPT_RT relies on PREEMPT_RCU - only allow RCU to be configured
   interactively in the !PREEMPT_RT case.

captures what we want(ed) to happen but wasn't what was actually
happening (note that PREEMPT_RT implicitly means RT_FULL here;
the log was written before RT_FULL existed).

A stacking effect of errors that is typical of large patch queues
that get carried forward over time took place.  It goes back at
least as far as rt-3.2

Here are the gory details:

1) We have "sched-disable-rt-group-sched-on-rt.patch" which adds a
"depends !PREEMPT_RT_FULL" to RT_GROUP_SCHED.

2) The patch "rcu-force-preempt-rcu-for-rt.patch" got mangled during
a carry forward.  It has the commit log quoted above, but instead
of doing that, it just reverts the sched patch above in #1.

3) The bug that #1 fixed got "rediscovered" and so 
"rt-disable-rt-group-sched.patch" got added as an accidental
duplicate of the earlier sched patch in #1. (instead of fixing #2)

4) Fixing patch #2, so it adds a "depends !PREEMPT_RT_FULL" to the
proper block (i.e. PREEMPT_RCU instead of RT_GROUP_SCHED) doesn't
have the desired effect of making PREEMPT_RCU enabled and non
interactive, instead it simply makes it go away entirely when
RT_FULL is enabled (and then you get compile failures, etc.)

So, to fix all of that, we throw away the duplicate from #3,
delete #2 entirely, since it is an accidental revert and can't
be salvaged (as per #4).  And finally, to achieve the goal of
having PREEMPT_RCU be always set non-interactively for RT_FULL=y
we simply add a select for it in the RT_FULL Kconfig control block.
That is added into the patch which introduces RT_FULL.

Overall, this is primarily a queue maintenance thing and not really
that interesting to the end users, since diffing the two trees after
running the updated queue results in only this difference:

 -------------------------------------
 $ git diff v3.6.11-rt30 v3.6.11-rt30-fixes
 diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
 index 3050029..38cecfe 100644
 --- a/kernel/Kconfig.preempt
 +++ b/kernel/Kconfig.preempt
 @@ -77,6 +77,7 @@ config PREEMPT_RT_FULL
         bool "Fully Preemptible Kernel (RT)"
         depends on IRQ_FORCED_THREADING
         select PREEMPT_RT_BASE
 +       select PREEMPT_RCU
         help
           All and everything
  
 $ 
 -------------------------------------
 
I'm posting this since even if there isn't a v3.6.11-rt31, ideally we'd
like to see this not get carried forward to yet another release.

Thanks,
Paul.
---

The following changes since commit bb102e108f5d60068b3a5564f0f1f314d4c72332:

  patches-3.6.11-rt30.tar.xz (2013-02-19 18:33:41 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/3.6-rt-patches.git v3.6.11-rt30-fixes

for you to fetch changes up to 55c97947531d88af6cf9f56ccccb41e26c7f8cd5:

  preempt-rcu: untangle kconfig RT_FULL/PREEMPT_RCU relationship (2013-02-20 19:05:38 -0500)

----------------------------------------------------------------
Paul Gortmaker (3):
      rt: drop duplicated rt-disable-rt-group-sched.patch
      rt: fix mispatch of Kconfig by rcu-force-preempt-rcu-for-rt.patch
      preempt-rcu: untangle kconfig RT_FULL/PREEMPT_RCU relationship

 kconfig-preempt-rt-full.patch      |  3 ++-
 rcu-force-preempt-rcu-for-rt.patch | 28 ----------------------------
 rt-disable-rt-group-sched.patch    | 29 -----------------------------
 series                             |  4 ++--
 4 files changed, 4 insertions(+), 60 deletions(-)
 delete mode 100644 rcu-force-preempt-rcu-for-rt.patch
 delete mode 100644 rt-disable-rt-group-sched.patch
