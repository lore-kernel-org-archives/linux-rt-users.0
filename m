From: Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 12/22] locking: add types.h
Date: Mon,  6 Aug 2018 04:17:28 -0500
Message-ID: <c1dafe11673fe140e4155fc3fb2e480c073d22d7.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533540554.git.julia@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
During the stable update the arm architecture did not compile anymore
due to missing definition of u16/32.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 1289b06974d64f244a26455fab699c6a1332f4bc)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 include/linux/spinlock_types_raw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index edffc4d53fc9..03235b475b77 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -1,6 +1,8 @@
 #ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 #define __LINUX_SPINLOCK_TYPES_RAW_H
 
+#include <linux/types.h>
+
 #if defined(CONFIG_SMP)
 # include <asm/spinlock_types.h>
 #else
-- 
2.18.0
