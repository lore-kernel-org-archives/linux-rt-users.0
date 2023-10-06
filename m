Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AE38F90
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXF0B0oj"
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702AEBE
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:37 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65b0e623189so12124006d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617696; x=1697222496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhK4D1Qz5w4odL0bSV80wjBn4uP73PDsNJ2TKTokZ/8=;
        b=LXF0B0ojOqQyuhxciKN7LWvVj8PlVJVUCudGrBgS/zsDv3EQGd3M2tL7vMTNuM6Ei9
         lLzkgjrYr78RiNbMkKP/3+eSYlCL1S6fuj0apq9M+Ai6y2UWfX7MK3W8fKngdVakkblT
         /55dTjp9rH0/9zNOnJ8oKZTBgcKGgiN1/XT//3fX4NZRP/ojtVamWyaIhJs8L5S4qsFR
         sw/dsN1BcfmO940m6Py/zW7Fz9ilthlUOfJ5bOSdMfTDOTlAcvsZg7VXOjhRCAvpWntC
         fZyI0il3DDKK+VvlNIOqrStqxOilO8QxWjPAZqoB6hj3ZNak30uaKJRg1P/usqd9Cnw2
         fG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617696; x=1697222496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PhK4D1Qz5w4odL0bSV80wjBn4uP73PDsNJ2TKTokZ/8=;
        b=eboU+PiQyC6RuaWQp8F3hmTzzHcvjTS9+xs+Vr+hKZk6MrzTaH/qUP5/UId23sB5ax
         zmq6CZWsLwh1G6rdZHTVYrSiOcyRP3Ek+uNGzogoFtSgMSPmi1fJXTkZUYdsCGaUidIP
         0JCB+pT39uzdGMhvVI8dLWduXTV9x53TSrvJeH2nxml0Ip6pJtt0TCTv6E52lXLDcBI3
         cjKdOhQVyhmQFJ3tohZi/qNzI7kYpBd8hMx5ArWyAUUWzV4hpxS0u6HHKopuEzO5YV7L
         NDZo3GTWMuIm6rEDHcNH0K/PNDwDa3mnxt9L35HkgVYhpN+iCsA+8in4MjtTFoWiStiu
         ZpSQ==
X-Gm-Message-State: AOJu0YyJ98gaJXYDOLSJGLDLht+E5vVyrbw0nWrp6OgHlqwr4RoNmxpU
	mO4vBMW5szoXNSZ8roWEdQHndqGjN+0=
X-Google-Smtp-Source: AGHT+IGx+t5c5wNUG6OVNsESb4jhmEPSIDzwHvoRgv2RfntQiVr3yWiwpwW6pBFqYdzsJuQPZ5YHnA==
X-Received: by 2002:a05:6214:5503:b0:65b:154d:facf with SMTP id mb3-20020a056214550300b0065b154dfacfmr8744048qvb.59.1696617696195;
        Fri, 06 Oct 2023 11:41:36 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:35 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 14/17] rt-tests: rt-numa: Fix comparison of different signedness
Date: Fri,  6 Oct 2023 14:40:08 -0400
Message-Id: <20231006184011.26699-14-jkacur@redhat.com>
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
 src/lib/rt-numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index 1b09cff8d948..548365f50cc4 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -52,7 +52,7 @@ int get_available_cpus(struct bitmask *cpumask)
 
 int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
 {
-	unsigned int m, cpu, i, num_cpus;
+	int m, cpu, i, num_cpus;
 
 	num_cpus = numa_bitmask_weight(cpumask);
 
-- 
2.40.1

