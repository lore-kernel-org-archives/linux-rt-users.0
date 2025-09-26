Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB6243371
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908425; cv=none; b=Kg7XYNDhcMR5sofbnudaHZbqFE0D/7vqMzVsp7O+yOthTu+rUKyZVofwyDIaUMh7r5DBhG5EOSzkU8M/3/9UfWB3BxfHiywprFO2YOJs4yR5B2HBqrijGzgePOupSM9AxPw5/9GyHiXiUDhZ97n2w6ZOqJJnDiudQBIJswwkblk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908425; c=relaxed/simple;
	bh=Kde1edyQAZ2roTI4WHNq/QeuX/uRwyydwcXt4S79bFI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M64UIHZmQy1NsfO5xDT0/eaSirOsbQ6VzrY6XWQLSWbw1pF8swgFQ7iI+B5UPWOFF4x1rsZQrrBKNSfNRjryuv4yaRuDIWaPXfWX1zJ8oPUCdiqBWQYSvVzaHejdybj95RzfZqiIFz1LOlD98yhqHWdEL2uHx/CnyJXzAcH5yIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tw1fYVsi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tw1fYVsi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758908420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yf+YxdBKZL3QUxJ3If1X35idRulm2jeC7/e4OZ4v+fE=;
	b=Tw1fYVsiHilZC5VKoM31tZ4dHDZQs1dcpFa/Ymg3Pr+Yvo85tPeVM8lrGQNxuKGeOPZTyg
	N0MFI1ThUklE5QvNmiEInQmME+pkjUuCgjKJXs1HshEq3hxeOUe8axoNBj11Ss7cwsAswR
	QrX2XgpjJyrwVe7MdvNwaOrMkQ8gXqE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-7N17Ys7VMsCobqnNPNVp3A-1; Fri, 26 Sep 2025 13:40:18 -0400
X-MC-Unique: 7N17Ys7VMsCobqnNPNVp3A-1
X-Mimecast-MFC-AGG-ID: 7N17Ys7VMsCobqnNPNVp3A_1758908415
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d8b8c3591fso66472371cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Sep 2025 10:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758908415; x=1759513215;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf+YxdBKZL3QUxJ3If1X35idRulm2jeC7/e4OZ4v+fE=;
        b=VC0QV2Q6OwWjgFUU5AtOyBgFmsypvOEd2bXk+l7C/tTuXeORHTtQY16OU2umgDBJ0f
         FPxDoU04GxYsZGIQdhMcCXXIr2YP2pl4PnMtKcfhKYQtCCWAn9TTeKbf6OBBCVBoMrww
         SPxEZoIpKb0kbPKsX6PLcz6QPrVK6Ktm3OhpO7yBV3N6KNKHG0XIMSHccm0pbx79Ius+
         wboG8+/NmGDH/+m/NlBrdjAWnUvOmvt9stA2+Du8DWQZaR7LEVr8RGwp0wnz2DjvU4XD
         6kvP4V6KfuuvJt5mm++B40vlyozofmSAaoB7bo6ll1U2srC10m+8sVqFdMhcfanpAx3d
         EMqw==
X-Forwarded-Encrypted: i=1; AJvYcCXDWKppZY/pIvW7LWc+3KEnXhXMj20tj/yEcQEPD7/h/7kGhl2TW6BKWvOWxfGcuGOpfTGW7XtkHYo9NYAc0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YznAkbebnO9h3BiDp2bDUbaNR2kQebZCsm2q+ZZvOUkAXJoOvQv
	4NAQdCtNH2GPlomcMZUbA1s4tuZsRkktOJw3ptLOBAzRywtLJP+PqXIwnAcLrcMc6U7O+MxQf7+
	dQflyKKovJjF4yczm/0610npn7ilyGO7q3+o4MQX6Zu+iNsoDcWer/E3cMhn7+jJfTwJVxMRind
	m7
X-Gm-Gg: ASbGncuu+Zwt8Wu1gC5WaqXwAB62Kz1Y0SCrXU1N0smFSwyxTq+sPPSelIoHf9/QuOB
	mZkfouuNjmDfnzcuwAW79Ce7Z64EgiqH63pz7IFYPoOOB0rA3cMJ29TWsM8XvoLAjGmB9NJyFju
	Z3oY8uVGTlXcgDlow2eXiJmDpTHT2ogy5ivA3ddliSOMKjZCh/sHbbeMW6TCEgc0EJbluvUsath
	Fe6sbK7bOhhFOpRGCXw8udhK+ZVb+D6C9mitR9TSvUrP0M2NDqm08gDbQ+ciijakM59nVoV9LzB
	KxVrqObdeecBTH6zlyjkU/QWhQ==
X-Received: by 2002:a05:622a:1982:b0:4d1:f8e7:e468 with SMTP id d75a77b69052e-4de68366b2dmr28294791cf.69.1758908415012;
        Fri, 26 Sep 2025 10:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFijid/eXbO/zSCoYMYLlmeGJdgVtnVX3QRF4C0OVlchCtOmN4nz3yeTKhHnfqrCqx2ELiTKw==
X-Received: by 2002:a05:622a:1982:b0:4d1:f8e7:e468 with SMTP id d75a77b69052e-4de68366b2dmr28294341cf.69.1758908414490;
        Fri, 26 Sep 2025 10:40:14 -0700 (PDT)
Received: from fionn ([70.53.55.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11cd52e5sm30071791cf.47.2025.09.26.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:40:13 -0700 (PDT)
Date: Fri, 26 Sep 2025 13:40:03 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 2/8] pmqtest.c: Check return values of write() and
 ftruncate()
In-Reply-To: <20250726091837.493915-3-yphbchou0911@gmail.com>
Message-ID: <0be2bd28-1137-8d66-5abf-d3c4ae01bb8b@redhat.com>
References: <20250726091837.493915-1-yphbchou0911@gmail.com> <20250726091837.493915-3-yphbchou0911@gmail.com>
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
>  src/pmqtest/pmqtest.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 04e36a1..eb20baa 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -75,6 +75,7 @@ void *pmqthread(void *param)
>  	int policy = SCHED_FIFO;
>  	struct sched_param schedp;
>  	struct timespec ts;
> +	int ret;
>  
>  	memset(&schedp, 0, sizeof(schedp));
>  	schedp.sched_priority = par->priority;
> @@ -189,7 +190,10 @@ void *pmqthread(void *param)
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
>  				if (tracing_enabled >= 0) {
> -					write(tracing_enabled, "0", 1);
> +					ret = write(tracing_enabled, "0", 1);
> +					if (ret < 0)
> +						fatal("Could not write to %s: %s\n",
> +						      tracing_enabled_file, strerror(errno));
>  					close(tracing_enabled);
>  				} else
>  					fatal("Could not access %s\n", tracing_enabled_file);
> -- 
> 2.48.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

