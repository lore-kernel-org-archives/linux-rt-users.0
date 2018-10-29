From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/2] Linux v4.4.162-rt176-rc1
Date: Mon, 29 Oct 2018 21:16:15 +0100
Message-ID: <20181029201617.24733-1-wagi@monom.org>
Cc: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch v4.4.162-rt176-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2018-11-05.

Enjoy,

-- Daniel


Daniel Wagner (2):
  x86/kconfig: Fall back to ticket spinlocks
  Linux 4.4.162-rt176-rc1

 arch/x86/Kconfig | 1 -
 localversion-rt  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.14.4
