Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:52150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVnW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:22 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 02/15] arm*: disable NEON in kernel mode
Date: Tue, 14 Aug 2018 13:53:55 -0500
Message-Id: <fc1fb1208145deaad5175ff3ca30cd49ff195dde.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream 4.4 rt-stable commit 728b41d8e7b5307b52bdbffcb492bc8345a4e38a ]

NEON in kernel mode is used by the crypto algorithms and raid6 code.
While the raid6 code looks okay, the crypto algorithms do not: NEON
is enabled on first invocation and may allocate/free/map memory before
the NEON mode is disabled again.
This needs to be changed until it can be enabled.
On ARM NEON in kernel mode can be simply disabled. on ARM64 it needs to
stay on due to possible EFI callbacks so here I disable each algorithm.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Daniel Wagner <wagi@monom.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 arch/arm/Kconfig          |  2 +-
 arch/arm64/crypto/Kconfig | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d635abf51063..12b1e7a5f103 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2122,7 +2122,7 @@ config NEON
 
 config KERNEL_MODE_NEON
 	bool "Support for NEON in kernel mode"
-	depends on NEON && AEABI
+	depends on NEON && AEABI && !PREEMPT_RT_BASE
 	help
 	  Say Y to include support for NEON in kernel mode.
 
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 5562652c5316..003fe0718117 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -10,42 +10,42 @@ if ARM64_CRYPTO
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_SHA2_ARM64_CE
 	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_GHASH_ARM64_CE
 	tristate "GHASH (for GCM chaining mode) using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_HASH
 
 config CRYPTO_AES_ARM64_CE
 	tristate "AES core cipher using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES
 
 config CRYPTO_AES_ARM64_CE_CCM
 	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES
 	select CRYPTO_AEAD
 
 config CRYPTO_AES_ARM64_CE_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES
 	select CRYPTO_ABLK_HELPER
 
 config CRYPTO_AES_ARM64_NEON_BLK
 	tristate "AES in ECB/CBC/CTR/XTS modes using NEON instructions"
-	depends on ARM64 && KERNEL_MODE_NEON
+	depends on ARM64 && KERNEL_MODE_NEON && !PREEMPT_RT_BASE
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES
 	select CRYPTO_ABLK_HELPER
-- 
2.14.1
