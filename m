Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71854DE725
	for <linux-rt-users@vger.kernel.org>; Thu,  1 Oct 2026 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849538; cv=none; b=n8lRTfk5QyMGn2vCI689wb/Xcjps/rcQL9eTLj6D7cu8HdVCWrOY7f+Ytnw7LdCKDPnAWmw9PMnDEYJo0zS8B2NtqwqgOmzL8SSHmqboRUrQ7xIQXuUqgorxLj2wHFviDnbfXqpQRoHqC+9cSVJOXryt7JpJcgD8wYObdovW72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849538; c=relaxed/simple;
	bh=jiMa3LvigGqxJM9dmwofP0pma4uaN1plgovfS482+xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbHqyclNQEa7qOjpfZw/wRxjFGrKnGaaAkijK9V173AvIUFLgtkqf58KBPNWOK1MRbvvUc0W88adnPs80Gd6W057B4qnnOR96TqDyzihtr5nflPIw+x+Ng0CQFlFBqE/OeHQSlPcsduutVRNSMSgKbIsZ3+IX//tCfqSENXXaeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WseVyDXW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDZiN5yl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WseVyDXW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDZiN5yl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790849522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cDJsxkM+SvXdClLQE052pKwrNvvVaUn0QYC/SN5qJQc=;
	b=WseVyDXWvYkBi1ScO1VeF3OVn9Icvtx+jk4tCqkr6LhRHsR2GlSqJ7Umydy1RMeNgdTW7b
	IG7OpYevr2Sbq3bypWnfLq2QNlpJVsc7PwLhNklIDOBc15bDWrFgGN+lE1b5nnWEIVuzuq
	pqnUByXmbxuBABSt/C/9qe5SKW9mhyQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-yopnj5rqMHyHIk9wrTV7YA-1; Thu, 01 Oct 2026 06:12:00 -0400
X-MC-Unique: yopnj5rqMHyHIk9wrTV7YA-1
X-Mimecast-MFC-AGG-ID: yopnj5rqMHyHIk9wrTV7YA_1790849519
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b0a199b20so506724f8f.1
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Oct 2026 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790849519; x=1791454319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cDJsxkM+SvXdClLQE052pKwrNvvVaUn0QYC/SN5qJQc=;
        b=iDZiN5ylDus7FW5MgvSjt5PudFNL1iGqoJWxi4Tjt72EHa0nGRqQXoEdrRmq84wX20
         syRiTrHDjtUkKOb91Lc6Xy6CnOU0MInRuk0jT6fyUVLh8fDZvWjbbgDECFGZVWS2rs6P
         R6Oc5Yy0kUyrDlXnpx+41NNZBe2+pNKelFevTnIN89rehbvl55l6iWU3hXMWVxsYsY9B
         /cK1zhRDZ0KUH22WfapGPxQMJZNjKjxeRwRiUmuBt6F7liEJ00L59ASJzYbDIKEhtFkp
         tneWaZg0tyeZHM/5iHsY5o4uXiJBKOrElxumEgP1H4Qn585gFxmkWpt5S0dgSrqUaMGC
         ZLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790849519; x=1791454319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cDJsxkM+SvXdClLQE052pKwrNvvVaUn0QYC/SN5qJQc=;
        b=MvZBD3vRK2y2TFVRs0eHNu/0h+aI+6Z8Rx+dMOTOV1lxl1qD5L6+bICAqkrphlQUHo
         rXRkM7T8guERPeBmChEfuNufSvE4aMX/ho5Vy8Zv6uVs9qbXsXF3T+y2zpcr+2FFAR5f
         hweXXh99dh7YUVY9fbNHJrHvUbYeQXlvNGQGNZXmyjs3vgy9uEQaYELSEWjFh1JrJng1
         8nXt8Rzl/IphSg75MY2UFDP6SF+mocZtCvXc+k76Z/6j64PadHjIASGRL54slxtDjpwX
         AYhpWpU+JBvvC8oDv4wkS6330aYWYmwNnxnlDBQDwyzm9l58jBOnQufB3Qv3+w544H/e
         TFXw==
X-Gm-Message-State: AFuF++mJu9SHSNC+TMQJIH/EVl6v7cyuPfd2galDRP3XVK+ukYxXFCjO
	h8n+3ZvEakP0L8/6yAIMwBQ7RJefuGoERsT2spbdbhCCI8HZWOaWsHG0w+elTJqCJQASN9acdgm
	vHuYPmja2123lToD/YbmTEiEd0LlyW0XiAbrharfdrWXlPNqzeYtbfbJMxgPHv77Q/Y/y
X-Gm-Gg: AYBFou143B5ZULkgvTPYDb1/cHgBfWtacj/EGp4LBksBRKr3gWXMiWLu2/WysZUicTk
	8aX0APfCKXhGY6XASr8lQNHk/fInm12ysHdPZG5qFFSNzcQhNAEYz2UlZDVIrTN8GN36k99Fys5
	V5SRYUYWEAS3p9qgyGwo/clo2FpU6g8wdZJ/jgGCylLgllUABAA0gIy/mhA/tmzRxDgfM39AgqK
	jPkEqF6IyCRStjJVpiPDJYmBoj32+maWiwhmFa1WBgjlp3fFEfM89n4xmlxGf6Oz2KJV/N0bcDq
	l0jkf1Yi++qUroH15TQ30eZ1lyVp6lsUUVHRgKeY1DHAwJ7GLgjXsZlnXfKBA/9QaiBV6YWTGRv
	KUZOkts0DpT57rxwX
