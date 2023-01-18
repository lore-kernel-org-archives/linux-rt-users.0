Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F1EC38147
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Jan 2023 18:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjARSwa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjARSw3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Jan 2023 13:52:29 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE1367E1
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Jan 2023 10:52:27 -0800 (PST)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9F5113F12A;
        Wed, 18 Jan 2023 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674067944;
        bh=wBmBN8UT++KM5edV/QvnrCt6IRASr8MKopVpbOzRDZs=;
        h=Message-ID:Date:MIME-Version:From:To:Cc:References:Subject:
         In-Reply-To:Content-Type;
        b=CPovh16o0JchBaFCzoDnFAuVna+v43DmfxkTUGeFAJZgJR/L/fSZ3SWyo4NAdYgJm
         Yle3qeLgtO2y/kF9cApRY/9kKUYRXpIc0L0NwmUf9kb/6wHml+JO44kxjjGviJuch/
         xSeGMLwb7Q9bTHks27qb9q4n/CSnHR5Eq6xooeQOWvlq7+V/SR4aeR6CuPHjK97By9
         gYEqy7uhtABMoATLQrUE2L0FUD3P1F8fTaS3D79r2PN6Ja8YK0BTOzK8fRCpTvU7eN
         HvYgoTsDnTMgxWzXa8JUQvrRZywwzoV7Fbr83eso5TwnSC+XLhHGte2CO2CCpH/+9f
         f+QhSaA9KZokQ==
Message-ID: <c4fe632e-568b-7c60-c6d2-99e0148680ad@canonical.com>
Date:   Wed, 18 Jan 2023 13:52:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de
References: <fe5974c9-3ed0-938a-f43c-4d301f603e92@canonical.com>
 <be47fd9c-028a-0b6b-9c7f-877f01e73960@canonical.com>
 <dea6d0e9-7814-4b8c-44dd-4804cbe48227@canonical.com>
Subject: Re: System Hang With 5.15.79-rt54 Patch Set
In-Reply-To: <dea6d0e9-7814-4b8c-44dd-4804cbe48227@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 1/4/23 15:47, Joseph Salisbury wrote:
>
>
> On 12/15/22 18:39, Joseph Salisbury wrote:
>>
>>
>> On 12/15/22 13:39, Joseph Salisbury wrote:
>>> Hello,
>>>
>>> A bug has been reported[0] against a linux-5.15.y based Ubuntu 
>>> kernel that has the 5.15.79-rt54 real-time patch set applied.
>>>
>>> This bug is causing a system hang when running disk tests with the 
>>> stress-ng[1] test suite.  A 'hung task' call trace is being 
>>> generated[2] just prior to the system hanging.  It appears the hang 
>>> is happening during a call to schedule.
>>>
>>> To see if this was a regression, I also tested prior real-time patch 
>>> sets, going as far back to rt38 and all versions exhibit this bug. I 
>>> will test back further to see if this is in fact a regression and a 
>>> kernel bisect can be done.  I also confirmed the same kernel without 
>>> the rt54 patch set applied does not exhibit this bug.
>>>
>>> I will continue to debug this issue, but I wanted to send this 
>>> message upstream in case anyone else runs into it.  Any specific 
>>> tests, tracing or debugging steps would be greatly appreciated. 
>>> Otherwise, I'll report back to this thread with any findings.
>>>
>>> Thanks,
>>>
>>> Joe
>>>
>>>
>>> [0] https://bugs.launchpad.net/ubuntu-realtime/+bug/1998536
>>> [1] https://github.com/ColinIanKing/stress-ng
>>> [2] https://launchpadlibrarian.net/637058129/dmesg_dl110_rt_kernel.txt
>>
>> I should have also mentioned, I will also test the latest available 
>> patch set (6.1-rc7-rt5) to see if it also exhibits the bug.
>>
>>
> This bug/system hang does still happen with the v6.1-rc7 kernel and 
> the rt5 real-time patch.  I also confirmed the bug/system hang does 
> not happen with just v6.1-rc7 without the real-time patch applied.
>
> I will bisect through the rt patches to see if I can find the specific 
> patch(s) that causes the bug.  I will use the v5.15 kernel and it's rt 
> patches, since v5.15 has the patches broken out individually, and they 
> can be applied one at a time with 'git am'.
>
> I'll provide further updates during the bisect.
>
> Thanks,
>
> Joe
>
>

I've been bisecting this bug down. It appears the bug has existed back 
to v5.15-rc3-rt5. I'll test older versions, but it may be that this bug 
has always existed with PREEMPT_RT enabled.

I will test some of the real-time patch releases prior to v5.15 to 
confirm this issue has always existed or not.

This is the current message I see on the console when the system locks up:

[ 4363.605933] INFO: task journal-offline:23780 blocked for more than 
622 seconds.
[ 4363.605936]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.605938] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4363.606051] INFO: task stress-ng:23298 blocked for more than 622 
seconds.
[ 4363.606052]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.606053] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4363.606121] INFO: task stress-ng:23299 blocked for more than 622 
seconds.
[ 4363.606122]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.606122] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4363.606183] INFO: task stress-ng:23300 blocked for more than 622 
seconds.
[ 4363.606184]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.606184] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4363.606235] INFO: task stress-ng:23302 blocked for more than 622 
seconds.
[ 4363.606236]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.606237] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4363.606290] INFO: task stress-ng:23305 blocked for more than 622 
seconds.
[ 4363.606291]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.606291] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4363.606346] INFO: task stress-ng:23309 blocked for more than 622 
seconds.
[ 4363.606347]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.606347] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4363.606393] INFO: task stress-ng:23314 blocked for more than 622 
seconds.
[ 4363.606394]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.606394] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4363.606440] INFO: task stress-ng:23319 blocked for more than 622 
seconds.
[ 4363.606440]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.606441] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4363.606484] INFO: task stress-ng:23323 blocked for more than 622 
seconds.
[ 4363.606485]       Not tainted 5.15.85-051585-realtime #202301172024
[ 4363.606486] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 4708.553134] systemd[1]: Failed to start Journal Service.
[ 4770.052389] systemd[1]: systemd-timesyncd.service: Watchdog timeout 
(limit 3min)!


I'll add more details to this thread as I continue.




