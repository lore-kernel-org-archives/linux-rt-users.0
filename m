Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA144DB84
	for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135025; cv=none; b=WZt3/kVKkIbf8mTJ91k/0aQQCHJhTEjA2MlubXOK/0RFLIWES/n3+W/ac1Oi9CbFLa9fIMEBHWRsj0EETptm9vzeV4KLNn9Y/97cTu5mjk1uA2nlc6fEgES6ePvOe00a/pV8VtnXL+u5XPpqDUq35LKg3WzEYPT5pv/miyWEzWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135025; c=relaxed/simple;
	bh=uy36mPAbuX29BWUHwWxR/Td98Yoh2ezcSsxbKwztpRQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YYYeaCJryjI4+bw0OfGP913f0gy0hvAVJp+ZesYQk5HmkCMTgmH23Z5E9J0wumI8WUknqzJFIkICqtRllvriCB+pEHoU1SdQj5JUlBS+T5vU5QQh/Syp8wsX9QsMdkCwTNXNner4okbX4RhOZWQlFjQ5gwnh8gVCisj2ComGHW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHRMhTaC; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHRMhTaC"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899c955f6c5so10241966d6.1
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2026 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772135023; x=1772739823; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EupXAREj5dfn9ZKsYPLTZgsSCnusuB86T/6+gBFtRds=;
        b=aHRMhTaCdiPQOOfHLPnLf2u2aLzsmiIcCdHhpNLGQ9aor8wOoWIgPZl92/n6WU/VAZ
         MHKAU/gQVlKqfgzpY0fx5ji65J5LhYZUH1DzZtNpMGbXJJGsaub2CVBCMsf6AtSannfr
         ZqNZMJ9C+b8ROf1vuE/18wQbW2kSNQHuO0/AN1w/NsHCO0hzFnR05VfVAwB9kI3h740C
         F+yoTim4i1YsadtBhFyePlI7smYtwkzfkN264tRMqrpW8ia1fkofZyktUuCVPFLIjFcM
         +dv9B4S7TzMQVHh42NpU9aa8JdtVUXmS8aqIAqjBs3d4OxNK361OL16EKyMpABOJrtw8
         Qv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772135023; x=1772739823;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EupXAREj5dfn9ZKsYPLTZgsSCnusuB86T/6+gBFtRds=;
        b=aoj2ee0vTepcwKktDnlZPoowNLk8ffkapFweTvZ9dFPmdqjkwQaAuquxEhGK94Ol79
         1yoZ8N3QyS8QfEaOo4d4I8V4EWTLcM2IGbsZZokw9TutrQcRSWnEg4fowK/C3FcBuyb+
         +VxYBbIm6qeXSgVr7gdT0IW072Jt8sbHrkYD30+SHJyxJRTpyZO7z0BDRu2D2z3wvCwj
         QPHMaRIPkg0M4P67KfvxobYtU8cXaRXYKgMsh1CPGTcAR5uH9BmX70Mdp14AkNatyUEX
         u6JxRl5rVfKT78LyxgIGnmnNknDBcJh9RaMCDe9tKtvfzf+RKMgKtAIZ62X6zC+PvtBo
         V7yw==
X-Forwarded-Encrypted: i=1; AJvYcCWZVkoKhCkK/1/2uj0CfUsQnximIo/gVdXW/u7caAUTh/mhvsjNsUqsj1bc7tha16iYJz1E1uYLPJv1/NExHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLNcKyrAzaoO+O79XeJ80Tt+jkxBfW68BhmX0IBAUGWCkuO6L
	9ZQbT3PYdwR3wmKqf1mMuzGLLrxUXgLpV04+jBjRNv3fWY7bHSozNl4n
X-Gm-Gg: ATEYQzzJBt2gClq+D0S/K+vEfaEwyTv0ihDpTDdvqy0Cv9g7Nr8EAzVASNBJiV/g2Bb
	dLOLJq+W1u4nXe5Vd1Z/4iY58tsyUzOVPQMemr5NVgL43KdL/LMCClv2wxPmfMKInTipFqoYi4A
	zVftzaQUFmqHViS/kFon+syikq41rXPRPhlDYOOuaZDRWn5wspHLLGc7yOxD9pWIJJk4cY2UwLc
	c2xcCr8y1HnhOLC1JaQotf29KjyZ0pFx8HX/g/lKGhtGYabjsx0xj5PgeEnO2b75UYa8bdzrT2a
	oBhLm3xJYA11rfkerQIwYPlesCbKOO10/z8Ei65iA8Rep9eFdqS2sfVamGcFqF2AApyRwEnQHIZ
	XElvU78wniaDrYxss7HraR0jbq5WFDrTqbHLmIjd7D23VsCM/m3EzHB2ZQzC3yMvrhYCG8Xm+1i
	hBW/U5ImBPsfqUoS0ps+Y/YJ+izUMI/SnKwHL0vXpNiwBDl3Bf3szIyHWYi8FgksJuf7b609pnX
	Q==
X-Received: by 2002:a05:6214:62b:b0:895:1d59:5aa7 with SMTP id 6a1803df08f44-899d1e0921cmr4589306d6.22.1772135022849;
        Thu, 26 Feb 2026 11:43:42 -0800 (PST)
Received: from Cumhall ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738d80bsm25427726d6.41.2026.02.26.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:43:41 -0800 (PST)
Date: Thu, 26 Feb 2026 14:43:40 -0500 (EST)
From: John Kacur <jkacur@gmail.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: John Kacur <jkacur@redhat.com>, 
    linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rt-tests: cyclictest: Fix -A long name in manpage
In-Reply-To: <20260226131828.234378-1-tglozar@redhat.com>
Message-ID: <43526917-bc39-c1e0-f36e-83411cbe5c31@gmail.com>
References: <20260226131828.234378-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 26 Feb 2026, Tomas Glozar wrote:

> The cyclictest manpage gives the long name for -A option as --align,
> however, the proper name in both help message and getopt_long() is
> --aligned.
> 
> Use the correct name in the manpage.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  src/cyclictest/cyclictest.8 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 6becd19..ff2cb96 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -17,7 +17,7 @@
>  cyclictest \- High resolution test program
>  .SH SYNOPSIS
>  .SY cyclictest
> -.RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
> +.RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " aligned " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
>  [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
>  [\-p " prio " ] [\-t " num " ] [\-D " time "] [\-w] [\-W] [\-y " policy " ] [ \-S | \-U ]"
>  
> @@ -47,7 +47,7 @@ field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU sets
>  * Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET,
>  if specified, must be a single CPU number.
>  .TP
> -.B \-A, \-\-align=USEC
> +.B \-A, \-\-aligned=USEC
>  Align thread wakeups to a specific offset in microseconds
>  .TP
>  .B \-b, \-\-breaktrace=USEC
> -- 
> 2.53.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
