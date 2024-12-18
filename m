Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED141FC0EC
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Dec 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551488; cv=none; b=qT+R2oDhS/Ec8G7HRP89cx3mRRfGQ5jUtN8UhYFFNFUAVHoSJ09/4ow9g3nJKTeAkcqLkr9i9YB8og/2KNVDMqXeECaUx2YqXl3qrePgVgvzvMsL8FWsCTTT1rrjOjjju+EQsby86ad6+PI1FI1z7o+YlFGAhDO2NHqmvygSmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551488; c=relaxed/simple;
	bh=1S3j1gZ2Vbyz5LjnkqseGNaACfmGlCvqGP07mh7TAJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KkESdVUsY3lafPREs+gEk8GqRLhveBm3q4zvkamg5WQ2X9pumkjIH6LfQKfd21vXeXMv+MkODncDqKiFa1dAUorlxIzUuMtoTFwmiCSfVGCrLasQwk/zkZrrqT9qDDw417aGHQL6FUYn2oVLeOoAKhEgxHkg887bDMi0ZAiun4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech; spf=pass smtp.mailfrom=aurora.tech; dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b=kP3DFghj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurora.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b="kP3DFghj"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so12272496a12.3
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Dec 2024 11:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google; t=1734551485; x=1735156285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpZESv4JKMme6J/T91rZtJT9JEh56k3z1VpoEjb8c34=;
        b=kP3DFghj19FYwNMjgaWmUfWb7Xs5f5Ct9UXMMfw8yHrPEB/7rpOXQ1cFBa+FMxf13n
         tbqSuXGbUfhfYSL6hVey1qbTsHAljH6J0ZCAkFaquFemlgrQuWiE4Z0Gh8Oso9WfJCoX
         jPAsVMCj8sFhbYqDMakHah8peWMgZTk5B+qpmmJfH0JEOe1PLpRkuWQo9yBdqwbFDIg6
         5sJL96JMfs22YSsewvb6khhBv/Fd7Npwn3jdNxzzQe9ObfzPTvoa+Xi0x8WDEGVQfBEK
         4PnSbdx64JQdIi2xBsJdy5RnQDaW4HeFfUIgOBBMOWvoSdJuUIW5gkxMpaEt/joJGP/C
         KNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734551485; x=1735156285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpZESv4JKMme6J/T91rZtJT9JEh56k3z1VpoEjb8c34=;
        b=xIKX/2kkZIvYvMkrnC9SZCgZGRAE/l0sfeUKmSzetnAbUXGmKtq8jmX2ukbf9BOsCK
         vBiegpjDFxfoTyydEbyad3JWjJDAd4rrIq8F6pHuoeMok6Uy5D8kldBJxejL7LPzgdqv
         ZsrwqwF8QML0aKMW+zDi9dE26cLVO2jF+w7h/uRQyE6JB4IuudLiRRfP+C48GFKEXX5J
         HSXtIsHZtka/Fb/8rERgiO//nnHSQW+uSFTmUD2EAtoswjWrQYB0XfE6JUYxkf6Em6Q2
         qDyhpsb8RRztKWA4zMx4s0cLd9zqmUvNAsOhlqYFWdFcaBf5T1m/gDZ/rxrExNa2xwpR
         gxcw==
X-Forwarded-Encrypted: i=1; AJvYcCUDypN+tkW5Cf0OPCnCmEU9ZTUHNGsGjP0IDMKK1OgLI+NBKR2S4IGjOI3ALwdcmxzy3lsTi35LVvEw8ALn3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFf/gk1JcYAlIZXj4UPxtFkGpPThTMP1CtYkQ4dAP0KS86S4h
	2LQfedHw3m3E8irhwOBwKNCOB9HS2bS+5A0GOud/T0k0KiHPHFWGvWvKWXQQgyYTWK9PhB7Mf6E
	2A+ffzF1GA00bivqThBvAS5J1FeVQWXvKV+90Lg==
X-Gm-Gg: ASbGncutl5ntrN/BlJ6lpEl7b6cDuPgmiKk6ck4QQxsfAqJ9h6fJhWyE3BZqtaJtvGH
	h6NzgkLLWZrdaMzVsyEHXoOW9oO7xfkNwH64iNFQ=
