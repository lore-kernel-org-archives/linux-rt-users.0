Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F614962B
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Sep 2024 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286428; cv=none; b=aYVIQokIplfxlu0nYUYMtozjoWenFY4JSkV7OESoT0W9nAXwY2MyfrpqvGYCODoNqkB5lD3OYUO1vMA+z+cP3Q8Lf8sTko/7y6LOWqDtL7v9JirwVFkHGhyFlW7OPdyeG1PvsxZLoDr90mcO626iKhr3EBT/M7inQqpJ0BJpt/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286428; c=relaxed/simple;
	bh=f106YTnRY0bQRKUSlwTT673TTXKL8L8yCngh3DFoe74=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cO5+Pj8e3/eWoB5//U9W2MwVQyWhaK1XwRUeY+nX0EgpAhdJdsSSC5O1eEJ0f3ySRJ+HZU06LMC5r+7e8nGds1X7xm/rjQO9+GWkXKtK6DblYYTm12dOiCKmuuQTegQORZh4e0qLnRswWyK3pEPSLmd316TxwwepLn8Q5ypO0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmJUMPBW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmJUMPBW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727286425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lE6EvKXeyEmx6oWs2wpSdnHCyDdUE3NEaGUWU8Pq+gM=;
	b=YmJUMPBWTY2Lv7SgoJ2bz4yAgD64XnyH4KiHBqVrC42eLhFwfHfdlYfxJDGkpbbXYML2Wi
	8SXDDKrpBf9G6F9nzInxBhNgpPCBB4dXU/aw5j5vGUfy9BTlOqcrF8kOth/H3kfvyea5Hd
	p4Oi42qiOntTymWdG3FOZ2OLAHgxyWQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Yp_Y-FkaP52GsOqoIg-Kaw-1; Wed, 25 Sep 2024 13:47:04 -0400
X-MC-Unique: Yp_Y-FkaP52GsOqoIg-Kaw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a9af65cf73so13540085a.0
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Sep 2024 10:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286423; x=1727891223;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lE6EvKXeyEmx6oWs2wpSdnHCyDdUE3NEaGUWU8Pq+gM=;
        b=wPd749uKmzg8hPD7UB1ScaKRmSN0x8dV2MCHrIZOm1gnu9Vok1LdNqrFUbpSOMbkQ+
         VBt/q+VCzbbeSm3M3oyxjdURGFVohZ/pnzgycQANnQj6YnItEZ+zG13xJ+WbMMh54TpA
         d+ckcmboCjlKAwqFpu3m+MGSvdOmABI3Kk25tAjrR9NBev4VLwJuM4YXliCgegCoVDcK
         ci/HKr/FdqtzRymr2lguCTdchAs7E2ZBKpC6o8kmwD3y3+aQqFTP2OdwbtrGlATmfWgH
         nc59Ohwk0kLTVX7OAK3K+5ICqBtTDXFw4K7kPwA0Uj8APQg0r7+wjnXE9MlbXbLa20VO
         lvsg==
X-Forwarded-Encrypted: i=1; AJvYcCVDbvtgRIV75Ucl+PFghT/rIMkJpv6OeSPWX4MfFNqQb0Dh89zCPeSXtvPLt0fKxxXYDlc/NuTO3Cme4Au5wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVWZeNjW4CcDndHJcnV1a17jsZ86tX7KD3QZD1ujYgpXykdjg
	o6ptwzoYbXvGRNTn4BzqmS8dA1zIZBZgkSFu+/JlAoWHk//ViH4XWAjTkaUsjXtJEHqw9FywgZb
	hp/DvZ/B8wep7u9cp7A9qtmjtlP/z61H9sCtsp62XlZ2QqL2uxUldUSakLp5GENyp
X-Received: by 2002:a05:620a:198e:b0:7a9:b744:fc38 with SMTP id af79cd13be357-7ace7400153mr440973385a.15.1727286423713;
        Wed, 25 Sep 2024 10:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRHwoEFKwfXY5vysvIe1qZ8paJL9w7D91+4M3oWkXMEn/tQiP0M0n/1twI/FkosFjQ3AC3Ww==
X-Received: by 2002:a05:620a:198e:b0:7a9:b744:fc38 with SMTP id af79cd13be357-7ace7400153mr440971985a.15.1727286423379;
        Wed, 25 Sep 2024 10:47:03 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acde565de5sm193501185a.61.2024.09.25.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:47:03 -0700 (PDT)
Date: Wed, 25 Sep 2024 13:47:01 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] rt-tests: pi_stress: Move unlock into if block with
 matching lock
In-Reply-To: <20240923155343.43720-1-jwyatt@redhat.com>
Message-ID: <e03a95d0-9892-bd0b-50a5-d19a9a044b90@redhat.com>
References: <20240923155343.43720-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 23 Sep 2024, John B. Wyatt IV wrote:

> Resolve unlocking a not locked mutex.
> 
> Issue reported by Valgrind's Helgrind tool.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  src/pi_tests/pi_stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 673a7bb..371e906 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -552,8 +552,8 @@ void *reporter(void *arg __attribute__ ((unused)))
>  				printf("Current Inversions: %lu\n",
>  						total_inversions());
>  			}
> +			pthread_mutex_unlock(&shutdown_mtx);
>  		}
> -		pthread_mutex_unlock(&shutdown_mtx);
>  
>  		/* if we specified a duration, see if it has expired */
>  		if (end && time(NULL) > end) {
> -- 
> 2.46.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

