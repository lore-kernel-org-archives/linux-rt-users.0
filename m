From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] paravirt: disable Kbuild option for now
Date: Tue, 9 Jan 2007 13:11:44 +0100
Message-ID: <20070109121144.GA13265@elte.hu>
References: <20070108163027.GD5098@localhost.localdomain> <20070109084520.GA444@elte.hu> <1168344326.19646.124.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	linux-rt-users@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:55097 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbXAIMTt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jan 2007 07:19:49 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Content-Disposition: inline
In-Reply-To: <1168344326.19646.124.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> > Andrew, we need to fix this before v2.6.20 is released. Simplest 
> > upstream fix is to just disable the CONFIG_PARAVIRT Kbuild option, 
> > as per the patch below. Rusty's unexport patch is promising in many 
> > ways, but it's v2.6.21 stuff IMO.
> 
> No.  Just drop the whole "don't export paravirt_ops" idea, and we'll 
> work on that for 2.6.21.
> 
> I don't see a problem with exporting paravirt_ops, [...]

I do see a problem with it: it's been poorly done /because/ nothing 
in-kernel uses it. We can fix it for 2.6.21, but lets disable it for 
2.6.20 - or make the export _GPL as per the patch below. We can enable 
it no problem. Or if that doesnt happen i'm strongly NACK-ing the whole 
paravirt subsystem in its current form.

	Ingo

---------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] paravirt: mark the export GPL

the paravirt subsystem is still in flux so all exports from it are 
definitely internal use only. The APIs around this /will/ change.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/arch/i386/kernel/paravirt.c
===================================================================
--- linux.orig/arch/i386/kernel/paravirt.c
+++ linux/arch/i386/kernel/paravirt.c
@@ -566,4 +566,4 @@ struct paravirt_ops paravirt_ops = {
 	.irq_enable_sysexit = native_irq_enable_sysexit,
 	.iret = native_iret,
 };
-EXPORT_SYMBOL(paravirt_ops);
+EXPORT_SYMBOL_GPL(paravirt_ops);
