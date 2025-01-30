Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F719D07C
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jan 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252816; cv=none; b=C8lKYOM2LpyEwmZSiAcr0mES2+QQd1bij6zn84kFwgMC6YLC+4JXdq3WxxfR1jRcZDMlhzNJhYkF1DUKj7MC6O0/ULT+hAfmPfWHS9bmMBcRqEl1MBzJudkDZPCH+IhMwboynmS7eBPZBSvlE7L+i+HHxU5b6Ru7BpEKO9eWu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252816; c=relaxed/simple;
	bh=kJEkwqMfhs82sdTniSqMtebtRtHnyt4C10Q9OpXu8PI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Soe8cXiVa1Dx9s2qNEFDmKoZOhkYE5UqIbX1QqBKFnZd0X1mrQaCyHw1ObZuwQh1uAbfTppnaLiZaGPPoXAW1w3JRpM5kGoLmZ/CakJ6P/sk2okP19TTPZBCFdTKn7LxXVOfzB/fo5F06wutfn3/GXa3G6RsL8ETuWy3e3zi6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXKKK0qU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXKKK0qU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738252813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/6Lpd314Tc83v5aDFKzenOMOpY1+JhnBOSHgPvSqXE=;
	b=hXKKK0qUZbY+zmZ8jUPvP9KIC6ZB5uAxn13ASyANega9B4czW6LySI5PMYiz+VuNe/g1rc
	rhlBFavnwe9O+xTr85ZnBtb1ksLU7SxIs6nHAwM2gHk+snjylt/gQ8mAVlGRlJlMLPRwSA
	kZqEmbdOGGX4qhS0TRtml0OEgs4sq1A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-oMA8LPfBOCGMg3B5JWuX3Q-1; Thu, 30 Jan 2025 11:00:11 -0500
X-MC-Unique: oMA8LPfBOCGMg3B5JWuX3Q-1
X-Mimecast-MFC-AGG-ID: oMA8LPfBOCGMg3B5JWuX3Q
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e852eeabso157992385a.0
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jan 2025 08:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738252811; x=1738857611;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/6Lpd314Tc83v5aDFKzenOMOpY1+JhnBOSHgPvSqXE=;
        b=E2U6trm427GcZthSVO2P7/4r7c/bG8grXwzNYh6sKRuIWZ1XPtB8jziU68np1OerKP
         neMY4NEgDiuUJrLFO9jswNehlnO5YS/rVZEKuN+CedglNPstWrpZeGGmj0grqsVBjG0L
         edwdpREXvGcCVq3biNDPPhaoqgaL+rWKn4MugdlrbABz/RhHkMh2EDkGkZQMMMluQcWu
         aedo7Or4WgC6FNhXUhSLlCX0N4bry+E1/+oHloq1M4WH5kQ2MTIHk5BrbzL16DcvM+yd
         YyikEuvLVTUEkqHzUyEiT7oKef2ttzZjIs9bZWLzUX2b31Dk0q/IsWMCuV1OjvX+K0AV
         AMUw==
X-Forwarded-Encrypted: i=1; AJvYcCUPDA7mM9w01UwraF5SIUlO77cmyCFwFfguS28Vv7iScKogCIdo561jrtFE5amIu84dWlJMIdT4e9lKJso3Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZ10wXxIrBwDrFJ6HQsDrglK9XGD3DndFqUzkTdAC7MbcWhq5
	/UHm4YMZHnAbvfYcrORG7uMHZySkrnBOlo8mWhj9EBFG9bWpWm8S4GvZAdYxVJa/Hylbe2rMUkp
	7BsxBcwse/cOkuGCJwzaerA8+OA271D/PdyodCZL/OxgzkKsl2zVL/mMzwIgeG3ez
X-Gm-Gg: ASbGnct4CQr0S3llPDA39kvIIhBSkG1TUL5UHYmz6RNlqNQFu+YoRtC/yVqd8FzTqat
	EGg2UchqV7FbXMokn8HYLggXKelJfzZ01QsJhvHEdL+2I/1gOx4zcZN1iBKkaieQ/F3E+7WktTP
	pzko0ohOewFhcw8AMjGQlcUWhBpFbDpzPvaxEi6lrtT7O3ZNwuEKnKjxOer5tGB8sMBm0TvnQRF
	TNhti+aoapwAM7hqHbMR/IICd2Kwd7e+3Tf2+jzcbXAcM8W0u874CSo4Q/4rtOvpABjl1w=
