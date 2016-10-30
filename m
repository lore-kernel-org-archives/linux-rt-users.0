From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 4/5] kbuild: add -fno-PIE
Date: Sun, 30 Oct 2016 12:46:39 -0400
Message-ID: <20161030164647.632632669@goodmis.org>
References: <20161030164635.444929710@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-kbuild-add-fno-PIE.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.35-rt41-rc1 stable review patch.
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
index 21f657f2c4e6..384ef0e05826 100644
--- a/Makefile
+++ b/Makefile
@@ -400,7 +400,7 @@ KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common \
 		   -Werror-implicit-function-declaration \
-		   -Wno-format-security \
+		   -Wno-format-security -fno-PIE \
 		   -std=gnu89
 
 KBUILD_AFLAGS_KERNEL :=
-- 
2.9.3
