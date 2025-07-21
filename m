Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E142236E3
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128034; cv=none; b=IDRyHtvkkMO4AnCGv0Q4OxpbWasC9sD54R5H+YHAkdxMUVEOMf767IssND3DINFSzLT3xuvNeL3PyFPzqu19FjRt1Vzyg3bpwr2VO1VmyWzP6AIBZxPEDxeBOnbd5LBYbbwInmW5WOtFxMNtpAxpH4l3P6uIcaE4QhnEGnZYpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128034; c=relaxed/simple;
	bh=KwziMPjQ/x7zsO5xZA1juGeaj3PhOhhRLkchvgkvNKY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a+1HFT3frgR9aHwjthSSm7BhXPFY8SXH9ARkAm2PdIa1DulqP1InAtToX45+1DF0TBuz0y3WRysTUqBtqrJu5wkvj2aoC4G/tuf/s72xXED3+L1uPCWbtL/yRONbOtlM79XK9Hmr0ly27AIxNIiiwbhSJSg6Z+oOJELmorszzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8Saf57N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8Saf57N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c0RnBRlVeLE7N/rSGffV0dCc8SJZhf1J85lwqeOx16A=;
	b=C8Saf57NUeLGOu9/Z8m1wqeIgyAgbpqKd0B10VC0fCs2hju+BLxIRuNLTMCtcTrze5jZvd
	+n6DhkH2x5H7DpRbfzBavtXTlnhrWaRhLC5QAabWuxdFUz2gnsIDz8r77gzTDeKLI8G9Sd
	RoQnAJITD8xTPIfrrMJ/WBGWZcuU+rI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-sHdL_ULxP2mmWeUphbEmJQ-1; Mon, 21 Jul 2025 16:00:27 -0400
X-MC-Unique: sHdL_ULxP2mmWeUphbEmJQ-1
X-Mimecast-MFC-AGG-ID: sHdL_ULxP2mmWeUphbEmJQ_1753128027
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e06402c7daso691556885a.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128027; x=1753732827;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0RnBRlVeLE7N/rSGffV0dCc8SJZhf1J85lwqeOx16A=;
        b=wl47B1NGJ4XkGHrIkKWDHKhf8a0LwSlDnSZhAHvaYiDF+nrwimCD7O9WIJV/K0UQ2V
         +6ciqDbM1xBrOXZB8QJdhPIOVsQd2CSnW4FI693O34nxm0KTm70P65Y2+2IcFsLPfKgL
         GEBEMOCJF88sYdX/MpW2daYWkCHsXv8XhMHCSZ+thjGiaVh3AYRxBNRn5MRBr1Mu9P27
         ONUwxDRLWzYkMoYw6LsNu88J/UpGqBc+CKOViugbu8YCrh8PVEA1E9AZPtnyUibZcYba
         G5pLmS9wW/QdBu1xvyB2PYEeXEj5+ArY5L/SbMqhAlBZhevrTv2bo2Cloi57VUs5DdGX
         f6Fg==
X-Gm-Message-State: AOJu0YywkCqPvtHqTzjv0eiy4uF30u3loTDC25I3+juyya0RqCRdq8It
	5fxmwSCAI1LTgbzIcdDxBa7pDe6LinnGGqCgKHnh327+VNVjNpuL14Svi+FQVrSXJZ71vxxx7ma
	r/cTBTB0WFmElIlG7u0fJJdlTYra8R1SqFonom3Apwkp3mW6o1bnTxWHownhSBS9Y1SbuNHb2bw
	/Z
X-Gm-Gg: ASbGnct6GiDXCZfX4Xzw0aESEzoSi0IxW54HVddaQ9CxRwX8vgbjw43rX71pKkM1gI+
	EY72j/4+RgzuqcdAeGKGUvN9QYQj1b7Wu3DBSHkC1fK4YL3eC0pw5RI2mpx2Wk08F0cA1MeO8Wo
	xPWAV6PXOVJ8cRIF5fMfc+edcX9nHruhRWUZdOrAzD/Tm2xlVc+mP5Y455emoAuTQ32FBfXepQb
	PyTqSSUuys33NLbvVAeNQ/aoeOurgdKlH2C+cIOO4/tNbpBY8WEJSkEUvPwLHDTa2wXvbfo1dyE
	mRhpTCXXuRnshCUCgC4cDvylTEYv8Q==
X-Received: by 2002:a05:620a:192a:b0:7d5:e432:2d91 with SMTP id af79cd13be357-7e342b8a269mr2924509185a.49.1753128026817;
        Mon, 21 Jul 2025 13:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZVKlwLFRyb5aAP5HMdvYNndnVLaYz3XNTES1JJbb67cL5o0Ylp3Ue3sqPxj//uLZmtnMdIA==
