Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432820898D
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884263; cv=none; b=VKdpBhGv5PxqbCSz4rNTnFn6ugKAgTdkSJ6dC4rW8WCn4XdDAjqOsHXVuNeXSVWjCIB4kOHUCROvh6Av6kOfxqPeRvmJHHVgwGHPgeHdWhbjNQ3Bh0wuD6NMXT9MrIEcZZdi5jLp5xVS5dPRaqZyKrisraBJYU4kqxLsurPcK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884263; c=relaxed/simple;
	bh=J8kuPI5Xj7UjB9TwiE+cWXhS7J1UoS1sT3AjdMlj3zQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9nOx7vgw5R6JC0scLZyjBSGkcsNvqD17/HP1eP2rtGahwz3gBUqA6uGN6bmRRXxvgDZNN5LcRK9hL2tK+p2IAHj76v7qgDkxX1h494W3vW6YH+m/pfYSiYuukNtkLgzKqew7M1JCAB7oQD+xt+fLRyEJ8Gq6RP3UJqJch3aGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWziJJz9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWziJJz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736884260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8kuPI5Xj7UjB9TwiE+cWXhS7J1UoS1sT3AjdMlj3zQ=;
	b=fWziJJz9O+hnfrzp3sMulaKrLO7U6kJPteWx6tDARynNfkaFa4NYIDSmHPIMGCtaUVHKbY
	//5mJ7HJ7Eqr0eCb2RWZynAXvK3fws0m6XdyB6Zx4ZSsA9TTzig5sS007AhOgjHH3pdQJf
	XR2fkG/e0u9mAiN0SbeOQ/asnF5u0/4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-oUFWygMYNzq-ic6EYRxD8Q-1; Tue, 14 Jan 2025 14:50:59 -0500
X-MC-Unique: oUFWygMYNzq-ic6EYRxD8Q-1
X-Mimecast-MFC-AGG-ID: oUFWygMYNzq-ic6EYRxD8Q
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f94518c9so124047276d6.1
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Jan 2025 11:50:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736884258; x=1737489058;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J8kuPI5Xj7UjB9TwiE+cWXhS7J1UoS1sT3AjdMlj3zQ=;
        b=EieHowXPo0f0k9YhY+aUXW8/GkcoEd0DWPPss8ikpspeDnM/aErIELnjqVPueGRLK9
         wKjbReUb5qmT631YXvsI8Zn8COGg5sjvGGlYOnkZiONqMKU4dQ0W6xpG5vYH4AU3SIzW
         Og7T7h4kNCoBeQisCXL8sqfJtmqQGcnNT3IiRlhTn1IWyinF5pxozxmTuEpth63M2uQ9
         02knJnpJoZj4FO5GtoQxkH9mr0sE/NdxHsOoSNDAc+lzxR4wCdmqh+4SJRwpDuXwgsBr
         8nJLIwMLuyk/BtidMIA+Sy3hT8RPwsHpRuvxy90RZwsRfIJNaRZV4X1ohJb5XkmvZUNq
         JeVA==
X-Forwarded-Encrypted: i=1; AJvYcCVbKMzvNBdRloMx0aFNHgLaLHjGuPr1l4dNcdPPkkUhPZOwt2yaF2d6izu4jDhIUJ9e4sKWKa659TJVLE7EAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4NKl19bwXvyK3wJLAVzb+WzZVVZPR2WylrsMQ0KrddTMGLAs
	KkaWcyhfG47OmK0Xch2trxmtDVfn/VGdkberzed/MiZUbazLw/Kc6kguCjhHa8K3srgCPaeRzi2
	AY0oWJo8nYAqcmKRmFcSmpW/uGtfo4ncxQIipzwyFjvmg6GkTB7VaF/W7friGkAMjml0w1bAB4+
	M=
