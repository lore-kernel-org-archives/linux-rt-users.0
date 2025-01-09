Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E851FCFF4
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jan 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417647; cv=none; b=GQAIP5GmhOCGRW4B9qF56D9ndkH+d3j1zNS2BMTuAlxwYc7AY/0SkP1twBhczLRiE1cERfP+9Dq03U76tvD9c1KSr6d56gd3VOCHrDnN4FJCXHajNJMye0z8NzfsGKhbpfhPXZqF+54cV4MMLdcanswbuO2tQosvQslZZFuUR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417647; c=relaxed/simple;
	bh=q2USTZR2Wf5I3Ple3pAj/VZCxTlXBEz3x5lE+stYrn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYJNTRjb54vWlZS4HmybqGWA/YuSltiSi73Xupz0HGf1IMVqLRVxK5oXbmTHmPTvcRArWIVFAckbDE3twbqg/e+ZaMaGBZi+P0vd6r0yaITOe7TIsjhwOaiVBteMjo1xiweYaQmMO7AzbuYibjUkpB5pSMvD2RczlyvL38M3nFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Egmj/RDo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Egmj/RDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736417644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pz0CHp/C324NqVLWniKZKOsrDQGqZBbQoq18jwzZEAE=;
	b=Egmj/RDoNxAeu3f3SzE43ZZRiaXEZEzu9aVd+2lgq09aYuGwWvqhcAkigf3YZo6MId5OQX
	pcC8KVudczyH0i3IEIH3uHv2N5+8PFzESvenouayy42PEiCpLKygbLJduGMAbDIG3JdW8q
	vnQrBKGR90iuuvQAEZl+jqvejGMkNec=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-bvk1ldiPMBSk5TfwsJ6IAQ-1; Thu, 09 Jan 2025 05:14:02 -0500
X-MC-Unique: bvk1ldiPMBSk5TfwsJ6IAQ-1
X-Mimecast-MFC-AGG-ID: bvk1ldiPMBSk5TfwsJ6IAQ
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d3eea3b9aaso529775a12.1
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Jan 2025 02:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736417641; x=1737022441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pz0CHp/C324NqVLWniKZKOsrDQGqZBbQoq18jwzZEAE=;
        b=qV1Ppxsrm2KmJ64DF+yBed9CRdG6yjDuwVoYES0O3c8atnL4Bbnz8HzTpSGBJZVi29
         5Ml7sZknBcQbgszm/LgD0+IIYOys07jpDJAeda8uPydyjz3L1z+k1S0JmllaCtUouy/A
         CEl19u17MI/Am3+H2AO62TbrH+Y0B1haa/GI/q82GztLw8kzi/cOxYc7/a60RTNeNdNf
         yaBtAX7l/32ajB06YZLhjzQIuHU3xhAqjSor8EZVq3lf1ms1GoEne8jT+HDgsg1m48UK
         Qsz/G2QSWD9DlhQ7/wMb4GhkiRGfmmbLnE8yXTTwUMdbPRI0M3KlUnVrSF5O3e8ePauH
         oJgA==
X-Forwarded-Encrypted: i=1; AJvYcCUHB82p7/lGY50Rn9COLoHXnR+giDXyV8O7yFQMv9GfStHH8ZJa7NGwl7e4GzjdMFm9EjPzFx7BKsd+gnhAAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAmMjWdvp4fIfaZwwuunBtoQVXgguXYZdNHKaHZFbKCIvavyr
	yo13khpAViuUVErTUcWWLw8XzRHTiaIUd28a0hXVLzxQ43AA/wTKrlq3olkJlMgSi77wPBUu2YS
	m3vuxt9Q+zy8mgI58mrK7TcEX6MFzcvuPyWJLxkwGC67mShXX1SH5vVbjfb7ySRT7fvVc9InbW+
	VDW8/t1Vx7ZwHOx8MWJ6MxyP1Mbwom6lqZldylzc8=
X-Gm-Gg: ASbGncvsr5HfRBklkHli3L6z9rj0tLfE0aOldzYyDmIh2m6tcwc4T41dlNuA8NzJMfV
	1c/nCTU2JmbhtPRHGPhWoqRgK35/dyXL9w+rSEg==
X-Received: by 2002:a05:6402:3596:b0:5d0:ea4f:972f with SMTP id 4fb4d7f45d1cf-5d972e0b068mr13280754a12.8.1736417641525;
        Thu, 09 Jan 2025 02:14:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+WPeddEFepuRpzMGTILsnY65eGPekM8VUb5mQTkHGACIkn6pVtG0rc2xcMAR9qUaa5d9mG8F5+7YZY3xHmvc=
X-Received: by 2002:a05:6402:3596:b0:5d0:ea4f:972f with SMTP id
 4fb4d7f45d1cf-5d972e0b068mr13280721a12.8.1736417641222; Thu, 09 Jan 2025
 02:14:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228114346.6020d6b0@windsurf> <87h66b2c6m.fsf@kurt.kurt.home>
 <20250107141424.EoC5uS6y@linutronix.de> <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>
 <20250109080555.WpQmRgu0@linutronix.de>
In-Reply-To: <20250109080555.WpQmRgu0@linutronix.de>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 9 Jan 2025 11:13:50 +0100
X-Gm-Features: AbW1kvZlMlSLz1O7bKrmZX7tyPSA2QcigJ426GZvsqa99CNcDMcLYSbk3bxdbjc
Message-ID: <CAP4=nvTmQFPrv=FtJAy_g2xxsqBSfHE1mne5sEBrsDGKVAs5+g@mail.gmail.com>
Subject: Re: rt-tests release tarball location
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Kacur <jkacur@redhat.com>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Clark Williams <williams@redhat.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 9. 1. 2025 v 9:06 odes=C3=ADlatel Sebastian Andrzej Siewior
<bigeasy@linutronix.de> napsal:
>
> What I am asking is to either please keep all rt-tests releases in
>         https://www.kernel.org/pub/linux/utils/rt-tests/
>
> but this would also mean that the older folder becomes removed and this
> might upset more people.

Can't we symlink the older directory to its parent, so that all
releases will be available under both
https://www.kernel.org/pub/linux/utils/rt-tests/ and
https://www.kernel.org/pub/linux/utils/rt-tests/older/? Yes, it's a
bit ugly, but it would ensure the downloads keep working for everyone.

> Then there is the alternative especially if you prefer to have only the
> latest release on top to please keep all releases in
>         https://www.kernel.org/pub/linux/utils/rt-tests/older/
>
> even the current one.  This does not sound annoying, does it? The latter
> is what I do with RT patches while I release them after people
> complained so I have the latest release in
>         https://www.kernel.org/pub/linux/kernel/projects/rt/$version/
> and
>         https://www.kernel.org/pub/linux/kernel/projects/rt/$version/olde=
r/
>
> > John
>
> Sebastian
>

Tomas

