From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch v2] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()
Date: Wed, 19 Oct 2016 17:56:30 +0200
Message-ID: <1476892590.3975.6.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
         <1476587662.1538.8.camel@gmail.com>
         <20161017142428.25dyxefk2arjeyfz@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017142428.25dyxefk2arjeyfz@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2016-10-17 at 16:24 +0200, Sebastian Andrzej Siewior wrote:
> On 2016-10-16 05:14:22 [+0200], Mike Galbraith wrote:
> > 
> > In v4.7, the driver switched to percpu compression streams, disabling
> > preemption (get/put_cpu_ptr()).  Use get/put_cpu_light() instead.
> 
> I am not convinced that this will work. Nothing prevents
> zram_bvec_write() to be reentrant on the same CPU what I can tell from
> browsing over the code and since it uses zstrm->buffer for compression
> it can go wrong. Also I don't know if crypto's tfm handler can be used
> in parallel for any ops (it usually does not work for crypto).
> 
> I suggest a local lock or a good reason why the this patch works.

(taking a break from hotplug squabble to pick on something easier:)

drivers/zram: Don't disable preemption in zcomp_stream_get/put()

In v4.7, the driver switched to percpu compression streams, disabling
preemption vai get/put_cpu_ptr().  Use a local lock instead for RT.
We also have to fix an RT lock order issue in zram_decompress_page()
such that zs_map_object() nests inside of zcomp_stream_put() as it
does in zram_bvec_write().

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 drivers/block/zram/zcomp.c    |    7 +++++--
 drivers/block/zram/zram_drv.c |   11 +++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/cpu.h>
 #include <linux/crypto.h>
+#include <linux/locallock.h>
 
 #include "zcomp.h"
 
@@ -116,14 +117,16 @@ ssize_t zcomp_available_show(const char
 	return sz;
 }
 
+DEFINE_LOCAL_IRQ_LOCK(zram_stream_lock);
+
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return *get_cpu_ptr(comp->stream);
+	return get_locked_var(zram_stream_lock, *comp->stream);
 }
 
 void zcomp_stream_put(struct zcomp *comp)
 {
-	put_cpu_ptr(comp->stream);
+	put_locked_var(zram_stream_lock, *comp->stream);
 }
 
 int zcomp_compress(struct zcomp_strm *zstrm,
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -566,6 +566,7 @@ static int zram_decompress_page(struct z
 	int ret = 0;
 	unsigned char *cmem;
 	struct zram_meta *meta = zram->meta;
+	struct zcomp_strm *zstrm;
 	unsigned long handle;
 	unsigned int size;
 
@@ -579,16 +580,14 @@ static int zram_decompress_page(struct z
 		return 0;
 	}
 
+	zstrm = zcomp_stream_get(zram->comp);
 	cmem = zs_map_object(meta->mem_pool, handle, ZS_MM_RO);
-	if (size == PAGE_SIZE) {
+	if (size == PAGE_SIZE)
 		copy_page(mem, cmem);
-	} else {
-		struct zcomp_strm *zstrm = zcomp_stream_get(zram->comp);
-
+	else
 		ret = zcomp_decompress(zstrm, cmem, size, mem);
-		zcomp_stream_put(zram->comp);
-	}
 	zs_unmap_object(meta->mem_pool, handle);
+	zcomp_stream_put(zram->comp);
 	zram_unlock_table(&meta->table[index]);
 
 	/* Should NEVER happen. Return bio error if it does. */
