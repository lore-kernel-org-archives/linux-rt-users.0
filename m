Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F0148FE7
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Feb 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891668; cv=none; b=LvLMuE9Bv5k42EKlh/PTBh+c2x8evGfrl/R19WXO1us0XrUqa8+xDb0GCDYhiLfKVcJD6aSGYyWB6Ns3Sj6JoQpGISz92MtsPcdJck2A6/3VDGXJjuV5h+Y8IxlKLkeDo2EM7oALxG8H4GvER7JpNghyNznLlJ9o0H3S4Jf5oYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891668; c=relaxed/simple;
	bh=tOWgqKPJ8VWHr1r6uBiISjYmLTMYT2W5T0lLLM039zQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PByjVKfqaYQa5LUtCxBJB2kZWwiq5LBvfZuhzxXeWQLm5vtkhGvlhUui0JXyrjIwSOcy3fe3EP4+VqZXKP9D0MTKMdt9I9lHVDTEfcatxcAar0lsJsyn9QHIF9UTjh2AsaWL985p/8htpsA1EejN55kjCWZ2Og8ElmPwHjZJCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ygi1zheR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ygi1zheR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706891665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a51lYtROgxAWvI1Dw0KFYYq8dK09nzCPlWXeuw+0oeA=;
	b=Ygi1zheRAkFHRCKw6HxeiQRg8Pv2eTgQiSRurYTvVcMawMqKLTFcN68xNgX/1vwkbElYL4
	DjnUF5lmj2hbsfRQg4KXf/bI+ndBIvOxBv2r+Jd2mjLAvuJmD2pbByxXeL4Vhh7slQPGGS
	UErRLVn03kRBpFLB7dz/JhLqXZJbBRE=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-XFfxS0cWPdGgywDgSxZrUw-1; Fri, 02 Feb 2024 11:34:22 -0500
X-MC-Unique: XFfxS0cWPdGgywDgSxZrUw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-21941c0f19dso9984fac.2
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Feb 2024 08:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891661; x=1707496461;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a51lYtROgxAWvI1Dw0KFYYq8dK09nzCPlWXeuw+0oeA=;
        b=VgbQanEERpnAlvvziwM0AQuELov43P6XUGpDOS3B2NW8fPXatfE6EplIkq9RxvYWCu
         kIAhrwmRjl4gFQXxblkimQNDPqJVhrpPQ+0gmEt/H5xXE+JZ5eseTE7RK2HZnz9umZZX
         J6sjWcSU+bSH41Wpk2kgItQyLC/R1+DkQ+WTyJrty0bTcW3y2KzDq/Gcg3uZAIyDIbZ9
         zGZBkT+bh21wF4ryI6atfr5iuiCXTjjTRU/ddm9uknnbZcC9n4Rq8YSKBPdJjX+LW7OJ
         qm/TQNTn3//5gCI+gUf7IIDGJl2e9zpC7jM9wLg4jLczpAZtEdnN0NDxo/59DWqUWKNE
         /KPg==
X-Gm-Message-State: AOJu0YzTxjPWIjen8JmCWrq0rFuvZCdNP2ebjxbZonXyqF1ytRylKeHF
	rHxUrlrLhs91s1RBWCQpGGlC1CdbK99noW8T2Olb1x0tgXKPdba7RmwLHEUFxRZS0zmZTV/2NgB
	NA6TxQ/gzIB1X3JLe6II8ki74HpqWRb9ES/Z4BBZ4Qt4MM4zcVKjvHx1ouXILiFCd
X-Received: by 2002:a05:6871:7243:b0:219:1fc4:81e6 with SMTP id ml3-20020a056871724300b002191fc481e6mr208044oac.49.1706891661284;
        Fri, 02 Feb 2024 08:34:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFafISCi3HZ+94zcvJ7AFqXpFkVlObMNId86fkCwuXg6kjl9JWmP2F91EKlbzhpu0ZShF+Hg==
X-Received: by 2002:a05:6871:7243:b0:219:1fc4:81e6 with SMTP id ml3-20020a056871724300b002191fc481e6mr208029oac.49.1706891661052;
        Fri, 02 Feb 2024 08:34:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX9Ih1U5d7jM5wY96Hxvs7d+andz44jZNWNmwEFdOYuLdf4tdrtM2zElAjJLUTd/y5tpvdFxo8/BGKvvch+AbIS8ZL3OQ==
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id mc6-20020a056214554600b0068c4aabcdb6sm940216qvb.29.2024.02.02.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:20 -0800 (PST)
Date: Fri, 2 Feb 2024 11:34:11 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    Chuck Newman <chuck.newman@hpe.com>
Subject: Re: [PATCH] rt-tests: oslat: convert to nanoseconds correctly
In-Reply-To: <ZbvZ/l9zKjU8Frvy@tpad>
Message-ID: <0a607b79-846b-f55b-a891-d00c3e630baf@redhat.com>
References: <ZbvZ/l9zKjU8Frvy@tpad>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 1 Feb 2024, Marcelo Tosatti wrote:

> 
> With buckets of size 1us, accounting for measurements in the
> [1ns, 999ns] range are done to the 2us bucket (while they 
> should be accounted in the 1us bucket):
> 
>     001 (us):	0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
>     002 (us):	41916187 41937649 41938461 42029055 ...
>     003 (us):	969 985 958 972 964 986 970 961 973 ...
> 
> Fix this by doing a plain cycles -> nanoseconds convertion:
> 
>     001 (us):	43287555 43086678 43087427 43109974 ...
>     002 (us):	983 987 985 975 982 960 993 961 992 ...
>     003 (us):	9 6 7 13 9 22 3 21 3 3 8 8 10 11 3 55
> 
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> Reported-by: Chuck Newman <chuck.newman@hpe.com>
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 4bdca64..13e887d 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -334,7 +334,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
>  	uint64_t extra;
>  	double us;
>  
> -	lat = (value * g.unit_per_us + t->counter_mhz - 1) / t->counter_mhz;
> +	lat = (value * g.unit_per_us) / t->counter_mhz;
>  	us = (double)lat / g.unit_per_us;
>  	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
>  		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %.*f us!\n";
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

