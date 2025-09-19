Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD55257AEC
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307350; cv=none; b=PTQbCL8kYV9Ti14k9zqOdLSjprz41oVMOoUm+aS41hbIVMyUAKl/S91NlL4+aL5pyXhQMw93029RJblauMyCx+GwANAqQ3wdHxyhXWTaXepWozB3WUy+nkQ6uYvafGnctP2G5/4nnKzIcfahsF6UDl/4yt0SBRS2ku7ND0N8qbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307350; c=relaxed/simple;
	bh=7djLvtoi2lEXOde2FFYOXKoBCuhTQaQjwmrVm/3ltAA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r8IzbZFAE8l5/v2RwCCQG/1cia/FFhJ3x3jZ4emE06mg6u2NilJEjRc4yOWpoHYKuGiXiiivXFzbFNC97kjDE7BHZmv1StTr/YCnJjOrnyOf3s5hqfx2mnLslL/ER1oRs4Egth2c5w+m4chukD9rJpZZP3EfgobEx1T+rhckJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3zchLdz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3zchLdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758307347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U2zag34hROOGecPIeSwdDZQHqMY+tFU1rqi182b5C84=;
	b=e3zchLdzcW5Hc+x48VHgzXnZ6SBtKYSSPc6Ux/iDokl7FOWByk/5psmBMrVqAtPssVL/+Y
	MqmW2ZujCyy2LJx2ppBv3hyqgg10qU33EEgH44JnCs+tBZJqM1qVg7y3A3Tdd8UGOPVLf6
	d/uQl0SKKGxGHNCvay9zIttf7mQPVTs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-JpjVlVoDN8Gf-DDApUKHJg-1; Fri, 19 Sep 2025 14:42:26 -0400
X-MC-Unique: JpjVlVoDN8Gf-DDApUKHJg-1
X-Mimecast-MFC-AGG-ID: JpjVlVoDN8Gf-DDApUKHJg_1758307346
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-82968fe9e8cso691157985a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Sep 2025 11:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307346; x=1758912146;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2zag34hROOGecPIeSwdDZQHqMY+tFU1rqi182b5C84=;
        b=HZ6I3/oJxbTLl1qBnTSPZDfDEBexWfKH1xxX61rMzd/+cvFuhsrMyZ3Am2F6kMk51a
         O6YYhmZ4IJVmOwll3PO28MFaFp+RwQNiNk/Mlf+y00QX7uvMu+b3N622qnI3WhLOjyll
         piObmZHGvEXRjzQg2UuXqG3kiMkC6wFUOCtAWFQo2fMoJSABtC/6WfnCJ9dWi0v7QQVv
         NRInqh54HvUHaxdT3wA4bMfscGRgSUkWWMJv1RgXlepUdhKqVy6RJo3rknhlQ/hNA2cW
         K4rB4sdSEVpLNCnq0N3gVHtMMsOOZ2ue2uw69JsIPiOc5LlKWRU2QD+0Y8oX1tmpWJzq
         ovLA==
X-Gm-Message-State: AOJu0YyTuD58XiH3XtIDvSsEIvaRUf6NeaPb994qiKs/9u7Wo2PTfzYn
	UOY1F7SKf7P4oOgxS0R9Rpz1jv9GANd63v1G4pOLKHAQHkPxBG6Ljax9WttVYXUN0aR88sBeJAT
	/YewHt0einw7GF3F88PkgSClacv8+Ln6E0H0BsSaRSivZVUfPzUU1oBqj4V2VV64p008BivTBON
	R/0RY=
X-Gm-Gg: ASbGncuer67Tbb4SmNQFIDf2eUySadDik7ORK05zuJGjG+KL76T9ApVIQNWhbUksOHZ
	AZ5gKLjv3UjrJ1/LMflruo79sc8DsHZJYJ+x5l5wcKP1nrC+5+y+O8Mq6dLinYmzNA9rop/JwZ9
	LNzGNCzHcDkzdU1vEouVpgQsyQAH9lbph/NOPVJota8Vp4Mot0co6mxRp7XXbTRE9nUAsj1Nbro
	jDJSm4TOE5ZvNA9pz5J5HopDG8+xYWBAm44ysdnHadPlePdVHBCAcqu4L0AX+4sJjlfMkfhmqik
	G3JPcwR8tWsMEVBIBfLy6vRJz/W6WMowvk2fT3astz9GkS38FR22YwJuq0fgyzCy6gd01c4B50c
	gVU7xjNIFbxSz
X-Received: by 2002:a05:620a:9510:b0:835:918f:2c16 with SMTP id af79cd13be357-83ba40ad301mr399977285a.21.1758307345682;
        Fri, 19 Sep 2025 11:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqSKQV2GiJtzmDxF85n0bt6U4tAGlEieRFBst0fi7u1OdEJsEAFG8JJkHqnxGoyqr5mgbN0Q==
X-Received: by 2002:a05:620a:9510:b0:835:918f:2c16 with SMTP id af79cd13be357-83ba40ad301mr399976085a.21.1758307345310;
        Fri, 19 Sep 2025 11:42:25 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0604w-grc-05-70-53-55-167.dsl.bell.ca. [70.53.55.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-836300b0a5asm368044885a.33.2025.09.19.11.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:42:24 -0700 (PDT)
Date: Fri, 19 Sep 2025 14:42:23 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
    Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 06/10] rt-utils: Simplify trace_file_exists()
In-Reply-To: <20250903111717.1391196-7-bigeasy@linutronix.de>
Message-ID: <51d0d895-5eef-546f-a1b8-a9d87b7c2fd7@redhat.com>
References: <20250903111717.1391196-1-bigeasy@linutronix.de> <20250903111717.1391196-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 3 Sep 2025, Sebastian Andrzej Siewior wrote:

> Pass the tracefs folder prefix directly to stat instead making a copy of
> it. stat() is defined as not altering the path argument.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  src/lib/rt-utils.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 0e6e6056a4392..294fc9683a122 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -408,10 +408,7 @@ static void close_tracemark_fd(void)
>  static int trace_file_exists(char *name)
>  {
>  	struct stat sbuf;
> -	char *tracing_prefix = get_tracefs_prefix();
> -	char path[MAX_PATH];
> -	strcat(strcpy(path, tracing_prefix), name);
> -	return stat(path, &sbuf) ? 0 : 1;
> +	return stat(tracefs_prefix, &sbuf) ? 0 : 1;
>  }
>  
>  static void tracefs_prepare(void)
> -- 
> 2.51.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

