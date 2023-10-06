Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F437C95
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUrRU8/x"
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B6B6
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:27 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65b0c9fb673so12838066d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617685; x=1697222485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeMSAFzQ1UToFRPwQ8pnGusBeLD2OJJdVLWknq1yrrs=;
        b=eUrRU8/xst2dd0mvOwQMULFSYItg5zQvHMxSuMWXjeeud3ndEJguZVfmGgtvMFxoFM
         xKLQ69IP80a2oi26D0eaw2HHS3Qq9m6cPYDFG7RgeN6J2F9L8/v+pB7NwPeStziN8fhQ
         1g42XGUmKK7BK8GyAvwvKYV2gaO5NxXHzgeF0Ze6TGu9WqSaMyjttBx/avYQW1OR8mPV
         gylOjNDeuI0S0Zt7rWhbksFPeh6efHqRMxCyluYboFbzqEAr81oW8UBgx2hQsOlE/M+R
         aRiG1Jb30GvtmI3vwyNfFhl0MUOGvi73eu1Tl6HeD9Z4K2l7gNnQ+363UeaeTu2vG+IW
         +t5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617685; x=1697222485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeMSAFzQ1UToFRPwQ8pnGusBeLD2OJJdVLWknq1yrrs=;
        b=thoL8iOcTRBQatPJQyzX6cEOBQi3kJWCNQ5p/APdvtWlaKNAUy7H97LzGKNEyvRW6F
         3SMNQnbcJo/6Bedcrkr5sWqxUkwwilaG9CMFQRXX0I/AT+OJ1St3eHg36f2R+ufgi4Jh
         X0Vzi+OY4dOKbGEuOdVIRtqmUk2oiqB2kczjzOrZJoOUlE5WbczQmmzdSLzkuKU7ty2N
         N7zjLBbxppKUHHrVELVAFFMlNErIfJTHoLnI4WXWIvPmUSJLzA3+1q1a/c7tEqrby9Vq
         0lZ1YK1eCDF5MKXAbMuYX5K7R0RI/+0CMyGZkFlUlLFqTWjo9xVp4CNBkwewST2H0ipW
         w2gg==
X-Gm-Message-State: AOJu0YyX3/R98WvODxB4zViKr1leCObySXWCTT4VFu7a46q3ToD5zLd0
	dV6oAoukODzze6XFpyFtmkyePHzJUew=
X-Google-Smtp-Source: AGHT+IGlx1P9Y5/kGg9mszXLWi3eWViKO9m3Ij+2VzMMQK2T7+TJ4Lj1xCXYz0tJDgsKgMNBBlN8KQ==
X-Received: by 2002:a05:6214:807:b0:65a:e23c:8861 with SMTP id df7-20020a056214080700b0065ae23c8861mr8496607qvb.9.1696617685617;
        Fri, 06 Oct 2023 11:41:25 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:25 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 04/17] rt-tests: queuelat: Suppress unused parameters warning
Date: Fri,  6 Oct 2023 14:39:58 -0400
Message-Id: <20231006184011.26699-4-jkacur@redhat.com>
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

Suppress unused paramters warning in queuelat

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/queuelat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index ead8ee5f4898..c549cd8381ab 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -519,7 +519,7 @@ void main_loop(void)
 	free(src);
 }
 
-void sig_handler(int sig)
+void sig_handler(int sig __attribute__ ((unused)))
 {
 	print_exit_info();
 	exit(0);
-- 
2.40.1

