From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 4.4.21-rt30
Date: Wed, 21 Sep 2016 14:55:21 -0400
Message-ID: <20160921145521.4042c25a@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.4.21-rt30 stable release.

Note, 4.4.21-rt29 was released with just the stable updates. This has
a fix for a broken build that was caused by a previous stable merge.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: c12d36b1603022530ddceb79c2e182799b4c6634


Or to build 4.4.21-rt30 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.21.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/patch-4.4.21-rt30.patch.xz



You can also build from 4.4.21-rt29 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/incr/patch-4.4.21-rt29-rt30.patch.xz



Enjoy,

-- Steve


Changes from v4.4.21-rt29:

---

Juerg Haefliger (1):
      hyperv: Fix compilation issue with 4.4.19-rt27

Steven Rostedt (Red Hat) (1):
      Linux 4.4.21-rt30

----
 drivers/hv/vmbus_drv.c | 2 +-
 localversion-rt        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---------------------------
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 509ed9731630..b2498b270f2c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -820,7 +820,7 @@ static void vmbus_isr(void)
 			tasklet_schedule(&msg_dpc);
 	}
 
-	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0);
+	add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR, 0, 0);
 }
 
 
diff --git a/localversion-rt b/localversion-rt
index 90290c642ed5..b72862e06be4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt29
+-rt30
