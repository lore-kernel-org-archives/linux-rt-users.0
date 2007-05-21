From: Daniel Walker <dwalker@mvista.com>
Subject: Re: v2.6.21-rt3
Date: Mon, 21 May 2007 13:11:06 -0700
Message-ID: <1179778266.15427.38.camel@imap.mvista.com>
References: <20070517194143.GA25394@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.158]:55324 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1764175AbXEUUN2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 May 2007 16:13:28 -0400
In-Reply-To: <20070517194143.GA25394@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Where did the arm ep93xx changes come from? It looks like patch below
came in with them in 2.6.21-rt6 ..

--- linux.orig/include/asm-arm/system.h
+++ linux/include/asm-arm/system.h
@@ -235,8 +235,9 @@ static inline void set_copro_access(unsi
  * so enable interrupts over the context switch to avoid high
  * latency.
  */
+#if 0 // preempt_rt hack, because warn_on in shedule.c triggers
 #define __ARCH_WANT_INTERRUPTS_ON_CTXSW
-
+#endif
 /*
  * switch_to(prev, next) should switch from task `prev' to `next'
  * `prev' will never be the same as `next'.  schedule() itself
