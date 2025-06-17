Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F9D2FA637
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Jun 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750181641; cv=none; b=hY8+Tmq2q8hGDdSXOaNZU1GdYKM44TmY7jmIwhP5SYholcqGaokkl6oJZXIpcqI0gZpGp/AVctJ/pF7wZKlufLVtA3QmRdGXT7aU6gwrUkaB/AHBso7Dj8/6MMvgs/rODQ04ZAjaSM/pzXR+jKF7/xg5R+Srnd5/biE04ciMbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750181641; c=relaxed/simple;
	bh=XdK5sBAP7wRC4v7eo8m3LWFK2Ood+u0VEgdKMuhRVBw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hj1LgmsNEIIcp5y6BY05riYP1fgMM1QQkfcjk/NolEBFs1U98jlu7NXsAQRaxJd8dtpmyrEc/QrrtVlIwIJwcyu4die2oqZVf8Hbn2QyFP5VfAYb5F9Yyfu82Hwj2sIt89z2FDllGENapRl++JvzqA4ykQ/qNZjlX7v2nPC8dKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSm1leHs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSm1leHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750181638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VRBFI3oo/Vkh6HuQHUgMmmfrwgAESb3yZ9oeYYBsYf4=;
	b=gSm1leHsBfJ0sUaY8w8L6378JpamLmRRem2w1o2xyJCKt0WbLn1vloq3HETv3FzSpm1dS5
	QWC0ra3OxybUc+8JkGRHWpPLWr99dEv5TmzTdJ5cjtDIGbQR9Ycly3jmE4Ua863+VfppGB
	vhPID7bgzXu0olLVxPj0XMh7AFfKZlw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-xI43fIIXNuOEIyDKBf4EeA-1; Tue, 17 Jun 2025 13:33:56 -0400
X-MC-Unique: xI43fIIXNuOEIyDKBf4EeA-1
X-Mimecast-MFC-AGG-ID: xI43fIIXNuOEIyDKBf4EeA_1750181636
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d22790afd2so940496685a.2
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Jun 2025 10:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750181636; x=1750786436;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRBFI3oo/Vkh6HuQHUgMmmfrwgAESb3yZ9oeYYBsYf4=;
        b=BArZt9VUkxvAvjQ4AWIxiLXd1HhXnew8yWX2rbsnNAKxo/oeYt+VtzkvGJZLFzxAyE
         15XRwkSAxaVZeobhxmAz2UQ25mGP0/U38yu82V+dHjsuVvf0eeAAvPwUZRJ7V18A81Cn
         UoDl446tynCmOYmGsOSVJXZEqv9SC+/Epv7i8d/BG7lSCdHStNGkEonLwxwLv24FKKvP
         3HnBnCkaDVoNVoYN8206FkGdf4LZP0MBj6tvsQONwDDZJa2squ+NCc3ERiH0aEWFMYbw
         67rKhAn04PLgxCgnhu9hehLIRQjiz3/G15X04yzVupX72BiAW5GgATkIdLjfyeAQ38TG
         qN4Q==
X-Gm-Message-State: AOJu0YxT0oLt3jrM/nT3SQDWkLwufEPDbYTlEvStsFRbVQO5VzL8Vwws
	06UvOGaNF4n0q3rT8gS3LR7g+eVgguTB15FM+S79soC5mH26+7jWJJ8jdTbL2hMM3U4QD4M4gA/
	wH018w4XH3LAPe4QqV2VaolznRN+yeCcsnyj1eK/8rYIv72gSJv5fum6uRP7p9OIkcaJV
X-Gm-Gg: ASbGncsU5u9d9xzJz7DZWpLBuUULSSCmSiM+T1dNa6IRTvfVJ7Z62RqSVf1g/6ZST7U
	wcYLKQQMuSaJdECJTxjuaPk8Uat3mT7dwdudcz7ru2HTzGoMfegCtYSWfvfaMrTwVsqxO8PnY/t
	3FP6AlAH/JVjGdoUen9dsMWgr8j1aUEBMlDoxBwz1NAHWZODYK2nMvV+znIW7o3inwggMSEdI2s
	v3QTwx1Wy6p//h1wwyfDk64+Y6qJSSHgbMGKOG1U95Fg7Zwu2yUh2OgOHTnhbALpDu1U2/Blsn9
	Um+jwDhiPwPPLVd+9PAV3WjuPxvays4n9YObGXRYoiYmVxEoW+WPxLLylBbPXGQpjNjPB4qc4g=
	=
X-Received: by 2002:a05:620a:4012:b0:7ce:c4c7:9b81 with SMTP id af79cd13be357-7d3c6cde7damr1725233785a.30.1750181636007;
        Tue, 17 Jun 2025 10:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDHMhB5jS/sTG/7uBspQZefw4/maM8ZbLZ1sih5e21Pr0Xz1g7+k+jP+C++4PC2QP56KiO1A==
X-Received: by 2002:a05:620a:4012:b0:7ce:c4c7:9b81 with SMTP id af79cd13be357-7d3c6cde7damr1725230185a.30.1750181635634;
        Tue, 17 Jun 2025 10:33:55 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-14-76-71-123-140.dsl.bell.ca. [76.71.123.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8df63fbsm676118285a.25.2025.06.17.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 10:33:55 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:33:54 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    Clark Williams <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Add a grouping separator to
 tracing_cpumask
In-Reply-To: <20250602160342.2740857-1-costa.shul@redhat.com>
Message-ID: <3aa05dfe-9b17-4506-b62d-28fa20c5324c@redhat.com>
References: <20250602160342.2740857-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 2 Jun 2025, Costa Shulyupin wrote:

> Writing values longer than 32 bits without a comma results in an error:
> 
>   echo 100000000 > /sys/kernel/debug/tracing/tracing_cpumask
>   bash: echo: write error: Value too large for defined data type
> 
> The bitmap_pars() kernel function specification:
> "Commas group hex digits into chunks.
> Each chunk defines exactly 32 bits of the resultant bitmask.
> No chunk may specify a value larger than 32 bits (%-EOVERFLOW)"
> 
> Add a comma as a grouping separator every 32 bits to a hexadecimal number,
> as expected by the bitmap_pars() kernel function.
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> 
> ---
> Cnahges in v2:
> - rebased
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  src/hwlatdetect/hwlatdetect.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index dc28f38b751a..946bef33748b 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -33,6 +33,11 @@ def info(istr):
>          print(istr)
>  
>  
> +def group_sep(hex):

Can you rename the above since hex is a python built-in?

> +    """ Add a comma as a grouping separator every 32 bits to a hexadecimal number. """
> +    return ','.join([hex[max(i - 8, 0):i] for i in range(len(hex), 0, -8)][::-1])
> +
> +
>  #
>  # Class used to manage mounting and umounting the debugfs
>  # filesystem. Note that if an instance of this class mounts
> @@ -494,7 +499,7 @@ def microseconds(sval):
>              for i in range(l, r + 1):
>                  cpumask |= (1 << i)
>          debug(f"set tracing_cpumask to {cpumask:x}")
> -        detect.set("cpumask", f"{cpumask:x}")
> +        detect.set("cpumask", group_sep(f"{cpumask:x}"))
>  
>      info(f"hwlatdetect:  test duration {detect.testduration} seconds")
>      info(f"   detector: {detect.type}")
> -- 
> 2.48.1
> 
> 
> 

