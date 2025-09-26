Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107B1C28E
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916168; cv=none; b=mgICGcSJb41N7EXJzM0FilWniOgw+yGajRPxlJdEpPFMWq4nNjKvwzpL0Jh4DzCkFmqVwvlULpoNQ5GABMeDqN7avN12TYrEy0TclB9Tu/8TCf2o3x0vl/UxAP5lNWItVLHECloNWItBW0SGHcFCNVoZFBngTPDWS5TsmgDgVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916168; c=relaxed/simple;
	bh=0Os49Chd0KBQYOOGqV7x271ZI8l94BLAZ7/3GYdX1Dk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K3bolYnS3zTZkl5nM2SWQPJYKbGmb79dvwEKqvWQyI5P0j+SS9dTGRCuimF/kKa5oaTcR3Rhvaqtf0eHUHithg9lK5YAVxToJnwZBlLtSWx4pMbBhqqNazf8YGOt0oHJuioVtnM+6U00Ff+whh/zs8p1+y+LA2AemNAm8xB17GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adGNGkiq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adGNGkiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758916165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vHVNYS8mIE/25qQYkrgABda6E4D7h+ws7j8BwMs2mA=;
	b=adGNGkiqugNbQXb21gXFWaHee3ZXD+A1Obt1JzvjyPHc1SIVxyBxf4tzs1zr3F+/cf8RGl
	1jPfhFyJMNXXMaewxVWkk6TheFfcr5VTTPEmU3ckNuBZDywFwmF5xOH0EYYXgTxGVfEFqR
	bKNScqq62sT4Q4IVwn9lHrAnNJOAYjY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-p8QjUz7XNsSNmbWLbZnsMg-1; Fri, 26 Sep 2025 15:49:23 -0400
X-MC-Unique: p8QjUz7XNsSNmbWLbZnsMg-1
X-Mimecast-MFC-AGG-ID: p8QjUz7XNsSNmbWLbZnsMg_1758916163
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-84b9c23b8aeso575607885a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 12:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916163; x=1759520963;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vHVNYS8mIE/25qQYkrgABda6E4D7h+ws7j8BwMs2mA=;
        b=bHd9bFRQvhCdWJewvC7bCiOUwIy6OfBz1R+3AnSDl2wSBRXnusiLDlE+rJJjdDy6ML
         FvnjZwv8KDFqcx0Kei2KTs4Ki9Nn0tHxLl8iKwG/iu3CMRh+pacP5n6/d2Nisipr6oHg
         zuR/iJ4FJlGH4JkZqs3+BFRlcgB436Y0xSBM0yKQYNhbhXxhw9d87Ly4T7ZEH0iG+8BL
         JxfudZ6JQ38DQ9pAHDACk9GqY+DXgyjwTKrf+Tgeri7dY4q3tkVbga08ZP/8C9IFBcgA
         +DdEQgRkK1hvi5FynSqN1B+/Qm5g9N7e/uMp50r4BNEwKqjomKOPx9Z8BlClpUmZjyRg
         OfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwNZjzB+n6yngWi+HVChlV60RXdbrHoZT8NsQpvrVLh0untRxx79nLS9Es6+cYYQlnW2oW+XXeyeZDruW1MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nc6lUoN6dnvUx0M0FH3/tRHHtKV0fRz4FGKiMb8fsJk72GpO
	Ke5qD3LNIf5ADqRCVpSM3kEthplSm/k7e7FH+HFzziKNi9EJKOxrsZbS6xK07mUE6l4d5jKNrGZ
	NWd9k99b9fHMHIbms76z9/qUdjwNbWBbCqU8hQ/aywu8ko2pq/9vprUyUk4yJR27hg3o5
X-Gm-Gg: ASbGncvgjU4WHm7g9IhpVhttm9lDk5JM4p4/bTPKuLiVIn8soX5LDjTJEtCgR9TWmrL
	tfKq6WsYsN7Tw92fzjyCx1e96Zb/34Li5kfviyqw8NybYsxwt8NiKBVDiZwB0h9wLUPNWNsjpml
	kWy3RHGr8W5wapoX2OywwV759YP7dTqcA2ljeuT2uDNlC3CJsXWLmb61wNxbSXG3cGO/v5kBIga
	CaDPTHbR0EWowyw5P9CcLOlJHzV4ruSYYMk7+P01b5nwgvkLqI8Qo4GdZ5loAM8ETeuarR7rAJS
	pRh9VGqP8aWE0JQcFekBDVy3kTlSgldNfb/UA3ParcjevdXJNUvrkHgmmI7XGHnsw29/BxGxm4B
	SEmAUhR3G6i/P
X-Received: by 2002:a05:620a:371a:b0:861:3a1c:b000 with SMTP id af79cd13be357-8613a4a7a79mr543007785a.34.1758916163223;
        Fri, 26 Sep 2025 12:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpJvsFg+ydeDRh3P2RaGWMkCPIeEfSlN6rWEH3DYQ0WFD0LJJw0GnsG7rsAis72rOjYXyHFA==
X-Received: by 2002:a05:620a:371a:b0:861:3a1c:b000 with SMTP id af79cd13be357-8613a4a7a79mr543005385a.34.1758916162887;
        Fri, 26 Sep 2025 12:49:22 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-86042e32249sm199621085a.44.2025.09.26.12.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 12:49:22 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:49:21 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 4/8] rt-migrate-test.c: Check return values of write()
 and ftruncate()
In-Reply-To: <20250726091837.493915-5-yphbchou0911@gmail.com>
Message-ID: <840ece3a-1144-a317-8929-b200b6ceab6b@redhat.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com> <20250726091837.493915-5-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sat, 26 Jul 2025, Cheng-Yang Chou wrote:

> Add error handling for write() to tracefs and ftruncate() on shared memory
> to avoid ignoring errors.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  src/rt-migrate-test/rt-migrate-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 8afe083..e007ed7 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -61,6 +61,7 @@ static void ftrace_write(const char *fmt, ...)
>  {
>  	va_list ap;
>  	int n;
> +	int ret;
>  
>  	if (mark_fd < 0)
>  		return;
> @@ -69,7 +70,9 @@ static void ftrace_write(const char *fmt, ...)
>  	n = vsnprintf(buff, BUFSIZ, fmt, ap);
>  	va_end(ap);
>  
> -	write(mark_fd, buff, n);
> +	ret = write(mark_fd, buff, n);
> +	if (ret < 0)
> +		fprintf(stderr, "%s: write failed\n", __func__);
>  }
>  
>  #define nano2sec(nan) (nan / 1000000000ULL)
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

