From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 12/20] drivers/block/zram: fixup compile for !RT
Date: Tue, 12 Jul 2016 10:24:17 -0400
Message-ID: <20160712142419.533751183@goodmis.org>
References: <20160712142405.634544943@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0012-drivers-block-zram-fixup-compile-for-RT.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.27-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/block/zram/zram_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 5f1eb86a307b..22c0173b00e3 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -137,7 +137,7 @@ static inline void zram_unlock_table(struct zram_table_entry *table)
 	bit_spin_unlock(ZRAM_ACCESS, &table->value);
 }
 
-static inline void zram_meta_init_locks(struct zram_meta *meta, u64 disksize) { }
+static inline void zram_meta_init_table_locks(struct zram_meta *meta, u64 disksize) { }
 #else /* CONFIG_PREEMPT_RT_BASE */
 static inline void zram_lock_table(struct zram_table_entry *table)
 {
-- 
2.8.1
