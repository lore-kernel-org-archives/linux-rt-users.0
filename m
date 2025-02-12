Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A33201258
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Feb 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393631; cv=none; b=bX09oAvVhwxCMNB83kShSKKVH5a9doUWUDrN990W12XsSTtLYNU4v2pBBBgXpBz9p0Pm6BI66kTU6lFVkTcDvybri6EvGuA0kyqFQgEz2V0q/t3yCp6aJ+NN4lMl4ajL4zXajlGxpotNjLMUaMPC/h3OJqMw/HiPqvc+aMqLleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393631; c=relaxed/simple;
	bh=CgsvVpmlJ1PRj1eVRUC4IormDhc36iyXO54A0vVXNb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HDV5IHiklrS1BBoeeReyLQS5i/KZ+EJRBinLgvb23P62Nd2/8rhhJwQUVEACPX2A4k3F703wQVbX75BGr1rFmNtn7SqXgcw/gxIqU9QWfiZZkZHlANE4udhCMb5+c2+5TO5VHzTf0aBsqCPcg8aqOVGDqa4YFRs779vkCDoYT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rhm14Eut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rhm14Eut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739393627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RywR3diu5cuuGvggQxT6Ul5m0vV3Z+hTijiZ9UpSpBg=;
	b=Rhm14EutNSfI2i3Z64hhpkgtYXZkufv/toK2aTl/jgowWskMVIuk5f405tyrgizW0qyOiQ
	x/to+18p3NOqgECPAWdvq7+RuNXhnaR/xg5/TtJuGr0chnxEqGQ+43SfKM31BsfM5JO9xf
	V8vvyDnnomXMfE6p3pTblVoYwlbSFbs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-gq1s0I4bN8SYpmQR-6tSXg-1; Wed, 12 Feb 2025 15:53:38 -0500
X-MC-Unique: gq1s0I4bN8SYpmQR-6tSXg-1
X-Mimecast-MFC-AGG-ID: gq1s0I4bN8SYpmQR-6tSXg
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-726fecab32dso108140a34.0
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Feb 2025 12:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739393617; x=1739998417;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RywR3diu5cuuGvggQxT6Ul5m0vV3Z+hTijiZ9UpSpBg=;
        b=dy6G2yB/B/7k6eumNlH5Ed0qa390YtgMq8NxEf5HuxIW5gAeJ1xpdV7YX66N3VBDUw
         HiEBzlUWLRKGPgq+O6o+pw4udnX3VIqXKDUFyKPmMLJ6TrRSqU6hG660Jq7VnDT25vO+
         N3/NTkjFyt8S6jFIKFDHBsgafbPKFJgzHGaklZJiGrH3RMY7jRNtIi0UI6JI2Ql9GTdx
         j+gkDc1SjIQQ0eACD3ZPYKtfvAPrIcPXgxNKbapEFnx1as7+X+XU+zAn886oSVfXKMM/
         07YvqsqkzfmrDSUL9CAv9c0GlfHqT10a9wZXMzMgIrAUpEarc5cwHBOnFHsRAiTKLjGB
         bnig==
X-Forwarded-Encrypted: i=1; AJvYcCWMKDLyyI1oynCagFn1auHaXRtIj9gcxW+6ercLgLs7AoORFHb7qcv6C5TKgaUgF2UXAhBAn8lmU6qtFkjDjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8BFIYcADNsrDgKYszUnBMSxQpsjrTpdj0ZeQVLKCjdY+2cb0X
	qq3aZQQrvkdREjxS3gkRcdoqqEmDEJM0ZjLLkVqdFsrPETCnc/IKlxMCUouZFJONW+Y+nsX8xR2
	mmWCRRqrbrP4TBLiZkBFatHyUthf/aGw4sWS1LSnDJeK+ZNcfrxUQIRbLx6FA4StE
X-Gm-Gg: ASbGncscDUZBOrIkxhYyDiy4hLxmYA6fG+yK/CWMZDhx3brJzEayM/F5YkFW3cRhtp0
	3OAWGe7pg5knq9h9MHuxBwHkcBcL3/AlxSU4Fi8TDj5iBarcQ1lDxgob4RtpL5HSTU3+e1dcEZx
	4vPNuE93NRfFinj2y+Bx+pS8dLO1Q4eVOUS6ED3OEtm2BfaNCEGKgd5TBOKhFLcM3/1vaZfwbON
	i4u0xeKlpR2d/ZKur+JG8DrGFPmyv5LFnzGjHBNM4Lk31GiUsYftHCR4IXHmYrH5j36AuX/wzFc
	x3Cqr023TfGFcla0XQocp2Qo943hJ+ICqQ==
