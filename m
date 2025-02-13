Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AE1FDA76
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Feb 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466357; cv=none; b=A4a6oI5AvZPMxcTeH31nY9ahDIDE32uZX8ispODZk0MDSoecJJc4JBwl5eIEWy3+pzNs9LucGOotWS82Ki/OaZHGuT9FSQUSRunVkQrWzSQ+cUrLejpSmx9HdrRcQSmPjB0nGXx1GjatEWYxdrPnm1zRSI2gslUsX0yVHl4tPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466357; c=relaxed/simple;
	bh=JRjDOwO1MZA7wOBIIPl89z+wMj4ug3KKiDN6EYVuPWA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KEAHR3qn7jLv8m/Cf1naew1JkC6+m+c5k0E3xd3Lk8Hcgjv605w8Uzz/kJkr2Ed5qCdQ4mex8OoL2T8QovEMU8PCdS+xw7h1D0Iwz2VgT6Uhf2HrAntZj6Sfw4jLTKZp3TO+Y/I/VEvFukKPM579QTvTpPkhpZVMwfbhkfAk5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4IS5Iro; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4IS5Iro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739466354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1WYfWgB5ZF51CCpUqFef2VRzTLDWwB8UB23BILJdMc8=;
	b=W4IS5IroR3RRsATpJhU3dsSBJHnM79IEMYBjAEqcDaj1oPg5jpt/NGulXXh+WnK/i31usk
	WmZrJ2WLX59VTJzFnH2tfufuZTKwfg9oK8F1DIiWiH3i1xezBDGIWt4u6Nh8fZAbnG6Z66
	Ktt6qtdkU+itpjaKwjauMxg/pF2Q6Jo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-o9_V3WRCNz6sYl6RIXFMdA-1; Thu, 13 Feb 2025 12:05:53 -0500
X-MC-Unique: o9_V3WRCNz6sYl6RIXFMdA-1
X-Mimecast-MFC-AGG-ID: o9_V3WRCNz6sYl6RIXFMdA
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47198c965e1so18889681cf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Feb 2025 09:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466352; x=1740071152;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WYfWgB5ZF51CCpUqFef2VRzTLDWwB8UB23BILJdMc8=;
        b=R7qsOrOVn5YiOT9TrxE7U/LD0wu8SuI87fYpxhYKUlktW9/xKPQ5UC+kMUmt2phoeq
         g5cTnEwoXVIujGMS+THaPeLoscsrtsRQl4/jeHObGuzPr8hNPJ47M18fRmfBFinkSI/Y
         FJR7gJnw5TWftZ2y0kjlZ7PLBlwXGDcqQmGp0ulCH2+B6e5b69D0+rOhMBbdImLYzP4H
         zf1vizTi4YVh7r/8oGuepu7gQ2yaO8kdwY2SlJ0Qm3QYwQoqLysGRefp4swvsbugCbzC
         ut4YT8/Y29Lplss9rLqeibI0Ef38lQtZ5xUMqeis8uI+rgkdtaOMcoFnc1nK90UMsT3I
         mmuA==
X-Forwarded-Encrypted: i=1; AJvYcCUEIPglIj1Tyr67QT0WqG8u/hYh5eUyUsz5HoPkmgeK9UJrp8yG/VzV3YVW5XQrRGmvJUR9XeyKt4OaFX42dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQ3MJnQeIKkr1BbWLfyP+dtRckADtx91BievM4WXRXKa+fsB5
	1oTY0ECSytc6OaZLwSNYg+dI6I3jN6ZBEeWp060dwoj3l2Tp7PR0di8uYuGKfGpFG0UAa4huXye
	e5O07mnLli4Lxa51dEPEheRnBBDReJsNORUASQpWRfBT6F/mh1zuoTxme8HLFucA8
X-Gm-Gg: ASbGncviNvbHD3puROMdUn6jM5eeaBVX1qZc96agXeQPNoH8chPNDVlu61PEsTnUNdw
	zxMlb6m/MTLB2yyft94lRttWU8wc5WpKgKwY1Es+GQKCpcgHrOxxjXIr0ZV7GFD2AZdSKNUxi4e
	71IvI/wVqYdXzZXQL76BuCrUik00xYlux5G4OOXv+FlqqPjS8RaVdUpxcbKks9V+i2w3R7Ov5Uy
	K4xhZ4aT9it1USwUwn4oCe5hKzYAcie6IM4DEel/xC1Owya0jNpW9q8r85VsjFRIY43lXg=
