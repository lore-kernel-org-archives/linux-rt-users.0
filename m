From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCHv2 1/3] arm64: Mark PMU interrupt IRQF_NO_THREAD
Date: Mon, 27 Apr 2015 22:53:08 +0200
Message-ID: <1430167990-12333-2-git-send-email-anders.roxell@linaro.org>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.hilman@linaro.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de, ayyappa.ch.linux@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:34005 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965140AbbD0Uxv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Apr 2015 16:53:51 -0400
Received: by laat2 with SMTP id t2so89516571laa.1
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2015 13:53:50 -0700 (PDT)
In-Reply-To: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Mark the PMU interrupts as non-threadable, as is the case with
arch/arm: d9c3365 ARM: 7813/1: Mark pmu interupt IRQF_NO_THREAD

Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index aa29ecb..70dcde6 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -461,7 +461,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
 			}
 
 			err = request_irq(irq, armpmu->handle_irq,
-					IRQF_NOBALANCING,
+					IRQF_NOBALANCING | IRQF_NO_THREAD,
 					"arm-pmu", armpmu);
 			if (err) {
 				pr_err("unable to request IRQ%d for ARM PMU counters\n",
-- 
2.1.4

