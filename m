Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11137136E3B
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2025 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737612298; cv=none; b=sWj315xCC2lFF8zvtqQu9ejrOA+1hPk7c7sKpC4jN76pZYgBIc2L5KfiSqYceNqGFwRYCv0ktD7Y0GrRDIUeRKFGmrzYH5UgWgPGZ5I/AEY4O/9VM3Ib/wHX/MTaOka/73fF6cKnqRoPhNYqYfrjbDrJuCdmP/3YQ7KH0KG1XUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737612298; c=relaxed/simple;
	bh=27XBhMg2+XQ5fQ5AQZJ9IM1nGR5yvoUjpSzQWlbCbOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXz5h46OY1dtd22lpVZg6Y0tPvdpUNUYJHDgK/BIIVCRxcS69Ss1xB7YVHTZqy29sDCax5VPB+50WR/g6hX7RtLLHk7y5whx8U2t8vmcsPePDoaRm/FIA8k8+6tJKYjl2LQkM6yIug0tQ6VUQ9hUjtldc9rUTNt9HYxXKOPnAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvF4i6sF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvF4i6sF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737612294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KlGKfCHHf+PmM5cevItB/62HAV7d5Fkq8oXEH5i7OZ0=;
	b=CvF4i6sFPqOteQGU/MPqLSRXoc3qIXbOPgaV4fPQ8GGoQNmq0UVnvPfvfBbjCIyTUuclVp
	MMKkj9x1/UyfLaCPhEJJxUIJoifhA5M5g+hksATY8/hWh366rA0Xx3vkmYYbT3lDB5NsGK
	WgxM26+42NFmO5lvyUTYip3tGiJXS9M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-GMJho_9vMuqU9tmBYe6kyg-1; Thu,
 23 Jan 2025 01:04:52 -0500
X-MC-Unique: GMJho_9vMuqU9tmBYe6kyg-1
X-Mimecast-MFC-AGG-ID: GMJho_9vMuqU9tmBYe6kyg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D54FC195608B
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2025 06:04:51 +0000 (UTC)
Received: from loobloo.redhat.com (unknown [10.72.112.227])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4DFE19560B7;
	Thu, 23 Jan 2025 06:04:49 +0000 (UTC)
From: Shizhao Chen <shichen@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH] rt-tests: pip_stress: Add option --usleep
Date: Thu, 23 Jan 2025 14:04:38 +0800
Message-ID: <20250123060443.31371-1-shichen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Different hardwares have different threasholds for usleep_val to
reliably trigger an prio inversion, add option --usleep to allow
specifying it at runtime, to facilitate testing of prio inheritance
on different platforms.

Signed-off-by: Shizhao Chen <shichen@redhat.com>
---
 src/pi_tests/pip_stress.8 |  6 +++++-
 src/pi_tests/pip_stress.c | 10 ++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/pi_tests/pip_stress.8 b/src/pi_tests/pip_stress.8
index 0d06dd2..f55e2d8 100644
--- a/src/pi_tests/pip_stress.8
+++ b/src/pi_tests/pip_stress.8
@@ -5,7 +5,8 @@
 .B pip_stress \- Priority Inheritance with processes
 .SH SYNOPSIS
 .B pip_stress
-
+.RB [ \-u|\-\-usleep
+.IR TIME ]
 .SH DESCRIPTION
 This program demonstrates the technique of using priority inheritance (PI)
 mutexes with processes instead of threads.
@@ -41,6 +42,9 @@ merely increase the time that the low priority process sleeps while
 holding the lock. (usleep);
 Also note that you have to run as a user with permission to change
 scheduling priorities.
+.SH OPTIONS
+.IP "\-u TIME,\-\-usleep=TIME"
+Specify the sleep time of the low priority process. Defaults to 500(us).
 .BR
 .SH AUTHOR
 pip_stress was written by John Kacur <jkacur at redhat.com>
diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index fb0391b..782e5db 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -72,7 +72,9 @@ static void usage(int error)
 	printf("pip_stress V %1.2f\n", VERSION);
 	printf("Usage:\n"
 	       "pip_stress <options>\n"\
-	       "-h	--help                  Show this help menu.\n"
+	       "-h       --help          Show this help menu.\n"\
+	       "-u TIME  --usleep=TIME   Specify the sleep time of the low priority process.\n"\
+	       "                         Defaults to 500(us).\n"
 	       );
 	exit(error);
 }
@@ -88,16 +90,20 @@ int main(int argc, char *argv[])
 	for (;;) {
 		struct option long_options[] = {
 			{ "help",	no_argument,		NULL,	'h' },
+			{ "usleep",	required_argument,	NULL,	'u' },
 			{ NULL,		0,			NULL,	0 },
 		};
 
-		int c = getopt_long(argc, argv, "s:h", long_options, NULL);
+		int c = getopt_long(argc, argv, "hu:", long_options, NULL);
 		if (c == -1)
 			break;
 		switch (c) {
 		case 'h':
 			usage(0);
 			break;
+		case 'u':
+			usleep_val = (useconds_t)strtoul(optarg, NULL, 10);
+			break;
 		default:
 			usage(1);
 			break;
-- 
2.47.1

