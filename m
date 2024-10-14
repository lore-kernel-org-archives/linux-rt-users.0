Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ABC155303
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Oct 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943212; cv=none; b=YV9OvT9A+jR6iogmiqFkusECksDqHln/AFAFFknerbNL8ah/MkEvxh9XTuSexWJV2qvlox+09kUtrn3SX390Yx/lgZemJmM6kA3je3Zpi2I1iRdlRsWDFYd+TiWbMpwoRiafpWvWUPRlrxOWe0nXWHdExgQ8jdPROtX6rHYBpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943212; c=relaxed/simple;
	bh=CpaWBS3H6Q0FIq5spIh823ScWo69g+hv3UCvPqTGDkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nw7Facdf3IAvHFNGD8QhkifFnOlY9zFVER5ikQbdM0m+bMqyl8yjr8/7cJi5/bfR191CvinUAMX7CrsO7dPor01gjwP0g03UfQsikIwwxLe6KtMWEHE0gdqn1yzKQDfQONpUV7PWYcC5+TjPJL6W1+csB+O5Wr0qX2LxGlw96zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BMI/w1JK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMI/w1JK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728943209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q1FZPx/1V2Ye0/1N1cXpIg4riw72Nn2phxOF17fhKVI=;
	b=BMI/w1JKYYwc+iupYDwndDJX+FwXw7qaTVdrYbfCkaL8StCJEyulW8aZdPD549neR+hGsz
	R432JfO/8cD43UAulhZESahjYvFKYmnJjuL6pGFQSJ6h0D4aPGdjEbtk2gjRD+wfkss9wE
	neKUJGFkghLuwzfgRR+aM7hTkyPLUz4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-kXQJ9JmZM4egEmcpP75KlQ-1; Mon,
 14 Oct 2024 18:00:07 -0400
X-MC-Unique: kXQJ9JmZM4egEmcpP75KlQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E8831956083
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Oct 2024 22:00:06 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.193.64])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94CFB300019D;
	Mon, 14 Oct 2024 22:00:04 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	williams@redhat.com
Subject: [PATCH] cyclictest: Fix help text for '-a' option
Date: Mon, 14 Oct 2024 23:59:46 +0200
Message-ID: <20241014215946.1833576-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix the help text for '-a' or '--affinity' option.

Tested with the following command (output editted to indicate thread
ranking, i.e., Thread 0 is the 1st thread, Thread 1 is the 2nd thread,
and so on):

	# cyclictest -t -a3-5,0 -t 5 -D1 -v
	[...]
	Thread 0 using cpu 0.	<-- 1st thread
	Thread 0 Interval: 1500
	Thread 1 using cpu 3.	<-- 2nd thread
	Thread 1 Interval: 2000
	Thread 2 using cpu 4.	<-- 3rd thread
	Thread 2 Interval: 2500
	Thread 3 using cpu 5.	<-- 4th thread
	Thread 3 Interval: 3000
	Thread 4 using cpu 0.	<-- 5th thread
	Thread 4 Interval: 3500
	[...]

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 src/cyclictest/cyclictest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c5c3389..f3ab836 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -769,9 +769,9 @@ static void display_help(int error)
 	       "-a [CPUSET] --affinity     Run thread #N on processor #N, if possible, or if CPUSET\n"
 	       "                           given, pin threads to that set of processors in round-\n"
 	       "                           robin order.  E.g. -a 2 pins all threads to CPU 2,\n"
-	       "                           but -a 3-5,0 -t 5 will run the first and fifth\n"
-	       "                           threads on CPU (0),thread #2 on CPU 3, thread #3\n"
-	       "                           on CPU 4, and thread #5 on CPU 5.\n"
+	       "                           but -a 3-5,0 -t 5 will run the first and fifth threads\n"
+	       "                           on CPU 0, the second thread on CPU 3, the third thread\n"
+	       "                           on CPU 4, and the fourth thread on CPU 5.\n"
 	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
-- 
2.46.2