X-Received: by 2002:a05:620a:248e:b0:7b6:6b52:8bb1 with SMTP id af79cd13be357-7bffcce06e5mr988954185a.14.1738252810958;
        Thu, 30 Jan 2025 08:00:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfXj/qbqg4uMr0jSRsArV3Y3QZrE/B0jMFdq9XYix0jYi8ruEdIRc8E3sTVlymAAYvWreu2g==
X-Received: by 2002:a05:620a:248e:b0:7b6:6b52:8bb1 with SMTP id af79cd13be357-7bffcce06e5mr988948585a.14.1738252810534;
        Thu, 30 Jan 2025 08:00:10 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a906518sm85795685a.84.2025.01.30.08.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 08:00:10 -0800 (PST)
Date: Thu, 30 Jan 2025 11:00:09 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Khem Raj <raj.khem@gmail.com>, Clark Williams <williams@redhat.com>, 
    rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] sched_attr: Do not define for glibc >= 2.41
In-Reply-To: <6041e9688de0cc0fb676ce6b20291f7afb2b96d0.camel@redhat.com>
Message-ID: <5325ef50-b73b-1571-f937-df44718b1e1e@redhat.com>
References: <20250128230838.2311298-1-raj.khem@gmail.com> <06e5ea58-b30e-0a8b-c9e8-226e8c20d70d@redhat.com> <6041e9688de0cc0fb676ce6b20291f7afb2b96d0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 29 Jan 2025, Crystal Wood wrote:

> On Wed, 2025-01-29 at 16:54 -0500, John Kacur wrote:
> > 
> > On Tue, 28 Jan 2025, Khem Raj wrote:
> > 
> > > glibc 2.41+ has added [1] definitions for sched_setattr and sched_getattr functions
> > > and struct sched_attr. Therefore, it needs to be checked for here as well before
> > > defining sched_attr
> > > 
> > > Define sched_attr conditionally on SCHED_ATTR_SIZE_VER0
> > > 
> > > Fixes builds with glibc/trunk
> > > 
> > > [1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8
> > > 
> > > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > > Cc: Clark Williams <williams@redhat.com>
> > > Cc: John Kacur <jkacur@redhat.com>
> > > Cc: rt-users <linux-rt-users@vger.kernel.org>
> > > ---
> > >  src/include/rt-sched.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
> > > index 80171c7..9cf0e3a 100644
> > > --- a/src/include/rt-sched.h
> > > +++ b/src/include/rt-sched.h
> > > @@ -42,6 +42,8 @@
> > >  #define __NR_sched_getattr		275
> > >  #endif
> > >  
> > > +/* sched_attr is not defined in glibc < 2.41 */
> > > +#ifndef SCHED_ATTR_SIZE_VER0
> > >  struct sched_attr {
> > >  	uint32_t size;
> > >  	uint32_t sched_policy;
> > > @@ -68,4 +70,6 @@ int sched_getattr(pid_t pid,
> > >  		  unsigned int size,
> > >  		  unsigned int flags);
> > >  
> > > +#endif /* SCHED_ATTR_SIZE_VER0 */
> > > +
> > >  #endif /* __RT_SCHED_H__ */
> > > 
> > > 
> > 
> > Does the following fix your problem?
> [snip]
> 
> > +#if ! __GLIBC_PREREQ(2, 41)
> 
> I'm not familiar with the norms surrounding use of this macro, but it's
> generally better to test features than versions... what if this feature
> gets backported into some distro's earlier-version-numbered glibc?

The macro is part of the glibc code in features.h
You make a good point about testing the features, but you could also argue 
that there is no guarantee that the implementation will always have 
SCHED_ATTR_SIZE_VER0 and that it could break in the future.

> 
> FWIW, it looks like QEMU went with the feature test approach:
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20241011054806.1014276-1-raj.khem@gmail.com/
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20241011193140.1047648-1-raj.khem@gmail.com/
> 
Well, that's by the same author who sent this patch.


> Also, was that patch posted anywhere?  Just wondering if I've still got
> problems with email filtering.

No, a version of this was sent to me in fedora channels to fix a break in 
rawhide.

The version is more complete than the other patch because it also fixes 
src/lib/rt-sched.c

If this works for folks, lets just use it and move on, it's not worth 
endlessly hashing out.

John Kacur

> 
> -Crystal
> 
> 
> 

