Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80400C54EBC
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Jan 2023 11:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjALLoi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjALLn2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Jan 2023 06:43:28 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C7050061
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Jan 2023 03:34:40 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i15so26442375edf.2
        for <linux-rt-users@vger.kernel.org>; Thu, 12 Jan 2023 03:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NPppTKcTJ8osAB1279QFcRRpcaOPzuC1Irm/XHV91xY=;
        b=nhy1MtVbKfauFFS3BCGLF7FnbflcNjW2sYGIUXqKeSwmc884VZmYAIaidQikvPoP0C
         Giv5KKFQN1nRKP8a/VRC/S+K1XNFW8VZ/aHF1sfownzPT+GHr4wdIsqNieuEgZvNAesE
         UY2vfXdMQxbvwC8eVEkUcuA7+zfVihSbqvh/4LFVoEIgmFbF7H5AFCqmUxg+LNTLOTjf
         zmgJus8v3RTAel2iPynBI0r+TGT5qyyKVOc9bsF25aRkzzBGIziT9qUA1okUGK84fDju
         bcQ8JuqCC6hC549gXJ4z6fGA7n+xwHyNI4YoAXat4g4IqaOH7tJFTIarLg6g/fFA3F5V
         HQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPppTKcTJ8osAB1279QFcRRpcaOPzuC1Irm/XHV91xY=;
        b=ASyFtdfK2t220IjQVfPsyVqemwuqrSPaU0SV/eze+j2FJzx+sGVYXFvGhnUO6VCxaO
         2ov0a8sH8SIoIrlucZAGLGYKWSI9ksc4i9QxS9OkgigiZK09MGzW/YOKfRVe1NnjoV0O
         GJDiEuyuyrSYLdqLPnZCFz0FFHUu7Q+7jRduVeJPEYGw+nH31RZdCk78NEnLj+XJbqQ2
         2kwDiPKAhMwvRgfWLRuPIl4QvjSGl3zVgkiL5n1BbgKbQMZaHWdFL1I6a1vv9Tc/WFmX
         HpGcB5ePwwj2C8oT1ZubzilhidSZiZ7dVgERVTnDlQDvqztlWXOLTdk8GqE99y8e1xyc
         Kpqg==
X-Gm-Message-State: AFqh2kp1ycI1sHF6CBFJuTYdBTK+7NG8VwFKCrEOL+aUf+yq7jDhk5du
        K4+9yg3tkJpda4MmgxUcydDosA==
X-Google-Smtp-Source: AMrXdXvWbW8IAmtnQmlSRkX+6gl0xQtW+r+xOr87zb6PQKvXJ8tr9zg5aJqowtBTnLas0xRFoSASbw==
X-Received: by 2002:aa7:c393:0:b0:499:b604:4de6 with SMTP id k19-20020aa7c393000000b00499b6044de6mr11772008edq.25.1673523279003;
        Thu, 12 Jan 2023 03:34:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d3-20020aa7d5c3000000b004835bd8dfe5sm7200389eds.35.2023.01.12.03.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 03:34:38 -0800 (PST)
Message-ID: <3d7c3a52-baa4-ce7b-e6d1-06a4d885d445@linaro.org>
Date:   Thu, 12 Jan 2023 12:34:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/5] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
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
 <20221219151503.385816-4-krzysztof.kozlowski@linaro.org>
 <Y7/qZNoXvp/I6h8s@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7/qZNoXvp/I6h8s@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 12/01/2023 12:09, Sebastian Andrzej Siewior wrote:
> On 2022-12-19 16:15:01 [+0100], Krzysztof Kozlowski wrote:
>> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
>> index 57bc3e3ae391..9d971cc4b12b 100644
>> --- a/drivers/cpuidle/cpuidle-psci.c
>> +++ b/drivers/cpuidle/cpuidle-psci.c
>> @@ -72,7 +72,7 @@ static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
>>  	ct_irq_enter_irqson();
>>  	if (s2idle)
>>  		dev_pm_genpd_suspend(pd_dev);
>> -	else
>> +	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>>  		pm_runtime_put_sync_suspend(pd_dev);
> 
> So based on the commit description you run into a sleeping lock in
> pm_runtime_put_sync_suspend() while the CPU is in an IRQ-off region.
> Why is it okay to skip it on PREEMPT_RT?

It is okay to skip it everywhere, you just don't get a suspended CPU.
Why PREEMPT_RT is different here - having suspended CPU is a great way
to have longer or even unpredictable (as it goes to firmware which is
out of control of Linux) latencies.

Best regards,
Krzysztof

