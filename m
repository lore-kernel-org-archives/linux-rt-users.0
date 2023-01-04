Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D08C53210
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Jan 2023 20:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbjADUrv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Jan 2023 15:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbjADUrs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Jan 2023 15:47:48 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048E6395FC
        for <linux-rt-users@vger.kernel.org>; Wed,  4 Jan 2023 12:47:46 -0800 (PST)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 721E243580;
        Wed,  4 Jan 2023 20:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1672865263;
        bh=vOqL5EVO18q4A7vUO2J3DZ2cRdErZs2V0AwmhJH2PI4=;
        h=Message-ID:Date:MIME-Version:From:To:Cc:References:Subject:
         In-Reply-To:Content-Type;
        b=AuLXEgPwBvbNW3VSmovA5FIDj8qF5XFG+804wVxYMrJmrAdoIisftm1y3tLCFcTAc
         btd6Cmt6WmtnbeAnJhPAuSyDoh6jc4Y0DcueknXEV3Ih8ENwi0WTzeGbtfzZHNwzm+
         7UmQ/OKLh722d34VXczHyrOs85/AjZfZCkwmIP+o2f8QNNBlDRi49uxX0qFs4msda8
         EFeLFwV6uni4EsgajtTmSAnQPwxOPwV6P2YHMtsrc8cQwPMSvbubFiHYFIJvWIWEaW
         KIImh21mZQKInvoB/KveyaZtREuDWq+6utAU8Te0ggGCaPZzeXlZFfUYRczqnTpB04
         wCAlMXhH2BtEA==
Message-ID: <dea6d0e9-7814-4b8c-44dd-4804cbe48227@canonical.com>
Date:   Wed, 4 Jan 2023 15:47:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
From:   Joseph Salisbury <joseph.salisbury@canonical.com>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de
References: <fe5974c9-3ed0-938a-f43c-4d301f603e92@canonical.com>
 <be47fd9c-028a-0b6b-9c7f-877f01e73960@canonical.com>
Subject: Re: System Hang With 5.15.79-rt54 Patch Set
In-Reply-To: <be47fd9c-028a-0b6b-9c7f-877f01e73960@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 12/15/22 18:39, Joseph Salisbury wrote:
>
>
> On 12/15/22 13:39, Joseph Salisbury wrote:
>> Hello,
>>
>> A bug has been reported[0] against a linux-5.15.y based Ubuntu kernel 
>> that has the 5.15.79-rt54 real-time patch set applied.
>>
>> This bug is causing a system hang when running disk tests with the 
>> stress-ng[1] test suite.  A 'hung task' call trace is being 
>> generated[2] just prior to the system hanging.  It appears the hang 
>> is happening during a call to schedule.
>>
>> To see if this was a regression, I also tested prior real-time patch 
>> sets, going as far back to rt38 and all versions exhibit this bug. I 
>> will test back further to see if this is in fact a regression and a 
>> kernel bisect can be done.  I also confirmed the same kernel without 
>> the rt54 patch set applied does not exhibit this bug.
>>
>> I will continue to debug this issue, but I wanted to send this 
>> message upstream in case anyone else runs into it.  Any specific 
>> tests, tracing or debugging steps would be greatly appreciated. 
>> Otherwise, I'll report back to this thread with any findings.
>>
>> Thanks,
>>
>> Joe
>>
>>
>> [0] https://bugs.launchpad.net/ubuntu-realtime/+bug/1998536
>> [1] https://github.com/ColinIanKing/stress-ng
>> [2] https://launchpadlibrarian.net/637058129/dmesg_dl110_rt_kernel.txt
>
> I should have also mentioned, I will also test the latest available 
> patch set (6.1-rc7-rt5) to see if it also exhibits the bug.
>
>
This bug/system hang does still happen with the v6.1-rc7 kernel and the 
rt5 real-time patch.  I also confirmed the bug/system hang does not 
happen with just v6.1-rc7 without the real-time patch applied.

I will bisect through the rt patches to see if I can find the specific 
patch(s) that causes the bug.  I will use the v5.15 kernel and it's rt 
patches, since v5.15 has the patches broken out individually, and they 
can be applied one at a time with 'git am'.

I'll provide further updates during the bisect.

Thanks,

Joe


