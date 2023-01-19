Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F23C6379F
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Jan 2023 18:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjASSmk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjASSmi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Jan 2023 13:42:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351C37F17
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 10:42:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id q10so2773843wrs.2
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Jan 2023 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yl655zxTlgKELJ7swQ9SsdqOuQT3cGOOSK8xkhPG2HU=;
        b=xBUP8DNf2arziCDahO9pk12ouk+PsskloAOQBC50IXTwelJgqpyn3nieGTuaG8+Ibe
         VGeIMw04x2WMAIh09ApFbjnoGrdSwJ/nrQIncdDHA2gkOjTyamuGDWhmP9RhmrS3PaUL
         FPuzu0/9zO2xF/7q3fELemdpSWVWc07FUjAMHQncnlJFB8IAUW2KIl20F4PQLUYUu0ZP
         6gXoZZsfybADlm+5xZjK5RL/s1jHRkfac6j6LUycFIfz/G7VQI4mOkJv7LeqTEllgLWo
         4P1qWB+7FfJu5oAqjnEduXhMHFmlLmCwcL/lUyZmd7XtyKZsS1RdJBHBBu4mCLHyGRqE
         F0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl655zxTlgKELJ7swQ9SsdqOuQT3cGOOSK8xkhPG2HU=;
        b=iLK6rN7Q8CpQE1VN+LqXLoS+TpivEAGE07J02Tq0mI29FwPCS9On1KMGE1JfO+XA4s
         VK7zKA/3W3PU97WJpQRiFjLLtyqNp+XyKKWr8f3xZDlGUM/dOhIg0oglBBiBuF183DfX
         AohT0T0iti9anrxTgx8152goUda5s6UrK7Zb+lF6dgpDgfslBQeFwQbgndjvnZy02zpv
         skmOMZo+O/rF0JWT7LQT/pLJI7tt19zppLVkanWqQXJtEtzy3ZBvZ2P/r+rpAITFY4/X
         Ke2EHHU2w8WRZnr4c711/N135yF89glVh13CH1HxGb2vY1ZM9q6S/qmETq7S9+Vgvk/C
         nOkQ==
X-Gm-Message-State: AFqh2koGNjQynw+relPDtwnys1p4XsRaFWPA4Akv6bZYCrg02TqEVFY7
        QGaf9xcxemkrXGrwaJwKVLnkVw==
X-Google-Smtp-Source: AMrXdXsNVX1Zn89uw1K4g/OFWItkRWvguxRz92nMDKqyqmJCDwfcv/k8QdIe+EOUorPW7tOKQuQgNw==
X-Received: by 2002:adf:a318:0:b0:2bd:dc0c:ffd1 with SMTP id c24-20020adfa318000000b002bddc0cffd1mr10185811wrb.13.1674153754017;
        Thu, 19 Jan 2023 10:42:34 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q18-20020adfdfd2000000b002bdc129c8f6sm22865410wrn.43.2023.01.19.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:42:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v3] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
Date:   Thu, 19 Jan 2023 19:42:28 +0100
Message-Id: <20230119184228.683892-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The runtime Power Management of CPU topology is not compatible with
PREEMPT_RT:
1. Core cpuidle path disables IRQs.
2. Core cpuidle calls cpuidle-psci.
3. cpuidle-psci in __psci_enter_domain_idle_state() calls
   pm_runtime_put_sync_suspend() and pm_runtime_get_sync() which use
   spinlocks (which are sleeping on PREEMPT_RT).

Deep sleep modes are not a priority of Realtime kernels because the
latencies might become unpredictable.  On the other hand the PSCI CPU
idle power domain is a parent of other devices and power domain
controllers, thus it cannot be simply skipped (e.g. on Qualcomm SM8250).

Disable the runtime PM calls from cpuidle-psci, which effectively stops
suspending the cpuidle PSCI domain.  This is a trade-off between making
PREEMPT_RT working and still having a proper power domain hierarchy in
the system.

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Re-work commit msg.
2. Add note to Kconfig.

Several other patches were dropped, as this is the only one actually
needed.  It effectively stops PSCI cpuidle power domains from suspending
thus solving all other issues I experienced.
---
 drivers/cpuidle/Kconfig.arm    | 3 +++
 drivers/cpuidle/cpuidle-psci.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 747aa537389b..24429b5bfd1c 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -24,6 +24,9 @@ config ARM_PSCI_CPUIDLE
 	  It provides an idle driver that is capable of detecting and
 	  managing idle states through the PSCI firmware interface.
 
+	  The driver is not yet compatible with PREEMPT_RT: no idle states will
+	  be entered by CPUs on such kernel.
+
 config ARM_PSCI_CPUIDLE_DOMAIN
 	bool "PSCI CPU idle Domain"
 	depends on ARM_PSCI_CPUIDLE
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 312a34ef28dc..c25592718984 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -66,7 +66,7 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
 	if (s2idle)
 		dev_pm_genpd_suspend(pd_dev);
-	else
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		pm_runtime_put_sync_suspend(pd_dev);
 
 	state = psci_get_domain_state();
@@ -77,7 +77,7 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 
 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
-	else
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		pm_runtime_get_sync(pd_dev);
 
 	cpu_pm_exit();
-- 
2.34.1

