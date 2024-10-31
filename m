Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190011BBBE0
	for <linux-rt-users@vger.kernel.org>; Thu, 31 Oct 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410576; cv=none; b=C4xbA5mUNuSbbf6Ya7rT3xNYKGp5Fe8kJMHvX0IacuiZKgChGdXe/x2OauBncNcR6+pO+mQvfyJGKLjY6wYEjTEaZ6kVNVhFVFvGfEzBOXIkniA8uybZB52/3Tu8aGBdVDuyTQiC4wSOjv8hsjbZkb8NYXaFcdPCmciTvqNPpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410576; c=relaxed/simple;
	bh=0PXr3c2hWLw+PmHYaIys/jIIPF5n3MAD14XIefAvYTc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mYNlLkP99Yz9Y2qwmvajB7yFM1dnGsNXXxcVXKMdZ+a2QGYjabDbsHbrEZSLevKfeZqNJqx3B9bVZJJ1UVyrA7YLSAa+MKUjrCSmS7D82a2RDXnO4Q5LZqLA6r9mCpOdc1ubc5yQQ7vtaDi8bB0PJaN54kWEqUHDCRXACnjM6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UzvIZz4K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzvIZz4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730410569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3Z37ryhmj7caqbEBAa8WqSnBGXSgsugKOAWWAJhbIg=;
	b=UzvIZz4Kq/kH0Mxhcekg1QUqTdkh45qTNslbXS+1y0CXoZlrYs3w2tuUwHuENMtKWdmXTO
	MjRyArdfmi7tRAYMSLBYmkbSvmYT8U4+W1CGdYcnVmwEfmaluJHa4caAhbu3MJXX9CbVWD
	7Z6q3BAq+dX5ID8hS/Bx0t5nFVjtsr8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-ORQ7Qt_VNeOadqfEC-0Wtw-1; Thu, 31 Oct 2024 17:36:07 -0400
X-MC-Unique: ORQ7Qt_VNeOadqfEC-0Wtw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbd2cb2f78so33324826d6.0
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Oct 2024 14:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730410567; x=1731015367;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3Z37ryhmj7caqbEBAa8WqSnBGXSgsugKOAWWAJhbIg=;
        b=jhYYYoHgKz2HTPHpfV1eUzE6mcpaHKuzKdFH42bgRLqwIL6mlgGFHC+1IX4Nd1A4Sg
         o4HUZvFmOQRqic0QSIIw9k6FrTte7vZYH9n1WpK10RyrmWAvrqH/oAMVAW189DXopPRA
         1CKyHN34/uJ65mK0OKh5/XUYECLjPIEZkcxaZUmBwWfiklmvafs1PnHpFoKo30TAxRpw
         im+H0s1Hz5fc26ON9GDSEJixZtqNkeW4UWRee9xwxtgPUZwxiedd9dsBHwxKhraB1Uw6
         rcqJQR5c9XuLGoVHGdSoZJYMp51ZicsXAi6l9gU2cWcr1J8pGYDtMBAWKEyB1+NhKBx/
         6E9Q==
X-Gm-Message-State: AOJu0YzFji5aa76N58pv5U/xpQQqCguhLiQU9kwhOZFFO7cHQzYZznyq
	cG9O/wnDeSFy9kG91Ci4NWOeoVSbszNRyFOuVOo+s860/IAy67tblD5nilCTOOkaSnXf/OZESDf
	kkgGfh/o9nDz48TY99g43/5U8QYiHjPMWBvFncTQmPqZZEI4P5tcGOlJFfCHWosQE
X-Received: by 2002:a05:6214:acb:b0:6cb:6468:7eb9 with SMTP id 6a1803df08f44-6d35b964338mr28189506d6.21.1730410567000;
        Thu, 31 Oct 2024 14:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbV/gwnAsvxMedPJt+dgJg08szbyNVwZgbQrttjPF3fGpgyCjY3FSXG+qmPelmLnIM5ScB0g==
X-Received: by 2002:a05:6214:acb:b0:6cb:6468:7eb9 with SMTP id 6a1803df08f44-6d35b964338mr28189166d6.21.1730410566612;
        Thu, 31 Oct 2024 14:36:06 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fe9d8asm12064256d6.66.2024.10.31.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 14:36:06 -0700 (PDT)
Date: Thu, 31 Oct 2024 17:36:05 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Eder Zulian <ezulian@redhat.com>
cc: linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH] cyclictest: Fix help text for '-a' option
In-Reply-To: <20241014215946.1833576-1-ezulian@redhat.com>
Message-ID: <0a5284a6-40b8-2260-d060-2aef7c653fd1@redhat.com>
References: <20241014215946.1833576-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 14 Oct 2024, Eder Zulian wrote:

> Fix the help text for '-a' or '--affinity' option.
> 
> Tested with the following command (output editted to indicate thread
> ranking, i.e., Thread 0 is the 1st thread, Thread 1 is the 2nd thread,
> and so on):
> 
> 	# cyclictest -t -a3-5,0 -t 5 -D1 -v
> 	[...]
> 	Thread 0 using cpu 0.	<-- 1st thread
> 	Thread 0 Interval: 1500
> 	Thread 1 using cpu 3.	<-- 2nd thread
> 	Thread 1 Interval: 2000
> 	Thread 2 using cpu 4.	<-- 3rd thread
> 	Thread 2 Interval: 2500
> 	Thread 3 using cpu 5.	<-- 4th thread
> 	Thread 3 Interval: 3000
> 	Thread 4 using cpu 0.	<-- 5th thread
> 	Thread 4 Interval: 3500
> 	[...]
> 
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index c5c3389..f3ab836 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -769,9 +769,9 @@ static void display_help(int error)
>  	       "-a [CPUSET] --affinity     Run thread #N on processor #N, if possible, or if CPUSET\n"
>  	       "                           given, pin threads to that set of processors in round-\n"
>  	       "                           robin order.  E.g. -a 2 pins all threads to CPU 2,\n"
> -	       "                           but -a 3-5,0 -t 5 will run the first and fifth\n"
> -	       "                           threads on CPU (0),thread #2 on CPU 3, thread #3\n"
> -	       "                           on CPU 4, and thread #5 on CPU 5.\n"
> +	       "                           but -a 3-5,0 -t 5 will run the first and fifth threads\n"
> +	       "                           on CPU 0, the second thread on CPU 3, the third thread\n"
> +	       "                           on CPU 4, and the fourth thread on CPU 5.\n"
>  	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
>  	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
>  	       "-c CLOCK --clock=CLOCK     select clock\n"
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

