From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: [PATCH] remove repeated #define
Date: Thu, 5 Apr 2007 10:40:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0704051038100.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:49291 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964852AbXDEIkO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Apr 2007 04:40:14 -0400
Received: from localhost (unknown [127.0.0.1])
	by mail.dsa-ac.de (Postfix) with ESMTP id C7BB93C404
	for <linux-rt-users@vger.kernel.org>; Thu,  5 Apr 2007 08:40:13 +0000 (UTC)
Received: from pcgl.dsa-ac.de (PCGL.dsa-ac.de [172.29.17.23])
	by mail.dsa-ac.de (Postfix) with ESMTP id F0D263C354
	for <linux-rt-users@vger.kernel.org>; Thu,  5 Apr 2007 10:40:12 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Cosmetic patch below.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

Remove repeated #define

Signed-off-by: G. Liakhovetski <gl@dsa-ac.de>

diff -u -r1.1.1.12.2.1 spinlock.h
--- a/include/linux/spinlock.h	5 Mar 2007 14:06:55 -0000	1.1.1.12.2.1
+++ b/include/linux/spinlock.h	5 Apr 2007 08:37:26 -0000
@@ -206,8 +206,6 @@
 # define _spin_lock_nested(l, s)	do { } while (0)
 # define _spin_lock_bh(l)		do { } while (0)
 # define _spin_lock_irq(l)		do { } while (0)
-# define _spin_lock(l)			do { } while (0)
-# define _spin_lock_bh(l)		do { } while (0)
 # define _spin_unlock(l)		do { } while (0)
 # define _spin_unlock_no_resched(l)	do { } while (0)
 # define _spin_unlock_bh(l)		do { } while (0)
