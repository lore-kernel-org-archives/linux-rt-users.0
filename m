From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/10] scsi/fcoe: Fix get_cpu()/put_cpu_light() imbalance in
 fcoe_recv_frame()
Date: Thu, 22 Sep 2016 19:17:32 -0400
Message-ID: <20160922231741.780240629@goodmis.org>
References: <20160922231728.394180695@goodmis.org>
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
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757445AbcIVXRs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 19:17:48 -0400
Content-Disposition: inline; filename=0004-scsi-fcoe-Fix-get_cpu-put_cpu_light-imbalance-in-fco.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.42-rt45-rc1 stable review patch.
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
index c1f2bd0bcdb7..8933c02b6729 100644
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


