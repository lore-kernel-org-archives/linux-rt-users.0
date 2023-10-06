Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC338F84
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGAra4wj"
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D2BE
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:29 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7740c8509c8so154094485a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617688; x=1697222488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/Ufdw32297h6lU8w1XqaDkLvYo/gsKtM03QV63U80E=;
        b=dGAra4wjtVqVx5luu29lUfFTJ3iNH2YLqo0PDbO5mGgn6qQBBnnkIeLuMFcXzPmVDU
         BBIe2SuqI0CzTetvkSIqlCv+FkAjXocj2RIdKoMAHqgajPOyBahqVDgIMDvdWTmR0ER1
         EAmQN9/4GHaq4QhdqeOgl5NXxBsyy7CRZY75WV12Apr7jJJYy21GsjlzfFUbg5nT5eB0
         TwVWfiyvOUuHxAjDept1hvTMxss+cBdLfzaFqMD2rfZU3Lkg1MwnYBau2Hem5G/nDfhF
         ESy+mL2h5E3LPt9SRjdMCHdqzAOmVmUit5OMltvN0g2vJb1leT7QKrXCyyd3L23Tebn1
         u1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617688; x=1697222488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/Ufdw32297h6lU8w1XqaDkLvYo/gsKtM03QV63U80E=;
        b=jl0MhKupgw/HWlCWbQDFDfcdb7QPU3ftJcoEoZgdB3Tjt0rX0MhZPL6sqooQ0K6SvP
         NU1FiujHfENCYSD9zQEZEYy3QkuDLsfVWngYJgcsiBbuCsebUyrlFYLYg/31w+vfzN9D
         CaLxOHVJ0IQZQyWx/xg7XhjkpgT8Sfe807pVASi4EVjNpvkVGfgSa6RrH2ETos20s9La
         q29kJl1vkf5Njy7iE3NqgVbwqpr3UBznKAICv2FSlI9mYSgoa7IXQDpuOBdUVPcq3m9Y
         60IJ8UI0+Az5jJzBn8I3aeQFl/Y1w2wofKZq8e14HtiU2MBNbp+BlNSZMq8df5d+KlFM
         pVbw==
X-Gm-Message-State: AOJu0YwDiXXzJuziQcvl01RQ777PYE8YYUU0uCL7EDfkLeXW6A4Hswgs
	YH2KHH++wmLFyyBq98m69PFiFRLKrLo=
X-Google-Smtp-Source: AGHT+IFD0sgbRHtlzclviXEYTgu/1liaPmfZwotsZ4OhryhNHNBaNaLZv4L6gePR9WYhy+SNLqbFIw==
X-Received: by 2002:a05:6214:4a4c:b0:658:24e2:f237 with SMTP id ph12-20020a0562144a4c00b0065824e2f237mr8614244qvb.31.1696617687844;
        Fri, 06 Oct 2023 11:41:27 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:27 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 06/17] rt-tests: svsematest: Suppress unused paramters warning
Date: Fri,  6 Oct 2023 14:40:00 -0400
Message-Id: <20231006184011.26699-6-jkacur@redhat.com>
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

Suppress unused paramters warnings in svsematest

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/svsematest/svsematest.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 243b13738b19..3c857dcb0189 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -416,7 +416,7 @@ static void process_options(int argc, char *argv[])
 
 static int volatile mustshutdown;
 
-static void sighand(int sig)
+static void sighand(int sig __attribute__ ((unused)))
 {
 	mustshutdown = 1;
 }
@@ -430,7 +430,7 @@ static void write_stats(FILE *f, void *data)
 {
 	struct params_stats *ps = data;
 	struct params *s, *r;
-	unsigned int i;
+	int i;
 
 	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
 	fprintf(f, "  \"thread\": {\n");
@@ -456,8 +456,7 @@ static void write_stats(FILE *f, void *data)
 	fprintf(f, "  }\n");
 }
 
-static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
-		       int verbose, int quiet)
+static void print_stat(FILE *fp __attribute__ ((unused)), struct params *receiver, struct params *sender, int verbose __attribute__ ((unused)), int quiet)
 {
 	int i;
 
-- 
2.40.1

