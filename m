Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823F34BA4D
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908304; cv=none; b=Gkk2DuZJeYQkcI94Y4wFtLkN4ZDb3+tcDjW19oeGX4uIdBzYVLpgxqNCaZE0RfqwYyB9J+kF1NDwPTV46QJ5X4bDVHWYOw5NvEY16k/pWtGMaXFkeY/5Pn3ySiswAbr4Sa6Bd0eS6Bd1TafSeCqzxfMK82WNF4syc1IREsqp5Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908304; c=relaxed/simple;
	bh=p4e1blIEhzbkJnTD0Z/EDYiPNWl54N4N5W/FPKRQ+mA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bUNXJCTd52sBlv1pdx0DbM/Mip9uVIZ749vT1dHsY65tFjd47RvZCQfEXoh5PBHneN86VIFH5VpinEb0EFGOo8QDnfOttmS/q34bEskTBpz/MutOvjaz1o4Q7lRo9znBkUozUzE3oNH6Cbn52yywkkekvjEh5tuegV/ZYvq3FHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IG5E7r6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IG5E7r6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758908300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5BRs3GvB6BH9Xiy9/HkXkhrHd5z6RQwYJKVILFEnUY=;
	b=IG5E7r6xNgFO14VVfIzAh47p2Q2/n8ZqjOOTCVnXEdcjmvyqrz/oXheeQ+RgTsqd5x5HhU
	36i6xyJNBpvJFpDlPCTabG4+V+Cht62Gx3nWJzP1WyhgGy3v8ccNq7cklg8ufOu13hd2uW
	UBGkoE6VdctDw088dL8VGrnifZilm7w=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-PBKgRx4NM9qqiiKpuxuzNw-1; Fri, 26 Sep 2025 13:38:19 -0400
X-MC-Unique: PBKgRx4NM9qqiiKpuxuzNw-1
X-Mimecast-MFC-AGG-ID: PBKgRx4NM9qqiiKpuxuzNw_1758908298
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-81b8d38504fso780044785a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 10:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758908298; x=1759513098;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5BRs3GvB6BH9Xiy9/HkXkhrHd5z6RQwYJKVILFEnUY=;
        b=VsT3BKR5eGL3ADMJewMclE0ymZqTZmEfQkqEkb4RTPcvD9K8lxC3EWsS3oJhM10G8D
         BKQPLGK9vf7ZjUhjsfw87LgrLQLJP40NQBG6I3DYTQby0R8yKZ9HAYzAcH9UbOEpUm0W
         enP5xBU+dKh4wTfEZzn2w58g3thdXGfYPerLObK49Vf4Rq4SpaZMKR6PpZsrxQqfWMfZ
         X3WkV2/XQ0hw51Pb1yMnN+3NwTsB9cvjFA66rzWH23PMMV+9kavfefptpre70RjzsGDQ
         cDZhh2ng+lOG1YT9tMBwTT6DAmoaMo/B3w7gYFjbhL98P+uvX6vPWyUXrofheKjSjtsu
         fuUA==
X-Forwarded-Encrypted: i=1; AJvYcCXQodVtFMA1qZE62TvDYmDCtsPJ1YAXYKde8jfUlJhQ7fq2OXw+gwWKe6AbAQ+/bDt1qXeLk9TZEfTmknJtFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS51qxGnn8ZO0pvzNQxEFD1frvVFhXr6AwB7t0mifW/PasLMKm
	jWuH1GVZqQ7qrY1htCgz/JZfGq3o8vtkqHHjwNzk7KEG6yyfwBCXwWtHH4dPXIFVhdpxpOWTU+u
	wDhKDuo1YHkfKseoIi3bFAUx8GR/vZ8uSXe5EjZIHL5Q5DBe/5tAHf8k0A8a43bfVXpo6
X-Gm-Gg: ASbGncuym3VC2/qlqqOitZS4TBC14+gHMos8ue5B9/GTAJ/9eVHifDCvOdqUL45hvXq
	SfP3WOqOh5Wpzf4lzrOAUdGAJSV2gu6wf4YoEEIaOvlniLJ2z5hE0fWA59daNTheF05ov0WzS1L
	yoxuZLFB6x1FDDJcx4nR82Ge+qVmQrTABqM34Fi2r+Or8Nc8J2KC7owqhRTPgxc7LoBSScuERnG
	cKh0yDwPxE+9iqukCuUDVCpOkWCfj2xYdbJpKoD5Bqog8QblRLxUYxde+fvDNNVs2gfnHwkf0lo
	YRjBm9fWiiddiWGwl0Uc2lLlgQ==
X-Received: by 2002:a05:620a:45a1:b0:85e:5fef:86fa with SMTP id af79cd13be357-85e5fef8cf0mr842466285a.28.1758908298539;
        Fri, 26 Sep 2025 10:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSG7zYblgXRQovP5oY2TN8bvANMV0OpHdWRLlCncW1fqPspJbZl+SAPbsGOyFuGFOuwI714g==
X-Received: by 2002:a05:620a:45a1:b0:85e:5fef:86fa with SMTP id af79cd13be357-85e5fef8cf0mr842462885a.28.1758908298084;
        Fri, 26 Sep 2025 10:38:18 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c32190646sm308048185a.53.2025.09.26.10.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:38:17 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:38:06 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 1/8] rt-utils.c: Check return values of write()
In-Reply-To: <20250726091837.493915-2-yphbchou0911@gmail.com>
Message-ID: <c09b8057-a037-20df-9b1d-2f7a65542231@redhat.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com> <20250726091837.493915-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 26 Jul 2025, Cheng-Yang Chou wrote:

> Add error handling for write() to tracefs in tracemark() to avoid ignoring
> partial or failed writes.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  src/lib/rt-utils.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 6bbd25a..447e158 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -465,6 +465,7 @@ void tracemark(char *fmt, ...)
>  {
>  	va_list ap;
>  	int len;
> +	int ret;
>  
>  	/* bail out if we're not tracing */
>  	/* or if the kernel doesn't support trace_mark */
> @@ -476,10 +477,14 @@ void tracemark(char *fmt, ...)
>  	va_end(ap);
>  
>  	/* write the tracemark message */
> -	write(tracemark_fd, tracebuf, len);
> +	ret = write(tracemark_fd, tracebuf, len);
> +	if (ret != len)
> +		warn("%s: write failed", __func__);
>  
>  	/* now stop any trace */
> -	write(trace_fd, "0\n", 2);
> +	ret = write(trace_fd, "0\n", 2);
> +	if (ret != 2)
> +		warn("trace stop write failed");
>  }
>  
>  void enable_trace_mark(void)
> -- 
    - resolved merge conflict because an earlier patch changed tracemark()
      and tracing_stop() since this was submitted
    Signed-off-by: John Kacur <jkacur@redhat.com>

