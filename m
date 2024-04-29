Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBA757FF
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399554; cv=none; b=YVmLOdf6FPMihQ3ABURPOrppzmdyyym4M68hfaWXxOV9gdb4oKcF9wMBGgXg614NWnmtb09hW3m8aA9jDWgR6VeePO1tVoyw552hZfXNoGmtdyR1749a4C/156faDS2YZEhIpr0rXWw3h9YR10CpU9doCkG66ubTHDJ9re3oDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399554; c=relaxed/simple;
	bh=Uf9ddhEBMCM/OlaEb7CTzNoTY6fpHPR3X42S1b/KeT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UP7UZG1ZmiyapiWsHFaUdVIFd2xW2OiaEd2d+xddmSbmRCHZ8F3PWzJa5aYo0onkQgRB+nl2WHOyGVMOl6U/sGM6LJ7cw0uHww2GTYNa6hzr4DhM1C60jleNS/Zflw//NN6VT1McaPLjco0Vv/2VtNxULaoJi4uetSzN0msALhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D5Itbw1P; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5Itbw1P"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso60301801fa.0
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399551; x=1715004351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXJMGZU5gWJajF1DAzW8nc/IcTR1txmF3L1/3ROYhek=;
        b=D5Itbw1P1NBmUpFO10twp0nncx6lGHp36H83ra6rvujpSaPPDKnRhxdAts5LwIMMYr
         SuPBDb97ici9jxQfwgrrqBCXtMpCH+sQQjr6ghCO/NTTlpHB3vtFo8c98Iu13oid4iH8
         94N/17OLYNSLQCYPUGDZO4EkmdQXb9ZNrDgprLQhLzbacgkAIxURc8iLSqmvIdp+OHCZ
         Rh3PD+E3XG6wevU51XUQZ+lLoPDS447axOw81uHXSZt4zH8Kh8N67OuCk31FxyR/Ue9+
         H60kN2QdrYyXij+N8pm6VDf9JkPtQD9CunuV1m2P0Ij9RQf4GA6ES9O3Zi85+vEaWg0h
         aNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399551; x=1715004351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXJMGZU5gWJajF1DAzW8nc/IcTR1txmF3L1/3ROYhek=;
        b=Bh+WpA6x+TCP7T7Da7zDakDlw/wFngI8+Kmo8aRvAX/k9hDRdnrm6Xv23+tP9tqCqz
         PJAvSlBHc8wdOIPvECv1yGwkJoq43OvT7vtE9TpLOSYybnqozj4cc6gXMvDvVSxPku39
         i5NUnzTV4NJPfN4jqnqLdQ/CEeoCyPy77WOdF6Tnz5K9jSz6G7DWcNQdNZa8RDnhrWTk
         U2bRJrC91qn4/zVFLMCR9a1r+QpKmQrasDya3N35ckf+zc2IrKSxgWq/YqbJ38uBND0O
         fFVrRrBndovuwr7sXDWv7VyJN2vOTj7qheVBUhb9ml5C1Id+rYRM9Ia5D3opfUoIC82v
         MPgA==
X-Forwarded-Encrypted: i=1; AJvYcCWrQ/1gQYVbp27eQr012FgkEefqLgSmmmOxvDtxcrjWTJ9qe5M2UuhpY7RKmRYsXibfELiYyl+NTMCoKD5EhWTBnFGSl29cXG2MYrZFPm4=
X-Gm-Message-State: AOJu0Yws1TqTLBkKsanx9XjUkGe0AWHMMejDAXc5V/NRtSlg6MJemdxa
	vYkGrejfSlc1JaBWkcxpNcsII6reNFRYKKiBlf09qzfabYVRoz/v/TazwTPxv5o=
X-Google-Smtp-Source: AGHT+IFUjAW34oQS8Y+fnyeVdUbDkDis1iigpkrMI5QToMUOQcc8rZfl2WurAe5k4jfFMqtb5cerlQ==
X-Received: by 2002:a05:651c:2107:b0:2df:dea1:5378 with SMTP id a7-20020a05651c210700b002dfdea15378mr6030267ljq.16.1714399551361;
        Mon, 29 Apr 2024 07:05:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:50 -0700 (PDT)
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
Subject: [PATCH 0/6] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:25 +0200
Message-Id: <20240429140531.210576-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


Ulf Hansson (6):
  pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
  pmdomain: core: Don't hold the genpd-lock when calling
    dev_pm_domain_set()
  cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
  cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
  cpuidle: psci: Enable the hierarchical topology for s2ram on
    PREEMPT_RT
  cpuidle: psci: Enable the hierarchical topology for s2idle on
    PREEMPT_RT

 drivers/cpuidle/cpuidle-psci-domain.c | 10 ++++--
 drivers/cpuidle/cpuidle-psci.c        | 26 +++++++++-----
 drivers/pmdomain/core.c               | 52 +++++++++++++++++++++++++--
 include/linux/pm_domain.h             |  5 ++-
 4 files changed, 77 insertions(+), 16 deletions(-)

-- 
2.34.1

