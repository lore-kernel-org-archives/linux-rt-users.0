Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E01E5713
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128260; cv=none; b=cRya5cvKfgWS6W2276qAQd2KYOVpqlRe68/7586tIQF4woTgU/7irmMB45nxaQ2qADyNxizguoU1wBJ4+VfBDezNY3gBVVQJrPVHrEEAeiV97fJhy55Ok0ETha7KPaFLrAwOlSCjLbLNTgI5RYwueSWiq1Y/P/geILcbWhYwz4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128260; c=relaxed/simple;
	bh=G9Et1RgVY8f+Dgab1Z7x0N7o6fwExUJf/XL/BWVDdpg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pV0+ACzYvQBFMdmPgaHbGnAGheFPD7o5FEVpqjhG5u+fO9y+7+ha9MN5Jxl7LMVGIXf3aD1wPMwnG8FA5FEXEc2yTyFSTaqj+v98EIT+3PT1N1NuVOU5XOnOJf63uy4OCH9SucRbXjTsAcGN4buZpo0YTP8czYOluacOyhTzF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKUYtpGP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKUYtpGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfOpuQaYgbx2mXZgzwSEosL5vbnbtw4bUOyVIK0/b00=;
	b=XKUYtpGPscJ1LEUMiHQNp6PmV3EvhAJ6x18jE0QEsAi37DF+2kHuoXXQcsXD/mmSrGUYhi
	7p24KP2HZBxC4aGl+6vFM/lLjGrRMtSxLB0YehUFUN71MSijor7HknYJqYZX1DzO3jp5sn
	9SgnSrcI7D79iTeBpv/jJsDZ8O2AwtY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-xoamhBQTPzWrrZd4RwgDAA-1; Mon, 21 Jul 2025 16:04:14 -0400
X-MC-Unique: xoamhBQTPzWrrZd4RwgDAA-1
X-Mimecast-MFC-AGG-ID: xoamhBQTPzWrrZd4RwgDAA_1753128254
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fad8b4c92cso131403356d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128254; x=1753733054;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfOpuQaYgbx2mXZgzwSEosL5vbnbtw4bUOyVIK0/b00=;
        b=Rb0wOL/1RTB2UMbOZMPx+bllh1ZMbzgWegtKsbEEx0LKW8M+eWyLgaQBrnnDxpOPpT
         csyaYX1o82/bz/LJfOczMYT/06DspWa1mPG0IAoBVfnxbOkSrO58eqBcymsaZPkYiElK
         Ss1EDx3c3V66Qrm/FtkyZVOnJS7vSLShfUT/xBQpXVgKjzs40nWyG+tLFRyJ3BYu4UMY
         N1QdrYGKxRc2gVUCEUZGlEDM65gCZQ4pNZPZusmQYkDFDv/y4K/6ejQqSV6jFUbVzEDE
         f5nC35XdXqkelAJt4kJffMfs9bGJrV40Dwdt1uTpZywvk65VRC/fHVGnitHEOXU7n/wl
         a0tA==
X-Gm-Message-State: AOJu0YyXvgMoD+G8iDDZLtufynsWuFHT+PuxwgVPCH+fDDiouojhQ6FP
	ML/bb1DiTROIglysTp4Caum2g9CO4gM8JyeJb134kMYC5t86RfpIKO3cEj9EkwXwU9LeJw6UAqO
	NnOuGpafNtPp8czAwBLJpuH06D7GTqlvdPQm19Ie6W+DQs8K9xnIoTtP7QttF36qpGy8A
