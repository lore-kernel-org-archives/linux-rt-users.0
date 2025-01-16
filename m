Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CFD1CB9EA
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Jan 2025 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737009930; cv=none; b=ONi4FZm5mTLQKFY28s2PEBu9NSkwA0hf8nG0xJKITQ42iZCJ9BAO2yfDkPGn4l/1dQRORHerJi+xDsf799dhrorKh9h4KTrmqdsjfB9kn4amhq2LvbuCu0OvBUetqKpf7AsYy39L1pk6CEOf9mwlOVX0sioMNwkiAgl3f/KqDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737009930; c=relaxed/simple;
	bh=A4LKWm/rjQP96EW02OzrZ6ZuPZRXiCQfdy4vEY0ZD68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXDccktN6QNyrnfhJh6z12Iakb8BhWWETbe1/5XLw7ua7jrvkz0PiV6fIlaAyqqkp/IONHPvjlDxARWeEQCPqZI+5jnMGAsCCpRQtFhuEIjyMa4rVCU4gblYbjJGD8aDSMRcmqzKa/ladkmUguV9v9jvD4lc4PQJ9Q+SldRBiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrHr3Q66; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrHr3Q66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737009921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A4LKWm/rjQP96EW02OzrZ6ZuPZRXiCQfdy4vEY0ZD68=;
	b=CrHr3Q66h1vknlqQj0IGdq6GCY9LdoPO4aVEygFDPyJphbIgi479iSN73k+FfMbxsnH7LL
	2+H3V6h/EG5JOB69fIiDH1WWLbX3ymW4zRxB9PebJiQwJa27Jdg7MfCHmbNHTxIyakAYMS
	qywoBRCigPcae2WtftUFVrJG33cWbts=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-TZQOSYviPcCLSX9VDuRR4A-1; Thu, 16 Jan 2025 01:45:19 -0500
X-MC-Unique: TZQOSYviPcCLSX9VDuRR4A-1
X-Mimecast-MFC-AGG-ID: TZQOSYviPcCLSX9VDuRR4A
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so3094785e9.3
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Jan 2025 22:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737009918; x=1737614718;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4LKWm/rjQP96EW02OzrZ6ZuPZRXiCQfdy4vEY0ZD68=;
        b=jN3yoEN8md+v+TQR7MjgLfR0+cBNgS/e/Zgb/R55dO/hTGb3ZRZn1YCm9xLb+BNRpR
         EGupp2dIfAr9qzb4DDbMXKY4HdxjCSv/PlU3sY83+IcYKFdj02TWumah34sFEePf4w0N
         977zChOAG2df4oook0dfrdycqlNg5PSQ5UzLQc7PbAYNt2C+GRzPqHBFLVOBbOP3ueC4
         gZj92XznZi1b859t46pO1Goo8GQOs0F2YEoerilAYly1u/XR9aS8ByMo7LTPC+ne8ndw
         WQkThDrelcI/wFcdf6KiyYFZT7E6zOMDZih+D05JgXf/9eUdl35cazzhg+buOQlmJbCy
         D16A==
X-Forwarded-Encrypted: i=1; AJvYcCVC1OUxcfC6/T3gcp8YG1WJ8hoeaFtf4lZRBlG1IAzahbgHAgixQBWKjJYI391I57qyAKIpALo+JqHBp2mBBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/nyYxwUsYMeIR1Ny/wAIbIgbIa4PPLC+NqZSzl6DPeSQ2WLv
	Je3GEN1KRxOwOs8OrztI0OdghgD8f0IM2tqQ1JiMaGtlCiUWq8TXOsz2UdOaYrWHjA5yfe5iE4c
	hEY7a0OLpn8MT0fX1SC2cEURHsf4j0bM/gQRjqh6VZbtnbNFRsJkuub0xTRZAaT9GBvUoQBY7SM
	A=
X-Gm-Gg: ASbGnctLVdjxvuIC/1gpLN/flMiyFq93y6gEQ6wNLbAMW4RpkMQXlHvaut3POg8YxIc
	Nbgu0es/blxl4qYyb4Lv7Y77bBa4DZvY/WCCsQYBzZ9vEpytte5k+iK5k8LIw4vEG9fbUg8f2ws
	v5VBh4vGN4G1pfS8+cIUHa9D3BIIFho9ZXtTaZ3KhwQm3pRGC6MXJGdY36FUpp12gLt5QrKrzY4
	LGQ1oJ2DtW1QOXaRt+XCCniBqjsuNXdNtGiE9zFFnL7d3p1duoWMV5DsYWD7/+fGiIZuoldlL4q
	DzW3xOs=
X-Received: by 2002:a05:600c:1d9e:b0:436:8a6f:b6db with SMTP id 5b1f17b1804b1-436e2707c41mr257649185e9.22.1737009918087;
        Wed, 15 Jan 2025 22:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxaZBPQH0qwfgXZr9nNMF4nI4E2uwCAM3H450VkG35I2UBFgfHP3XUlChaxvvKyP3WUWEQUA==
X-Received: by 2002:a05:600c:1d9e:b0:436:8a6f:b6db with SMTP id 5b1f17b1804b1-436e2707c41mr257649045e9.22.1737009917735;
        Wed, 15 Jan 2025 22:45:17 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bec32b96dsm1104101f8f.21.2025.01.15.22.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 22:45:16 -0800 (PST)
