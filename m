Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB537C0F1
	for <linux-rt-users@vger.kernel.org>; Thu, 16 Apr 2026 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342505; cv=none; b=tEIr8FqIs2XRp4K1d5cwZvc71dDZcfLK+SQZnrJI7h0m/Uu0xAaILM6s3f+Hf6vcRrXzMvNkPtuZ8uhABYOJKYbuIFCFAIjamnBlS6TfmWIy3ZQRZUn8u5L+T/+opdop0DscliqJYgp63SJfZJuJFO5QwKIxgLQQrtLljINdOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342505; c=relaxed/simple;
	bh=sWvMxCtsPOV10cpIK3sSsqr5FnSrM4Ew9e9iki/QTZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlKJM7gqOqzE+ndNGsKHVVzz/vS6UCwbfGz/GgK+/vRCyK0Vv7vM9JPXoxOjYWXBTYOOieZYT/Un+MOZRfMRUSdhxohV4+AMlQ+we0rMug2gGwnRUq4THxSLTbasyKdjI3elpM8dpD14yDYWVpnxkTINRZKy/Qelw8qen0F4g98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NEWj1CDK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f/bKCTEu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NEWj1CDK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f/bKCTEu"
Date: Thu, 16 Apr 2026 14:28:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776342499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmB+96GYExRl8vtqB1ZquKSLnwZGnKgAS81NRKyfGGI=;
	b=NEWj1CDKfwFKiydcynIP305gTk2OQeYD2JmuSfXDMsJfNUrwmrj2Pg8+mJNJReoqopB1Ys
	h99yNwyT15Yck4V8QJ8DxzcSxiAgOKUaDoMzDdForuysUm1fQTRGWgSY4FWFoOkbkJF3Ti
	2jXh+tp7cStxvRhDgwXahu93EsBqZiQiCRh60UYgO60nCtMDnc6gJyTzC3urQ4AV9QGVH+
	rPFkG8gKBIKM8NLVa9DE0Wpmb3EpemJh4XbEAziL+LXWtwZyL6cH3dE3mKZjthPHILmN4W
	U6T4MWERWTqf7/i+5g87j6r4fvMTghMqMFe5ye6OZpc+DXaiy/wpNgty2+ajKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776342499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FmB+96GYExRl8vtqB1ZquKSLnwZGnKgAS81NRKyfGGI=;
	b=f/bKCTEujaBIk8BqhJe48o36jQLBJFUmt2C0OvJekpfHZZ5HZCnyp/1USQaVplmSmT/GqF
	GzoO+x8E5R0XNNAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest: Simplify auxiliary clock parsing
Message-ID: <20260416142521-9f639d90-a475-43ad-b160-24b344465d2c@linutronix.de>
References: <20260415154249.139258-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260415154249.139258-1-jkacur@redhat.com>

On Wed, Apr 15, 2026 at 11:42:49AM -0400, John Kacur wrote:
> Replace eight individual strcmp() calls for aux0-aux7 with a single
> pattern-matching implementation that extracts and validates the digit.
> 
> Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index afc3a8c452da..71cf5cb25c22 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1054,23 +1054,13 @@ static int handleclock(const char *clockarg)
>  		used_clock = CLOCK_REALTIME;
>  	else if (strcmp(clockarg, "realtime") == 0)
>  		used_clock = CLOCK_REALTIME;
> -	else if (strcmp(clockarg, "aux0") == 0)
> -		used_clock = CLOCK_AUX + 0;
> -	else if (strcmp(clockarg, "aux1") == 0)
> -		used_clock = CLOCK_AUX + 1;
> -	else if (strcmp(clockarg, "aux2") == 0)
> -		used_clock = CLOCK_AUX + 2;
> -	else if (strcmp(clockarg, "aux3") == 0)
> -		used_clock = CLOCK_AUX + 3;
> -	else if (strcmp(clockarg, "aux4") == 0)
> -		used_clock = CLOCK_AUX + 4;
> -	else if (strcmp(clockarg, "aux5") == 0)
> -		used_clock = CLOCK_AUX + 5;
> -	else if (strcmp(clockarg, "aux6") == 0)
> -		used_clock = CLOCK_AUX + 6;
> -	else if (strcmp(clockarg, "aux7") == 0)
> -		used_clock = CLOCK_AUX + 7;
> -	else
> +	else if (strncmp(clockarg, "aux", 3) == 0 && strlen(clockarg) == 4) {
> +		int aux_num = clockarg[3] - '0';
> +		if (aux_num >= 0 && aux_num <= 7)
> +			used_clock = CLOCK_AUX + aux_num;
> +		else
> +			return 1;
> +	} else

That works, too.

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Though if it gets cleaned up, it might as well handle potentially larger
values of MAX_AUX_CLOCKS.

>  		return 1;
>  
>  	return 0;
> -- 
> 2.53.0
> 
