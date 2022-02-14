Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE30C433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Feb 2022 18:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357476AbiBNSda (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:33:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiBNSd2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Feb 2022 13:33:28 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C09652E3
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2022 10:33:20 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id c14so3419929ilm.4
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2022 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tPJrWe/i1MqPMtoPzbeR0YlE4FVwmAqDMvl6+ufirY4=;
        b=COkS4HG2yhu5A+qPYPGPODAVhYDxh2/jZFV1uAoGVTzJcBYPaXav2ILkA+Rl8b+vzh
         aP96JiOp8O+222QWhSurBWbwFqm1uF1n0AtJu385qY5DwYoAzFLtML3w+T1hhCwz1UkV
         LxyE3mKgNIHtUkLv/tlfZQGknbGYd4tdDCNVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tPJrWe/i1MqPMtoPzbeR0YlE4FVwmAqDMvl6+ufirY4=;
        b=08QP6H8UIPuyaaKUX9iNXLWI1Xswt8ieR89HKVhENVFUtTGpMIHA/MhvEjumad1jy5
         L6NUv4f3rUy3m+r4R5/jKg65KbVyiAjQ9y2yuAXnGOMZ593begfvcHVRVa97JAa3N1Ek
         4iWsOOTreOo+Q98yTluTvjF1OLgDRJ28/79szP6RRXxtHd1rtR+T/HyrLHo/7pGTf1mc
         1WRxRRYvzUGoFO1ak6kUQZq1a1eFGXjsOWvs2VgH6sF7rIGMFN03r0GI2E+OsCoPNRaf
         LvPzGoS9Jz09hUuHqyO17qMwDqtgAQQFHS19tll6hwg6G4hy88YvT4WpBIu1WDAEJ+n6
         SHBw==
X-Gm-Message-State: AOAM53342OX+yZhaceBrrQK7L7j4CxxgY/3uL1G0WivinvXAQHrzK4eR
        oKdX+e2NFC/OtDXC9kX9bqbv/df/Sb2U5g==
X-Google-Smtp-Source: ABdhPJwmbomCs/78CZKWKJaM/G0NMmImZ7RDFmjRwVP0Cf9Pq2eAUr8RIwQIdHQv4nTc1UGomvsRnA==
X-Received: by 2002:a05:6e02:1544:: with SMTP id j4mr92677ilu.77.1644863599754;
        Mon, 14 Feb 2022 10:33:19 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g1sm23149484iob.34.2022.02.14.10.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 10:33:19 -0800 (PST)
Subject: Re: [PATCH v3] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220214083657.165921-1-krzysztof.kozlowski@canonical.com>
 <Ygo6pqWmkTWJNNcR@linutronix.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8f034cd5-8495-de0e-6a3c-4d002e49cc51@linuxfoundation.org>
Date:   Mon, 14 Feb 2022 11:33:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Ygo6pqWmkTWJNNcR@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2/14/22 4:19 AM, Sebastian Andrzej Siewior wrote:
> On 2022-02-14 09:36:57 [+0100], Krzysztof Kozlowski wrote:
>> The PREEMPT_RT patchset does not use do_softirq() function thus trying
>> to filter for do_softirq fails for such kernel:
>>
>>    echo do_softirq
>>    ftracetest: 81: echo: echo: I/O error
>>
>> Choose some other visible function for the test.  The function does not
>> have to be actually executed during the test, because it is only testing
>> filter API interface.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
>> Notes:
>> I understand that the failure does not exist on mainline kernel (only
>> with PREEMPT_RT patchset) but the change does not harm it.
> 

Steve,

Would you like me to take this through linux-kselftest next for 5.18-rc1

I am guessing there is no urgency on this - of not I can take this in for
rc5.

thanks,
-- Shuah
