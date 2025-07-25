Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2B28C865
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467048; cv=none; b=YFjMD/ka9D30Xmb9JicH0g4mwqJqINF7ha/nqXVxq717lXd7UBRPKKlvlSlNOCjCGl4kt1SKkoJ98VZfo0IVby/kp8hIBotCERomWnh3TgK6YJxCxim+NCXO64w1oaTMPtY9XUiNdd9Y1bRji49Rh1vJONB0a/7CgROiqKKZqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467048; c=relaxed/simple;
	bh=64WEV01am4iv3KtRRgfvDhpb6MHu9jDNHICd1l4dPQg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mptUQ5L/SlwCuY52lRDTNp3VP5BXM4LniGdQYbDQ38T2xFEhBhWAezJFn9BphpJGGY81jHVkqo9JDRCF85jHXVE85UgsDSTdaEAN+/9A6HYfpq6ewbN7gKbjdewVUmKr0QLWXtIRjrNuUWWoI6nK85xRvG4GDiaIugLYSFRA05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzYSl4b0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzYSl4b0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753467046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOPe0cfGzKY2lclOGgYsfxvhkyVQniL99ztaG4QLN5A=;
	b=WzYSl4b03WHOFwJ0vGLKHFNimqlJYAcOxT39PWFc5XFdUiDg51N6v/uCJQRTNcvwCGx8ds
	Pw7TDeh+YUMvT8fnLi0r0a+90NUeecvNeMC3h42cGyrbXRjM7FOOcLcHwcEKjWIIKHkhrX
	8yyf6Iavhhb+gCDmKfN+pdgYTLTOook=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-RHcP3vlqMtayYatwET6dqA-1; Fri, 25 Jul 2025 14:10:44 -0400
X-MC-Unique: RHcP3vlqMtayYatwET6dqA-1
X-Mimecast-MFC-AGG-ID: RHcP3vlqMtayYatwET6dqA_1753467044
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7070645452dso34578046d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 11:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467044; x=1754071844;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOPe0cfGzKY2lclOGgYsfxvhkyVQniL99ztaG4QLN5A=;
        b=Nz9WtCv3gikPNravHlnQXVTXGX+tnxpoAGFjJncGg1tm2X7L5xMwIwP1zHjlk37uWo
         fr4aNg/GnopMM242RaBftKy/ChZuMFf+6Q1Ky7zKDSzCZ74YrYPdWSplQuUNDzf38NXM
         SDrQD7PG8ozCud0IJa05nbMshHqrUTyOB6Vpsoi2e0RtyOlfe0KqKTdp5RKip+OpnjSW
         R2AHGjE070sjUKOTmOb1/mGENVQKdLDC8KxTZeDA6bwAPTD6M6+GpSOcQBX0nNOHMyBI
         a5t7KFH3jHEHqrPf+bXvb7lke6iWw44NhgFv/u3n62p5GcvSusbrWGtxMtFr20EgmHPj
         gqqw==
X-Forwarded-Encrypted: i=1; AJvYcCVh7qvDS5d8ozKD4bpiV7/gfUaRIoQCfdxCXJKcbCdoA6i88ZG4xgBQcSXNoh2/W+5GwX/Yf8jootmg5S9frg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3KnJMHHtHWR37aQ/PVr53wjoGnOf7ZldeLeQFI0um/7uzP3+
	wwtwLhjiuCFltjkni4E04iR9MFJ+sBcNmKdLHUUCjFlLPRIVpLu7w2MND4zR98zF0ZIu2SRixiF
	SJZXpaN9qDmq1R4QzzUEnq2S+VGglsDLyFTtZ45h1hHFXpp+aNjRdZ8IZaCqtYLJxqihw
X-Gm-Gg: ASbGnctpCdXp9o8Fb8Z6lbf+OZkWhQfsDHYaafe/lpJrjz1Pi2vn6qtw9Krzky+5NK9
	ngq4MS2WFotnkMTP3et9y0c0YfDgbqTGzWSp1XgcY68YgGW4gT3Ujcbuj1QbpBbtStO22fZoX/9
	mF97ZmuVS5VI629uzfS4DmNWtdfBerxd/8CxapoHmTzTlZB8bcoME9/rW4mbtkGr8Pn0YOmKhVq
	+U6kDAAzISQe1jP447I7QMkUvOWClR0WayeaDMAFR+hRiqEo6Tw4R+x7p713PED5jeK5Yy6wBkg
	XhDRMpSSv1WoUdS32Y5vvOuk56xAlw==
X-Received: by 2002:a05:6214:2421:b0:707:2ae1:8bde with SMTP id 6a1803df08f44-7072ae18e7fmr8907996d6.1.1753467043454;
        Fri, 25 Jul 2025 11:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHufbB64f8RuHQiNkgOdR8p6YIkhGYwXkGJN//iXgbepa1IZIgHunzAgRbyADIOcjBaElsngw==
X-Received: by 2002:a05:6214:2421:b0:707:2ae1:8bde with SMTP id 6a1803df08f44-7072ae18e7fmr8907346d6.1.1753467042781;
        Fri, 25 Jul 2025 11:10:42 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-707299feac9sm3068186d6.1.2025.07.25.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:10:42 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:10:41 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 4/8] rt-migrate-test.c: Suppress warning
In-Reply-To: <20250712134213.58582-5-yphbchou0911@gmail.com>
Message-ID: <524bcaff-d66b-c7c1-f8de-145b467d80de@redhat.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com> <20250712134213.58582-5-yphbchou0911@gmail.com>
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
>  src/rt-migrate-test/rt-migrate-test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 8afe083..d7c0bf3 100644
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
> +		perror("ftrace_write failed");
>  }
>  
>  #define nano2sec(nan) (nan / 1000000000ULL)
> -- 
> 2.48.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

