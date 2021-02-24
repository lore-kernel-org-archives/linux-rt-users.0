Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A38AC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 02:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AB964E85
	for <linux-rt-users@archiver.kernel.org>; Wed, 24 Feb 2021 02:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhBXCS4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 21:18:56 -0500
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:50316 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBXCSz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 21:18:55 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 11O2GSE3020206; Wed, 24 Feb 2021 11:16:28 +0900
X-Iguazu-Qid: 2wGr679RacmOwlrMqD
X-Iguazu-QSIG: v=2; s=0; t=1614132988; q=2wGr679RacmOwlrMqD; m=oZ2QbQkxlmLWr3HpH/erZTexbYTC2qt5l4hfRuiLREM=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 11O2GRCr040595
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Feb 2021 11:16:27 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 5598D1000B1;
        Wed, 24 Feb 2021 11:16:27 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 11O2GQ5v008879;
        Wed, 24 Feb 2021 11:16:27 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, dwagner@suse.de,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [rteval PATCH v2 2/3] rteval: cyclictest.py: Make build targets architecture independent
Date:   Wed, 24 Feb 2021 11:16:02 +0900
X-TSB-HOP: ON
Message-Id: <20210224021603.446274-3-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210224021603.446274-1-punit1.agrawal@toshiba.co.jp>
References: <20210224021603.446274-1-punit1.agrawal@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Not all kernel archiectures provide the "bzImage" target, e.g., arm64
provides "Image" which generates an uncompressed kernel binary.

Instead of going down the path of customizing build targets
per-architecture, let's drop them altogether. The default kernel
target should build the kernel and modules on all architectures
anyways.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/modules/loads/kcompile.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 326f1ae..e747b9f 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -58,7 +58,7 @@ class KBuildJob:
         else:
             self.jobs = self.calc_jobs_per_cpu() * len(self.node)
         self.log(Log.DEBUG, "node %d: jobs == %d" % (int(node), self.jobs))
-        self.runcmd = "%s make O=%s -C %s -j%d bzImage modules" \
+        self.runcmd = "%s make O=%s -C %s -j%d" \
                 % (self.binder, self.objdir, self.kdir, self.jobs)
         self.cleancmd = "%s make O=%s -C %s clean allmodconfig" \
                 % (self.binder, self.objdir, self.kdir)
-- 
2.30.0

