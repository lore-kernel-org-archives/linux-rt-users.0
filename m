From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/4] Simple wait queue support
Date: Sun, 25 Oct 2015 13:10:33 -0700
Message-ID: <20151025201033.GC5105@linux.vnet.ibm.com>
References: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Daniel Wagner <daniel.wagner@bmw-carit.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:45284 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbJYUKa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Oct 2015 16:10:30 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sun, 25 Oct 2015 14:10:29 -0600
Content-Disposition: inline
In-Reply-To: <1445326090-1698-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Oct 20, 2015 at 09:28:06AM +0200, Daniel Wagner wrote:
> Hi,
> 
> Only small updates in this version, like fixing mips and reordering
> two patches to avoid lockdep warning when doing git bissect.  Reported
> by Fengguang Wu's build robot. Thanks!
> 
> Also removed the unnecessary initialization in the rcu patch as Paul
> pointed out.
> 
> Hopefully, I do a better job on Cc list this time.
> 
> These patches are against
> 
>   tip/master 11f4d95e6b634d7d41e7c2b521fcec261efbf769

I didn't find this commit, so I am (temporarily!) applying against
19a5ecde086a (rcu: Suppress lockdep false positive for rcp->exp_funnel_mutex)
for testing purposes.  RCU appears to be a bit of a moving target here...

							Thanx, Paul

> also available as git tree:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux.git tip-swait
> 
> cheers,
> daniel
> 
> changes since v2
>  - rebased again on tip/master. The patches apply
>    cleanly on v4.3-rc6 too.
>  - fixed up mips
>  - reordered patches to avoid lockdep warning when doing bissect.
>  - remove unnecessary initialization of rsp->rda in rcu_init_one().
> 
> changes since v1 (PATCH v0)
>  - rebased and fixed some typos found by cross building
>    for S390, ARM and powerpc. For some unknown reason didn't catch
>    them last time.
>  - dropped completion patches because it is not clear yet
>    how to handle complete_all() calls hard-irq/atomic contexts
>    and swake_up_all.
> 
> changes since v0 (RFC v0)
>  - promoted the series to PATCH state instead of RFC
>  - fixed a few fallouts with build all and some cross compilers
>    such ARM, PowerPC, S390.
>  - Added the simple waitqueue transformation for KVM from -rt
>    including some numbers requested by Paolo.
>  - Added a commit message to PeterZ's patch. Hope he likes it.
> 
> [I got the numbering wrong in v1, so instead 'PATCH v1' you find it
>  as 'PATCH v0' series]
> 
> v1: http://lwn.net/Articles/656942/
> v0: http://lwn.net/Articles/653586/
> 
> Daniel Wagner (1):
>   rcu: Do not call rcu_nocb_gp_cleanup() while holding rnp->lock
> 
> Marcelo Tosatti (1):
>   KVM: use simple waitqueue for vcpu->wq
> 
> Paul Gortmaker (1):
>   rcu: use simple wait queues where possible in rcutree
> 
> Peter Zijlstra (Intel) (1):
>   wait.[ch]: Introduce the simple waitqueue (swait) implementation
> 
>  arch/arm/kvm/arm.c                  |   4 +-
>  arch/arm/kvm/psci.c                 |   4 +-
>  arch/mips/kvm/mips.c                |   8 +-
>  arch/powerpc/include/asm/kvm_host.h |   4 +-
>  arch/powerpc/kvm/book3s_hv.c        |  23 +++--
>  arch/s390/include/asm/kvm_host.h    |   2 +-
>  arch/s390/kvm/interrupt.c           |   8 +-
>  arch/x86/kvm/lapic.c                |   6 +-
>  include/linux/kvm_host.h            |   5 +-
>  include/linux/swait.h               | 172 ++++++++++++++++++++++++++++++++++++
>  kernel/rcu/tree.c                   |  16 ++--
>  kernel/rcu/tree.h                   |  10 ++-
>  kernel/rcu/tree_plugin.h            |  32 ++++---
>  kernel/sched/Makefile               |   2 +-
>  kernel/sched/swait.c                | 122 +++++++++++++++++++++++++
>  virt/kvm/async_pf.c                 |   4 +-
>  virt/kvm/kvm_main.c                 |  17 ++--
>  17 files changed, 373 insertions(+), 66 deletions(-)
>  create mode 100644 include/linux/swait.h
>  create mode 100644 kernel/sched/swait.c
> 
> -- 
> 2.4.3
> 

