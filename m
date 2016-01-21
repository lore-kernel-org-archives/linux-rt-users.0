From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 2/2] cyclictest: Add --smi description on cyclictest man page
Date: Thu, 21 Jan 2016 16:08:30 -0200
Message-ID: <febe80773c6c45fca3497bb97094c52d76bbf37b.1453397401.git.bristot@redhat.com>
References: <cover.1453397401.git.bristot@redhat.com>
Cc: Len Brown <len.brown@intel.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48532 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965495AbcAUSIz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jan 2016 13:08:55 -0500
In-Reply-To: <cover.1453397401.git.bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add the description of the --smi comand line option of cyclictest.

"--smi  Enable SMI count/detection on processors with SMI count support."

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 src/cyclictest/cyclictest.8 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 4e169aa..437e7a6 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -188,6 +188,10 @@ memory allocations using the numa(3) policy library. Thread stacks and
 data structures are allocated from the NUMA node local to the core to
 which the thread is bound. Requires the underlying kernel to have NUMA
 support compiled in.
+.TP
+.B \\-\-smi
+Enable SMI count/detection on processors with SMI count support.
+
 .SH SEE ALSO
 .BR numactl (8),
 .\" .br
-- 
2.5.0

