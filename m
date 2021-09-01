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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55CDC4320E
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBBA46103D
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbhIAIJt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 04:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242858AbhIAIJs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Sep 2021 04:09:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD91C061575
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Sep 2021 01:08:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l3so1325773pji.5
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Sep 2021 01:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=up77ZZbcePUbHPIu931P2Nm3xBICe9exuO8Iknuq9fg=;
        b=uqThbocQKxVnADfgx1MuWXQbtD25JGO6N/p/10dbKXgxzpzGlniUsCkNM2jxvfh32B
         197VXfL7Eyhju4QOUgGw6PwIA3OjhHS6XU1yb/xKuMlIB4WNIfZBx5uUqs+ItKn9vFOo
         IUFqXQ52wAxdHHk5gu2McHnk/MtN77ry4MEo42BMLCqPjuwGXKHjT2RsW8w3mmbMmzjS
         gNUoVOYNspAExzcG6LrYMDjMOoXhjTehrFqo1/+e5IOnm5Uou7AybfxqnAVRR1+R/gFo
         yXFrtjzwEGiMTl51iBbUqE+oqpjdnA97xx6YlLETe0ufoGaU04hcOuTxFSnu3N4q8Zr4
         NvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=up77ZZbcePUbHPIu931P2Nm3xBICe9exuO8Iknuq9fg=;
        b=fmXSiz9zfLklrI0HMC1s+qup3EkPPDzni0gcAmRs43SWUUXm5fRuU6tOZ6HBfZ5acx
         l6Yi2RWAJ5yWv7icCjRmjiExJRaQkNvRHttjk+5ZosvnpnbNXA8Yb880BHeApsbf+Iy8
         IdO1mAQ+wOexN2DtVaih10vl8zNIud4kh+IBrPxcghP/GLzvIgzF1+vQxoDz7s1GTsWd
         5csHhDarukeK8jrQ6kD1Sq9dY6sXmVd13KHk5CEDOxFPqQo69JPSoauDNKYHkosrKrFV
         DuxcBvoXJ6iOlhfMNz9WncP4OIcmEPS0hEs6jASdSv1dA9Th+Af00l5/n0idzVn91xdt
         dsbQ==
X-Gm-Message-State: AOAM533x/noP98GSM/lzGXWD8OOudwpQ6jKiO8t6ndO+U63UAdLzkE8o
        NcvG2nEi4nhXqCV9AsNhpTWgpP8uDIs=
X-Google-Smtp-Source: ABdhPJzUO/g+cMSHKzYwB6X1WYHfxb+2xyO9SfIQn2ZSvY0BYYouOIyrBS37igYdqUW3u/Fwg2TKiw==
X-Received: by 2002:a17:90a:4418:: with SMTP id s24mr10503759pjg.222.1630483731530;
        Wed, 01 Sep 2021 01:08:51 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id g4sm5268254pjt.56.2021.09.01.01.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 01:08:51 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     punit1.agrawal@toshiba.co.jp,
        Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 5/5] rteval: kcompile.py: Gracefully handle missing affinity information
Date:   Wed,  1 Sep 2021 17:08:16 +0900
Message-Id: <20210901080816.721731-6-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210901080816.721731-1-punitagrawal@gmail.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

kcompile either sets the affinity of the workload threads to a user
specified list of cpus (using taskset) or binds the threads to the
local numa node (using numactl). In the absence of both the following
hard to parse error is thrown -

    Exception in thread kcompile:
    Traceback (most recent call last):
    ...
      File "...rteval/rteval/modules/loads/kcompile.py", line 55, in __init__
	self.binder = 'taskset -c %s' % compress_cpulist(cpulist)
      File "...rteval/rteval/misc.py", line 62, in compress_cpulist
	if isinstance(cpulist[0], int):
    TypeError: 'NoneType' object is not subscriptable

Instead, add a warning to report the missing affinity information /
tools and continue executing the workload with no affinity - relying
on the affinity settings being set by the kernel.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/modules/loads/kcompile.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index d1955c7aee3d..5c83b78525e5 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -51,8 +51,12 @@ class KBuildJob:
             os.mkdir(self.objdir)
         if os.path.exists('/usr/bin/numactl') and not cpulist:
             self.binder = 'numactl --cpunodebind %d' % int(self.node)
-        else:
+        elif cpulist is not None:
             self.binder = 'taskset -c %s' % compress_cpulist(cpulist)
+        else:
+            self.log(Log.WARN, 'Unable to set job affinity - please install "numactl" or pass "cpulist"')
+            self.log(Log.WARN, 'Running with default OS decided affinity')
+            self.binder = ''
         if cpulist:
             self.jobs = self.calc_jobs_per_cpu() * len(cpulist)
         else:
-- 
2.32.0

