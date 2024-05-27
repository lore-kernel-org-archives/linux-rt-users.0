Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C316FF48
	for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819977; cv=none; b=PecjieuN+BAiJl665AmWAVw0HgTmHJ4/bwqUu+XN6EsHXicz3MPV6/8ja+UPzS6sK0foCgtxa3uXq3kh3C4INKwxeP7aGnQjMwmS85c2P9MHMCcvfb3OsMXOtHCdtt6YNNm5EO6MiJyp4iVvRExkxJgRDDREeKOIWYzthyiQ+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819977; c=relaxed/simple;
	bh=hXWGDXaJCWWQtdpRlOhBueY5IthUY27xAjhv6lNOX6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9KDBGyAEM06HY+NAN9EI5kgwIRPXnSoWa2qTbdhIDLzhHJrGK3GERSypYiXsdXDhZD29gLtOA50l4qcvh+yHoHeERuZdM6LdhSkOW2T+fAz9qoxBheF81TOH0hVIGSmHu886+9sKAaD5DVh1Cfj6StzTBHgpm3klyj40Hx62XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nWAQus0f; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWAQus0f"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-529aa4e988aso2026608e87.0
        for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819974; x=1717424774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR5PKdQ2iHKXMf6EJDdAOgUvQYES8E8gefpFvCEDCJQ=;
        b=nWAQus0fy9L+dETwgVGRt95Fd/HyGy80hSyhzzMfSJdW2QCAp8wiNgbCeICilwPrP8
         uz/XXb0NJFviVZy62KY9akehNUDak2MCYByhNTdfiTm3rNFeHFYnc3mFnIoZEcoR05Qk
         j9bRyn9To56pt62qlsrAYzv7HvClbA4M0/S1WtD6w+JhpzC2F/jtQdKTTFK0PpZs9IoK
         GsK2SZzJ8X7ibJ/CgNMu2uzZ2NE44k6/rSFSzGMU0m6vZzVFOcMskZ8aQX/9++GRpaT9
         /NkdhLZhr6YskrD5A6VYc6QOXglUhoWHLyFsOtWMnWdt1tnHbBBCRsUk2QEUe6+pzQwd
         W4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819974; x=1717424774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR5PKdQ2iHKXMf6EJDdAOgUvQYES8E8gefpFvCEDCJQ=;
        b=qFyUFJjBtGYj4DgmgfGk7sjpYnInneXHyrVuK2UX1l8lRTx3x0M7DbaeTOHlDu4Xp1
         klh7zgjDgmHj3uMFhUwaArOQKR/RiZCrQBoy7bybFi2xNXc5GaS8cvsbi3/1e4aB5zrd
         fdB83ZkgTEgdgnS+Xq1dWRcTCeedqZKLJXltty/xa5WMaqpBlOyQkFIyck1UlWx/ZRc8
         QD53YNWmiPnLC7H8Ijl+Mhv/lb8N29+CrsCz1UZ/pyc+SW65pp8Q1PtQ0IF+HZHFTEFu
         QT3CLKN/K35eT+al6c38lGHxKUIxqWnPzRMPplnsSOUS0jf5mhJVcXfLRGrrBMfS1Oyu
         zldA==
X-Forwarded-Encrypted: i=1; AJvYcCXV0QOh7zutaq5qg52DBJerOIJyWoHe+w28WrEzb7y/zPTmyzcRWugoC5VgQR4BM+5iBGGHjkOiWh3dQAEKVfap6dOyYUcD9sjDPOok0UA=
X-Gm-Message-State: AOJu0YxymCo0ko44ulHeaaDuxUU4dyHajOAyIIALBjB1BDYi04Qrt6AK
	Lw6oDhUcxRJecYuX2znoZgaH67GyxnoLO3KnrVCBArU91s0rBwrX3im11acJozx4KoF/yZMVBWb
	+
X-Google-Smtp-Source: AGHT+IHN6I0KgOI+mMpRmfv9UvFiyCmUDcI287s6FVISxsXFeKqa2fx6vLJsUQQYAYOYjuyf/gP2Aw==
X-Received: by 2002:ac2:5a09:0:b0:523:88e9:9cd2 with SMTP id 2adb3069b0e04-529667cf983mr4822493e87.67.1716819973713;
        Mon, 27 May 2024 07:26:13 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:13 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
Date: Mon, 27 May 2024 16:25:54 +0200
Message-Id: <20240527142557.321610-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The domain-idle-states are currently disabled on a PREEMPT_RT based
configuration for the cpuidle-psci-domain. To enable them to be used for
system-wide suspend and in particular during s2idle, let's set the
GENPD_FLAG_RPM_ALWAYS_ON instead of GENPD_FLAG_ALWAYS_ON for the
corresponding genpd provider.

In this way, the runtime PM path remains disabled in genpd for its attached
devices, while powering-on/off the PM domain during system-wide suspend
becomes allowed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v2:
	- None.
---
 drivers/cpuidle/cpuidle-psci-domain.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index fae958794339..ea28b73ef3fb 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -67,12 +67,16 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 
 	/*
 	 * Allow power off when OSI has been successfully enabled.
-	 * PREEMPT_RT is not yet ready to enter domain idle states.
+	 * On a PREEMPT_RT based configuration the domain idle states are
+	 * supported, but only during system-wide suspend.
 	 */
-	if (use_osi && !IS_ENABLED(CONFIG_PREEMPT_RT))
+	if (use_osi) {
 		pd->power_off = psci_pd_power_off;
-	else
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
+	} else {
 		pd->flags |= GENPD_FLAG_ALWAYS_ON;
+	}
 
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
-- 
2.34.1

