Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E331DA63F
	for <linux-rt-users@vger.kernel.org>; Mon,  2 Dec 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167826; cv=none; b=ukkPApmapWL/NvCr1oBA3G9135C9yrSBHD5c0KFs5yh6/Bg8H24TU4kEA0jgKvu91vHorNhij5TaUU0veL4ur4vuCtUtF1wj8fsqVyKnfZBwisxY9iR1fugdBSyQAOdAO831cooI1Ts4i3W72lRTvxTznCcgwNgSxruXK3/lVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167826; c=relaxed/simple;
	bh=gTlNLfascC3qscQi9u1SPygm1N1yTD8e6dZtj7KP/Io=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AhGSq1ND/uYk1q2K552wtOO6v1DDniO98NyAT7EKufpoYqNRSWTMshzQNjGiZaZC0ehfT7mTtV8gbf92hHpWoJcM2mjzg4bhbz/r8hVQxYEiADGtCY0TiVzlGt4hD9fbeFxWzjZsz1Z4Zd/AL7fCbKt10S7K3864GVigVvlVpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQJvxxt3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQJvxxt3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733167824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnoh7RJPrXrLuVBgSSWj/lNHhgVqUr+qm8Z/JFv6aTE=;
	b=VQJvxxt3HOXfhCjuJ6JhK/6wmEmNq9/OgCYS6uHiEK0ZznLfZ+t7qMq6uF/P3s8vxYywuR
	x7lilQKsxVLD5NWRP8HnOXyOO3zwM/d4DrlmNHiRt06+pY13E1gP5DOHUFquwrwaJV6G1C
	9SwIxVVR8N8SHf6DZZWi5xxISteK5Uk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-n9RX8SoUPr-KIqAunmMwOA-1; Mon, 02 Dec 2024 14:30:23 -0500
X-MC-Unique: n9RX8SoUPr-KIqAunmMwOA-1
X-Mimecast-MFC-AGG-ID: n9RX8SoUPr-KIqAunmMwOA
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3ea4d873617so3367181b6e.0
        for <linux-rt-users@vger.kernel.org>; Mon, 02 Dec 2024 11:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167822; x=1733772622;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tnoh7RJPrXrLuVBgSSWj/lNHhgVqUr+qm8Z/JFv6aTE=;
        b=KOs/u2ph4P5QwVi/iyDCRQX0dHK4Vx9HvVTXxZtENATAOcQ0xmLXi57CgkKGZ8Duk/
         TBllaVkixwEBfJncDEo40PWFnGzUa1iZP1mcNpMapSjXuRkXu/Mu+vraE0zAqEXXhKA7
         6rwh+1VcYKwuczDmv9bOun8WFsDAuE7O8epsZSaR3k7SFv50pwk366NhHJHb3KOXcocR
         wYbgmey77FVOe8Bo+uogaB4wXqdJtHNbVrZv1mSZXlt50CSt2HG4w2r2OgmokYstAMFj
         ReGWnDSwv8Iuh4LoNfoEb2KNnNAI6NPHQCaRWgqYjZiMpOr3jF1KEcip/hOBL+Vw6HF6
         L29A==
X-Forwarded-Encrypted: i=1; AJvYcCUpoIdL8TznynqR4KTY1g5bxHu8DGuUO3HNMDBxwN1R37F6Ti1ogdX+KFVSnSwAtFSYR2T5/lVAAuxxzm3utw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnkW6Rwlmgo32wBOSdF1AXktfPVHns/oMH75cMy6FY+fvP8zj
	yJiTia2njZ/pMDtq9SOgfc26PWUS9YVzQGo3li+GV6tvsj8x8q0COeUe6EcEu/pZK2dB1aWc2Wf
	/BP1OEeTLMs1MCoEMMu78RZ4irystspC5gBdT80jw7S1bXCRpbIMNzLzAMIUsNFajRRCMqQui
X-Gm-Gg: ASbGncuMsBDXGiOHt5cPbjfAS0gxO3dhaCoG6rzdlDPonA8pDdRNUC/0r7kEdEFqEFl
	om8p0XGoE8ad8EknpagOWDzmGdV06YGlUveB7urkqhhBE1D0prMyOOEZ6tBwf5NR9xpE5yu9YUq
	6O8n3zd9w1Mf7T6Gga/CedoiZPLeLbctX3sHv2ic1RIY6P02jgSsD9IdvlaHrpoVtFCxrSsZNI3
	iSoiuJ41fYDkAsp8vMgPf0ag9Rdjg7mMLu+CyTWfMvEug+HAoNql4ao2/Dy40czylLpEjHp15ok
	P7+pjg==
X-Received: by 2002:a05:6808:1448:b0:3e7:a15c:467b with SMTP id 5614622812f47-3ea6dd54fedmr19117882b6e.34.1733167822010;
        Mon, 02 Dec 2024 11:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIkukgHjO+xHOsTzuojG4rTdEvhgQXYtw0cqLgh/hXnZ2vhbKtciYQjgLU33Id0JQ7Mxq4cA==
X-Received: by 2002:a05:6808:1448:b0:3e7:a15c:467b with SMTP id 5614622812f47-3ea6dd54fedmr19117837b6e.34.1733167821673;
        Mon, 02 Dec 2024 11:30:21 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8860dacf2sm41169846d6.53.2024.12.02.11.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:30:21 -0800 (PST)
Message-ID: <811c6dc97accdba53470dc11483256975f091c68.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state
 disabling via libcpupower
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-rt-users@vger.kernel.org, 
	williams@redhat.com
Date: Mon, 02 Dec 2024 13:30:20 -0600
In-Reply-To: <c8bd0b4f-dc73-5c9b-a692-bcc3f9660884@redhat.com>
References: <20241113114509.1058593-1-tglozar@redhat.com>
	 <20241113114509.1058593-3-tglozar@redhat.com>
	 <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com>
	 <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
	 <c8bd0b4f-dc73-5c9b-a692-bcc3f9660884@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 10:47 -0500, John Kacur wrote:
>=20
> On Tue, 26 Nov 2024, Crystal Wood wrote:
>=20
> > On Tue, 2024-11-26 at 17:29 -0500, John Kacur wrote:
> >=20
> > > I don't think we want to have a warning when the software is doing wh=
at we=20
> > > request of it.
> > > Can we either just move the logic out of this function into main and
> > > call either set_latency_target or the deepest latency state logic as=
=20
> > > appropriate, or move all the power management logic into a new functi=
on?
> >=20
> > This could be said about the laptop and power_management checks too...
>=20
> true
>=20
> > I'd go with verbose info prints rather than warnings for all three, if
> > anything.
>=20
> Note that verbose on cyclictest doesn't mean print extra warnings, it=20
> means output values on stdout for statistics.

That's what the help says, but it's already used to gate other things
that don't seem to be related, at least at first glance...

>=20
> >=20
> > I'm not sure how cluttering up main() with more logic would help, but
> > turning set_latency_target() into something like
> > setup_power()/cleanup_power() sounds good.
> >=20
> =20
>=20
> Sure, that's why I gave two options, however, there is already=20
> --deepest-idle-state logic in main(), how much more clutter does it add t=
o
> not call set_latency_target() if we're using --deepest-idle-state?

I meant moving the deepest idle stuff out of main() and into
setup_power()/cleanup_power().  In other words, I was agreeing with your
second option.

-Crystal