X-Google-Smtp-Source: AGHT+IE7BZxA6fASy3vJVWUgLL4RdazsW6DIJasx12SRwrK/c0EiC24c3Lvp5lMdUjhkUhWaB/HMZpf6tjOPd0H0OvU=
X-Received: by 2002:a05:6402:3491:b0:5d0:81f3:18bc with SMTP id
 4fb4d7f45d1cf-5d8025b105dmr386673a12.1.1734551484653; Wed, 18 Dec 2024
 11:51:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6743da2b.050a0220.118402.0d9a@mx.google.com> <6fa5d605-8a9a-4875-b15e-b236bd74a15c@collabora.com>
 <0222c0ae-ce85-4a33-9d22-df4579ee543a@monom.org> <8a6bc8e2-1e18-4af4-8bb7-d6251c5cabb6@shentel.net>
In-Reply-To: <8a6bc8e2-1e18-4af4-8bb7-d6251c5cabb6@shentel.net>
From: Alison Chaiken <achaiken@aurora.tech>
Date: Wed, 18 Dec 2024 11:51:13 -0800
Message-ID: <CAFzL-7v6d3mYYVmvXMPVRZv0xuzW3=yuj8VH1Aqh203ibLa3Yg@mail.gmail.com>
Subject: Re: KernelCI report for stable-rt: v4.19-rt-next@v4.19.324-rt139-rc1
To: gene heskett <gheskett@shentel.net>
Cc: Daniel Wagner <wagi@monom.org>, Muhammad Usama Anjum <Usama.Anjum@collabora.com>, 
	RT <linux-rt-users@vger.kernel.org>, stable-rt <stable-rt@vger.kernel.org>, 
	Jeny Sadadia <jeny.sadadia@collabora.com>, Shreeya Patel <shreeya.patel@collabora.com>, 
	Helen Mae Koike Fornazier <helen.koike@collabora.com>, kernelci-results-staging@groups.io, 
	Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 10:47=E2=80=AFAM gene heskett <gheskett@shentel.net=
> wrote:
>
>
> On 12/18/24 12:28, Daniel Wagner wrote:
> > Hi,
> >
> > On 11/30/24 11:15 AM, Muhammad Usama Anjum wrote:
> >> On 11/25/24 7:00 AM, staging.kernelci.org bot wrote:
> >>> OVERVIEW
> >>>
> >>>          Builds: 17 passed, 1 failed
> >>>
> >>>      Boot tests: 298 passed, 49 failed
> >>>
> >>>        RT tests: 768 passed, 2 failed
> >> The rt-migrate fails intermittently. Please have a look at it.
> >
> > Argh, I missed this email. Got drowned in my inbox. v4.19-rt has
> > reached EOL. IIRC, the CIP folks might want to look into it.
> It may have been EOL'd but its potential replacement, a 6.1.54-rt15 is
> much much worse for latency.

Here's a wild guess.   Could it be that ktimersoftd was enabled in
4.19, and then its replacement ktimers is not enabled in 6.1?

-- Alison Chaiken
Aurora Innovation

