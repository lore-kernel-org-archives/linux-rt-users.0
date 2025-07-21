Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C001E5713
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128222; cv=none; b=n95YCcw0zWPgLXVjvuhaOeoEuy2B6RBVI/jGifIr4MBep8ndd662EAvFS8WMH1D4S6zjrdUi5zf8SybJsWSAprO29UJ/P391uuYo3dUkE12r71btjSVRbb8fZ8K7WfAVZbV93m/AJYMY+ZJt1gWIeBqmJVmFAnxNJpPXXA2PK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128222; c=relaxed/simple;
	bh=erMYa38SFjbBvMCeglJ0g01BOBf+Y4JzQQL3vUYPGf8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iiznOCRfMIt6XFKCyIeEk0GA/jfIfeNlyMpm3fV6ha7jNPb+WTGyNoAO/Srt78ztlln2GGGZgoz5/pLeRZhNKaoUAHBCx5DTLbxo1lUhARjNVQCRYMuyizyKBpVYKq6Z29mQCFOh4YU7Pydo4DpZg05kmB6gJQXKFmOdF7w8FRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaXqJ7V+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaXqJ7V+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+IHxME+c5e5cNrkgbOLuiDMh43rX3XNWh69bkyEtAE=;
	b=WaXqJ7V+jP1Ti/1EdiA2erG6JJJNzH7uv7bSd57nWhOxI7E5DRnuTMSp5IZaCsnidrYF3/
	QgjoFp7CtBvfywKEm60uU0p+YwjAOROa/Ir3fcmhtsCLXcx+fI8ztmarZERb3pC74OKEK6
	TLQlLZPadRfKlhMVsnuJ+ktSAkZeIXo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-R1vSctqnP9OS-nhzMzW9zQ-1; Mon, 21 Jul 2025 16:03:38 -0400
X-MC-Unique: R1vSctqnP9OS-nhzMzW9zQ-1
X-Mimecast-MFC-AGG-ID: R1vSctqnP9OS-nhzMzW9zQ_1753128218
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fafc9f3e1bso71956936d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128218; x=1753733018;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+IHxME+c5e5cNrkgbOLuiDMh43rX3XNWh69bkyEtAE=;
        b=ULgt7+kkzIHT8RPl6J5bNKE1nUr7hSmlbAdimSn1x+jbf+lWdp+N0oBUtMcP00lQ8W
         cLKkL+OTf4B/1BOKr6uMLmfAO91j70ACBNSokob23ox9IqlVhV5qIedcE5cL+ovpRs1h
         pYJWypef6xknDBJuOWnqo2k6DPe0n85Gf2bW/r4QiO03eDAaAlChYbwnncpTUj9HKslK
         YNSHRSGk70WSP/a1ArJlp9ySl0jwLXvVSQUsT1wUf3cSzby9E65xULeXeu7GJYxZb0UO
         FumyaMnX5BAjmE9KwVy4SI22pbR+O0r1np8B68h2iTQb8ZkrOVlU1BJDedpiP+WYkfkj
         jSRg==
X-Gm-Message-State: AOJu0YxHg4OhKHld+rhvd47DGfI0olkqZ5gIOEV0HAKdnFjJXZL5uJ6O
	s0sfPuT3KFmJpHAsLTIWGCmRSpauUeN1M/TjJP4TsljZAqxg9+uH8F5NY2l6nBASrHp1onk1nNH
	GhU4XEW1jbwfskaPnGwCu80KBkM1HTlfd4H+wVG1HQ7hGW++iU7W4tVFvEAqXH/jt+kt6
X-Gm-Gg: ASbGncvRXlmJ0e7FcGIxbaVVjVPfUrZTlYl4sUxskPD/JZ7pqZwcT8rt4xn434Xlvom
	Io6oJmevd1OnbOE7RE/Wm7ikSSDwacw7/UdTyTzXTwM6vMR4fOkAbzTrKRUgZiQqWB6mZKUngir
	NdiRMLJBgNIzwk63yW7Z1pnV3spGKDDdGLoai6cvfpnmwYRWcdaZon6yUFP6bcUIqkX6xPal1kR
	QG9VoiIDMbwvP86QvfveJa/8u7YUZs0I4cajzSf0acOuc+KYtG/jaYsMD6LMm27fPNb8Qc2k+FL
	AEkVNXORHuQugG3JnfjLOaQ8HhfjFQ==
X-Received: by 2002:a05:6214:419f:b0:700:bce1:495a with SMTP id 6a1803df08f44-704f47f9fc1mr299891386d6.1.1753128217873;
        Mon, 21 Jul 2025 13:03:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsFybuHVv1sXz2HRoGz0kovxhghoPRBChSEmLxs3d/yPdUoVW7YkZttWGG48tOj6Zc7cbYsg==
X-Received: by 2002:a05:6214:419f:b0:700:bce1:495a with SMTP id 6a1803df08f44-704f47f9fc1mr299890806d6.1.1753128217239;
        Mon, 21 Jul 2025 13:03:37 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8c04fdsm42626136d6.15.2025.07.21.13.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:03:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:03:35 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 20/28] cyclictest.8: Group tracing options
In-Reply-To: <20250704132721.13325-21-darwi@linutronix.de>
Message-ID: <6584ffee-0467-fab9-824c-74516bee8f3a@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-21-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> The number and breadth of cyclictest's options is huge, and just
> exploring them in sequence can get the manpage reader lost.
> 
> Put the cyclictest's system-altering options:
> 
>        -b, --breaktrace=USEC
>        --tracemark
> 
> into their own group.  Adjust the Synopsis accordingly as well.
> 
> Further groupings will be added next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 90a3e08..964996f 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -37,6 +37,7 @@ cyclictest \- High resolution test program
>  .RB [ \-\-priospread ]
>  .RB [ \-b\~\c
>  .IR break\-usec ]
> +.RB [ \-\-tracemark ]
>  .RB [ \-D\~\c
>  .IR duration\-mhd ]
>  .RB [ \-f\~\c
> @@ -59,7 +60,6 @@ cyclictest \- High resolution test program
>  .IR num\-nodes ]
>  .RB [ \-\-dbg_cyclictest ]
>  .RB [ \-\-smi ]
> -.RB [ \-\-tracemark ]
>  .YS
>  .
>  .SY cyclictest
> @@ -186,13 +186,19 @@ v1, PROC-SET, if specified, must be a single CPU number.
>  .B \-m, \-\-mlockall
>  Lock current and future memory allocations to prevent being paged out
>  .
> -.SS "Other options"
> +.SS "Tracing options"
>  .
>  .TP
>  .B \-b, \-\-breaktrace=USEC
>  Send break trace command when latency > USEC
>  .
>  .TP
> +.B \-\-tracemark
> +write a trace mark when \-b latency is exceeded.
> +.
> +.SS "Other options"
> +.
> +.TP
>  .B \-D, \-\-duration=TIME
>  Specify a length for the test run.
>  .br
> @@ -262,10 +268,6 @@ The default is 1024 if not specified.
>  Enable SMI count/detection on processors with SMI count support.
>  .
>  .TP
> -.B \-\-tracemark
> -write a trace mark when \-b latency is exceeded.
> -.
> -.TP
>  .B \-u, \-\-unbuffered
>  force unbuffered output for live processing
>  .
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

