Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9F80058
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399564; cv=none; b=oHccbBtskbqHkFvW+E5gv8mByWn9u6YfI3LFAf7s4gObXK3gexIaCTb/z8X4FdC5xjdh0lNwlyPUS36GqsUVJ5Cp5Jnt/9gYduFhT4zyipcOvtaaJIFQjlNpE9EUbjSkOipAswCi+TGd6KnUBVhckXKG2dcQY8hK6o09b6svZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399564; c=relaxed/simple;
	bh=bIu8MbW3zdEnNCbcclk/lNsKop9RpekiJmMvuMEBXIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbwbXn39kvkGreqIFexRXgDw2Z0fCuBcAKNhtClW1KcDWrdfwefJ/8mj83nMGYMt+1VAu3oXafwCQzS8QusPezc+m9GTsxCdp00jE1g3H36QzHzNV6gQK6l5ZwSkwXIJCSN+OXs/AmNnD+0UvMQrsJdG0eSbA5E9z5/XXt7NvlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynNUlOaN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynNUlOaN"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so54144701fa.3
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399561; x=1715004361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDwOmSA7MQ7+zytHkA+laGeE0LQljf7L1jWo+P70lko=;
        b=ynNUlOaNVD7iZgypmP3lZCl0KpXUrvNBCUIpdi1Eha1nepv9lFYNM/v1anteWxOBY+
         PIf6WkEx/l3Le/oG4cTXCrbJXluBfipnb+wLin7DhzA1oT3fvN6KhjMlozBoOTNwWHhM
         3J5bK7YUquew17u0XdAY/Y/WH8dfpjj9TqHoNfdHd/R8Hb+j0KwMFDHoQsqQPVSvbP1B
         NjWReMvfvlCS2Q56EM7yt9YN4EPA+2gXxylUSStP5JijZ0s3u5L/dGDx6alA+290oln/
         2LV5nrCr1VS37kQvP/bTzGLJKmhE+80adYj/F0ryZWZIsZez2H/hMVWYHXmoFqX5WLD3
         XOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399561; x=1715004361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDwOmSA7MQ7+zytHkA+laGeE0LQljf7L1jWo+P70lko=;
        b=eMsSIRpUxfFU3DLnnJ/5C+9miaPoQSbR5iQ9feQpc5qTD+pib/JZSizFoBLuzb72gL
         6D0YiPOtwExxHEWQIBxFQu4gZa12mj3cHG19NwV4q3Hdom6eupBmxvSkIRQxz0SVyHkv
         Zkl7gWERx8T6Wt5Lwo3HylIK0UIIvhojIhpHaUlbjJjDxv4zsQ99xL4tAoW900kVx0hQ
         jVKf7rtG43zwkz1htYw+UJxaXUylfs+H6OBPO71q+WKhcnQMRy1zIjBNtmcSAxYFcC01
         k43BJwmHm/KBsoYDskE0Qn7tf3YqH+98twTdo/8P+IJ4wPDwq1xh2aNDbkFOklAVwf06
         iHzA==
X-Forwarded-Encrypted: i=1; AJvYcCWP7Dgx2bLkpF1p+Y5Z26DVpA6fHWZWgKk29lvA+LHW1YF/3i4J/Dqi2oCp2rfpnIDqSi8L6sKm7+INoyFc3PrAZzF6H5K52AMuXp4sEyA=
X-Gm-Message-State: AOJu0YyDCWZVazKeSL3PxWD1GVJkdtODr5LDGd9rcvQ6Zj9w+yE5/QXv
	UKPQxHHQjDecH0G+SMp6kPhLqRSc7Xj47hO6kGHioe0EDXWWE4m+fSlQDxxyq4k=
X-Google-Smtp-Source: AGHT+IHp/AQbEYZZdpmQu1KIboKwTFnhRTHy3IUitMBtdTfQEIp1e8p8oPGMBXNXjtBT0xrYq8GO+w==
X-Received: by 2002:a2e:93d5:0:b0:2dd:6d67:3064 with SMTP id p21-20020a2e93d5000000b002dd6d673064mr6309727ljh.28.1714399560822;
        Mon, 29 Apr 2024 07:06:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:06:00 -0700 (PDT)
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
Subject: [PATCH 6/6] cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:31 +0200
Message-Id: <20240429140531.210576-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429140531.210576-1-ulf.hansson@linaro.org>
References: <20240429140531.210576-1-ulf.hansson@linaro.org>
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

