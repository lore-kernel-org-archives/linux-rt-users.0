Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D62E5B13
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Oct 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433186; cv=none; b=M9/06ewY9e7uf1y8g0s/ofurcUFIWKSlHf1P8KtMPJkBgLlj9xW1RP1iq9+fUyU8dmAR0Q1tmOCxryWgpRYAngWCbeKSMVIp2vDYRfQgHK3jNzEiWf1+XrUvFimVl7V8M5fILjhC4pyVfJN9qiQ9gMykYrgqRLkGwGsT8vq22HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433186; c=relaxed/simple;
	bh=2GMeLBPGgN3hhwbx6ao+5bfbDBReaU4m9n4U35UHEGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peA5pfgG7BG37ZEmmZSdnUZ93AB42DqCh/IliVf427bXcIHKILJtiwJNH/jQs7v40ghlXBfBPmnF8xS9IWXfClCwmBRLEtVxNN0OL602a8FabXax4tery4vPtFefu2sGaqKgj9QRB1FuvcZ+ga1NzHobRpK9oM1mouNnjb7cfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5LXn9d6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5LXn9d6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SWmajmFFIoCVW5d9h3pTDg0yorgXtdqoP+I+UCPmMfY=;
	b=E5LXn9d62mHsHuom9usOiEWlp/fn3lp0EyJKmqqAkccQQWAl++41ZBjmaAI9b37KhTq6ab
	xDrsU+2zkkC94k6qyqOF3xU45wyl5okaUIA1CREGVr+7cGPakbvsPhMmnTVDIfBhqsMX1m
	tIz3H9jZFDy0qwZedVtMwGn/eJxKbvY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-R3OGNOUJP0iwvrjFLuMqdA-1; Tue, 14 Oct 2025 05:13:01 -0400
X-MC-Unique: R3OGNOUJP0iwvrjFLuMqdA-1
X-Mimecast-MFC-AGG-ID: R3OGNOUJP0iwvrjFLuMqdA_1760433181
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee1365964cso5066815f8f.2
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Oct 2025 02:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433181; x=1761037981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWmajmFFIoCVW5d9h3pTDg0yorgXtdqoP+I+UCPmMfY=;
        b=VhvaFKGJnWm191LDIuFbZknDhxUNg8S+gTs6lr+scYOXuif2K61yQSO5H0DduqYD/Q
         +UmFCmAG0mkKpy3vaEebE46X5HNIDCUj22nhqU9j/8qqP34k+Vdsdvb49+2h2JbmkcxE
         QHO9wlH9ix/2rb/ipegNgSQ2Ays4v86uj106IkrLOdxEPff0/Xia8BHticdAfA2qJ+20
         aqNqnF2glFQtayH64uu9VCoKeVbqiRAEX503affvLiFUJTNImHSUyZbO1p9MKfRnTp9/
         07PXcqgg25s5C7urcFnaO+IcWRCurGd2Xc/hWhEI5Lb7D9iyvFCmbMH1FZoJy/0R0SEI
         yBjw==
X-Forwarded-Encrypted: i=1; AJvYcCVS7ZDM/cYH8rXRVwl/YAtOgHKz9eN95UlD8Iq4D02jmAROm+oV6McKfa2aNtyV33RUaf5yEtiwL4TBNul+XA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJwJMzVbRt/rXJ+PV8YgLB6mkpOmempWha9NraHBypWeZUARlb
	gnZ64c4RtP94s+cxGK647o1P1YUcwQg+UDwbaA+w9NdEBHZKjEhAZBgdKf6MkN1dKw+kdI6saW0
	PLDD7dKMq0+REgAFQ9h5YXDf5XVH615qFq99ctOTvkQTUrF5RAJcFejtKd5h1JwbDduIi
X-Gm-Gg: ASbGncunyILlcDgQQQkcQ+WQzML+LnwSUsrR1EOw6k+GDvnTNowmACXouEeMBMtE6jA
	IDFbE585HCuQkh4hjekOCviDsXvJIoGC7+3PymTGP+OLCQbp1iiTWcmO0BOsMX2IUEvjCNAmNq/
	GbWSn4FcatjhdreO0IueYRRpqysK0pqjk/uSNQwqLBDvQzk85+9zIT8SxjFDcTq2iY8twQiRraV
	TDuNQnxQiI8tyeCKZcmX0wWa+dGKuNR5QcpbQYWOSb0U7+T3N8d9x1JrmzUY8BwZVjTYE2hq7PI
	DpZTvoIQZIqpz0Qfl39gMx5H9ugDtIvmrPChbkkekzUSKLHYTOOAxBHR0w==
