From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/7] tpm_tis: fix stall after iowrite*()s
Date: Thu, 23 Nov 2017 00:23:20 -0500
Message-ID: <20171123052629.883196481@goodmis.org>
References: <20171123052317.319740795@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        Haris Okanovic <haris.okanovic@ni.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0003-tpm_tis-fix-stall-after-iowrite-s.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.61-rt52-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Haris Okanovic <haris.okanovic@ni.com>

ioread8() operations to TPM MMIO addresses can stall the cpu when
immediately following a sequence of iowrite*()'s to the same region.

For example, cyclitest measures ~400us latency spikes when a non-RT
usermode application communicates with an SPI-based TPM chip (Intel Atom
E3940 system, PREEMPT_RT_FULL kernel). The spikes are caused by a
stalling ioread8() operation following a sequence of 30+ iowrite8()s to
the same address. I believe this happens because the write sequence is
buffered (in cpu or somewhere along the bus), and gets flushed on the
first LOAD instruction (ioread*()) that follows.

The enclosed change appears to fix this issue: read the TPM chip's
access register (status code) after every iowrite*() operation to
amortize the cost of flushing data to chip across multiple instructions.

Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/char/tpm/tpm_tis.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 8022bea27fed..247330efd310 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -50,6 +50,31 @@ static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *da
 	return container_of(data, struct tpm_tis_tcg_phy, priv);
 }
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * Flushes previous write operations to chip so that a subsequent
+ * ioread*()s won't stall a cpu.
+ */
+static inline void tpm_tis_flush(void __iomem *iobase)
+{
+	ioread8(iobase + TPM_ACCESS(0));
+}
+#else
+#define tpm_tis_flush(iobase) do { } while (0)
+#endif
+
+static inline void tpm_tis_iowrite8(u8 b, void __iomem *iobase, u32 addr)
+{
+	iowrite8(b, iobase + addr);
+	tpm_tis_flush(iobase);
+}
+
+static inline void tpm_tis_iowrite32(u32 b, void __iomem *iobase, u32 addr)
+{
+	iowrite32(b, iobase + addr);
+	tpm_tis_flush(iobase);
+}
+
 static bool interrupts = true;
 module_param(interrupts, bool, 0444);
 MODULE_PARM_DESC(interrupts, "Enable interrupts");
@@ -103,7 +128,7 @@ static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
 	while (len--)
-		iowrite8(*value++, phy->iobase + addr);
+		tpm_tis_iowrite8(*value++, phy->iobase, addr);
 	return 0;
 }
 
@@ -127,7 +152,7 @@ static int tpm_tcg_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	iowrite32(value, phy->iobase + addr);
+	tpm_tis_iowrite32(value, phy->iobase, addr);
 	return 0;
 }
 
-- 
2.13.2
