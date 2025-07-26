Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AC7B3E1
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753521530; cv=none; b=lp5t+1kgeWds7nISdNq8VRF7KLJAeQjjTeH35/sCRW7H6MNm1b+pO75fBxFTWsPaU0yXT+nHV5NxdZsO1Upx3PmB8SBPZ+tchv+Y4aax/yTFqCOC5RFISmSigmT2syH8TdwbtSwKTWP1kLaGuoZ6oxso9gNpKFlyK6uN0tJOd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753521530; c=relaxed/simple;
	bh=W8yt687cd1lQJaq+Js8PxmaqBZ7jcvWzNqJYRSDj3oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9UmTulMqo0RgHt6gW30zsUlzZTOuJJRIdFSjFaw3jfw7VQ0nkKvU9tNO9BL59y+/2b9PfL7JrmWR6cB71IyDNTNZbjxnFYHdtsePolpKexnWLS92nSOYVxI4wbUGh7Ei/tO6373+3+GkzfIJXaM6jS/jpbH/3tL/NCbuQzdK/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLfTQMHH; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLfTQMHH"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b1fd59851baso2138100a12.0
        for <linux-rt-users@vger.kernel.org>; Sat, 26 Jul 2025 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753521528; x=1754126328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ln3K2CQhhkBg66Lza5ni3Kp2E+wFjjRLYaj7M6YTwFo=;
        b=mLfTQMHHRaI54MMdOm2dzdPelgrbbTd0ANYpOoXW8PD1Xq2qD7IILuqYFKUaUEx2Ow
         O74si0bQYIYDaYY7wPvTFE89ACW+rFVdTK402dOueqc89QRbWYtwQx3zmQ4Evf4tqVUA
         WbeKXu4ndp39D9htfvJB2s3VZ8EPb/O0WDb6y/5XJ+w8HdJWsHSuCTHq6WXI7+tn6xRl
         47SwT5AkUt6omLwWDzxlO8I3wey37h9HjM139mYI9tKz5/FlpaEkfnknuEghBThXf7HN
         tg0KqJM9xWMMX6Vt5i9RESM6vo6yuJIGDu7Vd/Dh/WHBQsGrBTfuQjvnZhMgL7kRX5RB
         dBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753521528; x=1754126328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln3K2CQhhkBg66Lza5ni3Kp2E+wFjjRLYaj7M6YTwFo=;
        b=VUCqScZvHNGlpwwcj6jzEdDDU5XpF9UUle6xEJOIxhv1AhuIrQAVM9WKEnxtTqBaEY
         y6FH/2lc7GEXO18Eag8XDPsWosl4HzQw/KimBeRI+6IshL5kCw/66o1v8xSWVcGnF4tq
         L5GnVrlPGVjnktOeMOu1wJzF3BoTfuLkt4qTAJSlAo+bqyUaBLGao+ezWwKxOsBiT93t
         P+SzNIvBQwbzMbghKRjphT8rPTIiE19YAjwGY9+uzkxNwZuuD/PZrG7rwOjB0SxvrAJR
         r8U1AVmBB3HqlNjbNB77HjCt1koTvDcVailYn7zN8HvoY7j+rMMRB99etU0fA0THwk4y
         tBLQ==
X-Gm-Message-State: AOJu0Yz7BhuP596SHSO6Cmc9FgY1IqUi/LhdvebU/NyRacey4aO1b+kp
	JaUk6PoJ/qS5iNprTnlciYWiIbfWztiDkbHghNpg0kjubfyydxATFjbiIFfLqWdB
X-Gm-Gg: ASbGncvKjvwh+g73VN6iDa/oiRhmHpD3hnQnTwJeeuMdhxGFyW9l9G39LUubyS2xTaz
	0ojROQ0vuWFaIB04wycL7D9LuguTW8Gpai096p9QPlqYeNbPsBGARcKQLIUspN/RFYOPXwwDsCx
	U31m0FwWA49SisJicmarxCzcBqQANnr7/CdY7KAoLP4k8bo/z/ZkBlym4gk6gjx/nIh3PYZSSiX
	/z0phkGTFqGLf6qQAOhlnwghNGqN+GKpyLz8wxh4cEaSBpi6WqWMUapewV9uDL/hfe0AIUNpBAa
	otFaAAbvSCG3y+cNiI2rIQlHREO9T9LAeLQrrtUlplklojevi1qVAbiJABq6qNAOhK4+qN4hzSI
	ES3MgO5GdndMRF+KEfpBKV48ehnqtNXpRs30BSM989md3gB+J7fks
X-Google-Smtp-Source: AGHT+IG7FeiCsel8wsYYEsO9RIAjIDZ6ZvPeMDBbu/d9pO1KWVfwpmd4IP31erEuhIiaxpWLIsOKIg==
X-Received: by 2002:a05:6a21:99aa:b0:232:ac34:70ec with SMTP id adf61e73a8af0-23d6ffe455amr8467618637.7.1753521527778;
        Sat, 26 Jul 2025 02:18:47 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:3fec:e266:6de8:8b66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f569d24sm1295025a12.1.2025.07.26.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:18:47 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: williams@redhat.com,
	jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v2 3/8] ptsematest.c: Check return values of write() and ftruncate()
Date: Sat, 26 Jul 2025 17:18:32 +0800
Message-ID: <20250726091837.493915-4-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726091837.493915-1-yphbchou0911@gmail.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error handling for write() to tracefs and ftruncate() on shared memory
to avoid ignoring errors.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 src/ptsematest/ptsematest.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index d211669..787909c 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -62,6 +62,7 @@ void *semathread(void *param)
 	cpu_set_t mask;
 	int policy = SCHED_FIFO;
 	struct sched_param schedp;
+	int ret;
 
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->priority;
@@ -112,7 +113,10 @@ void *semathread(void *param)
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
-					write(tracing_enabled, "0", 1);
+					ret = write(tracing_enabled, "0", 1);
+					if (ret < 0)
+						fatal("Could not write to %s: %s\n",
+						      tracing_enabled_file, strerror(errno));
 					close(tracing_enabled);
 				} else
 					fatal("Could not access %s\n",
-- 
2.48.1

