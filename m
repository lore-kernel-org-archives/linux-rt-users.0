Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9FAC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Feb 2022 14:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242679AbiBJONT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:13:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiBJONS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Feb 2022 09:13:18 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A0513B
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Feb 2022 06:13:19 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D7B5F4005D
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Feb 2022 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644502397;
        bh=hHqRmwBM+7RA1FsnxWr2R/UGBrQXiz3iEv5wI0eWRho=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=LmQn7pOAUZ3OvE/C+LWSj4tzRYbPoxsmHTdKdhSI81nqDclOyAElIgKrsJNV98etI
         FFeS+veQZgW2t+Sd/LiSHXpWn0n8rVBaPSb3QZ7kkhgUOxbovhn2CP51M2rvmOxpU1
         2ar9ElWlf5LcmSedjbJMU8cV4PvehVZ3K0o+i0nlPMoJJkfFuSFWN761zwlfNWN55W
         HAejwl438QvlS7Eg6tGSkcyeSkUbg3P9IS7oXIknED2BL7ObAV6tRe0nOTUeouRHoD
         Zs33CcVPtL4x50aUaO7tQzdEA9shpLpeuawdZJU6zYRy0yCDcW8LmHzP9IQobRoNrx
         f/7pyV/fFIZ3A==
Received: by mail-ed1-f72.google.com with SMTP id g5-20020a056402090500b0040f28e1da47so3426693edz.8
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Feb 2022 06:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hHqRmwBM+7RA1FsnxWr2R/UGBrQXiz3iEv5wI0eWRho=;
        b=hLtSWHgvqbCHcT87+fB61YDbRzwhujSx6M4aUsEDADfVVd/Jga6oXYrc496ob0zKUJ
         4u3UsSn2vzUvv7LVD+PHNLutwtpy7JA1dDWzjbIqvvtD9+9Vp7+/UqGfIdiG7tDFYEms
         lQV5pLobws3gRvON0PdHjH4HAquvqYg8lPcCFSHVx3zdSX06cbpFbNhpYD7MRh14W1y6
         TxAE8bMXK9KOhCMjSbWBZV1ls9czmlk5bEoP5KCsiZDIaHBD0uyBceMpRv0A/llX/6pY
         V+t5eqMHY1U1eVZM8X0QCujGYya6NlCOA7rzpl/t8VtZyiRYeCNQUIeeL5oQcZtQkMcj
         aihQ==
X-Gm-Message-State: AOAM530V1XmQ80a3+UCST/ijV8mApiLA0sbKQY1sYJZq33Nc+D+zi89x
        46hoAYoGs/j2EdsudT/qJkXof1mQeox4XHFqzBsN+3epVWqUD+17iR+bx6OZ79pxjJco9onT1Ah
        fFSoILQ9DXq5nIyE2kDw3trklz9IR8nnjFDHCzM+GdPk7
X-Received: by 2002:a17:907:6d88:: with SMTP id sb8mr6493821ejc.25.1644502397481;
        Thu, 10 Feb 2022 06:13:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKV8TCZcJWN5L34rb74wIkQ6Jh9rhzbMYwLJm4thNkuEMEFmBKSz705+0NcRlXlKj8mCINJw==
X-Received: by 2002:a17:907:6d88:: with SMTP id sb8mr6493806ejc.25.1644502397287;
        Thu, 10 Feb 2022 06:13:17 -0800 (PST)
Received: from [192.168.0.98] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s11sm4966412ejr.176.2022.02.10.06.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:13:16 -0800 (PST)
Message-ID: <429dd2fd-3ceb-6780-f970-4ea9b115388c@canonical.com>
Date:   Thu, 10 Feb 2022 15:13:15 +0100
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
 <546f147d-1682-fb92-42e5-7247dc19dcf1@canonical.com>
 <YgUc5HxfIdJ0Z5AN@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgUc5HxfIdJ0Z5AN@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/02/2022 15:10, Sebastian Andrzej Siewior wrote:
> On 2022-02-10 15:05:24 [+0100], Krzysztof Kozlowski wrote:
>> On 10/02/2022 14:47, Sebastian Andrzej Siewior wrote:
>>> On 2022-02-10 09:33:56 [+0100], Krzysztof Kozlowski wrote:
>>>> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
>>>> do_softirq fails for such kernel:
>>>
>>> PREEMPT_RT does use soft IRQs.
>>
>> Correct. It does not use do_softirq() code, but follows different path
>> with ksoftirqd.
>> Shall I rephrase it towards something like this? Or maybe you have some
>> more accurate description?
> 
> It would be good to describe what the purpose of the change in terms of
> the actual problem and the aimed solution.

The purpose was explain - fix a failing test with PREEMPT_RT. I am not
planning to rework entire test, it is merely a fix.

> 
>> The implementation detail is that do_softirq() is in ifndef.
> 
> So let me ask again.  We have
>    FUNC1="schedule"
>    FUNC2="do_softirq"
> 
> What is the purpose of this? Do you need FUNC2 when ksoftirqd is run or
> when softirqs are served? Not sure how scheduler_tick fits in all this.

I guess this is more a question to the author of the test. Unless you
are now questioning the entire purpose of this test?

Best regards,
Krzysztof
