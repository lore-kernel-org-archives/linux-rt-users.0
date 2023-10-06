Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429230FB2
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUddZDEj"
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE688BE
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:24 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c4f1f0774dso1597010a34.2
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617684; x=1697222484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt+poQxdN+xngJ4xdMsOAO7ftfUcllaWtK9Cx+5ctKc=;
        b=eUddZDEjsjcFOoS9hEdDL9rLcWzBxlwEMRxqGIxoZttuEL2hpijOP1WjarbAVI47Fc
         Ur8ipkgHB9aE/h+LqBplkc0yaYFYOHDfwwg7CPbv7JroUTZrQH7CaL9ei0jta73MC0i2
         Joiz/A+2/9zGAXGSOVIXp9UiRc3X+mQwB1DCf2MiD754YQKTq6q2j/+zx+20mwVYl8GV
         2rxbOSlhY6bp/rd4oMOqbz0OQvYSmu3Qi4nUU4DypVdfHCl2y0Oo86JrSF8Ur78wjn1o
         xiMAktwaC2gbAhltcD9ySdpRUEkqEFq5oY7GPTzAnyXPNcryl3fBJepsqE4i51AQ/ZD8
         0NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617684; x=1697222484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xt+poQxdN+xngJ4xdMsOAO7ftfUcllaWtK9Cx+5ctKc=;
        b=AFBCx9xDx5yz5o3DlHHlSpr9DhuAOQw6MQzgD7zj4SIucTEGV/6bj3P2rqEWz/2wd4
         zhQOnFaEdph99F0Zu5jG33sWfRPO8VcAzWEnHw1RXmG6da2fvSnl/ek+81e63wmbziLL
         pAvBiCR0pUqtxFGOzYF70SR3pJPPkdYB3MSds4qmP6Z+azo6xBUkoqo+qMuX8tNzbcZB
         cEK3Fn9ySe3S3rHOGJnqJCVQQfUzmTUm5MmZ27e6uZbcBbQM9EzEakVWO2ymHItvptkI
         AyCiAtYhowCPPkTwhVLSvk0TkwdoUh/Aedqr2q0WhCQ+qj76iuT1wnNvrKkqkAAArvqB
         Yh4w==
X-Gm-Message-State: AOJu0YyyU/z0L4iOnDpcAhX7Z09aNBelIpE8wVtIO/H0tUZ8N/pF89xN
	LVNg3cGMWGOAnXTM2OWeN7JRNvvWVUQ=
X-Google-Smtp-Source: AGHT+IHF2kXTdtops9zm9Rda6X9VmjigvpMsvmXv051tj4zpBRqPzuNF0c5YTslhYtortVcmlxwIrw==
X-Received: by 2002:a05:6870:d1d3:b0:1d6:5b09:1584 with SMTP id b19-20020a056870d1d300b001d65b091584mr10197132oac.5.1696617683836;
        Fri, 06 Oct 2023 11:41:23 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:23 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 02/17] rt-tests: cyclictest: Suppress unused parameters warning
Date: Fri,  6 Oct 2023 14:39:56 -0400
Message-Id: <20231006184011.26699-2-jkacur@redhat.com>
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

Suppress unused parameters warning in cyclictest with __attribute__ ((unused))

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 179ae8b2004b..2542cb5ecdce 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1616,7 +1616,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
  * thread that creates a named fifo and hands out run stats when someone
  * reads from the fifo.
  */
-static void *fifothread(void *param)
+static void *fifothread(void *param __attribute__ ((unused)))
 {
 	int ret;
 	int fd;
@@ -1797,7 +1797,7 @@ rstat_err:
 	return;
 }
 
-static void write_stats(FILE *f, void *data)
+static void write_stats(FILE *f, void *data __attribute__ ((unused)))
 {
 	struct thread_param **par = parameters;
 	unsigned int i, j, comma;
-- 
2.40.1

