Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8F2AD0F
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127982; cv=none; b=H6INHY9nTDS+iGOfPGw7+gelSMwWSrTrhqPUNhSQ/W4bAWg9FYnl9Rw0c/sdOQa7ZkiNxxfoeZZ0JRqqbeA8yewWbWdOdHW0jF68d1//bHAHb6BPgQ5HfPgzeOIhfuI7xwA5FMWDO/z4A8LuVAzN1azZiXJegu+2SeHvhxNij4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127982; c=relaxed/simple;
	bh=NCjPKVEBsgZCvm2D6wz/PRZ99t8NlAvbSJy19agMJ/Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cf6AkPlhzv5GgI2Qi12aSePaZGBp7NEsqf5Vfq43/6sGTE3C9XMk5TnCkc8MWCHAvMkxD7DIWtboWGRwF6EFfm981IuZDutBk3CctFvH9wseaYrY19CuSPmcmE3uJwM1QOBmz4IR58mYM2pvyGnPtdEuqcAiV0mUU93hfj/sqZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvc//ars; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvc//ars"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753127978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Srb/9w4to3fQLFLlMW6+RxYFRe5VevRKj1Nk+Zh2eAg=;
	b=cvc//ars+Mb6gO9gPjFDkFQeU24sj4+pDRz2NRV9fEXNoOdiuKKH7//tED2yQIiF+XhSjT
	X5wjiBnMMtWgIZNjy2QOWLAIidUMVDkmXbdNJqUVsjz6ivCTzFO2ClC8t7T6LakdfeWfr/
	oxrxE0WeNKH6FRcmNqoB4nJknYLLuvw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-d_h2e4dPOC-i9mggsStrPQ-1; Mon, 21 Jul 2025 15:59:37 -0400
X-MC-Unique: d_h2e4dPOC-i9mggsStrPQ-1
X-Mimecast-MFC-AGG-ID: d_h2e4dPOC-i9mggsStrPQ_1753127976
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab5d2f4f29so85876731cf.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753127976; x=1753732776;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Srb/9w4to3fQLFLlMW6+RxYFRe5VevRKj1Nk+Zh2eAg=;
        b=u3mEqngTYs8KhTPgdxFetCC5vk4vs9ocii9nnJvDglgmrOzKMN6IvxJ7juSfxi1eOm
         ObMr5uG5QPu63jv1VWUGQMb3BTkizzlwVxKKLi2JWINp2og9USGblJkf76WnzpJaSHAl
         7A5ATK1c85yRoE176fMIAnQuH0sTTAV2t0LU8gkOzrDD3+awGFMVt/Z2VS7qjRoHQ3dD
         SVvm4eNADVFZSjhvHaV8CPJU6+/NEN0OggmugtnMQy62Jw1++ahAHKJf47WfSrZ3sjBu
         dgpRYUg010UfCJ1mxgA/uqJHtQXC/uGXgvqz3Zm25rDsZwSQv1dYIUmhFJugMxZUOsxy
         5CbA==
X-Gm-Message-State: AOJu0Yy2WUqfh5qYFRvWl0cJln2BJ7tLUwXaO4MXc3XV50nOgME+6XqX
	XQ73vweWjCb+S2Yd+G6o5u4OFuFEit+TXHFaMSsZGIQAy45r5oB7f/zSRBPI+kbSdVQZbSJIq+/
	MweH5Udbc7jm2GbVG3fIiettI8maXPeIFnLgh4t/oej3M+CBovTN+ol+f1AnT9tsQWtUS
X-Gm-Gg: ASbGncuArw+fwDgYXhYEgvAnJsMKL7yxJerLY+0MRaogykltNrKEzvlqNorzGphYMZP
	OoFcwerom0mx7rYc5zxGKm+iAIJg5v6n51a86ZzFqTK30t6kxNfS0yOoi+FvUL7XoFIh3VW4IIm
	Q/8LvA0eMEt45c/qvo4pCdPmUp6QF3M7QtFXgyXmu/vsHvS5XtzmS4i6s3o8gNh06L2yz+cm32t
	l9U6+ikUJiUtsdO2ogQuR7UuJmxrKhH0WEZ+6UiPoWjLkRMHtnUUdqXK7Bgl78VEWhkJ57qbCdx
	YYS+nYeJGoYOCv538Zd/sDKEegZyHg==
X-Received: by 2002:ac8:5a53:0:b0:4ab:65c3:37d9 with SMTP id d75a77b69052e-4aba3d9620cmr225459771cf.33.1753127976397;
        Mon, 21 Jul 2025 12:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC66CqAMXY2dUVV3jiG2Cy1z3CX9fXtcmI/SuNd6dgYIXmcj2JvEs06qGngaC0b09e2scYkA==
