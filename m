Return-Path: <SRS0=T8Iz=VW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C11C76186
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Jul 2019 02:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6C02238C
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Jul 2019 02:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389360AbfGYCtY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 24 Jul 2019 22:49:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388165AbfGYCtX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 24 Jul 2019 22:49:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACB42330272;
        Thu, 25 Jul 2019 02:49:23 +0000 (UTC)
Received: from hp-z230.usersys.redhat.com (dhcp-14-103.nay.redhat.com [10.66.14.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 192AD1001B07;
        Thu, 25 Jul 2019 02:49:18 +0000 (UTC)
From:   Qiao Zhao <qzhao@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@gmail.com, williams@redhat.com, Qiao Zhao <qzhao@redhat.com>
Subject: [PATCH] ptsematest, sigwaittest, pmqtest, svsematest reprot error "Could not access /sys/kernel/debug/tracing/tracing_enabled"
Date:   Thu, 25 Jul 2019 10:49:15 +0800
Message-Id: <20190725024915.11497-1-qzhao@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 25 Jul 2019 02:49:23 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

For current RHEL7 and RHEL8 kernel (3.10.0 and 4.18.0), we use "tracing_on"
to control tracing disable/enable. The "tracing_enabled" is not the
current value.

For RHEL bug: https://bugzilla.redhat.com/show_bug.cgi?id=1731336
E.g: # # svsematest -a -b 20us -f -i 100 -l 100 -S
...
Could not access /sys/kernel/debug/tracing/tracing_enabled

Sanity test passed. No this error msg when patched.

Signed-off-by: Qiao Zhao <qzhao@redhat.com>
---
 src/pmqtest/pmqtest.c         | 2 +-
 src/ptsematest/ptsematest.c   | 2 +-
 src/sigwaittest/sigwaittest.c | 2 +-
 src/svsematest/svsematest.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 2191710..a04fc49 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -204,7 +204,7 @@ void *pmqthread(void *param)
 				char tracing_enabled_file[MAX_PATH];
 
 				strcpy(tracing_enabled_file, get_debugfileprefix());
-				strcat(tracing_enabled_file, "tracing_enabled");
+				strcat(tracing_enabled_file, "tracing_on");
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index e8a3177..5537592 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -131,7 +131,7 @@ void *semathread(void *param)
 				char tracing_enabled_file[MAX_PATH];
 
 				strcpy(tracing_enabled_file, get_debugfileprefix());
-				strcat(tracing_enabled_file, "tracing_enabled");
+				strcat(tracing_enabled_file, "tracing_on");
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 4579f90..59f28a5 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -179,7 +179,7 @@ void *semathread(void *param)
 				char tracing_enabled_file[MAX_PATH];
 
 				strcpy(tracing_enabled_file, get_debugfileprefix());
-				strcat(tracing_enabled_file, "tracing_enabled");
+				strcat(tracing_enabled_file, "tracing_on");
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 01083d1..8f88078 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -185,7 +185,7 @@ void *semathread(void *param)
 				char tracing_enabled_file[MAX_PATH];
 
 				strcpy(tracing_enabled_file, get_debugfileprefix());
-				strcat(tracing_enabled_file, "tracing_enabled");
+				strcat(tracing_enabled_file, "tracing_on");
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
-- 
2.20.1

