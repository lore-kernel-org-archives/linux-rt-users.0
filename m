From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v3.10-rt] slab: reintroduce cpu_cache_get_on_cpu() static inline
Date: Tue, 8 Oct 2013 14:21:47 -0400
Message-ID: <1381256507-6669-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:59917 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab3JHSWE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Oct 2013 14:22:04 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It was present in the 3.8-rt series, in mm-slab-wrap-functions.patch
but got dropped in the v3.10-rt series.  Without it, compile of
SLAB breaks, even for !RT_FULL builds.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Should be squashed into patches/mm-slab-wrap-functions.patch ]

 mm/slab.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
index 0a3d6d3..b242b50 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -700,6 +700,12 @@ static inline struct array_cache *cpu_cache_get(struct kmem_cache *cachep)
 	return cachep->array[smp_processor_id()];
 }
 
+static inline struct array_cache *cpu_cache_get_on_cpu(struct kmem_cache *cachep,
+						       int cpu)
+{
+	return cachep->array[cpu];
+}
+
 static size_t slab_mgmt_size(size_t nr_objs, size_t align)
 {
 	return ALIGN(sizeof(struct slab)+nr_objs*sizeof(kmem_bufctl_t), align);
-- 
1.8.1.2

