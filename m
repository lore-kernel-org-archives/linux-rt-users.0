From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v4 0/5] Simple wait queue support
Date: Tue, 24 Nov 2015 14:03:02 +0100
Message-ID: <1448370187-10075-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Daniel Wagner <daniel.wagner@bmw-carit.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:46222 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752350AbbKXNDQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Nov 2015 08:03:16 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

In v3 we had some discussion concerning the open coded wait loop in
arch/powerpc/kvm/book3s_hv.c. If I understood it correctly, the
current version is okay though it wouldn't hurt to address the open
coded style eventually. Since I can't really test it and it looks
fragile I left it as it is.

swake_up_locked() is now available as non loop version as requested
by Boqun.

The API naming discussion faded out and the decision is on Peter.  I
assume since he wrote it initially it stays as it is.

There is now a new patch which tries to address the compile time type
check assertion. I added the checks to a couple of existing macros and
not on the complete API. If we want this we need to add macro for all
function calls I guess.

Obviously, I have rebased it and this time it is against tip/sched/core.
I noticed there are some smaller code refactorings ongoing, so this
version is not going to apply cleanly against mainline. There is
nothing particularly difficult to fix up though. In case someone
is interested I can post a version of it.

These patches are against

  tip/sched/core e73e85f0593832aa583b252f9a16cf90ed6d30fa

also available as git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux.git tip-swait

cheers,
daniel

changes since v3
 - rebased it on tip/sched/core (KVM bits have changed slightly)
 - added compile time type check assertion
 - added non lazy version of swake_up_locked()

changes since v2
 - rebased again on tip/master. The patches apply
   cleanly on v4.3-rc6 too.
 - fixed up mips
 - reordered patches to avoid lockdep warning when doing bissect.
 - remove unnecessary initialization of rsp->rda in rcu_init_one().

changes since v1 (PATCH v0)
 - rebased and fixed some typos found by cross building
   for S390, ARM and powerpc. For some unknown reason didn't catch
   them last time.
 - dropped completion patches because it is not clear yet
   how to handle complete_all() calls hard-irq/atomic contexts
   and swake_up_all.

changes since v0 (RFC v0)
 - promoted the series to PATCH state instead of RFC
 - fixed a few fallouts with build all and some cross compilers
   such ARM, PowerPC, S390.
 - Added the simple waitqueue transformation for KVM from -rt
   including some numbers requested by Paolo.
 - Added a commit message to PeterZ's patch. Hope he likes it.

[I got the numbering wrong in v1, so instead 'PATCH v1' you find it
 as 'PATCH v0' series]

v3: https://lwn.net/Articles/661415/
v2: https://lwn.net/Articles/660628/
v1: https://lwn.net/Articles/656942/
v0: https://lwn.net/Articles/653586/

Daniel Wagner (2):
  [s]wait: Add compile time type check assertion
  rcu: Do not call rcu_nocb_gp_cleanup() while holding rnp->lock

Marcelo Tosatti (1):
  KVM: use simple waitqueue for vcpu->wq

Paul Gortmaker (1):
  rcu: use simple wait queues where possible in rcutree

Peter Zijlstra (Intel) (1):
  wait.[ch]: Introduce the simple waitqueue (swait) implementation

 arch/arm/kvm/arm.c                  |   4 +-
 arch/arm/kvm/psci.c                 |   4 +-
 arch/mips/kvm/mips.c                |   8 +-
 arch/powerpc/include/asm/kvm_host.h |   4 +-
 arch/powerpc/kvm/book3s_hv.c        |  23 +++--
 arch/s390/include/asm/kvm_host.h    |   2 +-
 arch/s390/kvm/interrupt.c           |   8 +-
 arch/x86/kvm/lapic.c                |   6 +-
 include/linux/compiler.h            |   4 +
 include/linux/kvm_host.h            |   5 +-
 include/linux/swait.h               | 174 ++++++++++++++++++++++++++++++++++++
 include/linux/wait.h                |   2 +
 kernel/rcu/tree.c                   |  24 ++---
 kernel/rcu/tree.h                   |  12 +--
 kernel/rcu/tree_plugin.h            |  32 ++++---
 kernel/sched/Makefile               |   2 +-
 kernel/sched/swait.c                | 123 +++++++++++++++++++++++++
 virt/kvm/async_pf.c                 |   4 +-
 virt/kvm/kvm_main.c                 |  17 ++--
 19 files changed, 387 insertions(+), 71 deletions(-)
 create mode 100644 include/linux/swait.h
 create mode 100644 kernel/sched/swait.c

-- 
2.4.3

