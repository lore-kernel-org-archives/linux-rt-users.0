Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4E938FAB
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T70Tbn22"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2C7BF
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:40 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a507c72d3eso30037527b3.3
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617699; x=1697222499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqyTTd97H+4ZVsbSNfmoT1XhsjWzRAMMXo7IEVpQ34Q=;
        b=T70Tbn22hoRBf2rCVpqSFhLBXUMQ0fVZcaNoV3CK1GZn8MalUIusxlJdabbf8+as67
         21loj7d0Pw5GmzbqnBobt6f8NotdrzVCdy/v+Ns/KLK6cjrmjh+JFwdzJAhqr4j42X0m
         w2iCf0TpL8Uv6rV8+m5y62uNdanYKQfigIWQTwjR3GthnxVxAlQQ+5aUTbBOy++5xmby
         MY1Y0PRxeMs9fD9L1RuqWXlR3mLQVb6/qUGkwTzYxy7a5blwqK4s8GpQsTeJ52YfZAkt
         uW71rJB4GgGFsgR6vaza4DLYYib8ELaWIhLJ34d1AnI+Yx5Ha+cbNHzIH78ikswGXWWV
         2NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617699; x=1697222499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kqyTTd97H+4ZVsbSNfmoT1XhsjWzRAMMXo7IEVpQ34Q=;
        b=LysscLWcKHdHVm0EBKF6U8+pgcNbYUwg67+a+oNsRAEPjuMcpUDGzjx8wiQo9CweEb
         fzwqN2hOB3GADZROeRCrnkD1OI4n3OlI54b9XbOT0hpHgZo9ESlwstP1b6ahnwpm09b6
         TeZTzUJ1q8/YV+Q4RZLLtzghBsqCc9OPbzKfcCLzihTcSnZZLqQT3P2+q4ukxvYotBEr
         hQd0g1T6xhUv39eQBf6bkoIOX/0z/Le3WazPGuIQKoNL/SUnD7lYXs6bITTx07oEbsAS
         E+qFRATI+X8A8y3MSwY/7ca4JLOsPIXUtJJi9Ti8jV/EWGLjC+FL/rqef7/0srpb/OhS
         Mc8g==
X-Gm-Message-State: AOJu0YxYnpiGTe6bW+i5dff1W+JxjLBb00q5cJJT9n8UiN1dvHD68EDk
	e4v7yrWlsIQ50ZmKdGbiXFRmHb71kgY=
X-Google-Smtp-Source: AGHT+IEcPJodTunx6ehM5+dBAWlj2unrFJ+nf23EaTkDbVEsXNnbMleJjYQJFtPKCGI4WP2UeMAuTg==
X-Received: by 2002:a25:8e06:0:b0:d44:af:3cce with SMTP id p6-20020a258e06000000b00d4400af3ccemr9027036ybl.27.1696617699238;
        Fri, 06 Oct 2023 11:41:39 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:38 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 17/17] rt-tests: ptsematest: Fix unused paramter warnings
Date: Fri,  6 Oct 2023 14:40:11 -0400
Message-Id: <20231006184011.26699-17-jkacur@redhat.com>
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

Fix unused paramter warnings

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ptsematest/ptsematest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index a9d6c69b6449..5a29718d7bfb 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -321,13 +321,14 @@ static void process_options(int argc, char *argv[])
 
 static int volatile shutdown;
 
-static void sighand(int sig)
+static void sighand(int sig __attribute__ ((unused)))
 {
 	shutdown = 1;
 }
 
-static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
-		       int verbose, int quiet)
+static void print_stat(FILE *fp __attribute__ ((unused)),
+		       struct params *receiver, struct params *sender,
+		       int verbose __attribute__ ((unused)), int quiet)
 {
 	int i;
 
@@ -359,7 +360,7 @@ static void write_stats(FILE *f, void *data)
 {
 	struct params_stats *ps = data;
 	struct params *s, *r;
-	unsigned int i;
+	int i;
 
 	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
 	fprintf(f, "  \"thread\": {\n");
-- 
2.40.1

