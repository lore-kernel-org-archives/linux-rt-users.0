Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB418FDD0
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Nov 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722686; cv=none; b=uKIkDo0WaCT2WS8b+xpiw6MyYBikXIKC5TzlQQXZlWZ3MIaQnv9l9lP8G8WHW7YX1++/cftEJNUly+Yrm+Ydjxrn7d79i5tNgDeMekyvpCjNp2/JXF8Cb2ezOMATe0Nh/MRDaPTWacaSYw/yQoYKa1a0Mx2Pf91wlR/B5cHEERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722686; c=relaxed/simple;
	bh=pyX8a54TKCqbfSZi+GyToKNjnZ/BSIKIKr5uqNjV5cM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D3IotMmYUp3B+O0ynq7gKQ21I7241totC+hhQeRsXZJ6GtezFaBVF/PFIZ2NzgjeNwXEeib+KaK7BvbDVrEAQwtntRsUfaNoNiJnoXDxSSUK/5NCoiAbO36iwZZKlWoRtp2SvapMLbfceX0tREHar98dw67bV0Ys5U5rZ7Dy8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2d1yv2d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2d1yv2d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732722683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5rEwSBnLdldYZWCgEKKH9wvsYuhFoCO3zfsU62VAyPs=;
	b=O2d1yv2dOeyegXXjsd2S1UUlQoModcF7i1GtilMFjwClB0mWis+EvudEzw2DHDTf13tBP3
	TuZlXGsfUZBvdPzHJo0bRjrXE6JAAxIvzmxxzS5pU3X9w22ij4jDO5xeAxKAt6Uqo2DpdE
	U+OiqgmyCsmwgsLLKF7keBGB4CRvE3U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-xibyhSxAMxKew6I-6Nsz0Q-1; Wed, 27 Nov 2024 10:51:21 -0500
X-MC-Unique: xibyhSxAMxKew6I-6Nsz0Q-1
X-Mimecast-MFC-AGG-ID: xibyhSxAMxKew6I-6Nsz0Q
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b67a8cd4d2so139906785a.1
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Nov 2024 07:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722681; x=1733327481;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rEwSBnLdldYZWCgEKKH9wvsYuhFoCO3zfsU62VAyPs=;
        b=cqsF+sUhoF2wpbFz5QC9CSVlBku+pB+Bepm3+NJ1uW9j25jfCUeZIpVSPCGZMa3t5y
         p7PNFpDwg/htE8atACOFRxO7wcSvxwgh0yo0ZMAai55ssKFm3m8CWYvZDlb53RuqOJxP
         2+kRxkbTgGer10oxHorPFHj7wNAA16UiV8aA71AIYGH2aiUE080ndExOw00r2M4usG5h
         K1dMe2qzd0zds2N3ltiNEOSuKHzRfymFMxMAxjBmrQ1G7NbC1DMvwlh8YE4asz2Fgsac
         QsCm5mjGGP9SRo5JU44sbgfGmVKofMh60tQWqwWO4TQzjMv4EljmVb+RVQQtc6KiOctZ
         6ePA==
X-Forwarded-Encrypted: i=1; AJvYcCVVtiKfXlLE9y3APSYVSR1yTm2ecyI/Ez4bGXBbQxAyWyVQv1i6YoOwVC4wR4Lf5ob4UrGb6vXxccG9QlQ9gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBzbkfJghwiQ5j4OED8wfeuLCgZPhY/72oCv3xfWPTiI+RyL2
	9xQyjo+Z5ZftFnDB9ChnDECn0HPPpP+BegDz7LU/Bz5vZ+i77GNBMvQj20myXN0azoB1JbSkIw6
	r+QRiBULMBrgcN4haMQ0zYZmkI2AQS/IfjwAneHWLFjImXoagVfRkxI9K2kX/T6xS
X-Gm-Gg: ASbGncvHyMthxWELY+EgRA6WQgG+2ZvkgmeIP/ZOhZZicvXOGO3T1TnWAyP6RvATfKM
	eEDcCGmwbH25uGUtGDFMbkBXDzCndZrWTOTpE9IkxDPwDH1HOpmtnPhip4Mbp4ux74fmBmaOkWq
	9LOVZyoiIK1HsSU5VoSIAsJh6UjUClLK1j9rHD/BR3aQiz+Mx6x8Ou8ho04I4XXpMdPcYEmW+Aw
	AKieZueOn4SygdAicXA/1CDCFxF5Bcv7rxzjgfW
X-Received: by 2002:a05:620a:2447:b0:7b6:66f7:c2e1 with SMTP id af79cd13be357-7b67c25d8b0mr457236885a.13.1732722681339;
        Wed, 27 Nov 2024 07:51:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJK8rRk3Swd2MOlon10zVpXLnyPWODcuiTIPyTklTPiQ6DdhCM4Z/R2UICiV8mWVLLQjO2EA==
X-Received: by 2002:a05:620a:2447:b0:7b6:66f7:c2e1 with SMTP id af79cd13be357-7b67c25d8b0mr457234485a.13.1732722681050;
        Wed, 27 Nov 2024 07:51:21 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b67d22aa15sm68253385a.119.2024.11.27.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:51:20 -0800 (PST)
Date: Wed, 27 Nov 2024 10:51:19 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Crystal Wood <crwood@redhat.com>, linux-rt-users@vger.kernel.org, 
    williams@redhat.com
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state disabling
 via libcpupower
In-Reply-To: <CAP4=nvTZ5nLrP6O7rSU+c269M-=OFTX=3zNSp6TDDxzg2Fq2fg@mail.gmail.com>
Message-ID: <18b58bd4-7884-3a81-08bf-ee5143ec88f3@redhat.com>
References: <20241113114509.1058593-1-tglozar@redhat.com> <20241113114509.1058593-3-tglozar@redhat.com> <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com> <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
 <CAP4=nvTZ5nLrP6O7rSU+c269M-=OFTX=3zNSp6TDDxzg2Fq2fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463748606-583833000-1732722680=:13450"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463748606-583833000-1732722680=:13450
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 27 Nov 2024, Tomas Glozar wrote:

> st 27. 11. 2024 v 1:09 odesílatel Crystal Wood <crwood@redhat.com> napsal:
> >
> > This could be said about the laptop and power_management checks too...
> > I'd go with verbose info prints rather than warnings for all three, if
> > anything.
> >
> 
> I agree. I believe my code is consistent with what we already have.
> When you do cyclictest --default-system, you also get a warning about
> not setting cpu_dma_latency, despite it being what you have explicitly
> requested. My patch just does the same thing for --deepest-idle-state.
> 
> I suggest deferring this to a future patch that would remove the
> warnings and another one to refactor the code.


> 
> > I'm not sure how cluttering up main() with more logic would help, but
> > turning set_latency_target() into something like
> > setup_power()/cleanup_power() sounds good.
> >
> > -Crystal
> >
> 
> Yeah, main() is already long enough, I'd prefer to avoid cluttering it up more.
> 
> Tomas

Alright, you convinced me.

Signed-off-by: John Kacur <jkacur@redhat.com>
---1463748606-583833000-1732722680=:13450--

