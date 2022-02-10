Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524FFC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Feb 2022 14:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbiBJOF2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:05:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241248AbiBJOF1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Feb 2022 09:05:27 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733CCBF5
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Feb 2022 06:05:28 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2A6ED4004C
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Feb 2022 14:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644501927;
        bh=zKXhRO/iKyX7h/YxXn3Y6EhBscMlQ0dLk5x/LHBq8KY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=I9sWCwNoZ33HeU2gIQB8V9UQ6ojxxBavyk46hwji/hZRUFMAYEAIIUoVfOFJjl/VM
         Byrfvsvv/kv+UbbFiKMn+VgnE6AUoBC8hNRC+C8imxU4E46BV3FohqR09da8RlcmxG
         bkqHzXMGiDZlTBM5zmO1qqXyUL/gA2iOURbvODjxKlefJcyRS+Zn55bWQckCX5YV4n
         ANbW5gJl7oFeKUMjoTHa2En2oHuc626YyAkCPQbDvEGdicTmXxzfS03G2ZB96fqee4
         zNbm0/CcZVryvlpFqJmnz73PsrU05I9NdSkz0UZfSrxX2JuDUBOU2hc8cOutNr6vEf
         fIaYUv4qtJvbg==
Received: by mail-ej1-f72.google.com with SMTP id v2-20020a170906292200b006a94a27f903so2789654ejd.8
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Feb 2022 06:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zKXhRO/iKyX7h/YxXn3Y6EhBscMlQ0dLk5x/LHBq8KY=;
        b=SQNaJ+jvca7EFwjnj7L9MPvmSQElg/ZtkiViFaE4uWQuc49YGNfyaRFZ1rrDSGFUr0
         A/oTmnEt0Nvbo+7pPt6mNO3Bz3oN4JAzUAwEF2GvmkvLGbSSvLCwjK6LXgmWRtLaU4gw
         eVaQTFT8JPckQTEKHGSiiTDU2UO/FfYzRNh1bgg2OvH9IQZ9dx8fCdiqDa9udtiVemt3
         yvnyv6lN03VoEcLOCGeDxOTi53EUAWANEIZlYqkQYnWSZJ7RqxL9FLu0TJGhVaRzyK4G
         /nXDGTMV3dB7XMpQIVHOExMrIZXyvCGoUXQ/diFHI6YnR0jWVnlo5rbxyZ6j0VnyUQe+
         0/Iw==
X-Gm-Message-State: AOAM532PVhgEFergm/kmCsTcriwCl3ENRHDpC8DJSDHq3PE5p78ifT8F
        ON5aybIe/S2XTZ6fTui0DHOs1KgzBKkw6dinpoSR2aiT8k2YI3NNnde2yvZApBIEI1OT8zSw4bw
        BMT7SnheFxQYRf0oj+4XtvW3EnjE2twcX0tq2fa6xEPuk
X-Received: by 2002:a17:907:3ea9:: with SMTP id hs41mr6869701ejc.727.1644501926476;
        Thu, 10 Feb 2022 06:05:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJye7QQ/M4O+aQStNkXT2r87JXvIqUAITU2CmbxyLbP+hraXKwtnrC+00UUlx02GVr7CyioUXw==
X-Received: by 2002:a17:907:3ea9:: with SMTP id hs41mr6869681ejc.727.1644501926248;
        Thu, 10 Feb 2022 06:05:26 -0800 (PST)
Received: from [192.168.0.98] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i6sm9812939edf.20.2022.02.10.06.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:05:25 -0800 (PST)
Message-ID: <546f147d-1682-fb92-42e5-7247dc19dcf1@canonical.com>
Date:   Thu, 10 Feb 2022 15:05:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
 <YgUXcGC1mH7VX1d9@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgUXcGC1mH7VX1d9@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/02/2022 14:47, Sebastian Andrzej Siewior wrote:
> On 2022-02-10 09:33:56 [+0100], Krzysztof Kozlowski wrote:
>> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
>> do_softirq fails for such kernel:
> 
> PREEMPT_RT does use soft IRQs.

Correct. It does not use do_softirq() code, but follows different path
with ksoftirqd.
Shall I rephrase it towards something like this? Or maybe you have some
more accurate description?

The implementation detail is that do_softirq() is in ifndef.

> 
>>   echo do_softirq
>>   ftracetest: 81: echo: echo: I/O error
>>
>> Choose some other visible function for the test.
>>
> …
> 
>> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
>> @@ -19,7 +19,7 @@ fail() { # mesg
>>  
>>  FILTER=set_ftrace_filter
>>  FUNC1="schedule"
>> -FUNC2="do_softirq"
>> +FUNC2="scheduler_tick"
> 
> What is the purpose of this?
> 
>>  ALL_FUNCS="#### all functions enabled ####"
>>  
> 
> Sebastian


Best regards,
Krzysztof
