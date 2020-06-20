Return-Path: <SRS0=Kj7U=AB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F60C433DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Jun 2020 02:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A80422DD3
	for <linux-rt-users@archiver.kernel.org>; Sat, 20 Jun 2020 02:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgFTCpL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Jun 2020 22:45:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6365 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732006AbgFTCpL (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Jun 2020 22:45:11 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B9B84C6F9FB3B032F19;
        Sat, 20 Jun 2020 10:45:06 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 10:44:59 +0800
To:     <williams@redhat.com>, <jkacur@redhat.com>,
        <linux-rt-users@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] rt-tests: cyclictest: add '\n' symbol for printf in
 rstat_shm_open()
Message-ID: <b5d8bafb-6bd2-7fec-2f78-86c6d2508408@huawei.com>
Date:   Sat, 20 Jun 2020 10:44:48 +0800
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

The infomation "pid = xxx" is printed with other infomation on the same
line. so add '\n' symbol for printf in rstat_shm_open().

Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b3d72caa10ce..d1c148563dad 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1910,7 +1910,7 @@ static int rstat_shm_open(void)
 	pid_t pid;

 	pid = getpid();
-	printf("pid = %d", pid);
+	printf("pid = %d\n", pid);

 	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);

-- 
1.8.3.1

