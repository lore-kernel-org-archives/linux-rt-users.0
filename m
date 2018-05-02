Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:36566 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750936AbeEBOg5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 May 2018 10:36:57 -0400
Date: Wed, 2 May 2018 09:37:29 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: [PATCH 1/1] squashfs: Disable "percpu multiple decompressor" on
 RT
Message-ID: <20180502143729.GB967@jcartwri.amer.corp.natinst.com>
References: <20180502131233.17029-1-alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180502131233.17029-1-alexander.stein@systec-electronic.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de, tglx@linutronix.de

On Wed, May 02, 2018 at 03:12:33PM +0200, Alexander Stein wrote:
> This decompressor can introduce a huge latency when a to be executed
> process have to read and decompress directly from mass storage.
> Using a QSPI flash and squashfs, starting htop causes a latency of ~8000µs
> to a running cyclictest. The "multiple decompressor" is fine though.
> The cause is that squashfs_decompress() calls get_cpu_ptr(). If this is
> done on all CPUs no task will be executed until the decompression has
> finished.

Hello Alexander-

Thanks for the patch.

[..]
> +++ b/fs/squashfs/Kconfig
> @@ -86,6 +86,7 @@ config SQUASHFS_DECOMP_MULTI
>  
>  config SQUASHFS_DECOMP_MULTI_PERCPU
>  	bool "Use percpu multiple decompressors for parallel I/O"
> +	depends on !PREEMPT_RT_BASE

Hmm, I think we'd like to get out of the business of disabling Kconfig
options unless we are absolutely not given any other choice.

Looking at the codepaths involved in this squashfs decompressor, it
seems like this is a perfect candidate for the usage of local locks.
Can you give the following patch a try instead?

Thanks!
   Julia

-- 8< --
Subject: [PATCH] squashfs: make use of local lock in multi_cpu decompressor

Currently, the squashfs multi_cpu decompressor makes use of
get_cpu_ptr()/put_cpu_ptr(), which unconditionally disable preemption
during decompression.

Because the workload is distributed across CPUs, all CPUs can observe a
very high wakeup latency, which has been seen to be as much as 8000us.

Convert this decompressor to make use of a local lock, which will allow
execution of the decompressor with preemption-enabled, but also ensure
concurrent accesses to the percpu compressor data on the local CPU will
be serialized.

Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 fs/squashfs/decompressor_multi_percpu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 23a9c28ad8ea..661ced620fd1 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -6,6 +6,7 @@
  * the COPYING file in the top-level directory.
  */
 
+#include <linux/locallock.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/percpu.h>
@@ -25,6 +26,8 @@ struct squashfs_stream {
 	void		*stream;
 };
 
+static DEFINE_LOCAL_IRQ_LOCK(stream_lock);
+
 void *squashfs_decompressor_create(struct squashfs_sb_info *msblk,
 						void *comp_opts)
 {
@@ -79,10 +82,15 @@ int squashfs_decompress(struct squashfs_sb_info *msblk, struct buffer_head **bh,
 {
 	struct squashfs_stream __percpu *percpu =
 			(struct squashfs_stream __percpu *) msblk->stream;
-	struct squashfs_stream *stream = get_cpu_ptr(percpu);
-	int res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
-		offset, length, output);
-	put_cpu_ptr(stream);
+	struct squashfs_stream *stream;
+	int res;
+
+	stream = get_locked_var(stream_lock, percpu);
+
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	put_locked_var(stream_lock, stream);
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
-- 
2.17.0