X-Received: by 2002:ac8:5a53:0:b0:4ab:65c3:37d9 with SMTP id d75a77b69052e-4aba3d9620cmr225459351cf.33.1753127975689;
        Mon, 21 Jul 2025 12:59:35 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb497fb35sm44427541cf.15.2025.07.21.12.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:59:35 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:59:34 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 15/28] cyclictest.8: Group sleep-mechanism (clock)
 options
In-Reply-To: <20250704132721.13325-16-darwi@linutronix.de>
Message-ID: <8779fde7-7f0a-3844-df72-aeb6a0473bc7@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-16-darwi@linutronix.de>
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
> Put the cyclictest's sleep-mechanism related options:
> 
>        -c, --clock=CLOCK
>        -x, --posix_timers
>        -s, --system
>        -r, --relative
>        -R, --resolution
> 
> into their own group.  Adjust the Synopsis accordingly as well.
> 
> Further groupings will be added next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 66 +++++++++++++++++++------------------
>  1 file changed, 34 insertions(+), 32 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 0bc2fc1..eb7d713 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -14,14 +14,14 @@ cyclictest \- High resolution test program
>  .IR pm\-c\-state ]
>  .RB [ \-\-deepest\-idle\-state\~\c
>  .IR idle-state-num ]
> +.RB [ \-c\~\c
> +.IR clock\-type ]
>  .RB [ \-a\~\c
>  .IR proc\-set ]
>  .RB [ \-A\~\c
>  .IR alignment\-usec ]
>  .RB [ \-b\~\c
>  .IR break\-usec ]
> -.RB [ \-c\~\c
> -.IR clock\-type ]
>  .RB [ \-d\~\c
>  .IR distance\-usec ]
>  .RB [ \-D\~\c
> @@ -95,6 +95,38 @@ cpus.
>  Save battery when running cyclictest. This will give you poorer realtime
>  results, but will not drain your battery so quickly.
>  .
> +.SS "Sleep-mechanism clock options"
> +.
> +.TP
> +.B \-c, \-\-clock=CLOCK
> +select clock
> +.br
> +0 = CLOCK_MONOTONIC (default)
> +.br
> +1 = CLOCK_REALTIME
> +.
> +.TP
> +.B \-x, \-\-posix_timers
> +Use POSIX timers instead of clock_nanosleep.
> +.
> +.TP
> +.B \-s, \-\-system
> +Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s
> +can only be used with one thread because itimers are per process and not
> +per thread. \-s uses the nanosleep syscall and is not restricted to one
> +thread.
> +.
> +.TP
> +.B \-r, \-\-relative
> +Use relative timers instead of absolute. The default behaviour of the tests
> +is to use absolute timers. This option is there for completeness and should
> +not be used for reproducible tests.
> +.
> +.TP
> +.B \-R, \-\-resolution
> +Check clock resolution, calling clock_gettime() many times. List of
> +lock_gettime() values will be reported with -X
> +.
>  .SS "Other options"
>  .
>  .TP
> @@ -121,14 +153,6 @@ Align thread wakeups to a specific offset in microseconds
>  Send break trace command when latency > USEC
>  .
>  .TP
> -.B \-c, \-\-clock=CLOCK
> -select clock
> -.br
> -0 = CLOCK_MONOTONIC (default)
> -.br
> -1 = CLOCK_REALTIME
> -.
> -.TP
>  .B \-d, \-\-distance=DIST
>  Distance of thread intervals in us, default = 500
>  .
> @@ -217,28 +241,10 @@ Print a summary only on exit. Useful for automated tests, where only the
>  summary output needs to be captured.
>  .
>  .TP
> -.B \-r, \-\-relative
> -Use relative timers instead of absolute. The default behaviour of the tests
> -is to use absolute timers. This option is there for completeness and should
> -not be used for reproducible tests.
> -.
> -.TP
> -.B \-R, \-\-resolution
> -Check clock resolution, calling clock_gettime() many times. List of
> -lock_gettime() values will be reported with -X
> -.
> -.TP
>  .B \-\-secaligned [USEC]
>  align thread wakeups to the next full second and apply the optional offset.
>  .
>  .TP
> -.B \-s, \-\-system
> -Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s
> -can only be used with one thread because itimers are per process and not
> -per thread. \-s uses the nanosleep syscall and is not restricted to one
> -thread.
> -.
> -.TP
>  .B \\-S, \-\-smp
>  Set options for standard testing on SMP systems. Equivalent to using the
>  options: "\-t \-a" as well keeping any specified priority equal across all
> @@ -283,10 +289,6 @@ the count, and v is the latency value in microseconds.
>  .B \-\-dbg_cyclictest
>  Print info userful for debugging cyclictest
>  .
> -.TP
> -.B \-x, \-\-posix_timers
> -Use POSIX timers instead of clock_nanosleep.
> -.
>  .SH "See also"
>  .BR numa (3),
>  .BR numactl (8),
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

