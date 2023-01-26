Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CBEC05027
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Jan 2023 12:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjAZMhj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Jan 2023 07:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjAZMhi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Jan 2023 07:37:38 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181706A302
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Jan 2023 04:37:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id be8so1683323plb.7
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Jan 2023 04:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f781q+d7HKEn4nTTqyctm+PVJ5b9hnewFfXGjR2FR58=;
        b=CHbklH8jsL2VpxKAGklgkoHvXa6yco6vkdgNXOlro8mHSw6Oj+1FryUEPLh0fLoit9
         05zylBhQuwuGuycYe3kT5qfddarPljpltZ1sM9kt7oQSaggIcNbjpfJHKV3GP/GCyuah
         t9Lu5ysv9ogonIeWMD/3niWi+EFXi1IEZo3XTs2LvWk1QZTDVG/47sz5hBWw6z+VrKq/
         MI6mLRhK32BXsM6grX+3SNO6mkOFAquw1bD42BhLuWb3SXID6y97ouAvCYBTpP1F/WkZ
         zDp3E8KBx4TtDdw8keDmc7dQn1xtKXTzD56AcRAhlgHPa4gC39bSZDD6x8DnVJYmIkAO
         f2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f781q+d7HKEn4nTTqyctm+PVJ5b9hnewFfXGjR2FR58=;
        b=qI8X8rsH7ODk9NgRAZIdCHFLivTrdhX8CMI234ZFDcaK8sdFSqaxEgNJ+ntFtGFame
         55/vgG7HZg8sImNrS1J0xyK31FzRtaHnjueTBw+trvVnKfjIcEFPdUe0Nr/720vc0Pab
         SSsGtRfEhBLOZMboa8pZT92h5vSt/fOZCwWRyhHymhL0tA2bVhL6z5RsjcMfxZmZX+db
         LtSoyijoP58zSrR5VYL/WHfeCKQTUEQrqeGIm+iIMdwM1s5a+R16oJhZ4kK2k5M+yPBL
         JxBKUOW2+0wpLVA/xTcrlYdcUJ/IsnfplmK6x4x4tg4l5Z/VhwO3sRwYgwXl7eX2pgWj
         rqZA==
X-Gm-Message-State: AO0yUKVJWzezZaJhl9WHAZ52na0292Qjtz99Pw7DhytUkW1Pgt3Cz3OV
        /3pZtsFPVwquBgA5Zjy9vCQs9V94UoM3yv6RgmxQmw==
X-Google-Smtp-Source: AK7set8Cz8o/NquUec8I5fw/D7OCJ13899t+RvbRoO/PabAfwQcg6y7wHOKozkf+cz1PNgnw2z/zILbQzXxf/3U0MIY=
X-Received: by 2002:a17:90a:70cc:b0:22c:1dd5:db7 with SMTP id
 a12-20020a17090a70cc00b0022c1dd50db7mr508437pjm.148.1674736654542; Thu, 26
 Jan 2023 04:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Jan 2023 13:36:58 +0100
Message-ID: <CAPDyKFpUPwtJD9CPE7Dq-tZiMBhsndPBGWjJ4LFM4E953Nzemg@mail.gmail.com>
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 25 Jan 2023 at 12:34, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The runtime Power Management of CPU topology is not compatible with
> PREEMPT_RT:
> 1. Core cpuidle path disables IRQs.
> 2. Core cpuidle calls cpuidle-psci.
> 3. cpuidle-psci in __psci_enter_domain_idle_state() calls
>    pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
>    spinlocks (which are sleeping on PREEMPT_RT).
>
> Deep sleep modes are not a priority of Realtime kernels because the
> latencies might become unpredictable.  On the other hand the PSCI CPU
> idle power domain is a parent of other devices and power domain
> controllers, thus it cannot be simply skipped (e.g. on Qualcomm SM8250).
>
> Disable the idle callbacks in cpuidle-psci and mark the domain as
> always on.  This is a trade-off between making PREEMPT_RT working and
> still having a proper power domain hierarchy in the system.
>
> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Cc: linux-rt-users@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

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
>  drivers/cpuidle/Kconfig.arm           | 8 ++++++++
>  drivers/cpuidle/cpuidle-psci-domain.c | 7 +++++--
>  drivers/cpuidle/cpuidle-psci.c        | 3 +++
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 747aa537389b..8deaa2e05206 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -24,6 +24,14 @@ config ARM_PSCI_CPUIDLE
>           It provides an idle driver that is capable of detecting and
>           managing idle states through the PSCI firmware interface.
>
> +         The driver has limitations when used with PREEMPT_RT:
> +         - If the idle states are described with the non-hierarchical layout,
> +           all idle states are still available.
> +
> +         - If the idle states are described with the hierarchical layout,
> +           only the idle states defined per CPU are available, but not the ones
> +           being shared among a group of CPUs (aka cluster idle states).
> +
>  config ARM_PSCI_CPUIDLE_DOMAIN
>         bool "PSCI CPU idle Domain"
>         depends on ARM_PSCI_CPUIDLE
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index c80cf9ddabd8..6ad2954948a5 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -64,8 +64,11 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>
>         pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
>
> -       /* Allow power off when OSI has been successfully enabled. */
> -       if (use_osi)
> +       /*
> +        * Allow power off when OSI has been successfully enabled.
> +        * PREEMPT_RT is not yet ready to enter domain idle states.
> +        */
> +       if (use_osi && !IS_ENABLED(CONFIG_PREEMPT_RT))
>                 pd->power_off = psci_pd_power_off;
>         else
>                 pd->flags |= GENPD_FLAG_ALWAYS_ON;
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index 312a34ef28dc..6de027f9f6f5 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -222,6 +222,9 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
>         if (!psci_has_osi_support())
>                 return 0;
>
> +       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +               return 0;
> +
>         data->dev = psci_dt_attach_cpu(cpu);
>         if (IS_ERR_OR_NULL(data->dev))
>                 return PTR_ERR_OR_ZERO(data->dev);
> --
> 2.34.1
>
