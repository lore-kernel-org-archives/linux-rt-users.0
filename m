Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B81AC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7D2610D1
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 19:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbhIQTJV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhIQTJV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Sep 2021 15:09:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFEC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2021 12:07:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a66so20644396qkc.1
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2021 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QBAOHtatBjrL+qqd02++I0diA+3cjXZ1SyPkHIKHZBw=;
        b=FWeyKd+HonYjA/jY1pwU7NnH/hu1TAULTiI8+xv+LvlkZiQhVp7GAIKkcXKlkN0bU0
         qIiA7iLipqJehhsXw1vnRCiLHvviALs5L4pTuwnIbiBW6OrAA59KzqMrsGmwCnrc9lsy
         7DTYhhDqt4i7MUkEDdHgZhp9nXAGecN5ox70RiaIL9KLpQW2BCCW35SCNw7Mou6dZqAE
         0sNwko4nCSKHSBuHZt9qLMtAR5G4vXvYi1p2TaI1KTsY9fRjNMF5qHCmzKLMtzMdVd8B
         HXmygLEj7tmsaFo3IKYzcq0CNjM6cnfuu9XxNFHko99jmMT6Jx6Topd8HBYKcia9Vobr
         H1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QBAOHtatBjrL+qqd02++I0diA+3cjXZ1SyPkHIKHZBw=;
        b=eXOV+Bm/mHz/2wB8r5JZJS6+BesZcS5wVyw6qgsoIwh7WXBpBrs9ywYsJ0Q5CVb4dC
         YWidoQRB4LTppBQvSOdSLTWSLnmwabSzfJEK/QUqTLG+fmPb85IZ2gGxg4leg9OQnJ6D
         3QvE7V6zsxd1cgzCUXsdrqdyLyLQRcgdkBIVK3jOFN12P/wsFFHZAlL5wovcBeO8P6n3
         0Gr3Dcnirb3yrvwYPwFxTwgDgH9SO2P2Dq4wst04NZ+PCH7xBfrSBe9FcwDsz8+SCaQE
         AAncbgMRep3M8ZKNqNJyXo1uuvgqnsnF0MvwZsRWHJ2ZuQYC7aAAg9V4ziJRyAVCdCd9
         HbIA==
X-Gm-Message-State: AOAM532hWKU53QPr+0xCgCwtig7aGYTuvLG3MT9ovw/GA5rSM/P41oEQ
        Uyj/vwF9hBkNVTsQcy4O0lnNE3XkAAg=
X-Google-Smtp-Source: ABdhPJwJz1I0izJ7q6O+forVBe+fMuq9+DqL3fIPzKy3N8C+F2lXTaUhyXM4KjrsGsIMNuFVeagUFw==
X-Received: by 2002:a37:91c1:: with SMTP id t184mr12020278qkd.129.1631905678110;
        Fri, 17 Sep 2021 12:07:58 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id j3sm5391472qki.104.2021.09.17.12.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 12:07:57 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>, John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: pi_stress: Fix "id" in help
Date:   Fri, 17 Sep 2021 15:07:40 -0400
Message-Id: <20210917190740.14957-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

commit 3ef71ab4c40caea1fa70000a2ede0d8df8690c98
made some changes to the online help and man page

The --sched policy=deadline option requires id=[high|med|low]
Unfortunately the \tid (slash t) got transformed to "tid"

Fix this by replacing with "id" as originally intended.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 9f4ffa49e926..cba1ad92ac2d 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -996,7 +996,7 @@ void usage(int error)
 	       "-q       --quiet           suppress running output\n"
 	       "-r       --rr              use SCHED_RR for test threads [SCHED_FIFO]\n"
 	       "-s OPTS  --sched OPTS      scheduling options per thread type:\n"
-	       "   tid=[high|med|low]      select thread\n"
+	       "   id=[high|med|low]      select thread\n"
 	       "   ,policy=[fifo,rr]       scheduling class [SCHED_FIFO, SCHED_RR]\n"
 	       "     ,priority=N           scheduling priority\n"
 	       "   ,policy=[deadline]      scheduling class [DEADLINE]\n"
-- 
2.31.1

