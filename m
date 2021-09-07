Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960D1C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Sep 2021 15:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC3361132
	for <linux-rt-users@archiver.kernel.org>; Tue,  7 Sep 2021 15:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhIGPQk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345070AbhIGPQj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Sep 2021 11:16:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D1BE61107;
        Tue,  7 Sep 2021 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631027733;
        bh=Ea6i7nuMuxo3nuep6k3/uS6l/jmabdXQI6pMdAahtL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ffKmvK3wBprZET4qTUhh03G1E3cAf1H157JybTYOQC1b9RvN1zuCmjlk0mLZAbG1G
         M70zYMMgr+417YC4BSLX4lB6w8hFwZBhQjVQp1Ec/IDE0K3v2gn3j/vyqYhGK2Rkal
         WZdHkuu5+0EGtL+OH33Eb7ZZ1v3zrEs6RmIFeaMzjYVQK2pAk7wscCO5lfSNO1r1SA
         Chd34hjt0ForzdkRbWeNXLdc3Qla7HayKJJ1QK4JGP9kbMLrLQIEX8oobHlKi1HueD
         yFCNM6sUqwhzB0Sj3MZRHEgvbcwwPSSjZ6qEK/WtV1kur+YLzNPFvP/dGiKB6ghF4G
         tK0JyD3NYMg3A==
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Cc:     Gregor Beck <gbeck@esigma-technology.com>,
        Gregor Beck <gregor.beck@gmail.com>
Subject: [PATCH RT 2/3] fscache: fix initialisation of cookie hash table raw spinlocks
Date:   Tue,  7 Sep 2021 10:15:28 -0500
Message-Id: <b0d883b82b275ffe9aa0c9e3ca7960377e78c06e.1631027711.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1631027711.git.zanussi@kernel.org>
References: <cover.1631027711.git.zanussi@kernel.org>
In-Reply-To: <cover.1631027711.git.zanussi@kernel.org>
References: <cover.1631027711.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Gregor Beck <gbeck@esigma-technology.com>

v5.4.143-rt64-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


The original patch, 602660600bcd ("fscache: initialize cookie hash
table raw spinlocks"), subtracted 1 from the shift and so still left
some spinlocks uninitialized.  This fixes that.

[zanussi: Added changelog text]

Signed-off-by: Gregor Beck <gregor.beck@gmail.com>
Fixes: 602660600bcd ("fscache: initialize cookie hash table raw spinlocks")
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 fs/fscache/cookie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 5508d92e3f8f..cba2a226897f 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -963,6 +963,6 @@ void __init fscache_cookie_init(void)
 {
 	int i;
 
-	for (i = 0; i < (1 << fscache_cookie_hash_shift) - 1; i++)
+	for (i = 0; i < ARRAY_SIZE(fscache_cookie_hash); i++)
 		INIT_HLIST_BL_HEAD(&fscache_cookie_hash[i]);
 }
-- 
2.17.1

