Return-Path: <SRS0=QXCx=WE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D61C433FF
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B42E2184E
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Aug 2019 19:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565294072;
	bh=3qYlaQUl4rjpzfZVaXqFO7psBcZvQ5hQeGTgLfxda/s=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=YnjirnCd5y31PQLLwLf40cOPzsrKdynA3Y5SADU0Ol3ip9DHo5G4ThVwHBd4N0R1K
	 fI3G5WXRKQmuV1P3x28+zv/pWZ+J0dxFDsACHrbi9s1ndfMdGMq6YPP5zLIpOrlmWd
	 mPsOQusoqhpJvXnZzRE9Di5C3XIxSJaCT/A/bIVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403985AbfHHTy3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404391AbfHHTxP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:15 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676312189F;
        Thu,  8 Aug 2019 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565293994;
        bh=3qYlaQUl4rjpzfZVaXqFO7psBcZvQ5hQeGTgLfxda/s=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CUtpfZxplnU3Bc0I0mg45vDPMoIX/tZNqviM2fOtcgdD/zio45rwhROxQBAPjO3+W
         ZQZgFXnbhweeaK3PTeFSuT3nr1jAjLwH7YtUdf1W6WoTQaRoB2+GOIe/KenAW/FWxs
         p5LrzwKxFjibPlPZYWuxW34b+Q+Lg7dEa5O3mgm0=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 05/19] locking/rwsem: Rename rwsem_rt.h to rwsem-rt.h
Date:   Thu,  8 Aug 2019 14:52:33 -0500
Message-Id: <413840eba0b87756a0bd16b05d4f3ee52f7793ff.1565293934.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
In-Reply-To: <cover.1565293934.git.zanussi@kernel.org>
References: <cover.1565293934.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.137-rt65-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit fc7a6bdcce83ce162c32d991f0ac8e56ea260f5b ]

Rename rwsem_rt.h to rwsem-rt.h to remain consistent with rwsem-rt.c.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/{rwsem_rt.h => rwsem-rt.h} | 0
 include/linux/rwsem.h                    | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{rwsem_rt.h => rwsem-rt.h} (100%)

diff --git a/include/linux/rwsem_rt.h b/include/linux/rwsem-rt.h
similarity index 100%
rename from include/linux/rwsem_rt.h
rename to include/linux/rwsem-rt.h
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 513df11a364e..ac0857d60e04 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -21,7 +21,7 @@
 #endif
 
 #ifdef CONFIG_PREEMPT_RT_FULL
-#include <linux/rwsem_rt.h>
+#include <linux/rwsem-rt.h>
 #else /* PREEMPT_RT_FULL */
 
 struct rw_semaphore;
-- 
2.14.1

