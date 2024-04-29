Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE227D080
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399560; cv=none; b=XF8EqdwvgfvrNCTm6HZ2G66O8kMomhAcPha+n2keSfs23EFuTg0YYhQqhcOH/nYI4DUbRjZci+DqPUkuNpMoRmKDjkmRbCYT6tSRnhWARwCzBBUa0n1SAXQmYTUubZtPblWJYt/Y2+552x8i6HGnYxDLVslshWDS0mXdEBjV5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399560; c=relaxed/simple;
	bh=1UeH8qsec/NsG1L4r/jxKyr3U9Kx19UIvj4u750pz7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7s3oc02rpzFEQqbg1+lkZofwp7Eb8fuSN94chi3ZuAHghPkj8q0sV2UWE7yKpiXtbofespvNs6f6oeczqxS+HQwAPFu6JSxE6dK999efH96X9CBq/wkXj7/EDk1KaLKyJ1mgfNGEF7rSyX5opJFvgXNAkElFOYjQK9Xibgkrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c/iMwAhf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/iMwAhf"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2dd6a7ae2dcso71758351fa.1
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399557; x=1715004357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW5irYe0gjQq7lL2yVFdE32QB/2sja742dgELwuFIJk=;
        b=c/iMwAhfHedZjTaiZxINk9MIxWrW7IwFedzFroyC697A6qVFBcR9ZXmzzLjgSYEDjN
         pNEE8aDqnj5P+N9LiOchFD1jGyvqZc+SroHpZUFrQeEvlCtUVuqB1WfvbhDl0ouvuiSX
         +2/D4U0s+fW0MPPHiHeGiGMCIN/1LU79utIzK3MEbNQottQgLklgq2h0NO7EC5RcSt9d
         G/pvdOsOGKIVQUG9b09YcFdnUi0qQWq1S15Oiw1D68oq+dZDqj+EsBMcDSeBYMTLnTDj
         TIUtMp0CosUZD5C5IWoG/ff0pnufhY8hL9q9N+sKBcTLEu2mlMmVgWVBoB99RU23LtRd
         6eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399557; x=1715004357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AW5irYe0gjQq7lL2yVFdE32QB/2sja742dgELwuFIJk=;
        b=Ufso0OnE+rtL4G0a6iM7zZ0/2NUbu33gaLR+rdiylh8H1jK2jS6+BExdLGXINAN1vK
         QeQ8CGWppclVPamyMoNz8szxQFyEoquoPH0mrjXSsOlt57VH9H0Tus4H4uqCuOLUBp9O
         kFQ5N5fBLoUCfJaXZSi0TicMzlTUUnvargg7e/OAQDt3QilKmbu1eqOnem6cTi/8B40u
         zqmTuKrQWq1hYtQZyzfFH/TaUWpjpFe3dN4C/TN40cIi+WyFCV4KT3P9Mya1UkGX9UrB
         Plvm2r08n4b7y8X0YqFdPn1fyZxLnUle2xmRios4HWJXDB3qU4KQh2Pr+SD43WZNS7QX
         H/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyVT/YXoYzmyjJcfNfW5nyXV1eb2Ozyps0b9/l5CRrMqoOHlBIELkumbY6FyC2S4SWUAK/5gwdePVF0RN5WPyXDHrWua6Y+fO94Ow2vWU=
X-Gm-Message-State: AOJu0Yw6kOqnTPiHlaHg/z0rRs++VbDKG6HFevyLbHUp6hC0EFMr/bm8
	ceeOyHPzdwV9opAs0ysYKKsxYQynfm9SwIt5AdRe6AOQiAVX583MHFL1fr0MmAQ=
X-Google-Smtp-Source: AGHT+IGF1UWUkvnjVr7+ybR1e2V30LVUypzK2Fkn+AyO/pGbJIHureio72OUBUaKULp0nWYCZstvjA==
X-Received: by 2002:a2e:730c:0:b0:2d8:5af9:90c5 with SMTP id o12-20020a2e730c000000b002d85af990c5mr8482506ljc.39.1714399557079;
        Mon, 29 Apr 2024 07:05:57 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:56 -0700 (PDT)
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
Subject: [PATCH 3/6] cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:28 +0200
Message-Id: <20240429140531.210576-4-ulf.hansson@linaro.org>
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

