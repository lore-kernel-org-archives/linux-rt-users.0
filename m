From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Oops during Init IRQ
Date: Mon, 18 Jun 2012 19:53:17 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1206181949160.3086@ionos>
References: <4FDF32DD.3010800@c-s.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: leroy christophe <christophe.leroy@c-s.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45384 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab2FRRxT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jun 2012 13:53:19 -0400
In-Reply-To: <4FDF32DD.3010800@c-s.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 18 Jun 2012, leroy christophe wrote:

> Hello,
> 
> I'm trying to use the rt10 patch on a 3.4.2 kernel on a powerpc (MPC8xx)
> system, and I'm having the following Oops during Irq initialisation. This
> happens with CONFIG_PREEMPT_RT_FULL.
> It doesn't happen with CONFIG_PREEMPT__LL
> 
> May someone help ?

Does the following uncompiled and untested patch fix it for you ?

Thanks,

	tglx


Index: linux-3.4/arch/powerpc/platforms/8xx/m8xx_setup.c
===================================================================
--- linux-3.4.orig/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ linux-3.4/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -43,6 +43,7 @@ static irqreturn_t timebase_interrupt(in
 
 static struct irqaction tbint_irqaction = {
 	.handler = timebase_interrupt,
+	.flags = IRQF_NO_THREAD,
 	.name = "tbint",
 };
 
Index: linux-3.4/arch/powerpc/sysdev/cpm1.c
===================================================================
--- linux-3.4.orig/arch/powerpc/sysdev/cpm1.c
+++ linux-3.4/arch/powerpc/sysdev/cpm1.c
@@ -120,6 +120,7 @@ static irqreturn_t cpm_error_interrupt(i
 
 static struct irqaction cpm_error_irqaction = {
 	.handler = cpm_error_interrupt,
+	.flags = IRQF_NO_THREAD,
 	.name = "error",
 };
 
