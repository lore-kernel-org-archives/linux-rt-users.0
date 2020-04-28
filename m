Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3256BC83000
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 07:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1660A206A5
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 07:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgD1HLR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:11:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbgD1HLR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 03:11:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0962517394A83E3EDDE9;
        Tue, 28 Apr 2020 15:11:15 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 15:11:04 +0800
To:     <williams@redhat.com>, <jkacur@redhat.com>,
        <linux-rt-users@vger.kernel.org>, <hushiyuan@huawei.com>,
        <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] rt-tests: hachbench: Update the usage and man page for
 -F|--fifo option
Message-ID: <19489849-88a9-bc3d-38c1-e39c43d80d8d@huawei.com>
Date:   Tue, 28 Apr 2020 15:11:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The commit 6c0c79b5152a ("hackbench mods to work better under stress")
add -F|--fifo option, but not update the usage and man page, so this
patch fix it.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 src/hackbench/hackbench.8 | 6 +++++-
 src/hackbench/hackbench.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/hackbench/hackbench.8 b/src/hackbench/hackbench.8
index d86c52f27a2e..dadf070e1135 100644
--- a/src/hackbench/hackbench.8
+++ b/src/hackbench/hackbench.8
@@ -7,7 +7,7 @@ hackbench \- scheduler benchmark/stress test
 .RI "[\-l|\-\-loops " <num\-loops> "] "
 .RI "[\-g|\-\-groups "<num\-groups> "] "
 .RI "[\-f|\-\-fds <num\-fds>] "
-.RI "[\-T|\-\-threads] [\-P|\-\-process] [\-\-help]"
+.RI "[\-T|\-\-threads] [\-P|\-\-process] [\-F|\-\-fifo] [\-\-help]"

 .SH "DESCRIPTION"
 Hackbench is both a benchmark and a stress test for the Linux kernel
@@ -45,6 +45,10 @@ Each sender/receiver child will be a POSIX thread of the parent.
 .TP
 .B \-P, \-\-process
 Hackbench will use fork() on all children (default behaviour)
+.TP
+.B \-F, \-\-fifo
+Support to change the main thread to a SCHED_FIFO realtime thread
+after creating the workers
 .TP
 .B \-\-help
 .br
diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
index 5a883d341f2e..2cddff654df6 100644
--- a/src/hackbench/hackbench.c
+++ b/src/hackbench/hackbench.c
@@ -92,7 +92,7 @@ static void print_usage_exit()
 {
 	printf("Usage: hackbench [-p|--pipe] [-s|--datasize <bytes>] [-l|--loops <num loops>]\n"
 	       "\t\t [-g|--groups <num groups] [-f|--fds <num fds>]\n"
-	       "\t\t [-T|--threads] [-P|--process] [--help]\n");
+	       "\t\t [-T|--threads] [-P|--process] [-F|--fifo] [--help]\n");
 	exit(1);
 }

-- 
1.8.3.1

