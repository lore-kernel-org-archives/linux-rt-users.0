Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363443147
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Jul 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539110; cv=none; b=BE7L+htPl2Fe8+rEkxwKXYJC8hGFj/7u3xAP9OWkroN7qhTPgnSe/G0XIjF2IZ3uIfMxVN6WMM4QlXIaZ4/IFe2rKpWczMsv3X5bY2hLqzFpygWy922h9eIFy+HLzFWNVnOiEjmw+wxqORXM1LygKn3HsUmwCc6lVLgUt2bghOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539110; c=relaxed/simple;
	bh=voZI5s8NJ7G6cqBvxozBaN0IUoJi+5Na3Tpon9hVe7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ougdxK4p3zIVX/9+U6jzH2scr622CElUCPY+6MExrGHBnYmTyNmTnVQfOIzFqHfHz8oRGkQBPiT7uh9x57EjUINMzgl4Dq3BUU6T7MJdLhAjGYXegQ67ZBhQvZlyCxqypiaoRNafn3PpmtYjSpb2USSnd/83qLJXcTHHRg1sQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OJwghMV7; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJwghMV7"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e03a8955ae3so5164782276.1
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Jul 2024 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720539108; x=1721143908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qQoKhA+ICd3MJpIZmDmZs/xX1LjfxyqH2Gz0ml2Sepk=;
        b=OJwghMV7yN0k9UHa0lk7VpVtaqxiR88169IcFVg+WZKL283wZmhN50dP74AK6bhtwg
         YcJ9Md4gfmOMWI/X5Qjm+E2Lkb+IqKVez21rsM5Tl9dH6xfGjcrGaSafe1VyBeklnwZR
         ISOCw0kZzkBR4Izwavd4OeRzsK4PD2Uk4gx/1f3fV4Jy2+KeCVaqTOFu+o6y+W0FvKIG
         eUIhWOxhPo/FJTSw9ZMDCkXBFVCcupxRy4tcwx/laFXLx5vfQXmencSmieAPWk+wTFZZ
         UEiSW+LpntVFNjdmxGp8pxEu+lR35QMxUFTdBviMrJdGBjR+G7FGn9cQ8hmqCkVEzNek
         Nn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539108; x=1721143908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQoKhA+ICd3MJpIZmDmZs/xX1LjfxyqH2Gz0ml2Sepk=;
        b=Jppu8o2onby4dxQj3exV/usd6xZp69W7+Q3r4X+F/AcQjKd9fS7+YC18HaDDepGb+n
         tzHnCTJNiIt3/VCS+3839sSH5OTO1678atVWkuh7zwtsaJPHvNVjllpNYo2De/sAdt+g
         +Q5YoVIDsmoLYqXj4nzCxLkJOdloyZbsYu8gkbx3wyAIij1QDNMTvDbJUvih0Go9d658
         xfNoBThA+nRuUO+Asm5AV9KAv1gK0jHpyM0B0ObnHd6XTQYXRNtUTSQzyFWa4Epd3X6x
         KfhiIWtSdht75l5ImybqLoESl4TTQhz+dLFe8I4WD0nll/g5sk+PxAR8vbTcj7hWAC+W
         BKuw==
X-Forwarded-Encrypted: i=1; AJvYcCUvYs6gS/508UmGN2coLOXmD1/VGq3Wc/nqqUeKwTW4qRJ/BIoOOWpbWg5fcaJliukQwB0jg/FpuUYDaulb7nb34A6vwK3LML1ZNh9Sd6g=
X-Gm-Message-State: AOJu0YwkSo45183grqy1R/XTp6H/ZskzeJUV36aQFMeeydlw3Z+Bd6jf
	tnOtTEcpXzdYMrMsaRq70YCKw6FKek+XePnyb8qJkLl3MdfeVLCslV7nFsAwGAFBXDx3iChYWqj
	Xaw5HFBW4NT90Y2aYh7AXLIRYdSPi/CZbk/r9rC9Wz75XeTdm
X-Google-Smtp-Source: AGHT+IGAIeptn+tE7RkQYiH+yO0nFWuIoGL2cBnHEGQOA05tCKNOiKuaJATENwPLzVHZt9hSxTz4NtjwLh9UJcOo5kk=
X-Received: by 2002:a25:d30b:0:b0:e03:6241:b8f9 with SMTP id
 3f1490d57ef6-e041b070896mr3436258276.1.1720539108320; Tue, 09 Jul 2024
 08:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527142557.321610-1-ulf.hansson@linaro.org> <20240708135310.3VRFnmk1@linutronix.de>
In-Reply-To: <20240708135310.3VRFnmk1@linutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Jul 2024 17:31:12 +0200
Message-ID: <CAPDyKFo6hE9BPgS7Bhe259Mxki-KBZDYyMkaBPFuznETbZhGkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] pmdomain/cpuidle-psci: Support s2idle/s2ram on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, 
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-rt-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 15:53, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-05-27 16:25:50 [+0200], Ulf Hansson wrote:
> > Updates in v2:
> >       - Rebased and fixed a small issue in genpd, see patch3.
> >       - Re-tested on v6.9-rt5 (PREEMPT_RT enabled)
> >       - Re-tested on v6.10-rc1 (for regressions, PREEMPT_RT disabled)
> >
> > The hierarchical PM domain topology and the corresponding domain-idle-states
> > are currently disabled on a PREEMPT_RT based configuration. The main reason is
> > because spinlocks are turned into sleepable locks on PREEMPT_RT, which means
> > genpd and runtime PM can't be use in the atomic idle-path when
> > selecting/entering an idle-state.
> >
> > For s2idle/s2ram this is an unnecessary limitation that this series intends to
> > address. Note that, the support for cpuhotplug is left to future improvements.
> > More information about this are available in the commit messages.
>
> I looked at it and it seems limited to pmdomain/core.c, also I don't
> know if there is a ->set_performance_state callback set since the one I
> checked have mutex_t locking ;)
> So if this is needed, then be it. s2ram wouldn't be used in "production"
> but in "safe state" so I wouldn't worry too much about latency spikes.
> Not sure what it means for the other modes.
> I am not to worried for now, please don't let spread more than needed ;)

Thanks for taking a look and for providing your thoughts. Can I
consider that as an "ack" for the whole series?

Before I decide to apply this I am awaiting some additional
confirmation from Qcom guys. It's getting late for v6.11, so I may
need to make another re-spin, but let's see.

Kind regards
Uffe
