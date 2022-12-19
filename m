Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B689FC10F1B
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Dec 2022 15:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiLSPPT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiLSPPR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Dec 2022 10:15:17 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC90D2C8
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Dec 2022 07:15:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id q6so14075707lfm.10
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Dec 2022 07:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=710npLST/xPzuXiih2c1d9pFv9jXZIz92buQVuG0oAE=;
        b=uEio8RqgLj7kCKnMrT/ndnvx/qtape0C21ameHDn5oxR1frx1ZVQ/UjjKEP/ibeWWh
         /FrAeFueaLx7BNbF218RzyfLQhs6ts56jbLBL2inGVZ8II/hhK38SdmB46mvrjRjuhWs
         LneaquS3DyNt64GkklXVgbkS2zL9bf6bEp74uvqATEfY07UyjJTqmZM+QFcOLM4uy8Bo
         CE/mOMKX0Cwc47pRYdikRdnVWrHoU5LoezIzgPZcUuo1I6KJTFkMPX9rvq5ht+fmfcMC
         ONvGwjkQVW0VtSI8uJhE12tdg/7q+CM2fWOMU6PmvL3H+i1ZDUpFhpWuX439KLEKV4MS
         LZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=710npLST/xPzuXiih2c1d9pFv9jXZIz92buQVuG0oAE=;
        b=dyNXdCmxBoppx+bqJMsjJrB0JKfEdDbBrsi5HnD2QIoL0UfwfQ+VtMuak8yLNCONTW
         wn4+STI48/Yfr5x9DlHNogL4hzCVE0rWRxpqO5XeSq3oig0w/HEvhxDIWMwHEg/Z53pl
         i/Q8bQ7d3UqAaG2NvAq6siHDBG862ZDbJn0MTH3CLlyXegpIXegqkKMTn7qvulM1quw8
         MXEAkL5NqGse4dGMAX1RIk5XYXuNYgvqDRGMxnBjast76bXaya2QfY5wlkVEt6OnkNWz
         3DjqlHhef0Hczlkxk6R/8Uo867U5A0KRU6QSSlOQjGy+IV05uQfWRAZ3hJx5CJ/kLgDl
         ebWA==
X-Gm-Message-State: ANoB5pl874XSYVW81aduGBZ8qkjcclsxnoKIRF9VTeTnufyowo5ZKLpl
        B9paoxltgjFvagYm8/pZgPRKXQ==
X-Google-Smtp-Source: AA0mqf5O5lOshUMBMDUAarE8CUlxxQDab0aOfGYCt75u7yth94O0C4yTULqeDUE5eHe18yeibJ7oYw==
X-Received: by 2002:a05:6512:261b:b0:4b4:dd3d:4310 with SMTP id bt27-20020a056512261b00b004b4dd3d4310mr16841834lfb.19.1671462913205;
        Mon, 19 Dec 2022 07:15:13 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004bd8534ebbcsm1109894lfs.37.2022.12.19.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:15:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v2 2/5] cpuidle: psci: Mark as PREEMPT_RT safe
Date:   Mon, 19 Dec 2022 16:15:00 +0100
Message-Id: <20221219151503.385816-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The PSCI cpuidle power domain in power_off callback uses
__this_cpu_write() so it is PREEMPT_RT safe.  This allows to use it in
Realtime kernels and solves errors like:

  BUG: scheduling while atomic: swapper/2/0/0x00000002
  Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
  Call trace:
   dump_backtrace.part.0+0xe0/0xf0
   show_stack+0x18/0x40
   dump_stack_lvl+0x68/0x84
   dump_stack+0x18/0x34
   __schedule_bug+0x60/0x80
   __schedule+0x628/0x800
   schedule_rtlock+0x28/0x5c
   rtlock_slowlock_locked+0x360/0xd30
   rt_spin_lock+0x88/0xb0
   genpd_lock_nested_spin+0x1c/0x30
   genpd_power_off.part.0.isra.0+0x20c/0x2a0
   genpd_runtime_suspend+0x150/0x2bc
   __rpm_callback+0x48/0x170
   rpm_callback+0x6c/0x7c
   rpm_suspend+0x108/0x660
   __pm_runtime_suspend+0x4c/0x8c
   __psci_enter_domain_idle_state.constprop.0+0x54/0xe0
   psci_enter_domain_idle_state+0x18/0x2c
   cpuidle_enter_state+0x8c/0x4e0
   cpuidle_enter+0x38/0x50
   do_idle+0x248/0x2f0
   cpu_startup_entry+0x24/0x30
   secondary_start_kernel+0x130/0x154
   __secondary_switched+0xb0/0xb4

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index c80cf9ddabd8..d15a91fb7048 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -62,7 +62,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	if (!pd_provider)
 		goto free_pd;
 
-	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_RT_SAFE | \
+		     GENPD_FLAG_CPU_DOMAIN;
 
 	/* Allow power off when OSI has been successfully enabled. */
 	if (use_osi)
-- 
2.34.1

