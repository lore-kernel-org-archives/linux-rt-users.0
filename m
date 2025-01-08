Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900D80604
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Jan 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363140; cv=none; b=YxXiU6+ri72HsRczVWwZ/QxMtcuiScHBMdgrv+QPeKghqYPqRSEw227vIi8Ton90X1ptPeiWnCyHes0OmdfCo9YV0MZX+W0rrwJONpv1sjyL6HP35IUswbwJGUQK43+0I6isWU981T3yY+HNJwGC0omHLjdGXdU8A1RvaCWp0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363140; c=relaxed/simple;
	bh=wuFX24k7kJj6mdmsBst1dw1zCW6SHKDkJrlW5P+grOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0EeaFX9WMqTZeddPcjvxyeD6Yh7/O2TPjI0YlwIHViAEPH2p8UPF4xzurPsU9YvwIhlJKmEEg+6133PyeCqlROfFAXe0TOHRHVhH5kWK92Nkjb6CJZhqfrV5b02vUeY/ipOMsZPcfbegYaJdk5dXMEQVvEvYp6A5uYPt1FXoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhS+S3om; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhS+S3om"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736363137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuFX24k7kJj6mdmsBst1dw1zCW6SHKDkJrlW5P+grOU=;
	b=XhS+S3omVUicfPr8GGgMeZZUJL5QcDD1BMNK+JOCcpp7CH3ED4Al9C1QR2CJsbXAGmzqhM
	ut69iuCde/9VVM23b/xpSf14kFz8dN1TGFUAoDVmsLAmt/xAInSRUWe7OENuWReI+sRRtY
	knBrl8icrkjYADmBj8/kJ6X8o1W3Q1k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-QFYeISdyM-izDYBadrZu6A-1; Wed, 08 Jan 2025 14:05:35 -0500
X-MC-Unique: QFYeISdyM-izDYBadrZu6A-1
X-Mimecast-MFC-AGG-ID: QFYeISdyM-izDYBadrZu6A
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d87d6c09baso2012896d6.3
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Jan 2025 11:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736363134; x=1736967934;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wuFX24k7kJj6mdmsBst1dw1zCW6SHKDkJrlW5P+grOU=;
        b=kC+8mirEv2kWl5XKvTy6hSRimXVftbijswgidkk6ztk0WvRrbXnhDLuO6BEz16HS+f
         wwX2v8hM2sA5Qn4Fn5a9GX7Ki5wCR11pE5QA3yxUjj30Zo98aIBpF1pwS8jS1dTAqbjl
         Oz0dtkJS/GkBQOP+vMBALBtGSYT+1xzRjy5plZhW6vmBuaIEici6dswaU9v62nQmzaaq
         QZ8XtWPmuPU37yKPUmXWT7Y12lSTz6Cyk5MWr5tEx9KyUQwaBe0wRy3O38XNssHwRb5y
         wIZyJRlZLummX5wVk4xK2jxAgRrs8pWNGrFJg9hAgwpLsPGTwK9CPRWdyV4hRVvVl4fr
         wFEA==
X-Forwarded-Encrypted: i=1; AJvYcCUgGyRJqQKmxeS90Cu7QLD4/GdOwF55apv+EOG/nGMzoPCt7lQ5htIlbqPU/Nkuo/RyQcCWH9fgeDZ85yWwpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ahevWnLTmvR16lc1O0aSVKzvnD2Xuy8G11UWiaLdS/80N9Pu
	tQizqF8c5xRsCMlAnMR5oAxZ3yNcJ6TvAo7wOE9D5Ku4j4vno3myVG716DMBFA2yrvEV7Kx+x7E
	S32J9aBdpCOj9PhVKWMgKtwrlHm4NO6nhB6Sgm7QqE9ovJ2b61zUJSYQC9h1lFnpAxV1MqXhGUl
	8=
