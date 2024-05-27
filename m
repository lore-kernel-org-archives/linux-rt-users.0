Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3F16133C
	for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819976; cv=none; b=MVZTWdbRNuA0aO+8EwjZPVHfTSQay/4LAqz5M+3CeJY5aG3tJRwXWqz8cfOynl8q+6VIhgOtlyaE0y2ixDYddYiwHHJw7nHuZU9yaLFdX79ajg+eYxaYaHcAL079G73S4TuHbI6mqgwPFQQwThR214Mob1X5bJNlc3HZce5HDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819976; c=relaxed/simple;
	bh=6jcDQSRGQriKta5hxhLanAzBNZ/Jw6OPpaAHgN7aCBw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hEDA8+jRpg1BlSa87cX5k/q8pyZNg36E2j7oFJkZJNuft18BCnmXbRb9PnXU4G5Uf3sJZ6IOKZ/eTvAOpkxVayVHifXBE00qcXStLqwTKfKlTOKNbvwNCyrAiaKY3rQOjNT9jvCbXB4BS9uo+vnIss7KthLgH7FumP/olg+/XYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtRw8EjA; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtRw8EjA"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e9819a6327so6378781fa.1
        for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819969; x=1717424769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4/aOzZ0hsg6Et5+0deJCRjrlcbs+6p+P8Nfmbgr0Wg=;
        b=gtRw8EjAt5T/bRgN18LNqeQyURmvswT2q0HodrTvY2VWqxtHUbIPiBgGCY5XVu3e1b
         HfP1mW5EovML0K4Cah0WGitWs531Xr69eCzCrgUw0p74R11Jb96w1SE7UMQO1Wq6aG3j
         8dDJTEmRxQEwN1kCeOfDolwwWN5NQ13bEBASjNnLkVS5HJsDl3LT/zPg+TZZDLI21EQR
         sNFsMJRaOMndgqPc2WMsMeFvKjluJgakP946ZjJJ8jsMWSwclBju2AZQSUGjcMSC0M2z
         +intT+qaXtMk8H1HO3yf1YASVW+sgEJirAiYAfYdAL4orsYInz5JZIwRH4TOnQVroJHr
         nJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819969; x=1717424769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4/aOzZ0hsg6Et5+0deJCRjrlcbs+6p+P8Nfmbgr0Wg=;
        b=WhTM3YmIO7Cs+mFvdZN9FH4iEkEXL5gMaduJcULWiMzBSBSlsHtB6tpWMdc5b79Rjv
         3s0Kjnb/1w8AcFAWmtNAwOodpi2K6tvZT6YnVmd9Nj/qL0N4aRii7wqADWDtF/NF//8w
         nZ5Zrmos1ex72CRONlvu/UIPhF3307M2PhEQDgZq/ZSL05xXQiKO98j4SVzwuKQJe6FT
         zKcqrtPjuoB8fAWHYoA/twyE2utuNhXvYW9HTBQE3pPAoqr27aPmQ6bcV3wUJ5N7/Ytj
         hvE4fahtZB6HeXApvCm4fmKQDLgT2edD4GH3n9GCA4OHKw2QYeMH8N8kROAjw1EGdC1M
         CdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX0xazmioqJry+NoLumCexS7p1XM6sDUnRVg6zkXEGi9yIN+MYEwAhXi9L2kZAmW6kFvLRksZ7iahtn1BDfa9MgmRMs+BdTKwE9dD8jHI=
X-Gm-Message-State: AOJu0YyWqSZ+8Xe29x6UItUD4g00jDt67jid6TfZuUT/ZjX0ag61tNWQ
	A7h9wVALUekEgMcEmzupBOwdlVXDjUJI3KTFhG+Zo0laEGJpvuZmc3ILaMHhvds=
X-Google-Smtp-Source: AGHT+IH+Repiz1mD7Jsz8/a6LNVzHuU42Y7XwFI26a4ECpBnmSdsIFpuHAnpFl7oDQPNA9Ib/KtAhg==
X-Received: by 2002:a05:6512:3994:b0:522:2a2c:759e with SMTP id 2adb3069b0e04-5296420479emr6995769e87.6.1716819968484;
        Mon, 27 May 2024 07:26:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:07 -0700 (PDT)
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
Subject: [PATCH v2 0/7] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
Date: Mon, 27 May 2024 16:25:50 +0200
Message-Id: <20240527142557.321610-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates in v2:
	- Rebased and fixed a small issue in genpd, see patch3.
	- Re-tested on v6.9-rt5 (PREEMPT_RT enabled)
	- Re-tested on v6.10-rc1 (for regressions, PREEMPT_RT disabled)

The hierarchical PM domain topology and the corresponding domain-idle-states
are currently disabled on a PREEMPT_RT based configuration. The main reason is
because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
genpd and runtime PM can't be use in the atomic idle-path when
selecting/entering an idle-state.

For s2idle/s2ram this is an unnecessary limitation that this series intends to
address. Note that, the support for cpuhotplug is left to future improvements.
More information about this are available in the commit messages.

I have tested this on a Dragonboard 410c.

Kind regards
Ulf Hansson


Ulf Hansson (7):
  pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
  pmdomain: core: Don't hold the genpd-lock when calling
    dev_pm_domain_set()
  pmdomain: core: Use dev_name() instead of kobject_get_path() in
    debugfs
  cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
  cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
  cpuidle: psci: Enable the hierarchical topology for s2ram on
    PREEMPT_RT
  cpuidle: psci: Enable the hierarchical topology for s2idle on
    PREEMPT_RT

 drivers/cpuidle/cpuidle-psci-domain.c | 10 ++--
 drivers/cpuidle/cpuidle-psci.c        | 26 ++++++----
 drivers/pmdomain/core.c               | 75 +++++++++++++++++++--------
 include/linux/pm_domain.h             |  5 +-
 4 files changed, 80 insertions(+), 36 deletions(-)

-- 
2.34.1

