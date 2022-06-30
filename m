Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE0C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jun 2022 01:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiF3BDu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiF3BDt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 21:03:49 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B265720F4E
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 18:03:45 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:48498.623788312
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 84934100237;
        Thu, 30 Jun 2022 09:03:44 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-749df8664c-npclk with ESMTP id d20c4b1cd1d44eec83b22de1ffc2564b for jkacur@redhat.com;
        Thu, 30 Jun 2022 09:03:44 CST
X-Transaction-ID: d20c4b1cd1d44eec83b22de1ffc2564b
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <86fe5644-4deb-dc2b-b99c-be7cfaa26d0b@189.cn>
Date:   Thu, 30 Jun 2022 09:03:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] sched_deadline/cyclicdeadline add tracelimit
Content-Language: en-US
To:     John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
References: <1655448052-12537-1-git-send-email-chensong_2000@189.cn>
 <20220629065848.zpppngaem7qqazzf@beryllium.lan>
 <8d2bbda3-492-a5c9-4efc-722bddbc7bf6@redhat.com>
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <8d2bbda3-492-a5c9-4efc-722bddbc7bf6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

在 2022/6/29 23:34, John Kacur 写道:
> 
> 
> On Wed, 29 Jun 2022, Daniel Wagner wrote:
> 
>> Hi,
>>
>> On Fri, Jun 17, 2022 at 02:40:52PM +0800, Song Chen wrote:
>>>   static void usage(int error)
>>> @@ -689,6 +697,7 @@ static void usage(int error)
>>>   	       "                           (default 500us).\n"
>>>   	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
>>>   	       "-q       --quiet           print a summary only on exit\n"
>>> +	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
>>
>> Please also consider to update the man pages.
> 
> @Song Chen, You can send that as an extra patch, but this is a good point,
> please update the man page as well.
> 
> @Danel Wagner, is that just a comment or would you like a Reviewed-by ?

I will send v3 with man page update and "Reviewed-by" today, many thanks.

Song

> 
>   
