Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8831B78F3
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158499; cv=none; b=ayF1i2ItUexOrL9rPR1vp/TW+2S8iOHhVsinpw3Ojog4wXYdkudOu1hcE6JBMdI2p9QOWgF4ns/0mXE1zLbblR2QjThSw8ZaS1Dk3wCgwPHLUolanrtWRSHOtzvX0wBBw4gf2LRyYHErMPnbGuXNHosgzDuEQ7cfKGSrkPK1gOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158499; c=relaxed/simple;
	bh=rTCP0eFlUYf1cAy9AjZjkIhxqdiUY75FHK6S4X4wtU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Di/SSuXlniRQXL/NOlUWk6PWmR5G74/sWMgu54aSuehvCiZtkHN/yNYYa2uRqjXnitl94EXIpUrhsYFoBwDEOo3SdZEQTCZ6csLZxFKv1wM12E79i7gF2x+xM7RQunNZHllU8M/6nEsljiThJtclfSkGkopx3W56xwl244LtgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rwUGKSUV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwUGKSUV"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e5e6ab7b8so10901567b3.1
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2025 07:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752158496; x=1752763296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlZgkHsxN8ZXtcGrfVzgc7A5zah0HXAJABQ2cFxyfyc=;
        b=rwUGKSUV8Slq1pMf/VqILsmsYbgr2+yuMHjomTPOb6GmpP4oXw1oQwnqaG+8Sw+XuP
         npNEi9gXsKSMYsgdSQxuyjiAqwvdnf/bSsTt13RapO8FKyBRo9SgHHp+TXJdrHPXDHkj
         O5OuAWQWwkg+iNFCUOiBXJLIPJH8/hhxAIOQ1wAOK7XPoEwFoKV/bS/3C7S7uk5rrUZ3
         x+bohO63snsJ7AEuMqKscfSaZFdTuFGiYxZsD9FscpFISuJ/q6T6U5YP2EOkpyUYWsQG
         nvSHGiXfTiMc/cQ/Dd8dfL16nL2AkuuOF4SKAM9WrQUpIjDXPRRgVtTk9IpEDMQ9bvdf
         EvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158496; x=1752763296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlZgkHsxN8ZXtcGrfVzgc7A5zah0HXAJABQ2cFxyfyc=;
        b=vXxVEiienu/4wMrWeU+pnxDT5yKjwfxDph7Bw0h+VqEB7vyUhq5ypM8uLC/C/XBwEo
         M23/zz3rabx9y+C5b67XklSfZqMPcb6Ibeb4WQXqkJ7RxrUA8sj9XUEPtK6ZtVDQCSIV
         DUt7APV5/+Rt1uEryKjlaTp8VQ90XSfpnM0buDrUyWSuqMWJLLBz8jG/V+dWOLnnAFOj
         duFBap5BCFdK2aJuHeHRkhuI+Uxj6+pirf3vtrcUOGotiBcSicQNYbtu0Ulc7mY08cLT
         1EaHYtAsWqUvgA0kBdAy6w5HpvbtAEKEaF5ZWBTUpF5Gd0sbCsLkn1gxWBnjOlmwjHj8
         Wu9A==
X-Forwarded-Encrypted: i=1; AJvYcCVJlg3Tg3U/r1P5jo+6QOy5O64dmDzj6XKqacVcLjWweEAnOBCC1eIfgJKg6ojyZwPBJWeYN0yA8TDyRwaS9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJ6jQsLjy+0JTb65G9VdNcL2HL2fINN/kloeJ4j3p5auBKXBD
	iTo3zDla4f0LITo+ccIgDn3I+OKpZP6yf3WBCbk2eQMlnXZm1V6iFp9RbxEldwdAnzVWNzIuoY2
	F1xV0DKhJ7gTiXtivH0P0IpuOxjULJ9b6LidZry4JTQ==
X-Gm-Gg: ASbGncvTdyjuBOm2XJWJR3C8eEvAtleNY4jBSK0IXvy4bqhMsW/bzxz9M9X/3L9mvgE
	hJR7XiE1Tse5JXuXNJ1vqa2IH2SwcvIQupnZHqr6CWuJ8bPfzfjrTtncFYhcWjkQVYJoQOC7xMC
	9TQGxI0odcIuWWL1PfWSzYMZqJjnMxAj5wajoeeX3/xa8=
X-Google-Smtp-Source: AGHT+IHVD6gPsHq+Dexvu9tOsagl+k20PpDSEAg/CCtZ6R9oh9y4FIYINC4cgMj3d0zJYPGC/y7DQa6nR8qkXx9Q06g=
X-Received: by 2002:a05:690c:d90:b0:6fb:b8a1:d3bb with SMTP id
 00721157ae682-717b19cb233mr100039137b3.17.1752158495634; Thu, 10 Jul 2025
 07:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709154728.733920-1-daniel.lezcano@linaro.org>
 <CAJZ5v0ixk5hZPPQc_1rDLMTzjh=KpMQF_A2U=HehMTuNSMQwtQ@mail.gmail.com> <aG-40INpi05v3-fQ@bogus>
In-Reply-To: <aG-40INpi05v3-fQ@bogus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 10 Jul 2025 16:40:59 +0200
X-Gm-Features: Ac12FXw291rGaeQnkKGBJOE99wWaDDVeGF-LGyRZrV90PjOPwqUc_kzJDb-fgDQ
Message-ID: <CAPDyKFqS9fawvgxEhk9W=o3oUpA_HGc71-5siw8AGqenQegrLA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
To: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Raghavendra Kakarla <quic_rkakarla@quicinc.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jul 2025 at 14:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jul 10, 2025 at 02:43:10PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 9, 2025 at 5:47=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> > >
> > > Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
> > > not supported because the underlying generic power domain functions
> > > used in the cpu hotplug callbacks are incompatible from a lock point
> > > of view. This situation prevents the suspend to idle to reach the
> > > deepest idle state for the "cluster" as identified in the
> > > undermentioned commit.
> > >
> > > Use the compatible ones when PREEMPT_RT is enabled and remove the
> > > boolean disabling the hotplug callbacks with this option.
> > >
> > > With this change the platform can reach the deepest idle state
> > > allowing at suspend time to consume less power.
> > >
> > > Tested-on Lenovo T14s with the following script:
> > >
> > > echo 0 > /sys/devices/system/cpu/cpu3/online
> > > BEFORE=3D$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/i=
dle_states | grep S0 | awk '{ print $3 }') ;
> > > rtcwake -s 1 -m mem;
> > > AFTER=3D$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/id=
le_states | grep S0 | awk '{ print $3 }');
> > > if [ $BEFORE -lt $AFTER ]; then
> > >     echo "Test successful"
> > > else
> > >     echo "Test failed"
> > > fi
> > > echo 1 > /sys/devices/system/cpu/cpu3/online
> > >
> > > Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology=
 for s2idle on PREEMPT_RT")
> > > Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > As per MAINTAINERS, this is for Ulf/Sudeep.
> >
>
> LGTM, so
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> I still prefer to hear from Ulf who has more knowledge and hands-on exper=
ience
> with s2idle + PREEMPT_RT in case I am missing something.

Rafael, Sudeep,

I will pick this patch via my pmdomain tree, but will run some tests
of it first to be sure.

Kind regards
Uffe
