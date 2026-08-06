Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26925B09E
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Aug 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018095; cv=none; b=T4xcpCqKeClaRAjSYIcKSo0asg+YT5nNGvYNEzV/SZjvMNJrhJEOdnjZcMVCAfZF6BrKhh4S5v3fi0YBA7Tw10lVuT0sNtj9PyauIPL9ODJjbBewys155qFqBiBmDqKjiCDtz/BkLLGNwBoJcunlRFLDtqeMtgVQAe72688PmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018095; c=relaxed/simple;
	bh=WCFrs/egX5b+T8wUWPNJpqW20kbMtmIobOzSH3ziEP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcOLA0ohzBkiZztLPnBX5n4E1BwLRvgb/pCZYdImUo6nc9ywEnSrkHjBasYKqkA18fv53n2ntKI9K0lS+z8Nf+lUHjv/0nRiy4tPZjqP7qL3uSFepLFZS/c0TTZP5rmlsIT+Ru7pwfLWtbq3k4Cez7RISLuMW/l9+r9IHffu9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvcPRLMv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqMP0Nkz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvcPRLMv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqMP0Nkz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786018092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jtnPw2G1fad0xVsjxqYYtEnlbYWYBvTHHqddUFJseIg=;
	b=CvcPRLMvm4+Z0CplHfsPtEbUjU70vnk4nDmC4cIdNu0/iK9lUt2llx4Yw9tjZH7rfehozA
	d1a6dw5OihfbmbEOLIYSUWh9UmDBSzNqavYPRv72vXtY3t9l1hRn9ka6JJm1yXyCOS1Fak
	A4qReiLpHkEwSQjBw+Ss4zZ4Ugo9dsY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-k6-qpL4NOGWQuB-XdCbTVA-1; Thu, 06 Aug 2026 08:08:11 -0400
X-MC-Unique: k6-qpL4NOGWQuB-XdCbTVA-1
X-Mimecast-MFC-AGG-ID: k6-qpL4NOGWQuB-XdCbTVA_1786018090
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955b84e25eso12389345e9.1
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Aug 2026 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786018090; x=1786622890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jtnPw2G1fad0xVsjxqYYtEnlbYWYBvTHHqddUFJseIg=;
        b=WqMP0NkzEYLdlD4IR5matti8qU3gqMZi7HUJr0dfCNPfnAqzoJj9oGs35OtT4pE5im
         lrHXSqgc7QREtlzuE9NU2Ru6g37USBErz7dtM1PTNrXtchGSHTfYfwBPiypMevTx7LK8
         vSACbT2n17yGBolh7PCgMruksYcQGMO8InjJ0tV7EOpZhzYq229eMTiNEl5JIoHQ4CvP
         7QDILEJv7RJjHITybhVlaxqF7cG3V57LpP5W2POSGJ0ilyEXC6Owp0tvrCxbQDa+BPQ2
         cqu+W0sHqomFpa/a7jNVoTa2zDRvhwbC2uEBnvT6uNcdIZrM5gTQhe6G4qeVUNPTsDC1
         EHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786018090; x=1786622890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jtnPw2G1fad0xVsjxqYYtEnlbYWYBvTHHqddUFJseIg=;
        b=N+itHy7TL92d/UKsD58rgZaZ5Vw9we8VIVytNZCDRJz7c82814euhHa2NYPGMVBmxg
         VmT3QY43Ic//MddRkti6rs1Se7V99vv99R9uipLn2bcNtpXhs9po2XDYLWhTBA4RMm9d
         HoXiaafrEWKqpVeEPxgG5gskg5pRk+jkz9sZl5M9Mr0Lpdau5Bes15aQBqkyiAZ4Rivk
         9HP66C2FMzjd83AbOgVBNI4rNKepSfzKTSNR2ZLsK2Qp7qkvqwCnG+uY89IGzPmAlgkb
         nX37bdA+ZtLc/7KYDF875ddnT41x4SdjPTVFaQ7AN6Rxz5rBnDEvBtuWlIGdNCtAZQGa
         +ZhA==
X-Gm-Message-State: AOJu0Yz8Fe/ESsrOYEfNRf/BGgyXqD+uLwvBiDO56M3LxzbaZ3BwI80P
	PHp5e+lqSUDWLAmgjPKmsA0zpb5pNKeNaHJ6csSdefUEZrHaw1sGNGcqkY3Rr7w9YZPWFU7iMZU
	2HKHd69L2E9CiQYKsz4WgoPJLMDO+SfWgzszrDrYepKKmYkC5KEvtS2MvSU3B495ewuGO
