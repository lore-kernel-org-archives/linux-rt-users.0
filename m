From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH] Group together irq patches in series file
Date: Tue, 07 Jul 2009 15:42:23 -0700
Message-ID: <1247006543.1550.7.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f203.google.com ([209.85.216.203]:36603 "EHLO
	mail-px0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072AbZGGWr2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Jul 2009 18:47:28 -0400
Received: by pxi41 with SMTP id 41so210963pxi.33
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Jul 2009 15:47:27 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Subject: Group together IRQ patches in 2.6.29.5-rt22 series file.
From: Sven-Thorsten Dietrich <sdietrich@suse.de>

More IRQ patches together, making forward-porting / bisecting
a little easier.

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>

diff --git a/series b/series
index 6b85d34..843c273 100644
--- a/series
+++ b/series
@@ -1,5 +1,5 @@
 #
-# base tree: 2.6.29.4
+# base tree: 2.6.29.5
 #
 
 origin.patch
@@ -104,6 +104,12 @@ preempt-irqs-i386.patch
 # x8664
 #preempt-irqs-x86-64-ioapic-mask-quirk.patch
 
+# CHECKME:
+irq-mask-fix.patch
+handle-pending-in-simple-irq.patch
+preempt-realtime-irqthreading-sparseirq-fixups.patch
+preempt-realtime-sparseirq-waitqueue-init-fix.patch
+
 preempt-irqs-Kconfig.patch
 
 #
@@ -288,12 +294,6 @@ preempt-realtime-timer-cpu-hotplug-fix.patch
 preempt-realtime-serial-console-fix.patch
 preempt-realtime-disable-workqueue-tracer-on-preempt-rt.patch
 
-# CHECKME:
-irq-mask-fix.patch
-handle-pending-in-simple-irq.patch
-preempt-realtime-irqthreading-sparseirq-fixups.patch
-preempt-realtime-sparseirq-waitqueue-init-fix.patch
