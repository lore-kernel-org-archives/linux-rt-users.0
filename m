Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138D610F1
	for <linux-rt-users@vger.kernel.org>; Fri, 20 Dec 2024 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717726; cv=none; b=Ws7BT2kwDU8KQLQdtU3ofdGO8LZSTSk9/y8YJ2txVTPIZcnO4tzHaqlk/TciToycCiTspp143mxyPQ+A26UuYWVOEVX6kSvpOYGX/hordSfMs4NlOOKcouwuaDR+S+JQ/2sJCwLDL111a+t6yGqtYAZmlbTGVU7wSVIkLe8Jzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717726; c=relaxed/simple;
	bh=u/plw9jG/h4LmhxM03WSAH7FU9LQUEa4D1BEe8+VPLM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D4YyUUrIIBklIMBnuMQPAz+I1TZRhpJpI3zxnmJzNLjx1yz9NO2A51bhihRXp2SIX5fwzfkoQqz6SfuIOI6qQCQSIAc2oVuK+2pXhTy4MJwjcN4tksIkzyaeB7PDYbHpccHCbHEMHq9OYWX5nnd9I8jsP3Hura+Cc0JLqJ0x1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RW9wAB/0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RW9wAB/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734717724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kphGd+7xc4ZEj3FQHbo9auhdo1CN6NoVSseGZ3hTQN4=;
	b=RW9wAB/0lcPiReUXsb6Ujfr/B3q6QjqXMrc4hXq5aq53NdBTPc0kEfivpxl8qDejrlRhoz
	m0OeqWUiAnZ//Dqs9S68a5wwlGuIa8TDkhti6nx8x+gdmXCgV0AH8Fd0zbzX2AugDOlqOY
	gpla0FdqMoN7dQ1RcFMZStUC0TXgK3Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-HYFoCnH7OqqYwl_HJwp2oQ-1; Fri, 20 Dec 2024 13:02:02 -0500
X-MC-Unique: HYFoCnH7OqqYwl_HJwp2oQ-1
X-Mimecast-MFC-AGG-ID: HYFoCnH7OqqYwl_HJwp2oQ
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f2515eb3so181140585a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Dec 2024 10:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734717722; x=1735322522;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kphGd+7xc4ZEj3FQHbo9auhdo1CN6NoVSseGZ3hTQN4=;
        b=CTUHdIT/TgNf5EiceWgzmLU8XeMyDqWbWZn0UAtMRVM5VTtA/UJnvGnJUNuOXC5/UG
         KnxOKaJsmcBJnnDx8Cut+VGd9edec4c1qvUB50emQLL+cHmyp9uVBjrNbD9lVQpRWVhM
         dC8YEzvZ5N+vKvv1L/v4wApIiZAjHKOfh4F6skI1DPzcD48DIkq+LkaL/9I9XkPSXpKk
         xkFK7sHmPR4aJsy5IXb26DEFdeFcCQi/ieR1uTZ2YqEN6UsKaiI7FCn/+/PKpNGJa5kj
         CP2mADG5g8bBm72q8ukmb6Wg0GLme21ZrapnnCV1dTC5L5L0gPd8Nx1wQhrMrpFXGs58
         kM4g==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/ZLgEKSv++pPIYrc3L1aVHTPylSNohfk07HAmqEaQWGG6g0u4k1voQguDONgk68epEi6LE9Zo1JypV3xpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrW+tO6T8/5GCqsegpERwW5a3yN42eMdoyKWCLiEw9EI4Z52IK
	XzdgzM1YlUbhwjfSTXxQbFr6seSJhDsoixt266mSnVbrYwCLAal0ILIme9Sb93ocyc8HURfTLK8
	T72/w61hRx1mWnhF/fxySqMLZJmKVPA3FlF0eaWisDCAoRe7paFutH+2XpGbdTOs3
X-Gm-Gg: ASbGncsx223cKyE3JeCry3OtlHUr5S7hWTs9GiqMM8LToq4jWxV1oDRAgw0VHJE2ygE
	G4Iu3HymazZ3uRZ060Lgj/dqytmUZhQQRH/rpjXG4jCr2L5I0GfdnA9iSWWMnH3lupeUL/nSf3j
	v2XoU5Y4tDu/LmCBpuO0klnsvrsfz6NuwU/wYI1Vc7VpVcqSdUzVWOaTlwS+T63BjTC7LQHoHFU
	XVlKQUkfpPfqXO8MuzQIHkRqPFe5La2Pf5YbKNyssQe67A=
X-Received: by 2002:a05:620a:4721:b0:7b6:d273:9b44 with SMTP id af79cd13be357-7b9ba72dfd0mr607732085a.18.1734717722102;
        Fri, 20 Dec 2024 10:02:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOXwLowbCOMes5UmUpCMo6Q2XSxEAayuCxmpUK/kj+lAbp/HPO2P5xjM/774kq5FSvYUfK6w==
X-Received: by 2002:a05:620a:4721:b0:7b6:d273:9b44 with SMTP id af79cd13be357-7b9ba72dfd0mr607725185a.18.1734717721558;
        Fri, 20 Dec 2024 10:02:01 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bc8d6sm156796485a.2.2024.12.20.10.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 10:02:01 -0800 (PST)
Date: Fri, 20 Dec 2024 13:02:00 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: ende.tan@starfivetech.com, linux-rt-users@vger.kernel.org, 
    mtosatti@redhat.com, williams@redhat.com, leyfoon.tan@starfivetech.com, 
    endeneer@gmail.com
Subject: Re: [1/1] rt-tests: cyclictest: Suppress unused parameter warnings
In-Reply-To: <afa631a73622f8b0d49dbe4608764b353841f472.camel@redhat.com>
Message-ID: <ca9f9d61-a81d-9343-7872-f1110ef7b247@redhat.com>
References: <20241212162453.2618945-1-ende.tan@starfivetech.com> <afa631a73622f8b0d49dbe4608764b353841f472.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 13 Dec 2024, Crystal Wood wrote:

> On Fri, 2024-12-13 at 00:24 +0800, ende.tan@starfivetech.com wrote:
> > From: Tan En De <ende.tan@starfivetech.com>
> > 
> > Mark unused parameters with `__attribute__((unused))`.
> > 
> > Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> > ---
> >  src/cyclictest/cyclictest.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Can we just turn off this warning?  Unused parameters are entirely
> normal in functions used as callbacks as well as with ifdefs, and it
> seems like a low value warning to begin with (there's a reason it's not
> in -Wall).

I believe it IS in -Wall
https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

John

