From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: Re: [PATCH 24/34] signaltest: remove unused ARRAY_SIZE macro
Date: Mon, 5 Jun 2017 13:06:22 +0300
Message-ID: <ced54112-4dc0-5f27-ff5c-be27609087d0@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
 <20170522082540.15467-25-tommi.t.rantala@nokia.com>
 <alpine.LFD.2.20.1705221843320.7915@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50135.outbound.protection.outlook.com ([40.107.5.135]:39760
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751404AbdFEKGa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Jun 2017 06:06:30 -0400
In-Reply-To: <alpine.LFD.2.20.1705221843320.7915@riemann>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 22.05.2017 19:44, John Kacur wrote:
> On Mon, 22 May 2017, Tommi Rantala wrote:
> 
>> --- a/src/signaltest/signaltest.c
>> +++ b/src/signaltest/signaltest.c
>> @@ -30,8 +30,6 @@
>>   #include "error.h"
>>   #include "rt-utils.h"
>>   
>> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>> -
>>   /* Ugly, but .... */
>>   #define gettid() syscall(__NR_gettid)
>>   
>> -- 
> 
> NAK
> 
> You're right, it could be removed, but it's not really causing in harm
> either. I'm going to leave it in for now.
> 
> Thanks
> 
> John

Hi John,

OK, dropped the patch also from the github repo.

Any comments to the rest of the patches?

-Tommi
