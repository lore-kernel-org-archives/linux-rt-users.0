Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDED13B29B;
	Mon,  4 Nov 2024 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729239; cv=none; b=QagiqCg/6T3FqyBlH6NRLRQpLGMubkx3aZDIQLUGDYzJ7T8DPoNrOmJ/6huAB94Bdiz7h6dScS5pp1nP3/vA/A3ApPWr1i4m/2e8ZiXsb3A9akd2XMMmZm70sHKkcZ4xobN1Qe6oaTogCKVK0os2J7MhBLk4MQPAKZc1Kyo15+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729239; c=relaxed/simple;
	bh=tSk7r3MF2CI43gwaF+EvGuynE6AAhghA1aPNTvAowRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aT47dY1pcRSxXd0q5Ycf4SfoSbO9XKi94RWn9JSGPy8P0ZFqm1V38Um7oAf4ACrOAD6Kr77xTo94vbj/LLmkcc0hZt04RI25diCa/dn09td1ZPi5h9BBUybc5+aHvd0zsIyqKtwBah3xjWMAbr/Lu10aTDgm+VYSr+OVnGDKrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgrBAwbl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgrBAwbl"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ceb75f9631so4090412a12.0;
        Mon, 04 Nov 2024 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730729236; x=1731334036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrO6m+0lEDOk/J9N+G/zpmx+XWO2kpZRhvKVVivhyU8=;
        b=LgrBAwbl1mS9IbO7mCaEebaMhoxdoStE+wVCp68C1bS8jfZGeq5Tf41egmSXY3e/V7
         KoB6irW9vnWQtm7Y+Yfo7Gsao95FwCYJm/Oxc3TxG4rIPJPaivY39hhChT4S/EndY8oE
         j6mXk1Rj/9t1HyCriCYuU6/REJ+GZDvTEbbak0eZt4q8x+7kOsCmJi1Dk7FiNloe1d+T
         oDJgCcnaioc5co0aYkUiSRXbQRLKIoGv3eNG7SyFTIGyDpNj+ebqd/gEBVVs43TW4d13
         LW2Do3yvnbCkNK3BbyhcJnozFXKqV63DaGtVVh7FYs4VodSqXmlkds4l6JS+PFPX+VNd
         JZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729236; x=1731334036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrO6m+0lEDOk/J9N+G/zpmx+XWO2kpZRhvKVVivhyU8=;
        b=Iw7uUQ35Fs6h65I0khEZjm7F2i+0VTfRpVjplaY7frdss3/mvqxluxrRugpa1xMexg
         Xg16hoiaobzT/SPUrx3zWfESccIIz1bO5R9UT19fqcOvVRDfl2cmzfDYsnbnALWn6DVo
         3D+4SdjQ5on7UOUPIOkDUuGBaN8jcO655Ot9SDbFRaLPyZ7aR7i003xHdMq0KcqksVjy
         BujeGxMrGTagH8xC+9qzi2ff4zS4a+2y47cbrOnCv5nfkHvtVK4xfCZEEDy6gwXeL0wn
         A6MrvcpOax2MPkNieQdnMQE62NCA+bvu68GFLv5ROTQv0VoUpk072Rb1/Pu3x/IFbJQs
         1vzw==
X-Forwarded-Encrypted: i=1; AJvYcCVTerBfO7aNLs5nDXCJcwCaLBx8vxM9vSZeVJ9WpZoj8gIUfAXbRFR0J8EtSUenfGKxPqA8hPQxx9ZWdAs=@vger.kernel.org, AJvYcCVafe/Kdjtw9cPmTGq3MEpQG7Cj3YthHIZpycRi2hDbfNNmC3G/Fz8jWHRRlPtWG+pqW32LZXjH29O+jjJ6VhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZs+AVYk8ayRwwVIO5MA6yrNBO83+9oLarPysSxPXWAkiZGK0M
	S5N9mskC9TMEF5MaML6/pZIQOhqsN9zLv4MUTn1J/+/fm6wIwJyWxNdHdUDObZgQzl7w/XRTUvz
	nh7KwMpyliDUou2PHMh+2NLV8vh4=
X-Google-Smtp-Source: AGHT+IFX3DlXuvyNzLwu26s1QAtiGh7i7CAavN295/Rie4Ls/fuznG3uD5qrdFl3pWjVpiriugjM52YoQdwm2haSLrE=
X-Received: by 2002:a05:6402:3589:b0:5c9:4b8c:b910 with SMTP id
 4fb4d7f45d1cf-5cbbf87959bmr25250348a12.2.1730729235557; Mon, 04 Nov 2024
 06:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Udop9Qx_N8KwScmGk+j3NrfDry1r-Fk=5bc+9EXsfnB=w@mail.gmail.com>
 <20241104132412.dFx8w7ZH@linutronix.de> <6aadadc1-63f3-4300-9ceb-0475e0203ea7@oracle.com>
In-Reply-To: <6aadadc1-63f3-4300-9ceb-0475e0203ea7@oracle.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Mon, 4 Nov 2024 15:06:39 +0100
Message-ID: <CALXu0UdCqYJpDGKcvZ9ZvXeUkYtVW_7thGuQy4gMjgO6uo4Rew@mail.gmail.com>
Subject: Re: [External] : Re: Linux 5.15-rt still misses commit "NFSD: Fix
 NFSv4's PUTPUBFH operation"
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Joseph Salisbury <jsalisbury@kernel.org>, 
	Dan Shelton <dan.f.shelton@gmail.com>, Martin Wege <martin.l.wege@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Nov 2024 at 14:53, Joseph Salisbury
<joseph.salisbury@oracle.com> wrote:
>
>
>
>
> On 11/4/24 08:24, Sebastian Andrzej Siewior wrote:
> > On 2024-11-04 13:01:42 [+0100], Cedric Blancher wrote:
> >> Good lunchtime!
> > Hi,
> >
> >> Linux 5.15-rt in linux-stable-rt.git still misses commit "NFSD: Fix
> >> NFSv4's PUTPUBFH operation":
> >> Title: "NFSD: Fix NFSv4's PUTPUBFH operation"
> >> commit 202f39039a11402dcbcd5fece8d9fa6be83f49ae upstream.
> >>
> >> Could you please add this missing commit to the 5.15-RT branch in
> >> linux-stable-rt.git? Thank you!
> >>
> >> References:
> >> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kerne=
l/git/stable/linux.git/commit/?h=3Dv5.15.170&id=3D2f8f226f4d56fae0fabec23cf=
0af82c43cb4dce0__;!!ACWV5N9M2RV99hQ!J_i5oEOgM6dLLOAkgjiM9ncalWBDCr_5-CaHZBZ=
I8r2RU3TtvlTNnrOBlTBiS6Z0M3ETfv4emw1N632COpow2bNbsDE$
> > The v5.15-RT series is based on v5.15.167. The 170 minor release is fro=
m
> > 2024-11-01. The commit will be picked as part of the update to 170.
> >
> > There is v5.15.167-rt80-rc1 is preparation, I guess 170 will be next.
> What Sebastian says is correct. v5.15.167-rc80-rc1 is out for testing.
> This version has a release candidate, since it introduces a new patch:
> 4a1d3acd6ea8 ("netfilter: nft_counter: Use u64_stats_t for statistic.").
>
> Version v5.15.167-rc80 should be released the end of this week.
> Currently v5.15.170 is the latest stable release.  I should be releasing
> v5.15.170-rc81 next week (Or whichever is the latest stable release is,
> if a newer than 170 one comes out prior to my release).
>

Could you please just manually pull this patch in?

Ced
--=20
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
