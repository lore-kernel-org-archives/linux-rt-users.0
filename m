From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: [PATCH 2.6.26.5-rt9] remove duplicate save_stack_trace
Date: Fri, 12 Sep 2008 21:54:16 +0200
Message-ID: <20080912195416.GK9852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:52803 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753745AbYILTyS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Sep 2008 15:54:18 -0400
Received: from mediacenter.ptxnet.pengutronix.de ([10.1.0.65] ident=Debian-exim)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <rsc@pengutronix.de>)
	id 1KeEif-0004PF-8O
	for linux-rt-users@vger.kernel.org; Fri, 12 Sep 2008 21:54:17 +0200
Received: from rsc by mediacenter.ptxnet.pengutronix.de with local (Exim 4.69)
	(envelope-from <rsc@pengutronix.de>)
	id 1KeEie-0005gY-VW
	for linux-rt-users@vger.kernel.org; Fri, 12 Sep 2008 21:54:16 +0200
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Building the kernel with rt-preempt on MPC5121e, I get this one:

arch/powerpc/kernel/stacktrace.o: In function `save_stack_trace':
arch/powerpc/kernel/stacktrace.c:50: multiple definition of `save_stack_trace'
arch/powerpc/kernel/setup_32.o:arch/powerpc/kernel/setup_32.c:328: first defined here

Looks like somebody forgot to remove this in setup_32.c; setup_64.c has
it removed.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

---
 arch/powerpc/kernel/setup_32.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-2.6.26/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-2.6.26.orig/arch/powerpc/kernel/setup_32.c
+++ linux-2.6.26/arch/powerpc/kernel/setup_32.c
@@ -322,13 +322,6 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 }
 
-#ifdef CONFIG_STACKTRACE
-#include <linux/stacktrace.h>
-void notrace save_stack_trace(struct stack_trace *trace)
-{
-}
-#endif /* CONFIG_STACKTRACE */
