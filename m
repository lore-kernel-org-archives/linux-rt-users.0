Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AAE171085
	for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819979; cv=none; b=c784nW6uSCzRRYmgUFsHftNKGxvjVOFxgWGV+i28awHVA5v5tHz7tHxAevu06bUnNEFlLFPQw8kp1Aa+/tYQxN7jN6B6JjFAT7xKcXYFHZf/4lpy3eG6AAhgwfdcPt6Y0GrPJG36nSQGUiCKJFcVdLuMvD0NLbw3nl+afMZitMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819979; c=relaxed/simple;
	bh=Dqf4iQmXp0zK19p1+7qhaTomO3Kpy2CqPOAV3dW0uXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMef1ewIgioQMoxaJs3Eq+whomzsa4maQGBjpy/+pbpVNJOtgGSFNfcl/jFxez1+qwU7W7enMi1gaYiQcvxCGUkNjlaUabpCp5pmEWV0zRwn180gw76a1ZzxpJKELko6wozwwz4e41/ln/IC8ZH7o0NL8SlXvfudbdFUpQ9T+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgof/2C2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgof/2C2"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5295dadce7fso4184387e87.1
        for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819976; x=1717424776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LljiSusVSLaQvLa3fMIpBprCm3Nn7mYz+K0yIBAx5Q8=;
        b=lgof/2C2IrfR8Y7zaAeMVr/gRnZfYETQoJbmAMIUJr7dMRqU2LYgvCZXIhZPlBjUa1
         3zQCaUH+XHmrSeJucMiZMkl6VB0R8iizmztVAjC7tiTvAkUhEHqQmkRzTGWvHriQspoM
         Nihi758/77c1m3UbQ+AUVxMPtBn6DkvuMmp9C5BjkOi/Ec3qvYx4yWmpvUU7jPRk0BvG
         VZyyyBabHeYoNy54D9qeFgaabyJvLJLKwY9+qgpt7EhvYrXF5wG0rws9teCn056jF7bC
         tmtFABRIJLXJExFJ1M+9vRCykropcRBGpokUiZ9eOT56oCtZszfml9pkHfQIfKgMOMBj
         +QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819976; x=1717424776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LljiSusVSLaQvLa3fMIpBprCm3Nn7mYz+K0yIBAx5Q8=;
        b=Ut9s55ZO2ZqFGrCmcucyuedU6t3l9s7a0S7iUR0IT/b+PMp6dWSWOC8R5Rcx0KVBHa
         ekulDm4BoQU7t/VbzValmrTq2KbDPXbU9fh9qJ6m8/qlqwYikbcRenDuI9XIZgWmhrCa
         RXjgdbWVYkgi3pueJqZUXWPbhnWYFBbd1lSzvnRS3cYMUaouejpfvn0epwuEXOFIBZGQ
         09aEEICFHYBm8KUuDHaODSfbAGOy27LiM8tuHFLvm1NhBFIs9UQRsAi/c5HPAgseEddQ
         Yk3xMAM3eGbiJC3atjTgh2aNb3S7uV5hRim+u8lgIAsO6OuB54XPhWlXWOwXtUwfsVrP
         ntRA==
X-Forwarded-Encrypted: i=1; AJvYcCU+OGeQJBD+Ngf2byhPBtXtrT8AxlY0EbUbQPN86GaYEEgKBb0lcEtynXdLgZtTXLqQbpUgqaNhsME9vrU4UdHFBqG3vytMmpPXAcAmNII=
X-Gm-Message-State: AOJu0YzT/i8llbBbEL5/6K5Q/9Tbd6nW3vlAkw79bacacrkEKRlEHRaw
	TQzvv5EOQhUnIOLWobB+FXPF2wYHepup9+e4jGRp+ne6gnlVepciyi7iFryg53Q=
X-Google-Smtp-Source: AGHT+IHda/pxt1Ko7UnJfUcRRPdZ4toQLHtsmBjmcxqQ5f4apt+9Z4qbCKGMZXNL6CMfnbUjmtCv8g==
X-Received: by 2002:a19:ee0b:0:b0:518:a9bf:73ec with SMTP id 2adb3069b0e04-5296519899emr5678201e87.35.1716819976367;
        Mon, 27 May 2024 07:26:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:15 -0700 (PDT)
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
Subject: [PATCH v2 6/7] cpuidle: psci: Enable the hierarchical topology for s2ram on PREEMPT_RT
Date: Mon, 27 May 2024 16:25:56 +0200
Message-Id: <20240527142557.321610-7-ulf.hansson@linaro.org>
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

The hierarchical PM domain topology are currently disabled on a PREEMPT_RT
based configuration. As a first step to enable it to be used, let's try to
attach the CPU devices to their PM domains on PREEMPT_RT. In this way the
syscore ops becomes available, allowing the PM domain topology to be
managed during s2ram.

For the moment let's leave the support for CPU hotplug outside PREEMPT_RT,
as it's depending on using runtime PM. For s2ram, this isn't a problem as
all CPUs are managed via the syscore ops.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v2:
	- None.
---
 drivers/cpuidle/cpuidle-psci.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index d82a8bc1b194..ad6ce9fe12b4 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -37,6 +37,7 @@ struct psci_cpuidle_data {
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(u32, domain_state);
+static bool psci_cpuidle_use_syscore;
 static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(u32 state)
@@ -166,6 +167,12 @@ static struct syscore_ops psci_idle_syscore_ops = {
 	.resume = psci_idle_syscore_resume,
 };
 
+static void psci_idle_init_syscore(void)
+{
+	if (psci_cpuidle_use_syscore)
+		register_syscore_ops(&psci_idle_syscore_ops);
+}
+
 static void psci_idle_init_cpuhp(void)
 {
 	int err;
@@ -173,8 +180,6 @@ static void psci_idle_init_cpuhp(void)
 	if (!psci_cpuidle_use_cpuhp)
 		return;
 
-	register_syscore_ops(&psci_idle_syscore_ops);
-
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
 					"cpuidle/psci:online",
 					psci_idle_cpuhp_up,
@@ -222,13 +227,16 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	if (!psci_has_osi_support())
 		return 0;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		return 0;
-
 	data->dev = dt_idle_attach_cpu(cpu, "psci");
 	if (IS_ERR_OR_NULL(data->dev))
 		return PTR_ERR_OR_ZERO(data->dev);
 
+	psci_cpuidle_use_syscore = true;
+
+	/* The hierarchical topology is limited to s2ram on PREEMPT_RT. */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return 0;
+
 	/*
 	 * Using the deepest state for the CPU to trigger a potential selection
 	 * of a shared state for the domain, assumes the domain states are all
@@ -312,6 +320,7 @@ static void psci_cpu_deinit_idle(int cpu)
 	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
 	dt_idle_detach_cpu(data->dev);
+	psci_cpuidle_use_syscore = false;
 	psci_cpuidle_use_cpuhp = false;
 }
 
@@ -408,6 +417,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
 			goto out_fail;
 	}
 
+	psci_idle_init_syscore();
 	psci_idle_init_cpuhp();
 	return 0;
 
-- 
2.34.1

