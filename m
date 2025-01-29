Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E923DDCD
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738194004; cv=none; b=Ngr+T8W9AfQDRSgfCSmwOvbq9h7jr6+KosOxLulAEA8IkvFEaUasOVC9tDNSR3+o8nyYfrOsaf8EIjlZsy+uliJDVTQ/dQ+JMm94HlRTTul9he624J0amfB8iyo25Q1NIsZlsaQtOF+YdHRJEN1ky85055b6/SGRZJiU2sQcs7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738194004; c=relaxed/simple;
	bh=2FHmpZJW8jtm/Lq+iry6P12MhgqoSz7mBcO6cl0El10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orprWf6wV9HEmB4a68Bw4Te7pvSwCYuBK/ZrdNVc86USY9uyCJhJMPNr+IR27L8F/n53+I7XbnQWevzj0XFxTU85NthFClUaRBWGc+pyeNQGXlpUaMeMLCfcSRRG6ijnL1xPkHFmrCYdYLALIorLHINJmK5MnjL5NKnoxBRrDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U12gGm6w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U12gGm6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738194001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfWXbbgQpmiGOgrcBaPYwh8P0j0Bw2aDxOQCUrdkdaI=;
	b=U12gGm6wNKvdkNdnMhmpOW5AAMmXh6XFj92LPRc75aSQCKrYcZTlmWZ+LuIBtG/v+fTrn5
	Nq0ZruCDEvFxjbbyXo3aZdBteurE2L8Rg22yPZSWutJJ4zrRO9dnCKezaYhEjFW4zMYVMh
	XhFHtCn0/DnOnLGzOJQ394Am148FT1Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ZxhqHB9aMGGJ_BztiOKdgQ-1; Wed, 29 Jan 2025 18:39:59 -0500
X-MC-Unique: ZxhqHB9aMGGJ_BztiOKdgQ-1
X-Mimecast-MFC-AGG-ID: ZxhqHB9aMGGJ_BztiOKdgQ
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6c51069f5so48346185a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 15:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738193999; x=1738798799;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfWXbbgQpmiGOgrcBaPYwh8P0j0Bw2aDxOQCUrdkdaI=;
        b=cFi59og1HZoi0yH5nKOBf/osM+47UsOVXJTObA15LALCgiBO88KTtTG6SCFpqK8iP7
         ONI3F1SmelCJMLVt/tzNO+iLvc4vWNGx76s0mbZB1mnc4v4rRD2VUSaEXQG0YHAIoqhl
         FXJy/2y2yPo7GujP8mGxxDedmxmhvnd9BsLjItIbbZD7QR05KAre+50MTkWYs7um/VRK
         Kzz+kXAvf7zERF0MwgeH3KFgvAVxqomQ5r3NmNPhQXaUPKhJ+33KQj2ZBrZM0p0F7UtL
         6XX8gyK+9y3hRvQ/Zg3vQKeCpqAhXRaU0R5IWYmymNZ6a9gKSqVvNJR3At3lIkPseRJr
         tkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxrVGruzVmAi5/kjOZWh3O0d4nFsORNadI4NHceUwQjLUEzEJ/Un9poyPUHxtRWVxDGqkNL2Z9elooB/iLNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpkWh06Y5BHxX/H0yIW9YA0GhDciz6P7TaX/fTsEr0PBk7pnn
	Miez1uANYcpXaJ8FIURW67z/RklPLGTLhTyPGeOefYik91bulin2SaKk60tI4U8Q0jnpVJoKrb0
	1EWtd+HUk9pR6h0iuQvRbTVCodreqj7DRChfAKI+KZCoAaYwn/zYtfNOlZNrLGGiV
X-Gm-Gg: ASbGncvDmG1uYn5LZPl+poNbmLs3LcXgx9c3ewG9S2CfGM1xWYdnSjb1080KsI08Xnl
	orVuc6425FJzDKBAS0Wz3yW0hc8cxUzoxb5rRA9qLeiL3chIQxuKx31m8UMdZJUqPUtZIhFGh5f
	MD2LW0eYrMFYH6B1zVWT7hQGVYAiDqpajWi5jGcbc/H7yAXX+wAd67bZK1TuDmjJBuGjpXIm0R8
	1ui7IN7NeyKmF5MhrOXZv7pirhMneWmXOnzOsMTSU7/gdCphj2dvCcV5V/SzTmTjnUDYkTis/0X
	NB/YNDaPX4GRnYgENEVrdGqqxWN94cKtHmfl
