Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFE62EA162
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Jun 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948773; cv=none; b=KJycJf7YHb9qLyTgDGCd7EtSvpWWjIoVDUCc9+1Fx9cs61EBJ5OtpwR/hST30r828IjRNrlZuNsRSbVuD/jkcOxwfAnI/TxGMS42n+nn1eg54R6fLCMCB4h4tYErzU/W5ZXF/sdHeNNjDLBFbG6FK5ruwU62KcNiBdQdwzrifpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948773; c=relaxed/simple;
	bh=zdbFTV4hwSBL++7iJQrLTdcZ/BUKae8OmNRXzU21gHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrCk/Igz0riKGm4tkQMm6jIcew4BVX3k4hiaE7fwibw62fEcED00rG8iNoL8kmJD33YALlPb5XXHUdtL0uqFmLkuFs/BB9pdTsu2RWTWS0LRc21LE7Q1GkvYXIckOjjgi7Hm56voNBDmp5+IF1T2r8Q7e4dUJY5E+aECC3MRZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3hktPME; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3hktPME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750948767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GQjsTW4aJT1jkUs3Mw5GDJpssZ9gnAY+k1uNVViqeLE=;
	b=Y3hktPMEQ0o7djEnwi7gh5cPvvk3qxkH3Je+MlZdxeNCSLYHF/LBnKis6A2eqfPkDUDLVS
	NO4vBI+2sP4f+11ViWegLQhZoPtz5su6xmrpkhuXda/hDxK1eX1lYl/poXmuEkBSYbfCib
	dFoL+Qz2thp1NM1G3cNStcyou+ovBas=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-9P8GbJlROhS4z3Ot16Vhpg-1; Thu,
 26 Jun 2025 10:39:26 -0400
X-MC-Unique: 9P8GbJlROhS4z3Ot16Vhpg-1
X-Mimecast-MFC-AGG-ID: 9P8GbJlROhS4z3Ot16Vhpg_1750948765
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BF631800290
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Jun 2025 14:39:25 +0000 (UTC)
Received: from localhost (unknown [10.20.28.49])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B250B19AC0FA;
	Thu, 26 Jun 2025 14:39:24 +0000 (UTC)
From: Aseef Imran <aimran@redhat.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Aseef Imran <aimran@redhat.com>
Subject: [PATCH] Modified --spike and --breaktrace to allow capturing latencies lower than 2 us
Date: Thu, 26 Jun 2025 10:38:33 -0400
Message-ID: <20250626143833.64309-1-aimran@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Currently it is not possible to record spikes lasting less than 2 us when
specifying the --spike option. This is behavior is the result of a combination
of the following factors:
1. Spikes are only recorded if spike > diff (i.e. NOT >=)
2. If one sets spike = 0, the option has no effect.
3. Setting negative values for the spike also does not have the desired affect
due to reasons related to type conversion.

This patch aims to correct this behavior by allowing one to record latencies
that are < 2us. The ability to record such latencies is important for some use
cases such as when one is interested in measuring the latency of a system that
is expected to be very low latency or for statistical purposes where having the
entire distribution of latencies is important (especially in the case of --spike).
Currently methods like analyzing print statements to console are not sufficient
as print messages to std out are only updated once every 10ms (which means one
will miss several individual latency records depending on the length of the
interval used). This same logical fix is also applied to the --breaktrace option
for consistency.

This patch also improves command documentation related to --spike and --breaktrace
by correcting inaccurate descriptions and documenting certain edge cases with
argument usage.

