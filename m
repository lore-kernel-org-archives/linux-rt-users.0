Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDCCC54E94
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Jan 2023 10:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjAYKor (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 05:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjAYKoq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2023 05:44:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42638BC
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Jan 2023 02:44:45 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k16so13407264wms.2
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Jan 2023 02:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0PGKaDOTP+JnIoKhp2Ab4jDZbqX2jvYo8Knl+SxJHk=;
        b=J2CivbOq9Sc0LYpWFpt6Y/a3MN4ijCaw4I0eOR9msSJLA0jPy4CMxMK10iAxfryEPF
         VOgwTP3+RZ/+4KLbHZr7sMH+gmPhKZ851U3UbIeYDQd/L5VcRkRt6/H/H6QJ8DS+fasc
         f76Q1Zt5KQGsx+sPySwlO0v9Fn7mA5C3AcYNaBnEMV9/G+7U/k0m7c2vnnZkvPCjvlYn
         yrV7KxcrDNPpPiY4EGBYmjWmF+ip0lvEqPoOPw4d1B1gaXcY52DE568nHkc7+x16dQEx
         G2TASwTvOQ3MmCqVyQ/KnT6Q00xPR/whsPHlJ43bOFd2phwtXXTRBLnYPksZoLZkOOxj
         W0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0PGKaDOTP+JnIoKhp2Ab4jDZbqX2jvYo8Knl+SxJHk=;
        b=JOVkpBfP+4nB9sJF/lDjoSkEZnS4emHq3iWCBEUzRX4VJhDK2S+FEgFcQgGy/PdfQB
         4qe3PTaS3hCEoOotkn+Cncq/vF8saehnP+FrxVksM21xSt58OYIRGWmappuVH4uVPFfO
         2RrmO/a0Lr8+fhrA9KbQx1MTef1opj1SAZH/bZU/NhlMdOdKohLBn82EaZYTbIXzQHN3
         HlV/GQLf5RygmfOuXGYN5eBwwKjlMUOOP9p85KWkuqivtq+06BOsDABGyRtMOWgi69V1
         4G7Wbqn4ygX0lzcwGgnBidZwCxHvDZoEhoaxfP47MCShhU66WBG3bEPwbn9fDZik1JqU
         JLWA==
X-Gm-Message-State: AFqh2krlTko6O3UqiJi6z+fohry7mK4f3lF1LKEZPj2dvetBJbUbMrq7
        CGqNoS1lEW1hYnsfe/3lEQC7akSShMl/0Ecy
X-Google-Smtp-Source: AMrXdXvJ/wkwe3kkV70uazDWMi6X32/RVz4xSdXVXDPYwCipK5A0Pdbn4mOILW6hSAm3yRw0nC6x/Q==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:efe8:a42d with SMTP id p14-20020a05600c1d8e00b003d9efe8a42dmr31067477wms.21.1674643483805;
        Wed, 25 Jan 2023 02:44:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b003dc0b0e1e47sm1545487wms.48.2023.01.25.02.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 02:44:43 -0800 (PST)
Message-ID: <327c9cad-602a-e931-c8b8-cd0457639267@linaro.org>
Date:   Wed, 25 Jan 2023 11:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20230119184228.683892-1-krzysztof.kozlowski@linaro.org>
 <CAPDyKFqwRw5=SK9vckt02eGoo_dtqEpV6D0Nr5YsijoJZQh0eQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFqwRw5=SK9vckt02eGoo_dtqEpV6D0Nr5YsijoJZQh0eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 24/01/2023 11:33, Ulf Hansson wrote:
> On Thu, 19 Jan 2023 at 19:42, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> The runtime Power Management of CPU topology is not compatible with
>> PREEMPT_RT:
>> 1. Core cpuidle path disables IRQs.
>> 2. Core cpuidle calls cpuidle-psci.
>> 3. cpuidle-psci in __psci_enter_domain_idle_state() calls
>>    pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
>>    spinlocks (which are sleeping on PREEMPT_RT).
>>
>> Deep sleep modes are not a priority of Realtime kernels because the
>> latencies might become unpredictable.  On the other hand the PSCI CPU
>> idle power domain is a parent of other devices and power domain
>> controllers, thus it cannot be simply skipped (e.g. on Qualcomm SM8250).
>>
>> Disable the runtime PM calls from cpuidle-psci, which effectively stops
>> suspending the cpuidle PSCI domain.  This is a trade-off between making
>> PREEMPT_RT working and still having a proper power domain hierarchy in
>> the system.
> 
> I think this sounds like a reasonable compromise, at least at this point.
> 
>>
>> Cc: Adrien Thierry <athierry@redhat.com>
>> Cc: Brian Masney <bmasney@redhat.com>
>> Cc: linux-rt-users@vger.kernel.org
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Re-work commit msg.
>> 2. Add note to Kconfig.
>>
>> Several other patches were dropped, as this is the only one actually
>> needed.  It effectively stops PSCI cpuidle power domains from suspending
>> thus solving all other issues I experienced.
> 
> I like this approach better, thanks!
> 
>> ---
>>  drivers/cpuidle/Kconfig.arm    | 3 +++
>>  drivers/cpuidle/cpuidle-psci.c | 4 ++--
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index 747aa537389b..24429b5bfd1c 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -24,6 +24,9 @@ config ARM_PSCI_CPUIDLE
>>           It provides an idle driver that is capable of detecting and
>>           managing idle states through the PSCI firmware interface.
>>
>> +         The driver is not yet compatible with PREEMPT_RT: no idle states will
>> +         be entered by CPUs on such kernel.
> 
> This isn't entirely correct. In principle your suggested change ends
> up providing the below updated behaviour for PREEMPT_RT.
> 
> *) If the idle states are described with the non-hierarchical layout,
> all idle states are still available.
> **) If the idle states are described with the hierarchical layout,
> only the idle states defined per CPU are available, but not the ones
> being shared among a group of CPUs (aka cluster idle states).
> 
> Perhaps there is an easier way to summarize what I stated above?

Yes, I'll correct the message.

> 
>> +
>>  config ARM_PSCI_CPUIDLE_DOMAIN
>>         bool "PSCI CPU idle Domain"
>>         depends on ARM_PSCI_CPUIDLE
>> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
>> index 312a34ef28dc..c25592718984 100644
>> --- a/drivers/cpuidle/cpuidle-psci.c
>> +++ b/drivers/cpuidle/cpuidle-psci.c
>> @@ -66,7 +66,7 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
>>         /* Do runtime PM to manage a hierarchical CPU toplogy. */
>>         if (s2idle)
>>                 dev_pm_genpd_suspend(pd_dev);
>> -       else
>> +       else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> 
> Rather than doing this (and the below) in
> __psci_enter_domain_idle_state(), I suggest replacing this with a
> bailout point in psci_dt_cpu_init_topology(). That would prevent the
> __psci_enter_domain_idle_state() from being called altogether, which
> is really what we need.

Ack

> 
> Moreover, I think it would make sense to set the GENPD_FLAG_ALWAYS_ON
> for the corresponding genpd, when CONFIG_PREEMPT_RT is set. See
> psci_pd_init().

Makes sense.


Best regards,
Krzysztof