X-Received: by 2002:a05:620a:192a:b0:7d5:e432:2d91 with SMTP id af79cd13be357-7e342b8a269mr2924502285a.49.1753128026194;
        Mon, 21 Jul 2025 13:00:26 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356cc1aa8sm449049885a.111.2025.07.21.13.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:00:25 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:00:24 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 16/28] cyclictest.8: Group thread wakeup timing
 options
In-Reply-To: <20250704132721.13325-17-darwi@linutronix.de>
Message-ID: <8819a936-d049-7d0b-1073-a19a9b44b0d2@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-17-darwi@linutronix.de>
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
> Put the cyclictest's thread-wakeup timing options:
> 
>        -d, --distance=DIST
>        -i, --interval=INTV
>        --secaligned [USEC]
>        -A, --align=USEC
> 
> into their own group.  Adjust the Synopsis accordingly as well.
> 
> Further groupings will be added next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 52 +++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index eb7d713..6ab3b19 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -16,14 +16,18 @@ cyclictest \- High resolution test program
>  .IR idle-state-num ]
>  .RB [ \-c\~\c
>  .IR clock\-type ]
> -.RB [ \-a\~\c
> -.IR proc\-set ]
> +.RB [ \-d\~\c
> +.IR distance\-usec ]
> +.RB [ \-i\~\c
> +.IR interval\-usec ]
> +.RB [ \-\-secaligned\~\c
> +.IR wakeup\-usec ]
>  .RB [ \-A\~\c
>  .IR alignment\-usec ]
> +.RB [ \-a\~\c
> +.IR proc\-set ]
>  .RB [ \-b\~\c
>  .IR break\-usec ]
> -.RB [ \-d\~\c
> -.IR distance\-usec ]
>  .RB [ \-D\~\c
>  .IR duration\-mhd ]
>  .RB [ \-f\~\c
> @@ -32,8 +36,6 @@ cyclictest \- High resolution test program
>  .IR max\-latency\-usec ]
>  .RB [ \-H\~\c
>  .IR max\-latency\-usec ]
> -.RB [ \-i\~\c
> -.IR interval\-usec ]
>  .RB [ \-l\~\c
>  .IR num\-loops ]
>  .RB [ \-o\~\c
> @@ -50,8 +52,6 @@ cyclictest \- High resolution test program
>  .IR proc-set ]
>  .RB [ \-\-policy\~\c
>  .IR threads\-sched\-policy ]
> -.RB [ \-\-secaligned\~\c
> -.IR wakeup\-usec ]
>  .RB [ \-\-spike\~\c
>  .IR trigger\-point-usec ]
>  .RB [ \-\-spike\-nodes\~\c
> @@ -127,6 +127,25 @@ not be used for reproducible tests.
>  Check clock resolution, calling clock_gettime() many times. List of
>  lock_gettime() values will be reported with -X
>  .
> +.SS "Thread-waekup timing options"
> +.
> +.TP
> +.B \-d, \-\-distance=DIST
> +Distance of thread intervals in us, default = 500
> +.
> +.TP
> +.B \-i, \-\-interval=INTV
> +Set the base interval of the thread(s) in microseconds (default is
> +1000us). This sets the interval of the first thread. See also \-d.
> +.
> +.TP
> +.B \-\-secaligned [USEC]
> +align thread wakeups to the next full second and apply the optional offset.
> +.
> +.TP
> +.B \-A, \-\-align=USEC
> +Align thread wakeups to a specific offset in microseconds
> +.
>  .SS "Other options"
>  .
>  .TP
> @@ -145,18 +164,10 @@ sets.  * Support for CPU sets requires libnuma version >= 2.  For libnuma
>  v1, PROC-SET, if specified, must be a single CPU number.
>  .
>  .TP
> -.B \-A, \-\-align=USEC
> -Align thread wakeups to a specific offset in microseconds
> -.
> -.TP
>  .B \-b, \-\-breaktrace=USEC
>  Send break trace command when latency > USEC
>  .
>  .TP
> -.B \-d, \-\-distance=DIST
> -Distance of thread intervals in us, default = 500
> -.
> -.TP
>  .B \-D, \-\-duration=TIME
>  Specify a length for the test run.
>  .br
> @@ -183,11 +194,6 @@ runs a single thread only, the -H option is equivalent to -h.
>  Dump the latency histogram to <path> instead of stdout.
>  .
>  .TP
> -.B \-i, \-\-interval=INTV
> -Set the base interval of the thread(s) in microseconds (default is
> -1000us). This sets the interval of the first thread. See also \-d.
> -.
> -.TP
>  .B \-\-json=FILENAME
>  Write final results into FILENAME, JSON formatted.
>  .
> @@ -241,10 +247,6 @@ Print a summary only on exit. Useful for automated tests, where only the
>  summary output needs to be captured.
>  .
>  .TP
> -.B \-\-secaligned [USEC]
> -align thread wakeups to the next full second and apply the optional offset.
> -.
> -.TP
>  .B \\-S, \-\-smp
>  Set options for standard testing on SMP systems. Equivalent to using the
>  options: "\-t \-a" as well keeping any specified priority equal across all
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

