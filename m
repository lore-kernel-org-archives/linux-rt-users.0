Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A5C21A95D
	for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2026 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179773; cv=none; b=rqddhxEXb/iug6yTPCryMcCp8C1wAm33Ix2Vs7PlkO8sMvjQad9oISYlx/26X7/wENplJqpml/Fu+juDIB2bDTlShEBoQGLkAdUm7M1ACQ0mrhtU7n3lu+clHapgxtNDJ8cgJyced06VJumtyEYmr0ytFZA5Jqhx8dLIsVY2n6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179773; c=relaxed/simple;
	bh=7C8ElNzahPJsigIlK8eko85wKrct2q8DYBf3uUY9Ms0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNd/jVUZ4bKagoCT4qIxXTAkWlEPiSBekrZZbqCYnNi5hyEm9gHaqLlL2HbvzVlabXdSohpfmwr2BcM/EwBZIE517ZFQ8wtmOKI5E0jF1DjnConsRro2N4NS3oYN01iV2wkrrvA82wpcs36AdCYm4Kcj7GCjIHWGlhVXD4nAeMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6PHdfVx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrEEnIKx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6PHdfVx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrEEnIKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785179771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FlySrKacyu1mGpErJOKweo3GX4pJbqWBE/G85xv/3Gw=;
	b=i6PHdfVxjU9J6tZNg4EbY33AmjkniAK8E87YAJhDHA87z4U47VeK5HX/jrfnmF6/XBawk9
	RFhTVhIjyucpPam/M5GZkLSFckYFDqb1jPD1LPpDZlrzb3Br1cYfMg29MMZ8X/9N2ee6dh
	8fxhZfmXNbcxmo8udEDET8E5r2Th4nM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-f17yJidhMTGqBojV2KWEag-1; Mon, 27 Jul 2026 15:16:09 -0400
X-MC-Unique: f17yJidhMTGqBojV2KWEag-1
X-Mimecast-MFC-AGG-ID: f17yJidhMTGqBojV2KWEag_1785179768
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4955ce558d8so28935245e9.3
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jul 2026 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785179768; x=1785784568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FlySrKacyu1mGpErJOKweo3GX4pJbqWBE/G85xv/3Gw=;
        b=RrEEnIKxAyd9FvD4hMQH1KQ0QGR7glL2lnaSSdx+ijhLHAVS+0xH30D37XSW8I9C3z
         uk1ZIF02fLgSCV81DX1fO3bweAlMElm36+rs24/iy7NzCaBtsx5mzaEqIWL9jLybXT6g
         hQ/oGWgfqs8N8lJagQENqR8mi5J2Mq8gh0rY5is034bnb1WQ8unU9wFg3mVGYEmIN501
         C6ElKdfd9Kn2jtYxc42D7lBXJYSCv4fZw2DYPCg/fXiQzHgHxjVHhdL03SrumfzSnNKW
         XAjdLL6RhEaiIKyI9sUhW9inDIHVVpaVw7gkrLn9qlV9UFciW15fs1SyZqMBgkTAr+OS
         Twgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785179768; x=1785784568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FlySrKacyu1mGpErJOKweo3GX4pJbqWBE/G85xv/3Gw=;
        b=YWU2tDtsXIkMmhrtyeYHJ+8P9m+EA5/rtrZCGnGAQYoVkLpZFbZ8jnDncMT6jLurYF
         snVlboLFGTLYrZL4OUMm+UMrhftSuaPyLc0AElcs6/lU+Im4ocI44dJW/RgMIUPvUBg/
         A33D00SCmXaEnUT+GQW7PNjiTJVD+GgnT6wQP/d9nDgAgbUIhjxrGjdY6pOM6WmVLota
         q76zTT4xOFhFAhUf4Fx/GYnXH2U8QmNkg5AFLq/9ZDF5byabX20XVYNN36HBeTh0fHHF
         dyM/YqtaSsF4HS76CysNjublGmuZSieEmB2k/hyFVUCdYUlTaJaaYzwoEli3RXEdwNrk
         ImHQ==
X-Gm-Message-State: AOJu0YyraD+HdBkqL34OLT1KwWaT508JItSm3h9GbU20USizmBpCTTP1
	vxBON4hv0do68ZzCxuU7a94e17OK/xahf6uYT6fqJInXkSyHyrCPpVPPfkGOMU67CQufvD4NQQf
	0MMU8VXTjL4329UXWaVxE+zqnldMCYRTQ0E1ZMvy5vVLhTup5EurjYMkuWYlpGPbj+7qH
X-Gm-Gg: AR+sD11DjoPRb1gsrvYPkRY6emKeZgfq88bPcb8DZ7iyP+X+vsZP3GdnPfrWAgb2N48
	gpzKgkpn9PC7rITDtlz8QUIz3C+g8p+qtllzgI5IxtuWylSyUxKqqQaecSA42rj/PLjdvZypIzr
	Nz3hdaPTlkni22H7Z8MyNH0TyF2zJJYUS+Em7LxQ2wzCSoDU+4xzfH3UXfD4jhcGCH1ycGGbPGX
	uYAD1unsRs1vXIJZKMIcb/qtkttAILhBptiC07yFiVVepvn+TJhP1nTTBE8i5p7Kf31rvYnqWCq
	048vI8mbvrqbRIw9eRJr215Xag2vTtoG8GYZS1a235zMGf4q88tUWiyM18FlAmPigE4YC9uIKRl
	b+iaNU7Aam1q2NMR5
X-Received: by 2002:a05:600c:3b22:b0:496:c3b1:2a91 with SMTP id 5b1f17b1804b1-496c3b12b4dmr24049925e9.27.1785179768226;
        Mon, 27 Jul 2026 12:16:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3b22:b0:496:c3b1:2a91 with SMTP id 5b1f17b1804b1-496c3b12b4dmr24049625e9.27.1785179767790;
        Mon, 27 Jul 2026 12:16:07 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9b8b67sm295414085e9.4.2026.07.27.12.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:16:05 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh=20=28Schneider=20Electric=29?= <thomas.weissschuh@linutronix.de>,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH v1] rt-tests: Exit with failure when breaktrace threshold is exceeded
Date: Mon, 27 Jul 2026 22:15:45 +0300
Message-ID: <20260727191545.3023834-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.54.0
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
2.54.0

