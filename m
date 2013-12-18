From: Henrik Austad <henrik-RT+80VE2nyv1P9xLtpHBDw@public.gmane.org>
Subject: [PATCH 06/10] iwlwifi: pcie: determine the interrupt type in the handler
Date: Thu, 19 Dec 2013 00:26:01 +0100
Message-ID: <1387409165-28319-7-git-send-email-henrik@austad.us>
References: <1387409165-28319-1-git-send-email-henrik@austad.us>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Emmanuel Grumbach <emmanuel.grumbach-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387409165-28319-1-git-send-email-henrik-RT+80VE2nyv1P9xLtpHBDw@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Instead of having:
iwl_pcie_irq_handler
	iwl_pcie_isr_ict
		iwl_pcie_isr_non_ict

we now have:

iwl_pcie_irq_handler:
	if (use_ict))
		iwl_pcie_int_cause_ict;
	else
		iwl_pcie_int_cause_non_ict;

This is much clearer.

Change-Id: Ieb99e8120c62749c06e3b2636aaf7ccbea8c72c5
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/net/wireless/iwlwifi/pcie/rx.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/iwlwifi/pcie/rx.c b/drivers/net/wireless/iwlwifi/pcie/rx.c
index cd96eb2..aea6202 100644
--- a/drivers/net/wireless/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/iwlwifi/pcie/rx.c
@@ -810,8 +810,7 @@ static void iwl_pcie_irq_handle_error(struct iwl_trans *trans)
 	local_bh_enable();
 }
 
-/* legacy (non-ICT) ISR. Assumes that trans_pcie->irq_lock is held */
-static irqreturn_t iwl_pcie_isr_non_ict(struct iwl_trans *trans)
+static irqreturn_t iwl_pcie_int_cause_non_ict(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	u32 inta;
@@ -884,7 +883,7 @@ none:
  * the interrupt we need to service, driver will set the entries back to 0 and
  * set index.
  */
-static irqreturn_t iwl_pcie_isr_ict(struct iwl_trans *trans)
+static irqreturn_t iwl_pcie_int_cause_ict(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	irqreturn_t ret;
@@ -892,14 +891,6 @@ static irqreturn_t iwl_pcie_isr_ict(struct iwl_trans *trans)
 	u32 val = 0;
 	u32 read;
 
-	/* dram interrupt table not set yet,
-	 * use legacy interrupt.
-	 */
-	if (unlikely(!trans_pcie->use_ict)) {
-		ret = iwl_pcie_isr_non_ict(trans);
-		return ret;
-	}
