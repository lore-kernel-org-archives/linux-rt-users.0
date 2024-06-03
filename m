Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032C12DD9D
	for <linux-rt-users@vger.kernel.org>; Mon,  3 Jun 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423168; cv=none; b=n/zuC07TeSSjMzwvVV1g8AAYQHXo/pIFw/wA7RmyR6pZQLebfi5hE7q18fehLzYwG0xeX4QcyZDPS/hQ8wBnvdmkF42VqkKHzg//SRILLFqiVKSS4cDAGW59gK6V1KFL5O0YohusNHgULA+Pqk4HKwVTdF4VF+FlM6OKsKugzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423168; c=relaxed/simple;
	bh=cp0EWn+6r/LDs36eodL94/fGja5GAeIBzCYRxpW1QoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9Nd59qXLNOOL1NCEofGARtbFcCoPM1keP10hYCHlbtoDJOh+jiaK1UcaK2FbZj0yr1ZuVOq5cKeFg2IlwLksQboy2YVnXPkXERHg/9KK3lUUlYI14UAOaZDNmqcg7n8NkK2ghDd2NLeq8RWduDAeO+Ud48oGXJZ9ixNQtEUVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lYDdyh9D; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYDdyh9D"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfab4375f94so297463276.1
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Jun 2024 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717423164; x=1718027964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o2BkymhQ/db2q0Xr2SvTMdgw34Lx4ntfmiWk5iS8ce4=;
        b=lYDdyh9DSxC8f0IuGLcT7CDeWTvZcmaYqLJrGECfN4NcTa8cQnzervbRRG+b4DDgK3
         2RUASGHSsZZamZV1/zQD6R0lpRpvSIE0s20ZFXE+vTNth+1Zh7Wsd89Gc/m42s5yplWz
         XJ0wo0s5cM0X5ZKj5QtpTN+o8HlcJ/aEOsZ37e7W+KyBQsUgA0ERXjUl/zDNfhaaProM
         EuRNEFIPZ+LDBlIEOkwL6N0S1qzbyvdoMGfE8xGqZztuzMmLzK78T0TsxCvHa5tUmXqX
         sTe0XC7LvAAaKvW63yWK3iwZjZ46A9MQ11KHgo0TM46ULrkCtwshujEp8rZfyL8YvsWp
         aTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717423164; x=1718027964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2BkymhQ/db2q0Xr2SvTMdgw34Lx4ntfmiWk5iS8ce4=;
        b=MHWTn0zcrhRaxpzNqUa5QYZG2Mbe2dF8Omlsm6K0zSZ65/u9x9ZsX1MNJEQs1NRJbz
         y/+X0LtENn0Z8FKqR5rD9dNUl+Zt/+EVWJtFWnOpiSI8HI/RnU492CQghavsJUZngvre
         BT4BQv3su7wR3p1nDDVQknhRIrcTTzBmE6TMPpIy+wTHeu6m/IR0DI17X09zBovZGJ7n
         dx9/T5tZWE7V6ls0lPHQWvy9M1P0E/NBXlN6FENVDdGiPWcP8dEOMqWWnvEywo+jvtPU
         19lpfaLbNclJwZfS50EqeUf5wOF6leJI1r7j4dy3JwszF7l27fiisCtP4ioU1aiV2L+a
         k0mg==
X-Forwarded-Encrypted: i=1; AJvYcCUqRCWfvhunCft2ZA/HZdTQw7lbhZSbU49rW6vWoivT4Ou2EOkXKPJ3GeeiYhtxKcSxb2CXqMQ5/69qZzw32S6p5+UDIhX+hIE4nL+2VR4=
X-Gm-Message-State: AOJu0Yy8MQ993gReP5960UynLLOvBHxZP8i9+0YIpspcU/tEZol++maQ
	hKgatGmx/10YLq6Ibnv1Bik/FNZhfh6lUX+6K913VwGnEfdZbE6IpW5rfY2HxRReq7avkeI0Tc+
	VNFwmQJ8pvONC+iJ+Cbbr1PhvB9iJAdPTYP/A8w==
X-Google-Smtp-Source: AGHT+IE+Sp67UTouHkbbALinQ0QcvpOUd55hi+8TrM3/1VlCwjirTrjQWAm0YMJPdgvUF3kqgf48s/3BvbWC4dkjd7A=
X-Received: by 2002:a05:6902:260c:b0:de6:dcd:20ae with SMTP id
 3f1490d57ef6-dfa73c229e7mr10000393276.27.1717423163818; Mon, 03 Jun 2024
 06:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
 <20240527142557.321610-2-ulf.hansson@linaro.org> <52dce8d3-acfa-4f2c-92d0-c25aa59d6526@quicinc.com>
 <CAPDyKFq0V9ke30zYAGzS1aU0yq49DdfDkfYzxkLBZuaVGsyGDA@mail.gmail.com> <24570028-42cf-43b1-95f2-b6f48233bef9@quicinc.com>
