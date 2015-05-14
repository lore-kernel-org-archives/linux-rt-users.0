From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/2] Linux 3.4.107-rt134-rc1
Date: Thu, 14 May 2015 10:07:21 -0400
Message-ID: <20150514140721.234319563@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

This is the RT stable review cycle of patch 3.4.107-rt134-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 5/18/2015.

Enjoy,

-- Steve


To build 3.4.107-rt134-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.107.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.107-rt134-rc1.patch.xz

You can also build from 3.4.107-rt133 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.107-rt133-rt134-rc1.patch.xz


Changes from 3.4.107-rt133:

---


Marcelo Tosatti (1):
      KVM: lapic: mark LAPIC timer handler as irqsafe

Steven Rostedt (Red Hat) (1):
      Linux 3.4.107-rt134-rc1

----
 arch/x86/kvm/lapic.c | 42 +++++++++++++++++++++++++++++++++++++++---
 localversion-rt      |  2 +-
 2 files changed, 40 insertions(+), 4 deletions(-)
