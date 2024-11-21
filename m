Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5702200A3
	for <linux-rt-users@vger.kernel.org>; Thu, 21 Nov 2024 18:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732214904; cv=none; b=o+jdg11Fom/X4mJxBfY7YP52u46HNCt5tLNPsw4Id6hzC5g7sPUlH96ggzzknAgxh/TGqZcweZZynvImO/Yv46Y0Pb5kHZO/2ZyT1pYipQ3K2Kt5JYitb1VvA00hLHx8hBgMLybRTXzgDpKVZdEWuzKxacll5S3aSKx78zlz6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732214904; c=relaxed/simple;
	bh=/L00euctbkZfFOvM1Xl9ABTUeWZwa5CcVnw97Eu+ORA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Vjl63OIfBpHGYegRUjS4Sa9a6/MNVkojBUKP+Aa/OsjzGVJhApnZZAW3Ar0T/dB29UqpsUeFpkDEbIXyo00huSTd+KwPKojjaH8enISrUlSgyPqOT77+AtfNqtjLlpoEmaIIJwY0JdjHg3EYuPKJxLEgOwyDLhj43bAlM1a74oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsIQjP0/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsIQjP0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732214901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXDN/fbH3APx1MouiRb7pShY2EBcOVNLFLKojWkyBwU=;
	b=gsIQjP0/k8bFBqlN6orU4z4iwhVDx/3o/ZseLNZgErRYwTSvoACY6x2h1yQE3lo1pQYF3C
	tLamnm4Fa1z3lNbOqZNX99N0AANoobilTs6jEaCHQ0u1FSAdOxSZPPUtcYjln5eM/Dyo3D
	b5+tCDtIAHs7oUPkfweknPEon8BRly4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Ezk75Y-4Oeuxoph-bsIPjQ-1; Thu, 21 Nov 2024 13:48:20 -0500
X-MC-Unique: Ezk75Y-4Oeuxoph-bsIPjQ-1
X-Mimecast-MFC-AGG-ID: Ezk75Y-4Oeuxoph-bsIPjQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-460a85907b7so15594481cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 21 Nov 2024 10:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732214900; x=1732819700;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXDN/fbH3APx1MouiRb7pShY2EBcOVNLFLKojWkyBwU=;
        b=tyER6QjDzngXqE1yUEOceRvWiROp2DnqJwYYov9gKXlmjCDJA4UBNNF5mX92Vj1DV3
         xMV4ZPBQvkcYqbjEhiA2Vsa77VgniLj+Yq026JrJZhCgwDM/LHijT0BFC5fyC1FFXamc
         tqKSZuvLExdK7tRa2x1hQDOznLd2Yg32NvCfRvnaoDyEuNuI11lWAW6Sn4wmwZIUX5D9
         R9iOCJ0VuGV9H+IQYfLrX0PEOWC3EkkfZqFlenqgoV+WqaTYuOqJC38eCL0YmJbEuBMv
         1URchtm7WKYh4v6MdNL06ui2r1UsR0y+b0A8fcfIRJMcwx8dLseIIq/P33mSzhdPss66
         VNNw==
X-Gm-Message-State: AOJu0YyAIWueLUV0gbvvifwFeYQoJZ/ZmS0jGyCHj3iMzntL81+KVVqb
	xdq0/X4uKBRbEy0x8nRlbenN/GAJJ9H4ixtspHmPHkhd/vOprxpa9CUVdj7QHZTsB+SGrPzW+fv
	1rGrrXv3Ns/M0duPotn2paxGwgGUaUByB6XMXUDwzOIbJqeZ23vi1E1JvDfV72Ut1
X-Gm-Gg: ASbGncu+tNB0Mvjyi2ZDDjGHU2ihAq7xGMYiPzozWR0fgPZnfYiwo4OyapOI12qmqkR
	iQ9Lm6TQeu9uJ2oqgGhoGzMrylax0BkLwvsucRbGks7WccFhE19ste+BNK2aRIJgPsx2GNVgpYO
	cwhInDNMpqGRF2GvB47liXWThX33somFsy/ws1m3J31Oreerqnk49W/vDF343R2UlE8sUFj9sfV
	D4dt7YJjqAhnkHVNUxhFQHbsIo8cFe7ZwJoNCZt
X-Received: by 2002:a05:622a:558e:b0:463:788e:790a with SMTP id d75a77b69052e-4653d57a226mr960131cf.13.1732214899753;
        Thu, 21 Nov 2024 10:48:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvTXCAwd2VCh5qe0ojUrj9GXcV3bgiVu/pQv+NsROY1RkkNcT0wOdgT44SWVyLv8l/0QIp4Q==
X-Received: by 2002:a05:622a:558e:b0:463:788e:790a with SMTP id d75a77b69052e-4653d57a226mr959801cf.13.1732214899320;
        Thu, 21 Nov 2024 10:48:19 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c3d997dsm1938941cf.17.2024.11.21.10.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:48:18 -0800 (PST)
Date: Thu, 21 Nov 2024 13:48:17 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tan En De <ende.tan@starfivetech.com>
cc: linux-rt-users@vger.kernel.org, mtosatti@redhat.com, williams@redhat.com, 
    leyfoon.tan@starfivetech.com
Subject: Re: [1/1] rt-tests: queuelat: Fix wraparound in __clock_gettime()
In-Reply-To: <20241111014911.11571-1-ende.tan@starfivetech.com>
Message-ID: <60841c27-f589-07ac-4e00-ce9a15d59836@redhat.com>
References: <20241111014911.11571-1-ende.tan@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 11 Nov 2024, ende.tan@starfivetech.com wrote:

> From: Tan En De <ende.tan@starfivetech.com>
> 
> Include tv_sec in addition to tv_nsec in __clock_gettime(). If the value
> of variable 'a' wraps around, it may cause 'delta' to be negative, while
> 'delta' is defined with u64 type.
> 
> Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> ---
>  src/queuelat/queuelat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> index c549cd8..c057389 100644
> --- a/src/queuelat/queuelat.c
> +++ b/src/queuelat/queuelat.c
> @@ -292,7 +292,8 @@ static inline unsigned long long __clock_gettime(void)
>  	if (ret < 0)
>  		return 0;
>  
> -	return now.tv_nsec;
> +	// Combine seconds and nanoseconds into a single value in nanoseconds
> +	return (unsigned long long)now.tv_sec * 1000000000ULL + now.tv_nsec;
>  }
>  
>  #define gettick(val) do { (val) = __clock_gettime(); } while (0)
> -- 
> 2.34.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

