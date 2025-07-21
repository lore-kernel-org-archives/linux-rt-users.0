Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B4EAC6
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128297; cv=none; b=HLVhQ7qoVRv5QtFel15bsCnoEd7uwNZcgqEMHaeL0E0UvFA9h4YeF8K2CE9IJSsqAns0uqw0zl0tAiRkMk6BO3jyyDR2COcmIndjXD/DcUVAohS6DiaH+GgMO0E+FkkAHGBQ1Hs+JsdHdZO2u9xq/K0oOps2J/NSN4GvabgOfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128297; c=relaxed/simple;
	bh=AgzPYg35euVYpIiN9zE1z3EJ6VMCHAlDkBiJ7CeRbrE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UZKf5V1fVQNcKfvgR86kQV1jBiUQTmDzkfAuA5n6u6Io+cWSuaW18F7twMPTLQUdSGjQj0FltRUgGgMPXLxFx0kdMVyEV1gjNvEaFkagqtsY+SO5nymSqTf4jZp2goxXvEcP1HgypAxI8fCjinNo2JjFBaVLMspimSp8kcbIMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CB/qDSRt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CB/qDSRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iE0kL416JCpxCySoQRKtQ4+GT63JsMCwRJOaasiVZVE=;
	b=CB/qDSRtw5AHBoNdziuxkOTGVyaxC6xGBxQxeQCvkCVFnbT/fQyz/rpt6VIuWdoHrxTyx/
	kebLoWE9fq4bjevxxZQbR+18bUzcivQxif9W1WSxAxYErJCRrWP9VcTZxtgcMIvIYUw2fV
	UK6ZYXHRbJZSrENeILmscdmi0nZa4h0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-gkZqwmvwM3GkNmk0VlnNgg-1; Mon, 21 Jul 2025 16:04:53 -0400
X-MC-Unique: gkZqwmvwM3GkNmk0VlnNgg-1
X-Mimecast-MFC-AGG-ID: gkZqwmvwM3GkNmk0VlnNgg_1753128293
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5cd0f8961so876322485a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128293; x=1753733093;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iE0kL416JCpxCySoQRKtQ4+GT63JsMCwRJOaasiVZVE=;
        b=o6HCwPwMG4HEpbtb+fk1fPwHFjzwnuVPLrsNt6dNi0KciJOvfIY1e2PG653j8GAVJK
         33M1pLfiJ0TWAkc+5ORaPVUkInXh2B3pmIXsuc1QT2jciWLoAKMbYy1Qe3SM9ZKKMEfm
         pQfhwcR/a8E8islfu0pkWbCGKYUluJ1g8ic+VGuGZIo2x6kqWcQ3zX5FIGap/L/sHHYV
         OR3UQIp3/YEwlAmuROB6d6ela+Mp7oN2ALebaGonOOEYehngFzWYO7mLd1hDGpWkmEnC
         Sq5zQP63lwlQmmY/Is6/vznSR211P7n6PFP4Jf0DF0eYcuaF11VNvDBJDdqfivYeBuG5
         BcLg==
X-Gm-Message-State: AOJu0Yy0vbC7GXRtAsq/cTQ79xCo/jIrQ5p9n+rKGPtKUvu0OmzLTS+h
	nVNUnbWLPwgLwZbNXwVWchZ/rvjftjcWIhqdciTNghJ4SU8CLqJ2h7Iv3KhEr+7I3PVQx3WFKEq
	tWktPwHQlsienIbNjvS4qM20QtjRj7p+RmSMUhGiMJn+6bnogfjHTIJfHL1zTVRz7NHap8LoaoN
	Cf
X-Gm-Gg: ASbGncu05gYgids7ppUjZcRV2bVDV5c9W2HKkOvXRHtpoMkuCi+tDgVe4BdeDbnAxge
	my4U6jhvVIvPenKv6TezH/47jm2vGYOdiKuO84iPZIjuj0Ji8hxyFPg/6Y3e/l5VhRySusa3aFm
	ofH4EzQPc8bRM5y+PNh2x25P1+9uKJrw18orhQpxbSRqE0hlGiPlUVyH+IvPNWSUZ4GUzPaI0dP
	7JrBkbkn9MfYv+e81i1sUCQTS2xber3fcjR1XsyEIDx0u1fMz1G3aVjkzgW6rg37pjU1TfxxQ/h
	Sp3VF4XLCLijSQgkrJXWE74nwnzL/A==
X-Received: by 2002:a05:620a:458f:b0:7e1:ad94:af7c with SMTP id af79cd13be357-7e3435eb369mr2785574185a.29.1753128292839;
        Mon, 21 Jul 2025 13:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUuAjnKomxokbwhcqgAvEH5PSwjdaN/AA6XotGgBFZfcD6QSFtVCEb5cXKhXKR+FwZ96dFlA==
