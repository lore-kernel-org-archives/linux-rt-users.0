From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch v2] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()
Date: Thu, 20 Oct 2016 13:02:00 +0200
Message-ID: <20161020110200.zt2yguxq2zdvqyfc@linutronix.de>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
 <1476587662.1538.8.camel@gmail.com>
 <20161017142428.25dyxefk2arjeyfz@linutronix.de>
 <1476892590.3975.6.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47869 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757162AbcJTLCD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Oct 2016 07:02:03 -0400
Content-Disposition: inline
In-Reply-To: <1476892590.3975.6.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-10-19 17:56:30 [+0200], Mike Galbraith wrote:
> In v4.7, the driver switched to percpu compression streams, disabling
> preemption vai get/put_cpu_ptr().  Use a local lock instead for RT.

since you could have multiple streams which would be then serialized
with the local lock I went for this:

From: Mike Galbraith <umgwanakikbuti@gmail.com>
Date: Thu, 20 Oct 2016 11:15:22 +0200
Subject: [PATCH] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()

In v4.7, the driver switched to percpu compression streams, disabling
preemption via get/put_cpu_ptr(). Use a per-zcomp_strm lock here. We
also have to fix an lock order issue in zram_decompress_page() such
that zs_map_object() nests inside of zcomp_stream_put() as it does in
zram_bvec_write().

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
[bigeasy: get_locked_var() -> per zcomp_strm lock]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/block/zram/zcomp.c    |   12 ++++++++++--
 drivers/block/zram/zcomp.h    |    1 +
 drivers/block/zram/zram_drv.c |    6 +++---
 3 files changed, 14 insertions(+), 5 deletions(-)

--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -118,12 +118,19 @@ ssize_t zcomp_available_show(const char
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return *get_cpu_ptr(comp->stream);
+	struct zcomp_strm *zstrm;
+
+	zstrm = *this_cpu_ptr(comp->stream);
+	spin_lock(&zstrm->zcomp_lock);
+	return zstrm;
 }
 
 void zcomp_stream_put(struct zcomp *comp)
 {
-	put_cpu_ptr(comp->stream);
+	struct zcomp_strm *zstrm;
+
+	zstrm = *this_cpu_ptr(comp->stream);
+	spin_unlock(&zstrm->zcomp_lock);
 }
 
 int zcomp_compress(struct zcomp_strm *zstrm,
@@ -174,6 +181,7 @@ static int __zcomp_cpu_notifier(struct z
 			pr_err("Can't allocate a compression stream\n");
 			return NOTIFY_BAD;
 		}
+		spin_lock_init(&zstrm->zcomp_lock);
 		*per_cpu_ptr(comp->stream, cpu) = zstrm;
 		break;
 	case CPU_DEAD:
--- a/drivers/block/zram/zcomp.h
+++ b/drivers/block/zram/zcomp.h
@@ -14,6 +14,7 @@ struct zcomp_strm {
 	/* compression/decompression buffer */
 	void *buffer;
 	struct crypto_comp *tfm;
+	spinlock_t zcomp_lock;
 };
 
 /* dynamic per-device compression frontend */
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -568,6 +568,7 @@ static int zram_decompress_page(struct z
 	struct zram_meta *meta = zram->meta;
 	unsigned long handle;
 	unsigned int size;
+	struct zcomp_strm *zstrm;
 
 	zram_lock_table(&meta->table[index]);
 	handle = meta->table[index].handle;
@@ -579,16 +580,15 @@ static int zram_decompress_page(struct z
 		return 0;
 	}
 
+	zstrm = zcomp_stream_get(zram->comp);
 	cmem = zs_map_object(meta->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
 		copy_page(mem, cmem);
 	} else {
-		struct zcomp_strm *zstrm = zcomp_stream_get(zram->comp);
-
 		ret = zcomp_decompress(zstrm, cmem, size, mem);
-		zcomp_stream_put(zram->comp);
 	}
 	zs_unmap_object(meta->mem_pool, handle);
+	zcomp_stream_put(zram->comp);
 	zram_unlock_table(&meta->table[index]);
 
 	/* Should NEVER happen. Return bio error if it does. */

Sebastian
