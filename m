Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C25BC54E94
	for <linux-rt-users@archiver.kernel.org>; Wed, 25 Jan 2023 11:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjAYLer (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 25 Jan 2023 06:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjAYLe0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 25 Jan 2023 06:34:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F075D15C82
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Jan 2023 03:34:24 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m7so3073335wru.8
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Jan 2023 03:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QYojRCCtYlJhvbj3M9r4VzNWk15cQ6A9mCCL7h6cqs=;
        b=tM3TcsMUWq0ATsaki5PPF59y/iPtsRn3LI8ChlBOT16wCaHLeLiTV8DDwyuI3Hukcz
         MaR6lSYLCjvFoAPegdg4pLiIMAWFdk9D8O0JmNrmuKsOZvjuyvolpxaCzTi5QUoZs6BP
         JW/tDHKxFwyGtgkGpqFpi/HNOK8tDPn2YBfWGWJ4T8rFcLptFgdka6NgIcF2V0xWR02h
         VWcoQ+d+32zt7qWfr5WNeLWNwUCFe7ahUbVXTK4pgD70W1FK6tu7ObQ1h9P7MhKGXqvM
         CxPmI+QKnUF9DELrMsqsjFJtUZ9XR+qtZQ5d1X6hmSMee1vDsSKxSjj7fJNR3ukkC9Or
         gXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QYojRCCtYlJhvbj3M9r4VzNWk15cQ6A9mCCL7h6cqs=;
        b=Bql7aQM94VxWvfu20sYX/px9+GGZpFjnkdLA29q4p9b6S6IUmSKTQY7+Mdztp1ryDJ
         bKcCo6GPdIIXCpPf1fMVvMYMRCFZp1vN2DQXa9ip2l/jr/f/GLAZVMj2z4hZ3NemAgWh
         q7w5asHmgUVNY5hHFv8fl1AnDI3qRt9AiMOvn8Tl0sRYLckLZCDrczH42N7ol+6kRbP9
         kJUMRA6fx4VCcSuD8U/gh1HVN58XPmn+qXkNaRgRS+JbmHaVfcZzFrQzQqQzstB7xmLX
         9L7VcqZ5Qhkev4ztrhom15oOl1CsDwWBT9xfobTzezOIREw5yuqADeb9WLBJEkwHff4P
         /vQw==
X-Gm-Message-State: AO0yUKUNnyS0p2gvE+s0vLLEb0sxK4hsDXDUzNPTU9hJ8oCwdJ0p+Xvv
        zB2wJutlsCW205JQi98LMY0DuQ==
X-Google-Smtp-Source: AK7set9VpIH0D3BN4cRVxVqYN7JNRSMgys2I74WBhgAJEIQBNvqfmyMUGW9z20vMf24lhEQK0WRgNg==
X-Received: by 2002:adf:dd12:0:b0:2bf:afdf:13db with SMTP id a18-20020adfdd12000000b002bfafdf13dbmr4795182wrm.47.1674646463364;
        Wed, 25 Jan 2023 03:34:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4ed2000000b002bde537721dsm4213759wrv.20.2023.01.25.03.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 03:34:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
Date:   Wed, 25 Jan 2023 12:34:18 +0100
Message-Id: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
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

Disable the idle callbacks in cpuidle-psci and mark the domain as
always on.  This is a trade-off between making PREEMPT_RT working and
still having a proper power domain hierarchy in the system.

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v3:
1. Rework - disable idle states, mark as always on (Ulf).
2. Extend Kconfig warning (Ulf).

Changes since v1:
1. Re-work commit msg.
2. Add note to Kconfig.

Several other patches were dropped, as this is the only one actually
needed.  It effectively stops PSCI cpuidle power domains from suspending
thus solving all other issues I experienced.
---
 drivers/cpuidle/Kconfig.arm           | 8 ++++++++
 drivers/cpuidle/cpuidle-psci-domain.c | 7 +++++--
 drivers/cpuidle/cpuidle-psci.c        | 3 +++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 747aa537389b..8deaa2e05206 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -24,6 +24,14 @@ config ARM_PSCI_CPUIDLE
 	  It provides an idle driver that is capable of detecting and
 	  managing idle states through the PSCI firmware interface.
 
+	  The driver has limitations when used with PREEMPT_RT:
+	  - If the idle states are described with the non-hierarchical layout,
+	    all idle states are still available.
+
+	  - If the idle states are described with the hierarchical layout,
+	    only the idle states defined per CPU are available, but not the ones
+	    being shared among a group of CPUs (aka cluster idle states).
+
 config ARM_PSCI_CPUIDLE_DOMAIN
 	bool "PSCI CPU idle Domain"
 	depends on ARM_PSCI_CPUIDLE
diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index c80cf9ddabd8..6ad2954948a5 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -64,8 +64,11 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 
 	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
 
-	/* Allow power off when OSI has been successfully enabled. */
-	if (use_osi)
+	/*
+	 * Allow power off when OSI has been successfully enabled.
+	 * PREEMPT_RT is not yet ready to enter domain idle states.
+	 */
+	if (use_osi && !IS_ENABLED(CONFIG_PREEMPT_RT))
 		pd->power_off = psci_pd_power_off;
 	else
 		pd->flags |= GENPD_FLAG_ALWAYS_ON;
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 312a34ef28dc..6de027f9f6f5 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -222,6 +222,9 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	if (!psci_has_osi_support())
 		return 0;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return 0;
+
 	data->dev = psci_dt_attach_cpu(cpu);
 	if (IS_ERR_OR_NULL(data->dev))
 		return PTR_ERR_OR_ZERO(data->dev);
-- 
2.34.1

