From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/10] scsi/fcoe: Fix get_cpu()/put_cpu_light() imbalance in
 fcoe_recv_frame()
Date: Thu, 22 Sep 2016 22:49:31 -0400
Message-ID: <20160923024938.331662264@goodmis.org>
References: <20160923024927.685936218@goodmis.org>
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
Content-Disposition: inline; filename=0004-scsi-fcoe-Fix-get_cpu-put_cpu_light-imbalance-in-fco.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.79-rt85-rc1 stable review patch.
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
index 9df3ba445d03..d24665c27bef 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1816,7 +1816,7 @@ static void fcoe_recv_frame(struct sk_buff *skb)
 	 */
 	hp = (struct fcoe_hdr *) skb_network_header(skb);
 
-	stats = per_cpu_ptr(lport->stats, get_cpu());
+	stats = per_cpu_ptr(lport->stats, get_cpu_light());
 	if (unlikely(FC_FCOE_DECAPS_VER(hp) != FC_FCOE_VER)) {
 		if (stats->ErrorFrames < 5)
 			printk(KERN_WARNING "fcoe: FCoE version "
-- 
2.8.1
