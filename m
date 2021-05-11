Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22838C433ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 20:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE5561104
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 20:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhEKU1i (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 May 2021 16:27:38 -0400
Received: from mail.kernel-space.org ([195.201.34.187]:33350 "EHLO
        mail.kernel-space.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKU1h (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 May 2021 16:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1620764387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9XfU3zAcULkTyCndRJYvq3VH+f2RNGRUmPU6pL/9xM=;
        b=Feq3CHlWknsUjWEZ5H01gTgVII3wv/zKVFBwvIw2cPW8CrlfXBig4oVBVJAyVz2EJ0pOIs
        SbFjPvO6XhvK4ylQmR1vG0n2cVxhm/jHVQZr1MB9DrshX2oxVxOPKYV+vTFhlScoXLxl1T
        iHRGHZ2YYbFGy89SGKHxdL8q5rlABuI=
Received: from [192.168.0.2] (host-87-8-57-8.retail.telecomitalia.it [87.8.57.8])
        by ziongate (OpenSMTPD) with ESMTPSA id e44a9585 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 May 2021 20:19:47 +0000 (UTC)
Subject: Re: big rt latencies compared to non rt
To:     John Ogness <john.ogness@linutronix.de>,
        linux-rt-users@vger.kernel.org, schwenderjonathan@gmail.com
References: <736a53fb-d80e-3faa-1a66-d40538e0fe26@kernel-space.org>
 <87im3p6n9x.fsf@jogness.linutronix.de>
From:   Angelo Dureghello <angelo@kernel-space.org>
Message-ID: <686c7e74-995b-63bc-53be-150f13a2e3fd@kernel-space.org>
Date:   Tue, 11 May 2021 22:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87im3p6n9x.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John and Jonathan,

thanks a lot for the help.

On 11/05/21 10:14 PM, John Ogness wrote:
> Hi Angelo,
> 
> On 2021-05-11, Angelo Dureghello <angelo@kernel-space.org> wrote:
>> cyclictest --duration=180 -t=1 -m -Sp99 \
>>           -i2000 -h3000 -q > histogram
>>
>> Average is near 16uS but there are some outside
>> values near 40000, as
> 
> The first column is the latency in microseconds. The other columns
> (2nd-5th) is the count of times that latency was seen for a CPU.
> 
>> 000009 000000    000000    000000    000000
>> 000010 000001    000000    000002    000000
>> 000011 000002    000000    000000    000000
>> 000012 000023    000006    000008    000004
>> 000013 001565    001504    002010    001367
>> 000014 000425    001959    000649    000700
>> 000015 001447    001917    001129    001415
>> 000016 034084    026118    040328    032334
>> 000017 040537    015000    033773    041092  <-----
> 
> CPU3 saw a latency of 17us 41092 times.
> 
> John Ogness
> 

-- 
Angelo Dureghello

