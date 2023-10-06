Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4F38FA0
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrZRRods"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BEC2
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:31 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77428e40f71so153167585a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617690; x=1697222490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm3fLMicBeA8ArQnrDOrAt88qAd/Ud/EaM6GzE91cyc=;
        b=nrZRRods2mKr/260uPWuEgczpm848zx1CpqTWPuFx1gpV84r68fWk/WHBKtUbpNqny
         2Xq5wVx4l7KDudLlXOJAuxzucScXleQwb+5lXFezmKwNnLL6MCJbUcrtw/DBmi/YBSk6
         fKyjFE0FrUo0hrfWKL/FVNnpJNyo8eP8lkIiah+Ik9b9TolhruK2sABy7cnVI1lcqesp
         zZvm/b3MC11LA8xwkI9ZuO3w7bi8HgYPl3crezXblEIr1HNgYcxRJQxyA/7LR/+ZE0L8
         mim6s/zFVWYUkjV9uVSyextWFpBVpwPELjV/VsKJ3fa0mk17tej/cB9aWRipJwoRKjN9
         IhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617690; x=1697222490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jm3fLMicBeA8ArQnrDOrAt88qAd/Ud/EaM6GzE91cyc=;
        b=GK3DBmATZugjirayp/byegLe3GYK9ytzgfeac1xTX/HZzlFpUoLZBh/79gQL6FaPou
         Lq8zp8cRpCXPapI1xgPXrv+lMz7zNvgJkdU/8fMtql5cSq93a8EpKjmhzLPRvxd4fVvL
         UlA0PFUEhfYE3Ku0hr4DKEFJtgblyPx5ynVRJAzd/teOtfffJRbw9KbJYpQ7+w6ngS+m
         1wAHNiSc5d3hEQfW4luKxHhQu0J2MdtKqt5Ulgq+lBPHRtoLIywaNf5PSdQ2eRBP3VaD
         2Tn7WsrBjh3hB1Sg6TaJbo+v0DmHy+mcF918UpZUu43xHyw7Pddjj+vA1IU3ma8kx7AF
         lxxw==
X-Gm-Message-State: AOJu0YwjZCNK7aHUNxPZ30+DSTlGshp8kf8JQWke6St0ImS2BVuV5O7E
	vVifUaspgwiGtWyiq4ph8FuYOt1d1y0=
X-Google-Smtp-Source: AGHT+IHai0dNt+hVNqPbJUBwSv6NJGBYS1Sd1RA15skDJ9e8ZYHIhtaZzWI4WpctJuK5HGiFWs8fZg==
X-Received: by 2002:ad4:4aeb:0:b0:668:f33b:39a8 with SMTP id cp11-20020ad44aeb000000b00668f33b39a8mr8913595qvb.24.1696617690627;
        Fri, 06 Oct 2023 11:41:30 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:30 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 09/17] rt-tests: rt-migrate-test: Fix some warnings
Date: Fri,  6 Oct 2023 14:40:03 -0400
Message-Id: <20231006184011.26699-9-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184011.26699-1-jkacur@redhat.com>
References: <20231006184011.26699-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

- Use attribute unused where appropriate
- Change unsigned int to int for comparision

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 883e60e21bff..7b1917df12a3 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -44,7 +44,7 @@ static void setup_ftrace_marker(void)
 		"/debugfs/tracing/trace_marker",
 	};
 	int ret;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < (sizeof(files) / sizeof(char *)); i++) {
 		ret = stat(files[i], &st);
@@ -354,7 +354,7 @@ static void print_results(void)
 	}
 }
 
-static void write_stats(FILE *f, void *data)
+static void write_stats(FILE *f, void *data __attribute__ ((unused)))
 {
 	int i;
 	int t;
@@ -489,7 +489,7 @@ static int check_times(int l)
 	return 0;
 }
 
-static void stop_log(int sig)
+static void stop_log(int sig __attribute__ ((unused)))
 {
 	stop = 1;
 }
-- 
2.40.1

