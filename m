From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCHv2 0/3] Enable PREEMPT_RT_FULL on arm64
Date: Mon, 27 Apr 2015 22:53:07 +0200
Message-ID: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.hilman@linaro.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de, ayyappa.ch.linux@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34977 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965149AbbD0Uxp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 27 Apr 2015 16:53:45 -0400
Received: by lbbuc2 with SMTP id uc2so91911893lbb.2
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Apr 2015 13:53:43 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I tested this on an arm64 juno target, and to get that to boot I
had to backport the dtb from v4.0-rc6 to v3.18.11-rt7.

Incorporated comments from Sebastian Andrzej Siewior and Ayyappa Ch.

Cheers,
Anders

Anders Roxell (3):
  arm64: Mark PMU interrupt IRQF_NO_THREAD
  arm64: Allow forced irq threading
  arch/arm64: Enable PREEMPT_RT_FULL

 arch/arm64/Kconfig                   |  2 ++
 arch/arm64/include/asm/thread_info.h |  3 +++
 arch/arm64/kernel/asm-offsets.c      |  1 +
 arch/arm64/kernel/entry.S            | 13 ++++++++++---
 arch/arm64/kernel/perf_event.c       |  2 +-
 5 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.1.4

