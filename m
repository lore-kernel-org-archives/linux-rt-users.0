From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/5] Linux 3.12.40-rt56-rc1
Date: Thu, 14 May 2015 10:01:37 -0400
Message-ID: <20150514140137.396749660@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35657 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030264AbbENOBx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 10:01:53 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Dear RT Folks,

This is the RT stable review cycle of patch 3.12.40-rt56-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 5/18/2015.

Enjoy,

-- Steve


To build 3.12.40-rt56-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.12.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.12.40.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/patch-3.12.40-rt56-rc1.patch.xz

You can also build from 3.12.40-rt55 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.12/incr/patch-3.12.40-rt55-rt56-rc1.patch.xz


Changes from 3.12.40-rt55:

---


Marcelo Tosatti (2):
      KVM: lapic: mark LAPIC timer handler as irqsafe
      KVM: use simple waitqueue for vcpu->wq

Mike Galbraith (1):
      hotplug: Use set_cpus_allowed_ptr() in sync_unplug_thread()

Sebastian Andrzej Siewior (1):
      kernel/irq_work: fix no_hz deadlock

Steven Rostedt (Red Hat) (1):
      Linux 3.12.40-rt56-rc1

----
 arch/arm/kvm/arm.c                  |  4 ++--
 arch/arm/kvm/psci.c                 |  4 ++--
 arch/powerpc/include/asm/kvm_host.h |  4 ++--
 arch/powerpc/kernel/time.c          |  2 +-
 arch/powerpc/kvm/book3s_hv.c        | 20 ++++++++--------
 arch/s390/include/asm/kvm_host.h    |  2 +-
 arch/sparc/kernel/pcr.c             |  2 --
 arch/x86/kernel/irq_work.c          |  2 --
 arch/x86/kvm/lapic.c                | 48 ++++++++++++++++++++++++++++++++-----
 include/linux/kvm_host.h            |  4 ++--
 kernel/cpu.c                        |  2 +-
 kernel/irq_work.c                   |  5 +---
 kernel/time/tick-sched.c            |  5 ++++
 kernel/timer.c                      |  2 +-
 localversion-rt                     |  2 +-
 virt/kvm/async_pf.c                 |  4 ++--
 virt/kvm/kvm_main.c                 | 16 ++++++-------
 17 files changed, 81 insertions(+), 47 deletions(-)
