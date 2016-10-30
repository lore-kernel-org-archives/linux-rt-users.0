From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 5/6] kbuild: add -fno-PIE
Date: Sun, 30 Oct 2016 12:45:12 -0400
Message-ID: <20161030164519.867652213@goodmis.org>
References: <20161030164507.542995196@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932696AbcJ3QpZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 30 Oct 2016 12:45:25 -0400
Content-Disposition: inline; filename=0005-kbuild-add-fno-PIE.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.4.27-rt38-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Debian started to build the gcc with -fPIE by default so the kernel
build ends before it starts properly with:
|kernel/bounds.c:1:0: error: code model kernel does not support PIC mode

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3b2614a0fa1b..e2c9fdc9d22f 100644
--- a/Makefile
+++ b/Makefile
@@ -394,7 +394,7 @@ KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration \
-		   -Wno-format-security \
+		   -Wno-format-security -fno-PIE \
 		   -std=gnu89
 
 KBUILD_AFLAGS_KERNEL :=
-- 
2.9.3


