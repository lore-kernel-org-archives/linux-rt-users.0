From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 03/22] squashfs: make use of local lock in multi_cpu decompressor
Date: Wed, 05 Sep 2018 08:27:57 -0400
Message-ID: <20180905122834.792329062@goodmis.org>
References: <20180905122754.443196118@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org,
        Alexander Stein <alexander.stein@systec-electronic.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Julia Cartwright <julia@ni.com>

[ Upstream commit c160736542d7b3d67da32848d2f028b8e35730e5 ]

Currently, the squashfs multi_cpu decompressor makes use of
get_cpu_ptr()/put_cpu_ptr(), which unconditionally disable preemption
during decompression.

Because the workload is distributed across CPUs, all CPUs can observe a
very high wakeup latency, which has been seen to be as much as 8000us.

Convert this decompressor to make use of a local lock, which will allow
execution of the decompressor with preemption-enabled, but also ensure
concurrent accesses to the percpu compressor data on the local CPU will
be serialized.

Cc: stable-rt@vger.kernel.org
Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Julia Cartwright <julia@ni.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/squashfs/decompressor_multi_percpu.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
index 23a9c28ad8ea..6a73c4fa88e7 100644
--- a/fs/squashfs/decompressor_multi_percpu.c
+++ b/fs/squashfs/decompressor_multi_percpu.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 #include <linux/buffer_head.h>
+#include <linux/locallock.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
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
+	stream = get_locked_ptr(stream_lock, percpu);
+
+	res = msblk->decompressor->decompress(msblk, stream->stream, bh, b,
+			offset, length, output);
+
+	put_locked_ptr(stream_lock, stream);
 
 	if (res < 0)
 		ERROR("%s decompression failed, data probably corrupt\n",
-- 
2.18.0
