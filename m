Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6F38BC7
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Um0B9P1L"
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAADC6
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:27 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3af608eb34bso1542759b6e.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617686; x=1697222486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmtuJ3wyhKMdG28X1IjyfeBzNBwAPSW6cwB1+Sf5lck=;
        b=Um0B9P1L0HH5TZj74GhFH8cK8FFLH40lJwtbx8Fobbp+EjncPOqk9LtStbNiNiIx3k
         c7KKFZSyCN6rFk7AP6z1Wey8vOFxptZB8EUhJyhGGk1Hftm1NFY2IQXFJQJ8lPXvWZ3h
         lIzKo7yl8fbc0JTUYKE1rAICy4utpIr+zuszTJKN9gcakjDBC4HmV62FeXZEV9CQGRvi
         rrlJpjPFZVwTmFN1HbQylGOmsB5P0EX3CHy2RHAITmae0DmFqz2jcWaihAat2ZpN0ohK
         ld7ebdPyRHtoUsRW0KvKhIk/LQmzbxw8bBC0PReg1Zmr0ks6tN7z7wYKC73TkoR8QI9f
         jA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617686; x=1697222486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DmtuJ3wyhKMdG28X1IjyfeBzNBwAPSW6cwB1+Sf5lck=;
        b=NwORf3a+cDuts2E9zZAlexZBqZLdr53PABP7eot4owzSrWNJCCwKmDELmIG3/hXqLT
         Ka5SE2lZRHOQnyIHYPa6RZhCguDVOowRCr7Ozbp5MbU0sM+WyIGQ0R+gpzzLuzw/LxkW
         N45slOivWclzgJ8F18nM5i+ao4yfETvZHFO/ZZDgtAAqsulnFtl0oPrpjsEMDiZKuqUM
         mlzdFKwlH+MJiZioYKVo6RenruYnDs+ye8OvlCgJX5AiyOOiRFvjE1aXSpvvrV31gUpK
         rOtx19eXx7lDtoafwaBkRyQ1mRDbKFE6WM2MALqO9ewzAJal8aH9dw3hCaFtESD9ZsGv
         zwNA==
X-Gm-Message-State: AOJu0YwH+Tx/1KKqpKHzL/ZrqxyuAR0aM/qJko4q80KZ5TP3+zzjserE
	0AHshSyLAO1M9+z0qrqIXGVQXNZipYQ=
X-Google-Smtp-Source: AGHT+IG/eAPN0JqCCtLsl3PWVrfC70ENc42AVOhZjMxMQT+Qw2Khu1klY1S0XKvNd3DfCxJHBs1TEQ==
X-Received: by 2002:a05:6870:f141:b0:1d0:e371:e95c with SMTP id l1-20020a056870f14100b001d0e371e95cmr9698933oac.40.1696617686616;
        Fri, 06 Oct 2023 11:41:26 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 05/17] rt-tests: cyclicdeadline: Suppress unused parameter warning
Date: Fri,  6 Oct 2023 14:39:59 -0400
Message-Id: <20231006184011.26699-5-jkacur@redhat.com>
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

Suppress unused parameter warning in cyclicdeadline

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index ef00a0d6b2dd..b477cc7aa8ff 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1030,7 +1030,7 @@ static int calc_nr_cpus(const char *setcpu, char **buf)
 	return -1;
 }
 
-static void sighand(int sig)
+static void sighand(int sig __attribute__ ((unused)))
 {
 	shutdown = 1;
 }
-- 
2.40.1