X-Received: by 2002:a05:600c:4512:b0:49f:bd3c:bc1b with SMTP id 5b1f17b1804b1-4a01b00ee5dmr73130265e9.22.1790849519375;
        Thu, 01 Oct 2026 03:11:59 -0700 (PDT)
X-Received: by 2002:a05:600c:4512:b0:49f:bd3c:bc1b with SMTP id 5b1f17b1804b1-4a01b00ee5dmr73129845e9.22.1790849518874;
        Thu, 01 Oct 2026 03:11:58 -0700 (PDT)
Received: from cshulyup.raanaii.csb ([2a00:a041:e223:1b00:cde9:6812:f4a4:646])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f952931sm63334295e9.13.2026.10.01.03.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:11:58 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh=20=28Schneider=20Electric=29?= <thomas.weissschuh@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Suneeth D <Suneeth.D@amd.com>,
	Costa Shulyupin <costa.shul@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH v4] cyclictest, cyclicdeadline: Exit with failure when breaktrace threshold is exceeded
Date: Thu,  1 Oct 2026 13:11:21 +0300
Message-ID: <20261001101121.1451706-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cyclictest and cyclicdeadline always exit 0 even when the latency
threshold set by --breaktrace is exceeded, requiring test harnesses
to parse output or json to detect a failed test.

Set ret to 2 when break_thread_id is set, indicating the breaktrace
threshold was hit.  The exit code enables shell expressions like
"cyclictest ... && echo PASS" and seamless integration with testing
frameworks.  Also pass ret to rt_write_json() in cyclicdeadline so the
JSON output reflects the failure.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
v4:
- Address comments of John and Sebastian
- Fix cyclictest json and title
v3:
- return 2 on failure
- reword error descriptions in manpages
v2:
- refine subject
- "Assisted-by" already conforms format AGENT_NAME:MODEL_VERSION
- add sob
---
 src/cyclictest/cyclictest.8         | 11 +++++++++++
 src/cyclictest/cyclictest.c         |  6 +++---
 src/sched_deadline/cyclicdeadline.8 | 11 +++++++++++
 src/sched_deadline/cyclicdeadline.c |  7 +++++--
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index fc6121aa4d47..c52e09cbd73c 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -311,6 +311,17 @@ in mind, below cyclictest example invocation can provide a good start:
    --histfile=output.txt
 .fi
 .
+.SH "Exit status"
+.TP
+.B 0
+Success - breaktrace latency was not exceeded.
+.TP
+.B 1
+Error or invalid argument.
+.TP
+.B 2
+Test failure - breaktrace latency is exceeded.
+.
 .SH "See also"
 .MR numa 3 ,
 .MR numactl 8 ,
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 58b56bcede0f..a541f4c66369 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2325,9 +2325,6 @@ int main(int argc, char **argv)
 	if (!verbose && !quiet && refresh_on_max)
 		printf("\033[%dB", num_threads + 2);
 
-	if (strlen(jsonfile) != 0)
-		rt_write_json(jsonfile, ret, write_stats, NULL);
-
 	if (quiet)
 		quiet = 2;
 	for (i = 0; i < num_threads; i++) {
@@ -2353,9 +2350,12 @@ int main(int argc, char **argv)
 		if (break_thread_id) {
 			printf("# Break thread: %d\n", break_thread_id);
 			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
+			ret = 2;
 		}
 	}
 
+	if (strlen(jsonfile) != 0)
+		rt_write_json(jsonfile, ret, write_stats, NULL);
 
 	for (i=0; i < num_threads; i++) {
 		if (!statistics[i])
diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
index bfc6327c51da..39b5d422a452 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -58,6 +58,17 @@ Send break trace command when latency > USEC
 .B \-\-tracemark
 write a trace mark when \-b latency is exceeded.
 .br
+.SH "Exit status"
+.TP
+.B 0
+Success - breaktrace latency was not exceeded.
+.TP
+.B 1
+Error or invalid argument.
+.TP
+.B 2
+Test failure - breaktrace latency is exceeded.
+.
 .SH AUTHOR
 cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
 .PP
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index ff3356a9be3e..61caacfde832 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1314,10 +1314,13 @@ int main(int argc, char **argv)
 
 	loop(sched_data, nr_threads);
 
+	ret = EXIT_SUCCESS;
+
 	if (tracelimit) {
 		if (break_thread_id) {
 			printf("# Break thread: %d\n", break_thread_id);
 			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
+			ret = 2;
 		}
 	}
 
@@ -1333,7 +1336,7 @@ int main(int argc, char **argv)
 	}
 
 	if (strlen(jsonfile) != 0)
-		rt_write_json(jsonfile, 0, write_stats, sched_data);
+		rt_write_json(jsonfile, ret, write_stats, sched_data);
 
 	if (setcpu_buf)
 		free(setcpu_buf);
@@ -1343,5 +1346,5 @@ int main(int argc, char **argv)
 		fclose(histfile);
 	hset_destroy(&hset);
 
-	return 0;
+	return ret;
 }
-- 
2.55.0

