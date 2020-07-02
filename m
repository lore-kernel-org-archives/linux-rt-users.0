Return-Path: <SRS0=9hME=AN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E03C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Jul 2020 01:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC61220748
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Jul 2020 01:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgGBB2g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:28:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7331 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbgGBB2f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Jul 2020 21:28:35 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 420684F2D42DF4C68D6D;
        Thu,  2 Jul 2020 09:26:04 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.233) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Jul 2020
 09:25:53 +0800
Subject: Re: [PATCH] rt-tests: cyclictest: add '\n' symbol for printf in
 rstat_shm_open()
To:     John Kacur <jkacur@redhat.com>
CC:     <williams@redhat.com>, <linux-rt-users@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <b5d8bafb-6bd2-7fec-2f78-86c6d2508408@huawei.com>
 <alpine.LFD.2.21.2007011137180.7008@planxty>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <e56fa215-ec8c-ecef-e4e4-019446eba516@huawei.com>
Date:   Thu, 2 Jul 2020 09:25:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.2007011137180.7008@planxty>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.233]
X-CFilter-Loop: Reflected
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 2020/7/1 23:38, John Kacur wrote:
> 
> 
> On Sat, 20 Jun 2020, Yunfeng Ye wrote:
> 
>> The infomation "pid = xxx" is printed with other infomation on the same
>> line. so add '\n' symbol for printf in rstat_shm_open().
>>
>> Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
>> ---
>>  src/cyclictest/cyclictest.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
>> index b3d72caa10ce..d1c148563dad 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -1910,7 +1910,7 @@ static int rstat_shm_open(void)
>>  	pid_t pid;
>>
>>  	pid = getpid();
>> -	printf("pid = %d", pid);
>> +	printf("pid = %d\n", pid);
>>
>>  	snprintf(shm_name, SHM_BUF_SIZE, "%s%d", "/cyclictest", pid);
>>
>> -- 
>> 1.8.3.1
>>
>>
> oops, that looks like my debug code that I forgot to remove. Do you want 
> to send a patch removing that line?
> 
ok, I will send a patch v2, thanks.

> Thanks
> 
> John Kacur
> 
> 

