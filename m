Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C2AC54E94
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Jan 2023 16:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjAYQrJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 11:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjAYQrC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2023 11:47:02 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4725999F
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Jan 2023 08:46:57 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k16so14231885wms.2
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Jan 2023 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOGMCuNWW1qhFYaLtNrQ/3iF7ZU3/hOM8JR1TIVeFps=;
        b=sdD7R8X13wYUC6wJuc8MnHh3smCmEtX8wlJgUhIie0R5KmMxvF8582xjP4joAUbNYE
         jw97LiQ4PvGqGpMu26/a3iouDV3kmWn/Gzz0fqbFJo8LcWf3aa+2j8cOEwNrQKuzjH41
         /eWySxxpYkE0kGz0l2BuHrDQnoHP6kK6lyuL2qKs4A0Xpyr/mpPlntxd8ys+cxp3wk/C
         zQXQDoSYw7qpfGbx79f/qjGTUdMaUpmae2VsnuINYWs595+Sl3ym6WOJ2a/W0koXHqYh
         Zl8uk27sWEP8kQztR4XDRB930/pJLZOwCREXvRkTkoBhTDgnTsLjxZXahAkNu6KJ0RpJ
         OwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOGMCuNWW1qhFYaLtNrQ/3iF7ZU3/hOM8JR1TIVeFps=;
        b=uit0v7fNZPoIxGY905mrE9BYZo7y//yAqghhKk06K611Rh/AqMIyQ0wPkooMAyf1sT
         SqWCUhSOlOozu1snYPYjjkhNN7svGtd5oTPH9r1FeJZHxifXliJizllOqy7LZFS4cF5a
         l6NkjEjO3zGmwLvJrYyAju3Q2Lsod2x+dEaTKlKEywS0Jy50VeT9CL3kcvrF4lZAQCzE
         1fPkrkF+PFL15qHBkEQ4Aa+OIZ4/LPdThiZHEqtUMU3D/ALUompvpKYtjlL9V9jz1k5u
         9CuJUjOdPdcX7bP5N52D3uqYCE7c3CIRCZ3cdYGweJSiCMf6R9+DGi3r+L38YknA7CfS
         3SxQ==
X-Gm-Message-State: AFqh2kr90ktvvzN9A42xE6TlOVYw6ShaZ9LbDLXjljaTB0RlNJ6gD94a
        HJ6Diod19WCKmsKdgZYcq2RF6g==
X-Google-Smtp-Source: AMrXdXujjg+GiiEgro9U1/t4lYCnOFSW322yIEGNwNMqm1feqreeZkIYRQNZPaurQpsYf1Y1lyQ+sA==
X-Received: by 2002:a05:600c:31a3:b0:3d6:8570:1239 with SMTP id s35-20020a05600c31a300b003d685701239mr33878544wmp.16.1674665215494;
        Wed, 25 Jan 2023 08:46:55 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bg6-20020a05600c3c8600b003db06493ee7sm2637400wmb.47.2023.01.25.08.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 08:46:55 -0800 (PST)
Message-ID: <ac3ed1da-fcd1-d8e9-7770-8a047f0e392d@linaro.org>
Date:   Wed, 25 Jan 2023 17:46:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Hi Krzysztof,


On 25/01/2023 12:34, Krzysztof Kozlowski wrote:
> The runtime Power Management of CPU topology is not compatible with
> PREEMPT_RT:
> 1. Core cpuidle path disables IRQs.
> 2. Core cpuidle calls cpuidle-psci.
> 3. cpuidle-psci in __psci_enter_domain_idle_state() calls
>     pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
>     spinlocks (which are sleeping on PREEMPT_RT).
> 
> Deep sleep modes are not a priority of Realtime kernels because the
> latencies might become unpredictable.  On the other hand the PSCI CPU
> idle power domain is a parent of other devices and power domain
> controllers, thus it cannot be simply skipped (e.g. on Qualcomm SM8250).
> 
> Disable the idle callbacks in cpuidle-psci and mark the domain as
> always on.  This is a trade-off between making PREEMPT_RT working and
> still having a proper power domain hierarchy in the system.

Wouldn't make sense to rely on the latency constraint framework ?


> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v3:
> 1. Rework - disable idle states, mark as always on (Ulf).
> 2. Extend Kconfig warning (Ulf).
> 
> Changes since v1:
> 1. Re-work commit msg.
> 2. Add note to Kconfig.
> 
> Several other patches were dropped, as this is the only one actually
> needed.  It effectively stops PSCI cpuidle power domains from suspending
> thus solving all other issues I experienced.
> ---
>   drivers/cpuidle/Kconfig.arm           | 8 ++++++++
>   drivers/cpuidle/cpuidle-psci-domain.c | 7 +++++--
>   drivers/cpuidle/cpuidle-psci.c        | 3 +++
>   3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 747aa537389b..8deaa2e05206 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -24,6 +24,14 @@ config ARM_PSCI_CPUIDLE
>   	  It provides an idle driver that is capable of detecting and
>   	  managing idle states through the PSCI firmware interface.
>   
> +	  The driver has limitations when used with PREEMPT_RT:
> +	  - If the idle states are described with the non-hierarchical layout,
> +	    all idle states are still available.
> +
> +	  - If the idle states are described with the hierarchical layout,
> +	    only the idle states defined per CPU are available, but not the ones
> +	    being shared among a group of CPUs (aka cluster idle states).
> +
>   config ARM_PSCI_CPUIDLE_DOMAIN
>   	bool "PSCI CPU idle Domain"
>   	depends on ARM_PSCI_CPUIDLE
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index c80cf9ddabd8..6ad2954948a5 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -64,8 +64,11 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>   
>   	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
>   
> -	/* Allow power off when OSI has been successfully enabled. */
> -	if (use_osi)
> +	/*
> +	 * Allow power off when OSI has been successfully enabled.
> +	 * PREEMPT_RT is not yet ready to enter domain idle states.
> +	 */
> +	if (use_osi && !IS_ENABLED(CONFIG_PREEMPT_RT))
>   		pd->power_off = psci_pd_power_off;
>   	else
>   		pd->flags |= GENPD_FLAG_ALWAYS_ON;
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 312a34ef28dc..6de027f9f6f5 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -222,6 +222,9 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
>   	if (!psci_has_osi_support())
>   		return 0;
>   
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return 0;
> +
>   	data->dev = psci_dt_attach_cpu(cpu);
>   	if (IS_ERR_OR_NULL(data->dev))
>   		return PTR_ERR_OR_ZERO(data->dev);

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

