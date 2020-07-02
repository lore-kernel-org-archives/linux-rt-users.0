Return-Path: <SRS0=9hME=AN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8CBC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Jul 2020 02:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C120207D4
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Jul 2020 02:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGBCWm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:22:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbgGBCWm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Jul 2020 22:22:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C24CE834E69466550C04;
        Thu,  2 Jul 2020 10:22:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.233) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Jul 2020
 10:22:22 +0800
To:     <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
        <linux-rt-users@vger.kernel.org>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v2] rt-tests: cyclictest: remove the debug log "pid = xxx" in
 rstat_shm_open()
Message-ID: <62b7d30b-14ce-b340-a6f7-cf6abcf3a6f9@huawei.com>
Date:   Thu, 2 Jul 2020 10:22:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.233]
X-CFilter-Loop: Reflected
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The infomation "pid = xxx" is printed with other infomation on the same
line. so remove this debug log in rstat_shm_open().

Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
---
v1 -> v2:
 - remove the debug code

 src/cyclictest/cyclictest.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b3d72caa10ce..8353f561bb46 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1910,7 +1910,6 @@ static int rstat_shm_open(void)
 	pid_t pid;

 	pid = getpid();
-	printf("pid = %d", pid);

 	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);

-- 
1.8.3.1

