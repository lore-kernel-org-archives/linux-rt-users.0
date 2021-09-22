Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C301EC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 17:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A155661131
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 17:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhIVRZ2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:25:28 -0400
Received: from mo-csw-fb1114.securemx.jp ([210.130.202.173]:59158 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhIVRZ1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 13:25:27 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Sep 2021 13:25:27 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1114) id 18MHHNe2020229; Thu, 23 Sep 2021 02:17:23 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 18MHHLwr003997; Thu, 23 Sep 2021 02:17:21 +0900
X-Iguazu-Qid: 2wHHPNX9ay9DWLBYqe
X-Iguazu-QSIG: v=2; s=0; t=1632331041; q=2wHHPNX9ay9DWLBYqe; m=6pHulEwVUkPBjZbZ9imd9fo0d0KDj0ojqTM6yNs+YTM=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1111) id 18MHHLHA019772
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Sep 2021 02:17:21 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 137BB100127
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2021 02:17:21 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 18MHHKbI006967
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2021 02:17:20 +0900
From:   venkata.pyla@toshiba-tsip.com
To:     jkacur@redhat.com
Cc:     venkata pyla <venkata.pyla@toshiba-tsip.com>,
        punit1.agrawal@toshiba.co.jp, daniel.sangorrin@toshiba.co.jp,
        dinesh.kumar@toshiba-tsip.com, linux-rt-users@vger.kernel.org
Subject: [PATCH] rteval: kcompile.py: Relax the requirement for kernel tarball filename
Date:   Wed, 22 Sep 2021 22:47:40 +0530
X-TSB-HOP: ON
Message-Id: <20210922171740.8939-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Sep 2021 17:17:18.0662 (UTC) FILETIME=[B265A660:01D7AFD5]
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The kcompile module includes kernel version when looking for tarballs
or source folders. This necessitates periodically bumping the
kernel_prefix but also requires the user to provide particular version
of the kernel sources when using this workload. As the intent is to
generate a compile workload the source version used shouldn't matter.

To make life easier both for users and developers, relax the
requirement for specific version of kernel sources when using
kcompile.

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 rteval/modules/loads/kcompile.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 8d08a3d..be40a62 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -35,7 +35,7 @@ from rteval.Log import Log
 from rteval.misc import expand_cpulist, compress_cpulist
 from rteval.systopology import SysTopology
 
-kernel_prefix = "linux-5.13"
+kernel_prefix = "linux"
 
 class KBuildJob:
     '''Class to manage a build job bound to a particular node'''
-- 
2.20.1


