From: Mike Galbraith <efault@gmx.de>
Subject: [patch-rt] drivers/zram: fix zcomp_stream_get() smp_processor_id()
 use in preemptible code
Date: Wed, 23 Aug 2017 11:57:29 +0200
Message-ID: <1503482249.4970.7.camel@gmx.de>
References: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170818120939.b2rj2whb2hgfzjpm@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Use get_local_ptr() vs this_cpu_ptr().

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 drivers/block/zram/zcomp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -120,7 +120,7 @@ struct zcomp_strm *zcomp_stream_get(stru
 {
 	struct zcomp_strm *zstrm;
 
-	zstrm = *this_cpu_ptr(comp->stream);
+	zstrm = *get_local_ptr(comp->stream);
 	spin_lock(&zstrm->zcomp_lock);
 	return zstrm;
 }
@@ -131,6 +131,7 @@ void zcomp_stream_put(struct zcomp *comp
 
 	zstrm = *this_cpu_ptr(comp->stream);
 	spin_unlock(&zstrm->zcomp_lock);
+	put_local_ptr(zstrm);
 }
 
 int zcomp_compress(struct zcomp_strm *zstrm,
