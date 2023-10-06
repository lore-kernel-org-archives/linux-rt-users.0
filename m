Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82861A29F
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mk0HmTyd"
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E44BF
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:26 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so1573856fac.0
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617685; x=1697222485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWhzDvKh0xVCCh7ema8mg7INwO+/SotONhh1TeXO3uw=;
        b=mk0HmTydjj2athF+ARWORw+RyeitbUT3O5tGKTqNaTqjb/9JdWgYQenJ2+4rvv8GLn
         28V9EGw+kvg9uBkJmEBKG6BaijKztM2Ff+85CLvwOeRS3IcQ31Hgu1jef7G/k+QnwMp+
         uyjeG7Uj8X6GM90ak929DOLMyJIZgjx3fRlOCeoEfvcXUjHPVCGGNrPC+Jy+Z1w6D62S
         Q6q1CVlKaczW0Sr8v5Z0uPcUQVvKF2IMzPFCKfmLfDkDBzVce8u9cW12z2MRdcfA89X+
         UKogUe7mEE3NnoRBbb2uaO+ip3GjUPincAR18RCJKjfy+8FlA4wd5lkH/tNgaoxoOB1d
         ceqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617685; x=1697222485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iWhzDvKh0xVCCh7ema8mg7INwO+/SotONhh1TeXO3uw=;
        b=HJ4LCaXImtbWXQC9woY/MuMWhFATAGeoio3Vod5RzVvEfRsz19HePaNr08TPKjbzrB
         uOjzfNTNABS6ummN31vajWDm+yhsVMF8SdukTS8uBKhYdTTi03zvNngGXkQSYi5Mn7gg
         zvK3Iz1N9tgUM1H+l2jTi+xopJngaQEtrLMzCj4kjMwGyusbc4n8iY8PKwYVknJb6mNU
         FqngeoS0AHStSWB6C1U3oNStfbfbj4Pyday2NVtIl4jtq/BbvnqM7CbtIrP0MD6mAWNO
         3sZNCsYLd3ccJWQxlnMOfXqXlY5eiM0eHy2qhaoD4zxnkLcErFojAhYndUedhhbO5lOm
         S1LQ==
X-Gm-Message-State: AOJu0YyfKpW2a9qY0ElrdsLt6wGybMJwQDQ+NJ3b7SEDYS+7xlOOgVek
	7J/ib8p0SPtphoAhu5E6mE8759FhqR4=
X-Google-Smtp-Source: AGHT+IFwf/0DIFMr8DoLhypMSo28kP8QWu6i++IBFqyR8+nq1oIZuc+O7oVKdESyuYtOQZpPTJJZ5w==
X-Received: by 2002:a05:6870:14c1:b0:1bf:df47:7b5e with SMTP id l1-20020a05687014c100b001bfdf477b5emr9915072oab.16.1696617684825;
        Fri, 06 Oct 2023 11:41:24 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:24 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 03/17] rt-tests: ssdd: Suppress unused parameters warning
Date: Fri,  6 Oct 2023 14:39:57 -0400
Message-Id: <20231006184011.26699-3-jkacur@redhat.com>
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

Suppress unused parameters warning in ssdd with __attribute__ ((unused))

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ssdd/ssdd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index c5307648a82d..cad901b563d8 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -64,8 +64,6 @@ static const char *get_state_name(int state)
 	return state_name[state];
 }
 
-#define unused __attribute__((unused))
-
 static int quiet;
 static char jsonfile[MAX_PATH];
 
@@ -154,7 +152,7 @@ static pid_t parent;
 static int nforks = 10;
 static int nsteps = 10000;
 
-static void sigchld(int sig, unused siginfo_t *info, unused void *arg)
+static void sigchld(int sig __attribute__ ((unused)), siginfo_t *info __attribute__ ((unused)), void *arg __attribute__ ((unused)))
 {
 	got_sigchld = 1;
 }
-- 
2.40.1

