From: Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 06/15] locking: add types.h
Date: Thu,  2 Aug 2018 17:25:21 -0500
Message-ID: <8e0d5aeb84b08416dd846d0223e02d9209cda0f8.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, stable-rt@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1533242791.git.tom.zanussi@linux.intel.com>
References: <cover.1533242791.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

During the stable update the arm architecture did not compile anymore
due to missing definition of u16/32.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 1289b06974d64f244a26455fab699c6a1332f4bc)
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
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
2.14.1
