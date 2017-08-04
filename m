From: Haris Okanovic <haris.okanovic@ni.com>
Subject: [PATCH] [RFC] tpm_tis: tpm_tcg_flush() after iowrite*()s
Date: Fri, 4 Aug 2017 16:56:51 -0500
Message-ID: <20170804215651.29247-1-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <haris.okanovic@ni.com>, <harisokn@gmail.com>,
        <julia.cartwright@ni.com>, <gratian.crisan@ni.com>,
        <scott.hartman@ni.com>, <chris.graf@ni.com>, <brad.mouring@ni.com>,
        <jonathan.david@ni.com>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I have a latency issue using a SPI-based TPM chip with tpm_tis driver
from non-rt usermode application, which induces ~400 us latency spikes
in cyclictest (Intel Atom E3940 system, PREEMPT_RT_FULL kernel).

The spikes are caused by a stalling ioread8() operation, following a
sequence of 30+ iowrite8()s to the same address. I believe this happens
because the writes are cached (in cpu or somewhere along the bus), which
gets flushed on the first LOAD instruction (ioread*()) that follows.

The enclosed change appears to fix this issue: read the TPM chip's
access register (status code) after every iowrite*() operation.

I believe this works because it amortize the cost of flushing data to
chip across multiple instructions. However, I don't have any direct
evidence to support this theory.

Does this seem like a reasonable theory?

Any feedback on the change (a better way to do it, perhaps)?

Thanks,
Haris Okanovic

https://github.com/harisokanovic/linux/tree/dev/hokanovi/tpm-latency-spike-fix-rfc
---
 drivers/char/tpm/tpm_tis.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index c7e1384f1b08..5cdbfec0ad67 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -89,6 +89,19 @@ static inline int is_itpm(struct acpi_device *dev)
 }
 #endif
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+/*
+ * Flushes previous iowrite*() operations to chip so that a subsequent
+ * ioread*() won't stall a cpu.
+ */
+static void tpm_tcg_flush(struct tpm_tis_tcg_phy *phy)
+{
+	ioread8(phy->iobase + TPM_ACCESS(0));
+}
+#else
+#define tpm_tcg_flush do { } while(0)
+#endif
+
 static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 			      u8 *result)
 {
@@ -104,8 +117,10 @@ static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
-	while (len--)
+	while (len--) {
 		iowrite8(*value++, phy->iobase + addr);
+		tpm_tcg_flush(phy);
+	}
 	return 0;
 }
 
@@ -130,6 +145,7 @@ static int tpm_tcg_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
 	iowrite32(value, phy->iobase + addr);
+	tpm_tcg_flush(phy);
 	return 0;
 }
 
-- 
2.13.2
