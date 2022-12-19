Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43260C46467
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Dec 2022 15:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiLSPPY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiLSPPR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Dec 2022 10:15:17 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC5EF580
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Dec 2022 07:15:15 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so14152328lfb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Dec 2022 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2D0MZ2hxPTHwXNnho8HOkobrXZQciZPG6h42YTOjRw=;
        b=ucUJppIgRBgtpDQOSNoFKkTpre/wj89djnkxbJXoXfrK0vOY/QJLX1iUpqT5cY5qV/
         GF+Dl82w3xJ9mA3oFvYtRV0YhivF59Kq+GNvnC3Jqv4aY+ohv2cJJWZlvBeaEZEzK6ou
         HIlLEZWK5gd1rofobutljGLWfO3nULqGfRQ0ICl88S/eoknin4PISCvnL7lw7XSStvto
         AE4nkyesvYnJaizYJIHpktZOUcmnuiuncKvdsRPUYSWCKWWwaxvzUs4Jljp2D+ucASqX
         xQDAJUDjIsYIBgPxGqZ7U5LO8uF94J/koNWBdV2fQu+agiJ3nra/ype6SXUSompNmfk6
         bBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2D0MZ2hxPTHwXNnho8HOkobrXZQciZPG6h42YTOjRw=;
        b=peg068dHw4G96Thmr0VHHe1/vqhtyjRX2GPB4fhGFz2qHRlYgw4oFbupWqdY4Czxoo
         ccjWXvhODtF+gWuVk2TBbQVgXGrFeEskn3uX72cSOsLzFi/NFs1PcsiCOCy1vtD1BZVP
         r6TTzxkmCQNji9lsE+45RWlVqfpO46Kso9RCfKF97oJMaoU8Lp4lNk3wlRm1FKEIyAbV
         CSBbp6er9WLL5Fw4xYhDYGtWF0M8dr/ju/C39TKv4NwdgR1X+BgQsGpK6S5BCE1BuEzr
         +xBCbn3RProiHaN3qyUNK4+CPcdh/Nlo6ed6O3gbzggrlD2ufFQTEUKMszDjhVa7R2Ob
         90hw==
X-Gm-Message-State: ANoB5pmA/K7ueJh6vxsl4nrJx+Om3bK4YMBsNeQc5yu2/tUX+pYNLNXN
        mY3C079c+MbviZNZtK2M7S/iiQ==
X-Google-Smtp-Source: AA0mqf7n/NP8HRaYuYDbxI6GABLuMF7vUSdWaQUoDWCU0hAjFOQml5a/3nwbg+N3+37H31i1a6Yv2A==
X-Received: by 2002:a05:6512:a94:b0:4b7:113:9296 with SMTP id m20-20020a0565120a9400b004b701139296mr14233163lfu.14.1671462915529;
        Mon, 19 Dec 2022 07:15:15 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004bd8534ebbcsm1109894lfs.37.2022.12.19.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 07:15:15 -0800 (PST)
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
Subject: [PATCH v2 4/5] PM: Allow calling dev_pm_domain_set() with raw spinlock
Date:   Mon, 19 Dec 2022 16:15:02 +0100
Message-Id: <20221219151503.385816-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

device_pm_check_callbacks() uses dev->power spinlock, which on
PREEMPT_RT sleeps.  However some PM domains on PREEMPT_RT might be using
raw spinlocks as genpd_lock(), thus dev_pm_domain_set() must not call
device_pm_check_callbacks().  In fact device_pm_check_callbacks() is not
strictly related to dev_pm_domain_set() and calls for these two can be
made separately.

Add new helper dev_pm_domain_set_no_cb() which will only set PM domain
but will not check the callbacks, leaving the checl to the caller.

Cc: Adrien Thierry <athierry@redhat.com>
Cc: Brian Masney <bmasney@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/base/power/common.c | 27 +++++++++++++++++++++++++--
 include/linux/pm_domain.h   |  3 +++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 72115917e0bd..f81cab6990ad 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -218,6 +218,30 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_start);
  * This function must be called with the device lock held.
  */
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
+{
+	if (dev->pm_domain == pd)
+		return;
+
+	dev_pm_domain_set_no_cb(dev, pd);
+	device_pm_check_callbacks(dev);
+}
+EXPORT_SYMBOL_GPL(dev_pm_domain_set);
+
+/**
+ * dev_pm_domain_set_no_cb - Set PM domain of a device.
+ * @dev: Device whose PM domain is to be set.
+ * @pd: PM domain to be set, or NULL.
+ *
+ * Sets the PM domain the device belongs to. The PM domain of a device needs
+ * to be set before its probe finishes (it's bound to a driver).
+ *
+ * This is exactly like dev_pm_domain_set(), however device_pm_check_callbacks()
+ * is not called and the caller is responsible to invoke
+ * device_pm_check_callbacks() with device lock held.
+ *
+ * This function must be called with the device lock held.
+ */
+void dev_pm_domain_set_no_cb(struct device *dev, struct dev_pm_domain *pd)
 {
 	if (dev->pm_domain == pd)
 		return;
@@ -225,6 +249,5 @@ void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd)
 	WARN(pd && device_is_bound(dev),
 	     "PM domains can only be changed for unbound devices\n");
 	dev->pm_domain = pd;
-	device_pm_check_callbacks(dev);
 }
-EXPORT_SYMBOL_GPL(dev_pm_domain_set);
+EXPORT_SYMBOL_GPL(dev_pm_domain_set_no_cb);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 0a1600244963..352d0c76bfec 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -438,6 +438,7 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 int dev_pm_domain_start(struct device *dev);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
+void dev_pm_domain_set_no_cb(struct device *dev, struct dev_pm_domain *pd);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
@@ -460,6 +461,8 @@ static inline int dev_pm_domain_start(struct device *dev)
 }
 static inline void dev_pm_domain_set(struct device *dev,
 				     struct dev_pm_domain *pd) {}
+static inline void dev_pm_domain_set_no_cb(struct device *dev,
+					   struct dev_pm_domain *pd) {}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
-- 
2.34.1

