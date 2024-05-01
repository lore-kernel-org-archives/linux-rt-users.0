Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5E1649CF
	for <linux-rt-users@vger.kernel.org>; Wed,  1 May 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596725; cv=none; b=NUhfnZxNnxmz24C9QcfK/QKkjRq9Ctip33UOTINNtIJhUJVvFCgqZXxFr2jacBTABaN6Ieq3EZ5T421t9EYXT2kNmCsPR37AgaMRxuFXyi4hFBa4M9h6WDbDtspYKt2vFGC38U9fWH5GCT1xl9G7WkhYbgspUuJOmTC5GMwQkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596725; c=relaxed/simple;
	bh=/6RY9vJtdOCNe1qq/nf6SJ7XAuqgD3orMvGP0nQWd2c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uXaLZUzFNFwIL7B7R7RJoahybdqMOsCEKaj7OLd3a5iTjgjrhz1geUjhYxxuWNuGb9TNWF9/KiBEpzDOJs7/ubqNMX5vNO0oVIuu/G8Gl0yRFAKkNDEKUjP3CUJzmF8EnAUva1FCuVZjAZkTYvkXmkgzfWBE7wItOCxXh7zPJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4lM5RMA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4lM5RMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714596722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zp6vewNfKTBK2CtJrmMsZrXTqT0cqYg60sHYh2lx5RA=;
	b=d4lM5RMAeeq1qHIUC3rgyTfUGlMOuNebksdYYiNTEWdOhdrtHFgsyYUZdTAI+/MgAOfNbf
	yIAPv+R5I9FrbooQnM/k7AoU7kQa7thnTGZUqon6upNoR2332r62mJPLEU9PUKB9/63Zqr
	4JdNEDo8OiVMORnI9LJgONzpX48mBbA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-MeMZeV7IN3OwAlj8qcW7cQ-1; Wed, 01 May 2024 16:52:01 -0400
X-MC-Unique: MeMZeV7IN3OwAlj8qcW7cQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6a0bad9e756so42979576d6.3
        for <linux-rt-users@vger.kernel.org>; Wed, 01 May 2024 13:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714596721; x=1715201521;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp6vewNfKTBK2CtJrmMsZrXTqT0cqYg60sHYh2lx5RA=;
        b=aTbDg1a0ga8vTs2ATkiVGNg7XCCWleJSVfy8dilQ/L2WRl8rko9ip/+YJ93bKlSWz5
         nSqg5FdCGJSSAmAnRXHMpsCJZZbueRFRMJZybX2WhowapAfZIYQQLUGOt6hwfKhIugW5
         IkiMaXAIdiC2W4IdM5EnoZiZChjwM++CF8uaxP70mmLE9GAigPXFY1J1tKDjGRHq+RRE
         jkqiCjtKGSZ2D0xXnIVZCVyTVUhnNxr6dUZHumPjK04Kby04R6tpetWYAM7AUkcn43JP
         rEJ8rOESyec7kYct56Dw8UJ6ZiN4uYGHeInWfIbyIm9Y168X5lHcBfEyhtHjHhb8Q2Ib
         Ez9A==
X-Forwarded-Encrypted: i=1; AJvYcCWCtJmRshCrxDUOf8vbbCcyhJnmKGZj40Q/oZBNegOdpe2GzIu6PvFGlI7u6CfeTRJeONdTE89qkoyMs28k4hG2a4yuVBoOJGieif/DSFM=
X-Gm-Message-State: AOJu0Yz/NkGoTapvjV40b0bEHWQ+16R9Ga2c1R3FJH4ncxnKW45pDDr5
	qT1SIJl0C835ePvUWfm0iGSUKUM6mUS9sdqpNxo3aAdH1SIble4o/IFYoInIML/k2GnwiMrRkR0
	+y1/ilOf1ctz2vY9uYTobhk5jh4I8X9y2yQM1qAYzrAhfq3F/qV2fOQZAa3GfslXN
X-Received: by 2002:a05:6214:483:b0:69b:7b36:30fe with SMTP id pt3-20020a056214048300b0069b7b3630femr4364853qvb.38.1714596720914;
        Wed, 01 May 2024 13:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcnNZI2sRX4AIgEa8j2O3GCOcQiEu+AUYII3ByjWIFuj6OXFo8k8dyPb2LwToyGTUtyUOtgA==
X-Received: by 2002:a05:6214:483:b0:69b:7b36:30fe with SMTP id pt3-20020a056214048300b0069b7b3630femr4364829qvb.38.1714596720539;
        Wed, 01 May 2024 13:52:00 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id z7-20020a0ce607000000b0069b4f48003bsm216569qvm.100.2024.05.01.13.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:52:00 -0700 (PDT)
Date: Wed, 1 May 2024 16:51:51 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: cyclictest.py: reduce: Fix exception with missing
 samples
In-Reply-To: <20240501200922.226347-1-crwood@redhat.com>
Message-ID: <07093174-4e3d-844f-6cef-00cf8c3a2a96@redhat.com>
References: <20240501200922.226347-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 1 May 2024, Crystal Wood wrote:

> If cyclictest omits a line of zeroes rather than printing it,
> __samples[high] will not exist (rather than be zero).  Handle this
> in preparation for cyclictest doing this.
> 
> Note that get() seems more suitable than setdefault(), but the latter
> is used in order to match the code in timerlat.py.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/modules/measurement/cyclictest.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index cef73abd1b4b..925065367eaf 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -115,7 +115,7 @@ class RunData:
>                  low = i
>                  break
>          high = keys[-1]
> -        while high and self.__samples[high] == 0:
> +        while high and self.__samples.setdefault(high, 0) == 0:
>              high -= 1
>          self.__range = high - low
>  
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

