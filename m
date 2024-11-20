Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475615DBAE;
	Wed, 20 Nov 2024 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088414; cv=none; b=n/GNrrDM1kqEhFBYwFXFleAqY2VlIQFgbYxoYKq5oaHdZ9LR/uuEJdry6RuGaifDJg8IJ6vRB68Ub7vrs7hQhA2CX2x3Jp90bdvxVikn+8mfIaa4YkhXb8yiryd8kxsKR+E2xxFcbO4UIF/NvRQO6JX4CpYtF+yav8MYyKxuILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088414; c=relaxed/simple;
	bh=BmE0p7mm5HCQjrvucM4FO0Tiw8oj1KVX1AaQUJLFyuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3oSfqCbHL/a7aH4TueUeEoDdKEtuoaAjb2v85WbfyDhDJMU5Cd8fxPZejilbumUhrdrq2KNhWbb7KAXT26Cm2CUGZOYM45qzKVuHU+1N1QqYB9bJTvXT7GZnx0LGMijFqIi9zHV/i1WPTsuz2wNi5fEsWXVhOMjsYMw7wFD0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqrH7D1W; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqrH7D1W"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfbeed072dso4776823a12.3;
        Tue, 19 Nov 2024 23:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732088411; x=1732693211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llUfhdVZIco/FslmDl/EI8VgKcRfAJLjq/jSTC/0S+0=;
        b=nqrH7D1WJ6gP8/eKC56ALbqS2qM3jHbSFjMXSuuEb5T0VaEITIRSA4qibeg6rzYOUS
         95juwDPQ6pymiiLlQ2ACvNmTKF/BEvT3ogkkWEINAoxPfs+hAqeGLL0SFqmjGrLDD/dw
         tOSHNDqh6QK2Ghp9ajRWCF9fVTlPbwTirzpKEATZ8Md9KAk4APUZCcSE6nR4RYnNWT7R
         Gp3jiQA9nSZJjktowB3QB3Te1Ol06ZOMJRvLdP0oE/4PCcnpmQHrYfIcpa5UBW0PnLRs
         80HDdX9M4ViNj4JGk15g9SqCjNA0w3qy0M41eK9IrqMmr8wtd+74DFEfIJnXtrQ7QXi5
         oCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732088411; x=1732693211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llUfhdVZIco/FslmDl/EI8VgKcRfAJLjq/jSTC/0S+0=;
        b=BvP8IOXMvH3zHZdcIZ8/YfkqPi7Gbz/gsD+wyuK29lNSCvKh+6SJeUQyJra1d/RoCl
         gA1/RokNv6KKXPdndONKHKG5ruEhC42NWoIh25xH0op2EGK1L0rVOwe/TTbxpjUC/aN7
         4efJ8cvQGwNGNJefbKk8RaQWBhib8syb8RFG2kZo9ejczjPqIHlaidAnpPnRWzLQdIOT
         WWyp1xtS3sZTc+pivqQGBX0z5A3eXCxiiOh4qUsWBSXoV/vNutk71ecIuGgM1mIxAPpr
         48Sncg4e7rnPk88xRpZSvMzCDjapdcnljElDKKJ24jmySRP78AfgL/PIzfKaC4TXNIui
         Ek1g==
X-Forwarded-Encrypted: i=1; AJvYcCVRf6VthEFR73+GZPAUKLWYFyerbdcKATa0PJUPyciws1IcHPr1nRaKKYAUrb2cmWpE8Ulam2c01kO3rcs=@vger.kernel.org, AJvYcCVgEk09TKQ+TJ5Z/t04jCZOLX8p9bxQWzZArvbELjKlKei6O3tCbManR+zzRPzAmbDNDgWT9r7Jpi5FyrEvv2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vAdEt29qAPEqy0bJC/klXykb+LTEmlbr79BvFxhgmelPTI1k
	ZnubmfUhMDSMfJrAeUeERJM5bXbUXJUEJnrEFV8Bxsh95zHupYga1HHVQewW/48M8NXBbTKl0lM
	Y4we9r/JeUt/RHyJsh0DXBZewijc=
X-Google-Smtp-Source: AGHT+IE6uWUsrgFjiF0arFsc0SzpGZxgNX1E2jtXKQFzzga+tCD0muwzP9oOmLAiaoegFhdhFyr/8iYYMAyqku1wz08=
X-Received: by 2002:a05:6402:845:b0:5cf:d154:8360 with SMTP id
 4fb4d7f45d1cf-5cff4b2b39amr956280a12.14.1732088411217; Tue, 19 Nov 2024
 23:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Udop9Qx_N8KwScmGk+j3NrfDry1r-Fk=5bc+9EXsfnB=w@mail.gmail.com>
 <20241104132412.dFx8w7ZH@linutronix.de> <6aadadc1-63f3-4300-9ceb-0475e0203ea7@oracle.com>
 <CALXu0UdCqYJpDGKcvZ9ZvXeUkYtVW_7thGuQy4gMjgO6uo4Rew@mail.gmail.com>
 <d370e7e6-9b33-4901-b49b-699e1932dc49@oracle.com> <595e91af-7737-4567-94e6-6f97a281354f@oracle.com>
