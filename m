From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [v4.1.10-rt10] [PATCH 2/2] PCI: dra7xx: fix "WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu"
Date: Mon, 2 Nov 2015 21:30:26 +0200
Message-ID: <1446492626-24396-3-git-send-email-grygorii.strashko@ti.com>
References: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>
To: <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446492626-24396-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Use generic_handle_irq_rt_wa() to W/A below backtrace, which is
triggered because dra7xx_pcie_msi_irq_handler() forced to be
threaded on -RT:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 82 at kernel/irq/handle.c:150 handle_irq_event_percpu+0x14c/0x174()
irq 460 handler irq_default_primary_handler+0x0/0x14 enabled interrupts
Modules linked in: ahci_platform(+) ti_vip(+) libahci_platform xhci_pci(+) c_can_platform(+)
libahci xhci_hcd ti_vpe c_can libata v4l2_mem2mem can_dev gpio_keys leds_gpio
snd_soc_simple_card usbcore spi_ti_qspi videobuf2_core extcon_usb_gpio omap_wdt
ti_vpdma videobuf2_dma_contig ti_soc_thermal videobuf2_memops dwc3_omap extcon
rtc_omap ov1063x v4l2_common videodev media snd_soc_tlv320aic3x omap_rng rng_core omap_remoteproc
CPU: 1 PID: 82 Comm: irq/26-dra7-pci Not tainted 4.1.10-rt10-02638-g6486d7e-dirty #1
Hardware name: Generic DRA74X (Flattened Device Tree)
Backtrace:
[<c0013060>] (dump_backtrace) from [<c0013280>] (show_stack+0x18/0x1c)
 r7:c07acca0 r6:00000000 r5:c09034e4 r4:00000000
[<c0013268>] (show_stack) from [<c061ef14>] (dump_stack+0x90/0xac)
[<c061ee84>] (dump_stack) from [<c00436e4>] (warn_slowpath_common+0x7c/0xb8)
 r7:c07acca0 r6:00000096 r5:00000009 r4:ee4d3e38
[<c0043668>] (warn_slowpath_common) from [<c0043758>] (warn_slowpath_fmt+0x38/0x40)
 r8:ee3fcc00 r7:000001cc r6:00000000 r5:00000002 r4:c07acc78
[<c0043724>] (warn_slowpath_fmt) from [<c0085fd0>] (handle_irq_event_percpu+0x14c/0x174)
 r3:000001cc r2:c07acc78
 r4:ecfcdd80
[<c0085e84>] (handle_irq_event_percpu) from [<c008607c>] (handle_irq_event+0x84/0xb8)
 r10:00000001 r9:ee4b59c0 r8:ee1d0900 r7:00000001 r6:00000000 r5:ecfcdd80
 r4:ee3fcc00
[<c0085ff8>] (handle_irq_event) from [<c0089240>] (handle_simple_irq+0x90/0x118)
 r5:ee4a9020 r4:ee3fcc00
[<c00891b0>] (handle_simple_irq) from [<c0085514>] (generic_handle_irq+0x30/0x44)
 r5:ee4a9020 r4:000001cc
[<c00854e4>] (generic_handle_irq) from [<c034a7d4>] (dra7xx_pcie_msi_irq_handler+0x7c/0x8c)
 r5:ee4a9020 r4:00000001
[<c034a758>] (dra7xx_pcie_msi_irq_handler) from [<c0086f08>] (irq_forced_thread_fn+0x28/0x5c)
 r5:ee1d0900 r4:ee4b59c0
[<c0086ee0>] (irq_forced_thread_fn) from [<c00871dc>] (irq_thread+0x128/0x204)
 r7:00000001 r6:00000000 r5:ee4d2000 r4:ee4b59e4
[<c00870b4>] (irq_thread) from [<c005e2fc>] (kthread+0xd4/0xec)
 r10:00000000 r9:00000000 r8:00000000 r7:c00870b4 r6:ee4b59c0 r5:ee4b5a00
 r4:00000000
[<c005e228>] (kthread) from [<c000faa8>] (ret_from_fork+0x14/0x2c)
 r7:00000000 r6:00000000 r5:c005e228 r4:ee4b5a00
---[ end trace 0000000000000002 ]---

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/pci/host/pci-dra7xx.c      | 3 ++-
 drivers/pci/host/pcie-designware.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
index 6589e7e..8c241cb 100644
--- a/drivers/pci/host/pci-dra7xx.c
+++ b/drivers/pci/host/pci-dra7xx.c
@@ -220,7 +220,8 @@ static irqreturn_t dra7xx_pcie_msi_irq_handler(int irq, void *arg)
 	case INTB:
 	case INTC:
 	case INTD:
-		generic_handle_irq(irq_find_mapping(pp->irq_domain, ffs(reg)));
+		generic_handle_irq_rt_wa(irq_find_mapping(pp->irq_domain,
+					 ffs(reg)));
 		break;
 	}
 
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 2e9f84f..6ba0ee3 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -177,7 +177,7 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 				dw_pcie_wr_own_conf(pp,
 						PCIE_MSI_INTR0_STATUS + i * 12,
 						4, 1 << pos);
-				generic_handle_irq(irq);
+				generic_handle_irq_rt_wa(irq);
 				pos++;
 			}
 		}
-- 
2.6.2
