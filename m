Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1EE328BB
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ/hDqlR"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E7B6
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:35 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65b2463d663so12895656d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617694; x=1697222494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5UGSOBnnoTjspcMGngSs0kdoliq4sRX12Mt5mGrbVI=;
        b=mQ/hDqlRRtn4E/nKBZOhJrjwWYM39CeGeIY94l8aui4dD8TxAvt7uxxMtTS2K+rpKt
         Nb57rXS9VnO+5h4r0DICdIzxwP+8J1tiKxyKWjmrnBbdVgHLLnXGUtiUP7CyKog/gniG
         sLU475kUPt5N0HnqwAdwzLTwLlrSdq4BSFphA4gJcCs9BRqMevYKFdMngz8xJgTrLl6H
         S6jB/4aZdEfIHCbv5SLBHAMftG2UxQY6wonHOrsFuydaEfah1HAJDDlfZc2FPS7CreM/
         uSPqURX6MY2hW3hjmBKUpS0tJDN0DYrUK9y7HtZb9pp+7Zqzz5AnSc9pGXhHpCiZ/Jgt
         bDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617694; x=1697222494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S5UGSOBnnoTjspcMGngSs0kdoliq4sRX12Mt5mGrbVI=;
        b=kmfXMFYcVBp8hbFrDD/DZWyFdaL3y20yZ/Jw1UcWyXpuTrPgEr8psu6b3BK609uRyY
         +cSgFBgQYMVm6jAo8kvSD5AVcMZJ6r/2JRHPGPfFnaLXep+cj4iRT4uUQCGTGuGYyeHY
         CrctZ3wjTLxqzCxkbOdDSMn6LBiUzR8fc62PSJwXpYzGZvpG8QWMyg7JBVUtCRSL2M01
         c13DH2pkorflk2hMdUrVqqMkYL05DwBvGhSeg//Y9/i8j/wYImo+pWqItSg/ouE1RE2H
         nK2D2sRRyaAacuZgFxod1yU2v4WHsVqWiHMeyk7pT7GG+vLtdXPY1PNCFc+m5SxI30Qd
         uIBA==
X-Gm-Message-State: AOJu0Yw2j+Osf2JwZ9DRkJdS4ruBomnH+tZjSRvBX0gfQjrfS4p8bpUL
	xNE1aejeF/lBjvpS5KjfrOSb5obTOuI=
X-Google-Smtp-Source: AGHT+IG3SajgORwPfxNmHFR5fdtKPEiFkxuqKLGfvxRXd6WZS/V0yl9bT+EZOGhY/4xQQdCJOpdotQ==
X-Received: by 2002:a0c:a9d4:0:b0:65b:d75:129d with SMTP id c20-20020a0ca9d4000000b0065b0d75129dmr9005720qvb.34.1696617693920;
        Fri, 06 Oct 2023 11:41:33 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:33 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 12/17] rt-tests: cyclictest: Fix comparison of different signedness
Date: Fri,  6 Oct 2023 14:40:06 -0400
Message-Id: <20231006184011.26699-12-jkacur@redhat.com>
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

Fix comparison of integer expressions of different signedness

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2542cb5ecdce..a8039b49feb6 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1800,7 +1800,8 @@ rstat_err:
 static void write_stats(FILE *f, void *data __attribute__ ((unused)))
 {
 	struct thread_param **par = parameters;
-	unsigned int i, j, comma;
+	int i, j;
+	unsigned comma;
 	struct thread_stat *s;
 
 	fprintf(f, "  \"num_threads\": %d,\n", num_threads);
-- 
2.40.1

