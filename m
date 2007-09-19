From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 4/5] Include hrtimer.h in tick.h.
Date: Wed, 19 Sep 2007 16:49:47 +1000
Message-ID: <20070919064947.F2FDB399913@thor>
References: <1190184586.867449.381310088392.qpush@thor>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pythia.bakeyournoodle.com ([203.82.209.197]:51508 "EHLO
	pythia.bakeyournoodle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbXISGvg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Sep 2007 02:51:36 -0400
In-Reply-To: <1190184586.867449.381310088392.qpush@thor>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

struct tick_shed uses struct hrtimer, explictly include the right header file.

preemtivly fixes the following warning
  CC      arch/powerpc/platforms/iseries/setup.o
In file included from arch/powerpc/platforms/iseries/setup.c:30:
include/linux/tick.h:45: error: field 'sched_timer' has incomplete type

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

---

 include/linux/tick.h |    1 +
 1 file changed, 1 insertion(+)

Index: working/include/linux/tick.h
===================================================================
--- working.orig/include/linux/tick.h
+++ working/include/linux/tick.h
@@ -7,6 +7,7 @@
 #define _LINUX_TICK_H
 
 #include <linux/clockchips.h>
+#include <linux/hrtimer.h>
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
