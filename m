From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/3] Linux 3.2.57-rt84-rc1
Date: Sun, 27 Apr 2014 10:39:25 -0400
Message-ID: <20140427143925.177486597@goodmis.org>
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

This is the RT stable review cycle of patch 3.2.57-rt84-rc1.

Please scream at me if I messed something up. Please test the patches too.

The -rc release will be uploaded to kernel.org and will be deleted when
the final release is out. This is just a review release (or release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main release
on 4/30/2014.

Enjoy,

-- Steve


To build 3.2.57-rt84-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.2.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.2.57.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2.57-rt84-rc1.patch.xz

You can also build from 3.2.57-rt83 by applying the incremental patch:

http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2.57-rt83-rt84-rc1.patch.xz


Changes from 3.2.57-rt83:

---


Sebastian Andrzej Siewior (2):
      net: gianfar: do not disable interrupts
      rcu: make RCU_BOOST default on RT

Steven Rostedt (Red Hat) (1):
      Linux 3.2.57-rt84-rc1

----
 drivers/net/ethernet/freescale/gianfar.c         | 16 ++++++++--------
 drivers/net/ethernet/freescale/gianfar_ethtool.c |  8 ++++----
 drivers/net/ethernet/freescale/gianfar_sysfs.c   | 24 ++++++++++++------------
 init/Kconfig                                     |  2 +-
 localversion-rt                                  |  2 +-
 5 files changed, 26 insertions(+), 26 deletions(-)
