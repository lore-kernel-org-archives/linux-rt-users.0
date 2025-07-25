Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AF21C860B
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466663; cv=none; b=jD1sVr5KGlBssc9rmKyT58wBcqVhncdolPg4SL6Huiv24Vuev3B6DVXRdE9n56+nF/VzmwOOIypH/mqX8Kke3y0x2DYJYtapxdkyZWMqepssdtUETI+19Ahxif960KGDPEMmo2yjil6ol+yn2AM1pN1JGsKeNm42AjE+gogEEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466663; c=relaxed/simple;
	bh=X6l/d9Lfn9Qk3OpuABOIPwYUrlKtI/LVN2/kMBVDEio=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DVloJsPwwRcStLJoZd4JZEEcg6He1qNBM4vFMNdRFY89G885Fcf2hEiYG3JkJKsDl0pY1YwKL11BRbHCehH9ddtegWuxDsRRDefR9DU4bSemG9cByD3zcBjKbt5EdbjbjTY81w3+/6ddWmeaXNssqBaPio2sKZdpkC6SCcJSf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uj8gofUI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uj8gofUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753466661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AhkKV33dvvU3VBkd7yNRXYZxrhqTK66fW9dR8pkQbx8=;
	b=Uj8gofUIKatjSXNS/JQA0oCPvfgyx910TIgZlrEDHXCILRl5vggwzWgQ+aFJG2jx+jSKsg
	Jgjm92dMfzZxYNXNLrMR2S/TprVheeno3dJCPF3qmfsxgVBsohfFzJv7up+BLiNv1dIUoF
	WnilYkcwaVoni3X8cWsx1H8TBgM9y14=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-L6lfglUSMWu7o6WtV42bbg-1; Fri, 25 Jul 2025 14:04:20 -0400
X-MC-Unique: L6lfglUSMWu7o6WtV42bbg-1
X-Mimecast-MFC-AGG-ID: L6lfglUSMWu7o6WtV42bbg_1753466659
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e03ac1bf79so189735385a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 11:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466658; x=1754071458;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhkKV33dvvU3VBkd7yNRXYZxrhqTK66fW9dR8pkQbx8=;
        b=BACX2f8fDdW/uSSCMwclKB1lfRmkODQu4LQgCG/gQhSlPpUcIggeafpT68EdbZwk95
         QilhkGcTvIXOlr69iE+MfkC4Jqf3reJieCKGVrzxO/4CcNP41YD6OH38zs/J48ZdTp7n
         9lkYTPyye4qgLzwpIixtGpYz+7QHdMVTa4b4a/rxh1ZjvpSQp5K6XQcosj2MlgWFsuo0
         pqf5hq7rjr5i4nJht0FqTwRmE7w8DOqsTXDa9GX5Yjji6T5n9dk4uTqbsUPcG7sUu1tL
         LTJaYCImsQM+GjkkxPwyaGVEd4EbMcsIm7yjDSlMTn97YE1ko4pW/rdRnxhrVQBrdP5G
         MX1g==
X-Forwarded-Encrypted: i=1; AJvYcCUs0I9iVRfK8gZa55xyRJ+YwilcmoGEm0hTk8muk2J64jW3q9rzHH+tWnNIj/Bo+65IlzdiBrUvjrNoEfzjWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMg63NeyPuBxChX96axnP4uZAD8+Pc509s+4u7VJV9DJ1z3bi
	45k14/mufMi7iGPihCdHU0Z9YvVsfvyWEEGg1Ghr9GykWdXoiHTvZNQFDTn7ohzpP9ZTK7UARSL
	bJj+Q56f9oLD1zOsO3s1ydt3QXT8zYnPwtTruOZRADGnJNIr7YjVCmD3mno/dA9wkTyz7QvC9s1
	Rz
X-Gm-Gg: ASbGncv8oOrOdqOM+Al+XqKDUqq6k/z2DIQNdLN/Ac7U9Y44EI9AuSalexqqaumj/Ef
	9S5Unzwwhda4Y6jHlfjcmX3/LB3tgW9OyR56RVMqKlrODwdyGZXL1UP+hbdPHmuyhAvLQ4N5yPl
	bK3MMXt9BeOIboxcAnzgAduQsQ24mIwBm7bRJodsK9o9jkIGJv55alFIYkCk+yqTfCud2HMsU1G
	oDYkc899DXif4oKZ/aGKQRl8/Y34YhqMSZniAv1tYLCjLvP5sUA1w6RtkI9JUkPrlQ0lcoUQr0K
	BM5kLsM+Z+LEEviwlWA+boywu8S+IQ==
X-Received: by 2002:a05:6214:20a2:b0:6fb:1c3:f527 with SMTP id 6a1803df08f44-707205c3553mr41454486d6.39.1753466658093;
        Fri, 25 Jul 2025 11:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtENnH1hN1MDDMzBKtZdlyqAa/R9/3QplKvrbKKHS/TT3VunCv5C56LyHCYGziphwZ/sPtxQ==
X-Received: by 2002:a05:6214:20a2:b0:6fb:1c3:f527 with SMTP id 6a1803df08f44-707205c3553mr41453616d6.39.1753466657270;
        Fri, 25 Jul 2025 11:04:17 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299feac9sm3007466d6.1.2025.07.25.11.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:04:16 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:04:15 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 1/8] rt-utils.c: Suppress warning
In-Reply-To: <20250712134213.58582-2-yphbchou0911@gmail.com>
Message-ID: <edcac743-004d-0194-caa9-fedff24aa9df@redhat.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com> <20250712134213.58582-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 12 Jul 2025, Cheng-Yang Chou wrote:

> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  src/lib/rt-utils.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 6bbd25a..18e515f 100644
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
> +		warn("tracemark write failed");
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
> 2.48.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

