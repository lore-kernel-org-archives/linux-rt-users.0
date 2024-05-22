Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F71C6BD
	for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398242; cv=none; b=PfUG7+OUBRBHDTZ8FBaYr/30kf4MggLIt6vSiZmYXXWJ4/vx/UG9kYBLa2l3jqzZe7aNAVmg+vU9MdU8u1/eD9eb7RmqUu/LeAfwRe1H8svS9h5s9ZKaDUqQjEe4J0SeEatDCLgj0kWEqdwi07epVa2xao4re00Q8mb7FT+OBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398242; c=relaxed/simple;
	bh=dhbWayZZrr4p20Ubtv4RnvMiYgOSpnkc3cbSPxbdm7I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aYxJKGFAhnNWxVDtrFuq6Y3C3TjkgTMpJh7tP3YfcO8eejZPTwNMqDx7yG9N0QzfVk/VAp75vXnNf4KseAKT5DL7PhFGHVdMhGLYJqVdFojtjnskmyXVjTQA5OCICwWX5s5vY7UF2u4Kfl2SwNmjT9iA+VEbySWeIjvpOXjwPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUN2clNk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUN2clNk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716398239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ApIl08gthRsJ0w5QlTSX9RbPWvJWb29R2d8QJz6dEo=;
	b=RUN2clNkMGRGb+OD6tOxbeZCDYwxFRQYJNjL+dxwVdUbDSsJHAeT3CJ2eTRKRPqcGCOvbQ
	PMu4QCGEXtnm/eljzkN3l3OSFnj7bY2y5Rq1QhPo4TeAbrxj+DebRA4cbKFYWFJ2cTk9oC
	tAcOHTWCOsYdfXzB8G/0ATYdTBS2gZM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-H87d95J4MOOIBJy_rVqmkQ-1; Wed, 22 May 2024 13:17:18 -0400
X-MC-Unique: H87d95J4MOOIBJy_rVqmkQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6aa38593113so43847876d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2024 10:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716398237; x=1717003037;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ApIl08gthRsJ0w5QlTSX9RbPWvJWb29R2d8QJz6dEo=;
        b=vd7V5w/mxcba5YTpFzW3u3OHvCDwBNMuu+mtzG39D8lISl5RrjXicaxruylV6lZs5f
         G2SDk0wa8JywA8HCW1Tqf1aVpCYhpr7iIP4Bso3orc9nVz9KwGMcJpj3cwE1IFGmCoJj
         pIOxBBm+WTmv20biEhBzyg7jjAfgtnMKVeATgdxjGiMK7jC0pQ3r2jUJRrGwVGFLalbb
         ng4DopTCfJgVv1e6nUKMigrf8BJFWRkWu95MG3tLLfkArw/+FPvEsnudQ3ZrnLXm/ScF
         2rIZxgQP4bI4B6WeWC/kXZwYu9IWSU9ZLw0Pa+h++NlwqHebOgx0ekTY1OTMMMQgRcXQ
         Aw0Q==
X-Gm-Message-State: AOJu0YwR2D/E22qzon0SmzDTauAtc1Fdk8Cafl8sdDzMgRQfSmgo9hLy
	KaWKWGsrmh7sZXFwbMNDtDLVb+HJ6Je730LPbN14OTz2tbF9T+9xVozXnDqFB6t0PJpGW1ewoHi
	MXpIGiFJ0ZZiw/9y7mmJPwXnrfwVwwh6sbvE0RpBmGa5DwyX3pzWuH76YdWw0iqaq
X-Received: by 2002:a05:6214:3d0d:b0:6ab:7102:e090 with SMTP id 6a1803df08f44-6ab7f3536b2mr26568156d6.15.1716398237433;
        Wed, 22 May 2024 10:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3DgZpwKnvwjAPBK8MAMTppgM59Odr31HjrrZTr6oIJOa6GbgJFW9kRLojrURng0bLYqTYGw==
X-Received: by 2002:a05:6214:3d0d:b0:6ab:7102:e090 with SMTP id 6a1803df08f44-6ab7f3536b2mr26567916d6.15.1716398237045;
        Wed, 22 May 2024 10:17:17 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab84cd6d93sm6585686d6.127.2024.05.22.10.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:17:16 -0700 (PDT)
Date: Wed, 22 May 2024 13:17:05 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Anubhav Shelat <ashelat@redhat.com>
cc: linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH v2 2/2] rt-tests: hackbench: properly recognize when
 integer arguments are negative
In-Reply-To: <20240522144347.13281-2-ashelat@redhat.com>
Message-ID: <cb20ab34-37da-3bf3-c617-9af4eb1dcfa7@redhat.com>
References: <20240522144347.13281-1-ashelat@redhat.com> <20240522144347.13281-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 22 May 2024, Anubhav Shelat wrote:

> hackbench is supposed to catch when the user passes
> negative arguments to options -f, -g, -l, and -s.
> 
> Previously hackbench would allow options to accept
> negative arguments, resulting in undefined behavior.
> 
> Now process_options() assigns variables outside of
> the if considiton where they are used. hackbench will
> output a usage message if the user inputs a negative
> argument.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  src/hackbench/hackbench.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index fec8357bef81..55be325a38df 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -426,7 +426,8 @@ static void process_options(int argc, char *argv[])
>  		}
>  		switch (c) {
>  		case 'f':
> -			if ((num_fds = atoi(optarg)) <= 0) {
> +			num_fds = atoi(optarg);
> +			if (atoi(optarg) <= 0) {
>  				fprintf(stderr, "%s: --fds|-f requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> @@ -435,7 +436,8 @@ static void process_options(int argc, char *argv[])
>  			fifo = 1;
>  			break;
>  		case 'g':
> -			if ((num_groups = atoi(optarg)) <= 0) {
> +			num_groups = atoi(optarg);
> +			if (atoi(optarg) <= 0) {
>  				fprintf(stderr, "%s: --groups|-g requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> @@ -444,7 +446,8 @@ static void process_options(int argc, char *argv[])
>  			print_usage_exit(0);
>  			break;
>  		case 'l':
> -			if ((loops = atoi(optarg)) <= 0) {
> +			loops = atoi(optarg);
> +			if (atoi(optarg) <= 0) {
>  				fprintf(stderr, "%s: --loops|-l requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> @@ -456,7 +459,8 @@ static void process_options(int argc, char *argv[])
>  			use_inet = 1;
>  			break;
>  		case 's':
> -			if ((datasize = atoi(optarg)) <= 0) {
> +			datasize = atoi(optarg);
> +			if (atoi(optarg) <= 0) {
>  				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

