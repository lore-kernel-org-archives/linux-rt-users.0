Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20311156991
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Jan 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737705140; cv=none; b=VHa5CVgKTrEuSDDewXSiYwtMRpRZ0j7JIn8S0rNlIjzgJAHCQ15sAWPBDmaXGMxXVCU4V7/DmoYHDzRTTkaa2hCRDwFc7cripvvl+7xZXs+CkjCZy8LMJfB09sNAeORK/kh8kfKYgVealfe3KnR0SorwnBE5jpXVgoadBqczsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737705140; c=relaxed/simple;
	bh=coHeGAipLEWIP2UZ9toguhlwGtw1BWMtuaQ2mTTDyxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u45WArSOubkjiiSP7k0fqO5Rz69mAZucXXYgtWOivlm0MqSFtfzaQoCWk8Mmfc5H132aEDqpxUfFuqlQm2a+9PZ5cvJExfk2jgebPdjao3AnzIDVU/05weajt6W4UtW09ozyGC/J5HqrY3+Xl27auvLbzbTlCgrL84sjfxoKr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FObMyTYI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FObMyTYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737705137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mS7ijYJ/G5HonJR9lNo1CifNAP7igB7TAp8i1V459E=;
	b=FObMyTYIrLB5AqovUqJMcO7SdyXXwIclp1Cs3dYDctwMwxbP9q+inZjDYe1OvcOZQeRoQA
	AIjXorvfURjvs+Z9bPtnp53utXKlmZ3e89/IW1ed8I9roZ2Ck41elO8QYXsUTazNJR1rou
	4aP4owHbRDQ6ZDZxIDhZErbAUWyvv58=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-sV8_bO0bOLWDwbYTJHW0Kg-1; Fri,
 24 Jan 2025 02:52:14 -0500
X-MC-Unique: sV8_bO0bOLWDwbYTJHW0Kg-1
X-Mimecast-MFC-AGG-ID: sV8_bO0bOLWDwbYTJHW0Kg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08EED1955D50
	for <linux-rt-users@vger.kernel.org>; Fri, 24 Jan 2025 07:52:14 +0000 (UTC)
Received: from loobloo.nay.redhat.com (unknown [10.66.36.212])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 811FC1955F1B;
	Fri, 24 Jan 2025 07:52:11 +0000 (UTC)
From: Shizhao Chen <shichen@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH v2] rt-tests: pip_stress: Add option --usleep
Date: Fri, 24 Jan 2025 15:51:57 +0800
Message-ID: <20250124075206.35834-1-shichen@redhat.com>
In-Reply-To: <CADm5pWf1p-SJAWp6fyOhynpxz7gJx6542d+ZPt3e66WC9JSbyA@mail.gmail.com>
References: <CADm5pWf1p-SJAWp6fyOhynpxz7gJx6542d+ZPt3e66WC9JSbyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
index 0d06dd2..0f65ad1 100644
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
+Specify the sleep time in usec of the low priority process. Defaults to 500.
 .BR
 .SH AUTHOR
 pip_stress was written by John Kacur <jkacur at redhat.com>
diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index fb0391b..9bd225f 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -72,7 +72,9 @@ static void usage(int error)
 	printf("pip_stress V %1.2f\n", VERSION);
 	printf("Usage:\n"
 	       "pip_stress <options>\n"\
-	       "-h	--help                  Show this help menu.\n"
+	       "-h       --help          Show this help menu.\n"\
+	       "-u TIME  --usleep=TIME   Specify the sleep time in usec of the low priority process.\n"\
+	       "                         Defaults to 500.\n"
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
+			usleep_val = strtoul(optarg, NULL, 10);
+			break;
 		default:
 			usage(1);
 			break;
-- 
2.47.1

