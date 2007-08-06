From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: "BUG" fixed by -rt* kernel, why not in mainline?
Date: Mon, 6 Aug 2007 15:42:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0708061527240.8578@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:54824 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765068AbXHFODI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Aug 2007 10:03:08 -0400
Received: from localhost (unknown [127.0.0.1])
	by mail.dsa-ac.de (Postfix) with ESMTP id 419773D6A9
	for <linux-rt-users@vger.kernel.org>; Mon,  6 Aug 2007 13:42:18 +0000 (UTC)
Received: from pcgl.dsa-ac.de (PCGL.dsa-ac.de [172.29.17.23])
	by mail.dsa-ac.de (Postfix) with ESMTP id 3172B3C3D1
	for <linux-rt-users@vger.kernel.org>; Mon,  6 Aug 2007 15:42:17 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

there's a hunk in patch-2.6.23-rc2-rt2, which looks like a bug-fix, 
also relevant for the mainline kernel:

@@ -477,8 +550,8 @@ static inline void finish_lock_switch(st
        smp_wmb();
        prev->oncpu = 0;
 #endif
-#ifndef __ARCH_WANT_INTERRUPTS_ON_CTXSW
-       local_irq_enable();
+#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
+       local_irq_disable();
 #endif
 }
 #endif /* __ARCH_WANT_UNLOCKED_CTXSW */

But it is not in the mainline until now, although this seems to be 
affecting both platforms defining __ARCH_WANT_INTERRUPTS_ON_CTXSW and 
those not defining it. So, my question is - has it been submitted into 
mainline? If not - why, and what can be consequences of this bug (resp. of 
fixing it)?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
