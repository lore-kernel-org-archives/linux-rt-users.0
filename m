Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C720C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 08:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475EC61132
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 08:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhIIIHT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhIIIHS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 04:07:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DDC061575
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Sep 2021 01:06:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q3so556426plx.4
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GJpcefJPfp1IQm8IIFNmZTAsQgtMb2CzvV2kA4kX5Z8=;
        b=jInENSushmyiG3jXjUWiKEYiydOCSEnMwP9IlHbCQWPvBzexc8IWy7dxrZpsyLaReG
         fyc+9/MhI1WuqSOGxU+OS3NV/5sRtLMpw1wH3njjy2SK9MaE7gqIIQFhQOkU7oLen8ZK
         oTnrCTAyVB1GUYqZcmv9EPF4+MOpO3brlzlWCOeJj9KN6KuEUhqOswwUGwMK7CctgtxA
         tkzF4ffVfmksfxAWmTdeJ0LucJB5Mm0tvWwUyP5mGHTgoBIArnr6/SiCmQITVggSdR97
         tWSk4HIjFGEgDAMFjYXROZijHncVf9yJzmGwC6CYW8dOU2CC0kR2H8n6FPXkMGKHle8a
         5Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJpcefJPfp1IQm8IIFNmZTAsQgtMb2CzvV2kA4kX5Z8=;
        b=FE7MhfiWHMHoXSjdllgmHPVp1sFAFwWnBJMrMZTVw1u/7PV2sGBaPlNlL/U5eNbb6j
         fA8gu+/eT04vXa+vgqoFxCmVM2AjJ51G44upgbEvzGmdrWDvohXEpvzvPDBc3zOvmaAi
         NCyNxx2Pro35B6SuNwitWvH9uHiRCVHE11HAHsAVUJgU5XhXSd+RUXSLL6jliNA+7Vtv
         wzfN9+S+3hquSmJbarh05IIAOlxnpKvk/hKxwQ3epvbwxg5MKk3wcC3L0qPL1kxbfKo0
         AAgipwdJafNSi9ei4AzWFWPN6TKaymHTbZP5qSASm0MRlqhVNFF/x2OZVWKD9d4PpJQu
         BecA==
X-Gm-Message-State: AOAM533Etzkx3rorOjoW2NcSCFQqSJZIjK4R4JlzT3a2kBYC+Qn6+jww
        O3J7iPYJhN0m8SBRHyXAZt8=
X-Google-Smtp-Source: ABdhPJwBNAIqt/KMxVo7i94aoMoL+7V56dFEU7mkhoNfT5G2hQowCTfCfK/NJzy3oX0mX+StMm160w==
X-Received: by 2002:a17:902:c401:b0:138:d462:3692 with SMTP id k1-20020a170902c40100b00138d4623692mr1597969plk.51.1631174768632;
        Thu, 09 Sep 2021 01:06:08 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id a10sm1267325pfn.48.2021.09.09.01.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 01:06:08 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: [PATCH 1/2] rteval: osinfo.py: Fix RT kernel detection
Date:   Thu,  9 Sep 2021 17:05:46 +0900
Message-Id: <20210909080547.1331581-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210909080547.1331581-1-punitagrawal@gmail.com>
References: <20210909080547.1331581-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Since the osinfo.py module was developed, RT kernels have moved on
from identifying as "RT" to "PREEMPT_RT". This change in the kernel
identifier causes osinfo.py to incorrectly detect RT kernels as
non-RT.

Update the check for detecting RT kernel to be able to handle both the
variants.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/sysinfo/osinfo.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/sysinfo/osinfo.py b/rteval/sysinfo/osinfo.py
index 98e5b4422cad..7b7bfe9ce4ec 100644
--- a/rteval/sysinfo/osinfo.py
+++ b/rteval/sysinfo/osinfo.py
@@ -91,7 +91,7 @@ class OSInfo:
 
         (sys, node, release, ver, machine) = os.uname()
         isrt = 1
-        if ver.find(' RT ') == -1:
+        if 'RT ' not in ver:
             isrt = 0
 
         node_n = libxml2.newNode("node")
-- 
2.32.0

