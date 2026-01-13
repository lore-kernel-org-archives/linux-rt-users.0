Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDE20F08C
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768347712; cv=none; b=ajJA8w1GGCiqVNcLrUPainSwDXxC/BsTi3nEknr4THbKJbjrlyCe//BFkMSlSVGXKKlC50n6TrzEKi9tbAEP8qzOhF5nExVJc/o/eiP5Dv0m19eYVTCeZ5A1GrAncioT3K4DquyBefypSUuX8Qj53TAIGIr5Pv1FHHBvZTGEupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768347712; c=relaxed/simple;
	bh=5AFCYy7Hfjzva6YsHIhdY9TvSCOI0WvtFTwCBkPUN3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IxhnohWPaChwshWruag067c5k+kcxThTy5zWNy4O9Q5ACEXb6VY5Pzdq+0kQ6HrSQWEaBX6NCpeeQGYynEOonOzJD+CXWCK463MwrU4lLGqa6Ei/phCy9KXhO0bIxDfeHK76aZC9TVwZOLwJwYXSofMQ/pX5xAvz4G7yk+xzMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=day2rCWR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p4qP5SO5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="day2rCWR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p4qP5SO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768347709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KrBPTSdu1KXmhRzTVv8zGv7Vn5NU3zHg93wQtKi2tI=;
	b=day2rCWR3trQgu5v4ArEafq1RJ1GoueDUyIvitHx4LRInEmY8GYFqM8HHwH251SrXUoDI4
	wVJJQu2GcqhR/Bw/s1sD1LuxJVC04lmKiYnV9WxZZXmN9WUhLBJ5z8BScOiIv2yV9mudhq
	h55+0PBmkgBpBjTtiuA1BGD2CjShytg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-keNDriC4MT23OCIT5JpHyw-1; Tue, 13 Jan 2026 18:41:46 -0500
X-MC-Unique: keNDriC4MT23OCIT5JpHyw-1
X-Mimecast-MFC-AGG-ID: keNDriC4MT23OCIT5JpHyw_1768347706
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-888825e6423so156619476d6.3
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 15:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768347706; x=1768952506; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7KrBPTSdu1KXmhRzTVv8zGv7Vn5NU3zHg93wQtKi2tI=;
        b=p4qP5SO52QNXgEjtaWxPbEztZamPDI7PGBbw7VRcgkTo4B0S5djbbQHoCqq0S+iTUn
         xrJAGS4mFLRBTljQwutsKGHsbNf1G60ChN3Qc2DWyfa98ZHBNkJAW2/R/YlhvfSJiD7L
         b9O/z3pyuuXV4ujECB/nwD+Rfuuo7MEZLuDkJJUJvkivmFA8DnHeQaAgtOWoRsaCvr84
         +KQrIvSxC7B5E6jE3/l5UR1paLdvzMcwb3Z3RH4miD6Y7OGzKt9TsGRQZBF0DmmTMKPU
         pBWaKPmkOamePmWkBqYjC7cazSDfLSXotG+abXPrhQyHXm0AUacIaUbqbc5sJ/DfmRxj
         ar3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768347706; x=1768952506;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KrBPTSdu1KXmhRzTVv8zGv7Vn5NU3zHg93wQtKi2tI=;
        b=TQGvmqpE7oxFTBBD1Y2/DgkYF5vBoL43pSQrK6VW5oSGzyqmwzRFQbCLMclAUNtGe5
         Ovbhm1/RNHCTSRuv7eYpS4LPPnb0x5cRqtP2cMP/er9ARivm/7y48BPfLIQ9q6sVfOB/
         XyC8+WO/JwJFlokZXWVOBg8lx+N4dE73/DT+VNes24Yq499k2LEhP55DlSH+N1kKXSta
         BgretiMqz3f6o5CkWZux1z+hrSIJq4HxiD51c1lU2gqftMjZl5254FHtXgh55zzVMZDy
         8f6hk2wVpmv91ispucfvgzHaVphmJ9XyHy0A/ogzi3201vxw5nmveyMJ7zD2ciJat/Dy
         TSoA==
