Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFDB82D7B
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041776; cv=none; b=nWQj3fT3F1e/KiaTZ6madBp3aQJQLBKVAFNDnmRPQqzBam9hLX6CPNi/F1lInLocWHknILO2rhzXEWgFpPuPLRZSERWscOZIdQV14ZNafk0AeEpDg33jxD4idPDzivQmnVreqtxA/iCLBhXEVJCI6epSvAVEi0Y+8QnmJCvualQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041776; c=relaxed/simple;
	bh=wY+Vqfy3GpsKmAjj8ou4EPE9Lh2AXVxwaw8ue1TOoJM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ks2QP7XY+7ujXpjaUqmogBPdQf65hv3iMoXiwuXHmTbx2LToUPpbRIJFIXkdsqKYb4ZXorUPi4B9LYOVthAKrrk8aA+qEBzuFDNrcJJ8CwL4lDEx8EHF+Gea3L14dwFcQqHukYK2vofk3xlugclU8QnM1+YN9ceFrdfBK2c22oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8xoNIvw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8xoNIvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706041773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDJKxhh4ec7vySgBS18OlLCH3/dXlQKPCR885KVpd/w=;
	b=U8xoNIvwLpTCSFnC3jo0XwaT7NesSRkkVmB9Z7CvUoKvJs0WtmO7xXpIZopkRHd/E6DhFY
	Q+qfybixZwYem8az5ZUTfDfo3ys0X0XnCmn36E63TGYeQyJ6E7hTKRzERoBY94Nzo3Ym7A
	3uq6JTIasqEVwqlsjBBWWYj0lON/v60=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-WG2DtjeVODmFes-srN-KwQ-1; Tue, 23 Jan 2024 15:29:32 -0500
X-MC-Unique: WG2DtjeVODmFes-srN-KwQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-680b48a8189so89859816d6.1
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 12:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706041772; x=1706646572;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDJKxhh4ec7vySgBS18OlLCH3/dXlQKPCR885KVpd/w=;
        b=nvdadgUCC9IRJueyW8D55oTAsIl2KyR6sB4AcPgxlB4hRDyvvDDvmBcamrAwZiZchY
         SWo12Dm0n00yVICeREFt/K99+THbF/r7O69HDZAibLOKRuiPEAghrYy6g8X98YeIFp8D
         0ceYu4nI1dvUPTz8n+LkQL0QtL9xPF4XBwat4V3b0RYNHNxehj7zwuXGf2/aEM6E56Yr
         z2UHm3KqAvIGHSaMWFDxwC3uDJG8Y0/LP82FbQvqKDcRyvxHGKwdO+bF8MERV+3I5kjW
         uW42AteXMZY3DpRY7eBDZPILf7Rb59ChcezDo5K6uq2/VdC/EDfN3s3AXNzYyuwBmIhr
         o90g==
X-Gm-Message-State: AOJu0YwpU533oSMxKA8KIoUfVpOsBHcCsmQI4DeY2P+Ii//rW1896Os9
	NZ4SREWdeo89GvMGAZilt1qk/8rP7Xp4auH+Pjv//Q+Goqf5XrzyjA6XT29YtckpsuWtAPKBZO8
	aHzEf0/mfloz/nDyBBouVjjXBFjo4TexweqVHDp/BC6M8ynNRPfPupUUiEqFs+59i
X-Received: by 2002:ad4:5ce9:0:b0:685:4c80:c044 with SMTP id iv9-20020ad45ce9000000b006854c80c044mr1636204qvb.7.1706041772028;
        Tue, 23 Jan 2024 12:29:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg7fv36te2+5HYWEgZKXRtGiX9rQQF1oG+ixS0WVE+D6idl9J9JWe6n9bAIgUmMjrWSrfplQ==
X-Received: by 2002:ad4:5ce9:0:b0:685:4c80:c044 with SMTP id iv9-20020ad45ce9000000b006854c80c044mr1636196qvb.7.1706041771779;
        Tue, 23 Jan 2024 12:29:31 -0800 (PST)
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id lr7-20020a0562145bc700b006869485d9eesm1935901qvb.82.2024.01.23.12.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:29:31 -0800 (PST)
Date: Tue, 23 Jan 2024 15:29:22 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/3] rt-tests: cyclicdeadline: Print the histogram
 regardless of quiet
In-Reply-To: <20240122221321.9545-2-crwood@redhat.com>
Message-ID: <d24f9961-03ae-8f10-fdd2-1a11b37a778a@redhat.com>
References: <20240122221321.9545-1-crwood@redhat.com> <20240122221321.9545-2-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 22 Jan 2024, Crystal Wood wrote:

> The histogram printing code should not have been gated by !quiet,
> even though other summary printing code is.
> 
> The non-histogram output also should not have been gated based on
> the presence of the histogram.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  src/sched_deadline/cyclicdeadline.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index b3155547b9bb..3cb8f714b788 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1117,15 +1117,15 @@ static void loop(struct sched_data *sched_data, int nr_threads)
>  	usleep(10000);
>  	if (!quiet) {
>  		printf("\033[%dB", nr_threads + 2);
> -	} else {
> -		if (histogram) {
> -			FILE *out = histfile ? histfile : stdout;
> +	} else if (!histogram) {
> +		for (i = 0; i < nr_threads; ++i)
> +			print_stat(stdout, &sched_data[i], i, 0, 0);
> +	}
>  
> -			print_hist(out, sched_data, nr_threads);
> -		} else {
> -			for (i = 0; i < nr_threads; ++i)
> -				print_stat(stdout, &sched_data[i], i, 0, 0);
> -		}
> +	if (histogram) {
> +		FILE *out = histfile ? histfile : stdout;
> +
> +		print_hist(out, sched_data, nr_threads);
>  	}
>  }
>  
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

