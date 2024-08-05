Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE64156242
	for <linux-rt-users@vger.kernel.org>; Mon,  5 Aug 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857744; cv=none; b=AMom4CJkWHOE3TQKsN3O+cxTEzfJKBrtkBMMvVHkSbGiaAzVZBZKHHGtmWip9lqqrI3MWKfVyagmPrenRJACvZjMQShHcMBCuSRvpZxQ8eVx1YkQTx3PD3ufZtt9cM02qWZGU9kUJgEJzdP+ffF2c9Jj/uWf9t1n1PdkA88nGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857744; c=relaxed/simple;
	bh=8G/5og31ZdWxDbzaltklXNdhbY//dhSu0UC8kT0ECxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTYHoz2VwjNfnAqheD/PoJfXvXh4RbenurrsGS6pzwQA3V5p5WeS/H7fjQgZtRyvKswcNBUcoYoCcg0GDPEOrDT5p8sWV5OA+ENcCkX9K7cmOOBLcZUeKu8quyePdYJZJvA0rkvHTc/5oaTN6PCLN7BD/K6fJD4jftZf4w0Suqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgLakQ9F; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgLakQ9F"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0bfc0ee203so1871607276.2
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Aug 2024 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722857742; x=1723462542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RC1mkfGxghq8dpQy/VjlNqYZwIedOyF9cpN0BiEfzRE=;
        b=fgLakQ9FvpXkn4I4E/CNR9O9YKevVC2hvjyD+Ysb6HdjSzoO9IhLqjAUIiclhaP6xU
         nbGCVNi0LSZUxo4pTQFNH3jzwYTR4prKuPN7qIYW6Cs0DNMKtRK4TUabCYRuecG2+3R7
         5KAAUHbxa7tjsn7fAfSvr03MsP5uK1auh9WmMCDBRsDw9uGk0M02FliFzVGCZmEUSL15
         9ljuLTa0cDx1QV5m1y1xCMrtdlyGPs/m6OKt79a7dmkuCIpvMNwLXGb18O+H3aLC1xIN
         MeMFUwnVvN5qpnlPBNRIi2QJHb9hJUCuS5d14HYhcMm2lTdqVgutqtc/yZvUDro8ewHx
         Q8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722857742; x=1723462542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RC1mkfGxghq8dpQy/VjlNqYZwIedOyF9cpN0BiEfzRE=;
        b=qlDwQx6aZt2FMkdznhxyedPsM0GMedNkrq7wubTvERX+h1IaTiX3OVyg3PBZpQSe+q
         A6W5o3l6SdVz9VMBsSMkdqG8v52dLe6vetlzQpN+1LTxB4ogTr6WIz53NLLNGQkYRJbn
         WkjnbKGC0qqzFTR2akU8k6mLns+lpDMFNRaBy35jZ6c5lPp28KL1ZRMI5ZTEm7VlcE40
         Z7noeSrYD4mPv4+FJuFI37eX1R8HNPeb3TAK4EKTuwN5or2+YpWB0E78gMzfxS8X6RKK
         BIkzMMlIw3GtbteqgC7UXLtrpAZiDGomGMpWoKSWOlyrZjG/gMXsNQbeI3f+D9Ida4l5
         TBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUze4bIxW7k+N4uv8+9GnjuX0FFP8PK0F61OYJPTyOsA9F/jIJ30ykUSXD/qpwhmD96zsUVebySIWGg7yq+SroaD4DP6q3XuHQOP10jd0Y=
X-Gm-Message-State: AOJu0YwZD7fU1p/ra+QcGIk7EboRxI36c6FHJ4q8IQzrsMidW8rfM1il
	JGavVmr+ny6jzga/2eETKNcDcL8+KA4aI34HaofgY42tJLwp8iWhhkl1gpRtQL/Sva2XBmAkw+Y
	ZWZP8LcgW5/PkCByf8ixSkcUBQPxQwWGoQSnUtA==
X-Google-Smtp-Source: AGHT+IGrk7bdr9hMTo+pdPXGdlCB4JCPDeCJ5I15NZK30YOAHMCo5ECXoQSHSGJf0dFY7hrfZVW0IaiXzgYW21XQJsg=
X-Received: by 2002:a05:6902:2193:b0:e0b:e28c:b4f4 with SMTP id
 3f1490d57ef6-e0be28cb8b9mr11954505276.38.1722857741726; Mon, 05 Aug 2024
 04:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Aug 2024 13:35:06 +0200
Message-ID: <CAPDyKFpPbQ9rPSL8Uurk_AsZfqH8-EY9vGUVC9ah-c9tMqTvXg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
To: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	quic_rkakarla@quicinc.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Raghavendra Kakarla, Sebastian Andrzej Siewior

On Mon, 27 May 2024 at 16:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Updates in v2:
>         - Rebased and fixed a small issue in genpd, see patch3.
>         - Re-tested on v6.9-rt5 (PREEMPT_RT enabled)
>         - Re-tested on v6.10-rc1 (for regressions, PREEMPT_RT disabled)
>
> The hierarchical PM domain topology and the corresponding domain-idle-states
> are currently disabled on a PREEMPT_RT based configuration. The main reason is
> because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
> genpd and runtime PM can't be use in the atomic idle-path when
> selecting/entering an idle-state.
>
> For s2idle/s2ram this is an unnecessary limitation that this series intends to
> address. Note that, the support for cpuhotplug is left to future improvements.
> More information about this are available in the commit messages.
>
> I have tested this on a Dragonboard 410c.
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (7):
>   pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
>   pmdomain: core: Don't hold the genpd-lock when calling
>     dev_pm_domain_set()
>   pmdomain: core: Use dev_name() instead of kobject_get_path() in
>     debugfs
>   cpuidle: psci-domain: Enable system-wide suspend on PREEMPT_RT
>   cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
>   cpuidle: psci: Enable the hierarchical topology for s2ram on
>     PREEMPT_RT
>   cpuidle: psci: Enable the hierarchical topology for s2idle on
>     PREEMPT_RT
>
>  drivers/cpuidle/cpuidle-psci-domain.c | 10 ++--
>  drivers/cpuidle/cpuidle-psci.c        | 26 ++++++----
>  drivers/pmdomain/core.c               | 75 +++++++++++++++++++--------
>  include/linux/pm_domain.h             |  5 +-
>  4 files changed, 80 insertions(+), 36 deletions(-)
>

Just wanted to let you all know that I have queued up this series via
my pmdomain tree. Please let me know if you have any further
comments/suggestions.

Kind regards
Uffe
