Return-Path: <SRS0=9hME=AN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A808EC433DF
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Jul 2020 01:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81645207D4
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Jul 2020 01:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGBBp5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:45:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727957AbgGBBp4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Jul 2020 21:45:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 55C3BCD40BE6809E4BDB;
        Thu,  2 Jul 2020 09:45:55 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.233) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Jul 2020
 09:45:45 +0800
Subject: Re: [PATCH] rt-tests: cyclictest: try not to share the same cpu with
 main thread
To:     John Kacur <jkacur@redhat.com>
CC:     <williams@redhat.com>, <linux-rt-users@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <60c13be0-76ad-5d95-f8d5-124cb13d0561@huawei.com>
 <alpine.LFD.2.21.2007011145320.7008@planxty>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <7e4a5fad-1640-c3fd-0491-60b57a449eb1@huawei.com>
Date:   Thu, 2 Jul 2020 09:45:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.2007011145320.7008@planxty>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.233]
X-CFilter-Loop: Reflected
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 2020/7/2 0:24, John Kacur wrote:
> <
> 
> On Sat, 20 Jun 2020, Yunfeng Ye wrote:
> 
>> The main thread will interfere with the test thread and try not to share
>> the same CPU with the main thread when the number of thread is less than
>> max_cpus.
>>
>> Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
>> ---
>>  src/cyclictest/cyclictest.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
>> index 989113fb3483..b3d72caa10ce 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -1080,7 +1080,8 @@ static int cpu_for_thread_sp(int thread_num, int max_cpus)
>>  		fatal("No allowable cpus to run on\n");
>>  	}
>>
>> -	m = thread_num % num_cpus;
>> +	/* just don't try to share the same cpu with main thread */
>> +	m = (thread_num + 1) % num_cpus;
>>
>>  	/* there are num_cpus bits set, we want position of m'th one */
>>  	for (i = 0, cpu = 0; i < max_cpus; i++) {
>> -- 
>> 1.8.3.1
>>
>>
> I'm not sure about this one. It would work, but the purpose of the test is 
> to make sure we get good real-time results despite the other threads. Plus 
> we have done it this way for so long, and tools might expect things to 
> work this way. I'm inclined not to take this, even though your idea is 
> correct, although note that you didn't apply it everywhere it would be 
> needed.
> 
I think the cyclictest can use not only for rt-linux, but also for gp-linux
(General Purpose Linux) with isolation (for example, isolcpus, nohz_full,
and bind irq affinity to non isolation cpus, also deploy real-time application
with many constraints). In this situation, this path will work good. thanks.

> Thanks
> 
> John
> 
> 

