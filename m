Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E9191489
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738187869; cv=none; b=HwkvytjuLhgr9zp/jZZ1aBZykmcuwAIkTMTb4REY/cNDVkFbtHqwfZ/6wEVvf11Gr+nzPBp5nw8XWTEA/TsGOhuQNbgLxHZT8wAiv0B2lo8Ceh/om8CpJrofolHQwbnPs26B93uXWsm7rr8rnhkP5ecvwsOVrffT6YRuE+eFEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738187869; c=relaxed/simple;
	bh=bJydYA3vA5M3KYT2af39IFG0BYLLBXOiJTpLFD+zl9A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U6aG3kLjAyPFm69CCjrE64yLwXsRZihGMN1AXpqUD7tnUqAtfaVB8vhJsrqxakmFW1/F3gdWwnMOcVp+cAftFiGTC3TqsszAnWgf31RLM8gl4O9T9hJDCNjvf61b2ZdOQdlknpMR/oCkL85jwXa8C3+iFbz6uHNdm1THkXMM99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pt4hQym3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pt4hQym3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738187867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp4xgJpW4/hK6CwdMW76um9nW30apm4eZTt6ghLU1vE=;
	b=Pt4hQym3q9VZqmqtYM0c93oY01TDL6vr2byFG4S/Qd2PoGvOViGe/nOL+thpiIllKgKhfs
	T1I/zP9GkkMnVUqCd+9Nyaf+sBj3803Ds3WTr4kRUfbhkI709OMQaIxRckpPzD9a7Rv/Rw
	Cuc348cARs4dvxen9fftjaQLi1gdh6c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-ESYrtqhJNtqyRCns_GjHzQ-1; Wed, 29 Jan 2025 16:57:45 -0500
X-MC-Unique: ESYrtqhJNtqyRCns_GjHzQ-1
X-Mimecast-MFC-AGG-ID: ESYrtqhJNtqyRCns_GjHzQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8b3173b5bso2057066d6.3
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 13:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738187860; x=1738792660;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp4xgJpW4/hK6CwdMW76um9nW30apm4eZTt6ghLU1vE=;
        b=reOMhtJEbHZvkRy5fdJoaMvJh2DZyDNXhGNvZTtxlqYWiCrJ6JZkUQ0bGH83j3jptY
         hszNkw6mjG+XfxJP0yaws5GjmuIt7Tt59cJ1Zmse1os9U38X2aH6TKCWsOvV/uuYZKZ5
         ZDEiBmr01XhMw1R/I68pdMjKnzS4BhvI6Zw8ox2Fg7eqoRt0H0UHULLFBCVPk1vucwWc
         MV7exm+OTNtXOOIBooAaLDRS6o4qbUdRB1tSKN1kQAkq8rJGtDrwO1Uk9qWKvVt92OyM
         tnuWnZZv6La7u99YMYrgzzF6Zxdbe/1AGwfioYV1j29IVA+SzCzZzzBvACIrlR4oRpVi
         Wyuw==
X-Gm-Message-State: AOJu0YyrD+gH+ipRPP2gLqwkTnZQp0nBz9DQKAAxRytxpmKpmEUWaRea
	mdF2rjeYCWzHvbaNdz3B8JWmIUdbpdMUWwfwF7ssjntR+LZ+Zjpd9b8WmEZzsyhn+YqP+izxOCb
	zPaslg/D4ML1UGCyalvIOVtz3Lwp//PggnR8QeSptRf8+e2OGdjpj7LJKDCbBRuHX
X-Gm-Gg: ASbGncugh5rqb4cEYl6OUaSOY5RZL408bHS5DxGThXxky4CzAdncq3eCatZ6/UjL4eO
	xjMMA9nAHWhDdrb+IGcnsgtrbJR3izn4swDD6zqnp813Yg99NimR2Wz1MSQPXLm/eh1jD4GAxXG
	Kt7nUOBxsgGGuyWu+mz6yGldvOBNhYYgKrxWuWtRZbyox+rOf21CsXreuv+ujnndZBEO2YUY8wd
	Ig6SC7daMW7x4EfFDa1l80kAU+ZTg+kFk9tlrGFtsvI691GNOenRttN53Da4awdjqtO04E=
