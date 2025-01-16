Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB99115A8
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jan 2025 01:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990081; cv=none; b=og2TVDO4Oi7IP7v7KQ1dRcQY8xehL9grFEJC3bbZRhd1R3/w4HWpy+ixUPIKoXWREjiEaXywJWbdp1K9j5NHJ2U028m88bn96kvK5OLgggrSjvERUmEa9kxyunjHhoro6gxgvYsawqUDmu8FOVUhFX9zwaWfz1OPhBanf4AJZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990081; c=relaxed/simple;
	bh=AeUQwV6Yf+hBkkTHta1OR/Jdt8SZ67ZPF23DfnDMA7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ccb0FFKABIIhq/x8MXsPjEkodFmxJ6fg1Y7w66cAJODBfMWsI4PSfIjlHJ0PGVqQ49xNrfOGOV/M1vbeTd1MLE9GI2ezxfc9X14pTf/+dzJWl1IKl6EnORzTAL1WRoBgSbJaAxfoia6pjEwFbe0RDGzugzeDtBZKK1ZjBDBlSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VB4dgHrn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB4dgHrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736990078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lEGBDt7H6TcO1ZBn4vMUhMJDwtrxLQHwwjM/T3T54o=;
	b=VB4dgHrny7mGRKUYF0KkUPcy4g81kGKH7M0sKS/3S0GwXmCVORtsJCq/0D9TI+USMg8Bf9
	845w/oEg2kMM9HB9d56NdkdYoLo3JGj6Ex1lojB+ebLTGAtmNsXdXxeL5f/uzMqyPh+Fea
	fGn1XtE7Gxw0AtbLLew1JdgTH1urX28=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-gVnQuHCJPp6siMyiynryBQ-1; Wed, 15 Jan 2025 20:14:37 -0500
X-MC-Unique: gVnQuHCJPp6siMyiynryBQ-1
X-Mimecast-MFC-AGG-ID: gVnQuHCJPp6siMyiynryBQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e19e09cc20so9561396d6.2
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jan 2025 17:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736990076; x=1737594876;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lEGBDt7H6TcO1ZBn4vMUhMJDwtrxLQHwwjM/T3T54o=;
        b=Ri2LE8AwvNFETLoop8/wR7sbWG2pUW/qTuLQNafyxPy0GjEpERyhw2QgJiG0R3z0p+
         Wjx+mY2mHqF2zTLw1K7RcyNSnruFN5kk0DX5YNCXzpKWuccaDVSMjxHqLmOIi7uR87ZR
         YpbOIEUffshz1yHe4MXJyq0LXVkHhI3hJUqMgSBWlgVo1/qKasEVbW4zLD1Qt12zTPn2
         L5fDnRqk6zI5fuIbyZKTHA2gFGcFbhvDVKHuN3kWQzpg1uAKnOGkKMmQLUYQNH1YDg1J
         rDDXKUztYpIVPA82cOdXGBSJnJI7oM5yYaq4v14/OAdbTwzzA+0cP9XF75ZznBpSU8OW
         B/3g==
X-Forwarded-Encrypted: i=1; AJvYcCUHBOcPjkJXDO0WlbjAUJ8y8YdJv3HuaWAZwfo4LdL3Xgg6Q40oO/M8R3pDeDB4kQuDVodZf9K/vhl8hhTcQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hvvafBvUfwbfXIvKI1MkMTCwpZpSfbNhSWJSMgEkyXuGTOYV
	xS+1n2Dy+QnxJ3bhOauvxguBmGgQ97yVh+iw646kBkDr3XKvcQ84VyqSbCEgNPwL5NSaA/1CNww
	sTqU33cqnKJF3gTasYvnezcQfejWWNUNkWQD91y4gLSgJ0Gqc8Uc6OiAoD12bvFOebzLRWCRbKn
	4=
X-Gm-Gg: ASbGncswyjSr1MOR6dv0nFTkh6hjyy4jCqvD3mqpAULM2IT3/MU4YNydAgUOR20Py3j
	HZsCZLe+R8DqGGFWmyUrVzYEa49BiP4XVHtItdh7fUGTTaoMplOKLGQS2fbt2Z0jlTAXO9mpat3
	5/CR6Eqn8jT8rmbu3afyoi5QN6kIJ5axO7fzcSAgguRX53KFSGqkMDXHnTWvxwTSZqTX9XVOhoL
	Wf/bzSDli3KmkKVH4FuRnkpW4WCcSsqIl7aqSTz+kQkA6qIRTYxbGmYcatbI9wM2orSirlXffe0
	lNlQ0ugnqDue
