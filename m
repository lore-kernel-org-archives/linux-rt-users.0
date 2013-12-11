From: Emmanuel Grumbach <emmanuel.grumbach-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC 01/10] iwlwifi: pcie: clean up ICT allocation code
Date: Wed, 11 Dec 2013 10:33:36 +0200
Message-ID: <1386750826-25219-2-git-send-email-emmanuel.grumbach@intel.com>
References: <1386750826-25219-1-git-send-email-emmanuel.grumbach@intel.com>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Emmanuel Grumbach <emmanuel.grumbach-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386750826-25219-1-git-send-email-emmanuel.grumbach-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Since iwl_trans_pcie_alloc_ict is called in the PCIe
allocation code, we always set CSR_INT_BIT_RX_PERIODIC.
Move that bit to the default list of interrupts we enable
and simplify the code.
Also use dma_zalloc_ and avoid to memset the memory
afterwards.
trans_pcie->ict_index is 0 since trans_pcie has just been
kzalloced, remove the redundant assignment.

Change-Id: I1612bafb2c93d8a796cdd42444102e39199d4869
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/net/wireless/iwlwifi/iwl-csr.h |  3 ++-
 drivers/net/wireless/iwlwifi/pcie/rx.c | 15 ++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/iwlwifi/iwl-csr.h b/drivers/net/wireless/iwlwifi/iwl-csr.h
index da4eca8..bbab26e 100644
--- a/drivers/net/wireless/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/iwlwifi/iwl-csr.h
@@ -198,7 +198,8 @@
 				 CSR_INT_BIT_RF_KILL | \
 				 CSR_INT_BIT_SW_RX   | \
 				 CSR_INT_BIT_WAKEUP  | \
-				 CSR_INT_BIT_ALIVE)
+				 CSR_INT_BIT_ALIVE   | \
+				 CSR_INT_BIT_RX_PERIODIC)
 
 /* interrupt flags in FH (flow handler) (PCI busmaster DMA) */
 #define CSR_FH_INT_BIT_ERR       (1 << 31) /* Error */
diff --git a/drivers/net/wireless/iwlwifi/pcie/rx.c b/drivers/net/wireless/iwlwifi/pcie/rx.c
index 7aeec5c..b3e6564 100644
--- a/drivers/net/wireless/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/iwlwifi/pcie/rx.c
@@ -1048,7 +1048,7 @@ int iwl_pcie_alloc_ict(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	trans_pcie->ict_tbl =
-		dma_alloc_coherent(trans->dev, ICT_SIZE,
+		dma_zalloc_coherent(trans->dev, ICT_SIZE,
 				   &trans_pcie->ict_tbl_dma,
 				   GFP_KERNEL);
 	if (!trans_pcie->ict_tbl)
@@ -1060,17 +1060,10 @@ int iwl_pcie_alloc_ict(struct iwl_trans *trans)
 		return -EINVAL;
 	}
 
-	IWL_DEBUG_ISR(trans, "ict dma addr %Lx\n",
-		      (unsigned long long)trans_pcie->ict_tbl_dma);
+	IWL_DEBUG_ISR(trans, "ict dma addr %Lx ict vir addr %p\n",
+		      (unsigned long long)trans_pcie->ict_tbl_dma,
+		      trans_pcie->ict_tbl);
 
-	IWL_DEBUG_ISR(trans, "ict vir addr %p\n", trans_pcie->ict_tbl);
-
-	/* reset table and index to all 0 */
-	memset(trans_pcie->ict_tbl, 0, ICT_SIZE);
-	trans_pcie->ict_index = 0;
