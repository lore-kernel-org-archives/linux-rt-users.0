Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A0F1C8FD4
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736804055; cv=none; b=RzeE1n5gGa6vBPDutxfVZoL3KOFxwCtu52S5CllbmzG594B49+n2+BJFtRvgPbjQVHxH70BLmlTxjiSJ4a6h4MXZVyZYWTZ15i+x8Qut1sxYtOToqpH86vvoQ2wEjB1tVIOCg3T+py2qy6TKBVmwLhIbrVENLcu1+1x/QJSOQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736804055; c=relaxed/simple;
	bh=tk43YeP0Xo39WSYwdOJphXNk7Z5pY+sRcAWPuWU3dmo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dvSz8JrT2MFYEFwR6czUi9QlA4ffPJ6nbimIdxrfYKi0Bq9jiXc40ksNt0fznnfDfxyX0KmK3OaOFxqEA78o0wERJRgPGz6dM5REfZSaW5mx4aWesLu6YwveMWbSO19iMPgZDAQLfT1xu2DnD6Vy232HK/0iy155uE4WD1mJkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWR9YdrF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWR9YdrF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736804052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ua9fkjJSNgJYo/av8RaZ3nicxGrp9Ng1VM214HPfxng=;
	b=HWR9YdrFo9lHCDzjAnzi1ee9UGH6nEk51bYZji1E3SGwCIfcaqpcoPL7ggtedyAIaMqzgC
	O04JJG6NuZoi1lrVnqSd7fVa3QipdYOsoezNVrQFXZ6WCUswQs+wtw1DtjTjdNlSSutjZ5
	b7HiQL/3CvCIJYHo72tAKP3n5iNzD38=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-NNxdhi9CNw-fnO9iKvW5eQ-1; Mon, 13 Jan 2025 16:34:10 -0500
X-MC-Unique: NNxdhi9CNw-fnO9iKvW5eQ-1
X-Mimecast-MFC-AGG-ID: NNxdhi9CNw-fnO9iKvW5eQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d87efed6c4so78230476d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 13:34:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736804050; x=1737408850;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ua9fkjJSNgJYo/av8RaZ3nicxGrp9Ng1VM214HPfxng=;
        b=t4Y5YMIU/7ln7g00y3jWMrPzqxvP34ULP2Aqr0bcw80GfLHaUy2qSwzdeNpzFfxRJN
         gU0LkIT1ypME9iwXTUlX3bTGPvQITUZfkp9X/jQFwWR2hmd+bOc5UKjJVswIL7vUthH9
         iLXGjsnP7SA3PTFBoV46hY1Iu7JS/ApZlYtgczs4I17yaqs56lZDhZ+XNxkL1LTW3141
         Q1y86rI/L2omKIYLYwCnj11ow5VayMn+QBSfEy2MrWV4d4AUfXNg9iLo0VVo/VbL0Kkr
         VxP67Pt5/Xyg9CMOFuExbORsc6dkb7bGpkHQcrMgkC1dlYXACyJDpZ0Ta/lWgWSj7Tdi
         9EsA==
X-Forwarded-Encrypted: i=1; AJvYcCXQbY0lJfFzl38yqemszLoxs7uaWFJL65Zej5hauSGmd+ZRrxSaDPZOnMw4GG79f1KKTQJZkGUEWS5zcj9iCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFD/RjMInXjSQ4B3YOGzkfmtD53gVu6qP8nBbRHs9NbVO485D
	lSjFuBMJsEhDdgoN0KUtiwyvMJareKd1tTJrOAwwyAm+nEKq7uCiOszM2I8kcpXJb94LgFEjlIm
	6eVQ0yeuQEodr9hrQWq+AcjPEIZX2siOYTVJKO54x5jfNDQatSe6l/PJDeuK2Vzwx
X-Gm-Gg: ASbGncuo5TY3ZBKmHxi6jvBQTepwX82C0CyzwzeGeJcePh9BR4nWq+vxIMXCKcpSFr8
	ru9n9eTtjclrysbWoKaS76YoiiCJfsKAq8jcGPQdYBaB74O0PTJP3f00Gaumi/zRR05kM+V6jV1
	okiDwGsEe1jLP6fEqs6+935fDzoyTTcNAK1LMgxhrgeQfiDwf0ZCR6Umf3g6k5AknfOa2BLKK9K
	/4hpjJ18qGDp8MghrzIl322WdvDPlN/+44uZIgMYoXsCgY=
X-Received: by 2002:a05:6214:19c5:b0:6d8:8256:41d4 with SMTP id 6a1803df08f44-6df9b1f00c4mr389496296d6.19.1736804050250;
        Mon, 13 Jan 2025 13:34:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDgX+VZGGj1nrAem06J45boo8Ql7mJEfe0iwe00yd5N86NAjoNa91oom4dxSxTj3Vf8OJEyw==
X-Received: by 2002:a05:6214:19c5:b0:6d8:8256:41d4 with SMTP id 6a1803df08f44-6df9b1f00c4mr389495956d6.19.1736804049899;
        Mon, 13 Jan 2025 13:34:09 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfadeb40eesm45331046d6.123.2025.01.13.13.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:34:09 -0800 (PST)
Date: Mon, 13 Jan 2025 16:34:08 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Allow configuration from stdin
In-Reply-To: <20250113121856.225406-1-gmonaco@redhat.com>
Message-ID: <8d23151f-af7c-1b75-eae9-c8d88fa1ec3d@redhat.com>
References: <20250113121856.225406-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 13 Jan 2025, Gabriele Monaco wrote:

> Modules can currently be set only via configuration file, if rteval is
> called from a script run on different systems, the only way to make sure
> the loaded modules are known is to provide (or generate) a configuration
> file and pass it via -f/--infile .

The config files are almost obsolete.
Everything has a reasonable default, or can be set from the CMI
The one exception is for the measurement module.

What would be useful would be a CMI interface to switch from rtla timerlat
to cyclictest.

Thanks

> 
> Add the possibility to use - as input file to read the configuration via
> standard input.
> 
> This allows something like:
> 
>  # rteval -f - << EOF
> [measurement]
> timerlat: module
> 
> [loads]
> stressng:  module
> EOF
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  rteval/rtevalConfig.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
> index 0c2fc6b..4c41ed7 100644
> --- a/rteval/rtevalConfig.py
> +++ b/rteval/rtevalConfig.py
> @@ -238,10 +238,14 @@ class rtevalConfig:
>              # Don't try to reread this file if it's already been parsed
>              return
>  
> -        self.__info(f"reading config file {cfgfile}")
>          ini = configparser.ConfigParser()
>          ini.optionxform = str
> -        ini.read(cfgfile)
> +        if cfgfile == "-":
> +            self.__info("reading config file stdin")
> +            ini.read_file(sys.stdin)
> +        else:
> +            self.__info(f"reading config file {cfgfile}")
> +            ini.read(cfgfile)
>  
>          # wipe any previously read config info
>          if not append:
> 
> base-commit: 5edb31a58bea3c2433e817439e053b79221a06df
> -- 
> 2.47.1
> 
> 
> 

