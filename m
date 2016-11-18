From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: RT_PREEMPT on Raspberry PI 3
Date: Fri, 18 Nov 2016 08:21:44 -0600
Message-ID: <20161118142143.GA19506@unpythonic.net>
References: <2c0e540f-c501-f65b-1292-782e12f71039@fastwebnet.it>
 <20160922141041.ytyils2x3ehzoqhb@linutronix.de>
 <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuliano Colla <giuliano.colla@fastwebnet.it>,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oussama Ghorbel <ghorbel@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from afk.unpythonic.net ([138.68.55.246]:43129 "EHLO
        afk.unpythonic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbcKROv6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Nov 2016 09:51:58 -0500
Content-Disposition: inline
In-Reply-To: <CABfLueFUNmudobECEZ_jt4Q6ixqOSeTajKW2SpdLJW=Qi0zQyg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

FWIW the plain text version of the patch appears to be at
https://www.osadl.org/monitoring/patches/rbs3s/usb-dwc_otg-fix-system-lockup-when-interrupts-are-threaded.patch
I've included the current version of that patch inline below for reference.

Jeff

-- >8 --
From: Oussama Ghorbel <ghorbel@gmail.com>
Date: Sun, 6 Nov 2016 00:16:02 +0100
Subject: [PATCH] usb: dwc_otg: fix system lockup when interrupts are threaded

Fix lockup in dwc_otg driver that leads to a system freeze of the
4-core Raspberry Pi board when RT Preempt kernel is in use or when
interrupts are threaded in general.
The lockup occurs when the irq handler thread gets preempted while it
holds the fiq spin lock.
The patch makes sure to disable local irq while fiq spin lock is held
irrespective of whether the interrupt is threaded or not.
The patch also unifies the use of the fiq spin lock outside the fiq
handler by introducing two function-like macros fiq_fsm_spin_lock_irqsave
and fiq_fsm_spin_unlock_irqrestore.

Under RT kernel, the bug can be reproduced in a few minutes by running
hackbench and cyclictest in this way
$ ( while true; do nice hackbench 30 >/dev/null; done )&
$ echo "run 'kill $!' to stop hackbench"
$ cyclictest -a -t -n -p 80

Signed-off-by: Oussama Ghorbel <ghorbel@gmail.com>

---
 drivers/usb/host/dwc_otg/dwc_otg_fiq_fsm.h   |   14 +++++++++
 drivers/usb/host/dwc_otg/dwc_otg_hcd.c       |   40 +++++++++++----------------
 drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c  |   39 ++++++++++----------------
 drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c |   14 ++++-----
 4 files changed, 52 insertions(+), 55 deletions(-)

Index: linux-4.6.5-rt10-v7/drivers/usb/host/dwc_otg/dwc_otg_fiq_fsm.h
===================================================================
--- linux-4.6.5-rt10-v7.orig/drivers/usb/host/dwc_otg/dwc_otg_fiq_fsm.h
+++ linux-4.6.5-rt10-v7/drivers/usb/host/dwc_otg/dwc_otg_fiq_fsm.h
@@ -373,4 +373,18 @@ extern void dwc_otg_fiq_fsm(struct fiq_s
 
 extern void dwc_otg_fiq_nop(struct fiq_state *state);
 
+#define fiq_fsm_spin_lock_irqsave(lock, flags)		\
+	do {						\
+		local_fiq_disable();			\
+		local_irq_save(flags);			\
+		fiq_fsm_spin_lock(lock);		\
+	} while (0)
+
+#define fiq_fsm_spin_unlock_irqrestore(lock, flags)	\
+	do {						\
+		fiq_fsm_spin_unlock(lock);		\
+		local_irq_restore(flags);		\
+		local_fiq_enable();			\
+	} while (0)
+
 #endif /* DWC_OTG_FIQ_FSM_H_ */
Index: linux-4.6.5-rt10-v7/drivers/usb/host/dwc_otg/dwc_otg_hcd.c
===================================================================
--- linux-4.6.5-rt10-v7.orig/drivers/usb/host/dwc_otg/dwc_otg_hcd.c
+++ linux-4.6.5-rt10-v7/drivers/usb/host/dwc_otg/dwc_otg_hcd.c
@@ -1418,12 +1418,11 @@ static void assign_and_init_hc(dwc_otg_h
 
 	dwc_otg_hc_init(hcd->core_if, hc);
 
-	local_irq_save(flags);
 
-	if (fiq_enable) {
-		local_fiq_disable();
-		fiq_fsm_spin_lock(&hcd->fiq_state->lock);
-	}
+	if (fiq_enable)
+		fiq_fsm_spin_lock_irqsave(&hcd->fiq_state->lock, flags);
+	else
+		local_irq_save(flags);
 
 	/* Enable the top level host channel interrupt. */
 	intr_enable = (1 << hc->hc_num);
@@ -1433,12 +1432,10 @@ static void assign_and_init_hc(dwc_otg_h
 	gintmsk.b.hcintr = 1;
 	DWC_MODIFY_REG32(&hcd->core_if->core_global_regs->gintmsk, 0, gintmsk.d32);
 
-	if (fiq_enable) {
-		fiq_fsm_spin_unlock(&hcd->fiq_state->lock);
-		local_fiq_enable();
-	}
-	
-	local_irq_restore(flags);
+	if (fiq_enable)
+		fiq_fsm_spin_unlock_irqrestore(&hcd->fiq_state->lock, flags);
+	else
+		local_irq_restore(flags);
 	hc->qh = qh;
 }
 
@@ -1616,6 +1613,7 @@ int fiq_fsm_queue_isoc_transaction(dwc_o
 	int xfer_len, nrpackets;
 	hcdma_data_t hcdma;
 	hfnum_data_t hfnum;
+	unsigned long flags;
 
 	if (st->fsm != FIQ_PASSTHROUGH)
 		return 0;
@@ -1691,8 +1689,7 @@ int fiq_fsm_queue_isoc_transaction(dwc_o
 	fiq_print(FIQDBG_INT, hcd->fiq_state, "%08x", st->hctsiz_copy.d32);
 	fiq_print(FIQDBG_INT, hcd->fiq_state, "%08x", st->hcdma_copy.d32);
 	hfnum.d32 = DWC_READ_REG32(&hcd->core_if->host_if->host_global_regs->hfnum);
-	local_fiq_disable();
-	fiq_fsm_spin_lock(&hcd->fiq_state->lock);
+	fiq_fsm_spin_lock_irqsave(&hcd->fiq_state->lock, flags);
 	DWC_WRITE_REG32(&hc_regs->hctsiz, st->hctsiz_copy.d32);
 	DWC_WRITE_REG32(&hc_regs->hcsplt, st->hcsplt_copy.d32);
 	DWC_WRITE_REG32(&hc_regs->hcdma, st->hcdma_copy.d32);
@@ -1712,8 +1709,7 @@ int fiq_fsm_queue_isoc_transaction(dwc_o
 	}
 	mb();
 	st->hcchar_copy.b.chen = 0;
-	fiq_fsm_spin_unlock(&hcd->fiq_state->lock);
-	local_fiq_enable();
+	fiq_fsm_spin_unlock_irqrestore(&hcd->fiq_state->lock, flags);
 	return 0;
 }
 
@@ -1739,6 +1735,7 @@ int fiq_fsm_queue_split_transaction(dwc_
 	/* Program HC registers, setup FIQ_state, examine FIQ if periodic, start transfer (not if uframe 5) */
 	int hub_addr, port_addr, frame, uframe;
 	struct fiq_channel_state *st = &hcd->fiq_state->channel[hc->hc_num];
+	unsigned long flags;
 
 	if (st->fsm != FIQ_PASSTHROUGH)
 		return 0;
@@ -1847,8 +1844,7 @@ int fiq_fsm_queue_split_transaction(dwc_
 	DWC_WRITE_REG32(&hc_regs->hcchar, st->hcchar_copy.d32);
 	DWC_WRITE_REG32(&hc_regs->hcintmsk, st->hcintmsk_copy.d32);
 
-	local_fiq_disable();
-	fiq_fsm_spin_lock(&hcd->fiq_state->lock);
+	fiq_fsm_spin_lock_irqsave(&hcd->fiq_state->lock, flags);
 
 	if (hc->ep_type & 0x1) {
 		hfnum.d32 = DWC_READ_REG32(&hcd->core_if->host_if->host_global_regs->hfnum);
@@ -1947,8 +1943,7 @@ int fiq_fsm_queue_split_transaction(dwc_
 		DWC_WRITE_REG32(&hc_regs->hcchar, st->hcchar_copy.d32);
 	}
 	mb();
-	fiq_fsm_spin_unlock(&hcd->fiq_state->lock);
-	local_fiq_enable();
+	fiq_fsm_spin_unlock_irqrestore(&hcd->fiq_state->lock, flags);
 	return 0;
 }
 
@@ -2442,6 +2437,7 @@ static void process_non_periodic_channel
 void dwc_otg_hcd_queue_transactions(dwc_otg_hcd_t * hcd,
 				    dwc_otg_transaction_type_e tr_type)
 {
+	unsigned long flags;
 #ifdef DEBUG_SOF
 	DWC_DEBUGPL(DBG_HCD, "Queue Transactions\n");
 #endif
@@ -2467,11 +2463,9 @@ void dwc_otg_hcd_queue_transactions(dwc_
 			gintmsk.b.nptxfempty = 1;
 
 			if (fiq_enable) {
-				local_fiq_disable();
-				fiq_fsm_spin_lock(&hcd->fiq_state->lock);
+				fiq_fsm_spin_lock_irqsave(&hcd->fiq_state->lock, flags);
 				DWC_MODIFY_REG32(&hcd->core_if->core_global_regs->gintmsk, gintmsk.d32, 0);
-				fiq_fsm_spin_unlock(&hcd->fiq_state->lock);
-				local_fiq_enable();
+				fiq_fsm_spin_unlock_irqrestore(&hcd->fiq_state->lock, flags);
 			} else {
 				DWC_MODIFY_REG32(&hcd->core_if->core_global_regs->gintmsk, gintmsk.d32, 0);
 			}
Index: linux-4.6.5-rt10-v7/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
===================================================================
--- linux-4.6.5-rt10-v7.orig/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
+++ linux-4.6.5-rt10-v7/drivers/usb/host/dwc_otg/dwc_otg_hcd_intr.c
@@ -107,6 +107,7 @@ int32_t dwc_otg_hcd_handle_intr(dwc_otg_
 	gintmsk_data_t gintmsk;
 	hfnum_data_t hfnum;
 	haintmsk_data_t haintmsk;
+	unsigned long flags;
 
 #ifdef DEBUG
 	dwc_otg_core_global_regs_t *global_regs = core_if->core_global_regs;
@@ -124,8 +125,7 @@ int32_t dwc_otg_hcd_handle_intr(dwc_otg_
 	/* Check if HOST Mode */
 	if (dwc_otg_is_host_mode(core_if)) {
 		if (fiq_enable) {
-			local_fiq_disable();
-			fiq_fsm_spin_lock(&dwc_otg_hcd->fiq_state->lock);
+			fiq_fsm_spin_lock_irqsave(&dwc_otg_hcd->fiq_state->lock, flags);
 			/* Pull in from the FIQ's disabled mask */
 			gintmsk.d32 = gintmsk.d32 | ~(dwc_otg_hcd->fiq_state->gintmsk_saved.d32);
 			dwc_otg_hcd->fiq_state->gintmsk_saved.d32 = ~0;
@@ -144,8 +144,7 @@ int32_t dwc_otg_hcd_handle_intr(dwc_otg_
 		gintsts.d32 &= gintmsk.d32;
 
 		if (fiq_enable) {
-			fiq_fsm_spin_unlock(&dwc_otg_hcd->fiq_state->lock);
-			local_fiq_enable();
+			fiq_fsm_spin_unlock_irqrestore(&dwc_otg_hcd->fiq_state->lock, flags);
 		}
 
 		if (!gintsts.d32) {
@@ -192,11 +191,9 @@ int32_t dwc_otg_hcd_handle_intr(dwc_otg_
 			gintmsk_data_t gintmsk = { .b.portintr = 1};
 			retval |= dwc_otg_hcd_handle_port_intr(dwc_otg_hcd);
 			if (fiq_enable) {
-				local_fiq_disable();
-				fiq_fsm_spin_lock(&dwc_otg_hcd->fiq_state->lock);
+				fiq_fsm_spin_lock_irqsave(&dwc_otg_hcd->fiq_state->lock, flags);
 				DWC_MODIFY_REG32(&dwc_otg_hcd->core_if->core_global_regs->gintmsk, 0, gintmsk.d32);
-				fiq_fsm_spin_unlock(&dwc_otg_hcd->fiq_state->lock);
-				local_fiq_enable();
+				fiq_fsm_spin_unlock_irqrestore(&dwc_otg_hcd->fiq_state->lock, flags);
 			} else {
 				DWC_MODIFY_REG32(&dwc_otg_hcd->core_if->core_global_regs->gintmsk, 0, gintmsk.d32);
 			}
@@ -236,8 +233,7 @@ exit_handler_routine:
 	if (fiq_enable)	{
 		gintmsk_data_t gintmsk_new;
 		haintmsk_data_t haintmsk_new;
-		local_fiq_disable();
-		fiq_fsm_spin_lock(&dwc_otg_hcd->fiq_state->lock);
+		fiq_fsm_spin_lock_irqsave(&dwc_otg_hcd->fiq_state->lock, flags);
 		gintmsk_new.d32 = *(volatile uint32_t *)&dwc_otg_hcd->fiq_state->gintmsk_saved.d32;
 		if(fiq_fsm_enable)
 			haintmsk_new.d32 = *(volatile uint32_t *)&dwc_otg_hcd->fiq_state->haintmsk_saved.d32;
@@ -260,8 +256,7 @@ exit_handler_routine:
 		haintmsk.d32 = DWC_READ_REG32(&core_if->host_if->host_global_regs->haintmsk);
 		/* Re-enable interrupts that the FIQ masked (first time round) */
 		FIQ_WRITE(dwc_otg_hcd->fiq_state->dwc_regs_base + GINTMSK, gintmsk.d32);
-		fiq_fsm_spin_unlock(&dwc_otg_hcd->fiq_state->lock);
-		local_fiq_enable();
+		fiq_fsm_spin_unlock_irqrestore(&dwc_otg_hcd->fiq_state->lock, flags);
 
 		if ((jiffies / HZ) > last_time) {
 			//dwc_otg_qh_t *qh;
@@ -659,6 +654,7 @@ int32_t dwc_otg_hcd_handle_hc_intr(dwc_o
 {
 	int i;
 	int retval = 0;
+	unsigned long flags;
 	haint_data_t haint = { .d32 = 0 } ;
 
 	/* Clear appropriate bits in HCINTn to clear the interrupt bit in
@@ -671,12 +667,10 @@ int32_t dwc_otg_hcd_handle_hc_intr(dwc_o
 	if(fiq_fsm_enable)
 	{
 		/* check the mask? */
-		local_fiq_disable();
-		fiq_fsm_spin_lock(&dwc_otg_hcd->fiq_state->lock);
+		fiq_fsm_spin_lock_irqsave(&dwc_otg_hcd->fiq_state->lock, flags);
 		haint.b2.chint |= ~(dwc_otg_hcd->fiq_state->haintmsk_saved.b2.chint);
 		dwc_otg_hcd->fiq_state->haintmsk_saved.b2.chint = ~0;
-		fiq_fsm_spin_unlock(&dwc_otg_hcd->fiq_state->lock);
-		local_fiq_enable();
+		fiq_fsm_spin_unlock_irqrestore(&dwc_otg_hcd->fiq_state->lock, flags);
 	}
 
 	for (i = 0; i < dwc_otg_hcd->core_if->core_params->host_channels; i++) {
@@ -1088,6 +1082,7 @@ static void halt_channel(dwc_otg_hcd_t *
 			 dwc_hc_t * hc,
 			 dwc_otg_qtd_t * qtd, dwc_otg_halt_status_e halt_status)
 {
+	unsigned long flags;
 	if (hcd->core_if->dma_enable) {
 		release_channel(hcd, hc, qtd, halt_status);
 		return;
@@ -1110,11 +1105,9 @@ static void halt_channel(dwc_otg_hcd_t *
 			 */
 			gintmsk.b.nptxfempty = 1;
 			if (fiq_enable) {
-				local_fiq_disable();
-				fiq_fsm_spin_lock(&hcd->fiq_state->lock);
+				fiq_fsm_spin_lock_irqsave(&hcd->fiq_state->lock, flags);
 				DWC_MODIFY_REG32(&global_regs->gintmsk, 0, gintmsk.d32);
-				fiq_fsm_spin_unlock(&hcd->fiq_state->lock);
-				local_fiq_enable();
+				fiq_fsm_spin_unlock_irqrestore(&hcd->fiq_state->lock, flags);
 			} else {
 				DWC_MODIFY_REG32(&global_regs->gintmsk, 0, gintmsk.d32);
 			}
@@ -1135,11 +1128,9 @@ static void halt_channel(dwc_otg_hcd_t *
 			 */
 			gintmsk.b.ptxfempty = 1;
 			if (fiq_enable) {
-				local_fiq_disable();
-				fiq_fsm_spin_lock(&hcd->fiq_state->lock);
+				fiq_fsm_spin_lock_irqsave(&hcd->fiq_state->lock, flags);
 				DWC_MODIFY_REG32(&global_regs->gintmsk, 0, gintmsk.d32);
-				fiq_fsm_spin_unlock(&hcd->fiq_state->lock);
-				local_fiq_enable();
+				fiq_fsm_spin_unlock_irqrestore(&hcd->fiq_state->lock, flags);
 			} else {
 				DWC_MODIFY_REG32(&global_regs->gintmsk, 0, gintmsk.d32);
 			}
Index: linux-4.6.5-rt10-v7/drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c
===================================================================
--- linux-4.6.5-rt10-v7.orig/drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c
+++ linux-4.6.5-rt10-v7/drivers/usb/host/dwc_otg/dwc_otg_hcd_queue.c
@@ -671,6 +671,7 @@ static int schedule_periodic(dwc_otg_hcd
 int dwc_otg_hcd_qh_add(dwc_otg_hcd_t * hcd, dwc_otg_qh_t * qh)
 {
 	int status = 0;
+	unsigned long flags;
 	gintmsk_data_t intr_mask = {.d32 = 0 };
 
 	if (!DWC_LIST_EMPTY(&qh->qh_list_entry)) {
@@ -689,11 +690,9 @@ int dwc_otg_hcd_qh_add(dwc_otg_hcd_t * h
 		if ( !hcd->periodic_qh_count ) {
 			intr_mask.b.sofintr = 1;
 			if (fiq_enable) {
-				local_fiq_disable();
-				fiq_fsm_spin_lock(&hcd->fiq_state->lock);
+				fiq_fsm_spin_lock_irqsave(&hcd->fiq_state->lock, flags);
 				DWC_MODIFY_REG32(&hcd->core_if->core_global_regs->gintmsk, intr_mask.d32, intr_mask.d32);
-				fiq_fsm_spin_unlock(&hcd->fiq
100 13425  100 13425    0     0  20549      0 --:--:-- --:--:-- --:--:-- 20527
_state->lock);
-				local_fiq_enable();
+				fiq_fsm_spin_unlock_irqrestore(&hcd->fiq_state->lock, flags);
 			} else {
 				DWC_MODIFY_REG32(&hcd->core_if->core_global_regs->gintmsk, intr_mask.d32, intr_mask.d32);
 			}
@@ -737,6 +736,7 @@ static void deschedule_periodic(dwc_otg_
  * @param qh QH to remove from schedule. */
 void dwc_otg_hcd_qh_remove(dwc_otg_hcd_t * hcd, dwc_otg_qh_t * qh)
 {
+	unsigned long flags;
 	gintmsk_data_t intr_mask = {.d32 = 0 };
 
 	if (DWC_LIST_EMPTY(&qh->qh_list_entry)) {
@@ -758,11 +758,9 @@ void dwc_otg_hcd_qh_remove(dwc_otg_hcd_t
 		if( !hcd->periodic_qh_count && !fiq_fsm_enable ) {
 			intr_mask.b.sofintr = 1;
 			if (fiq_enable) {
-				local_fiq_disable();
-				fiq_fsm_spin_lock(&hcd->fiq_state->lock);
+				fiq_fsm_spin_lock_irqsave(&hcd->fiq_state->lock, flags);
 				DWC_MODIFY_REG32(&hcd->core_if->core_global_regs->gintmsk, intr_mask.d32, 0);
-				fiq_fsm_spin_unlock(&hcd->fiq_state->lock);
-				local_fiq_enable();
+				fiq_fsm_spin_unlock_irqrestore(&hcd->fiq_state->lock, flags);
 			} else {
 				DWC_MODIFY_REG32(&hcd->core_if->core_global_regs->gintmsk, intr_mask.d32, 0);
 			}
