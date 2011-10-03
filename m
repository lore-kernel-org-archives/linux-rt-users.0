From: Venkat Subbiah <venkat.subbiah@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Mark SMP-IPI interrupt as IRQF_NO_THREAD
Date: Mon,  3 Oct 2011 13:31:10 -0700
Message-ID: <1317673870-10671-1-git-send-email-venkat.subbiah@caviumnetworks.com>
Cc: linux-rt-users@vger.kernel.org, david.daney@cavium.com
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7806 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753172Ab1JCUcH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 3 Oct 2011 16:32:07 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Venkat Subbiah <venkat.subbiah@cavium.com>

This is to exclude it from force threading to allow RT patch set to work.
And while on this line
* Remove IRQF_DISABLED as as this flag is NOOP
* Add IRQF_PERCPU as this is a per cpu interrupt.


Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/smp.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
index 8b60642..efcfff4 100644
--- a/arch/mips/cavium-octeon/smp.c
+++ b/arch/mips/cavium-octeon/smp.c
@@ -207,8 +207,9 @@ void octeon_prepare_cpus(unsigned int max_cpus)
 	 * the other bits alone.
 	 */
 	cvmx_write_csr(CVMX_CIU_MBOX_CLRX(cvmx_get_core_num()), 0xffff);
-	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt, IRQF_DISABLED,
-			"SMP-IPI", mailbox_interrupt)) {
+	if (request_irq(OCTEON_IRQ_MBOX0, mailbox_interrupt,
+			IRQF_PERCPU | IRQF_NO_THREAD, "SMP-IPI",
+			mailbox_interrupt)) {
 		panic("Cannot request_irq(OCTEON_IRQ_MBOX0)\n");
 	}
 }
-- 
1.7.0.4