X-Received: by 2002:a05:6830:1312:b0:726:c9f5:750b with SMTP id 46e09a7af769-726fee9a36emr273492a34.7.1739393617295;
        Wed, 12 Feb 2025 12:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBuHhSb1JgYK2MxPJzAOm6ul6RuXXBwBhoSsdzf1ylkg9IpU8QBemfcnn/qdZ+mI+x00gqnA==
X-Received: by 2002:a05:6830:1312:b0:726:c9f5:750b with SMTP id 46e09a7af769-726fee9a36emr273485a34.7.1739393616882;
        Wed, 12 Feb 2025 12:53:36 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726eb48ef12sm2147948a34.24.2025.02.12.12.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:53:36 -0800 (PST)
Message-ID: <50cda06eaa30769ebb2c3130fce5394f1d8bd9ad.camel@redhat.com>
Subject: Re: [PATCH 0/2] Add cpupower idle-state functionality
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>, "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
 kernel-rts-sst <kernel-rts-sst@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>
Date: Wed, 12 Feb 2025 14:53:35 -0600
In-Reply-To: <21714eaf-d3d8-81bd-cc27-7a8aeb0bf971@redhat.com>
References: <20250128014551.15058-1-jwyatt@redhat.com>
	 <21714eaf-d3d8-81bd-cc27-7a8aeb0bf971@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 14:50 -0500, John Kacur wrote:
>=20
> On Mon, 27 Jan 2025, John B. Wyatt IV wrote:
>=20
> > This patch series adds idle-state functionality to control cpu power
> > usage and to test idle states.
> >=20
> > The number of cpus was needed in the cpupower file; I extracted out the
> > previously local to tuna-cli.py functionality to a separate file so the
> > cpu code can be used in any file in Tuna and reduce duplications. The
> > nics code was similar so it was also extracted to reduce the number of
> > global variables.
> >=20
> > Sincerely,
> > John Wyatt
> > Software Engineer, Core Kernel
> > Red Hat
> >=20
> > John B. Wyatt IV (2):
> >   tuna: extract cpu and nics determination code into a utils.py file
> >   tuna: Add idle-state control functionality
> >=20
> >  tuna-cmd.py      |  67 +++++++++-------
> >  tuna/cpupower.py | 202 +++++++++++++++++++++++++++++++++++++++++++++++
> >  tuna/utils.py    |  27 +++++++
> >  3 files changed, 267 insertions(+), 29 deletions(-)
> >  create mode 100755 tuna/cpupower.py
> >  create mode 100644 tuna/utils.py
> >=20
> > --=20
> > 2.48.1
> >=20
> >=20
> >=20
> ./tuna-cmd.py idle-set -h
> usage: tuna-cmd.py idle-set [-h] [-c CPU-LIST]
>                             (-s IDLESTATEDISABLEDSTATUS | -i | -d=20
> IDLESTATEINDEX | -e IDLESTATEINDEX)
>=20
> Query and set all idle states on a given CPU list. Requires libcpupower t=
o=20
> be
> installed
>=20
> options:
>   -h, --help            show this help message and exit
>   -c CPU-LIST, --cpus CPU-LIST
>                         CPU-LIST affected by commands
>   -s IDLESTATEDISABLEDSTATUS, --status IDLESTATEDISABLEDSTATUS
>                         Print if cpu idle state of the cpus in CPU-LIST i=
s
>                         enabled or disabled. If CPU-LIST is not specified=
,
>                         default to all cpus.
>   -i, --idle-info       Print general idle information on cpus in=20
> CPU-LIST. If
>                         CPU-LIST is not specified, default to all cpus.
>   -d IDLESTATEINDEX, --disable IDLESTATEINDEX
>                         Disable cpus in CPU-LIST's cpu idle (cpu sleep=
=20
> state).
>                         If CPU-LIST is not specified, default to all cpus=
.
>   -e IDLESTATEINDEX, --enable IDLESTATEINDEX
>                         Enable cpus in CPU-LIST's cpu idle (cpu sleep=20
> state).
>                         If CPU-LIST is not specified, default to all cpus=
.
>=20
> These names are kind of awkward, isn't IDLESTATE good enough, why=20
> IDLESTATEINDEX?
>=20
> For the -s option, why do we need to put the IDLESTATEDISABLEDSTATUS, if=
=20
> we omit that can't we just get a result like running "cpupower idle-info"=
?
> Could you rename IDLESTATEDISABLEDSTATUS to just IDLESTATE_STATUS?

This was confusing to me too, but it looks like the argument is actually
a particular idle state, not the status of that state.  So it should be
"IDLESTATE" just like -d and -e.  Or better, "IDLE-STATE" like "CPU-
LIST".

-Crystal

