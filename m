Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A61A23B5
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127767; cv=none; b=C8/S5kKQVRvC8vp72ptKlWh8epdW7YXG6VCkSqgGOJw8aTAev9wnMYkYxXNo2pBVroqu3DotPjj3N9NM0TIRjFy/07YQoQ1EQfR+lxTiidp1bzwMUfpq4WDN6DMURLUPbvmbVyawNE0u71sKib6WmCgJxHqv8utf8gBmrh9QzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127767; c=relaxed/simple;
	bh=U7TxGc76lZWSedfAEn2dd3yN5KUl0vXZtasrLk9P/10=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h9uNA+qRHRI84jwmeWlgf9HeevGW3UBDvgWM4YlBcnxP2jf8vQUzs6tT8mWLM5umYB2n5IUV2yWXZ6SZ1jrnUQmnP2snzaDQUHV8WeQtol+E6u00RZdHzk3ehoCVMfJrrS3cFVYwxqP3OVCBsqoxeU6w7x+yzitA0QtQbNsKOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClVbVwRP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClVbVwRP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753127764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fPpNK2H+nbXLIQCpYNOrXvg9GJ5RfENl1/ygvFuj5oM=;
	b=ClVbVwRP6NZEOi87SU9esBANbMW7Vl0pQuU8SvDgfDblfYM2kUuNLzdxv8p8NNzgX1Ww4L
	WqUKx7wg7ZwHw+IeEi13peSrT/AaOnLZSPJmHKL0E3e1RdYXBArl7KyvdEYXHrPMms3v1F
	EgyB07u6Jwhv9FBq4nWqpHsoSv2SOGs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-mnbfaIhzPBKfU3-EVyA1Ow-1; Mon, 21 Jul 2025 15:56:02 -0400
X-MC-Unique: mnbfaIhzPBKfU3-EVyA1Ow-1
X-Mimecast-MFC-AGG-ID: mnbfaIhzPBKfU3-EVyA1Ow_1753127762
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fad2a25b65so79497216d6.3
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753127762; x=1753732562;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPpNK2H+nbXLIQCpYNOrXvg9GJ5RfENl1/ygvFuj5oM=;
        b=Tsf/R0tIQ1ar1l8GPxphSilDWUSMLec7puu2W2sfAYFTo/v9j5jfE5YjJ76KHsexaK
         TVHFgGeM1IsA+M0s+VHEfy14kFeaHRH/ahtCqqyWmtt6OuIRe8OsLeI6kKrZkXVwmXj+
         9m3hqbKZS6fVa/tDEKgbWwOvN7yzJKpFL6XvM7a21p/Xh9IXavbyBgXWyaILp2o+424r
         /3Td/aZgbPXnvfsN4QiW5SwELL0s4Neve0P4Q976C6trmjF95A4zA6N/32JoBm0PTpRZ
         vaPpPF9o48PXtUKPZD/LbKbQfTgfMP8iksqi7L0+8CP/NNu7aKuYjnzCglteP03Ob7oW
         DicQ==
X-Gm-Message-State: AOJu0Yy8Uo2KESg1TxAxgtLHzQBWxEjNQ7B+MeSFVKrZ4sym9v9EIpqb
	S34DeYQveTysqVped7RLXie3p3jfUUho2SDRnyl6rvoXVcgTvdIRdR5JXpMkeqNP8x39apYjOsx
	29HkRSU2x+f15D50rl2CX3UMLChguwrBm9lSYRn27TPTf2YCMzg8IXaUkfmVAhSPTrbZ5
X-Gm-Gg: ASbGncunbGmHCh2QtsViB5bkeVbOblp7Y7HVQkjXAmh1o8rKeWcbbVyXIS02/H4JJRM
	Z19SRv8AhHo2gfltgpRV5P6ruaYTygWELwT49eu7+NbqMmx+cOASp/6BYWWX4ca9K0zqBcN4xsd
	B1dPidqWnYnnLLPdZfv6Hbl7mX1AIBt7X/Z8ZaQ/2PTv3Iv+DILFKXWfuryuFLYepe1lVpfxugK
	YcaSshKB8hZluB1LWX+Zk8OKf14rDZlS/Io/8Qg2E5NOlBargv8i7Cr7C5odAAqJ7lJ7td845Vi
	RgHjvVkdUaDIGxJXG9q2FzlTmrqw/Q==
X-Received: by 2002:a05:6214:5d0f:b0:702:d822:9381 with SMTP id 6a1803df08f44-704f6a6ba4fmr364942666d6.19.1753127762336;
        Mon, 21 Jul 2025 12:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQHPN4l8TFBFlJBmOFCRduP4OPOclTBCyjLTM4IUo5++nJzHNr237xQXzOvdk1Kcg72QvALg==
X-Received: by 2002:a05:6214:5d0f:b0:702:d822:9381 with SMTP id 6a1803df08f44-704f6a6ba4fmr364942436d6.19.1753127762011;
        Mon, 21 Jul 2025 12:56:02 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70692e593f2sm32224196d6.21.2025.07.21.12.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:56:01 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:56:00 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 13/28] cyclictest.8: Synopsis: Distinguish --help
 mode
In-Reply-To: <20250704132721.13325-14-darwi@linutronix.de>
Message-ID: <29a16edc-305b-8152-463e-c2ce8e8570c5@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-14-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Per groff_man_style(7), different command operation modes should be
> distinguished through unique Synopsis (.SY/.YS) blocks.
> 
> Distinguish "cyclictest --help" with its own section, as other parameters
> won't be recognized when --help is passed.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 0271f5c..1fd550f 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -6,6 +6,7 @@
>  cyclictest \- High resolution test program
>  .
>  .SH Synopsis
> +.
>  .SY cyclictest
>  .RB [ \-mMNqrRsSuvx ]
>  .RB [ \-a\~\c
> @@ -61,11 +62,14 @@ cyclictest \- High resolution test program
>  .RB [ \-\-tracemark ]
>  .YS
>  .
> +.SY cyclictest
> +.B \-\-help
> +.YS
> +.
>  .SH Options
> -These programs follow the usual GNU command line syntax, with long
> -options starting with two dashes ('\-\-').
> -.br
> -A summary of options is included below.
> +.
> +.B \-\-help
> +display a usage message and exit.
>  .
>  .TP
>  .B \-a, \-\-affinity[=PROC-SET]
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

