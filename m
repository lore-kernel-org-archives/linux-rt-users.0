Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from webbox1416.server-home.net ([77.236.96.61]:58243 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751742AbeEBNWD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 May 2018 09:22:03 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id 6583927A5EB
        for <linux-rt-users@vger.kernel.org>; Wed,  2 May 2018 15:12:41 +0200 (CEST)
From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/1] squashfs: Disable "percpu multiple decompressor" on RT
Date: Wed,  2 May 2018 15:12:33 +0200
Message-Id: <20180502131233.17029-1-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

This decompressor can introduce a huge latency when a to be executed
process have to read and decompress directly from mass storage.
Using a QSPI flash and squashfs, starting htop causes a latency of ~8000µs
to a running cyclictest. The "multiple decompressor" is fine though.
The cause is that squashfs_decompress() calls get_cpu_ptr(). If this is
done on all CPUs no task will be executed until the decompression has
finished.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 fs/squashfs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/squashfs/Kconfig b/fs/squashfs/Kconfig
index 1adb3346b9d6..246c5966173d 100644
--- a/fs/squashfs/Kconfig
+++ b/fs/squashfs/Kconfig
@@ -86,6 +86,7 @@ config SQUASHFS_DECOMP_MULTI
 
 config SQUASHFS_DECOMP_MULTI_PERCPU
 	bool "Use percpu multiple decompressors for parallel I/O"
+	depends on !PREEMPT_RT_BASE
 	help
 	  By default Squashfs uses a single decompressor but it gives
 	  poor performance on parallel I/O workloads when using multiple CPU
-- 
2.16.1

