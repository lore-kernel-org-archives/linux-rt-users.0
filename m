Return-Path: <SRS0=XEuX=TY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B84C072B5
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 May 2019 08:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6502081C
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 May 2019 08:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389473AbfEXIix convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 May 2019 04:38:53 -0400
Received: from mail.numalliance.com ([90.84.246.155]:38801 "EHLO
        mail.numalliance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389324AbfEXIix (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 May 2019 04:38:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.numalliance.com (Postfix) with ESMTP id 8236F23F176F;
        Fri, 24 May 2019 10:38:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.numalliance.com
Received: from mail.numalliance.com ([127.0.0.1])
        by localhost (mail.numalliance.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DEU8nhNx6p3i; Fri, 24 May 2019 10:38:42 +0200 (CEST)
Received: from [192.168.0.139] (retd17.numalliance.com [192.168.0.139])
        (Authenticated sender: sancelot@numalliance.com)
        by mail.numalliance.com (Postfix) with ESMTPSA id 6516423F1775;
        Fri, 24 May 2019 10:38:05 +0200 (CEST)
From:   =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Subject: Re: intel j1900 and i915 realtime problems
To:     Giuliano Colla <giuliano.colla@fastwebnet.it>,
        linux-rt-users@vger.kernel.org
References: <bf7df0b0-64b4-910f-137e-1eba406d3f52@numalliance.com>
 <f1670f5a-6a78-634b-914a-cb26e2ce74aa@fastwebnet.it>
Message-ID: <dfa8f252-8345-9bb4-6f3e-c95b10f52309@numalliance.com>
Date:   Fri, 24 May 2019 10:38:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f1670f5a-6a78-634b-914a-cb26e2ce74aa@fastwebnet.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8BIT
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


>> Hi,
>>
>> I have got a problem with a celeron j1900 platform and i915 driver.
>>
>> I have 3 realtime tasks that are launched sequentially.
>>
>> task1 is clocked periodically at 3ms.
>>
>> task1 wakes up task2 and takes 2 wakes up task 3 using priority 
>> scheduling (and SCHED_FIFO mechanism).
>>
>> everything works well, until I am using graphic applications with 
>> activity (hide/show gui programs...,widgets creation /refresh etc).
>>
>> The task1 always start periodically each 3ms, but the other threads 
>> execution time are delayed.
>>
>> I mean normally, the whole computing processing timing 
>> (task1+task2+task3) takes normally around 800us time execution.
>>
>> When I stress the graphic pages, This time becomes up to 1.6ms.
>>
>> The 3 tasks are isolated on a cpu. I don't think the problem is 
>> involved by the CPU, but more by i915 driver and memory.
>>
>> I have not managed to identify the right reason with perf utility.
>>
>> One thing I am sure :
>>
>> if I run the same gui pages through an ssh shell, the problem has not 
>> appeared. realtime is not "broken"
>>
>> I know that the intel driver is involved.
>>
>> I would need some help to identify the right problem and for finding 
>> solutions.ideas.
>>
>> Regards,
>>
>
> What priorities you have given to your RT tasks?
>
my 3 RT Tasks have the following priorities:

task1: 47

task2 : 48

task3 : 49

Higher priorities don't solve the problem. It is important to notice my 
resolution is  1280x1024 /  19inch vertical orientation display,


> I have experienced that running on an isolated CPU is not enough to 
> ensure that the scheduling of your tasks is not influenced by other 
> activities. In order to have my RT tasks running properly, I've been 
> forced not only to set policy to SCHED_FIFO, but also to set a 
> priority as high as possible, sort of:
>        mysched.sched_priority = 99;
>          if( sched_setscheduler( 0, policy, &mysched ) == -1 ) {
> 	......
> for the first task, and slghtly lower priorities to the others.
>
> Then with *top *you may see where are positioned your tasks in the 
> scheduler priority.
>
> Here's a snapshot of Top output (sorted by priority), with my 15 RT 
> tasks being, in order of priority, /ymain/ to /erhndl/. Very little 
> has higher priority, and all the rest has lower. This setup for me is 
> insensitive to CPU graphic activities.
>
>
>
> Of course if in your case the i915 driver happens to have a higher 
> priority than the one you can manage to obtain programmatically for 
> your tasks, then you're out of luck.
>
> Hope that it helps,
>
> Giuliano
>
>
> -- 
> Do not do to others as you would have them do to you.They might have different tastes.