X-Received: by 2002:a05:6000:60a:b0:426:d516:4e9d with SMTP id ffacd0b85a97d-426d5165022mr6480147f8f.32.1760433180593;
        Tue, 14 Oct 2025 02:13:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETi42NWwQHJKuJ2aImH9TVAU9fF3BSZEa19UdNEH1yEDVwS+KHN6Jxh8S4/zFGuiGNhennjw==
X-Received: by 2002:a05:6000:60a:b0:426:d516:4e9d with SMTP id ffacd0b85a97d-426d5165022mr6480133f8f.32.1760433180104;
        Tue, 14 Oct 2025 02:13:00 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d404sm22823697f8f.3.2025.10.14.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:12:59 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH v1] rt-tests: cyclictest: Extract check_and_report_clock_resolution() from main()
Date: Tue, 14 Oct 2025 12:12:40 +0300
Message-ID: <20251014091240.139307-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cyclictest absorbed a lot of development debt over the long history.

The longest function is main() with length 453:

lizard --warnings_only --length 320 --CCN 100 cyclictest.c
cyclictest.c:1095: warning: process_options has 312 NLOC, 140 CCN, 1824 token, 2 PARAM, 346 length, 0 ND
cyclictest.c:1910: warning: main has 342 NLOC, 107 CCN, 2187 token, 2 PARAM, 453 length, 0 ND

Extract check_and_report_clock_resolution() from main().  Locate the
function between check_timer() and sighand() because they are used in
the same order.  After the change the length of main() became 365
instead of 453:

lizard --warnings_only --length 320 --CCN 100 cyclictest.c
cyclictest.c:1189: warning: process_options has 312 NLOC, 140 CCN, 1824 token, 2 PARAM, 346 length, 0 ND
cyclictest.c:2004: warning: main has 287 NLOC, 94 CCN, 1826 token, 2 PARAM, 365 length, 0 ND

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 src/cyclictest/cyclictest.c | 179 ++++++++++++++++++------------------
 1 file changed, 89 insertions(+), 90 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b4bce8915b43..34dbf3e2b72d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1449,6 +1449,93 @@ static int check_timer(void)
 	return (ts.tv_sec != 0 || ts.tv_nsec != 1);
 }
 
