From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/5] rt-tests: Add header including copyright notice to rt_numa.h
Date: Wed, 27 Jan 2010 21:24:24 +0100
Message-ID: <1264623868-23595-2-git-send-email-jkacur@redhat.com>
References: <1264623868-23595-1-git-send-email-jkacur@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Carsten Emde <C.Emde@osadl.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755018Ab0A0UZe@vger.kernel.org>
In-Reply-To: <1264623868-23595-1-git-send-email-jkacur@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Add a header which includes a copyright notice to rt_numa.h for cyclictest.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/rt_numa.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index a0ebe7f..14837ff 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -1,3 +1,16 @@
+/*
+ * A numa library for cyclictest.
+ * The functions here are designed to work whether cyclictest has been
+ * compiled with numa support or not, and whether the user uses the --numa
+ * option or not.
+ * They should also work correctly with older versions of the numactl lib
+ * such as the one found on RHEL5, or with the newer version 2 and above.
+ *
+ * (C) 2010 John Kacur <jkacur@redhat.com>
+ * (C) 2010 Clark Williams <williams@redhat.com>
+ *
+ */
+
 #ifndef _RT_NUMA_H
 #define _RT_NUMA_H
 
-- 
1.6.6
