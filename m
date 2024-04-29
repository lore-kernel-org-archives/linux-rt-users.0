Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94147C098
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399559; cv=none; b=QW3N7G3qSCleXjl6eysMd/S7cJzK+pzUFzUEVlyeKTumX4YOXD77f6yNplIZrk2oikMHw1/zkCbl3IqLh3lGHGUc+o/mCnZ9ArI0cleM/Y5IlYwKLTZxeqpenf/Yk5EcAeToSlF5DcKUvWPBIAmcBH/3NJv8vUI/Rcbj8cSYoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399559; c=relaxed/simple;
	bh=DBZiNtJHVVXl6UzU8xo+RguK8DX+TTi3BYBsrhBX+dU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CiuqNnoMtTBtcy9bXBWHDURMtRgQ/uQKQrOgNVHRxO1A0yg1egrTfaFcTCPahF9LVlT9SPDwUB8RPvABXyyVUqMfLY2QRr+SgPNBqwcfLR+Bbe4ntOW9lu4li9jRtwHRdHhA1SMqvQzGYHMrwiQQLQKzztSjSIafq4x0rJVFHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jg/UPbul; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jg/UPbul"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso55086021fa.1
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 07:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399556; x=1715004356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhlwXdsIIQqTLzsLYWWuKXNc3rr4XrNJUhlJgkxDb2g=;
        b=jg/UPbulxiW3Cy8fmJZG/BSq9n743kqRqw8it/B7Qc1nB9nDvkxQFmPA+ihIwBi2G8
         9KyFaxJuYXKQPfbvDICSH6fFS155mOwcs6bIOQLpjtsflv9qP+DpZMEcgDXXECIpsQoI
         7ZK4wi0IPlZ2TAJqOhRZ+s5W1UPySxdkvq2ER1EB5azdxXYfxGIz/YwkLvPmvs1X34Py
         wzMHemo6/E5BmlDTQg2O+e1rRBnFjV+mql6ARerH3KjELMErYkalzCsnbGWQF4vDLl8t
         UazNyzQGODQpq83bPgVn/qV3gXAafhnR6WDeRmc3WV4lEfN2ahetWfnIAv3eSicCZHJp
         SbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399556; x=1715004356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhlwXdsIIQqTLzsLYWWuKXNc3rr4XrNJUhlJgkxDb2g=;
        b=na0sXyiorM5PBuowof3hhKMcUEvalbrtXgTPyemA44ZR+GupL+MG1V/EfjsdnLZsxG
         XU1p/HKZ0y7Nc+nSZ4o1Mbrmel8V/5J1PPYnNybkNn+FL1pg1xym3uDb8oSm3beMVdXF
         yRMzDKmTUfKJW4Q9Kedd+MD6HFVtzkJ8NNP30WgkEvnTRIj5DrlkyNaBHl9Y+d38CK8r
         GTebaRklsrPokrMxrOhhlJ38OVFlLvqzR2qWbImQf8sEn29LKSG5aY0lhZxRgBj3yXcX
         CoNntNqvwbiBMlAdrFZEO2mutXEhvY9+vl2DNN5lR1lRktFpduPU1B4KVnsW2UtKnDn3
         O/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPJlgAHnGbgwyNLgBuqH85R5r56kj4pwRCFkSG8kDWF8VSYFxG3tOZs/RiGhBjdBGrM9fnxafzBwWsLrBfm4Cx6DhOATcCbu6atYPrK1w=
X-Gm-Message-State: AOJu0Yxk+/k/aA1XH/JrnETfEDtPGzQSG8HrO8Vj1le4s2bGd+/elPxC
	zQ8nPonlGO43pUtbt/xBSl1CdFMqyg6Na6heH21tupDTOMWW81zER+z2nDftY6I=
X-Google-Smtp-Source: AGHT+IHPdwyXQU3aNRNl39I+1zVVIQFncsJfd0yL3gfsj/5GlxoblfJ4b4uEsKSkTrkhND9uPVuJKw==
X-Received: by 2002:a05:651c:221b:b0:2e0:752c:1f2e with SMTP id y27-20020a05651c221b00b002e0752c1f2emr2172687ljq.1.1714399553969;
        Mon, 29 Apr 2024 07:05:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:53 -0700 (PDT)
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
Subject: [PATCH 2/6] pmdomain: core: Don't hold the genpd-lock when calling dev_pm_domain_set()
Date: Mon, 29 Apr 2024 16:05:27 +0200
Message-Id: <20240429140531.210576-3-ulf.hansson@linaro.org>
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

There is no need to hold the genpd-lock, while assigning the
dev->pm_domain. In fact, it becomes a problem on a PREEMPT_RT based
configuration as the genpd-lock may be a raw spinlock, while the lock
acquired through the call to dev_pm_domain_set() is a regular spinlock.

To fix the problem, let's simply move the calls to dev_pm_domain_set()
outside the genpd-lock.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index abd3c069df8b..1e3f8dea4654 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1726,7 +1726,6 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	genpd_lock(genpd);
 
 	genpd_set_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
 	if (gd)
@@ -1735,6 +1734,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
 	genpd_unlock(genpd);
+	dev_pm_domain_set(dev, &genpd->domain);
  out:
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1791,12 +1791,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 		genpd->gd->max_off_time_changed = true;
 
 	genpd_clear_cpumask(genpd, gpd_data->cpu);
-	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
 
 	genpd_unlock(genpd);
 
+	dev_pm_domain_set(dev, NULL);
+
 	if (genpd->detach_dev)
 		genpd->detach_dev(genpd, dev);
 
-- 
2.34.1

