Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D75304D7
	for <linux-rt-users@vger.kernel.org>; Wed, 23 Sep 2026 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169204; cv=none; b=O/zUGzGZwa2jOcb6unG7r5Dfy9URDEUsxU886wrCJdHmOGpyO+xxXMxxWZ3EHFvYgLCa0iBG5eNbVcfZwd3DYDx+Qw8c4ESObAAVF2bCv4jCxxuZEJkjiIrEvYm5dPl0drf3SX/V+y5hY2aIuWrVKnKZ20HRpONPzbPm6kudtYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169204; c=relaxed/simple;
	bh=pZNpLxJzt/+4hhPklpajPNTd/jga57NhxEOYNlYTDaI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JDbU0gnPL6WWjW7ztTfDQMg7M5f+ys7BJlnUbqRUmJ+emDyAuOrdmtyZzF8ToVfeSljE5V0jHE05cH0u9l36B0fBhnPJ2/1UL7QMeUu/JScyAozqGhHGPRCTlull+xQdkqCHIZCxNeDvv8EY/YlFWnAp8sWPbplixHmJhnhl7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YdaWehMr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DzlKt91E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdaWehMr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DzlKt91E"
Date: Wed, 23 Sep 2026 15:13:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790169201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tOOYJNx958wIS13I253Nlq1CHBL2byyhk/LD9OSydPM=;
	b=YdaWehMrQkddEJsZBI3pMu2ouuIFwpMPmidpIC2vpk0ddWoZXcjq2QlsGLQFUi7iTSVmt1
	rsod2S1sNdNS0aaGqzs5Qtbi8baq2BHLOR//TVhwU/eqY+qoWHdE4bcHvU/UclCVOSoDbL
	423mCqwbdqcYmkun3YDMIEQ8okEe7ERwdpe885JDDVF5oGgZP+PIUhAj6hPDBGcfAoDFRx
	s8C8aeoCFDe8PisCvGQJQnx0uB2zxWdY0cGabhyrueacA7OaE6puh/eoEfy2Yj6qy7fTue
	QCyhvYzdwCZkzDF4Ktd8hqCc4UpOMQflTCczr1tb28eGALUYSRRZz3EFutwIeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790169201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=tOOYJNx958wIS13I253Nlq1CHBL2byyhk/LD9OSydPM=;
	b=DzlKt91EP2g4siRVcL/31it9pF51Nj1nxFm1zhNOl7jYXGxQVuZDs/Mqsfd9gVWErXNVb1
	960FAoAhrnQH8sBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Subject: [PATCH rt-tests] rt-utils: Remove access to /sys/kernel/realtime
Message-ID: <20260923131320.5zhWJFy0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The json file reads /sys/kernel/realtime and then writes the attribute
'realtime' = 1 if its content was 1. That file is only created with the
PREEMPT_RT patch applied will not be submitted upstream.
The information can be deducted from the uname(2) function which is used
and all fields are written into the json file.

Set the 'realtime' attribute to 1 if the version field contains
'PREEMPT_RT'. This was always the case.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/lib/rt-utils.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index aa70c788d0259..6622f5364c07f 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -508,11 +508,9 @@ void rt_write_json(const char *filename, int return_code,
 		  void (*cb)(FILE *, void *),
 		  void *data)
 {
-	unsigned char buf[1];
 	struct utsname uts;
 	char ts_end[MAX_TS_SIZE];
-	FILE *f, *s;
-	size_t n;
+	FILE *f;
 	int rt = 0;
 
 	if (!filename || !strcmp("-", filename)) {
@@ -525,17 +523,12 @@ void rt_write_json(const char *filename, int return_code,
 
 	get_timestamp(ts_end);
 
-	s = fopen("/sys/kernel/realtime", "r");
-	if (s) {
-		n = fread(buf, 1, 1, s);
-		if (n == 1 && buf[0] == '1')
-			rt = 1;
-		fclose(s);
-	}
-
 	if (uname(&uts))
 		err_exit(errno, "Could not retrieve system information");
 
+	if (strstr(uts.version, "PREEMPT_RT"))
+		rt = 1;
+
 	fprintf(f, "{\n");
 	fprintf(f, "  \"file_version\": 1,\n");
 	fprintf(f, "  \"cmdline:\": \"%s\",\n", test_cmdline);
-- 
2.55.0

