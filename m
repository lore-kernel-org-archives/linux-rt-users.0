Return-Path: <SRS0=SCW0=XO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E334BC3A5A6
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Sep 2019 18:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA7021924
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Sep 2019 18:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/9UYa/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391518AbfISSb0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Sep 2019 14:31:26 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:41328 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbfISSb0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Sep 2019 14:31:26 -0400
Received: by mail-qt1-f180.google.com with SMTP id x4so5472102qtq.8
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Sep 2019 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3M3wsO+l0xWUAzZPIQnuosYctgJjk93533h/4BGoXQ=;
        b=M/9UYa/19pj55Pb5KuVWnXZMZDkmMAWnRjuKN2R1DrufP29Xjv/lInA9O5eYwkeTp+
         ue39eL/yOLRH1UCTVKPBZNgeiGncRCGJfRs3v597w6qUxa0sqSwF9Ki60k4lZhxUNWz4
         0te47HYPFobM/18kusYXq4a0JNfOWKj39DVjT1pcKiV+gG70wSXu9FyKkY+5f+16jJjW
         P471GvEm0nP5W9wbYylpBjwTpchu3+9RhNcLlX5qaULzLNDY/GIxkysd4zuUnJLwTwXa
         Do1DEquGNJwm2eUiHuOpszRwa55u2c2K+hmP4rt9qWCbQ2RrNbqJ0YwVP+ZSytpyxU0R
         gr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=e3M3wsO+l0xWUAzZPIQnuosYctgJjk93533h/4BGoXQ=;
        b=mjTWdYAbnJC3g6XoOfCdQ/nUtyF0wysWXWK83Fr70FI6DEmeq9mx627VIAJNpgib6k
         kZ8Rhsx5zsT32bSJS49q+Y2y4yRnF9mdrYFIrrRBMNyLUOceDwAvxDxL/3YGrljUznrq
         Obpad6aEh5gc52VwAsy90ywsHZoyKFJUGwdu/5OpWmD86jNNa+UHcqyiefyzLEXRMja3
         yYjfcTIbici1w2g6aWQrEIh5ylXfydJDHwzvkWOrkZUkIUynpeJsxC7HsNNV4PcgTm2r
         cjtWIY2lbfNDrG7eFqVsmTL/pCXp3XVP2MsviZ7ouWjFd1+z+0iJ+XPZfjHLjALeZZHr
         aNnw==
X-Gm-Message-State: APjAAAUlgAJkD2cmg1pXLlHbE6iuanNS8wad4kypujhVsCxqKHnII6oH
        g53O6ozrw+ztqflw0V6dMtf4Q4esyWg=
X-Google-Smtp-Source: APXvYqwS+s57k9voicpp92xPBDEpXXdKGgVEqxmg2b0zcau+rS7SfTRoWtynAIVhqttWRtOpYCYDkA==
X-Received: by 2002:ad4:4708:: with SMTP id k8mr8907935qvz.219.1568917884346;
        Thu, 19 Sep 2019 11:31:24 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id u186sm4841516qkh.120.2019.09.19.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 11:31:23 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: cyclictest: Assume libnuma version 2 by default
Date:   Thu, 19 Sep 2019 20:31:14 +0200
Message-Id: <20190919183114.11569-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Most distributions have used libnuma version 2 for awhile now, so make
it the default.

This doesn't prevent people from defining it as version 1, or compiling
without numa.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/rt_numa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index e0f4b2e9d8b2..7adeb3c01324 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -29,7 +29,7 @@ static int numa = 0;
 #include <numa.h>
 
 #ifndef LIBNUMA_API_VERSION
-#define LIBNUMA_API_VERSION 1
+#define LIBNUMA_API_VERSION 2
 #endif
 
 static void *
-- 
2.20.1

