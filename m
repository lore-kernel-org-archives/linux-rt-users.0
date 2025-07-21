Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD1520B22
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128063; cv=none; b=cqe0bSpQlSKwayjXOZIFX/WgOP8tDPMSqV+ai8UOkNBlI0adgpaLKGXt09bmR6tcvb1y5h2Lp/9BnYuuuVaUA1hubU0mdgFm3wrwnAurlRzsNrDGPRMmcWyyulxrqVxyFovhvMMcGrd6NSQNrl526t1hdv3Sd4bCtuvsbinShcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128063; c=relaxed/simple;
	bh=yrWNdgp5jifHvone/jBJb++f9UHTo7/u6RuztElXfOY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m/oxEEkHvOozANamqQxIVOWDDQphOk3VGB9l5LjHLcRn0b4BQNnt0S/X+z+DWndTJ+nyJEfDFAr4nCv3yPVW6HboPoIRmvrwnGV6l3yCbsRcRyNYdvgZH7fefF2++hTct10Tx5+QI7VsFUkJtabmn2z2Nd1hk4a74cqUQOeMwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bn6oqTAi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn6oqTAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UWVnKLqPzkUQu96nFxNuKL97UgGloEmzOH1NywPw8Gw=;
	b=bn6oqTAimOLljz5RxfCIpGiudvRUkv1GDvbBfaYGo/EoVHw5YB2/7nPVrgW3xm1IRdjEHi
	3yFc+qReKbcgxtopaW7HxSzPW8IwzVCksDJCC/oCP+0x0ySik7o3TzRjyEaSyq00ogR5nO
	XHByNpP0wpHPmTFLCBjjlhMAb3uNHUA=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-BUEIGtPsMuuQxUNyEmRKnw-1; Mon, 21 Jul 2025 16:00:59 -0400
X-MC-Unique: BUEIGtPsMuuQxUNyEmRKnw-1
X-Mimecast-MFC-AGG-ID: BUEIGtPsMuuQxUNyEmRKnw_1753128059
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4f5ccb416bdso165304137.2
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128059; x=1753732859;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWVnKLqPzkUQu96nFxNuKL97UgGloEmzOH1NywPw8Gw=;
        b=tXzPT+y4jGOMn7H8kmHu1xITZfXv9jbCxOe1mzhzhEksan9InU3NlMiP6fjM1StM7F
         w8m5b6yPdNJc98RC0J9/iSI15OC7FjshHlOrGV8S1m0g9XoetsqG3QjmFaNjBl77Rvrs
         OADzk+BaYgysJ540kCoBjgjX485EHxnD+VxC5L1LMmOVjX7tG9OXAVeW2ngVBF3N1PE3
         lg9uIjIUOYTj13BgdYwLs6/+Phhmh6fHlHlhmwtpi9tJJ3fdlhS00R92fhDIXIh02mkc
         kBt95T4Yi5FyWKI7wB2OL/x7J4Xfowz8UVNxbXXYzadCXGNlE1zpFK9cQ0IRA7b4cyoA
         5zdg==
X-Gm-Message-State: AOJu0YyoCq0TABXHE35N+Xrrdj768YvF38wVkgsAbLpA7yDlHc6vZAjG
	N/ZyNcqTivqzUsuJRH/sLJcfl0JsLYapjD8sFxBSwDsiZjK0xjbELkzuJIbC4M8ZmG15vXZM7Dk
	WxoFKWK9n19oc/2Uxw/vI1G4wSiLzEIYmOH6DqJq9yM2sNIFAHjNAs0VF7ZUJ7sjmIuRx
X-Gm-Gg: ASbGncu48EkVqWz5WaKI19A4/t2kxio7thOlicVvWnYuIL09qHhisoO0WSfKiDVyhYj
	fCPX/gm0eR91JA4ZeJXuqZwzW2gXvf9EIqeRENDjf3gShhICF3UWTduGvhyq/XB4R/Z+Qb4Yl5j
	1YIhKmGgyQhPluihaKeLrdfkehlaJMZoDndKrB2abzb2Uj/k0Gv/ksLfneBW3aU75+JjMCH3Y3u
	aXHx+kFZ94jYdRoyQ5NrG0HBO/tjrP49ta54gyPbdJulv/AvB8e3wggUSNKkz1MdaFU4wE85nb4
	GYqqY3KRCnRE/NCAuBKjPQRCoQJH+A==
X-Received: by 2002:a05:6102:4420:b0:4e2:aafe:1bde with SMTP id ada2fe7eead31-4f95f2aa5b6mr10332063137.9.1753128058657;
        Mon, 21 Jul 2025 13:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSCxFWg0zr8xQdwwNW6bcMmsA+Ac50KeD1zhx/XIbHSFV4QORRhmfswY4rqEfLSGllo+AYpg==