+static void check_and_report_clock_resolution()
+{
+	int clock;
+	uint64_t diff;
+	int k;
+	uint64_t min_non_zero_diff = UINT64_MAX;
+	struct timespec now;
+	struct timespec prev;
+	uint64_t reported_resolution = UINT64_MAX;
+	struct timespec res;
+	struct timespec *time;
+	int times;
+
+	clock = clocksources[clocksel];
+
+	if (clock_getres(clock, &res))
+		warn("clock_getres failed");
+	else
+		reported_resolution = (NSEC_PER_SEC * res.tv_sec) + res.tv_nsec;
+
+	/*
+	 * Calculate how many calls to clock_gettime are needed.
+	 * Then call it that many times.
+	 * Goal is to collect timestamps for ~ 0.001 sec.
+	 * This will reliably capture resolution <= 500 usec.
+	 */
+	times = 1000;
+	clock_gettime(clock, &prev);
+	for (k = 0; k < times; k++)
+		clock_gettime(clock, &now);
+
+	diff = calcdiff_ns(now, prev);
+	if (diff == 0) {
+		/*
+		 * No clock rollover occurred.
+		 * Use the default value for times.
+		 */
+		times = -1;
+	} else {
+		int call_time;
+		call_time = diff / times;         /* duration 1 call */
+		times = NSEC_PER_SEC / call_time; /* calls per second */
+		times /= 1000;                    /* calls per msec */
+		if (times < 1000)
+			times = 1000;
+	}
+	/* sanity check */
+	if ((times <= 0) || (times > 100000))
+		times = 100000;
+
+	time = calloc(times, sizeof(*time));
+
+	for (k = 0; k < times; k++)
+		clock_gettime(clock, &time[k]);
+
+	info(ct_debug, "For %d consecutive calls to clock_gettime():\n", times);
+	info(ct_debug, "time, delta time (nsec)\n");
+
+	prev = time[0];
+	for (k = 1; k < times; k++) {
+		diff = calcdiff_ns(time[k], prev);
+		prev = time[k];
+
+		if (diff && (diff < min_non_zero_diff))
+			min_non_zero_diff = diff;
+
+		info(ct_debug, "%ld.%06ld  %5llu\n",
+				time[k].tv_sec, time[k].tv_nsec,
+				(unsigned long long)diff);
+	}
+
+	free(time);
+
+	if (verbose ||
+	    (min_non_zero_diff && (min_non_zero_diff > reported_resolution))) {
+		/*
+		 * Measured clock resolution includes the time to call
+		 * clock_gettime(), so it will be slightly larger than
+		 * actual resolution.
+		 */
+		warn("reported clock resolution: %llu nsec\n",
+		     (unsigned long long)reported_resolution);
+		warn("measured clock resolution approximately: %llu nsec\n",
+		     (unsigned long long)min_non_zero_diff);
+	}
+}
+
 static void sighand(int sig)
 {
 	if (sig == SIGUSR1) {
@@ -1981,96 +2068,8 @@ int main(int argc, char **argv)
 	if (check_timer())
 		warn("High resolution timers not available\n");
 
-	if (check_clock_resolution) {
-		int clock;
-		uint64_t diff;
-		int k;
-		uint64_t min_non_zero_diff = UINT64_MAX;
-		struct timespec now;
-		struct timespec prev;
-		uint64_t reported_resolution = UINT64_MAX;
-		struct timespec res;
-		struct timespec *time;
-		int times;
-
-		clock = clocksources[clocksel];
-
-		if (clock_getres(clock, &res))
-			warn("clock_getres failed");
-		else
-			reported_resolution = (NSEC_PER_SEC * res.tv_sec) + res.tv_nsec;
-
-
-		/*
-		 * Calculate how many calls to clock_gettime are needed.
-		 * Then call it that many times.
-		 * Goal is to collect timestamps for ~ 0.001 sec.
-		 * This will reliably capture resolution <= 500 usec.
-		 */
-		times = 1000;
-		clock_gettime(clock, &prev);
-		for (k=0; k < times; k++)
-			clock_gettime(clock, &now);
-
-		diff = calcdiff_ns(now, prev);
-		if (diff == 0) {
-			/*
-			 * No clock rollover occurred.
-			 * Use the default value for times.
-			 */
-			times = -1;
-		} else {
-			int call_time;
-			call_time = diff / times;         /* duration 1 call */
-			times = NSEC_PER_SEC / call_time; /* calls per second */
-			times /= 1000;                    /* calls per msec */
-			if (times < 1000)
-				times = 1000;
-		}
-		/* sanity check */
-		if ((times <= 0) || (times > 100000))
-			times = 100000;
-
-		time = calloc(times, sizeof(*time));
-
-		for (k=0; k < times; k++)
-			clock_gettime(clock, &time[k]);
-
-		info(ct_debug, "For %d consecutive calls to clock_gettime():\n", times);
-		info(ct_debug, "time, delta time (nsec)\n");
-
-		prev = time[0];
-		for (k=1; k < times; k++) {
-
-			diff = calcdiff_ns(time[k], prev);
-			prev = time[k];
-
-			if (diff && (diff < min_non_zero_diff))
-				min_non_zero_diff = diff;
-
-			info(ct_debug, "%ld.%06ld  %5llu\n",
-					time[k].tv_sec, time[k].tv_nsec,
-					(unsigned long long)diff);
-		}
-
-		free(time);
-
-
-		if (verbose ||
-		    (min_non_zero_diff && (min_non_zero_diff > reported_resolution))) {
-			/*
-			 * Measured clock resolution includes the time to call
-			 * clock_gettime(), so it will be slightly larger than
-			 * actual resolution.
-			 */
-			warn("reported clock resolution: %llu nsec\n",
-			     (unsigned long long)reported_resolution);
-			warn("measured clock resolution approximately: %llu nsec\n",
-			     (unsigned long long)min_non_zero_diff);
-		}
-
-	}
-
+	if (check_clock_resolution)
+		check_and_report_clock_resolution();
 
 	mode = use_nanosleep + use_system;
 
-- 
2.51.0

