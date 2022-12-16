Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE521C4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Dec 2022 10:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLPKU1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLPKUZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Dec 2022 05:20:25 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F5236C55
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Dec 2022 02:20:24 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y25so2754312lfa.9
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Dec 2022 02:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXLwuG2ES9YsBUnvXZ4iNqCmom6VONPXoTbb+R4XyYE=;
        b=f0ptqrcUjHpXFvbGCXXcuELvSFgXRRsHJvjUin6ydG+ZZgt2l5b32J4NH6D9GkagHt
         MxYjeOYzw5Fxm+09qVb9eh6+oj19g5/bpmyQ/7IuMIxEFIKMYXutZlU6hwRIIP18EYxN
         IHXv/aeMODitj2XB5yyGCcpjFEsk8M8hodi59cFUDdeyaSo43Pa6sIfkJlfyqTG8SoEP
         wfXQ3SiYpZnCdDIet352VOZ39X9ZO4XT8W3w+0jEcECjP3BuaXODqtSW31PODOcUbPV1
         QU2Ov+nz7cGnR9oFlZKuJbzpAy/d4CE/vLW4p+AlstbiJeqKPMb1goCTGtdtQbKl8sOa
         KtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXLwuG2ES9YsBUnvXZ4iNqCmom6VONPXoTbb+R4XyYE=;
        b=wx6dNq4ubLSyZHw87LZ9YgYAvn50gsvQEN0h2yc8oX3dFSPMnTKWSkVCVtyvqjU15x
         KwvaAABkBG+CCLdX+BSr513rZN7u2dRzm2MTuCdOKGHlYZjCfi4ydAoJCCxj8mUViAlK
         JUYxcTaqMscdcnJ0zU47Lc2m6HPM36myivOHx4RqMXzIMbpguLjDdFfHvlH7dA8FKbr+
         9N1C8X0hmsBZONet1VZuGvxhOwIYlfQdh/NYcZDjcvYbZ7hlVxNqa0ho0Hxy8UQ3tP/w
         OgI6SYEjAxu28SHNJ0yCEMpVdcV2/2Q6GUVyNpnelj+wRbF8wjooDuEaUIpVpX1kAMVo
         X/+Q==
X-Gm-Message-State: ANoB5pmWqGcELgcPmWBciKJhjzt9O1wPmrvZsAMW7fofsx9ggMHNagrZ
        owSXI+fPubTNGVBI6PLa5GgpvA==
X-Google-Smtp-Source: AA0mqf7JccL0NaLEUm1TWH37w4VIiZYqkO5I7s5GVGnjDzkT922ouNfUqRbSMWarqik1MzR4m+cvVg==
X-Received: by 2002:a05:6512:3caa:b0:4b5:7f79:f8bd with SMTP id h42-20020a0565123caa00b004b57f79f8bdmr13397292lfv.22.1671186022382;
        Fri, 16 Dec 2022 02:20:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i6-20020a2ea366000000b0027eb5903568sm117195ljn.72.2022.12.16.02.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 02:20:21 -0800 (PST)
Message-ID: <cefad5f6-8aa4-acb8-231c-91170ec10bcf@linaro.org>
Date:   Fri, 16 Dec 2022 11:20:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH RFC] base: power: replace generic_pm_domain spinlock by
 raw spinlock
To:     Adrien Thierry <athierry@redhat.com>,
        linux-rt-users@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Brian Masney <bmasney@redhat.com>, linux-pm@vger.kernel.org
References: <20220615203605.1068453-1-athierry@redhat.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220615203605.1068453-1-athierry@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 15/06/2022 22:36, Adrien Thierry wrote:
> We've been encountering a BUG: scheduling while atomic while running the
> 5.18.0-rt11 kernel on a Qualcomm SoC (see stacktrace below).
> 
> It seems to occur because a spinlock is taken in the PSCI idle code path
> in the idle loop. With the RT patchset applied and CONFIG_PREEMPT_RT
> enabled, spinlocks can sleep, thus triggering the bug.
> 
> In order to prevent this, replace the generic_pm_domain spinlock by a
> raw spinlock.
> 
> [    2.994433] BUG: scheduling while atomic: swapper/6/0/0x00000002
> [    2.994439] Modules linked in:
> [    2.994447] [<ffff80000810b0ec>] migrate_enable+0x3c/0x160
> [    2.994461] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.18.0-rt11+ #1
> [    2.994464] Hardware name: Qualcomm SA8295P ADP (DT)
> [    2.994466] Call trace:
> [    2.994467]  dump_backtrace+0xb0/0x120
> [    2.994473]  show_stack+0x1c/0x6c
> [    2.994477]  dump_stack_lvl+0x64/0x7c
> [    2.994483]  dump_stack+0x14/0x2c
> [    2.994487]  __schedule_bug+0xa8/0xc0
> [    2.994489]  schedule_debug.constprop.0+0x154/0x170
> [    2.994492]  __schedule+0x58/0x520
> [    2.994496]  schedule_rtlock+0x20/0x44
> [    2.994499]  rtlock_slowlock_locked+0x110/0x260
> [    2.994503]  rt_spin_lock+0x74/0x94
> [    2.994505]  genpd_lock_nested_spin+0x20/0x30

Hi Adrian,

I also hit it now on v6.1 RT kernel. I see no more discussions happened
here. Do you have any progress on your side for this issue?

Best regards,
Krzysztof

