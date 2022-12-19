Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E1C4332F
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Dec 2022 15:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiLSPPP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiLSPPN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Dec 2022 10:15:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A57BF45
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Dec 2022 07:15:12 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id q6so14075527lfm.10
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Dec 2022 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBscDX32Qyn/0CwIAUKmTYxHhuxi4NwStBcWmmpiMug=;
        b=zFNgrdyF+mttnjY4vXjQS7/2/LOBBOMHjS4QQ1GQbSuki5CJHo1Sc7vndREPKidnCJ
         W52Uiaf5xR/3oRbV4gtSZjKNFGnAIz0KnLbAlhSTpGewIrVz5WYC8LI07G/K1i0lCW5n
         HFIMShYHlST+6CBpC6TxoNsPBLs14k7BSeaywzbVWHMmUiZXtgIsNowRmTtxSWFOhY/M
         SBwRlymqHmjH4Il/F4uADvtt/6aj6Vl6onDta5RS/Ez8DmrpXHXRzGhARbJn7VOXXnfO
         mGakFNEnt86QOoBuSGd79CM6yRoysSWFOr/4VLZBrR4Yk5MYhR9C0GnfKKx8p5128QrB
         jRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBscDX32Qyn/0CwIAUKmTYxHhuxi4NwStBcWmmpiMug=;
        b=wXfTBMWp+vqiQIw4YCK8NZ436Q8d8y7LXcgCmoya+ReZm63suG2i/f5hxoBXe0tYVQ
         zb93pBYR9sMKAMcrVQWqr0/4XyGixC1hDhzVR3qt7TsdVdCo1z8AvDaYG4wYc75cfHUa
         dtkiFfD83bG7xT4wIsItcAa2xildZ7IEFF6F/xVNeqWy0hRpkUWeSB96w+LIDaCyyZYB
         +Adifd428gXHkNnYE0rDgI22Z6zxE+U4VEL9wMk+++a/acBIb0xYm0AJjJuzH0LQjKFO
         dNYvD6A4veFP4h4+Ot0kMvkNGV/j6QC88Pi32g4qom2nlYSdqlF++V/ZKyHK3J+t78sV
         Cbew==
X-Gm-Message-State: ANoB5pkN8kHiTVAJsc/3UKEE0mtm5r8gPcv4Bb6pZ0Uprj5HXpGknnVz
        F3DY4hmQA1hLlpl92RfNODbk9g==
X-Google-Smtp-Source: AA0mqf5UKUVcABReRnF5CXRK5v5ErUJaXMBrfO1u9voQcZQt9jDNWPYiCt5ftYFKFKtZJKWhskqvYA==
X-Received: by 2002:a05:6512:c09:b0:4b6:e64c:aec6 with SMTP id z9-20020a0565120c0900b004b6e64caec6mr12127074lfu.63.1671462910742;
        Mon, 19 Dec 2022 07:15:10 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004bd8534ebbcsm1109894lfs.37.2022.12.19.07.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:15:10 -0800 (PST)
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
Subject: [PATCH v2 0/5] PM: Fixes for Realtime systems
Date:   Mon, 19 Dec 2022 16:14:58 +0100
Message-Id: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

The goal is to make Linux kernel PM / PM domains / cpuidle friendlier for
Realtime systsems (PREEMPT_RT).  Realtime changes regular spinlocks into
sleeping primitives, thus other parts of the code must be ready for it.

Changes since v1
================
1. Patch #1: Add missing WARN for parent domain
2. New patches 3-5 for other issues encountered with PREEMPT_RT.

Best regards,
Krzysztof

---

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Cc: linux-rt-users@vger.kernel.org

Krzysztof Kozlowski (5):
  PM: domains: Add GENPD_FLAG_RT_SAFE for PREEMPT_RT
  cpuidle: psci: Mark as PREEMPT_RT safe
  cpuidle: psci: Do not suspend topology CPUs on PREEMPT_RT
  PM: Allow calling dev_pm_domain_set() with raw spinlock
  PM: domains: Do not call device_pm_check_callbacks() when holding
    genpd_lock()

 drivers/base/power/common.c           | 27 ++++++++++-
 drivers/base/power/domain.c           | 65 +++++++++++++++++++++++++--
 drivers/cpuidle/cpuidle-psci-domain.c |  3 +-
 drivers/cpuidle/cpuidle-psci.c        |  4 +-
 include/linux/pm_domain.h             | 16 +++++++
 5 files changed, 107 insertions(+), 8 deletions(-)

-- 
2.34.1

