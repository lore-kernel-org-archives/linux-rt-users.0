From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH -rt] nmi: fix a build error
Date: Thu, 12 Feb 2009 04:43:11 +0100
Message-ID: <20090212034310.GA4809@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:35664 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbZBLDnQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Feb 2009 22:43:16 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Note this patch applies against rt:origin/master
I guess it relies on a specific topic but I can't find which one.
--
Latest -rt tree fails to build:

arch/x86/kernel/nmi.c: In function =E2=80=98nmi_watchdog_tick=E2=80=99:
arch/x86/kernel/nmi.c:463: erreur: implicit declaration of function =E2=
=80=98__profile_tick=E2=80=99
make[1]: *** [arch/x86/kernel/nmi.o] Erreur 1
make: *** [arch/x86/kernel] Erreur 2

nmi.c uses __profile_tick() but lacks its prototype, it needs to includ=
e
linux/profile.c
Also, __profile_tick() is missing an off case (!CONFIG_PROFILING) on li=
nux/profile.h

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
---
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index c9afd16..4f26868 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kdebug.h>
 #include <linux/smp.h>
+#include <linux/profile.h>
=20
 #include <asm/i8259.h>
 #include <asm/io_apic.h>
diff --git a/include/linux/profile.h b/include/linux/profile.h
index 2e1de8a..e440411 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -97,6 +97,11 @@ static inline int profile_init(void)
 	return 0;
 }
=20
+static inline void __profile_tick(int type, struct pt_regs *regs)
+{
+	return;
+}
+
 static inline void profile_tick(int type)
 {
 	return;

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
