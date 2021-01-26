Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96190C433E9
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 04:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5789F22DD6
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 04:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbhAZE6F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:58:05 -0500
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:54604 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbhAZCP4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jan 2021 21:15:56 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 10Q2D4PR018310; Tue, 26 Jan 2021 11:13:04 +0900
X-Iguazu-Qid: 2wGqzdZmcjhCQ0rWSY
X-Iguazu-QSIG: v=2; s=0; t=1611627184; q=2wGqzdZmcjhCQ0rWSY; m=EN3E/StyKwh7erK0+FBUw6KP+jiboSdfwkAQ6hJc3hw=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1112) id 10Q2D26s004792;
        Tue, 26 Jan 2021 11:13:03 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 10Q2D2Yr004469;
        Tue, 26 Jan 2021 11:13:02 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 10Q2D21h024313;
        Tue, 26 Jan 2021 11:13:02 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, dwagner@suse.de,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [rteval PATCH 2/2] rteval: cyclictest.py: Make build targets architecture independent
Date:   Tue, 26 Jan 2021 11:12:41 +0900
X-TSB-HOP: ON
Message-Id: <20210126021241.112944-3-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp>
References: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp>
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
2.29.2