X-Gm-Gg: AR+sD12meDHHgUVjXPIfNYT686+nVGsgBe0YwMtdYVQskINc1tNLTYbWpHvbLeJyywy
	qQTpHIfH1eoWSKT1l4EDMFZNO4/+Fxoi5WLcPcU0A1D5s3NvrBt0lJrLSK3Uui2DRVl9efqiiDE
	sISsXF+oja0uSj4kHLG6k7sndFhjTe45qnyisperkysRth5igw2DkEC9iqJ9pWhliEugYRJ33rq
	bNCsjFnJDqBwqQCkgn5DqSaNU35084Mig0CHOHuBXytDEQA74RF8HRgCblHLNOYFV6KQNEbTIVh
	g46kpBz9enW0GHD4Y0jBGhz1qZHQXZqrqHdpGekM/HkAMN13NzGIFlQruo2KeWYY0Brt/p0H0qA
	X2x+krbs5q6Aa+w==
X-Received: by 2002:a05:600c:1d1f:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-4994e71d2acmr184431885e9.5.1786018089900;
        Thu, 06 Aug 2026 05:08:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1d1f:b0:496:c9cd:e7ab with SMTP id 5b1f17b1804b1-4994e71d2acmr184431125e9.5.1786018089413;
        Thu, 06 Aug 2026 05:08:09 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995421b198sm68272195e9.7.2026.08.06.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:08:08 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh=20=28Schneider=20Electric=29?= <thomas.weissschuh@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH v2] cyclictest, cyclicdeadline: Exit with failure when breaktrace threshold is exceeded
Date: Thu,  6 Aug 2026 15:07:31 +0300
Message-ID: <20260806120732.1371118-1-costa.shul@redhat.com>
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

Set ret to EXIT_FAILURE when break_thread_id is set, indicating the
breaktrace threshold was hit.  The exit code enables shell expressions
like "cyclictest ... && echo PASS" and seamless integration with testing
frameworks.  Also pass ret to rt_write_json() in cyclicdeadline so the
JSON output reflects the failure.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
v2:
- refine subject
- "Assisted-by" already conforms format AGENT_NAME:MODEL_VERSION
- add sob
---
 src/cyclictest/cyclictest.8         | 8 ++++++++
 src/cyclictest/cyclictest.c         | 1 +
 src/sched_deadline/cyclicdeadline.8 | 8 ++++++++
 src/sched_deadline/cyclicdeadline.c | 7 +++++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index fc6121aa4d47..813c61653f61 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -311,6 +311,14 @@ in mind, below cyclictest example invocation can provide a good start:
    --histfile=output.txt
 .fi
 .
+.SH "Exit status"
+.TP
+.B 0
+Success - all latencies were within the breaktrace threshold, or no threshold was set.
+.TP
+.B 1
+Failure - a latency exceeding the breaktrace threshold was detected.
+.
 .SH "See also"
 .MR numa 3 ,
 .MR numactl 8 ,
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 71cf5cb25c22..88fc08347cba 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2337,6 +2337,7 @@ int main(int argc, char **argv)
 		if (break_thread_id) {
 			printf("# Break thread: %d\n", break_thread_id);
 			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
+			ret = EXIT_FAILURE;
 		}
 	}
 
diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
index bfc6327c51da..cd7088629d97 100644
--- a/src/sched_deadline/cyclicdeadline.8
+++ b/src/sched_deadline/cyclicdeadline.8
@@ -58,6 +58,14 @@ Send break trace command when latency > USEC
 .B \-\-tracemark
 write a trace mark when \-b latency is exceeded.
 .br
+.SH "Exit status"
+.TP
+.B 0
+Success - all latencies were within the breaktrace threshold, or no threshold was set.
+.TP
+.B 1
+Failure - a latency exceeding the breaktrace threshold was detected.
+.
 .SH AUTHOR
 cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
 .PP
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 0c6c96976010..1123de4f4cae 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1315,10 +1315,13 @@ int main(int argc, char **argv)
 
 	loop(sched_data, nr_threads);
 
+	ret = EXIT_SUCCESS;
+
 	if (tracelimit) {
 		if (break_thread_id) {
 			printf("# Break thread: %d\n", break_thread_id);
 			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
+			ret = EXIT_FAILURE;
 		}
 	}
 
@@ -1334,7 +1337,7 @@ int main(int argc, char **argv)
 	}
 
 	if (strlen(jsonfile) != 0)
-		rt_write_json(jsonfile, 0, write_stats, sched_data);
+		rt_write_json(jsonfile, ret, write_stats, sched_data);
 
 	if (setcpu_buf)
 		free(setcpu_buf);
@@ -1344,5 +1347,5 @@ int main(int argc, char **argv)
 		fclose(histfile);
 	hset_destroy(&hset);
 
-	return 0;
+	return ret;
 }
-- 
2.55.0

