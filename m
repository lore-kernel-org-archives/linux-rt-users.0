From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH tip v7 0/7] Simple wait queue support
Date: Fri, 29 Jan 2016 15:03:21 +0100
Message-ID: <1454076208-28354-1-git-send-email-daniel.wagner@bmw-carit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-fbdev@vger.kernel.org, linux-mips@linux-mips.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Maik Broemme <mbroemme@plusserver.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-rt-users.vger.kernel.org

Hi,

As it turns out I missed a few incompatible-pointer-types errors.
Furthermore I even missed to update one calling side on wait in the ARM KVM
code base. Luckily the kbuild test robot found them all.

These patches are against

  tip/sched/core 0905f04eb21fc1c2e690bed5d0418a061d56c225

also available as git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux.git tip-swait

cheers,
daniel

changes since v6:
 - fixed a couple of incompatible-pointer-types errors
 - fixed a missing KVM ARM wait -> swait update

changes since v5:
 - unconditionally add -Werror=incompatible-pointer-types
 - updated KVM statistics in commit message
 - rebased on tip/sched/core 
 - added ack-by PeterZ

changes since v4:
 - replaced patch #2 which tried to force to compiler to
   exit with an error by using compile time assertion type
   check macros. Instead use -Werror=incompatible-pointer-types
   to tell the compiler to barf loudly.
 - fixed wrong API usage in patch 4 as reported by Boqun.

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

v6: https://lkml.org/lkml/2016/1/28/462
v5: https://lkml.org/lkml/2015/11/30/318
v4: https://lwn.net/Articles/665655/
v3: https://lwn.net/Articles/661415/
v2: https://lwn.net/Articles/660628/
v1: https://lwn.net/Articles/656942/
v0: https://lwn.net/Articles/653586/

Daniel Wagner (4):
  video: Use bool instead int pointer for get_opt_bool() argument
  MIPS: Differentiate between 32 and 64 bit ELF header
  kbuild: Add option to turn incompatible pointer check into error
  rcu: Do not call rcu_nocb_gp_cleanup() while holding rnp->lock

Marcelo Tosatti (1):
  KVM: use simple waitqueue for vcpu->wq

Paul Gortmaker (1):
  rcu: use simple wait queues where possible in rcutree

Peter Zijlstra (Intel) (1):
  wait.[ch]: Introduce the simple waitqueue (swait) implementation

 Makefile                                 |   3 +
 arch/arm/kvm/arm.c                       |   8 +-
 arch/arm/kvm/psci.c                      |   4 +-
 arch/mips/include/asm/elf.h              |  68 ++++++------
 arch/mips/kvm/mips.c                     |   8 +-
 arch/powerpc/include/asm/kvm_host.h      |   4 +-
 arch/powerpc/kvm/book3s_hv.c             |  23 ++---
 arch/s390/include/asm/kvm_host.h         |   2 +-
 arch/s390/kvm/interrupt.c                |   4 +-
 arch/x86/kvm/lapic.c                     |   6 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c |   2 +-
 include/linux/kvm_host.h                 |   5 +-
 include/linux/swait.h                    | 172 +++++++++++++++++++++++++++++++
 kernel/rcu/tree.c                        |  24 +++--
 kernel/rcu/tree.h                        |  12 ++-
 kernel/rcu/tree_plugin.h                 |  32 ++++--
 kernel/sched/Makefile                    |   2 +-
 kernel/sched/swait.c                     | 123 ++++++++++++++++++++++
 virt/kvm/async_pf.c                      |   4 +-
 virt/kvm/kvm_main.c                      |  17 ++-
 20 files changed, 420 insertions(+), 103 deletions(-)
 create mode 100644 include/linux/swait.h
 create mode 100644 kernel/sched/swait.c

-- 
2.5.0