X-Received: by 2002:a05:6102:4420:b0:4e2:aafe:1bde with SMTP id ada2fe7eead31-4f95f2aa5b6mr10331991137.9.1753128058109;
        Mon, 21 Jul 2025 13:00:58 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b2a976sm445873685a.13.2025.07.21.13.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:00:57 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:00:56 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 17/28] cyclictest.8: Group SMP-related options
In-Reply-To: <20250704132721.13325-18-darwi@linutronix.de>
Message-ID: <471cc3e8-b65e-2d66-3056-d56c168b3922@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-18-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> The number and breadth of cyclictest's options is huge, and just
> exploring them in sequence can get the manpage reader lost.
> 
> Put the cyclictest's SMP-related options:
> 
>        -S, --smp
>        -t, --threads[=NUM]
>        --mainaffinity=CPUSET
>        -a, --affinity[=PROC-SET]
> 
> into their own group.
> 
> Further groupings will be added next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 46 +++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 6ab3b19..7fc0420 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -24,6 +24,10 @@ cyclictest \- High resolution test program
>  .IR wakeup\-usec ]
>  .RB [ \-A\~\c
>  .IR alignment\-usec ]
> +.RB [ \-t\~\c
> +.IR num\-threads ]
> +.RB [ \-\-mainaffinity\~\c
> +.IR proc-set ]
>  .RB [ \-a\~\c
>  .IR proc\-set ]
>  .RB [ \-b\~\c
> @@ -42,14 +46,10 @@ cyclictest \- High resolution test program
>  .IR oscope\-red ]
>  .RB [ \-p\~\c
>  .IR thread\-prio ]
> -.RB [ \-t\~\c
> -.IR num\-threads ]
>  .RB [ \-\-histfile\~\c
>  .IR file\-path ]
>  .RB [ \-\-json\~\c
>  .IR file\-path ]
> -.RB [ \-\-mainaffinity\~\c
> -.IR proc-set ]
>  .RB [ \-\-policy\~\c
>  .IR threads\-sched\-policy ]
>  .RB [ \-\-spike\~\c
> @@ -146,7 +146,24 @@ align thread wakeups to the next full second and apply the optional offset.
>  .B \-A, \-\-align=USEC
>  Align thread wakeups to a specific offset in microseconds
>  .
> -.SS "Other options"
> +.SS "SMP-related options"
> +.
> +.TP
> +.B \\-S, \-\-smp
> +Set options for standard testing on SMP systems. Equivalent to using the
> +options: "\-t \-a" as well keeping any specified priority equal across all
> +threads
> +.
> +.TP
> +.B \-t, \-\-threads[=NUM]
> +Set the number of test threads (default is 1). Create NUM test threads. If
> +NUM is not specified, NUM is set to the number of available CPUs. See \-d,
> +\-i and \-p for further information.
> +.
> +.TP
> +.B \-\-mainaffinity=CPUSET
> +Run the main thread on CPU #N. This only affects the main thread and not
> +the measurement threads
>  .
>  .TP
>  .B \-a, \-\-affinity[=PROC-SET]
> @@ -163,6 +180,8 @@ field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU
>  sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
>  v1, PROC-SET, if specified, must be a single CPU number.
>  .
> +.SS "Other options"
> +.
>  .TP
>  .B \-b, \-\-breaktrace=USEC
>  Send break trace command when latency > USEC
> @@ -204,11 +223,6 @@ for automated tests with a given number of test cycles. Cyclictest is
>  stopped once the number of timer intervals has been reached.
>  .
>  .TP
> -.B \-\-mainaffinity=CPUSET
> -Run the main thread on CPU #N. This only affects the main thread and not
> -the measurement threads
> -.
> -.TP
>  .B \-m, \-\-mlockall
>  Lock current and future memory allocations to prevent being paged out
>  .
> @@ -247,12 +261,6 @@ Print a summary only on exit. Useful for automated tests, where only the
>  summary output needs to be captured.
>  .
>  .TP
> -.B \\-S, \-\-smp
> -Set options for standard testing on SMP systems. Equivalent to using the
> -options: "\-t \-a" as well keeping any specified priority equal across all
> -threads
> -.
> -.TP
>  .B \-\-spike=<trigger>
>  record all spikes > trigger
>  .
> @@ -267,12 +275,6 @@ The default is 1024 if not specified.
>  Enable SMI count/detection on processors with SMI count support.
>  .
>  .TP
> -.B \-t, \-\-threads[=NUM]
> -Set the number of test threads (default is 1). Create NUM test threads. If
> -NUM is not specified, NUM is set to the number of available CPUs. See \-d,
> -\-i and \-p for further information.
> -.
> -.TP
>  .B \-\-tracemark
>  write a trace mark when \-b latency is exceeded.
>  .
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

