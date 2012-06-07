From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/4] scsi: qla2xxx: Use local_irq_save_nort() in qla2x00_poll
Date: Thu, 07 Jun 2012 11:51:49 -0400
Message-ID: <20120607155221.445178514@goodmis.org>
References: <20120607155148.698959275@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	David Sommerseth <davids@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-scsi-qla2xxx-Use-local_irq_save_nort-in-qla2x00_poll.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: John Kacur <jkacur@redhat.com>

RT triggers the following:

[   11.307652]  [<ffffffff81077b27>] __might_sleep+0xe7/0x110
[   11.307663]  [<ffffffff8150e524>] rt_spin_lock+0x24/0x60
[   11.307670]  [<ffffffff8150da78>] ? rt_spin_lock_slowunlock+0x78/0x90
[   11.307703]  [<ffffffffa0272d83>] qla24xx_intr_handler+0x63/0x2d0 [qla2xxx]
[   11.307736]  [<ffffffffa0262307>] qla2x00_poll+0x67/0x90 [qla2xxx]

Function qla2x00_poll does local_irq_save() before calling qla24xx_intr_handler
which has a spinlock. Since spinlocks are sleepable on rt, it is not allowed
to call them with interrupts disabled. Therefore we use local_irq_save_nort()
instead which saves flags without disabling interrupts.

This fix needs to be applied to v3.0-rt, v3.2-rt and v3.4-rt

Suggested-by: Thomas Gleixner
Signed-off-by: John Kacur <jkacur@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: David Sommerseth <davids@redhat.com>
Link: http://lkml.kernel.org/r/1335523726-10024-1-git-send-email-jkacur@redhat.com
Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/scsi/qla2xxx/qla_inline.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 4c8167e..e5e99e9 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -36,12 +36,12 @@ qla2x00_poll(struct rsp_que *rsp)
 {
 	unsigned long flags;
 	struct qla_hw_data *ha = rsp->hw;
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (IS_QLA82XX(ha))
 		qla82xx_poll(0, rsp);
 	else
 		ha->isp_ops->intr_handler(0, rsp);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }
 
 static inline uint8_t *
-- 
1.7.10
