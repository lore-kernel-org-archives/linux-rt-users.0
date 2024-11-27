Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B9200124
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Nov 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722478; cv=none; b=uL6Di85ozKsyUKTGqHJHeJl9zkxDfrJHOOMLesfyRZIi7mErSyhydQDbpV27GGtTf+QUNcm6LzS3uHtLicF18No/ioepeHBgDPFxjfQ4ibbSTceoj76AycSK9CaV0As577Z9JjhOkrs8AatkURIf5gD166VJwec0o+g/sMh2YLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722478; c=relaxed/simple;
	bh=k2J+htwy4onOwfgio6+Tzo4IdbEnBZtbnLVN16jySxk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nNHFq4Wg90WxfP8fsSsYwpd+26/E4tu5cW5xqTMwNVL0C584rsCxZg+rIpBcZBXiTO1jq4Dsa1tLlFgUSgRpM/WcuXVZu0kasZNzDV2UCxJZ7yvPGZszfhYHFOiPRKHOk+PaUX9CXenhcdixhf2OAeVkP3FiVSFIBAU6BFW/a2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DONBT/ae; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DONBT/ae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732722475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIdas/pvhSoC4CHGxNJqjQEPTSDHDFoL9V0FFYCBMdU=;
	b=DONBT/aecIELnIYtXpWCK44cqPdIQIT9afI6QOSQkCCxYIuFK3KOLedSRkNpOGbpHk4cpg
	pMfQC2EBTXyq9B8dZhxMj1oLRgboI0rWGdXUeK3EOKA5HHpwlMImTEjl7OhN1D8RjvtvZL
	ilW5Cajvd5PpVL4Gus/EFniIjiJeyPY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-TjpXFkPMOmKZVbUok4vCjQ-1; Wed, 27 Nov 2024 10:47:54 -0500
X-MC-Unique: TjpXFkPMOmKZVbUok4vCjQ-1
X-Mimecast-MFC-AGG-ID: TjpXFkPMOmKZVbUok4vCjQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d402d4ff25so100473516d6.2
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Nov 2024 07:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722474; x=1733327274;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIdas/pvhSoC4CHGxNJqjQEPTSDHDFoL9V0FFYCBMdU=;
        b=iCsZjF79Ae/Z8F6/CgpP9SKw6SRLAlIVvNiBHdFWjuTskMk41qxIwcj2ezJHLKabs1
         t/W7UesYnt2P/P3AyBJWHlHhkEPiP+FvK2PJ6KQi4lKH+dVxVldLOdQTrMcID763L5WS
         2mo7o/dL+sLUMzNT2D7hVhH3I/VmE4ks8TyPUKOoNCZ1VwfxxoGtSj6bqqMqtdD6YHtF
         eKxj9iRQgqfqyszhFVI75bqtaYVBkQGNC3i3+UgCiVo6CQ+oN9dssknIZDWi3VzlIjdb
         v6bFBaKnrH1IFEeDm7KWoltjfCyNw7onLe4jtO+5VBz5kNo21JWFlc8kOv47xEWzbNQY
         JcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWefNpQzhmq5vzLsJtqmTes2BLbTPhQI7Bzhm6/FwBgERT53RJT/0gK+NoSWVI89cw6LcDRKXwfWpGWe4D4eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuM4Fybvw87D6/9C3+IFy4zvshKtUDEKbDPtPXiNKUcDh8bWx2
	W5rKraQc9V3Y7z+hXokQ9AOLMyN17qOowBsxtqcb/R1zb/Ctw7KsfV7u0eHUHUkKvQ18id0/GtI
	UjQdB6gOHXm3uSxh4Bjhe+c8im94gbZhygbukH321x7uKL9z1yya4LDPBZnT7cbyVyuxZOf94
X-Gm-Gg: ASbGncvF8N0PsDAFKK6nNBUcZOW2DQr5w2yZqWiSkTde9o8j8/2wfsyi/YQYjtmOxz7
	/Go7bSOqavI2v4An39kyar2hUdkTqCiI79aYP9g9mS/qOjyh7uk1zw63dXUq/M5BnPyq6shmQTz
	CGypXrEsZchhLVwcl0VEQ/abhdMLPYtygQvhON+lE6V4ZvVarrky2LBy/lEl0Yir4ZZ+vW7AijT
	OQ8/bvsyH3Pin2verc0GTG38IW6nGdVAgcNUeuY
X-Received: by 2002:a05:6214:acf:b0:6d4:22be:9824 with SMTP id 6a1803df08f44-6d864d82fbcmr55920566d6.28.1732722473896;
        Wed, 27 Nov 2024 07:47:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhvQRMMZdd2i16O0N3+8yz/gBKPbfOrQfk11LjuMsTkfyjzuem8RFZBz/EMVZbk/tsvR9b4Q==
X-Received: by 2002:a05:6214:acf:b0:6d4:22be:9824 with SMTP id 6a1803df08f44-6d864d82fbcmr55920326d6.28.1732722473603;
        Wed, 27 Nov 2024 07:47:53 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b4c69esm67003966d6.113.2024.11.27.07.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:47:53 -0800 (PST)
Date: Wed, 27 Nov 2024 10:47:52 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Tomas Glozar <tglozar@redhat.com>, linux-rt-users@vger.kernel.org, 
    williams@redhat.com
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state disabling
 via libcpupower
In-Reply-To: <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
Message-ID: <c8bd0b4f-dc73-5c9b-a692-bcc3f9660884@redhat.com>
References: <20241113114509.1058593-1-tglozar@redhat.com> <20241113114509.1058593-3-tglozar@redhat.com> <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com> <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 26 Nov 2024, Crystal Wood wrote:

> On Tue, 2024-11-26 at 17:29 -0500, John Kacur wrote:
> > 
> > On Wed, 13 Nov 2024, tglozar@redhat.com wrote:
> > 
> > 
> > > @@ -254,6 +259,11 @@ static void set_latency_target(void)
> > >  		return;
> > >  	}
> > >  
> > > +	if (deepest_idle_state >= -1) {
> > > +		warn("not setting cpu_dma_latency, --deepest-idle-state is set instead\n");
> > 
> > I don't think we want to have a warning when the software is doing what we 
> > request of it.
> > Can we either just move the logic out of this function into main and
> > call either set_latency_target or the deepest latency state logic as 
> > appropriate, or move all the power management logic into a new function?
> 
> This could be said about the laptop and power_management checks too...

true

> I'd go with verbose info prints rather than warnings for all three, if
> anything.

Note that verbose on cyclictest doesn't mean print extra warnings, it 
means output values on stdout for statistics.

> 
> I'm not sure how cluttering up main() with more logic would help, but
> turning set_latency_target() into something like
> setup_power()/cleanup_power() sounds good.
>
 

Sure, that's why I gave two options, however, there is already 
--deepest-idle-state logic in main(), how much more clutter does it add to
not call set_latency_target() if we're using --deepest-idle-state?

John