X-Received: by 2002:a05:622a:229c:b0:471:c658:8760 with SMTP id d75a77b69052e-471c65887d8mr37304051cf.32.1739466352524;
        Thu, 13 Feb 2025 09:05:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhfgoaM3RDwvU8KRi9j0LtWQsKD2Dc1R9k7Fy+V1sRjEWOqKejBEj/QEkHFrs7NkqwEzsTEA==
X-Received: by 2002:a05:622a:229c:b0:471:c658:8760 with SMTP id d75a77b69052e-471c65887d8mr37303631cf.32.1739466352181;
        Thu, 13 Feb 2025 09:05:52 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2b04417sm9690211cf.67.2025.02.13.09.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:05:51 -0800 (PST)
Date: Thu, 13 Feb 2025 12:05:50 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Crystal Wood <crwood@redhat.com>, Clark Williams <williams@redhat.com>, 
    linux-rt-users@vger.kernel.org, kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2] Add cpupower idle-state functionality
In-Reply-To: <Z60Rfi05LXbjGfHi@thinkpad2024>
Message-ID: <1c58aa9f-79f8-f42c-3d1e-0055bb12ea17@redhat.com>
References: <20250128014551.15058-1-jwyatt@redhat.com> <21714eaf-d3d8-81bd-cc27-7a8aeb0bf971@redhat.com> <50cda06eaa30769ebb2c3130fce5394f1d8bd9ad.camel@redhat.com> <Z60Rfi05LXbjGfHi@thinkpad2024>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 12 Feb 2025, John B. Wyatt IV wrote:

> On Wed, Feb 12, 2025 at 02:53:35PM -0600, Crystal Wood wrote:
> > On Mon, 2025-02-10 at 14:50 -0500, John Kacur wrote:
> > > For the -s option, why do we need to put the IDLESTATEDISABLEDSTATUS, if 
> > > we omit that can't we just get a result like running "cpupower idle-info"?
> > > Could you rename IDLESTATEDISABLEDSTATUS to just IDLESTATE_STATUS?
> > 
> > This was confusing to me too, but it looks like the argument is actually
> > a particular idle state, not the status of that state.  So it should be
> > "IDLESTATE" just like -d and -e.  Or better, "IDLE-STATE" like "CPU-
> > LIST".
> > 
> > -Crystal
> > 
> 
> Apologies for not answering you earlier John. Did not see this email until
> Crystal's email.
> 
> If there is no objections I will go with Crystal's suggestion.

No objection, just as long as it is legible, that looks a lot better!

John

> 
> Here is the current printout for the patch series I will send (note I changed
> a few items to address confusion). Please let me know if this addresses
> everyone's concerns:
> 
> options:
>   -h, --help            show this help message and exit
>   -i, --idle-info       Print general idle information on cpus in CPU-LIST. If CPU-LIST is not specified, default to all cpus.
>   -s IDLE-STATE, --status IDLE-STATE
>                         Print the idle-state (cpu sleep state) of the cpus in CPU-LIST as enabled or disabled. The argument is the index of the idle-state of the cpu as reported by -i. If
>                         CPU-LIST is not specified, default to all cpus.
>   -d IDLE-STATE, --disable IDLE-STATE
>                         Disable cpus in CPU-LIST's idle-state (cpu sleep state). The argument is the index of the idle-state of the cpu as reported by -i. If CPU-LIST is not specified,
>                         default to all cpus.
>   -e IDLE-STATE, --enable IDLE-STATE
>                         Enable cpus in CPU-LIST's idle-state (cpu sleep state). The argument is the index of the idle-state of the cpu as reported by -i. If CPU-LIST is not specified,
>                         default to all cpus.
>   -c CPU-LIST, --cpus CPU-LIST
>                         CPU-LIST affected by commands
> 
> -- 
> Sincerely,
> John Wyatt
> Software Engineer, Core Kernel
> Red Hat
> 
> 
> 

