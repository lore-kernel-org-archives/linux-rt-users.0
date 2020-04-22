Return-Path: <SRS0=xzyi=6G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C304C2BA19
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Apr 2020 02:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459C3206D4
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Apr 2020 02:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDVCUE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:20:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbgDVCUE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Apr 2020 22:20:04 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 675ABDCF49C296C38C93;
        Wed, 22 Apr 2020 10:20:01 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 10:19:52 +0800
To:     <linux-rt-users@vger.kernel.org>, <williams@redhat.com>,
        <jkacur@redhat.com>
CC:     <hushiyuan@huawei.com>, <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] rt-tests: cyclictest: Fix -a option fail when max_cpus is
 more
Message-ID: <a56715d8-efbc-3104-11d3-47014fa1c5f9@huawei.com>
Date:   Wed, 22 Apr 2020 10:19:52 +0800
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

An Error occurs when run: ./cyclictest -v -t 5 -p 80 -i 1000 -a 3

  parse_cpumask: Using 0 cpus.
  Max CPUs = 96
  WARN: Couldn't setaffinity in main thread: Invalid argument
  # /dev/cpu_dma_latency set to 0us
  FATAL: No allowable cpus to run on

We find that numa_bitmask_alloc() is used incorrectly in
use_current_cpuset(), it should pass the number of cpus as parameters,
not the sizeof(struct bitmask), which is only 8 bytes.

The syscall sched_getaffinity will check the parameters, if using
sizeof(struct bitmask), it will fail when cpus is more:

  SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
                unsigned long __user *, user_mask_ptr)
  {
        int ret;
        cpumask_var_t mask;

        if ((len * BITS_PER_BYTE) < nr_cpu_ids)
                return -EINVAL;

Fix it by passing max_cpus as parameters to numa_bitmask_alloc().

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c5f1fd46567a..989113fb3483 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1135,7 +1135,7 @@ static void use_current_cpuset(const int max_cpus)

 	pid = getpid();

-	curmask = numa_bitmask_alloc(sizeof(struct bitmask));
+	curmask = numa_bitmask_alloc(max_cpus);
 	numa_sched_getaffinity(pid, curmask);

 	/* Clear bits that are not set in both the cpuset from the environment,
-- 
1.8.3.1


