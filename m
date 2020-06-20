Return-Path: <SRS0=Kj7U=AB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA18C433DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Jun 2020 01:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B349922D02
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Jun 2020 01:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgFTBsU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:48:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731502AbgFTBsU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jun 2020 21:48:20 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CE00943EC51CCC8F15C;
        Sat, 20 Jun 2020 09:48:18 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 09:48:08 +0800
To:     <williams@redhat.com>, <jkacur@redhat.com>
CC:     <linux-rt-users@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] rt-tests: cyclictest: try not to share the same cpu with main
 thread
Message-ID: <60c13be0-76ad-5d95-f8d5-124cb13d0561@huawei.com>
Date:   Sat, 20 Jun 2020 09:48:07 +0800
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

The main thread will interfere with the test thread and try not to share
the same CPU with the main thread when the number of thread is less than
max_cpus.

Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
---
 src/cyclictest/cyclictest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 989113fb3483..b3d72caa10ce 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1080,7 +1080,8 @@ static int cpu_for_thread_sp(int thread_num, int max_cpus)
 		fatal("No allowable cpus to run on\n");
 	}

-	m = thread_num % num_cpus;
+	/* just don't try to share the same cpu with main thread */
+	m = (thread_num + 1) % num_cpus;

 	/* there are num_cpus bits set, we want position of m'th one */
 	for (i = 0, cpu = 0; i < max_cpus; i++) {
-- 
1.8.3.1

