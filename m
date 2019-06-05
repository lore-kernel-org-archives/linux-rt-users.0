Return-Path: <SRS0=TVKX=UE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A26C46470
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD7920870
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jun 2019 16:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfFEQGb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:06:31 -0400
Received: from mail.monom.org ([188.138.9.77]:35590 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfFEQGb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jun 2019 12:06:31 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 5DC9D500535;
        Wed,  5 Jun 2019 18:06:29 +0200 (CEST)
Received: from localhost (ppp-93-104-174-142.dynamic.mnet-online.de [93.104.174.142])
        by mail.monom.org (Postfix) with ESMTPSA id 20ED55004BB;
        Wed,  5 Jun 2019 18:06:28 +0200 (CEST)
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: [PATCH v2 01/12] rt_numa.h: Remove unused function
Date:   Wed,  5 Jun 2019 18:06:06 +0200
Message-Id: <20190605160617.22987-2-wagi@monom.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605160617.22987-1-wagi@monom.org>
References: <20190605160617.22987-1-wagi@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Daniel Wagner <daniel.wagner@siemens.com>

GCC on a BeagleBoneBlack complains:

In file included from src/cyclictest/cyclictest.c:39:0:
src/cyclictest/rt_numa.h:253:13: warning: ‘numa_on_and_available’ defined but not used [-Wunused-function]
 static void numa_on_and_available()
             ^~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---
 src/cyclictest/rt_numa.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index e8cd7f481baa..e0f4b2e9d8b2 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -249,13 +249,6 @@ static inline void rt_bitmask_free(struct bitmask *mask)
 	free(mask);
 }
 
-
-static void numa_on_and_available()
-{
-	if (numa) /* NUMA is not defined here */
-		fatal("numa mode and numa functions not available.\n");
-}
-
 #endif	/* NUMA */
 
 /*
-- 
2.20.1