In-Reply-To: <595e91af-7737-4567-94e6-6f97a281354f@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 20 Nov 2024 08:39:00 +0100
Message-ID: <CALXu0Uf1nNNKnyY9yeL-EZ5uFMOvt9LQr1iKdh6MpHqq2PH=6A@mail.gmail.com>
Subject: Re: [External] : Re: Linux 5.15-rt still misses commit "NFSD: Fix
 NFSv4's PUTPUBFH operation"
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joseph Salisbury <jsalisbury@kernel.org>, 
	Dan Shelton <dan.f.shelton@gmail.com>, Martin Wege <martin.l.wege@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, 
	chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Joe, thank you

Ced

On Tue, 5 Nov 2024 at 21:42, Joseph Salisbury
<joseph.salisbury@oracle.com> wrote:
>
>
>
>
> On 11/4/24 12:10, Joseph Salisbury wrote:
> >
> >
> >
> > On 11/4/24 09:06, Cedric Blancher wrote:
> >> On Mon, 4 Nov 2024 at 14:53, Joseph Salisbury
> >> <joseph.salisbury@oracle.com> wrote:
> >>>
> >>>
> >>>
> >>> On 11/4/24 08:24, Sebastian Andrzej Siewior wrote:
> >>>> On 2024-11-04 13:01:42 [+0100], Cedric Blancher wrote:
> >>>>> Good lunchtime!
> >>>> Hi,
> >>>>
> >>>>> Linux 5.15-rt in linux-stable-rt.git still misses commit "NFSD: Fix
> >>>>> NFSv4's PUTPUBFH operation":
> >>>>> Title: "NFSD: Fix NFSv4's PUTPUBFH operation"
> >>>>> commit 202f39039a11402dcbcd5fece8d9fa6be83f49ae upstream.
> >>>>>
> >>>>> Could you please add this missing commit to the 5.15-RT branch in
> >>>>> linux-stable-rt.git? Thank you!
> >>>>>
> >>>>> References:
> >>>>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/ke=
rnel/git/stable/linux.git/commit/?h=3Dv5.15.170&id=3D2f8f226f4d56fae0fabec2=
3cf0af82c43cb4dce0__;!!ACWV5N9M2RV99hQ!J_i5oEOgM6dLLOAkgjiM9ncalWBDCr_5-CaH=
ZBZI8r2RU3TtvlTNnrOBlTBiS6Z0M3ETfv4emw1N632COpow2bNbsDE$
> >>>>>
> >>>> The v5.15-RT series is based on v5.15.167. The 170 minor release is
> >>>> from
> >>>> 2024-11-01. The commit will be picked as part of the update to 170.
> >>>>
> >>>> There is v5.15.167-rt80-rc1 is preparation, I guess 170 will be next=
.
> >>> What Sebastian says is correct. v5.15.167-rc80-rc1 is out for testing=
.
> >>> This version has a release candidate, since it introduces a new patch=
:
> >>> 4a1d3acd6ea8 ("netfilter: nft_counter: Use u64_stats_t for
> >>> statistic.").
> >>>
> >>> Version v5.15.167-rc80 should be released the end of this week.
> >>> Currently v5.15.170 is the latest stable release.  I should be
> >>> releasing
> >>> v5.15.170-rc81 next week (Or whichever is the latest stable release i=
s,
> >>> if a newer than 170 one comes out prior to my release).
> >>>
> >> Could you please just manually pull this patch in?
> > We generally don't create releases for individual patches that come in
> > via stable releases.
> >
> > If you need this patch due to a time constraint, I can release
> > v5.15.170-rc81, which includes this patch, immediately following
> > v5.15.167-rt80. That would be towards the end of the week to ensure
> > proper testing and allowing for feedback of v5.15.167-rt80-rc1.
> >
> >>
> >> Ced
> >
> Hi Cedric,
>
> The v5.15.170-rt81 patchset is now available.  This release has the
> commit you were interested in:
> 2f8f226f4d56f ("NFSD: Fix NFSv4's PUTPUBFH operation")
>
>
> You can get this release via the git tree at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>    branch: v5.15-rt
>    Head SHA1: 67017c496f78e15598f48bb3115e3641a82ae507
>
> Or to build 5.15.170-rt81 directly, the following patches should be appli=
ed:
>
>    https://www.kernel.org/pub/linux/kernel/projects/rt/5.15
>
>    https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz
>
>    https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.170.xz
>
> https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.170-r=
t81.patch.xz
>
>
> Thanks,
>
> Joe



--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
