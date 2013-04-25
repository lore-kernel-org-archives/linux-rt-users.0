From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] powerpc/64bit,PREEMPT_RT: Check preempt_count before
 preempting
Date: Thu, 25 Apr 2013 18:58:16 +0200
Message-ID: <20130425165816.GH5561@linutronix.de>
References: <1366004896-3006-1-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, rostedt@goodmis.org
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45120 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619Ab3DYQ6R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 12:58:17 -0400
Content-Disposition: inline
In-Reply-To: <1366004896-3006-1-git-send-email-Priyanka.Jain@freescale.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Priyanka Jain | 2013-04-15 11:18:16 [+0530]:

>Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
>---
> arch/powerpc/kernel/entry_64.S |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>
>diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>index 1b1c8ae..ec120e6 100644
>--- a/arch/powerpc/kernel/entry_64.S
>+++ b/arch/powerpc/kernel/entry_64.S
>@@ -643,6 +643,8 @@ resume_kernel:
> #ifdef CONFIG_PREEMPT
> 	/* Check if we need to preempt */
> 	lwz	r8,TI_PREEMPT(r9)
>+	cmpwi	0,r8,0		/* if non-zero, just restore regs and return */
>+	bne	restore
> 	andi.	r0,r4,_TIF_NEED_RESCHED
> 	bne+	check_count

Oh boy oh boy. Thanks for caching this. Steven please take this to v3.6,
don't see this chunk in v3.4.

Priyanka: does 64bit power work fine on v3.6/v3.8 besides this?

Sebastian
