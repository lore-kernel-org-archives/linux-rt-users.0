Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVn2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Aug 2018 17:43:28 -0400
From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 06/15] locking: add types.h
Date: Tue, 14 Aug 2018 13:53:59 -0500
Message-Id: <aa5ffd43df199e1f5605e484d7ae72e49b9dc6f5.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1534263273.git.tom.zanussi@linux.intel.com>
References: <cover.1534263273.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org, jkacur@redhat.com, bigeasy@linutronix.de, daniel.wagner@siemens.com, julia@ni.com

v3.18.117-rt105 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream rt-devel commit 1289b06974d64f244a26455fab699c6a1332f4bc ]

During the stable update the arm architecture did not compile anymore
due to missing definition of u16/32.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
