From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch-rt] scsi/fcoe: Fix get_cpu()/put_cpu_light() imbalance in
 fcoe_recv_frame()
Date: Thu, 28 Jul 2016 06:04:49 +0200
Message-ID: <1469678689.3889.10.camel@gmail.com>
References: <20160715114803.GA11606@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34660 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbcG1EEw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2016 00:04:52 -0400
In-Reply-To: <20160715114803.GA11606@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

During master->rt merge, I stumbled across the buglet below.

Fix get_cpu()/put_cpu_light() imbalance.

Signed-off-by: Mike Gabraith <umgwanakikbuti@gmail.com>
---
 drivers/scsi/fcoe/fcoe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1814,7 +1814,7 @@ static void fcoe_recv_frame(struct sk_bu
 	 */
 	hp = (struct fcoe_hdr *) skb_network_header(skb);
 
-	stats = per_cpu_ptr(lport->stats, get_cpu());
+	stats = per_cpu_ptr(lport->stats, get_cpu_light());
 	if (unlikely(FC_FCOE_DECAPS_VER(hp) != FC_FCOE_VER)) {
 		if (stats->ErrorFrames < 5)
 			printk(KERN_WARNING "fcoe: FCoE version "