X-Gm-Message-State: AOJu0YwB58q9Y72U4aeeOrbylfcgFgrHtBvM3SsIGH4WQguX/G7Lfky4
	vk6vP+/UUl0Hb5vnANsAbouAESca0yiDEFXWlA3QpTaHZKZmmSraBdCRn9aLsFG0wQSLpnHpoQr
	EYdjBeqYHB0f7UJsPeyYTSJMc38V88u49IpU+q0FTc3i9XMK09PVzr0VitH9afZD5QrxW
X-Gm-Gg: AY/fxX5x1Pys13vY+DQ+BwsoDs5luQ5a8kOl58IS3zl/T5d8uR7j14A50KeHImFKOCn
	qcZS5j0DVjA/aVHSbv1VGLraFwNWO58qMkFJQd3L45AG9RgR7rXv19M1wLvYmKrjv4mOBJKXpf/
	TQMmk0oeLoyRyltIcuhd7UEwBpp3ASPVrW13Tt3eon1HwKVx8mT9urLA3DSmYVpl3F2I1n4lmBR
	Yo8kpRf+nfSzDk234tNzv5UdvfnxS6wYAtqTzkM5vYxzyhX8gKZed23h+KM2LiY8QgZwoIMYfZG
	8RGx+JQDkDO4um9MQtJkvyV3HRmOrKrtf8R7n1gAmITAhM52OKv4Emi8Qzyj1H4qoCmhVQ/Al/U
	/4sGCa65/42kA1qrB1LwOsoaiO5ojPoWczb1l1Dm5CA==
X-Received: by 2002:a05:6214:f62:b0:882:4660:3724 with SMTP id 6a1803df08f44-89275c6bf15mr1031626d6.63.1768347705847;
        Tue, 13 Jan 2026 15:41:45 -0800 (PST)
X-Received: by 2002:a05:6214:f62:b0:882:4660:3724 with SMTP id 6a1803df08f44-89275c6bf15mr1031456d6.63.1768347705404;
        Tue, 13 Jan 2026 15:41:45 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e202esm163021016d6.14.2026.01.13.15.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 15:41:45 -0800 (PST)
Message-ID: <8522afe144e1abec56404ba84923662786228eef.camel@redhat.com>
Subject: Re: [PATCH v1] cyclictest: Generate optstring dynamically from
 long_options
From: Crystal Wood <crwood@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Costa Shulyupin
	 <costa.shul@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, John Kacur
	 <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Date: Tue, 13 Jan 2026 17:41:43 -0600
In-Reply-To: <20260113111449.ULgrZN6N@linutronix.de>
References: <20260110113738.2376456-1-costa.shul@redhat.com>
	 <e64e7188a920634fce126fc71ccc09696984f42f.camel@redhat.com>
	 <20260113081300.s3s115wU@linutronix.de>
	 <CADDUTFxQHSP1VWqEG1ksL7sOoTOKkjXmz=JP3_HPWajz07GjoA@mail.gmail.com>
	 <20260113111449.ULgrZN6N@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-13 at 12:14 +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-13 12:00:29 [+0200], Costa Shulyupin wrote:
> > On Tue, 13 Jan 2026 at 10:13, Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > > GNU ARGP might be easier to parse and maintain in the long run
> > > especially if 20 other options are added.
> > >         https://www.gnu.org/software/libc/manual/html_node/Argp-Examp=
le-4.html
> >=20
> > It looks impossible to port to ARGP without CLI change: cyclictest has
> > options with optional arguments (e.g., -a can mean 'use all CPUs' or
> > -a 0,2,4 means 'use specific CPUs'). ARGP handles these differently
> > than getopt_long.
>=20
> I see. It looked nice and I assumed it supports the same features. But
> if optional arguments to options are not supported then it is probably
> not doable.

It does support optional arguments (OPTION_ARG_OPTIONAL) but
rtla/cyclictest use nonstandard syntax: "-a foo" rather than "-afoo" or
"--arg=3Dfoo".  We get away with this because there's no mixing of
argument and non-argument options to create ambiguity, and it's not
worth changing at this point.

-Crystal

