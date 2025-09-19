Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632BB223311
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309255; cv=none; b=l45DMZIIJ1jttLG4U7RhDBlvW+NT0qpl6UjNb3iENTI95i6vicuHQUvJcs2bOVulfOMTE2DSESA45CTyzzou7fDmnKQ2GpuqH6OjbnQ6daa/065+/vQwzRtiuvm4/6MmtqV6QMgnjnY7Ay0qTfLLgo1+6bCX2lZwsOaJYZJ1L6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309255; c=relaxed/simple;
	bh=c4HgYwbxnkM6o/jKgxKAWhg95ZTuy0v/+gOjLiKYfnY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QR5AZTVOtkVrIpIgXREnKhq19EPTXPCp2wY/LL3/vJ8BJW0xY9ADjibKd8v6j/cUZY9qNyLBZARHBC7vgwi7R3wtfcHwYmP8aCZHMS507Qp7UJ8IxRW9gjg9MgeioqPLm4QkbYw0MOwUaEOELiu2V/sw0mbiXZVVkgO1h/lknGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iO5JXyNb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iO5JXyNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758309252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TR/hBrMdvcQfNhkiIOiJKhAM/L4vfWHY9mq60yMTVXw=;
	b=iO5JXyNbOmIZ4oGqKIBGqpSnJSH02uNDNPudPkBqW5aKc3ALji7tGRKkW0hX7WuagUE0PB
	qh4uy97lVrfsbuWsvy1TzQt+NR/LjoR7b978cVHYu0prZ5GaYj8AseFTvAosxJZoSDtx85
	qCjm1Q98JchymwiU91616k4wBEhlxpg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-8x8gGpq4NoOhctg9iOVt9A-1; Fri, 19 Sep 2025 15:14:10 -0400
X-MC-Unique: 8x8gGpq4NoOhctg9iOVt9A-1
X-Mimecast-MFC-AGG-ID: 8x8gGpq4NoOhctg9iOVt9A_1758309249
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5d5cc0f25so42291301cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 12:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758309249; x=1758914049;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TR/hBrMdvcQfNhkiIOiJKhAM/L4vfWHY9mq60yMTVXw=;
        b=T9uvC6wpVpchF5ZZegSObKB26gU1OplMLcZs2iRN1LGHUSn33E7jOO89ClSqQnt8UM
         TrEMWMjkts4YVf2Lp/ow/4aeWeZnfs7kAY5WiibPKw0wE4RDNRlXGZ4LNt1xprGOQdOR
         3nPZU19zdWYeNhq0R/8qwY6majH0Ls5DcJLjSC4qUCdWQDZp0nVRiAeWISz8wwaSPYIX
         FTK1tJASV4uJRph+FKoHTSylgN7dmUWpfGOZbtLq4tMGEz2b6QOdn+77HiiYcut6F76q
         IziJIHtWD9e8jZBTDeE9d2uqpxmabVopLMVrywyh6D1RBldPTm3RwgqWQ0R2HrkUSAGk
         v4JQ==
X-Gm-Message-State: AOJu0Yz0bhdwzpzX42CeT/oibS+38WsuYucX5UYDh1TDPyXMlJ+OA81l
	HEfHHq4tykdIxAn01ptMOoUv4lcgmI2qc15ACl9NT7JkkpszXwrxRKIESVJJTAgIXyKVIncQHMU
	Iy8Yf/iaz5bdU+4Nu/iM6Evnt0WE5ePYHlCHZAdvxysh/EYcFZgxzwXg74ubxDXl87Zjv
X-Gm-Gg: ASbGncuXbsYsZHs7O/qj1TxZq9DA7QT8qa+OSYh4XSSwbM3Ca54zJN71U8idZcMBTci
	SYSwHaR8kSZCiGqvqSZuWaqAg7P8Acw+TK40RDnZoG1Ea7vNNcmp64q73ri8dmQ1e01QNxJsLMx
	cd0O+J96PZdzzbNMIKlYjjGSNYflyRioaWWzHb5UW+hJewVl5AsMKMi1LeYSPRst6WoqhGrDyRM
	fF0TX6ThpqnLPWQ2blRHxGWWJW1a+kepcW8zntEMG69hLX1bIH9Tptfovk+WQrLNEsKluatdqz+
	sXO5iL2jBXSra2JerlMrKfLN6NGlOMkDDE6imHjXVm5nqDemFdbf9JjRkneAu6dykmzo
X-Received: by 2002:a05:622a:5c17:b0:4b0:edba:5a47 with SMTP id d75a77b69052e-4c073e88e08mr56845831cf.53.1758309249217;
        Fri, 19 Sep 2025 12:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmuuARR3Z3+9Ln4+MduJhHEHtl31WmblQnPayTGV3udGFtcgPa+bqflLZM8tZ0udKMc7H+vw==
X-Received: by 2002:a05:622a:5c17:b0:4b0:edba:5a47 with SMTP id d75a77b69052e-4c073e88e08mr56845301cf.53.1758309248656;
        Fri, 19 Sep 2025 12:14:08 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bdaaa8a962sm32484561cf.53.2025.09.19.12.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:14:08 -0700 (PDT)
Message-ID: <e7e2fc6bba36dda627e557aa319ae5b0ae47294d.camel@redhat.com>
Subject: Re: [PATCH v3] ssdd: mitigate tracee starvation
From: Crystal Wood <crwood@redhat.com>
To: debarbos@redhat.com, williams@redhat.com, jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org, oleg@redhat.com, shichen@redhat.com
Date: Fri, 19 Sep 2025 14:14:07 -0500
In-Reply-To: <3yq34kwrfmwvhy5la5wutnmbdd6pf4rwnvnvnapegvx7acq7xu@pghcpahcvndz>
References: 
	<3yq34kwrfmwvhy5la5wutnmbdd6pf4rwnvnvnapegvx7acq7xu@pghcpahcvndz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 14:11 -0400, Derek Barbosa wrote:
> -static int check_sigchld(void)
> +static int check_sigchld(sigset_t *set)
>  {
> -	int i;
> +
> +	struct timespec timeout;
> +
> +	timeout.tv_sec =3D 10;
> +	timeout.tv_nsec =3D 0;
> +	int recv_sig =3D 0;
> +
>  	/*
> -	 * The signal is asynchronous so give it some
> -	 * time to arrive.
> +	 * Check the handler flag, then if need be, wait for the signal to
> +	 * arrive
>  	 */
> -	for (i =3D 0; i < 10 && !got_sigchld; i++)
> -		usleep(1000); /* 10 msecs */
> -	for (i =3D 0; i < 10 && !got_sigchld; i++)
> -		usleep(2000); /* 20 + 10 =3D 30 msecs */
> -	for (i =3D 0; i < 10 && !got_sigchld; i++)
> -		usleep(4000); /* 40 + 30 =3D 70 msecs */
> -	for (i =3D 0; i < 10 && !got_sigchld; i++)
> -		usleep(8000); /* 80 + 70 =3D 150 msecs */
> -	for (i =3D 0; i < 10 && !got_sigchld; i++)
> -		usleep(16000); /* 160 + 150 =3D 310 msecs */
> +	if (!got_sigchld)
> +		recv_sig =3D sigtimedwait(set, NULL, &timeout);
> +
> +	if (sigprocmask(SIG_UNBLOCK, set, NULL) =3D=3D -1) {
> +		printf("EXITING, ERROR: unable to mask signal set\n");
> +		exit(1);
> +	}

Why unblock it at this point, versus just leaving it blocked?  When
would the signal handler ever happen, if we're blocking before the
signal is generated and consuming it before we unblock?

-Crystal