Signed-off-by: Aseef Imran <aimran@redhat.com>
---
 src/cyclictest/cyclictest.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 890da5d..faa08c1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -149,7 +149,7 @@ struct thread_stat {
 
 static pthread_mutex_t trigger_lock = PTHREAD_MUTEX_INITIALIZER;
 
-static int trigger = 0;	/* Record spikes > trigger, 0 means don't record */
+static int trigger = -2;	/* Record spikes > trigger, -2 or below means don't record */
 static int trigger_list_size = 1024;	/* Number of list nodes */
 
 /* Info to store when the diff is greater than the trigger */
@@ -171,7 +171,7 @@ static void trigger_print();
 static void trigger_update(struct thread_param *par, int diff, int64_t ts);
 
 static int shutdown;
-static int tracelimit = 0;
+static int tracelimit = -2;	/* Stop trace on latency > trigger, -2 or below means don't record */
 static int trace_marker = 0;
 static int verbose = 0;
 static int oscope_reduction = 1;
@@ -747,7 +747,7 @@ static void *timerthread(void *param)
 
 	while (!shutdown) {
 
-		uint64_t diff;
+		int64_t diff;
 		unsigned long diff_smi = 0;
 		int sigs, ret;
 
@@ -837,14 +837,14 @@ static void *timerthread(void *param)
 				pthread_cond_signal(&refresh_on_max_cond);
 		}
 		stat->avg += (double) diff;
-
-		if (trigger && (diff > trigger))
+		
+		if (trigger >= -1 && (diff > trigger))
 			trigger_update(par, diff, calctime(now));
-
+			
 		if (duration && (calcdiff(now, stop) >= 0))
 			shutdown++;
 
-		if (!stopped && tracelimit && (diff > tracelimit)) {
+		if (!stopped && tracelimit >= -1 && (diff > tracelimit)) {
 			stopped++;
 			shutdown++;
 			pthread_mutex_lock(&break_thread_id_lock);
@@ -939,7 +939,9 @@ static void display_help(int error)
 	       "                           the third thread on CPU 4,\n"
 	       "                           and the fourth thread on CPU 5.\n"
 	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
-	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	       "-b trgr  --breaktrace=trgr send break trace command when latency > trigger. Trigger\n"
+		   "						   threshold is in ns if the --nsec option is supplied and us\n"
+		   "			               otherwise.\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
 	       "                           0 = CLOCK_MONOTONIC (default)\n"
 	       "                           1 = CLOCK_REALTIME\n"
@@ -991,10 +993,10 @@ static void display_help(int error)
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
 	       "-S       --smp             Standard SMP testing: options -a -t and same priority\n"
 	       "                           of all threads\n"
-	       "	--spike=<trigger>  record all spikes > trigger\n"
+	       "	--spike=trgr  record all spikes > trgr. Set to -1 to record all measurements.\n"
 	       "	--spike-nodes=[num of nodes]\n"
-	       "			   These are the maximum number of spikes we can record.\n"
-	       "			   The default is 1024 if not specified\n"
+	       "			   These are the maximum number of spikes we can record. The default\n"
+	       "			   is 1024 if not specified. Must only be specified after --spike.\n"
 #ifdef ARCH_HAS_SMI_COUNTER
                "         --smi             Enable SMI counting\n"
 #endif
@@ -1304,7 +1306,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			trigger = atoi(optarg);
 			break;
 		case OPT_TRIGGER_NODES:
-			if (trigger)
+			if (trigger >= -1)
 				trigger_list_size = atoi(optarg);
 			break;
 		case 'u':
@@ -1935,7 +1937,7 @@ int main(int argc, char **argv)
 				numa_bitmask_weight(affinity_mask));
 	}
 
-	if (trigger) {
+	if (trigger >= -1) {
 		int retval;
 		retval = trigger_init();
 		if (retval != 0) {
@@ -1974,7 +1976,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (tracelimit && trace_marker)
+	if (tracelimit >= -1 && trace_marker)
 		enable_trace_mark();
 
 	if (check_timer())
@@ -2300,7 +2302,7 @@ int main(int argc, char **argv)
 			threadfree(statistics[i]->values, VALBUF_SIZE*sizeof(long), parameters[i]->node);
 	}
 
-	if (trigger)
+	if (trigger >= -1)
 		trigger_print();
 
 	if (histogram)
-- 
2.49.0