X-Received: by 2002:a05:620a:6798:b0:7b1:880c:5805 with SMTP id af79cd13be357-7bffcda59c3mr686856285a.45.1738193999324;
        Wed, 29 Jan 2025 15:39:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTuvrji9heZH5PRWrSoQRN0rFI8mMJBxtoSCG/kuvwY7o6a/Rcp/+6MlKsGj2FvCa8i/x5lA==
X-Received: by 2002:a05:620a:6798:b0:7b1:880c:5805 with SMTP id af79cd13be357-7bffcda59c3mr686853885a.45.1738193998934;
        Wed, 29 Jan 2025 15:39:58 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d9512sm16068085a.59.2025.01.29.15.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 15:39:58 -0800 (PST)
Message-ID: <6041e9688de0cc0fb676ce6b20291f7afb2b96d0.camel@redhat.com>
Subject: Re: [PATCH] sched_attr: Do not define for glibc >= 2.41
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>, Khem Raj <raj.khem@gmail.com>
Cc: Clark Williams <williams@redhat.com>, rt-users
	 <linux-rt-users@vger.kernel.org>
Date: Wed, 29 Jan 2025 17:39:57 -0600
In-Reply-To: <06e5ea58-b30e-0a8b-c9e8-226e8c20d70d@redhat.com>
References: <20250128230838.2311298-1-raj.khem@gmail.com>
	 <06e5ea58-b30e-0a8b-c9e8-226e8c20d70d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-29 at 16:54 -0500, John Kacur wrote:
>=20
> On Tue, 28 Jan 2025, Khem Raj wrote:
>=20
> > glibc 2.41+ has added [1] definitions for sched_setattr and sched_getat=
tr functions
> > and struct sched_attr. Therefore, it needs to be checked for here as we=
ll before
> > defining sched_attr
> >=20
> > Define sched_attr conditionally on SCHED_ATTR_SIZE_VER0
> >=20
> > Fixes builds with glibc/trunk
> >=20
> > [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3D21571c=
a0d70302909cf72707b2a7736cf12190a0;hp=3D298bc488fdc047da37482f4003023cb9ade=
f78f8
> >=20
> > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > Cc: Clark Williams <williams@redhat.com>
> > Cc: John Kacur <jkacur@redhat.com>
> > Cc: rt-users <linux-rt-users@vger.kernel.org>
> > ---
> >  src/include/rt-sched.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
> > index 80171c7..9cf0e3a 100644
> > --- a/src/include/rt-sched.h
> > +++ b/src/include/rt-sched.h
> > @@ -42,6 +42,8 @@
> >  #define __NR_sched_getattr		275
> >  #endif
> > =20
> > +/* sched_attr is not defined in glibc < 2.41 */
> > +#ifndef SCHED_ATTR_SIZE_VER0
> >  struct sched_attr {
> >  	uint32_t size;
> >  	uint32_t sched_policy;
> > @@ -68,4 +70,6 @@ int sched_getattr(pid_t pid,
> >  		  unsigned int size,
> >  		  unsigned int flags);
> > =20
> > +#endif /* SCHED_ATTR_SIZE_VER0 */
> > +
> >  #endif /* __RT_SCHED_H__ */
> >=20
> >=20
>=20
> Does the following fix your problem?
[snip]

> +#if ! __GLIBC_PREREQ(2, 41)

I'm not familiar with the norms surrounding use of this macro, but it's
generally better to test features than versions... what if this feature
gets backported into some distro's earlier-version-numbered glibc?

FWIW, it looks like QEMU went with the feature test approach:
https://patchwork.ozlabs.org/project/qemu-devel/patch/20241011054806.101427=
6-1-raj.khem@gmail.com/
https://patchwork.ozlabs.org/project/qemu-devel/patch/20241011193140.104764=
8-1-raj.khem@gmail.com/

Also, was that patch posted anywhere?  Just wondering if I've still got
problems with email filtering.

-Crystal

