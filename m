From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Subject: [PATCH -rt 3/4] x86: nmi_watchdog NMI needed for irq_show_regs_callback()
Date: Mon, 28 Apr 2008 11:17:48 -0700
Message-ID: <481614CC.2040306@ct.jp.nec.com>
References: <48161325.1080508@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:3689 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933091AbYD1SRt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Apr 2008 14:17:49 -0400
In-Reply-To: <48161325.1080508@ct.jp.nec.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

The -rt kernel doesn't panic immediately when NMI lockup detected.
Because the kernel waits show_regs on all cpus, but NMI is not come so
frequently.

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---
 arch/x86/kernel/nmi_32.c |    7 +++++++
 arch/x86/kernel/nmi_64.c |    8 +++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/nmi_32.c b/arch/x86/kernel/nmi_32.c
index f55f05b..da9deb3 100644
--- a/arch/x86/kernel/nmi_32.c
+++ b/arch/x86/kernel/nmi_32.c
@@ -428,6 +428,13 @@ nmi_watchdog_tick(struct pt_regs *regs, unsigned reason)
 				if (i == cpu)
 					continue;
 				nmi_show_regs[i] = 1;
+			}
+
+			smp_send_nmi_allbutself();
+
+			for_each_online_cpu(i) {
+				if (i == cpu)
+					continue;
 				while (nmi_show_regs[i] == 1)
 					cpu_relax();
 			}
diff --git a/arch/x86/kernel/nmi_64.c b/arch/x86/kernel/nmi_64.c
index 69cc737..5d3073c 100644
--- a/arch/x86/kernel/nmi_64.c
+++ b/arch/x86/kernel/nmi_64.c
@@ -412,10 +412,16 @@ nmi_watchdog_tick(struct pt_regs * regs, unsigned reason)
 				if (i == cpu)
 					continue;
 				nmi_show_regs[i] = 1;
+			}
+
+			smp_send_nmi_allbutself();
+
+			for_each_online_cpu(i) {
+				if (i == cpu)
+					continue;
 				while (nmi_show_regs[i] == 1)
 					cpu_relax();
 			}
