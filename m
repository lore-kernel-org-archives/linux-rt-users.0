From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/20] ARM: at91: remove useless includes and function prototypes
Date: Tue, 12 Jul 2016 10:24:09 -0400
Message-ID: <20160712142417.931010097@goodmis.org>
References: <20160712142405.634544943@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-ARM-at91-remove-useless-includes-and-function-protot.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.27-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Remove leftover from the previous cleanup

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/mach-at91/generic.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index d224e195706a..28ca57a2060f 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -11,13 +11,6 @@
 #ifndef _AT91_GENERIC_H
 #define _AT91_GENERIC_H
 
-#include <linux/of.h>
-#include <linux/reboot.h>
-
- /* Map io */
-extern void __init at91_map_io(void);
-extern void __init at91_alt_map_io(void);
-
 #ifdef CONFIG_PM
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9260_pm_init(void);
-- 
2.8.1