> >
> > Thanks a lot for the feedback! Highly appreciated!
> > Daniel
> >
> >>
> >>>
> >>>      CI systems: maestro
> >>>
> >>> REVISION
> >>>
> >>>      Commit
> >>>          name: v4.19.324-rt139-rc1
> >>>          hash: b33e0cf394c4dfb11c91395dd25ccfc2a9fd2789
> >>>      Checked out from
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.gi=
t
> >>> <https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.g=
it>
> >>> v4.19-rt-next
> >>>
> >>>
> >>> BUILDS
> >>>
> >>>      Failures
> >>>        -riscv (defconfig)
> >>>        Build detail:
> >>> https://kcidb.kernelci.org/d/build/build?orgId=3D1&var-id=3Dmaestro:6=
7437f69923416c0c9942fd4
> >>> <https://kcidb.kernelci.org/d/build/build?orgId=3D1&var-id=3Dmaestro:=
67437f69923416c0c9942fd4>
> >>>
> >>>        Build error: make: *** No rule to make target 'Image'. Stop.
> >>>        CI system: maestro
> >>>
> >>>
> >>> BOOT TESTS
> >>>
> >>>      Failures
> >>>
> >>>        arm:(multi_v7_defconfig)
> >>>        -beaglebone-black
> >>>        Test details:
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
382ae923416c0c99438c1
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4382ae923416c0c99438c1>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38317923416c0c994394a
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438317923416c0c994394a>
> >>>
> >>>
> >>>        CI system: maestro
> >>>
> >>>        arm64:(defconfig)
> >>>        -meson-gxl-s905x-libretech-cc
> >>>        Test details:
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38251923416c0c994367b
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438251923416c0c994367b>
> >>>
> >>>
> >>>        CI system: maestro
> >>>
> >>>        i386:(defconfig)
> >>>        -acer-chromebox-cxi4-puff
> >>>        -acer-cp514-2h-1130g7-volteer
> >>>        -asus-C433TA-AJ0005-rammus
> >>>        -hp-x360-14a-cb0001xx-zork
> >>>        -asus-CM1400CXA-dalboz
> >>>        -asus-C523NA-A20057-coral
> >>>        -acer-cp514-2h-1160g7-volteer
> >>>        -acer-cp514-3wh-r0qs-guybrush
> >>>        -dell-latitude-5300-8145U-arcada
> >>>        -lenovo-TPad-C13-Yoga-zork
> >>>        -dell-latitude-3445-7520c-skyrim
> >>>        -hp-14-db0003na-grunt
> >>>        -acer-R721T-grunt
> >>>        -acer-cbv514-1h-34uz-brya
> >>>        -dell-latitude-5400-4305U-sarien
> >>>        -dell-latitude-5400-8665U-sarien
> >>>        -hp-x360-14-G1-sona
> >>>        -acer-cb317-1h-c3z6-dedede
> >>>        -asus-C436FA-Flip-hatch
> >>>        -hp-x360-12b-ca0010nr-n4020-octopus
> >>>        -hp-11A-G6-EE-grunt
> >>>        -hp-14b-na0052xx-zork
> >>>        Test details:
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c3923416c0c9943351
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c3923416c0c9943351>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c4923416c0c9943354
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c4923416c0c9943354>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c5923416c0c994335a
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c5923416c0c994335a>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c2923416c0c9943345
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c2923416c0c9943345>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c0923416c0c9943336
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c0923416c0c9943336>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c5923416c0c9943370
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c5923416c0c9943370>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c4923416c0c9943357
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c4923416c0c9943357>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c0923416c0c9943329
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c0923416c0c9943329>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c6923416c0c9943373
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c6923416c0c9943373>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c2923416c0c9943348
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c2923416c0c9943348>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c1923416c0c9943339
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c1923416c0c9943339>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c1923416c0c994333c
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c1923416c0c994333c>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381bf923416c0c994331e
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381bf923416c0c994331e>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c3923416c0c994334e
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c3923416c0c994334e>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c6923416c0c9943376
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c6923416c0c9943376>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c7923416c0c9943381
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c7923416c0c9943381>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c7923416c0c9943384
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c7923416c0c9943384>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c3923416c0c994334b
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c3923416c0c994334b>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c5923416c0c9943365
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c5923416c0c9943365>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c7923416c0c9943387
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c7923416c0c9943387>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c1923416c0c994333f
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c1923416c0c994333f>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381c2923416c0c9943342
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381c2923416c0c9943342>
> >>>
> >>>
> >>>        CI system: maestro
> >>>
> >>>        x86_64:(x86_64_defconfig,
> >>> cros://chromeos-4.19/x86_64/chromeos-intel-pineview.flavour.config)
> >>>        -asus-C436FA-Flip-hatch
> >>>        -acer-chromebox-cxi4-puff
> >>>        -acer-cbv514-1h-34uz-brya
> >>>        -acer-cp514-2h-1160g7-volteer
> >>>        -acer-cp514-2h-1130g7-volteer
> >>>        -acer-cb317-1h-c3z6-dedede
> >>>        Test details:
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38170923416c0c9943086
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438170923416c0c9943086>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3816e923416c0c994307a
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43816e923416c0c994307a>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3816e923416c0c9943077
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43816e923416c0c9943077>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3816f923416c0c9943080
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43816f923416c0c9943080>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38168923416c0c994303e
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438168923416c0c994303e>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38167923416c0c9943038
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438167923416c0c9943038>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38167923416c0c994303b
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438167923416c0c994303b>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3816e923416c0c9943074
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43816e923416c0c9943074>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38167923416c0c9943035
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438167923416c0c9943035>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38168923416c0c9943044
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438168923416c0c9943044>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38166923416c0c9943032
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438166923416c0c9943032>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3816f923416c0c994307d
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43816f923416c0c994307d>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38205923416c0c9943503
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438205923416c0c9943503>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3820b923416c0c9943530
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43820b923416c0c9943530>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38205923416c0c9943506
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438205923416c0c9943506>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38206923416c0c9943509
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438206923416c0c9943509>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3820b923416c0c994352d
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43820b923416c0c994352d>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3820a923416c0c994352a
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43820a923416c0c994352a>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38205923416c0c9943500
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438205923416c0c9943500>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3820a923416c0c9943527
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43820a923416c0c9943527>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38204923416c0c99434fd
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438204923416c0c99434fd>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38209923416c0c9943524
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438209923416c0c9943524>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38207923416c0c994350f
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438207923416c0c994350f>
> >>>
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
3820c923416c0c9943536
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
43820c923416c0c9943536>
> >>>
> >>>
> >>>        CI system: maestro
> >>>
> >>> RT TESTS
> >>>
> >>>      Failures
> >>>
> >>>        rt-tests.rt-migrate-test:
> >>>        x86_64:(defconfig)
> >>>        -hp-14b-na0052xx-zork
> >>>        Test details:
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
381ad923416c0c9943289
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
4381ad923416c0c9943289>
> >>>
> >>>
> >>>        CI system: maestro
> >>>
> >>>        rt-tests.rt-migrate-test.rt-migrate-test:
> >>>        x86_64:(defconfig)
> >>>        -hp-14b-na0052xx-zork
> >>>        Test details:
> >>>        -
> >>> https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:674=
38599923416c0c9943d3a
> >>> <https://kcidb.kernelci.org/d/test/test?orgId=3D1&var-id=3Dmaestro:67=
438599923416c0c9943d3a>
> >>>
> >>>
> >>>        CI system: maestro
> >>>
> >>> See complete and up-to-date report at:
> >>>
> >>> https://kcidb.kernelci.org/d/revision/revision?orgId=3D1&var-git_comm=
it_hash=3Db33e0cf394c4dfb11c91395dd25ccfc2a9fd2789&var-patchset_hash=3D
> >>> <https://kcidb.kernelci.org/d/revision/revision?orgId=3D1&var-git_com=
mit_hash=3Db33e0cf394c4dfb11c91395dd25ccfc2a9fd2789&var-patchset_hash=3D>
> >>>
> >>>
> >>>
> >>> Tested-by: kernelci.org bot <bot@kernelci.org>
> >>>
> >>> Thanks,
> >>> KernelCI team
> >>>
> >>> _._,_._,_
> >>> ---------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------
> >>>
> >>> Groups.io Links:
> >>>
> >>> You receive all messages sent to this group.
> >>>
> >>> View/Reply Online (#74789)
> >>> <https://groups.io/g/kernelci-results-staging/message/74789> | Reply
> >>> to Group
> >>> <mailto:kernelci-results-staging@groups.io?subject=3DRe:%20KernelCI%2=
0report%20for%20stable-rt%3A%20v4.19-rt-next%40v4.19.324-rt139-rc1>
> >>> | Reply to Sender
> >>> <mailto:bot@kernelci.org?subject=3DPrivate:%20Re:%20KernelCI%20report=
%20for%20stable-rt%3A%20v4.19-rt-next%40v4.19.324-rt139-rc1>
> >>> | Mute This Topic <https://groups.io/mt/109764951/6630336> | New
> >>> Topic <https://groups.io/g/kernelci-results-staging/post>
> >>> Your Subscription
> >>> <https://groups.io/g/kernelci-results-staging/editsub/6630336> |
> >>> Contact Group Owner
> >>> <mailto:kernelci-results-staging+owner@groups.io> | Unsubscribe
> >>> <https://groups.io/g/kernelci-results-staging/leave/13729535/6630336/=
1522968245/xyzzy>
> >>> [usama.anjum@collabora.com]
> >>>
> >>> _._,_._,_
> >>
> >>
> >
> Cheers, Gene Heskett, CET.
> --
> "There are four boxes to be used in defense of liberty:
>   soap, ballot, jury, and ammo. Please use in that order."
> -Ed Howdershelt (Author, 1940)
> If we desire respect for the law, we must first make the law respectable.
>   - Louis D. Brandeis
>
