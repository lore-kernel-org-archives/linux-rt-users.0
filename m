Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F324171E4B
	for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819982; cv=none; b=VgRAKyGqbUeTjqelK9lyp7D6vyN0YUwRyEbrOUWjrvRzAA0SWB+8e5OTTivShAtxVkSTCiXd5ksYxZ6fr1Oria+nLIzVLeZ/RyGrBU9vr0Z9Ot9wHUYiHpK3BbzbGo2io2dsv0awaqIVohrlz6f4IPGlBIfSEm5nA0SwuSSzEHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819982; c=relaxed/simple;
	bh=sz5by33IERLM5zwiJFy9mJ1MJ8cDhLszCDyK9tAyqqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=An7ngLZydzwCpVfpDe5dVZ8GUavfFQIkT7JKLedI5kHPXdESZxng13JPtszHAYpH4D4RlIH+GKEX3kHVOsXvUz2CXbbj4OTz+ktqDNdQibhpnf8NozqMPZ58ZxSKCx5UZRoyZy6Qa5RjIqEL3nbMWJDegr38QJmGr9nDVMCdT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b0mg4Z0x; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0mg4Z0x"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so63709131fa.0
        for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819977; x=1717424777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GR2SPI55DeqkFqYqinmHi2Z3WjfSQZFZ8NPV3Q+VMg=;
        b=b0mg4Z0xdl7v29H92uBbvl0HkpfgAKp1wdAFy3MO13XRMb9IrbXEu1DIavjcc2LFoT
         DSSSXD5tl3gXxZhdv/jOH32h2YTG1JrfAZ3lddtLHDGnPDrk8cwXqxK+L2uB9kgfZWIz
         NDEr7TPFg1+fYRfpGkCasrGmLH5O1vWSibYXPzf3OP8R7m8T6OAuQUJ9QF2XeH6jV5p4
         gfC71z1SUgTE2/WdPCXgA8qR8vmOKslCqrZ3f7l0b/HEQLqwy2aWmFkOBSqPlZ2FAL9N
         h7HYmlIwkDP3/Ed8M57vTCSf8HK6quVp3cJOxTq5ElKCjujVH7hR/X6Qhf7JOzmpvsX3
         wydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819977; x=1717424777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GR2SPI55DeqkFqYqinmHi2Z3WjfSQZFZ8NPV3Q+VMg=;
        b=Bk3Jp+7quUEx1aLY9p1KwJN53EO95X01sudhD5PICgRboKIPPTjSvJlVPNS3Q8AfEm
         dKOrQ0Q+ye6gWcHTtW89amA5HhjxY8AAZjArnLDKV/nGwfNFJ6poGtAI4Rm0JAeD5dRt
         GY8ZdPmengZ/BACKQBez9IgwDus9Vj6sTNoBPobH61JGSgjSSmSd25hGwbL+ycfVrOKe
         gTXwOulnRrMrK1TXo8TbCRhajNok5GwSvDwXVaabY9PQTj3goI8U0rYC3u+OubDftASc
         kco4vm4yX8k5caCeVm8JtHRsTVdDgaPGKXAV9DMbl6jfATQ+QMzc+oqm5RzhT69if5km
         r09g==
X-Forwarded-Encrypted: i=1; AJvYcCURvQg7wVnQnnXNGTeqc2196TPU2IQ4XCFDHp5u2ibJNq6t11lwaTCFKi1EQeRg6cH6wsFQ7sW1o/EmVVpjJTSVPQH8tDtFTulXtByby58=
X-Gm-Message-State: AOJu0Yz1Yociu9XHZ/JIRQ9nXqPh3Rp2dwaycfbSr9WkItXVUvfwC1DT
	/NzFV7Odnx+UOjE56l6gBbPoFrbKSKJMCmIOkX4CIYMFxdk/VgBeOnYx5s+tFDk=
X-Google-Smtp-Source: AGHT+IGA/P2FW8XpPqzZeELvPdtjcyg+OYc+xsv0HaG5JN5DSLqw1uWa/8UhB3bobcPBPC4oZ82dnw==
X-Received: by 2002:a05:6512:3107:b0:51b:528e:ce7d with SMTP id 2adb3069b0e04-52966005b6emr7056095e87.34.1716819977519;
        Mon, 27 May 2024 07:26:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:17 -0700 (PDT)
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
Subject: [PATCH v2 7/7] cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT
Date: Mon, 27 May 2024 16:25:57 +0200
Message-Id: <20240527142557.321610-8-ulf.hansson@linaro.org>
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

To enable the domain-idle-states to be used during s2idle on a PREEMPT_RT
based configuration, let's allow the re-assignment of the ->enter_s2idle()
callback to psci_enter_s2idle_domain_idle_state().

Similar to s2ram, let's leave the support for CPU hotplug outside
PREEMPT_RT, as it's depending on using runtime PM. For s2idle, this means
that an offline CPU's PM domain will remain powered-on. In practise this
may lead to that a shallower idle-state than necessary gets selected, which
shouldn't be an issue (besides wasting power).

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v2:
	- None.
---
 drivers/cpuidle/cpuidle-psci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index ad6ce9fe12b4..2562dc001fc1 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -233,18 +233,17 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 
 	psci_cpuidle_use_syscore = true;
 
-	/* The hierarchical topology is limited to s2ram on PREEMPT_RT. */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		return 0;
-
 	/*
 	 * Using the deepest state for the CPU to trigger a potential selection
 	 * of a shared state for the domain, assumes the domain states are all
-	 * deeper states.
+	 * deeper states. On PREEMPT_RT the hierarchical topology is limited to
+	 * s2ram and s2idle.
 	 */
-	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	psci_cpuidle_use_cpuhp = true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
+		psci_cpuidle_use_cpuhp = true;
+	}
 
 	return 0;
 }
-- 
2.34.1

