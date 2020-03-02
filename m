Return-Path: <SRS0=J9x3=4T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6ABC3F2D1
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4665620732
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Mar 2020 21:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6ck+kLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCBVoo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:44:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41915 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCBVoo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Mar 2020 16:44:44 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so1242041qtr.8
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Mar 2020 13:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxJMYlr0unCfgSF1dH4l7Ll4cSqbfMDatVMrWLNzVek=;
        b=W6ck+kLd1v2uYCwC2xpUO26A12KmnOVaAHhmFW9dyiGW6VAkCT/1Qh33T8Eal7Q7pi
         zthvOF73oxGaDUIZ1daqldjP1JmiskJ7kkv9mp2/ZihjI1fXB6fhM2nkonl0wZZhKwEd
         nv6MXClSIxQuh+o5txng5i1rDJ4jm/ZrGjBc7iJeLdlNrv0x0bhl6jvUcEqi7iKoFQ2o
         1GxwAox71EglLpDOqroLy2kJvq2N7d3WqYiV34VD2B5g29aQejtuvJKoM7/avbLj8RGz
         0BWD/DhMDRmIrJtJbpyszRYa2L0My39cs6nbR8KLTHabockRcXhBlmCPNgdhKcuTjktr
         hMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kxJMYlr0unCfgSF1dH4l7Ll4cSqbfMDatVMrWLNzVek=;
        b=idpXPyQ9QTgHgZkEbr/e+7QyBjjJ01BgS/V+83hGsQUguQRL5xZPrR63vJ9pUTqeJR
         wtv3r4LCpHIyPjP5r9kYiEx2XllRE+DVVxQTOIWkmXOvjUrcYkjUawdT6EWK5AXJ5yT0
         FkRYSOgJ1weKG3V8GznGiaQhjV/zxu9NXeAGS3C9a7VBabq/nuOG0qs1YnrEgrgUufY4
         or1Dt7vlnLxaidmcezSg3VkkqYwUpV5GHklq4KMgCzItg9bfiPsSzMplAokKA5zTWDPH
         E+JfnWnZWJcRy0/q+iCEW+tWQtJ750xAV7v+7lIOcdEMN9ruF2wQHkczdkhgmxCYA9OF
         xVKA==
X-Gm-Message-State: ANhLgQ3DSwue39gNAS+n+MWpVpId4sp3lge/2HXXkREVThC7xuLbVvR9
        W4ua0PfAJsQ69BuK9E2P0DEsTTDoGvk=
X-Google-Smtp-Source: ADFU+vsYYXuGkof54bzKH2azxhhmZXaODXN8lZxemV5dFZYM//9YA4cbmhzGMeP07kUiGXxEju/cWw==
X-Received: by 2002:aed:2944:: with SMTP id s62mr1603022qtd.289.1583185483348;
        Mon, 02 Mar 2020 13:44:43 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id n8sm10858796qkn.49.2020.03.02.13.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 13:44:42 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/6] rt-tests: cyclictest: Report all errors from pthread_setaffinity_np
Date:   Mon,  2 Mar 2020 16:44:26 -0500
Message-Id: <20200302214430.15825-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302214430.15825-1-jkacur@redhat.com>
References: <20200302214430.15825-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On error pthread_setaffinity_np returns a non-zero number.
Make sure cyclictest prints a warning in all such cases.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c66755dd4d87..bd1fcd1092aa 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -650,7 +650,7 @@ static void *timerthread(void *param)
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
 		thread = pthread_self();
-		if (pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
+		if (pthread_setaffinity_np(thread, sizeof(mask), &mask) != 0)
 			warn("Could not set CPU affinity to CPU #%d\n",
 			     par->cpu);
 	}
-- 
2.20.1

