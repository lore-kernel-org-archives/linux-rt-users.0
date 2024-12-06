Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA9B1F3D34
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Dec 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502624; cv=none; b=SVxIG31jQXPq/RjnrjgZridb6pC8z4ljQgqh7B+fHHvHs4nshQsyCzY6zkV+1OQJ1ghACqC4Vd5FYLEInksLhnZUHj/O/kNTX0KvVK2vIPNjJUkNVAwFeotLEvN9T5f1Lal+rDD7hoRrEJDC6OaI+c2xCR7E0I2KSimh6iY5kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502624; c=relaxed/simple;
	bh=pQDcAemzbapVktoDIQ8F+y8f6yJAP7/ljBhUs7YNQa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkyMBdwgEW9/vutBk9e3OFOptuuX31VGW+rdHjSaGA2WP5NVxh6abg4HQgYFBdJqb/LDKYcfHN9/b48yObbL4v6I0KVFLlpnuRUQpQ8f2nOOW9UtrR0yYrtfC4O90B75R91SfcH9oUBQX9J0AHfrFbm61ei9Ext8N95mdb4Qneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dC8L5Bzu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC8L5Bzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733502621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEOV8AIhBoB9AvDjHDWD9/oHVbE7APb5kRg3pvXByF4=;
	b=dC8L5BzuFWcnq9fBy9lJ1NttdApsnotHokIQ6fQ7GC1fPB6kjI2l6k8iLiAgWHh1fjcBEx
	qCuImTnulJ/jLzPMf9FfvrDjYOM3pzHMvB+NwpWqPpynJJ4RDdOQEp7iyDYNt20m//0YF4
	Qj4kCmvuRGQNXN2l9iJ5XDHDntgLtfQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-7IY6gJAXMWSbYTwjRo256w-1; Fri, 06 Dec 2024 11:30:19 -0500
X-MC-Unique: 7IY6gJAXMWSbYTwjRo256w-1
X-Mimecast-MFC-AGG-ID: 7IY6gJAXMWSbYTwjRo256w
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e1339790so1427938f8f.2
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Dec 2024 08:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502618; x=1734107418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEOV8AIhBoB9AvDjHDWD9/oHVbE7APb5kRg3pvXByF4=;
        b=NK5EUTLTRUwikxcXLv6iquKZibZgW0btIBfqhbpL6/x0AmAZ93eR358S05PHLXM0pX
         iGNLjtv0KxzomE50BtvTWQGs1PL0Htq8+asNVSYa5sShPM7XLz0bfPrruxr9ubma/YZ1
         nw4BzTjeS7bjQI1kb6hlrCaa4HGuc/lBzGrthFBuWpQMmBJJNHkZuav+yqaTDzxpqtgE
         RoydqVH+CJzBAxGTjJZ1aeXjcTC/tMnnVjKLtwXJTDptIAG3o78G8X4lCaXEp12YuGf6
         KlURd/paT/AN6i1ArselXmlBJI8DWCKHxO9sCu6qRlyP7QkQ77D0u++Tr3+g03j+DhaV
         3Crg==
X-Forwarded-Encrypted: i=1; AJvYcCXrzBXetC1SC1nU4PyXuRCzcM17f8le+dG9ylzNpvhUMjAyMRx7PiDSgjg0NXVBz7nox+OLsUxf1wDd+/E9UA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzunJCWvvWasGdNw9DTtzy3NV3AJCffN1gYE+R8ahLnqEsTkNxb
	CL34m9Gu2zE6wDTHz6PJKt4oXgBQJ0QCgmorcBHPXRE2NDxOEwfDRNXaKIbDtXZyoJXZ7v8KzFM
	FKthkOUgdBksNMh0/1h3xNLmJe3010tOJ6AMcc4JqsF+udLRzUO2uoz0aS5HlKsRrK4VlPLivbi
	s46hCpaP1yE2cVBP0tWwvoTOcyncGlJMwVBoTW+g0=
X-Gm-Gg: ASbGnctvb/A9I9W5foFccKZWt2uzNkvAj7GmkG5g6cOZ6aOf/yE/8/AmFtch4/FHA08
	7NbdJ9QcZaoMJNLt0uJqi7p3Sms1hfw==
X-Received: by 2002:a05:6000:707:b0:385:eb7c:5d0f with SMTP id ffacd0b85a97d-3862b36ace8mr3693657f8f.26.1733502618223;
        Fri, 06 Dec 2024 08:30:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnu5uzpkWjfcU4pdd5o/39FM3VzHRtGNeapFyBsxD9aw6AxhlBO3YvriAgO37aghT0D8M5/rerbo71B/wuZLk=
X-Received: by 2002:a05:6000:707:b0:385:eb7c:5d0f with SMTP id
 ffacd0b85a97d-3862b36ace8mr3693633f8f.26.1733502617936; Fri, 06 Dec 2024
 08:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203094009.67697-1-ende.tan@starfivetech.com>
 <20241203103611._nfkyEXJ@linutronix.de> <NTZPR01MB10187B77E803325E8C88F383F837A@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>
 <20241205080614.y_512eFh@linutronix.de>
In-Reply-To: <20241205080614.y_512eFh@linutronix.de>
From: Clark Williams <williams@redhat.com>
Date: Fri, 6 Dec 2024 16:30:06 +0000
Message-ID: <CAMLffL8BPgObXvb4Ps2AkfQj=h62UJ_g_M9OYOkUsXhUZMzz=A@mail.gmail.com>
Subject: Re: RE: [RT,1/1] tty/serial/sifive: Make the locking RT aware
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: EnDe Tan <ende.tan@starfivetech.com>, stable-rt@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	"endeneer@gmail.com" <endeneer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yes, I'll put it in my pending RC

On Thu, Dec 5, 2024 at 8:06=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-12-04 15:24:38 [+0000], EnDe Tan wrote:
> > > -----Original Message-----
> > > You need to state which kernel this needs to be applied to.
> > > The change you looking for is
> > >     32c694ec3efc2 ("serial: sifive: Use uart_prepare_sysrq_char() to
> > > handle sysrq.")
> >
> > Thanks for pointing this out, I overlooked the commit in the mainline k=
ernel.
> > BTW, the commit is not in v6.6.63-rt46-rebase.
>
> Indeed. Clark, could you please backport
>         32c694ec3efc2 serial: sifive: Use uart_prepare_sysrq_char() to ha=
ndle sysrq.
>
> for v6.6-RT?
>
> Sebastian
>

