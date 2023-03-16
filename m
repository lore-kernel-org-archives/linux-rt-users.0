Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F287C6FD1F
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Mar 2023 12:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjCPM3A (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Mar 2023 08:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCPM2x (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Mar 2023 08:28:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F6C0834
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Mar 2023 05:28:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id fd5so6919368edb.7
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Mar 2023 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678969700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuzDwg2lxu1rtYjhTSBJYtTkaTQvz0mwPxYBQwYy20g=;
        b=vxJm/pF8sewwUszKYiDSfHTVUwBSWICc5MH1RuCN+eYfHnhXBErovQZaEhRLWS2t0S
         oBnoKqECgFj7mYaG6pAolJe3JfDkDB8qgSMH5JXts1MtsUk9viXtPl9+co+SOTeSgADk
         FCOT+Dh4PTlzam28dIfSNtv0/5uEeIUZgLqeBoHLlcX0cBZ73lwHvyXp/6dx53dwvg3S
         hNaRx9B+h6dya1kb6FGh7wD4M3nwdX18E3bQlcBVHZyFqZyEzHuTVqp16BbQ+iAXxp20
         wuPhDagD3QqBtUJXlc7DgijZkhcoazfyQxfNDytWOUe2Wlpdu1zjgW18qED2nc7651ia
         WXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678969700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuzDwg2lxu1rtYjhTSBJYtTkaTQvz0mwPxYBQwYy20g=;
        b=kfmAqYzLLgmGcfF+cQDsyYWEbfGGvAWteuxWlxkQj+NYUEG5ioOIhdWBslMOBvHu7c
         +cFyO2H39bAkol5sXDe19SGfpoZ1JeD82TH+MAsurLQ0nKo5HGjD/owPz7H2iUcvFSEF
         5Z2nL0g0HsYTywMNAIqtqZoevWdWhqLbO5euIfzmSyeMQgBp8uNO7mWZeViPERyxvWHQ
         /jPIvrBN1iNWcbQvMEIgjORXZ9Y4ZWXqyR8f2dkpRwufjLWxsdnBJxfyXoA5w8rZhTIt
         0X98oDUq/N8Jw0GL7DR7EZDil4wMjXWbuR/k6ZkjAuYBc6SyorTWVLjP6ID5D4ii1yKl
         AsZA==
X-Gm-Message-State: AO0yUKVgvHX00+DhI2TyixC9GiSTgDZuZ2vU4Swq9DmFX8MSG6IW7ZN1
        Zd2MQ0QTISBfPXruMKATMNvMrA==
X-Google-Smtp-Source: AK7set8sb9Pt47A8F5UHMhUTeEFJy8nZDAA2FIy5bTWmk2ssc26ydb1AH4xupqEGnvo0UKQ1P6AZIQ==
X-Received: by 2002:a17:906:4a09:b0:8b1:7de6:e292 with SMTP id w9-20020a1709064a0900b008b17de6e292mr9717493eju.9.1678969700160;
        Thu, 16 Mar 2023 05:28:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id d20-20020a1709063ed400b008d1693c212csm3762281ejj.8.2023.03.16.05.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 05:28:19 -0700 (PDT)
Message-ID: <01d18b05-238f-e938-9ad0-ff1956cb361d@linaro.org>
Date:   Thu, 16 Mar 2023 13:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] cpufreq: qcom-cpufreq-hw: allow work to be done on
 other CPU for PREEMPT_RT
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


On 15/03/2023 17:49, Krzysztof Kozlowski wrote:
> Qualcomm cpufreq driver configures interrupts with affinity to each
> cluster, e.g.  dcvsh-irq-0, dcvsh-irq-4 and dcvsh-irq-7 on SM8250.
> Triggered interrupt will schedule delayed work, but, since workqueue
> prefers local CPUs, it might get executed on a CPU dedicated to realtime
> tasks causing unexpected latencies in realtime workload.
> 
> Use unbound workqueue for such case.  This might come with performance
> or energy penalty, e.g. because of cache miss or when other CPU is
> sleeping.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++++-

Let me also paste impact of this patch - rtla osnoise on entirely idle
system (cores 2-7 isolated for Realtime):

BEFORE:
       osnoise/7-2967    [007] d..h2..  3937.898311: irq_noise: dcvsh-irq-7:179 start 3937.898310871 duration 104 ns
 irq/179-dcvsh-i-343     [007] d..h2..  3937.898318: irq_noise: IPI:6 start 3937.898317537 duration 104 ns
 irq/179-dcvsh-i-343     [007] d...3..  3937.898321: thread_noise: irq/179-dcvsh-i:343 start 3937.898316287 duration 4740 ns
     kworker/7:0-85      [007] d..h2..  3937.898323: irq_noise: IPI:6 start 3937.898322381 duration 104 ns
     kworker/7:0-85      [007] d...3..  3937.898343: thread_noise: kworker/7:0:85 start 3937.898321339 duration 20990 ns
       osnoise/7-2967    [007] .......  3937.898343: sample_threshold: start 3937.898308475 duration 34531 ns interference 5

Noise duration: 34 us

AFTER:
       osnoise/7-2637    [007] d..h2..   530.563819: irq_noise: dcvsh-irq-7:178 start 530.563817139 duration 260 ns
       osnoise/7-2637    [007] d..h2..   530.563827: irq_noise: IPI:6 start 530.563826670 duration 156 ns
       osnoise/7-2637    [007] .......   530.563828: sample_threshold: start 530.563814587 duration 12864 ns interference 2

Noise duration: 13 us

Best regards,
Krzysztof