X-Received: by 2002:a05:622a:5081:b0:46c:782f:5f6c with SMTP id d75a77b69052e-46c782f610dmr397439191cf.14.1736990076503;
        Wed, 15 Jan 2025 17:14:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHUah7HXsoIReWOn+YmwL9r0YDZ6xwpSeIMHX/9JePS1556qnAtkLAPoHd+LS40/FvKs4Eqw==
X-Received: by 2002:a05:622a:5081:b0:46c:782f:5f6c with SMTP id d75a77b69052e-46c782f610dmr397438961cf.14.1736990076216;
        Wed, 15 Jan 2025 17:14:36 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873dbf21sm70303271cf.66.2025.01.15.17.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 17:14:35 -0800 (PST)
Message-ID: <b16d675a16d3592e14af07a58954f4eb9de991e4.camel@redhat.com>
Subject: Re: [PATCH] rteval: Allow configuration from stdin
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Clark Williams
 <williams@redhat.com>,  Tomas Glozar <tglozar@redhat.com>,
 linux-rt-users@vger.kernel.org
Date: Wed, 15 Jan 2025 20:14:34 -0500
In-Reply-To: <a37f794b-fb11-417f-3131-f0d61c8e077d@redhat.com>
References: <20250113121856.225406-1-gmonaco@redhat.com>
	 <8d23151f-af7c-1b75-eae9-c8d88fa1ec3d@redhat.com>
	 <7323d02c15095c659749147c3d2e9d4b777df2a2.camel@redhat.com>
	 <8abfe0115fc4e7824f9d92743d9d41b5dbbdb50a.camel@redhat.com>
	 <a37f794b-fb11-417f-3131-f0d61c8e077d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-14 at 18:07 -0500, John Kacur wrote:
>=20
> On Tue, 14 Jan 2025, Crystal Wood wrote:
>=20
> > On Tue, 2025-01-14 at 07:40 +0100, Gabriele Monaco wrote:
> > > I could start drafting a patch for the CLI options to specify modules
> > > if they look alright to you.
> > >=20
> > > Another not too different option could be kinda like stress-ng,
> > > specifying the modules just like --cyclictest , --timerlat , --
> > > hackbench , etc.
> >=20
> > It fits the pattern of module-specific parameters, so I kind of like it
> > from an interface perspective. =C2=A0Implementation wise, though, somet=
hing
> > like
> > --load-modules=3D'cyclictest,sysstat' or --load cyclictest --load sysst=
at
> > might be easier (interface wise, I prefer the latter).
> >=20
>=20
> Note that cyclictest and timerlat in rteval jargon are measurement module=
s

Sorry, brain fart... s/load/measurement/ (I'd prefer just "measure" but
I guess we want to be consistent with stuff like --measurement-cpulist)

> The current way that load modules work is that most are implicitly=20
> implied.=C2=A0
>=20

They're explicitly enabled in the default config file...

> stress-ng is not among the default implicitly implied load=20
> modules, but if you choose stressng-option then it sets itself as
> an exclusive load module and turns off the others. If a person tries to=
=20
> run with a stressng-option and an option for an other load module, it is=
=20
> an error condition.
>=20
> It is possible to run both the cyclictest and timerlat measurement module=
s=20
> without using any specific cyclictest or timerlat options. (so that=20
> doesn't work as a way to differentiate)

I don't think implicit enablement based on module-specific options is a
good model to emulate, regardless.

>=20
> There are some measurement module options that will apply to either one.
> For example=20
> --measurement-cpulist CPULIST
>=20
> will run measurement modules on the CPULIST whether that be cyclictest or=
=20
> timerlat.
>=20
> I think the simplest thing to do would be to implement these two options=
=20
> without parameters.
> --cyclictest
> --timerlat

If you mean special casing these two modules rather than having a
general mechanism for enabling modules, I'm not a huge fan of that...
though it might be preferable to overengineering something.

What about sysstat?

And how would we specify a module to disable?  If timerlat is the
default (currently this is only the case if the measurement section of
the config file is missing), and the user enables cyclictest, do we
hardcode that that disables timerlat?  Or have a way to prefer command-
line-specified modules over conflicting default modules?

>=20
> Now, you wouldn't HAVE to use them, currently timerlat is the default, so=
=20
> if you don't specify, then it would use the default.
>=20
> Like with stress-ng and the load modules, if a person tried to use a=20
> cyclictest and a timerlat option at the sametime, it should create an=20
> error and exit.
>=20
> I like the above idea, because other than the optional option of=20
> --cyclictest and --timerlat, nothing else changes, so it wouldn't break=
=20
> anybody's scripts in any kind of major way.

None of these proposals should break existing scripts, assuming we don't
change the defaults.  Removing config file support, OTOH, would force
people still using cyclictest to start specifying it on the command line
one way or another.


-Crystal

