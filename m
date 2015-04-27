From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCHv2 2/3] arm64: Allow forced irq threading
Date: Mon, 27 Apr 2015 22:53:09 +0200
Message-ID: <1430167990-12333-3-git-send-email-anders.roxell@linaro.org>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.hilman@linaro.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de, ayyappa.ch.linux@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:33230 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965160AbbD0Uxy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Apr 2015 16:53:54 -0400
Received: by layy10 with SMTP id y10so89577968lay.0
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2015 13:53:53 -0700 (PDT)
In-Reply-To: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Now its safe to allow forced interrupt threading for arm64,
all timer interrupts and the perf interrupt are marked NO_THREAD, as is
the case with arch/arm: da0ec6f ARM: 7814/2: Allow forced irq threading

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9532f8d..3708eec 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -61,6 +61,7 @@ config ARM64
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
+	select IRQ_FORCED_THREADING
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
 	select OF
-- 
2.1.4

