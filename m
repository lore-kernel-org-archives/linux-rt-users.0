From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/3] net: gianfar: Fix missing return of gfar_clean_tx_ring()
Date: Wed, 30 Apr 2014 20:47:59 -0400
Message-ID: <20140501005004.406079574@goodmis.org>
References: <20140501004757.583708392@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-net-gianfar-Fix-missing-return-of-gfar_clean_tx_ring.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.12.15-rt26-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

The patch "net: gianfar: do not try to cleanup TX packets if they are
not done" for 3.12-rt left out the return value for gfar_clean_tx_ring().
This would cause an error when building this module. Note, this module
does not build on x86 and was not tested because of that.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/net/ethernet/freescale/gianfar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 091945c..df27493 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2615,6 +2615,7 @@ static int gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
 	tx_queue->dirty_tx = bdp;
 
 	netdev_tx_completed_queue(txq, howmany, bytes_sent);
+	return howmany;
 }
 
 static void gfar_schedule_cleanup(struct gfar_priv_grp *gfargrp)
-- 
1.8.5.3
