Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5B2C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 04:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F8822D04
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 04:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbhAZE5V (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:57:21 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:33460 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731123AbhAZCPN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 25 Jan 2021 21:15:13 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 10Q2D0NS029810; Tue, 26 Jan 2021 11:13:00 +0900
X-Iguazu-Qid: 2wGqsXjpvkITz1WMGP
X-Iguazu-QSIG: v=2; s=0; t=1611627180; q=2wGqsXjpvkITz1WMGP; m=vyg8k9zZb0miu6Vn8e+3q+aHkYq6SrsYX3700/l++kk=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1113) id 10Q2Cxq4039282;
        Tue, 26 Jan 2021 11:12:59 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 10Q2CxpA004441;
        Tue, 26 Jan 2021 11:12:59 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 10Q2CwwY024233;
        Tue, 26 Jan 2021 11:12:58 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, dwagner@suse.de,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [rteval PATCH 1/2] rteval: cyclictest.py: Make 'model name' optional
Date:   Tue, 26 Jan 2021 11:12:40 +0900
X-TSB-HOP: ON
Message-Id: <20210126021241.112944-2-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp>
References: <20210126021241.112944-1-punit1.agrawal@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Certain architectures such as arm64 don't have a "model name" in
/proc/cpuinfo. Relax the requirement to include the model name in the
description to allow running rteval on such machines.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/modules/measurement/cyclictest.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 232bd6b..afe87f7 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -217,13 +217,13 @@ class Cyclictest(rtevalModulePrototype):
         for core in self.__cpus:
             self.__cyclicdata[core] = RunData(core, 'core', self.__priority,
                                               logfnc=self._log)
-            self.__cyclicdata[core].description = info[core]['model name']
+            self.__cyclicdata[core].description = info[core].get('model name', '')
 
         # Create a RunData object for the overall system
         self.__cyclicdata['system'] = RunData('system',
                                               'system', self.__priority,
                                               logfnc=self._log)
-        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0']['model name']
+        self.__cyclicdata['system'].description = ("(%d cores) " % self.__numcores) + info['0'].get('model name', '')
 
         if self.__sparse:
             self._log(Log.DEBUG, "system using %d cpu cores" % self.__numcores)
-- 
2.29.2