X-Gm-Gg: ASbGnctXp51nCqy/PFHLFT2RKUVrX0hK57OSZstZvFpTfvA3JOM3MTiDB8DW/utVpNK
	H+L6ZhAc7dJB/i3HyYxlzs4A1dxVqoCyBvr3bCBCRc/Kg2z4wPOCWGvSuhfU7P5bTVeBsDs2d6U
	eehSZiSPUsccXqPZmPEs20HCUdf5ANDxwsjfM0122yRv+dTjEcH/dGCFr0H7w7bXcKPflMYjtlB
	AsXo/YzXU7mMoEcTd76cSwlDnICSs6Btyf/r5SR3E/FVBJI2zRkFWBXTBBMu9MZoTHJpq5TQgGt
	L6hwmRN1975UIGL9JyRzgg56e375NLTfKk4jHuxGfRd5bQ==
X-Received: by 2002:a05:6214:20a2:b0:6d8:7e03:c427 with SMTP id 6a1803df08f44-6df9b22fc82mr49329696d6.20.1736363134326;
        Wed, 08 Jan 2025 11:05:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh1FUWrzH0rNf46NpNRhGVDydxSkYOjcmzzQDpIF1fdaHVKmRQjk7ESdga1vHtFIGqWmZwrg==
X-Received: by 2002:a05:6214:20a2:b0:6d8:7e03:c427 with SMTP id 6a1803df08f44-6df9b22fc82mr49329506d6.20.1736363134041;
        Wed, 08 Jan 2025 11:05:34 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d3169sm192774116d6.102.2025.01.08.11.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:05:33 -0800 (PST)
Message-ID: <864fc2a605ac3d97a927947902ace34d31c8d4a7.camel@redhat.com>
Subject: Re: rt-tests release tarball location
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>, Sebastian Andrzej Siewior
	 <bigeasy@linutronix.de>
Cc: Kurt Kanzenbach <kurt@linutronix.de>, Clark Williams
 <williams@redhat.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-rt-users <linux-rt-users@vger.kernel.org>
Date: Wed, 08 Jan 2025 14:05:33 -0500
In-Reply-To: <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>
References: <20241228114346.6020d6b0@windsurf>
	 <87h66b2c6m.fsf@kurt.kurt.home> <20250107141424.EoC5uS6y@linutronix.de>
	 <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-08 at 13:21 -0500, John Kacur wrote:
>=20
> On Tue, 7 Jan 2025, Sebastian Andrzej Siewior wrote:
>=20
> > +John, +Clark
> > On 2025-01-07 10:41:37 [+0100], Kurt Kanzenbach wrote:
> > > On Sat Dec 28 2024, Thomas Petazzoni wrote:
> > > > Hello,
> > > >=20
> > > > I am one of the co-maintainers of Buildroot, an embedded Linux buil=
d
> > > > system. Among many other packages, we obviously have rt-tests as on=
e of
> > > > our packages. When rt-tests is built, we download it from kernel.or=
g.
> > > > Unfortunately, the rt-tests tarballs are moved around: the latest
> > > > release is available at https://www.kernel.org/pub/linux/utils/rt-t=
ests/,
> > > > but as soon as another newer release is available, the older releas=
e
> > > > tarballs get moved to
> > > > https://www.kernel.org/pub/linux/utils/rt-tests/older/.
> > > >=20
> > > > This breaks the build for build systems such as Buildroot, that exp=
ect
> > > > a release tarball to stay at a given location, and not being moved
> > > > around.
> > > >=20
> > > > Would it possible to keep the tarballs at the same location? Either=
 by
> > > > not having the older/ folder entirely, or by populating it immediat=
ely
> > > > with the latest release, so that all releases are always available =
from
> > > > the older/ folder?
> >=20
> > John, any favorites?
> >=20
>=20
> We've been doing this for 15+ years. Normally I would expect the package=
=20
> creators to come-up with a work around and not expect the people offering=
=20
> the packages to accomdate your packaging software.

Even when the status quo is both weird (unstable URLs are bad in
general) and has caused issues for multiple packagers, and there's a
simple fix?

>=20
> How many kernels back to you need to keep? Could we come up with a=20
> compromise where we keep the newest kernel, plus say the last 3 in the=
=20
> rt-tests directory before they get moved to the older directory?

Or just don't move anything, and keep everything in "older" including
the latest release, with the latest release also being in the current
spot (i.e. Thomas's second suggestion).

Or turn older/ into a symlink to the current directory, for
compatibility only, maybe with a "latest" symlink to the current
release.

-Crystal

