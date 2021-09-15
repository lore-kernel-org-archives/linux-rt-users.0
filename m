Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DE5C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 12:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E72861216
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 12:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhIOMQP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbhIOMQO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Sep 2021 08:16:14 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D137EC061574
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2021 05:14:55 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 93so1699830qva.7
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2021 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=el5F29coJF6fWCFEVyY7xZ06GD++xysH+fSG+s36kCM=;
        b=Dw30kQctuY81JXVNvZ+NZOXAvQgPgX1El8d27nG5Vz534rKD8sMyBdixpUREhAek3W
         y4op22pvz2RC4eNMDjYdlOOQdFIQFETNFuydLLGAUVLA/peS+k5KJHG3WCXAHyujPaz5
         p+PlxBzk2/5NYud/2TK8UIMc6HWG7fy7/crXqeUTz6gjpkwka9vVsQL2/L7EVIc1arZ5
         /v1p+lWBBrMlanIIj66aMNrlYnZkwQPI+6oWW6wl99Vr1K3o9ouu7DAB0UftlAFFpe3I
         6YH/yVWs2IFDSOToNLn4nzFvaJPs0mDGkWaBCg1SDTbbi+7BOXVgQa1aAEWCVPNvdj7a
         G3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=el5F29coJF6fWCFEVyY7xZ06GD++xysH+fSG+s36kCM=;
        b=P3BXAtEkv23jUm+pHnJfZRQo8Kf9Dy2623pNEd7kAMZcqUNnAaLx+m5Cwz6EmSHO80
         qXgTYVpRkv2c7tp36RsjKdbxCT9QGIecD/Zz5MXPx1TW+5pXXle6cvZd/X62hGXk0/Ey
         xjxeFBnXMfV5cJjlOwqkANILVD0OhyuIiuv0gg2RGecq4+S/+3yMeRUOcsh1TQuc+leF
         1i3qYLwRjkJV3eAP0e/d3AYJi+11BX3pf6RpvihXK1Zc0audQ7SDtdMU4dwbMBWlN3SY
         EkXQHDqr1K9S27ObVfaeU6Hh4wqVFrHtrbw+JJ7GE+oMifpYGxuPbeQgywqFaibFWDj/
         gRzg==
X-Gm-Message-State: AOAM530Orf3z/2p6zV2JmX7usbVOOid+t/bm1QvdNFwgCGe3Ct3LqdMp
        +us2iLoaeXva19HEJEIwir/T7OmK8uE=
X-Google-Smtp-Source: ABdhPJxzu0eSOrqAUzOwiTnOtzA5IiCtUPfO9IQWWSRgVUednJH8vozYuDbzrAm8kWX0CGt4K2FcGQ==
X-Received: by 2002:ad4:474a:: with SMTP id c10mr10572658qvx.54.1631708094910;
        Wed, 15 Sep 2021 05:14:54 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id 9sm7768466qtz.83.2021.09.15.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:14:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Remove self.__err_sleep
Date:   Wed, 15 Sep 2021 08:14:32 -0400
Message-Id: <20210915121432.5472-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915121432.5472-1-jkacur@redhat.com>
References: <20210915121432.5472-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

commit 5ed68ae77ec05786aab99fbed35d0347a5d25997
changed the code to exit gracefully if hackbench failed from memory
errors. No attempt is made anymore to wait to see if memory pressures
ease. The variable __err_sleep however was not removed at the time.
Remove it now, as it is now longer used.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/hackbench.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index 8119d50f626a..2fb90c1946a5 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -97,7 +97,6 @@ class Hackbench(CommandLineLoad):
                      '-l', str(self._cfg.setdefault('loops', '1000')),
                      '-s', str(self._cfg.setdefault('datasize', '1000'))
                      ]
-        self.__err_sleep = 5.0
 
     def _WorkloadBuild(self):
         # Nothing to build, so we're basically ready
-- 
2.31.1