X-Received: by 2002:a05:620a:458f:b0:7e1:ad94:af7c with SMTP id af79cd13be357-7e3435eb369mr2785570485a.29.1753128292323;
        Mon, 21 Jul 2025 13:04:52 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c43308sm449945885a.64.2025.07.21.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:04:51 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:04:50 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 22/28] cyclictest.8: Group output options
In-Reply-To: <20250704132721.13325-23-darwi@linutronix.de>
Message-ID: <7b0bfe39-209c-9de1-7bf1-287574aa76d7@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-23-darwi@linutronix.de>
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
> Put the cyclictest's output options:
> 
>        --dbg_cyclictest
>        -o, --oscope=RED
>        -F, --fifo=<path>
>        -h, --histogram=US
>        -H, --histofall=MAXLATENCYINUS
>        --spike=<trigger>
>        --spike-nodes=[num of nodes]
>         --histfile=<path>
>        --json=FILENAME
>        -M, --refresh_on_max
>        -N, --nsecs
>        -q, --quiet
>        -u, --unbuffered
>        -v, --verbose
> 
> into their own group.  Adjust the Synopsis accordingly as well.
> 
> Further groupings will be added next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 58 +++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 28 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index c2c963c..ca75884 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -42,23 +42,23 @@ cyclictest \- High resolution test program
>  .IR duration\-mhd ]
>  .RB [ \-l\~\c
>  .IR num\-loops ]
> +.RB [ \-\-dbg_cyclictest ]
> +.RB [ \-o\~\c
> +.IR oscope\-red ]
>  .RB [ \-f\~\c
>  .IR fifo\-path ]
>  .RB [ \-h\~\c
>  .IR max\-latency\-usec ]
>  .RB [ \-H\~\c
>  .IR max\-latency\-usec ]
> -.RB [ \-o\~\c
> -.IR oscope\-red ]
> -.RB [ \-\-histfile\~\c
> -.IR file\-path ]
> -.RB [ \-\-json\~\c
> -.IR file\-path ]
>  .RB [ \-\-spike\~\c
>  .IR trigger\-point-usec ]
>  .RB [ \-\-spike\-nodes\~\c
>  .IR num\-nodes ]
> -.RB [ \-\-dbg_cyclictest ]
> +.RB [ \-\-histfile\~\c
> +.IR file\-path ]
> +.RB [ \-\-json\~\c
> +.IR file\-path ]
>  .RB [ \-\-smi ]
>  .YS
>  .
> @@ -210,7 +210,15 @@ Set the number of loops. The default is 0 (endless). This option is useful
>  for automated tests with a given number of test cycles. Cyclictest is
>  stopped once the number of timer intervals has been reached.
>  .
> -.SS "Other options"
> +.SS "Output options"
> +.
> +.TP
> +.B \-\-dbg_cyclictest
> +Print info userful for debugging cyclictest
> +.
> +.TP
> +.B \-o, \-\-oscope=RED
> +Oscilloscope mode, reduce verbose output by RED.
>  .
>  .TP
>  .B \-F, \-\-fifo=<path>
> @@ -229,6 +237,16 @@ right that contains summary data of all thread histograms. If cyclictest
>  runs a single thread only, the -H option is equivalent to -h.
>  .
>  .TP
> +.B \-\-spike=<trigger>
> +record all spikes > trigger
> +.
> +.TP
> +.B \-\-spike-nodes=[num of nodes]
> +These are the maximum number of spikes we can record.
> +.br
> +The default is 1024 if not specified.
> +.
> +.TP
>  .B \-\-histfile=<path>
>  Dump the latency histogram to <path> instead of stdout.
>  .
> @@ -247,29 +265,11 @@ Show results in nanoseconds instead of microseconds, which is the default
>  unit.
>  .
>  .TP
> -.B \-o, \-\-oscope=RED
> -Oscilloscope mode, reduce verbose output by RED.
> -.
> -.TP
>  .B \-q, \-\-quiet
>  Print a summary only on exit. Useful for automated tests, where only the
>  summary output needs to be captured.
>  .
>  .TP
> -.B \-\-spike=<trigger>
> -record all spikes > trigger
> -.
> -.TP
> -.B \-\-spike-nodes=[num of nodes]
> -These are the maximum number of spikes we can record.
> -.br
> -The default is 1024 if not specified.
> -.
> -.TP
> -.B \\-\-smi
> -Enable SMI count/detection on processors with SMI count support.
> -.
> -.TP
>  .B \-u, \-\-unbuffered
>  force unbuffered output for live processing
>  .
> @@ -280,9 +280,11 @@ statistical information about the latency distribution. The output is sent
>  to stdout. The output format is: "n:c:v", where n is the task number, c is
>  the count, and v is the latency value in microseconds.
>  .
> +.SS "Other options"
> +.
>  .TP
> -.B \-\-dbg_cyclictest
> -Print info userful for debugging cyclictest
> +.B \\-\-smi
> +Enable SMI count/detection on processors with SMI count support.
>  .
>  .SH "See also"
>  .BR numa (3),
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

