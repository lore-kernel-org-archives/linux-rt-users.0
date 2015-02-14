From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3.14-rt] sas-ata/isci: dont't disable interrupts in qc_issue handler
Date: Sat, 14 Feb 2015 11:01:16 -0500
Message-ID: <1423929676-35724-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:64554 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbbBNQBX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 14 Feb 2015 11:01:23 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t1EG1NwE007072
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Sat, 14 Feb 2015 08:01:23 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 3.14-rt we see the following trace on Canoe Pass for
SCSI_ISCI "Intel(R) C600 Series Chipset SAS Controller"
when the sas qc_issue handler is run:

 BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:905
 in_atomic(): 0, irqs_disabled(): 1, pid: 432, name: udevd
 CPU: 11 PID: 432 Comm: udevd Not tainted 3.14.28-rt22 #2
 Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.01.0002.082220131453 08/22/2013
 ffff880fab500000 ffff880fa9f239c0 ffffffff81a2d273 0000000000000000
 ffff880fa9f239d8 ffffffff8107f023 ffff880faac23dc0 ffff880fa9f239f0
 ffffffff81a33cc0 ffff880faaeb1400 ffff880fa9f23a40 ffffffff815de891
 Call Trace:
 [<ffffffff81a2d273>] dump_stack+0x4e/0x7a
 [<ffffffff8107f023>] __might_sleep+0xe3/0x160
 [<ffffffff81a33cc0>] rt_spin_lock+0x20/0x50
 [<ffffffff815de891>] isci_task_execute_task+0x171/0x2f0  <-----
 [<ffffffff815cfecb>] sas_ata_qc_issue+0x25b/0x2a0
 [<ffffffff81606363>] ata_qc_issue+0x1f3/0x370
 [<ffffffff8160c600>] ? ata_scsi_invalid_field+0x40/0x40
 [<ffffffff8160c8f5>] ata_scsi_translate+0xa5/0x1b0
 [<ffffffff8160efc6>] ata_sas_queuecmd+0x86/0x280
 [<ffffffff815ce446>] sas_queuecommand+0x196/0x230
 [<ffffffff81081fad>] ? get_parent_ip+0xd/0x50
 [<ffffffff815b05a4>] scsi_dispatch_cmd+0xb4/0x210
 [<ffffffff815b7744>] scsi_request_fn+0x314/0x530

and gdb shows:

(gdb) list * isci_task_execute_task+0x171
0xffffffff815ddfb1 is in isci_task_execute_task (drivers/scsi/isci/task.c:138).
133             dev_dbg(&ihost->pdev->dev, "%s: num=%d\n", __func__, num);
134
135             for_each_sas_task(num, task) {
136                     enum sci_status status = SCI_FAILURE;
137
138                     spin_lock_irqsave(&ihost->scic_lock, flags);    <-----
139                     idev = isci_lookup_device(task->dev);
140                     io_ready = isci_device_io_ready(idev, task);
141                     tag = isci_alloc_tag(ihost);
142                     spin_unlock_irqrestore(&ihost->scic_lock, flags);
(gdb)

In addition to the scic_lock, the function also contains locking of
the task_state_lock -- which is clearly not a candidate for raw lock
conversion.  As can be seen by the comment nearby, we really should
be running the qc_issue code with interrupts enabled anyway.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index d2895836f9fa..c85e07ab51e4 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -191,7 +191,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	/* TODO: audit callers to ensure they are ready for qc_issue to
 	 * unconditionally re-enable interrupts
 	 */
-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	spin_unlock(ap->lock);
 
 	/* If the device fell off, no sense in issuing commands */
@@ -261,7 +261,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 
  out:
 	spin_lock(ap->lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 	return ret;
 }
 
-- 
2.1.0

