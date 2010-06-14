From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: beagleboard RT problem
Date: Mon, 14 Jun 2010 16:41:49 +0530
Message-ID: <AANLkTimtwlNkt3Fc4FP0Da5YYmCNnIDHxSATerps7dRd@mail.gmail.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	<AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
	<AANLkTinztcUB6WVJKaZlwPuBrq7nZYN_ROdCC6ZNtRJf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Maksym Parkachov <lazy.gopher@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45433 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab0FNLLv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Jun 2010 07:11:51 -0400
Received: by vws14 with SMTP id 14so526076vws.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jun 2010 04:11:50 -0700 (PDT)
In-Reply-To: <AANLkTinztcUB6WVJKaZlwPuBrq7nZYN_ROdCC6ZNtRJf@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> But, generally, is there way to trace what happens in kernel,
> something in /proc or /sys ?
> Do I need to switch tracing in configuration ?

I think you should look at kernel module level of Tracing. You could
have tracing with something like cyclic-test.
Also some tracing with options like # CONFIG_PREEMPT_RCU_TRACE is not set.
>
> Thanks,
> Maksym.
>
> On 14 June 2010 11:44, Sujit K M <sjt.kar@gmail.com> wrote:
>>> CONFIG_PREEMPT_RCU=y
>>> # CONFIG_PREEMPT_RCU_TRACE is not set
>>
>> Why is RCU being set to y?
>>
>>> # CONFIG_PREEMPT_NONE is not set
>>> # CONFIG_PREEMPT_VOLUNTARY is not set
>>> # CONFIG_PREEMPT_DESKTOP is not set
>>
>> Fine.
>>
>>> CONFIG_PREEMPT_RT=y
>>
>> This is correct.
>>
>>> CONFIG_PREEMPT=y
>>> CONFIG_PREEMPT_SOFTIRQS=y
>>> CONFIG_PREEMPT_HARDIRQS=y
>>
>> I think this part is susceptible.
>>
>> Thanks,
>> Sujit
>>
>



-- 
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