Message-ID: <01904166f9337db39745149e53ef0d410c2cbcef.camel@redhat.com>
Subject: Re: [PATCH] rteval: Allow configuration from stdin
From: Gabriele Monaco <gmonaco@redhat.com>
To: Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 	linux-rt-users@vger.kernel.org
Date: Thu, 16 Jan 2025 07:45:14 +0100
In-Reply-To: <b16d675a16d3592e14af07a58954f4eb9de991e4.camel@redhat.com>
References: <20250113121856.225406-1-gmonaco@redhat.com>
		 <8d23151f-af7c-1b75-eae9-c8d88fa1ec3d@redhat.com>
		 <7323d02c15095c659749147c3d2e9d4b777df2a2.camel@redhat.com>
		 <8abfe0115fc4e7824f9d92743d9d41b5dbbdb50a.camel@redhat.com>
		 <a37f794b-fb11-417f-3131-f0d61c8e077d@redhat.com>
	 <b16d675a16d3592e14af07a58954f4eb9de991e4.camel@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Wed, 2025-01-15 at 20:14 -0500, Crystal Wood wrote:
> On Tue, 2025-01-14 at 18:07 -0500, John Kacur wrote:
> >=20
> > On Tue, 14 Jan 2025, Crystal Wood wrote:
> >=20
> > > On Tue, 2025-01-14 at 07:40 +0100, Gabriele Monaco wrote:
> > > > I could start drafting a patch for the CLI options to specify
> > > > modules
> > > > if they look alright to you.
> > > >=20
> > > > Another not too different option could be kinda like stress-ng,
> > > > specifying the modules just like --cyclictest , --timerlat , --
> > > > hackbench , etc.
> > >=20
> > > It fits the pattern of module-specific parameters, so I kind of
> > > like it
> > > from an interface perspective. =C2=A0Implementation wise, though,
> > > something
> > > like
> > > --load-modules=3D'cyclictest,sysstat' or --load cyclictest --load
> > > sysstat
> > > might be easier (interface wise, I prefer the latter).
> > >=20
> >=20
> > Note that cyclictest and timerlat in rteval jargon are measurement
> > modules
>=20
> Sorry, brain fart... s/load/measurement/ (I'd prefer just "measure"
> but
> I guess we want to be consistent with stuff like --measurement-
> cpulist)
>=20
> > The current way that load modules work is that most are implicitly=20
> > implied.=C2=A0
> >=20
>=20
> They're explicitly enabled in the default config file...
>=20
> > stress-ng is not among the default implicitly implied load=20
> > modules, but if you choose stressng-option then it sets itself as
> > an exclusive load module and turns off the others. If a person
> > tries to=20
> > run with a stressng-option and an option for an other load module,
> > it is=20
> > an error condition.
> >=20
> > It is possible to run both the cyclictest and timerlat measurement
> > modules=20
> > without using any specific cyclictest or timerlat options. (so that
> > doesn't work as a way to differentiate)
>=20
> I don't think implicit enablement based on module-specific options is
> a
> good model to emulate, regardless.
>=20
> >=20
> > There are some measurement module options that will apply to either
> > one.
> > For example=20
> > --measurement-cpulist CPULIST
> >=20
> > will run measurement modules on the CPULIST whether that be
> > cyclictest or=20
> > timerlat.
> >=20
> > I think the simplest thing to do would be to implement these two
> > options=20
> > without parameters.
> > --cyclictest
> > --timerlat
>=20
> If you mean special casing these two modules rather than having a
> general mechanism for enabling modules, I'm not a huge fan of that...
> though it might be preferable to overengineering something.
>=20
> What about sysstat?
>=20
> And how would we specify a module to disable?=C2=A0 If timerlat is the
> default (currently this is only the case if the measurement section
> of
> the config file is missing), and the user enables cyclictest, do we
> hardcode that that disables timerlat?=C2=A0 Or have a way to prefer
> command-
> line-specified modules over conflicting default modules?
>=20
> >=20
> > Now, you wouldn't HAVE to use them, currently timerlat is the
> > default, so=20
> > if you don't specify, then it would use the default.
> >=20
> > Like with stress-ng and the load modules, if a person tried to use
> > a=20
> > cyclictest and a timerlat option at the sametime, it should create
> > an=20
> > error and exit.
> >=20
> > I like the above idea, because other than the optional option of=20
> > --cyclictest and --timerlat, nothing else changes, so it wouldn't
> > break=20
> > anybody's scripts in any kind of major way.
>=20
> None of these proposals should break existing scripts, assuming we
> don't
> change the defaults.=C2=A0 Removing config file support, OTOH, would forc=
e
> people still using cyclictest to start specifying it on the command
> line
> one way or another.

Strictly speaking, enabling timerlat as the default measurement module
did break existing scripts, that's what brought me to start this patch
in the first place.

I agree that we should try to keep the same behaviour with respect to
default values, no measurement module specified via command line should
be the same as no measurement section in the config files, as
specifying only one should disable the other. Specifying both should be
allowed.

I see the command line as another setup that should override the config
file, while behaving exactly the same (where the notation --
measurement-modules would indeed be a bit more familiar, but I still
like --cyclictest/--timerlat).

The order could be: command-line > explicit config file (-f) > default
config file (/etc) > default values, this wouldn't affect the behaviour
much.

I only see the behaviour with stress-ng a bit strange, is it really not
a thing to run it in conjunction with hackbench and kcompile?

I see the simplest thing for now is to start with command-line options
for measurement only. After we consolidate that, we can do the same for
loads (with or without special cases).

Thoughts?

Gabriele

