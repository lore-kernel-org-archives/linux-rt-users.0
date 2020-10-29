Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC9BC55179
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4472076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIIPE3Wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgJ2RlT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgJ2RlR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:17 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D6C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:16 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id i7so2364072qti.6
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXu3PfrX/DTaVcn8thcSEL8HLfqJ0w3SnZL0jimNThw=;
        b=EIIPE3WzD3o7tpu0YnRP5W89X/NlZDRpDj4OBP+G6kv/B8gsUPy7clOdEBeZ7CoGhn
         XwQQ6ru0uehbUpZB1qWHM65UhCYUemhRlpRADP3XzV3KRhbu6JeLcyr1Gw3IcoHTux2S
         BZbbE8vu3uAkdbqx9XyElHmUick5t4uqNNGhvqxNcaYMIzpPjibyG7o5vERRg5umLuNh
         auW0EzH8Zul64yRU0UA+BZz7GwR5AfBTUHaqS/r3kjmVvAuXnQDnByMCa7t84nb9Y8An
         BLiAI5XzPR5suKkZey5vIkactSwa+xv9su9tV7Pc77j9H8/+L3m7lPbcRS/7MD0pC13Y
         Rkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QXu3PfrX/DTaVcn8thcSEL8HLfqJ0w3SnZL0jimNThw=;
        b=NhdpVnXSK7/GSWnmoJjPPqQ8M4u5eHDyWcQSL82Jmdh8ikFLumBTRAls2jFLN+CP9e
         ZBg56eRcoUVmv9MD1TSKFucHoxTgFfVNgs1vEekm5/3TVwFtpvi8nlQtVrXFVbzKvRyl
         9al+ozn9FA6D9fuhEM+Aw/VXYQM1iZxU6e8+7W54feXCp9ExX/eN5+mdPPqr/6OaazsY
         L1msLooVT9tWVdTYqQTkXOnSZSftQV5jDxFlKZ92qVR5VnINj49Q0+VApli7GH1rchVN
         uJoOr6SpcPP4GKcn6QTeY/DILJWdwdkBZGbCz8ThinR8MjG7vucNgPD9TivW++DPUjjI
         VGyA==
X-Gm-Message-State: AOAM531lHtrzcOEYWZ+OQklqHbDWFC0XNcq3n6ngn51N1hJVI01t9U+v
        k1Gju4fHE89GEkKIvXWA3SD6BxBWM9CNeQ==
X-Google-Smtp-Source: ABdhPJyN1FeRpGezlG+SRvXsyKfT47x0+Pq4mQap0nDycLPiSL+JnX0//8u1Md/3zNXYUj8lRhOBTg==
X-Received: by 2002:ac8:4b79:: with SMTP id g25mr4750237qts.19.1603993275342;
        Thu, 29 Oct 2020 10:41:15 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:14 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 03/16] rt-tests: rt-sched.c: Style change
Date:   Thu, 29 Oct 2020 13:40:44 -0400
Message-Id: <20201029174057.20033-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Style change from checkpatch.pl

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/lib/rt-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/rt-sched.c b/src/lib/rt-sched.c
index 2aaf02d42aee..8023bc70c473 100644
--- a/src/lib/rt-sched.c
+++ b/src/lib/rt-sched.c
@@ -26,5 +26,5 @@ int sched_getattr(pid_t pid,
 		  unsigned int size,
 		  unsigned int flags)
 {
-        return syscall(__NR_sched_getattr, pid, attr, size, flags);
+	return syscall(__NR_sched_getattr, pid, attr, size, flags);
 }
-- 
2.26.2

