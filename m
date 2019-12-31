Return-Path: <SRS0=0aUV=2V=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CDEC2D0C2
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Dec 2019 10:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98495206DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Dec 2019 10:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="aZ3fiRv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLaKBQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:01:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45997 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaKBQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Dec 2019 05:01:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so26705513lfa.12
        for <linux-rt-users@vger.kernel.org>; Tue, 31 Dec 2019 02:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pSn9edI5nPyVNDRNjyZxCJa51KVXQFLu7Z+N0xYESZM=;
        b=aZ3fiRv4+ZGkdTTxyOpPcXirhvKwWGryL6T7j7XKBE9fc93FuXx+MkRadzqUdqYZdZ
         fvVeSHvZ7M4vCMttZLQbQl3DwJcRieGaqk8Tl3rCWyO3KJcyiqHaQtjOc6VW2OZvY4A5
         37ClRX+pQA2SrK9Durq81c4rKn7rUi4ydq8hqU6eMd4t05Py5Vw1Nr/VTN+t24I9wQ6W
         CPk+ACbhFuGWkgeLDvHxXS6BG2SRspOLTNxdrSLnM6flT9ZHnxjAZQEc3xZrWtQbmPJJ
         Xt/oDb7aVnIX2lvxXcZ+qsJcNX4dInOUQM6T/qMk7DRLx/ZuVKM42PQz55KENKCkpxem
         vt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pSn9edI5nPyVNDRNjyZxCJa51KVXQFLu7Z+N0xYESZM=;
        b=ZqG9seacrav+EZSDjZXS/P9QRn3NWIg1xvr7pWS+Cl6mUFnQ37nHIBXazWCttaB4U8
         Z5GkJfRisCBA2RVkm+gAg6lwutrR3Ffj7j3vSC/w5xus3VcbRRNV2FuASzLpv9KH1GrG
         dJTutDGf0+b9DC3jmVF4NZnLOIczXi3vDeMsBQrew0Rk92YslArn9NM6/1poXUWT+kT7
         WcHVmHM+jHGIyWgC5uwPC3JdScwT5USyxWAewSuUESDG6N4Hi+GlcdWAkFwk9yU/vl3+
         m/h6mE5h4ISjdokWCe/f3mRHutE7H58o6Oe9VtV6rOrjjRRzdaj/JYbzXHNBsy1xPi2+
         GGIg==
X-Gm-Message-State: APjAAAUcHEEDYt/IRyoxxFvOnQFUkoJ2XWaXAsRASiyGKAJVpZNz5OEZ
        SI+Kzzels+Hi5suN46+gQ4khAJniX8w=
X-Google-Smtp-Source: APXvYqwnp0qtUfePE0r3dEuyGaQWspjTdDLpivyf+n3hqH1klraV79CJ8/rBVIlnQz6200xQznLhVw==
X-Received: by 2002:a19:888:: with SMTP id 130mr41987264lfi.167.1577786473881;
        Tue, 31 Dec 2019 02:01:13 -0800 (PST)
Received: from localhost.localdomain ([109.204.235.119])
        by smtp.googlemail.com with ESMTPSA id x23sm19900799lff.24.2019.12.31.02.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 02:01:13 -0800 (PST)
From:   John Mathew <john.mathew@unikie.com>
To:     linux-rt-users@vger.kernel.org
Cc:     bigeasy@linutronix.de, lukas.bulwahn@gmail.com,
        John Mathew <john.mathew@unikie.com>
Subject: [PATCH] crypto: only wait for completion once
Date:   Tue, 31 Dec 2019 12:00:51 +0200
Message-Id: <20191231100051.658-1-john.mathew@unikie.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Proposed fix for the swake_up_all_locked warnings issue discussed in
Link: https://lore.kernel.org/linux-rt-users/20191218165334.k4suur4gzlu62ibs@linutronix.de/T/#t
Currently multiple wait for completions are scheduled for the same algo.
Only one completes and the rest are returned with ENOENT. This patch
checks for the name of the algorithm going to be waited up on, and if
the algorithm is already being waited for completion return EAGAIN ,
without accumulating completions and returning ENOENT.

Signed-off-by: John Mathew <john.mathew@unikie.com>
---
 crypto/api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index d8ba54142620..1c6004e7ab6c 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -234,8 +234,12 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
 		alg = crypto_alg_lookup(name, type, mask);
 	}
 
-	if (!IS_ERR_OR_NULL(alg) && crypto_is_larval(alg))
-		alg = crypto_larval_wait(alg);
+	if (!IS_ERR_OR_NULL(alg) && crypto_is_larval(alg))	{
+		if (!strcmp(alg->cra_name, name))
+			alg = ERR_PTR(-EAGAIN);
+		else
+			alg = crypto_larval_wait(alg);
+	}
 	else if (!alg)
 		alg = crypto_larval_add(name, type, mask);
 
-- 
2.17.1

