Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59C15853B
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Jan 2025 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360485; cv=none; b=bOZcrrPmU/SI+G+/fQbE8Qv0zGPGR5Z+qtZ5Nl5YL399S7S/eCZoPBKML3Zno7ZyRAHvY+YXPPa3TFeIuN50XzA7EUI0YBF6pk2qQVHk3t7clmEynDG4LkC2tn/RgaBJrnRQ73XCNkQhvtk0A7ZpLbytJrrrFgQHfoGseuSaEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360485; c=relaxed/simple;
	bh=+S8NvkoAYyTrwgUEYcA5F/xXUJWZSIXTmK9VzIshLjA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AsWZMUrwnr+sDF7uzuxEQgzdfv7DAXWpMwPrFIIt9wjczv2X5Ewm/F8ZUuOFuabAPL2kKng2rqNh17lfSF00dcusDxR9Ip8v2LsW1jOTcNSbzvmDQBS5PJjoLTxmbhBSODn6YeqyRnnjRJZGqQMT6oYKde8dIItR8mT4UkFQwTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKBK29UG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKBK29UG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736360483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlpLNqlwYQ6yBwAYzG/drxPjjxL7jhtneUfhF5aj9WI=;
	b=RKBK29UGlcQF7O7I1MwcFCGiU2QtqLIJlijt8rT3o0uAhH9egdQ6CC8uX5FphPYRuxaR7h
	cCUX6eEZTkNXVPhzJwGnikDoxC8S3giLrHveanVFTfUFz1OZM+pBwzdw9V56qlEsRMeOUs
	MuiaMQ6Vgg3L4WhNVwNGqw+BAeRPGZQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-aVm3e7DbOVG1R3d0ns_ERw-1; Wed, 08 Jan 2025 13:21:21 -0500
X-MC-Unique: aVm3e7DbOVG1R3d0ns_ERw-1
X-Mimecast-MFC-AGG-ID: aVm3e7DbOVG1R3d0ns_ERw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6dcd1e4a051so2332566d6.2
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Jan 2025 10:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736360481; x=1736965281;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlpLNqlwYQ6yBwAYzG/drxPjjxL7jhtneUfhF5aj9WI=;
        b=CJHdlwrVQBNErumI7jgcUVFo1yRD4BKqbzPbsibtkpkBN4wgW9WXAzlmtX4IvwvPSa
         ActNYwAY79R/fWf4blEulTB2DTXTsWe0PPfbSb7Jijv9XUd8y2YrCFXZUOTIC54AVLkv
         pO1ho+sxA7bwjEzc5Tp5ue7pcNKktNyICe0C01RpNBl+PWpLBHrF2GBl4d6jJRMcDkmA
         06vHaE9NKHsk4VdxXcaRgFqXgtAt7SR2621nnAl45CcQOpaO0zRX0ol5BFDytsajUbMO
         v2eE4u2zqCB4hRwElVm3BUxBlFP3iD/209MANOK3PakHouY2LBasu2c9Cxru9YQ9Euvt
         Z1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX62k0YHsclBPwv0i3LrpPyThr1xl4iYfqEnpco3GtKPmCclZanspOJ9uarukJsRU5yi7xwjzkHhVlDvT2UiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8i9EOsDcacZu17FvKv+rEjLA+E8BGGk43LsaeKIg07BbMmxSd
	wS93uWtyxXrDEpiIjyWlx4j65DisbmCY73cbC3PGCBTanhNfWSSPoBKwjAQTs82ciAYk68/5b+j
	W3MP4dmcA6gK2cCAdc/i98E1hYHFhlUER2QeQRC4lBBjGdZXZNjRri3B1a51Zp0Dn
X-Gm-Gg: ASbGncsPbeUYqiKANKNhIPvupLKW8Fq8/C7XOzPWwqZ8QOsJkmq2CqjTMLnVzO7+vZt
	rsEgsOvjAjToIplGdNzYihd/Vf70I3Ok7amKUlSa4Pyi5SyaBYLC4O6dU4ebbpQzlkpNB4bIbPT
	hmTRGlStRbAzp5TLxYImOFdUA2S66dkKw38IwTCNF7+zdFjuk33SZm9xr1XhiapgZVdVmqtHedE
	IfKS8zdbfk8YlAMsBOVZxPv6UPrAdbm+NfTHdPZkPg/RVE=
X-Received: by 2002:a05:6214:20eb:b0:6d8:8742:137c with SMTP id 6a1803df08f44-6df9b230fefmr51860696d6.24.1736360481184;
        Wed, 08 Jan 2025 10:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtoxKl96A9quCEU97ixWPX5t/wor8k6E8c0UUAhuz176F1Acu/Qdc81mrMU2DwBTqcBTSqgg==
X-Received: by 2002:a05:6214:20eb:b0:6d8:8742:137c with SMTP id 6a1803df08f44-6df9b230fefmr51860426d6.24.1736360480892;
        Wed, 08 Jan 2025 10:21:20 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18110460sm192554566d6.41.2025.01.08.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 10:21:20 -0800 (PST)
Date: Wed, 8 Jan 2025 13:21:19 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: Kurt Kanzenbach <kurt@linutronix.de>, Clark Williams <williams@redhat.com>, 
    Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
    linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: rt-tests release tarball location
In-Reply-To: <20250107141424.EoC5uS6y@linutronix.de>
Message-ID: <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>
References: <20241228114346.6020d6b0@windsurf> <87h66b2c6m.fsf@kurt.kurt.home> <20250107141424.EoC5uS6y@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 7 Jan 2025, Sebastian Andrzej Siewior wrote:

> +John, +Clark
> On 2025-01-07 10:41:37 [+0100], Kurt Kanzenbach wrote:
> > On Sat Dec 28 2024, Thomas Petazzoni wrote:
> > > Hello,
> > >
> > > I am one of the co-maintainers of Buildroot, an embedded Linux build
> > > system. Among many other packages, we obviously have rt-tests as one of
> > > our packages. When rt-tests is built, we download it from kernel.org.
> > > Unfortunately, the rt-tests tarballs are moved around: the latest
> > > release is available at https://www.kernel.org/pub/linux/utils/rt-tests/,
> > > but as soon as another newer release is available, the older release
> > > tarballs get moved to
> > > https://www.kernel.org/pub/linux/utils/rt-tests/older/.
> > >
> > > This breaks the build for build systems such as Buildroot, that expect
> > > a release tarball to stay at a given location, and not being moved
> > > around.
> > >
> > > Would it possible to keep the tarballs at the same location? Either by
> > > not having the older/ folder entirely, or by populating it immediately
> > > with the latest release, so that all releases are always available from
> > > the older/ folder?
> 
> John, any favorites?
> 

We've been doing this for 15+ years. Normally I would expect the package 
creators to come-up with a work around and not expect the people offering 
the packages to accomdate your packaging software.

How many kernels back to you need to keep? Could we come up with a 
compromise where we keep the newest kernel, plus say the last 3 in the 
rt-tests directory before they get moved to the older directory?

John