X-Gm-Gg: ASbGncuwCd9vs3FF5+DKsVGUtNIDH3QZqfsp2WYVJGlny6PY33bJFPUyq55abzppvki
	AD9dlH9E0nN2g42pFyCcH8vPGP3g/l/UZQMiqDQIxE0Rww3rHt2F3mfJw283Iz7Dwmn/x/ldCoS
	ZukuHKa/mMXZ/7mhEZkzs+Zz57wFcgBvMadm2IQ/SqVHID8iBv5/Cgbe5Gcn7V5t8Jt4RHHIm5F
	p0/AcTd5/SFTRjGKpT9/fYOVU1fJVY0t/eVUOMjpyX1UP8CV10sD/u4rVTCO2HXqGW1on+cs0Qv
	vWHCbl5E4jsC
X-Received: by 2002:a05:6214:f23:b0:6d8:7ed4:336c with SMTP id 6a1803df08f44-6df9b1f2f2bmr318428276d6.9.1736884258571;
        Tue, 14 Jan 2025 11:50:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMXC1zZR9gpfqyQ0dHdXwvbJx2mzEi1f3pTY0sblGhHyntFWJ/C+eBPmOZWGjTzkB/mJAoiw==
X-Received: by 2002:a05:6214:f23:b0:6d8:7ed4:336c with SMTP id 6a1803df08f44-6df9b1f2f2bmr318428026d6.9.1736884258267;
        Tue, 14 Jan 2025 11:50:58 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3238003sm643910785a.2.2025.01.14.11.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:50:58 -0800 (PST)
Message-ID: <8abfe0115fc4e7824f9d92743d9d41b5dbbdb50a.camel@redhat.com>
Subject: Re: [PATCH] rteval: Allow configuration from stdin
From: Crystal Wood <crwood@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
  linux-rt-users@vger.kernel.org
Date: Tue, 14 Jan 2025 14:50:56 -0500
In-Reply-To: <7323d02c15095c659749147c3d2e9d4b777df2a2.camel@redhat.com>
References: <20250113121856.225406-1-gmonaco@redhat.com>
	 <8d23151f-af7c-1b75-eae9-c8d88fa1ec3d@redhat.com>
	 <7323d02c15095c659749147c3d2e9d4b777df2a2.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-14 at 07:40 +0100, Gabriele Monaco wrote:
> On Mon, 2025-01-13 at 16:34 -0500, John Kacur wrote:
> >=20
> >=20
> > On Mon, 13 Jan 2025, Gabriele Monaco wrote:
> >=20
> > > Modules can currently be set only via configuration file, if rteval
> > > is
> > > called from a script run on different systems, the only way to make
> > > sure
> > > the loaded modules are known is to provide (or generate) a
> > > configuration
> > > file and pass it via -f/--infile .
> >=20
> > The config files are almost obsolete.
> > Everything has a reasonable default, or can be set from the CMI
> > The one exception is for the measurement module.
> >=20
> > What would be useful would be a CMI interface to switch from rtla
> > timerlat
> > to cyclictest.
> >=20
>=20
> Mmh, that was actually my first idea, something like --measurement-
> modules=3Dtimerlat,cyclictest --loads-modules=3Dhackbench
> Basically behaving just like the measurement and loads sections in the
> config.
>=20
> I opted for this as it was simpler but if the config file is getting
> obsolete, I think you can just ignore the patch.

It's a simple enough patch that it might be worth taking anyway...
unless we actually do want to deprecate the config file entirely, rather
than just making sure it's not the only place where certain things can
be configured.

>=20
> I could start drafting a patch for the CLI options to specify modules
> if they look alright to you.
>=20
> Another not too different option could be kinda like stress-ng,
> specifying the modules just like --cyclictest , --timerlat , --
> hackbench , etc.

It fits the pattern of module-specific parameters, so I kind of like it
from an interface perspective. =C2=A0Implementation wise, though, something
like
--load-modules=3D'cyclictest,sysstat' or --load cyclictest --load sysstat
might be easier (interface wise, I prefer the latter).

>=20
> Both would require a bit of refactoring how we load modules.

That could be a good thing, if the new way is simpler.

-Crystal

