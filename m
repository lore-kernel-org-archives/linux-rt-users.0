Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E51C54EBC
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Jan 2023 11:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjALLlc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjALLkr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Jan 2023 06:40:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059A3517C3
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Jan 2023 03:31:06 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hw16so32145899ejc.10
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Jan 2023 03:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OMuAyOi3tfWlxGzLyr9WZRzvZr9Bx2UzbGUycZVDQqY=;
        b=q2tr9HM5VxAlb2mwHwciq3gjRse0GjE0+vDhDI8zP3Zcb2njpROrPv2SY9bxIJ3krP
         RmqYW07g5BKQApBoUJN6+Nw7pagjCanKvHHDMgAdibHtiIPB8J9vvTjhvzR/bqBbcI2P
         CQakZdJEf7AmWhA0PDSMH1ymuVKuZIFPmga5JT5LE48uFzspo+G1A6vhUrXXJ4gvBlhw
         AfqqgTopEvMZ5QLo3ABdN15CUv26nOirfhe/uFSRPyE9Gme5BnuFRtYH+oJW9v+rWnhQ
         ogSUXBKhEnF3HKDlj08efs31mh+wmJ7/3MrlbL5VqHFr6yBJUxSWoc0hff5K0chk+jqI
         PB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMuAyOi3tfWlxGzLyr9WZRzvZr9Bx2UzbGUycZVDQqY=;
        b=KdzxdeHYIelnu9GyNQQRbdaFcDHs3nWwRCNKaUp1mHe2JEyJBs3tSabBZSB+SYmvq2
         7SCaDS+cKJgP3dthXuyIoCkedjEDK1iQGQr0TugdfZLSSqhyks/1Q/8TYyRl/63mljJ7
         /V2lnyaX2a57irTQzeBrE8FFUiYrRrlD6IiK0MpCT916uOtE1Q3X0S4nEhRfIcblxtWt
         +fSOTzoHTOI/xQdnD56FpmNSHwYnqCy6K/0wVC4/0MOLTh9qNRKInhk9yYY6WYkKtVTa
         vlS9d6BnOn7oMVpsJ/lJq0Ghv+e1wFUTqPyP4oWumPAUs+rCsZknaaB7T+s0JL4Q60Aq
         3pCw==
X-Gm-Message-State: AFqh2kp4WajzWJpWJ3vmOWRF4zhN0lWa0demgqWSbod8tBGXF7LYqE8M
        Dv6QZJ9EkedziwVGuiTnd8gdaw==
X-Google-Smtp-Source: AMrXdXu8nq7pgkBL5G94fORkKbl1bwAxN1S0t3Ainvx6uqRt5geVVuxRrObSl7eTbW+NVr/UGxJBLA==
X-Received: by 2002:a17:906:30d4:b0:7a6:5b50:a32c with SMTP id b20-20020a17090630d400b007a65b50a32cmr60646950ejb.12.1673523064627;
        Thu, 12 Jan 2023 03:31:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709061bb200b0082000f8d871sm7362044ejg.152.2023.01.12.03.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 03:31:04 -0800 (PST)
Message-ID: <b6d0aa40-5d25-df4e-f8fb-64d056b24c84@linaro.org>
Date:   Thu, 12 Jan 2023 12:31:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/5] PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-2-krzysztof.kozlowski@linaro.org>
 <Y7/h2n271HBeXDl6@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7/h2n271HBeXDl6@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 12/01/2023 11:32, Sebastian Andrzej Siewior wrote:
> On 2022-12-19 16:14:59 [+0100], Krzysztof Kozlowski wrote:
>> Realtime kernels with PREEMPT_RT must use raw_spinlock_t for domains
>> which are invoked from CPU idle (thus from atomic section).  Example is
>> cpuidle PSCI domain driver which itself is PREEMPT_RT safe, but is being
>> called as part of cpuidle.
> 
> I think it needs to be clarified what PREEMPT_RT safe means. 

OK

> PSCI is an
> external interface which does not inform us what it does and how long
> the operation will take.
> The ACPI table for instance populate several idle states and their
> entry/exit time. Then you can decide if and when an entry/exit latency
> of 500us is PREEMPT_RT safe.
> 
>> Add a flag allowing a power domain provider to indicate it is RT safe.
>> The flag is supposed to be used with existing GENPD_FLAG_IRQ_SAFE.
>>
>> Cc: Adrien Thierry <athierry@redhat.com>
>> Cc: Brian Masney <bmasney@redhat.com>
>> Cc: linux-rt-users@vger.kernel.org
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
> …
>> index 1cd41bdf73cf..0a1600244963 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -61,6 +61,14 @@
>>   * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
>>   *				components' next wakeup when determining the
>>   *				optimal idle state.
>> + *
>> + * GENPD_FLAG_RT_SAFE:		When used with GENPD_FLAG_IRQ_SAFE, this informs
>> + *				genpd that its backend callbacks, ->power_on|off(),
>> + *				do not use other spinlocks. They might use
>> + *				raw_spinlocks or other pre-emption-disable
>> + *				methods, all of which are PREEMPT_RT safe. Note
> 
> Please use spinlock_t and raw_spinlock_t. Wouldn't it be better to write
> "preemption" instead "pre-emption"?

Sure.

> The important part is probably that once a raw_spinlock_t has been
> acquired, it is not possible to invoke any function that acquries
> sleeping locks (which includes memory allocations). While even without
> that flag it is possible to invoke a function which disables and enables
> preemption on its own.
> 
>> + *				that, a genpd having this flag set, requires its
>> + *				masterdomains to also have it set.
> 
> This could be verified upon registration, no?

It is, just like the IRQ_SAFE flag. The code is symmetrical to IRQ_SAFE.

> It might be worth noting that preemption-off section during PM
> operations contribute to the system's max latency.

You mean in the commit msg? In the doc, I don't want to deviate from
IRQ_SAFE. It's not really related to the flag.

> Depending on how low
> the operation is, it may or may not be a problem.
> The ->power_on|off() refers to the sate of the component, right?

It refers to genpd framework.

Best regards,
Krzysztof

