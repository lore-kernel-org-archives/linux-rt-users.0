Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C033013777B
	for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2024 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653011; cv=none; b=fTO7vXbFXZ3wJSSxFGjmq07A0V0JbGWOFN95C5yEiGKwE533mIUmgWJCqgHcGBmPTnj0ffxU7EgxhFoMmzREG0kfoE+he5P30N2VwIYpJi+AJXnip0YMblApSxjO0KjFtbnYmxB9UA6f1kwHbIB4mF8uiBrARo8jcs5D6TlgUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653011; c=relaxed/simple;
	bh=3pBWrey5qedxOGywqhF9vxueYHZBcISeQ35QKvN2JqE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SEBI7roNY3qaFb8RE0jbChIBLJBwMIcnup1nQglUzP9ivoiK0l1f+FY9P7lSpTRTeb2X3KS7a7zWRdj8/tXTDFffx3WSryNLueEyabH9Hn4uvSwduufVQcEg6RtoFCcU2MBr6kjHcFitf7QFEhbxE47jkdXQjrzOtTEUcwmvw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFYzGpEp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFYzGpEp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711653008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhf9VNDeNMdMcFBkxDa3FcOH9gTTaNM1YMf2iqNiSdA=;
	b=WFYzGpEp6RH1u/sFFSKP4Dnqkj2StIFD0PrS6o6JFJAaHO+xec7J34Mm18/f6mE3/1ewpg
	k4xLhxL7gugglLSD148bXwM6ibX1n5xLs0L01UiKywmekY1QzWaFMcH1XlCg1tlvb4CKfB
	24qyW79q8pzFeQQtvnpL9ztrqKdWp74=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-Rq2CCAffOZOnBhc0nDeRkw-1; Thu, 28 Mar 2024 15:10:07 -0400
X-MC-Unique: Rq2CCAffOZOnBhc0nDeRkw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-789f2dee101so124727285a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 28 Mar 2024 12:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711653006; x=1712257806;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhf9VNDeNMdMcFBkxDa3FcOH9gTTaNM1YMf2iqNiSdA=;
        b=cWFgJvuGNySjLwIpTcCELzyBdUDtFiipJOXO+q2TJPcMx/0V+IFoOEsGWjcRtjC9I7
         A6DG0Y8POcIr1LTnSfbkYnEzuQfX4Uuznk1wzTZl0rvMmv4T4bdECLH7M8ceVXaekmQm
         wF14b/8Oxw0RYtbA50gcFPCknZBuRTu/qM9FUvUHY671QD4tSbZKgyskJ2hDbrrxlObE
         aJUhg6HamV8Nc0+WOOdAbZSZzazIHkHlBcansvre3CXajOzmXiae9FEzM3StzqUH+Zzh
         9aKyL7uS2KjGJBPhephQ6qL2BOsSpxKfXfbhP0mFMj7Gcj71dW/WmPV4lHNJufgwuFuM
         YCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm/GTycNPjx0MKSJ9vwFV492QQhX1iJS9/CbyPAK3WlmPnXBGUicBE+E5yo51Md72GGPK164UYIYcSbE25Bt7LnIjemEFQ6o2XIzrrdgI=
X-Gm-Message-State: AOJu0YwBCkgadjR5mdLlo2eFzCQOArL+MXgcaNzuS37h2VOs7IGNdPLl
	sXs9bfUEquSYx/W/nc0rQsSI5gw+k1zPwfZx51qsI9BuSD+GKaVR7meZf8C0DfzZnlKBMjB+CbC
	rY6qxGH9lx+8SKp49XdHS2pxKKFH6scl/mi+S02oMDJlHWzUGa/uL3Q/n7Usqd3FmEw3IBt+d
X-Received: by 2002:a05:620a:2a08:b0:78a:3ed1:e262 with SMTP id o8-20020a05620a2a0800b0078a3ed1e262mr513343qkp.48.1711653006569;
        Thu, 28 Mar 2024 12:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1vS6Qt7eStiUhlQFLda6QFSWnWrDOBPqvjN7iDXNyGuPayj+zhb3N4Mp0AB7johKsPRc/sA==
X-Received: by 2002:a05:620a:2a08:b0:78a:3ed1:e262 with SMTP id o8-20020a05620a2a0800b0078a3ed1e262mr513320qkp.48.1711653006265;
        Thu, 28 Mar 2024 12:10:06 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-166.dsl.bell.ca. [184.147.142.166])
        by smtp.gmail.com with ESMTPSA id qp1-20020a05620a388100b0078a6b1b65f1sm741961qkn.130.2024.03.28.12.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:10:05 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:10:04 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/5] rteval: default_config_search: Return None on
 failure
In-Reply-To: <20240304211655.20174-2-crwood@redhat.com>
Message-ID: <fd143a8e-4525-cf32-142a-0fc4d5b26c3f@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com> <20240304211655.20174-2-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 4 Mar 2024, Crystal Wood wrote:

> If False is used without checking, it will be interpreted as stdin,
> hanging rteval waiting for input.  OTOH, None will cause os.path.exists()
> to throw an exception, so we need to check both the name and the existence
> separately anyway.  However, this is a better failure mode than hanging
> on stdin if the user of the filename fails to check both.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> I found this by trying to use "make install", which fails to install the
> XSL files... apparently data_files is deprecated.
> ---
>  rteval/__init__.py     | 2 +-
>  rteval/rtevalConfig.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rteval/__init__.py b/rteval/__init__.py
> index ca018f6fd8b8..5d43615af5bb 100644
> --- a/rteval/__init__.py
> +++ b/rteval/__init__.py
> @@ -76,7 +76,7 @@ class RtEval(rtevalReport):
>          else:
>              self.__mailer = None
>  
> -        if not os.path.exists(self.__rtevcfg.xslt_report):
> +        if not self.__rtevcfg.xslt_report or not os.path.exists(self.__rtevcfg.xslt_report):
>              raise RuntimeError(f"can't find XSL template ({self.__rtevcfg.xslt_report})!")
>  
>          # Add rteval directory into module search path
> diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
> index 030d4205efab..e62da25119a6 100644
> --- a/rteval/rtevalConfig.py
> +++ b/rteval/rtevalConfig.py
> @@ -46,7 +46,7 @@ def default_config_search(relative_path, verifdef=os.path.isdir):
>              if verifdef(os.path.join(path, *relative_path)):
>                  return os.path.join(path, *relative_path)
>  
> -    return False
> +    return None
>  
>  
>  # HACK: A temporary hack to try to figure out where the install dir is.
> -- 
> 2.43.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

