Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB54C61D97
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Jan 2023 12:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAZMpz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Jan 2023 07:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjAZMpw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Jan 2023 07:45:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B425F44BEA
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Jan 2023 04:45:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id s3so997749pfd.12
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Jan 2023 04:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQBrpKdtF81iXahPtF6gU+IPWtlOgCZq7sNUlQBczDo=;
        b=bMI2xEvHCOBw/DZewO0k/Ohq8kIIP0JsaF9SK+iKCGjS02Wctxn9Cpbg7nMZTWw4eo
         XMnIG7omfgGfipSH/PwDeD2VN9IbaN33PADGKe7AcdrD6rNcHGvT47rsach+HUEljG11
         5onzj/nepw/GneyCzttuxs+dCX4TrpY7Qo2m4EwaI7DShRo/h9jt/7IrbPPSRJ6yRP8s
         rEEuKGWyI8Kaivq9ZRD4r4TddEwUBMmNPsL5gX2Ll5Wo/ek0aXFrJvp43pbAk5mLbujN
         p4XUwrThc4HV+9qvC8W+r1UfftvM/s+cBSCOkoURSaQHwe/EOwG0H6oXugxuUTu3FXgB
         DP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQBrpKdtF81iXahPtF6gU+IPWtlOgCZq7sNUlQBczDo=;
        b=0BKeBOcxdiJ2E4+nKUq7ZOarwUBRDuFJG2o9mLK2mpynfa1j8bxz9xTXcDS+amU+Ec
         Pugx0jT+DH5QxpDywNnMgc6nYQPouDDe1UVieKZ8vBbydLwEL2RXgDQkUiSA/wO7mAW0
         1nnFsWG7efljoDrQCQZV9POAhVnYJgzODGB7cJnjnnOhHDiO+rjSQzUfvsvZZgn2PQnI
         BvN8PyfyKniAKo7xsFfcA/yEsYf41vBn4RpsKiZr9uc81QDQPMV4fzajMwnwsPKavoyU
         CCs6snk4ZViPPo2KvvOscvklKEEgQqqZMQfdwBJAKf542vXASpqL1XhAbDpAk++5zGJ+
         nvJw==
X-Gm-Message-State: AO0yUKVXhdmnrY7HF2jWQjGEIT/DUDBMZXJ4008VdFeO42otQGqAaUj/
        rABEw0nrN8qSIKeJnmYSF5JL5Sn6kaUvMriEV2M1hg==
X-Google-Smtp-Source: AK7set9GuXW5qS1QMdZByaefsiV9jzqn+8eQhW82mxF+fn13Cl4JPjXgS1YfrESUzXLoFDvulLlEMDcFbmdOeUlwdNQ=
X-Received: by 2002:a63:a5c:0:b0:4d9:8f35:e0c with SMTP id z28-20020a630a5c000000b004d98f350e0cmr858530pgk.89.1674737148966;
 Thu, 26 Jan 2023 04:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org> <ac3ed1da-fcd1-d8e9-7770-8a047f0e392d@linaro.org>
In-Reply-To: <ac3ed1da-fcd1-d8e9-7770-8a047f0e392d@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Jan 2023 13:45:12 +0100
Message-ID: <CAPDyKFr9ePUvi-h_jJByrfsBKp+Mu+oyn=qcgp=Ta_jjygEeLw@mail.gmail.com>
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, 25 Jan 2023 at 17:46, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Krzysztof,
>
>
> On 25/01/2023 12:34, Krzysztof Kozlowski wrote:
> > The runtime Power Management of CPU topology is not compatible with
> > PREEMPT_RT:
> > 1. Core cpuidle path disables IRQs.
> > 2. Core cpuidle calls cpuidle-psci.
> > 3. cpuidle-psci in __psci_enter_domain_idle_state() calls
> >     pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
> >     spinlocks (which are sleeping on PREEMPT_RT).
> >
> > Deep sleep modes are not a priority of Realtime kernels because the
> > latencies might become unpredictable.  On the other hand the PSCI CPU
> > idle power domain is a parent of other devices and power domain
> > controllers, thus it cannot be simply skipped (e.g. on Qualcomm SM8250).
> >
> > Disable the idle callbacks in cpuidle-psci and mark the domain as
> > always on.  This is a trade-off between making PREEMPT_RT working and
> > still having a proper power domain hierarchy in the system.
>
> Wouldn't make sense to rely on the latency constraint framework ?

The main problem is that for runtime PM there is a per device spinlock
being used, which becomes a sleepable lock on PREEMPT_RT.

In other words, the only simple solution is to avoid the calls to
runtime PM in the idle path.

[...]

Kind regards
Uffe
