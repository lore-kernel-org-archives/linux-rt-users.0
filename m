Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73DC2EA
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Oct 2025 04:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760069273; cv=none; b=FQyMWxdiw8jeBRu9TLYyRckzg7nBLtragUEwGO9jCGF0+YtGTCUoW+OULKu7aa2F+fd3/LtmgpxSl1Vj8K58xyVD5qUd4pqog70UqtzIu2W8jh65bWXeiznyaMsOtkBFHRlC7yJXPBkBcYZNDt0PZM7wWRwdCSEJ3CuWMieglSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760069273; c=relaxed/simple;
	bh=Vk1SRoTJ1Nll0+nTiwmjGXUtS4RrDIFcCOs/8Iaogyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WEjhRtvH5VZIePRPM8rYee6cKafPC2zQp9g3RBgS7P9x8Nr/OswdQywlJ6zoHwdPsP0E/nKUJGH17ZwiOdV324exv77WZMX6YNnRTBLF6MbnrtwnO0T8m26/27tD4u3bRYUvbNPeg8dJdM9wAgSvX5Flxwzg1gpje0AvFw3Bkvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELeaYg4H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELeaYg4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760069270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26yVlG7fDwTWn4uxnDJB1aTKTbmDPi1iuNPcceSmeyA=;
	b=ELeaYg4H4cfejc94n5D2HwkjoGXe8zY3Cx0LssWR6rMfpAfjZPOTwDiJo1WTc6501SSQlV
	r9QLRs2NrItSUl0vYMpi1J6lI3AWyKtUSaS51xVFvezaf6AFEReHDsl6sogIQt1Pgm6H7A
	DO5MejnLbvGXuRAGRd1ADdCWW3n7PPg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-7E7D_MxsMxOgi9dhr1nU7g-1; Fri, 10 Oct 2025 00:07:48 -0400
X-MC-Unique: 7E7D_MxsMxOgi9dhr1nU7g-1
X-Mimecast-MFC-AGG-ID: 7E7D_MxsMxOgi9dhr1nU7g_1760069267
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9201572ebfbso644749939f.3
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Oct 2025 21:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760069267; x=1760674067;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26yVlG7fDwTWn4uxnDJB1aTKTbmDPi1iuNPcceSmeyA=;
        b=K452p6UB171ED+Wk0feyrVDPCdEJhAQhUgVD2AO29TNZqhcItBv+0kwkPTLtswur70
         FcNO3xLhu4v4HPvfeY7EQBjcLzoH4qewRPjm0XwugroVyVZhiDov8wLYhDn6k/aOi0U2
         9z3k6iAZftoO5JXyHrYxgrxkOrNiW10FCsR1bXBm+/pDW0lyEDkUtnP/kozH0ZaqROyU
         FpigBG1gb4eIQBFt622ATyqd/SPfvhrNcHwxcZz5vr9iiQEW1ZTF/xTj2uTvLLefHa+Y
         q/06CVPpvp8JjWxvNC3N1VhqrzjO8BImfZy5DlTt4luczTjTPSZXa+2vj96rcxgrH98L
         V5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXnwdjDtzUKI8SLsM6CPlPkACzgi29o4hbxI3RuPk+nQGFx57p7DmoONniHKh1wNJMRjM15YwoecqZ01/ZJdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfV6qawgZYWMzFKtoPoLApOZ/Aq64i475Klz/A5wM8zV8HXXRq
	tR4O3e/sgEAbKN0zWVfraWP6XvR0YTYqH0/rVNc6FbVwIGeH0x3C9z1j00hPpJRcgeh3R2l1nTN
	oT7hJxWLHJ7hGbPLqQi6gZGK8urEmHZwC9lUFvuXsE6Ehc932UbvX6IofsbQHIPF/BgG5
