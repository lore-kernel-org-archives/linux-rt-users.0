Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BFD1A29F
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfJmuBJj"
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A834B6
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d81b42a3108so2787179276.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617683; x=1697222483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=abc9jH7p9op4GCd1YvdShfPjRo+5a1KLFVgcNDm4/nA=;
        b=ZfJmuBJj467m3/p3ncaQn/bKPYXZoS+p43Jr92FbFxC5elU24G6cBhnDlQzV0TuYsv
         ZYCOrC6hOXeiFOtO+cRdKgCWN3ZA67AQnaacoFXmTnuOD64KS4Yf2Wqle7OjgmBI7MTk
         GzlEuJPMkADAqQBw6EsLdL1SPHiEOc6CN3xFOydLVhnd7OwT+n/5W1bTTHxklUtMxAn6
         mXzPTZtkisVp4UsGjhL0BQOLQBmFkIJmpsJkGGTM8FhWQi0Uk60eaMHIQm6q3/Lg0Rcz
         PgGYbvRvjZfivF351Nrik2qlS/bII1BqzzpxpbnM+ddJ4tXcv/qSkuIh7jwYV8ADP7FI
         EFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617683; x=1697222483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abc9jH7p9op4GCd1YvdShfPjRo+5a1KLFVgcNDm4/nA=;
        b=tTBghbPaSNMx11cqgpJntz2tFDaRrk+Wg75wzGo8+kzukD/dMFom5vQyRmUhwbcNRs
         m6TbCt1IfyReQjjbDAecs9jYvsgzsW7PXRdYjIcSxgLXkrUZV/Vk+A0qv0U5Sga5NDaq
         KwBlYYB6UtmQCGmHvVpIgzAYPjdsQBnvlPf2D1PPVt19u7Cc1nz7VxPwrmpbyfePP9FH
         UMHIhadRWF0HdpOGf9Pd2g0ah8/eAxLXDK7QGYi1kmDV41vjvo5bciiCMnppLPxiACQ3
         6SxoR70KFlAYVX/IxxSl3q+t3GXhyWmp/csGwXTQR1xRsEwQus1C3hqAoGt8G99B5xZK
         NzMQ==
X-Gm-Message-State: AOJu0YxtT/e6fF9alVzufBLNkYHwgopN+C49eHNVDlf/aLgSKPvEaNbp
	MSu/JU9TgSHfhvPl3WVB2thkuG1K5jc=
X-Google-Smtp-Source: AGHT+IEt+K5JvZ7Gm21ec365gRb0m1/5H0RQLNSqaEBmShGTNjE41NZEJ3TlpmFT12SiNCGAsFm+hQ==
X-Received: by 2002:a25:8441:0:b0:d78:134:9477 with SMTP id r1-20020a258441000000b00d7801349477mr8597388ybm.58.1696617682702;
        Fri, 06 Oct 2023 11:41:22 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:22 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Eder Zulian <ezulian@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 01/17] rt-tests: cyclictest: Remove warnings due different signedness in comparison
Date: Fri,  6 Oct 2023 14:39:55 -0400
Message-Id: <20231006184011.26699-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
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

From: Eder Zulian <ezulian@redhat.com>

Type casting used to remove compiler warnings due to comparison of
integer expressions of different signedness.

Signed-off-by: Eder Zulian <ezulian@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4a7108ea2c8f..179ae8b2004b 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -317,8 +317,10 @@ static int raise_soft_prio(int policy, const struct sched_param *param)
 		return err;
 	}
 
-	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? policy_max : rlim.rlim_cur;
-	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? policy_max : rlim.rlim_max;
+	soft_max = (rlim.rlim_cur == RLIM_INFINITY) ? (unsigned int)policy_max
+						    : rlim.rlim_cur;
+	hard_max = (rlim.rlim_max == RLIM_INFINITY) ? (unsigned int)policy_max
+						    : rlim.rlim_max;
 
 	if (prio > soft_max && prio <= hard_max) {
 		rlim.rlim_cur = prio;
-- 
2.40.1