X-Gm-Gg: ASbGncuIoH16L6o18nBl558QyrE7WVQZsxIUxHWDReEoKe5PvuoK4svQs3EyLR4b4PN
	7hbYORHFJI/AsB20a9md7sUbbeNqK+nBjLFNs0QUBY9y2FLddMuwHAni17F+85S0pvygm+aNiny
	LoCtHz2EfOUqPV9I6+JJq1W8vasAvYDFuAsdq/x216utPHxqnIeBoG2zZFzYIk1mxyuPFErI1cI
	DPpf5UNgEsEQXUIAHWbWvgZkuvVPyWNS8Q3GVJKR/Xr7u+cU5tPT/fxJ8UUy5GbwcXBAkTP5tUT
	QngSRzfb6KqF/1lqqCEmGmhmQdFymQ==
X-Received: by 2002:a05:6214:1cc3:b0:704:8e16:51e9 with SMTP id 6a1803df08f44-7051a194b9emr220842756d6.45.1753128254399;
        Mon, 21 Jul 2025 13:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQeajH6ljkSAA9Fl9oYxvmw8t4tEjAc8tQFP8qBSpSC9PgvUXHXfAbWb9vnqKer9VbN/mShQ==
X-Received: by 2002:a05:6214:1cc3:b0:704:8e16:51e9 with SMTP id 6a1803df08f44-7051a194b9emr220842266d6.45.1753128253826;
        Mon, 21 Jul 2025 13:04:13 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c8c459sm459264285a.88.2025.07.21.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:04:13 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:04:12 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 21/28] cyclictest.8: Group test duration options
In-Reply-To: <20250704132721.13325-22-darwi@linutronix.de>
Message-ID: <2284a096-d60b-8465-4691-be159e63c0de@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-22-darwi@linutronix.de>
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
> Put the cyclictest's system-altering options:
> 
>        -D, --duration=TIME
>        -l, --loops=LOOPS
> 
> into their own group.  Adjust the Synopsis accordingly as well.
> 
> Further groupings will be added next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 964996f..c2c963c 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -40,14 +40,14 @@ cyclictest \- High resolution test program
>  .RB [ \-\-tracemark ]
>  .RB [ \-D\~\c
>  .IR duration\-mhd ]
> +.RB [ \-l\~\c
> +.IR num\-loops ]
>  .RB [ \-f\~\c
>  .IR fifo\-path ]
>  .RB [ \-h\~\c
>  .IR max\-latency\-usec ]
>  .RB [ \-H\~\c
>  .IR max\-latency\-usec ]
> -.RB [ \-l\~\c
> -.IR num\-loops ]
>  .RB [ \-o\~\c
>  .IR oscope\-red ]
>  .RB [ \-\-histfile\~\c
> @@ -196,7 +196,7 @@ Send break trace command when latency > USEC
>  .B \-\-tracemark
>  write a trace mark when \-b latency is exceeded.
>  .
> -.SS "Other options"
> +.SS "Test-duration options"
>  .
>  .TP
>  .B \-D, \-\-duration=TIME
> @@ -205,6 +205,14 @@ Specify a length for the test run.
>  Append 'm', 'h', or 'd' to specify minutes, hours or days.
>  .
>  .TP
> +.B \-l, \-\-loops=LOOPS
> +Set the number of loops. The default is 0 (endless). This option is useful
> +for automated tests with a given number of test cycles. Cyclictest is
> +stopped once the number of timer intervals has been reached.
> +.
> +.SS "Other options"
> +.
> +.TP
>  .B \-F, \-\-fifo=<path>
>  Create a named pipe at path and write stats to it
>  .
> @@ -229,12 +237,6 @@ Dump the latency histogram to <path> instead of stdout.
>  Write final results into FILENAME, JSON formatted.
>  .
>  .TP
> -.B \-l, \-\-loops=LOOPS
> -Set the number of loops. The default is 0 (endless). This option is useful
> -for automated tests with a given number of test cycles. Cyclictest is
> -stopped once the number of timer intervals has been reached.
> -.
> -.TP
>  .B \\-M, \-\-refresh_on_max
>  Delay updating the screen until a new max latency is hit. (useful for
>  running cyclictest on low-bandwidth connections)
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