X-Gm-Gg: ASbGncuVQKf8HWKe7VPIAnOTesjsWz5n2oNz4dmAs1fUat53j/4u/anb9BlWoZCjDnN
	mG3YJQADTSIVfN7PspFnz8WuGTie6sp0TWt9dGUjaYztQ3WMRekRrgHUUK0atyij+Bp+aBrUUkq
	gFipbZsUVu+GeCbli7lkDJ3BqaZC+PRt8jXVCDJLvNJKc02pjeh9BnzTZmizRjfQpq2/dC3jr7d
	+O/9KqULW3iahjzfREMYkzVdXdB5K+zmuPXmtOZ1gmfjmM8PUHqat0xMMc/EcbgayGUzJXoPQrq
	5p9MkXLANHYTx9QgqF5LL+CpDBWwJ4o+NxRU5Z0nvk1Pe7zcT5Kid8UWeI4KYSoI6GI2zfFy
X-Received: by 2002:a05:6602:483:b0:8d6:87c1:27ba with SMTP id ca18e2360f4ac-93bd186b4d1mr1305768339f.7.1760069267308;
        Thu, 09 Oct 2025 21:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLeFD2oqyVh2A0P7PEOMn0kLRn5YhS8SJL/uBJ0rZJyB50YbEKujVEXpd1HrltDd1pTP+iyA==
X-Received: by 2002:a05:6602:483:b0:8d6:87c1:27ba with SMTP id ca18e2360f4ac-93bd186b4d1mr1305765939f.7.1760069266904;
        Thu, 09 Oct 2025 21:07:46 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a3cc9esm59068339f.13.2025.10.09.21.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 21:07:46 -0700 (PDT)
Message-ID: <367f7c89f0915f586a133914fe509d2913941cc4.camel@redhat.com>
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
From: Crystal Wood <crwood@redhat.com>
To: debarbos@redhat.com
Cc: clrkwllms@kernel.org, linux-rt-users@vger.kernel.org, wander@redhat.com
Date: Thu, 09 Oct 2025 23:07:45 -0500
In-Reply-To: <xlsdpirj2vodtryotfqn6weo4dly3elwctxs6xcyur2skkmmix@anxl6dmzgig3>
References: <20251002205515.1299816-1-debarbos@redhat.com>
	 <20251002205515.1299816-3-debarbos@redhat.com>
	 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
	 <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
	 <6eef31238e5c8ee18fee7dbc1cf250bd30892941.camel@redhat.com>
	 <6wtktjmptvddkeo3wibqjignaofyupiowxwsug4xp5inekvn24@qriseqkmhke6>
	 <20cee89c557ca65b99637d49508c62f8a636f846.camel@redhat.com>
	 <xlsdpirj2vodtryotfqn6weo4dly3elwctxs6xcyur2skkmmix@anxl6dmzgig3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 19:52 -0400, Derek Barbosa wrote:
> On Wed, Oct 08, 2025 at 04:38:49PM -0500, Crystal Wood wrote:
> > On Wed, 2025-10-08 at 14:41 -0400, Derek Barbosa wrote:
> >=20
> > >=20
> > > Appending c99 to the CFLAGS on the command-line a-la `CFLAGS+=3D-std=
=3Dc99`
> > > overrides the cflags entirely... so editing the CFLAGS to append -std=
=3Dc99..
> >=20
> > You're saying that if you do CFLAGS+=3D-std=3Dc99 the only thing in CFL=
AGS
> > is -std=3Dc99?  That shouldn't happen...
>=20
> Yeah...
>=20
> ```
> [root@rt-qe-06 stalld]# make USE_BPF=3D0 SOPTS=3D FCF_PROTECTION=3D CFLAG=
S+=3D-std=3Dc99

Oh, I missed "on the command-line".  If you want to make that work, the
makefile itself would have to use=C2=A0
"override CFLAGS +=3D <the normal stuff>" instead of "CFLAGS :=3D".

There's nothing to add to yet when processing the command line
variables.

-Crystal

