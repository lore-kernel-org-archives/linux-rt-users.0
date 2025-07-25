Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495948CFC
	for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466964; cv=none; b=WxQPooGI5VNSuqgYcBnTJDAGiPFoDwIQisuUORm8CAOZaEiP3i10Kyr2cucNUT/OCNtEs//d3+v1wuAenMzZ+bnARsrB4TENwapOpmjFd3kmoyOgJHxalzV1zvJILBcUhQz6WJRljaLTTbb2ABq/fRmt/uLMjhu3hZH8wEnk+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466964; c=relaxed/simple;
	bh=Tw8iaC+MRnv7yLUe1UemBywp8S9tyV+EYz/N85WY03U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IeBnCC2/WGiawRCjd+SB4eqyOBbtEMzRVeBSsHQGDBxRJWfxOR1uj6hKC4k0s/SNYJ1WLkakqE9cxvB5SAwH2rWlKVDy8IsrzPyUKYNMQyqv9RB01N1TzmVfVvUrUuyTXcm/UBJg+8MpSnun1luXK/k0KBcIyhgbKvQRVFW+fuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfVcTf/8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfVcTf/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753466961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7oTTun4qJ9ZXuigJpcuXHaSINUuD/3hU6SofYWt/Dhc=;
	b=AfVcTf/8M9c9LcZzM8/kkEC5+5xKk+XFWblE6C5u0a0qYWFn39XuKL7cpkNdjhdM8CmHzK
	ZuvBLc+spZApzUWShvRvfrkmdEls6HCumDqbPh3bDLEN9CCD5BoGgNeM+6IUcxKe7RgJZX
	i+SMjNBGZFMiU8wrRHtKCFgIcsvL8ME=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-8nmGhdAZOHWNo7plrPgDHA-1; Fri, 25 Jul 2025 14:09:20 -0400
X-MC-Unique: 8nmGhdAZOHWNo7plrPgDHA-1
X-Mimecast-MFC-AGG-ID: 8nmGhdAZOHWNo7plrPgDHA_1753466959
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab758aaaf3so89965491cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Jul 2025 11:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466959; x=1754071759;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oTTun4qJ9ZXuigJpcuXHaSINUuD/3hU6SofYWt/Dhc=;
        b=oVMNQKl5ZlsiE5/3yZHaHM4FiPgfXU4oVaY3lsB52pWw0ltOd7RHCIDDP/bHJ4NE7V
         htSfqyWrJhhiJ+HKQTurnwqqSBBx5p/Ic9khTqorTINjHBBPH/8QK563RaCKxkb5VZsV
         BEx8Q/kkqhGtUCsrAOzuD177OsJHoBzAXrHs157d0Ofl0+9Ot/HPnI9ZOYkb1yEj79B3
         4Z/AOq0Th3vxhEwGjdn8gjWuJREkfcevFOd3a9DkPXKrPYYTm3oYnRSXoG9i5bdtOtpS
         +AFJdQOuLyc7w1uRYaBV+Xe7d0ZPZI+1te9QVyZGMjvlch7E/gJ1beMTUjQDkc4+PZAP
         UYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXRaDQoel0h17HKsT4CMplyr3Q1aG5wvsk1NKJkZC4Sw44bJ79VvAgOLGFn2kaoGgzUI1ajApnkVLQzH8/VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPFTjzCf4Ejx6LC07LXD+YNLM4ykCWysE6K9zzAz3Jx3RfdvA
	KH2cIrg2zfHxTWHN0hX0vwaxxosruYW6aSnl33t8alx0tGzsDMfWN1LSA3a8Olgt8uJdKY97yxG
	W0JXj8E3p8gQnolBRwoNDDeI///txt1g6iv9k6T1yp2cas3cv/zEc+b3U9esRnTWAsgMN
X-Gm-Gg: ASbGnctTEif+CoQxAp7lKpCRq6I6Qo2cVqc66m7/lMik/3iSBF8SzCREqXMFXLa2tQB
	PwiZyvACADVZ/tdIgUGjZsXdkOLq8CZiaggK1qZbIMPKqEEtuKIeeJ6l6xfPMS61LhT8I/wX1p5
	BRnZu6wyLbe97mT3JZ3JtR31GNMp8Bhq8WB+bsAGRi8GL/Ltp1TM/PIMZBuQQ7qTRTepFX9GVjg
	2JGHdtZF+wzI84eB6AgvQMGwBbXZKLf+8yGRiNo4074fKssmE5gg8S6JsPGLLdpdspO5Jpc56Nt
	wm2W0qdP7tZYXJwaGrBUg/IOJSJwbQ==
X-Received: by 2002:ac8:580f:0:b0:4ab:66d1:dcde with SMTP id d75a77b69052e-4ae8efabc8cmr33871671cf.21.1753466959498;
        Fri, 25 Jul 2025 11:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlX7gQbX2TUwPn0fcSo2IWIXSv7TDs73i0LMqNQhz0G0Ata/ean0Hm/30yS6RSed4oRJKSgQ==
X-Received: by 2002:ac8:580f:0:b0:4ab:66d1:dcde with SMTP id d75a77b69052e-4ae8efabc8cmr33871291cf.21.1753466959036;
        Fri, 25 Jul 2025 11:09:19 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae99545512sm2944821cf.21.2025.07.25.11.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:09:18 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:09:17 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
cc: williams@redhat.com, linux-rt-users@vger.kernel.org, 
    jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH 3/8] ptsematest.c: Suppress warning
In-Reply-To: <20250712134213.58582-4-yphbchou0911@gmail.com>
Message-ID: <0e6ccb25-6b92-d37c-2e0e-ad8aa1c7eb8c@redhat.com>
References: <20250712134213.58582-1-yphbchou0911@gmail.com> <20250712134213.58582-4-yphbchou0911@gmail.com>
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
>  src/ptsematest/ptsematest.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index d211669..787909c 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -62,6 +62,7 @@ void *semathread(void *param)
>  	cpu_set_t mask;
>  	int policy = SCHED_FIFO;
>  	struct sched_param schedp;
> +	int ret;
>  
>  	memset(&schedp, 0, sizeof(schedp));
>  	schedp.sched_priority = par->priority;
> @@ -112,7 +113,10 @@ void *semathread(void *param)
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
>  					fatal("Could not access %s\n",
> -- 
> 2.48.1
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

