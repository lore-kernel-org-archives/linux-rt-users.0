Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48D328A2
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcpoyB/6"
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B27CA
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Oct 2023 11:41:34 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1dd78b46995so1429034fac.3
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Oct 2023 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696617693; x=1697222493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OznNJAkxQa61VkMM/CJVhyZpfswExKXtz11p9bWBnWA=;
        b=mcpoyB/678dxbz/SX+uE1r6b9DIT0L9Wazs30Upagmrui6b0PRZD8Ch6cnXnyYw4Ox
         9SskMiPA3NDwrnCeVzHuDVsZXX+8i0VUQDrdyKN/yMmgy20gr13mGoWrYzWrUB1ZH18x
         zXss9lPA+BN+avCwQ3aqXBnROxA1I8ssMdeanoQLNt7M6uodJDggmj1kukOlVp+JrLS2
         pvvCbSpCMHM5yabyGfRH64RdrjOiCgGosd1SkRIWCg0oOPgRm6LeKvqbTuwosYeY1dem
         kKX0eLzgOMxECuoDXh9/2i96PmmkvPDjy79v1hVdybFbMk3Kac96xpkurIHVCyMUEWPN
         nGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617693; x=1697222493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OznNJAkxQa61VkMM/CJVhyZpfswExKXtz11p9bWBnWA=;
        b=piDGwy6fMIdsv4d8qXyNrHwocB1P/Arq2/PoheoZ6llideDPhcbgCTJCOwpKhWaBZ7
         8l/5/8ASHBhmnDEJhXaTvV6D9O35WzNv0F5ABjqHBQGrKY7aZcklJ6I4ZLgURADMX+ZO
         rWudHrAYR6dUIwebUJKbjcg/t2Iwal0ND4Wi8XmaWhuvADkTniLJup643pcTVtnXMgxp
         nmpkllKe9kQJhSp7zRpnMFU5/X7QHg8c7Z/gp+0N259iehpGNX5RvEKAzTrkiq8+Hp/E
         YLlN9LgIpNG8t3m/VHTvk6Tv8PusdcASuJ3lUir4kxrFvLjbeNed+/Y9//TIs3Avmudm
         7AFQ==
X-Gm-Message-State: AOJu0YxiM4j405avGhdIZ49vOdFn5m4rZPfGjFDJOgA0CDFowHNep1yl
	T3FQNxoFYJcyWflfEwpYP0dhc0sM4LY=
X-Google-Smtp-Source: AGHT+IGh1nUHL23PvFiZ7sYJW4FsEiCKKszns/6rAHRgND7HjqSrv+wCbWlUzcLpL8E6YyS7HWKu7w==
X-Received: by 2002:a05:6870:658f:b0:1bf:fd8a:826e with SMTP id fp15-20020a056870658f00b001bffd8a826emr10021075oab.55.1696617692869;
        Fri, 06 Oct 2023 11:41:32 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id y8-20020a0ce048000000b0065b11053445sm1593012qvk.54.2023.10.06.11.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:41:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 11/17] rt-tests: cyclicdeadline: Fix comparison of different signedness
Date: Fri,  6 Oct 2023 14:40:05 -0400
Message-Id: <20231006184011.26699-11-jkacur@redhat.com>
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
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index b477cc7aa8ff..9bdc4b5deaf1 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1067,7 +1067,7 @@ static void write_stats(FILE *f, void *data)
 {
 	struct sched_data *sd = data;
 	struct thread_stat *s;
-	unsigned int i;
+	int i;
 
 	fprintf(f, "  \"num_threads\": %d,\n", nr_threads);
 	fprintf(f, "  \"resolution_in_ns\": %u,\n", use_nsecs);
-- 
2.40.1

