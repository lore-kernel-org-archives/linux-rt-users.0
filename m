From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHv2 2/3] arm64: Allow forced irq threading
Date: Thu, 14 May 2015 17:40:41 +0200
Message-ID: <20150514154041.GC13442@linutronix.de>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-3-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: ayyappa.ch.linux@gmail.com, linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.hilman@linaro.org
To: Anders Roxell <anders.roxell@linaro.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:37956 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964886AbbENPkn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 May 2015 11:40:43 -0400
Content-Disposition: inline
In-Reply-To: <1430167990-12333-3-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Anders Roxell | 2015-04-27 22:53:09 [+0200]:

>Now its safe to allow forced interrupt threading for arm64,
>all timer interrupts and the perf interrupt are marked NO_THREAD, as is
>the case with arch/arm: da0ec6f ARM: 7814/2: Allow forced irq threading
>
>Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Please, could this go via the ARM64 tree?

>---
> arch/arm64/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>index 9532f8d..3708eec 100644
>--- a/arch/arm64/Kconfig
>+++ b/arch/arm64/Kconfig
>@@ -61,6 +61,7 @@ config ARM64
> 	select HAVE_RCU_TABLE_FREE
> 	select HAVE_SYSCALL_TRACEPOINTS
> 	select IRQ_DOMAIN
>+	select IRQ_FORCED_THREADING
> 	select MODULES_USE_ELF_RELA
> 	select NO_BOOTMEM
> 	select OF


Sebastian
