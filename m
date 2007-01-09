From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] paravirt: disable Kbuild option for now
Date: Tue, 9 Jan 2007 09:45:20 +0100
Message-ID: <20070109084520.GA444@elte.hu>
References: <20070108163027.GD5098@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@osdl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:46190 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbXAIIsx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jan 2007 03:48:53 -0500
To: Sascha Hauer <s.hauer@pengutronix.de>
Content-Disposition: inline
In-Reply-To: <20070108163027.GD5098@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Sascha Hauer <s.hauer@pengutronix.de> wrote:

> In include/linux/irqflags.h safe_halt changed from a macro to a static 
> inline function which results in tons of warnings for architectures 
> other than x86[-64]:
> 
> include/linux/irqflags.h:99: warning: implicit declaration of function 
> 'raw_safe_halt'

ok, this is still not fixed in rt2 - which is using Rusty's 
paravirt-unexport patch.

Andrew, we need to fix this before v2.6.20 is released. Simplest 
upstream fix is to just disable the CONFIG_PARAVIRT Kbuild option, as 
per the patch below. Rusty's unexport patch is promising in many ways, 
but it's v2.6.21 stuff IMO.

i'm keeping it enabled in -rt, which makes actual use of this 
infrastructure via KVM-paravirt, so it wont be forgotten.

	Ingo

-------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] paravirt: disable Kbuild option for now

disable CONFIG_PARAVIRT for now - it's not like that it is useful for 
anything in-tree at the moment. I'll make sure it's fixed in v2.6.21.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/arch/i386/Kconfig
===================================================================
--- linux.orig/arch/i386/Kconfig
+++ linux/arch/i386/Kconfig
@@ -199,6 +199,12 @@ endchoice
 
 config PARAVIRT
 	bool "Paravirtualization support (EXPERIMENTAL)"
+
+	#
+	# Work in progress, disable for now:
+	#
+	depends on 0
+
 	depends on EXPERIMENTAL
 	depends on !(X86_VISWS || X86_VOYAGER)
 	help
