From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHv2 1/3] arm64: Mark PMU interrupt IRQF_NO_THREAD
Date: Thu, 14 May 2015 17:39:37 +0200
Message-ID: <20150514153937.GB13442@linutronix.de>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-2-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ayyappa.ch.linux@gmail.com, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.hilman@linaro.org
To: Anders Roxell <anders.roxell@linaro.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37944 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbbENPjk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 11:39:40 -0400
Content-Disposition: inline
In-Reply-To: <1430167990-12333-2-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Anders Roxell | 2015-04-27 22:53:08 [+0200]:

>Mark the PMU interrupts as non-threadable, as is the case with
>arch/arm: d9c3365 ARM: 7813/1: Mark pmu interupt IRQF_NO_THREAD
>
>Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Could this please go via the arm64 tree?

>---
> arch/arm64/kernel/perf_event.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>index aa29ecb..70dcde6 100644
>--- a/arch/arm64/kernel/perf_event.c
>+++ b/arch/arm64/kernel/perf_event.c
>@@ -461,7 +461,7 @@ armpmu_reserve_hardware(struct arm_pmu *armpmu)
> 			}
> 
> 			err = request_irq(irq, armpmu->handle_irq,
>-					IRQF_NOBALANCING,
>+					IRQF_NOBALANCING | IRQF_NO_THREAD,
> 					"arm-pmu", armpmu);
> 			if (err) {
> 				pr_err("unable to request IRQ%d for ARM PMU counters\n",

Sebastian
