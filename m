From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: geode-mfgpt oops 2.6.29.6-rt23
Date: Thu, 23 Jul 2009 22:16:06 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0907232215100.2936@localhost.localdomain>
References: <4A65E556.4050007@systektum.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1819660318-1248380167=:2936"
Cc: linux-rt-users@vger.kernel.org
To: =?ISO-8859-15?Q?Jens_D=F6ring?= <j.doering@systektum.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51373 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbZGWUQN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 23 Jul 2009 16:16:13 -0400
In-Reply-To: <4A65E556.4050007@systektum.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1819660318-1248380167=:2936
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 21 Jul 2009, Jens Döring wrote:

> I noticessed the following oops on 2.6.29.6 with -rt23 patch. without the
> patch anything is fine.

> [    0.800000] BUG: unable to handle kernel NULL pointer dereference at
> 00000034
> [    0.800000] IP: [<c0233d54>] tick_periodic+0x59/0x6d

Does the patch below fix it ?

Thanks,

	tglx
-----
Subject: geode-fix.patch
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 23 Jul 2009 22:12:40 +0200

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/mfgpt_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-tip/arch/x86/kernel/mfgpt_32.c
===================================================================
--- linux-2.6-tip.orig/arch/x86/kernel/mfgpt_32.c
+++ linux-2.6-tip/arch/x86/kernel/mfgpt_32.c
@@ -347,7 +347,7 @@ static irqreturn_t mfgpt_tick(int irq, v
 
 static struct irqaction mfgptirq  = {
 	.handler = mfgpt_tick,
-	.flags = IRQF_DISABLED | IRQF_NOBALANCING,
+	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
 	.name = "mfgpt-timer"
 };
 
--8323328-1819660318-1248380167=:2936--
