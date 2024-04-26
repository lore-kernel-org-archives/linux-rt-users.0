Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58CD147C81
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Apr 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138376; cv=none; b=AqBMm8PyYiF0Q32tKY2o7l2ekQ9sDOoLg3yOMcaUS7wQBwCAZDY82RNHRCsitIWyhTjvV40yExoC8AIcCnCJYGfC2t2u4oYpv27jQ0wPHZNUpjWMBO45KlB6yxdIRMZK0ODIqHxcVacXQC0QF/8nbDbwykhOtDLGTWWAEwnKvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138376; c=relaxed/simple;
	bh=U6iAX5O60pri58o6Bie5xzUMYBt0iMYH/FkDGvv4aYo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DoRFgJ7SdQPvYUp80DXfAg0wb+y7TA+w5kW9nnqWNIMLfrAEynMDIQjLMYgZYGqrhlZL5DqiOMz95SLpoFJU9+Ip83sN4MIVrvXrGF7VMncK7pyRRfiW6GAIiRHuSUdWocsuth84VbHZ2/85n1yqFLaNa9wTZv3DMUlPqzb0mvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgBhEQB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgBhEQB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714138373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7M+L4/HGAdca57XC4f0XYzdZGPhvBfw0lIYnIjCGtxo=;
	b=WgBhEQB4KnkK5acf5gwe3sGh9autrI6gCVlUuR1P0aqshIVrVMEW5jr0Nve/DkWPpsFW0x
	KYBohraoBnG3TuN4gWTpX74xiwnTCOpWHcvrNikjd6YpDcYbTO8tjiIxznD3cc7M2NgG3+
	4ZogbbL5k7ucvf8rFlIWKPAKVtlfItM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-1-FJenNcM-qcd1VmBgtgRg-1; Fri, 26 Apr 2024 09:32:50 -0400
X-MC-Unique: 1-FJenNcM-qcd1VmBgtgRg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43a1389bc01so41677361cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Apr 2024 06:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138370; x=1714743170;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7M+L4/HGAdca57XC4f0XYzdZGPhvBfw0lIYnIjCGtxo=;
        b=SY/1bEP3XsRkRTS48yKGJcZzAgTjFzYSgLgQCZjSpk9K8XLE5X8WlYSvhLj0/JGNR4
         R25YA03g9vtL6hXH7fat4D9Qjw+66uSwTDl8fTeBVPKPv9kuo2cAVOLGUCYFACnXgSdZ
         7dDm3dvcqo36ciSSLtkL1HFOXU4WEKA1C+e/A8/0JwGjSJBPGVY2weXmJAG7smYWXISS
         VInrXl8oiY/bksIy8fSzUimpf2gScJTKRZPi5I31/e4TNgQWjZ+jYVTBC9RTcuQaMWqZ
         O9+bZtMolvXV5ddcF2SJY2SAky9Qcru5j8Nin1L1LGurdDmAg4ahswlncU4yG60sCB0Y
         fxgg==
X-Forwarded-Encrypted: i=1; AJvYcCUUUgyo0wPcGg/rcmfJtHtEUoxjjqsP76etdRV1UHTW73o7wZHtafk8QyhspzkRijhTloJ7YdTMtwGm+gf94VA58ptflhK7GZf+KDt+bPk=
X-Gm-Message-State: AOJu0Yyas9XkSlQFjz+JZxmqVW6TXdFlo/sCJVce6aSEptl1Ddu0rQJa
	xv5G5cZIC1XOl/+o4yf+Jn/rKVyBTmb5Ru/t+FYaCMkBBrRoOWjwnIfgFH+/kxZ9DsGEUyh9pSA
	+MQu639Tn4vMcKFhYBrOMcXEVNuWKFJtfPThyBk4K9BsjLpqcLToe+IHCtda5JNHJ
X-Received: by 2002:a05:622a:1a87:b0:439:b456:25b6 with SMTP id s7-20020a05622a1a8700b00439b45625b6mr9560725qtc.30.1714138369939;
        Fri, 26 Apr 2024 06:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz7NszxkDoeuGPL0qrphPM6xYgTKWvZDpZk1vSV3ginHQ01m5HNFXUQSxQPVFz3yTt7CPtHA==
X-Received: by 2002:a05:622a:1a87:b0:439:b456:25b6 with SMTP id s7-20020a05622a1a8700b00439b45625b6mr9560693qtc.30.1714138369586;
        Fri, 26 Apr 2024 06:32:49 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id r15-20020ac85e8f000000b004359216e794sm7887696qtx.29.2024.04.26.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:32:49 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:32:40 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Use -j with make mrproper
In-Reply-To: <20240424174526.190509-1-crwood@redhat.com>
Message-ID: <6e918ff9-10c2-b9bd-e637-51e683f15b4c@redhat.com>
References: <20240424174526.190509-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 24 Apr 2024, Crystal Wood wrote:

> This reduces the startup overhead somewhat.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> On my 12-cpu laptop the gain is about half of what
> https://lore.kernel.org/linux-rt-users/20240304211655.20174-4-crwood@redhat.com/
> does, but *shrug*
> ---
>  rteval/modules/loads/kcompile.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
> index de1539986723..f7a9c0084805 100644
> --- a/rteval/modules/loads/kcompile.py
> +++ b/rteval/modules/loads/kcompile.py
> @@ -248,7 +248,7 @@ class Kcompile(CommandLineLoad):
>  
>          # clean up any damage from previous runs
>          try:
> -            cmd = ["make", "-C", self.mydir, "mrproper"]
> +            cmd = ["make", "-C", self.mydir, "-j", str(os.cpu_count()), "mrproper"]
>              ret = subprocess.call(cmd, stdin=null, stdout=out, stderr=err)
>              if ret:
>                  # if the above make failed, remove and reinstall the source tree
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

