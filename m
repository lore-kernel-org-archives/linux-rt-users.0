Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD97E11E
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399563; cv=none; b=XGwX2w0Ai1n6knkukjLNrHMC3QOFiy8XOjx2v/vKDEdkIjT68gTyGVSMB4Zf8vhQP46VvMsTm67gH16OYNqkSIJew4++LeISKcOtCoKX6y++8wMhLFQCvQnyhZSGQBCK2zB0/0/Y/CSvZfy9c9rFS99ZpMRwr7cgoC1sAXuzdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399563; c=relaxed/simple;
	bh=jSO/TwF193q6NQysycIGd6vDzmh/SnmSAu4Kev3da7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=He6egnOVae3PhFDn5qNNs7lxfDVNwFXY66nv64Lo6Ixw1C/SRQVv/gurXRT8hHLs71+PV0KC1zNx+NsIaT3QKK3ddzCjdhoya9RFetW9jrOn8bsjUMsdQxGPYNGZd750dtGbcYD4f+ZuE0o6si8w/BY2lUp7+sec/SNwerIkc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANV24eal; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANV24eal"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so54144051fa.3
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399558; x=1715004358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryk8Yjnwcb/TeAS/NSYC6eu7KpbQ2RMUyBm2Fm6rA9s=;
        b=ANV24eal42bpfcOfoK6+3lvgO3RLohrNWPsGMfJ9BCyUxF8xkd8fT5B5Gb2oXMyA7X
         rwiRyNJx5Sh60wn3z/CkEpyLIZIzdqactruq0PJXP9SM4PQkYOZUrlZd2cypR9WzIaT8
         4e8F8dKDJzLiPZFTifQI53szRQL+O2md4i0SPH0KmTg8ZTwndT59MGEDmBPs8y03fg4B
         F/LSSDTfj1zWEHcxC2P7RwH8R7CNRlUbaR/Ux3+Yu8OxkMuLyIWhZwzeGMO3kwhe1bFy
         ABTjdHtsDVj+F561/qjZaXytwDHbLN3BiYgvFIwOoylPL8KSrZZgJle8Jg1fnnv/5W64
         hJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399558; x=1715004358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryk8Yjnwcb/TeAS/NSYC6eu7KpbQ2RMUyBm2Fm6rA9s=;
        b=krATNNEiijPLKFFGGaehe6wIZuST1Ryz7Tvzt0DNRjSdct70UM2p4LERS65bUtXV1e
         DrkL2tPGaPWN40RIn0tv494z3IwanZ+XjZSX2NkNxxJRLIZ7xBg0wY6+B+0V3IC3emlK
         OqZCuFT1HswvsksHb4q/1JSIpVit4EuRk/Y6MiWsK5MMYBtNcBIgiHW2XZJu30a+1EQb
         eS+0gfEoDoB0rDwaLABrbtooYq2nU0SYFeaeIMN3D1noD/SGoJwFZalR9lgFF0r3PXKd
         wpmrHXxbXzKXNAsmyOlykjd5EWI7M1o/4+KIZasiiO7xjgT9tv4BHQdSFjGE8uC2j+uA
         6pfA==
X-Forwarded-Encrypted: i=1; AJvYcCWTdYk0ViM33yRRBVV5ridPMMfEfND4AfyXGvUPflkCtVTKGvKOwcySrUF/RwLf/hOe34oKiOCLWGgTGl2hywpfSaXkyXVCWvFJjfc6u28=
X-Gm-Message-State: AOJu0Yw2CB3Dinu43IuwNfPjUzUAltjiz2TPkiRis9GEPhFIC3ozAZ5h
	fdWrlOkvlTDeLlWOsgPt7jrEvDPqNyYK08vRlmtuqS0wyQfCuafxxRJbScLsYyw=
X-Google-Smtp-Source: AGHT+IHXIApKuUwmhZVbv+qbGSSWrutGduBAYZPG18WJ+SF5X8KY8BLp8xAT7YhpWiZQaddV7NhglA==
X-Received: by 2002:a2e:be08:0:b0:2e0:2661:77fc with SMTP id z8-20020a2ebe08000000b002e0266177fcmr3590162ljq.39.1714399558442;
        Mon, 29 Apr 2024 07:05:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:58 -0700 (PDT)
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
Subject: [PATCH 4/6] cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
Date: Mon, 29 Apr 2024 16:05:29 +0200
Message-Id: <20240429140531.210576-5-ulf.hansson@linaro.org>
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

When using the hierarchical topology and PSCI OSI-mode we may end up
overriding the deepest idle-state's ->enter|enter_s2idle() callbacks, but
there is no point to also re-assign the CPUIDLE_FLAG_RCU_IDLE for the
idle-state in question, as that has already been set when parsing the
states from DT. See init_state_node().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 782030a27703..d82a8bc1b194 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -234,7 +234,6 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * of a shared state for the domain, assumes the domain states are all
 	 * deeper states.
 	 */
-	drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
 	psci_cpuidle_use_cpuhp = true;
-- 
2.34.1