In-Reply-To: <24570028-42cf-43b1-95f2-b6f48233bef9@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Jun 2024 15:58:47 +0200
Message-ID: <CAPDyKFoOxa1tmzxY4jrbPET5RKF6s-OAfYV=eZY9sPrJMR6jaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] pmdomain: core: Enable s2idle for CPU PM domains
 on PREEMPT_RT
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 16:23, Nikunj Kela <quic_nkela@quicinc.com> wrote:
>
>
> On 5/30/2024 1:15 AM, Ulf Hansson wrote:
> > On Tue, 28 May 2024 at 21:56, Nikunj Kela <quic_nkela@quicinc.com> wrote:
> >>
> >> On 5/27/2024 7:25 AM, Ulf Hansson wrote:
> >>> To allow a genpd provider for a CPU PM domain to enter a domain-idle-state
> >>> during s2idle on a PREEMPT_RT based configuration, we can't use the regular
> >>> spinlock, as they are turned into sleepable locks on PREEMPT_RT.
> >>>
> >>> To address this problem, let's convert into using the raw spinlock, but
> >>> only for genpd providers that have the GENPD_FLAG_CPU_DOMAIN bit set. In
> >>> this way, the lock can still be acquired/released in atomic context, which
> >>> is needed in the idle-path for PREEMPT_RT.
> >>>
> >>> Do note that the genpd power-on/off notifiers may also be fired during
> >>> s2idle, but these are already prepared for PREEMPT_RT as they are based on
> >>> the raw notifiers. However, consumers of them may need to adopt accordingly
> >>> to work properly on PREEMPT_RT.
> >>>
> >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>> ---
> >>>
> >>> Changes in v2:
> >>>       - None.
> >>>
> >>> ---
> >>>  drivers/pmdomain/core.c   | 47 ++++++++++++++++++++++++++++++++++++++-
> >>>  include/linux/pm_domain.h |  5 ++++-
> >>>  2 files changed, 50 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> >>> index 623d15b68707..072e6bdb6ee6 100644
> >>> --- a/drivers/pmdomain/core.c
> >>> +++ b/drivers/pmdomain/core.c
> >>> @@ -117,6 +117,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >>>       .unlock = genpd_unlock_spin,
> >>>  };
> >>>
> >>> +static void genpd_lock_raw_spin(struct generic_pm_domain *genpd)
> >>> +     __acquires(&genpd->raw_slock)
> >>> +{
> >>> +     unsigned long flags;
> >>> +
> >>> +     raw_spin_lock_irqsave(&genpd->raw_slock, flags);
> >>> +     genpd->raw_lock_flags = flags;
> >>> +}
> >>> +
> >>> +static void genpd_lock_nested_raw_spin(struct generic_pm_domain *genpd,
> >>> +                                     int depth)
> >>> +     __acquires(&genpd->raw_slock)
> >>> +{
> >>> +     unsigned long flags;
> >>> +
> >>> +     raw_spin_lock_irqsave_nested(&genpd->raw_slock, flags, depth);
> >>> +     genpd->raw_lock_flags = flags;
> >>> +}
> >>> +
> >>> +static int genpd_lock_interruptible_raw_spin(struct generic_pm_domain *genpd)
> >>> +     __acquires(&genpd->raw_slock)
> >>> +{
> >>> +     unsigned long flags;
> >>> +
> >>> +     raw_spin_lock_irqsave(&genpd->raw_slock, flags);
> >>> +     genpd->raw_lock_flags = flags;
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static void genpd_unlock_raw_spin(struct generic_pm_domain *genpd)
> >>> +     __releases(&genpd->raw_slock)
> >>> +{
> >>> +     raw_spin_unlock_irqrestore(&genpd->raw_slock, genpd->raw_lock_flags);
> >>> +}
> >>> +
> >>> +static const struct genpd_lock_ops genpd_raw_spin_ops = {
> >>> +     .lock = genpd_lock_raw_spin,
> >>> +     .lock_nested = genpd_lock_nested_raw_spin,
> >>> +     .lock_interruptible = genpd_lock_interruptible_raw_spin,
> >>> +     .unlock = genpd_unlock_raw_spin,
> >>> +};
> >>> +
> >>>  #define genpd_lock(p)                        p->lock_ops->lock(p)
> >>>  #define genpd_lock_nested(p, d)              p->lock_ops->lock_nested(p, d)
> >>>  #define genpd_lock_interruptible(p)  p->lock_ops->lock_interruptible(p)
> >>> @@ -2079,7 +2121,10 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
> >>>
> >>>  static void genpd_lock_init(struct generic_pm_domain *genpd)
> >>>  {
> >>> -     if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> >>> +     if (genpd->flags & GENPD_FLAG_CPU_DOMAIN) {
> >>> +             raw_spin_lock_init(&genpd->raw_slock);
> >>> +             genpd->lock_ops = &genpd_raw_spin_ops;
> >>> +     } else if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> >> Hi Ulf, though you are targeting only CPU domains for now, I wonder if
> >> FLAG_IRQ_SAFE will be a better choice?  The description of the flag says
> >> it is safe for atomic context which won't be the case for PREEMPT_RT?
> > You have a point!
> >
> > However, we also need to limit the use of raw spinlocks, from
> > PREEMPT_RT point of view. In other words, just because a genpd
> > provider is capable of executing its callbacks in atomic context,
> > doesn't always mean that it should use raw spinlocks too.
>
> Got it! Thanks. Maybe in future, if there is a need, a new GENPD FLAG
> for RT, something like GENPD_FLAG_IRQ_SAFE_RT, can be added to address this.

Yes, I agree, something along those lines would make sense.

BTW, did you manage to get some time to test the series on your end?

Kind regards
Uffe