X-Received: by 2002:a05:6214:2aa7:b0:6d8:9f61:de8c with SMTP id 6a1803df08f44-6e243c56b86mr72159686d6.27.1738187860106;
        Wed, 29 Jan 2025 13:57:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKzsSTSBXyP7JG8mIU9qwNLk48DSNo8jWSgRz9lQpGdhZ9gaU3asUvp1Fjls5ECe3QDSMzpg==
X-Received: by 2002:a05:6214:2aa7:b0:6d8:9f61:de8c with SMTP id 6a1803df08f44-6e243c56b86mr72159476d6.27.1738187859796;
        Wed, 29 Jan 2025 13:57:39 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2057a8ab6sm59248786d6.81.2025.01.29.13.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 13:57:39 -0800 (PST)
Date: Wed, 29 Jan 2025 16:57:38 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Shizhao Chen <shichen@redhat.com>
cc: linux-rt-users@vger.kernel.org, Crystal Wood <crwood@redhat.com>, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH v2] rt-tests: pip_stress: Add option --usleep
In-Reply-To: <20250124075206.35834-1-shichen@redhat.com>
Message-ID: <a73c98c7-13a5-3932-27c2-eb0d9c32de88@redhat.com>
References: <CADm5pWf1p-SJAWp6fyOhynpxz7gJx6542d+ZPt3e66WC9JSbyA@mail.gmail.com> <20250124075206.35834-1-shichen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 24 Jan 2025, Shizhao Chen wrote:

> Different hardwares have different threasholds for usleep_val to
> reliably trigger an prio inversion, add option --usleep to allow
> specifying it at runtime, to facilitate testing of prio inheritance
> on different platforms.
> 
> Signed-off-by: Shizhao Chen <shichen@redhat.com>
> ---
>  src/pi_tests/pip_stress.8 |  6 +++++-
>  src/pi_tests/pip_stress.c | 10 ++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/src/pi_tests/pip_stress.8 b/src/pi_tests/pip_stress.8
> index 0d06dd2..0f65ad1 100644
> --- a/src/pi_tests/pip_stress.8
> +++ b/src/pi_tests/pip_stress.8
> @@ -5,7 +5,8 @@
>  .B pip_stress \- Priority Inheritance with processes
>  .SH SYNOPSIS
>  .B pip_stress
> -
> +.RB [ \-u|\-\-usleep
> +.IR TIME ]
>  .SH DESCRIPTION
>  This program demonstrates the technique of using priority inheritance (PI)
>  mutexes with processes instead of threads.
> @@ -41,6 +42,9 @@ merely increase the time that the low priority process sleeps while
>  holding the lock. (usleep);
>  Also note that you have to run as a user with permission to change
>  scheduling priorities.
> +.SH OPTIONS
> +.IP "\-u TIME,\-\-usleep=TIME"
> +Specify the sleep time in usec of the low priority process. Defaults to 500.
>  .BR
>  .SH AUTHOR
>  pip_stress was written by John Kacur <jkacur at redhat.com>
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index fb0391b..9bd225f 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -72,7 +72,9 @@ static void usage(int error)
>  	printf("pip_stress V %1.2f\n", VERSION);
>  	printf("Usage:\n"
>  	       "pip_stress <options>\n"\
> -	       "-h	--help                  Show this help menu.\n"
> +	       "-h       --help          Show this help menu.\n"\
> +	       "-u TIME  --usleep=TIME   Specify the sleep time in usec of the low priority process.\n"\
> +	       "                         Defaults to 500.\n"
>  	       );
>  	exit(error);
>  }
> @@ -88,16 +90,20 @@ int main(int argc, char *argv[])
>  	for (;;) {
>  		struct option long_options[] = {
>  			{ "help",	no_argument,		NULL,	'h' },
> +			{ "usleep",	required_argument,	NULL,	'u' },
>  			{ NULL,		0,			NULL,	0 },
>  		};
>  
> -		int c = getopt_long(argc, argv, "s:h", long_options, NULL);
> +		int c = getopt_long(argc, argv, "hu:", long_options, NULL);
>  		if (c == -1)
>  			break;
>  		switch (c) {
>  		case 'h':
>  			usage(0);
>  			break;
> +		case 'u':
> +			usleep_val = strtoul(optarg, NULL, 10);
> +			break;
>  		default:
>  			usage(1);
>  			break;
> -- 
> 2.47.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

