Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA15C4332F
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Dec 2022 15:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiLSPP1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiLSPPS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Dec 2022 10:15:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F7D11816
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Dec 2022 07:15:17 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b13so14138215lfo.3
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Dec 2022 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8Uj/f0x4H68pfp6EBuS49q8mUm/dd1ntZTx2c5gQRw=;
        b=joGdkJgxChVHrhqXxh4D8sJDaKpzxBgUcFgLtPczIcYGrPWnS0gYSfGGb/xwur1BZA
         HXUG1BhIHBctF7bFBpebP9+UCrd1/wX6sQ06q9+cIYwobrrc2Zzo3WsBKRD3558LWzFQ
         /N47j8fJwjN1I4eRjd0Qr07xS6EOzoIv8QhoPs4d+muMgyaWlNH3o7v1b1Xr6gxm8Bsn
         zsRaxMej9uybQ/82hjh0l+j0+akCnf8EYggcdPI5wQ4zTU9cGGyx+pH3DhxSdkmYX4n/
         boQmP89KDmwLe8i18IoxJ121DOicW9mnYp04EIuXSuoqBPamMqwF9q353kDRDAlSKDOO
         ifvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8Uj/f0x4H68pfp6EBuS49q8mUm/dd1ntZTx2c5gQRw=;
        b=tYfOJjBhX4kWt6vWEfVuxF8m5j2HsQBhqsXwC1YlTa9VRqUByxtss5stKmSuYI/OwY
         BqpYZlOHwzk0HR49KRFnFp9bto4OiKaU/1th6w+Jz8omG85LUPe2QonZ8YrHRPPJ3tj0
         gJac/BT8EuIVZHXF8ulkMKKfwuSykDo4dBkgqM5cX16Qf2gYHssLQD+nuJxj1jUDjvwy
         MppZMWRFfQv7hNIip/KYEAu2d+KpD7ItracIQ57LYwfIjxmI5Fqm9jUVTd1N0xi5RxC1
         0wNOHDr61DNHGMPqv3LCff4+92HY02P8KpIrGCukwbvHmlC1Kx5kwIvY5GVFFQxLjeXL
         BQSw==
X-Gm-Message-State: ANoB5plcx/Dcn3njTVyL1mWyw4BgzvSwc+7jSCUY4K8876T1vrmwGLzZ
        Ev67y2TuoVW2wu2E6UsTpzp9Rg==
X-Google-Smtp-Source: AA0mqf6TIA7wSK78A1e7LxWcZY/ah0RMdr0IMbRzO6DwrSrVhPg3kDS+rfPE3kSDU9y+6k9YFRKeKw==
X-Received: by 2002:a05:6512:2c85:b0:4a4:68b9:607f with SMTP id dw5-20020a0565122c8500b004a468b9607fmr11616697lfb.10.1671462916643;
        Mon, 19 Dec 2022 07:15:16 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004bd8534ebbcsm1109894lfs.37.2022.12.19.07.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:15:16 -0800 (PST)
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
Subject: [PATCH v2 5/5] PM: domains: Do not call device_pm_check_callbacks() when holding genpd_lock()
Date:   Mon, 19 Dec 2022 16:15:03 +0100
Message-Id: <20221219151503.385816-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If PM domain on PREEMPT_RT is marked as GENPD_FLAG_RT_SAFE(), the
genpd_lock() will be a raw spin lock, thus device_pm_check_callbacks()
must be called outside of the domain lock.

This solves on PREEMPT_RT:

  [ BUG: Invalid wait context ]
  6.1.0-rt5-00325-g8a5f56bcfcca #8 Tainted: G        W
  -----------------------------
  swapper/0/1 is trying to lock:
  ffff76e045dec9a0 (&dev->power.lock){+.+.}-{3:3}, at: device_pm_check_callbacks+0x20/0xf0
  other info that might help us debug this:
  context-{5:5}
  3 locks held by swapper/0/1:
   #0: ffff76e045deb8e8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x38/0x1c0
   #1: ffffa92b81f825e0 (gpd_list_lock){+.+.}-{4:4}, at: __genpd_dev_pm_attach+0x7c/0x250
   #2: ffff76e04105c7a0 (&genpd->rslock){....}-{2:2}, at: genpd_lock_rawspin+0x1c/0x30
  stack backtrace:
  CPU: 5 PID: 1 Comm: swapper/0 Tainted: G        W          6.1.0-rt5-00325-g8a5f56bcfcca #8
  Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
  Call trace:
   dump_backtrace.part.0+0xe0/0xf0
   show_stack+0x18/0x40
   dump_stack_lvl+0x8c/0xb8
   dump_stack+0x18/0x34
   __lock_acquire+0x938/0x2100
   lock_acquire.part.0+0x104/0x28c
   lock_acquire+0x68/0x84
   rt_spin_lock+0x40/0x100
   device_pm_check_callbacks+0x20/0xf0
   dev_pm_domain_set+0x54/0x64
   genpd_add_device+0x258/0x340
   __genpd_dev_pm_attach+0xa8/0x250
   genpd_dev_pm_attach_by_id+0xc4/0x190
   genpd_dev_pm_attach_by_name+0x3c/0x60
   dev_pm_domain_attach_by_name+0x20/0x30
   dt_idle_attach_cpu+0x24/0x90
   psci_cpuidle_probe+0x300/0x4b0
   platform_probe+0x68/0xe0
   really_probe+0xbc/0x2dc
   __driver_probe_device+0x78/0xe0
   driver_probe_device+0x3c/0x160
   __device_attach_driver+0xb8/0x140
   bus_for_each_drv+0x78/0xd0
   __device_attach+0xa8/0x1c0
   device_initial_probe+0x14/0x20
   bus_probe_device+0x9c/0xa4
   device_add+0x3b4/0x8dc
   platform_device_add+0x114/0x234
   platform_device_register_full+0x108/0x1a4
   psci_idle_init+0x6c/0xb0
   do_one_initcall+0x74/0x450
   kernel_init_freeable+0x2e0/0x350
   kernel_init+0x24/0x130
   ret_from_fork+0x10/0x20

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/base/power/domain.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4dfce1d476f4..db499ba40497 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1666,10 +1666,14 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (ret)
 		goto out;
 
+
+	/* PREEMPT_RT: Must be outside of genpd_lock */
+	device_pm_check_callbacks(dev);
+
 	genpd_lock(genpd);
 
 	genpd_set_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, &genpd->domain);
+	dev_pm_domain_set_no_cb(dev, &genpd->domain);
 
 	genpd->device_count++;
 	if (gd)
-- 
2.34.1

