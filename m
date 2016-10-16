From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch] drivers/zram: Don't disable preemption in
 zcomp_stream_get/put()
Date: Sun, 16 Oct 2016 05:14:22 +0200
Message-ID: <1476587662.1538.8.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


In v4.7, the driver switched to percpu compression streams, disabling
preemption (get/put_cpu_ptr()).  Use get/put_cpu_light() instead.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 drivers/block/zram/zcomp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -118,12 +118,12 @@ ssize_t zcomp_available_show(const char
 
 struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
-	return *get_cpu_ptr(comp->stream);
+	return *per_cpu_ptr(comp->stream, get_cpu_light());
 }
 
 void zcomp_stream_put(struct zcomp *comp)
 {
-	put_cpu_ptr(comp->stream);
+	put_cpu_light();
 }
 
 int zcomp_compress(struct zcomp_strm *zstrm,
