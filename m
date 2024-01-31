Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99F39AD7
	for <linux-rt-users@vger.kernel.org>; Wed, 31 Jan 2024 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738249; cv=none; b=sgm40GYZujgRQ1iMyJvVHOnwHeY9M/j/MqXVzpeyn5u2VRRdq91dhUV7L8kmPOT8vEjCDcX4VMHGplK5BnYfERkzn6B5kECqrB716eRM6rQnib/AR4/c9rjym4ElKCiowcLlRcYynvkgr2+t1NPjBmZQjXaURZ/WNVD5jXHNYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738249; c=relaxed/simple;
	bh=gC0lXf7I3SZcZiIxOmuaTz2uCZpWqFRp2MIZZXqsmkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hu9S0DhcAK95GEM53Fj1PcFaNZjXchIHqZmrG9qjXtvuMQPpr0wY1+QwEWFEn7yMxaRbsrCPdK/ei7ja98yuAH2GpOJ8egVeRHbXgRv9VnQm4Ar8pdAI2HRrGc3sBeqMaJMcNuqcA2dq03ABefTVmZY3DoWqQjmyxNkn9K/9/48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JM+Ir2Z6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JM+Ir2Z6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706738246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5fW+pR0Od9wClLuo3WHp1P1SzDvmkG9A4Voix2JXDE=;
	b=JM+Ir2Z6AOaEoqGxEbFGg83ZA4BXShwV0otK3apdF7VPEJ5r+VuFsqnSUIpRjV44KBShjM
	m2jjdDKDGLNILy5s+h96a2H6t/esvH7IzFb95CuUzadZEkxF+aEz7iX2AVrjjmINyUnNt2
	XYEF3ZTcNxykBmnc5mNSAxM/0Zz8L0M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-ODf3ewgcOK6gcuFALMN9CA-1; Wed, 31 Jan 2024 16:57:25 -0500
X-MC-Unique: ODf3ewgcOK6gcuFALMN9CA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33afc5a3f40so76659f8f.2
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Jan 2024 13:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706738244; x=1707343044;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5fW+pR0Od9wClLuo3WHp1P1SzDvmkG9A4Voix2JXDE=;
        b=LflCHmL9RxJr5TP8sCJECzuNiJFYYk28LXuH/6eX9tvjVAreGSUqTOJZ34iRxG9iBj
         hVUt3YVzZggjqMxBZ83gUkmZ7bHoThbNIvEtnK7JKSxiw9YfkdyWpAVHVHgi7TQvvkDZ
         ddr/Kfc68DeCLKZ+OYxkZ2uuVsrX9qA4Tnt/e4TTxntWRRJrJ3Unxz/Ifc4gLtr48BEy
         4ed13VDbiXjodxt6YSfy6aLH79fAgoFhDi8oo/IuCAgCOIZgiBmKB9xdbbCQKEkXvf5B
         MnQuhnWbyIzTVUaO0Wd21J03/OBf8Q0Z/Yrpu+sCOjdzXzSxC7ZMiYZ4x0KVvA5hn3nD
         f+ig==
X-Gm-Message-State: AOJu0YxD8AZ0z0zrsNzyQkvX3OC1cD7ut2mMMC3nK7JCjOFeAdlEe/+Y
	3Gm9EY2G1ED2gHeH5JkoVnd6MxJnnaSF8d0oZDNUg4BEuR2MBFDqCgtzX5ID/wVzbz/FMC39V+p
	QPA81rTjkAhYhbic/v2SALnTjgXubGNR0btta0/EdbuTv466vyfkCTh2KKtyZci08mlM+P5R1BQ
	UMiiUTALDaJ4Rc2ECIOF6qfZe1G7lgLsqC1mN21cs=
X-Received: by 2002:adf:f98d:0:b0:33b:998:3643 with SMTP id f13-20020adff98d000000b0033b09983643mr248800wrr.34.1706738244215;
        Wed, 31 Jan 2024 13:57:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvq6Klk32tuusUbUXszcqh0e5W5OiGe4KfWf4z08Djrb6F1s6ICn5hYUcrjCqeJicorPvnA82CO8a4mLBNIjY=
X-Received: by 2002:adf:f98d:0:b0:33b:998:3643 with SMTP id
 f13-20020adff98d000000b0033b09983643mr248789wrr.34.1706738243932; Wed, 31 Jan
 2024 13:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170663397812.1314437.1686905275956809283@demetrius>
In-Reply-To: <170663397812.1314437.1686905275956809283@demetrius>
From: Clark Williams <williams@redhat.com>
Date: Wed, 31 Jan 2024 21:57:12 +0000
Message-ID: <CAMLffL_XZqBwoq8WivEyAU46TrTas+x4h5n4H=fFRq3ODWmEpw@mail.gmail.com>
Subject: Re: [ANNOUNCE] 6.1.75-rt23
To: LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Wagner <daniel.wagner@suse.com>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	Pavel Machek <pavel@denx.de>, Joseph Salisbury <joseph.salisbury@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wow, that'll teach me to do two releases back to back. I fat fingered
my release announcement for 6.6 and did the 6.1 instead.

Sorry for the noise, the v6.6.14 announce will be out shortly

Clark

On Tue, Jan 30, 2024 at 5:00=E2=80=AFPM Clark Williams <williams@redhat.com=
> wrote:
>
> Hello RT-list!
>
> I'm pleased to announce the 6.1.75-rt23 stable release.
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v6.1-rt
>   Head SHA1: feaccee7987b202020fb8e13d33a793930a55045
>
> Or to build 6.1.75-rt23 directly, the following patches should be applied=
:
>
>   https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz
>
>   https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.75.xz
>
>   https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.75-rt=
23.patch.xz
>
>
> Enjoy!
> Clark
>

