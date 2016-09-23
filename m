From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/8] scsi/fcoe: Fix get_cpu()/put_cpu_light() imbalance in
 fcoe_recv_frame()
Date: Fri, 23 Sep 2016 11:30:34 -0400
Message-ID: <20160923153202.868583110@goodmis.org>
References: <20160923153031.676858930@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        <stable-rt@vger.kernel.org>,
        Mike Gabraith <umgwanakikbuti@gmail.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-scsi-fcoe-Fix-get_cpu-put_cpu_light-imbalance-in-fco.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.10.103-rt115-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

During master->rt merge, I stumbled across the buglet below.

Fix get_cpu()/put_cpu_light() imbalance.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Gabraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/scsi/fcoe/fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 7586dd90d67e..26fa668e5b4c 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1805,7 +1805,7 @@ static void fcoe_recv_frame(struct sk_buff *skb)
 	 */
 	hp = (struct fcoe_hdr *) skb_network_header(skb);
 
-	stats = per_cpu_ptr(lport->stats, get_cpu());
+	stats = per_cpu_ptr(lport->stats, get_cpu_light());
 	if (unlikely(FC_FCOE_DECAPS_VER(hp) != FC_FCOE_VER)) {
 		if (stats->ErrorFrames < 5)
 			printk(KERN_WARNING "fcoe: FCoE version "
-- 
2.8.1
