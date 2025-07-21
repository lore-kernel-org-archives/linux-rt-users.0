Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB931E0DD8
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124773; cv=none; b=jIJAtATwSyfxa+Q+n/TOqN3HY9cykxGNaYwU5LOmgsUUJAdx6xTdU4yYAXux7AVjrTpWK2lNN3F+1ponOb+dM8FcvqpqnyZqQJETmN5RlrNn6c2Ev/PnwozaekkaWk70wb2WlGFxhOVUvk93qN+5Jc/u3Vxl9cULszXvB9P3hH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124773; c=relaxed/simple;
	bh=eIkCp2MprQvey0mgrkveJslLJTlpQ58pigSkAumnvmw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iZJlDSLvNU0FfxsK+V4G6MoPbIkr81xRmRoU35LNHgctJd6nBeIrO7jU2S4gjdwvmdtbdpKwe3CtNU82r2Zfhk5td4KADrHW0Idee0hjssA5ORNSsg5UKrRYz+H5GxeLGwh12FTzRNxj05haHYGEcHy1+ZXoJEtOr8LUdWga2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1Xuc0h7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1Xuc0h7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753124770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q49kXbf9pZHSBSYfP7LechvXZVVdp4S0YcsR0o69bJc=;
	b=I1Xuc0h7EeXHOw2J/kknzxMzNj1lyh3eIDDDYV8guk7/gfrTs+b1osDtM+qNM9/6fTeyH7
	sKo21zWaY5jBIaqxo1ORGfW1jMcyTeQK8CrMM9bUKfDh35yhC5tefP/MEbW5Ge5Y3Gekm+
	v+uhEt+s1npUplW8lll3WtJs0WOHpJ8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-5_ysxMvXOr2lfgtMcyEzBw-1; Mon, 21 Jul 2025 15:06:07 -0400
X-MC-Unique: 5_ysxMvXOr2lfgtMcyEzBw-1
X-Mimecast-MFC-AGG-ID: 5_ysxMvXOr2lfgtMcyEzBw_1753124767
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fabd295d12so64865646d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753124766; x=1753729566;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q49kXbf9pZHSBSYfP7LechvXZVVdp4S0YcsR0o69bJc=;
        b=fwGeoIUMBbiybqtwxMeChjDIcMkLupVxstVm6w/SucVIva7qIkF0DCgwOUEg7jhMW9
         uNeKWBauZR11uwuff2kFEX1Mr1MtHa/n1aiFPwROMX+n/NApnReeGvDJ7tZT71XthzrK
         EV2DLYxteGTXn5eihzsO5VDwSayNwh/jkPjyfZOgt5ytVSwczZ5xqe47Fwp4UAxxxSCH
         Ll3VCL+Oj80ZuZFs3zJTfYYvaCwekeHmYcjZzjhrPCaIRIAGUeDB907rx+0CM9MYlt85
         Rc0GSam5qIX8KxZ3cwsZNcKkchH1t2dNaJzbK6l5mAbxobVZU1w1skhvR8pfaxAw2HYM
         wpAg==
X-Gm-Message-State: AOJu0Yze6sTJhN1BCsSHF83JKu2XnHvazoHVuxHh9kZuhi01gRKVLkId
	0q1w5Q3d/w2AGz2jYIWzF5cog7jY0tZObADx0+4kgllgoEUqNs88OpEgOrYg/w2rsiR3FqNtYNl
	2J8fkXAiK+bEb8gD45Lc63Wa2G553qIZZKiFmR7bJf8wfJI/uLROIyjJujNOI9rkJuyWAqJt9uZ
	ZV
X-Gm-Gg: ASbGncst0B+8QLEWclWLNHFd+lgq3Yo9EYIXqncM11lCK/LNpYdoVmvSbZgTRnbMe/d
	3CIoVTnwvqiMqFNkgQgUuuSImUoYRzF17Nd6XAHNCueGm/iriOh1IyXO37S8opGhA04tTSwSgVM
	RhwhBBSSJ/II5OexnAr835OaP4x6eiTyTv9t7Li+GEFquiZPXH/ORavpWF+p69QyH1an+iNtHrd
	ts9cCzJNrV9HNPd+IKgjCiBAg5Y3CxKIU+Pqwiq4En+CHZZ3rXNAJTnJgMq13MAZ/Gr71t1/gMw
	YaUvOlvRPASP6BwWgSQ3Mby+IedaGA==
X-Received: by 2002:ad4:5f46:0:b0:704:8afa:250c with SMTP id 6a1803df08f44-704f48364c2mr293243906d6.15.1753124766055;
        Mon, 21 Jul 2025 12:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqwwb6oXNq+Qbhbjp5U6Lmt+X0HXNsRlsotPcD2q0uUrAn9t6dPRl5+aOjB8q7dmebCxvfNw==
X-Received: by 2002:ad4:5f46:0:b0:704:8afa:250c with SMTP id 6a1803df08f44-704f48364c2mr293243546d6.15.1753124765638;
        Mon, 21 Jul 2025 12:06:05 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b02dsm41765526d6.63.2025.07.21.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:06:05 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:06:04 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 06/28] cyclictest.8: Standardize --verbose paragraph
 formatting
In-Reply-To: <20250704132721.13325-7-darwi@linutronix.de>
Message-ID: <5f7d033c-f2dc-8ec1-4461-7232335e6fc9@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-7-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> All of cyclictest's options are described in the manpage through a single
> paragraph except --verbose, which renders the verbose statistics output
> format in a separate paragraph for no special reason.
> 
> Let the description text of --versbose match the other parameters style.
> Beside consistency, this will also be useful when all the options will be
> separated at the manpage source level.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index c1a7b29..803c5fd 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -170,11 +170,10 @@ write a trace mark when \-b latency is exceeded.
>  force unbuffered output for live processing
>  .TP
>  .B \-v, \-\-verbose
> -Output values on stdout for statistics. This option is used to gather statistical information about the latency distribution. The output is sent to stdout. The output format is:
> -
> -n:c:v
> -
> -where n=task number c=count v=latency value in us.
> +Output values on stdout for statistics. This option is used to gather
> +statistical information about the latency distribution. The output is sent
> +to stdout. The output format is: "n:c:v", where n is the task number, c is
> +the count, and v is the latency value in microseconds.
>  .TP
>  .B \-\-dbg_cyclictest
>  Print info userful for debugging cyclictest
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

