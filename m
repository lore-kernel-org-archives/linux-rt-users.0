From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/7] drivers/zram: fix zcomp_stream_get() smp_processor_id() use in
 preemptible code
Date: Thu, 23 Nov 2017 00:23:18 -0500
Message-ID: <20171123052629.606402690@goodmis.org>
References: <20171123052317.319740795@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org, Mike Galbraith <efault@gmx.de>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-drivers-zram-fix-zcomp_stream_get-smp_processor_id-u.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.9.61-rt52-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

Use get_local_ptr() instead this_cpu_ptr() to avoid a warning regarding
smp_processor_id() in preemptible code.
raw_cpu_ptr() would be fine, too because the per-CPU data structure is
protected with a spin lock so it does not matter much if we take the
other one.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/block/zram/zcomp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index fa8329ad79fd..8c93ee150ee8 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -120,7 +120,7 @@ struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
 {
 	struct zcomp_strm *zstrm;
 
-	zstrm = *this_cpu_ptr(comp->stream);
+	zstrm = *get_local_ptr(comp->stream);
 	spin_lock(&zstrm->zcomp_lock);
 	return zstrm;
 }
@@ -131,6 +131,7 @@ void zcomp_stream_put(struct zcomp *comp)
 
 	zstrm = *this_cpu_ptr(comp->stream);
 	spin_unlock(&zstrm->zcomp_lock);
+	put_local_ptr(zstrm);
 }
 
 int zcomp_compress(struct zcomp_strm *zstrm,
-- 
2.13.2
