Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235163E1208
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jun 2026 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943652; cv=none; b=cF74NhrstP/6p1H/8rekNgG2ZXVRuE7XdOfv/JYC0pEdbzbnHfUEwl5a5x5fxByjaZn8hD6IbWLPAut6DYwWBLr/jQlxjwI+IulpAjV2wDFK1+jqhTy+3YY3va9GapLdTLy6E1eVfEYbyTU3MoQB1oKkddJOWFkvBoAYEjIaPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943652; c=relaxed/simple;
	bh=ATY1t74RJmFSuq9hQLgGCaVzEb8zUfmC4+VsZ4vtxWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNJIOCOQwrG9Jy1HaAFhKzHtAJgBDS+PrM8UlucQ7sfKSRbvr2BiZmIESaWWEwtltZQeVGYsD1Tci6trGaXv3RW3Syz6ddOC9wfp7fAtvi4aravxjqvj9UdpTdYLLR8TVOkcKBVhw9nbmC+EpuE34zmrtLZOu6FPyTtbE21qMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OPLOwlC/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPLOwlC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780943650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsdYPJqv0jUg0kyWFrdU0g9ivG9K0ztUzkxznYGQfw8=;
	b=OPLOwlC/i16OsdnhAwmclAvXcmkmYZ4vOwJnWCrJ4DhnQ91hWJ/SXmXesndE1U61mnsg1Y
	FU5uVifp09Nit3Vs6cIFF/Q0BYx2sTB/ztxLzjOz/KL5aivPNgOXoMHRKgSelobQXiM1dt
	b5pOUdECMQA7yMp0LKGiumnnECmn5UQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-i2K4ypr0OPaijLWMOM2s1Q-1; Mon,
 08 Jun 2026 14:34:07 -0400
X-MC-Unique: i2K4ypr0OPaijLWMOM2s1Q-1
X-Mimecast-MFC-AGG-ID: i2K4ypr0OPaijLWMOM2s1Q_1780943646
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1048D1977034;
	Mon,  8 Jun 2026 18:34:06 +0000 (UTC)
Received: from wcosta-defaultstring.rmtbr.csb (unknown [10.22.88.160])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0619A3692A;
	Mon,  8 Jun 2026 18:34:03 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-rt-users@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	luffyluo@tencent.com,
	davidlt@rivosinc.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH stalld 41/52] stalld: fix signed integer overflow in set_reservation
Date: Mon,  8 Jun 2026 15:31:51 -0300
Message-ID: <20260608183206.140526-42-wander@redhat.com>
In-Reply-To: <20260608183206.140526-1-wander@redhat.com>
References: <20260608183206.140526-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The deadline period calculation multiplies the period parameter by one
billion using int arithmetic. For period values of three or four the
product exceeds INT_MAX, triggering signed integer overflow and passing
a corrupt value to sched_setattr().

Switch the local variables to uint64_t, apply ULL suffixes so the
multiplication is performed in 64-bit arithmetic, change the function
parameters to unsigned int, and use PRIu64 in the log format string.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 src/stalld.h |  2 +-
 src/utils.c  | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/stalld.h b/src/stalld.h
index b910870..81ce9f7 100644
--- a/src/stalld.h
+++ b/src/stalld.h
@@ -204,7 +204,7 @@ int rt_throttling_is_off(void);
 int turn_off_rt_throttling(void);
 void cleanup_regex(unsigned int *nr_task, regex_t **compiled_expr);
 void find_sched_debug_path(void);
-int set_reservation(int period, int reservation);
+int set_reservation(unsigned int period, unsigned int reservation);
 int get_tgid(int pid);
 void merge_tasks_info(int cpu, struct task_info *old_tasks, int nr_old, struct task_info *new_tasks, int nr_new);
 int set_cpu_affinity(char *cpu_list);
diff --git a/src/utils.c b/src/utils.c
index 5d54ae9..738d059 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <sys/sysinfo.h>
 #include <mntent.h>
+#include <inttypes.h>
 
 #include "stalld.h"
 #include "sched_debug.h"
@@ -702,9 +703,9 @@ void write_pidfile(void)
  * picture, as at the end, the task will receive the % of time, while
  * avoiding have yet another knob to handle.
  */
-int set_reservation(int period, int reservation)
+int set_reservation(unsigned int period, unsigned int reservation)
 {
-	unsigned long dl_period, dl_runtime;
+	uint64_t dl_period, dl_runtime;
 	struct sched_attr attr;
 	int flags = 0;
 	int ret;
@@ -715,8 +716,8 @@ int set_reservation(int period, int reservation)
 	if (period > 4)
 		period = 1;
 
-	dl_period = period * 1000 * 1000 * 1000;
-	dl_runtime = dl_period * reservation / 100;
+	dl_period = period * 1000ULL * 1000ULL * 1000ULL;
+	dl_runtime = dl_period * reservation / 100ULL;
 
 	memset(&attr, 0, sizeof(attr));
 	attr.size = sizeof(attr);
@@ -731,7 +732,7 @@ int set_reservation(int period, int reservation)
 		return ret;
 	}
 
-	log_msg("successfully set %d%% SCHED_DEADLINE reservation runtime/period = %lld/%lld\n",
+	log_msg("successfully set %d%% SCHED_DEADLINE reservation runtime/period = %"PRIu64"/%"PRIu64"\n",
 		reservation, dl_runtime, dl_period);
 	return 0;
 }
-- 
2.54.0

