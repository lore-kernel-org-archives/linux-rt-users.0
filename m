Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7E175542
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352498; cv=none; b=iIHMwAgKeYCoVBGE1Whl+DP4ni+yhEL0AXueN7t0hDwXHyQX6n0aj35zFjzOk2y4Pta81jDGR8z+vbnsQvCIrF9fAeQFidZ9+8nfpZ5nmiUoWhld6o7Jjo/gpSGBf2QfmHr2NSQuPVFiZZyOUxBKR4UqYm1eNzArVB+PSCAe0rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352498; c=relaxed/simple;
	bh=eW6l4gpx122hsbycoOosma5R37OwbwNkxdcBo/OImFc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MoZHnpqe8bMDDivqFirBUpyUlg9zuz0q2gMYkrhxo4CHJvG4Shrye6jkv0Fup7Z2C+iKu2m/eiTi+3C5oUr1JUEcCud5hunxfNH9p5K3EEX5D9A3WEXtq758K2YRKJaWIybX9pKb1a1NyBSnI9BqPikvNQrUf61LoLFdxSiBuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPwATY6Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPwATY6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712352495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ped0tO4s3gqUib10B8TivwnrKGGhaCKEW/b/IUyi7FE=;
	b=cPwATY6Y+Fnxi5s8dkVredRbduUNUSl876Aq00INr1Jcso4y0qJqPhWIaFiKTOYuola9pq
	5ZRSCNhckzWO5sn7eFNJG0r/JZTOvhiKT5YFMm5OTThBpGwnKpGl5nFHGrDJFq0NqEQxWm
	YmqDLDI0C3ChBGt3j4+IC3zK9PWkxmc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-oHLO3u1jPiSn47CKh0cjDA-1; Fri, 05 Apr 2024 17:28:14 -0400
X-MC-Unique: oHLO3u1jPiSn47CKh0cjDA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-699481d14ffso5368426d6.1
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2024 14:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352494; x=1712957294;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ped0tO4s3gqUib10B8TivwnrKGGhaCKEW/b/IUyi7FE=;
        b=gLoeWgBLQxOw4gz6x3buOEtte1aRvqc2wTKR2+1IUg27q6QPPEazvqOtzxGqKWfZCq
         okgaWdlN+vybauJjr5oxbGSNwgmdVWfiV7nVHQ8Le7I91UCGzlrHQ1LG4F7NETT0i6CE
         vRvuDrTkyLt7e1MGbs/SlMzG8X96itHckGZSd5DZHmcJAAD/sP4gkav05xylPPl9mgAt
         wQi6k7sO6yJ+2zLTi8penTH+7EN0cDz+4omTHGMpS6p9Hs1YdgmsPDFppJ/MyrB224XG
         iRQPnmTloNEm89JPMaf6H3yge4/XnN0AQZ/tQNAtSJP7ZcPaQS9M6SAiZG8YuDyYC0er
         VObQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOF3iXrkVVcR5ewtr1D4HY7I0o7t6iy/u4SNqTi+ah0kSdpBCgeK1tTPXGnJqEkmQkpRSsCE7xVkv09mwIS5xgjd8dNQtrrjRbH/t9W+I=
X-Gm-Message-State: AOJu0YzYoFGd7k4cZUqVnFELZlq1LYNjhOlKVu5ykMhH8XsZFf4xNGFl
	TYSGBPsIFqYFmvfoLDYKbjrDTefFOaL4myvL+ZoVIMo3A87Nd4sstn+GMjvTpWm+zX17QCQRy3X
	iS839HTco0KaEGfDbBGdI/no81xkih/nQu7N+AjwAtQ4WWtTzKrxF41TmrCSsiNZe
X-Received: by 2002:a05:6214:20ee:b0:698:d692:9bc7 with SMTP id 14-20020a05621420ee00b00698d6929bc7mr2610347qvk.13.1712352493851;
        Fri, 05 Apr 2024 14:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDAEutNuZ120WjxXH7jd+PQX3Nr6Z596AEsGcZdNaa5Jl03eR5RKNVkkaHZUZfviLpewnVKQ==
X-Received: by 2002:a05:6214:20ee:b0:698:d692:9bc7 with SMTP id 14-20020a05621420ee00b00698d6929bc7mr2610338qvk.13.1712352493566;
        Fri, 05 Apr 2024 14:28:13 -0700 (PDT)
Received: from fionn ([184.147.142.166])
        by smtp.gmail.com with ESMTPSA id y18-20020ad457d2000000b0069903c37a36sm924344qvx.100.2024.04.05.14.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 14:28:13 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:28:04 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Rodrigo Queiro <rodrigoq@google.com>
cc: Clark Williams <williams@redhat.com>, 
    Daniel Bristot de Oliveira <bristot@redhat.com>, 
    rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] Support --smi on newer processors
In-Reply-To: <20240312105329.3876232-1-rodrigoq@google.com>
Message-ID: <67c7071b-7304-a600-1bd7-b0033dec2e55@redhat.com>
References: <20240312105329.3876232-1-rodrigoq@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 12 Mar 2024, Rodrigo Queiro wrote:

> This avoids the need to update cyclictest.c for every new CPU family, at
> the cost of generating bogus SMI numbers on pre-2008 CPUs. Based on the
> comment from Daniel Bristot de Oliviera:
> 
> > When I added that option the smi was a relatively new thing...
> > nowadays I think it is pretty standard...
> > so simplifying it is a good thing.
> ---
>  src/cyclictest/cyclictest.c | 91 ++++---------------------------------
>  1 file changed, 8 insertions(+), 83 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 33fac3b..8a96339 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -404,7 +404,14 @@ static int get_smi_counter(int fd, unsigned long *counter)
>  
>  #include <cpuid.h>
>  
> -/* Based on turbostat's check */
> +/* Guess if the CPU has an SMI counter in the model-specific registers (MSR).
> + *
> + * This is true for Intel x86 CPUs after Nehalem (2008). However, it's not
> + * possible to detect the feature directly, (or at least, turbostat.c doesn't
> + * know how to do it either) so we assume it's true for all x86 CPUs.
> + * Previously, this function had an explicit allowlist, which required updates
> + * every time a new CPU generation was released.
> + */
>  static int has_smi_counter(void)
>  {
>  	unsigned int ebx, ecx, edx, max_level;
> @@ -428,88 +435,6 @@ static int has_smi_counter(void)
>  	if (!(edx & (1 << 5)))
>  		return 0;
>  
> -	model = (((fms >> 16) & 0xf) << 4) + ((fms >> 4) & 0xf);
> -
> -	/* Based on intel_model_duplicates */
> -	switch (model) {
> -	case 0x1A:      /* INTEL_FAM6_NEHALEM_EP */
> -	case 0x1E:      /* INTEL_FAM6_NEHALEM */
> -	case 0x1F:      /* Core i7 and i5 Processor - Nehalem */
> -	case 0x25:      /* INTEL_FAM6_WESTMERE */
> -	case 0x2C:      /* INTEL_FAM6_WESTMERE_EP */
> -		model = 0x1E;      /* INTEL_FAM6_NEHALEM */
> -		break;
> -	case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
> -	case 0x2F:      /* INTEL_FAM6_WESTMERE_EX */
> -		model = 0x2E;      /* INTEL_FAM6_NEHALEM_EX */
> -		break;
> -	case 0x85:      /* INTEL_FAM6_XEON_PHI_KNM */
> -		model = 0x57;      /* INTEL_FAM6_XEON_PHI_KNL */
> -		break;
> -	case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
> -	case 0x56:      /* INTEL_FAM6_BROADWELL_D */
> -		model = 0x4F;      /* INTEL_FAM6_BROADWELL_X */
> -		break;
> -	case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
> -	case 0x5E:      /* INTEL_FAM6_SKYLAKE */
> -	case 0x8E:      /* INTEL_FAM6_KABYLAKE_L */
> -	case 0x9E:      /* INTEL_FAM6_KABYLAKE */
> -	case 0xA6:      /* INTEL_FAM6_COMETLAKE_L */
> -	case 0xA5:      /* INTEL_FAM6_COMETLAKE */
> -		model = 0x4E;      /* INTEL_FAM6_SKYLAKE_L */
> -		break;
> -	case 0x7E:      /* INTEL_FAM6_ICELAKE_L */
> -	case 0x9D:      /* INTEL_FAM6_ICELAKE_NNPI */
> -	case 0x8C:      /* INTEL_FAM6_TIGERLAKE_L */
> -	case 0x8D:      /* INTEL_FAM6_TIGERLAKE */
> -	case 0xA7:      /* INTEL_FAM6_ROCKETLAKE */
> -	case 0x8A:      /* INTEL_FAM6_LAKEFIELD */
> -	case 0x97:      /* INTEL_FAM6_ALDERLAKE */
> -	case 0x9A:      /* INTEL_FAM6_ALDERLAKE_L */
> -		model = 0x66;      /* INTEL_FAM6_CANNONLAKE_L */
> -		break;
> -	case 0x9C:      /* INTEL_FAM6_ATOM_TREMONT_L */
> -		model = 0x96;      /* INTEL_FAM6_ATOM_TREMONT */
> -		break;
> -	case 0x6C:      /* INTEL_FAM6_ICELAKE_D */
> -	case 0x8F:      /* INTEL_FAM6_SAPPHIRERAPIDS_X */
> -		model = 0x6A;      /* INTEL_FAM6_ICELAKE_X */
> -		break;
> -	}
> -
> -	/* Based on probe_nhm_msrs */
> -	switch (model) {
> -	case 0x1E:      /* INTEL_FAM6_NEHALEM */
> -	case 0x2E:      /* INTEL_FAM6_NEHALEM_EX */
> -	case 0x2A:      /* INTEL_FAM6_SANDYBRIDGE */
> -	case 0x2D:      /* INTEL_FAM6_SANDYBRIDGE_X */
> -	case 0x3A:      /* INTEL_FAM6_IVYBRIDGE */
> -	case 0x3E:      /* INTEL_FAM6_IVYBRIDGE_X */
> -	case 0x3C:      /* INTEL_FAM6_HASWELL */
> -	case 0x46:      /* INTEL_FAM6_HASWELL_G */
> -	case 0x3F:      /* INTEL_FAM6_HASWELL_X */
> -	case 0x45:      /* INTEL_FAM6_HASWELL_L */
> -	case 0x3D:      /* INTEL_FAM6_BROADWELL */
> -	case 0x47:      /* INTEL_FAM6_BROADWELL_G */
> -	case 0x4F:      /* INTEL_FAM6_BROADWELL_X */
> -	case 0x4E:      /* INTEL_FAM6_SKYLAKE_L */
> -	case 0x66:      /* INTEL_FAM6_CANNONLAKE_L */
> -	case 0x55:      /* INTEL_FAM6_SKYLAKE_X */
> -	case 0x6A:      /* INTEL_FAM6_ICELAKE_X */
> -	case 0x37:      /* INTEL_FAM6_ATOM_SILVERMONT */
> -	case 0x4D:      /* INTEL_FAM6_ATOM_SILVERMONT_D */
> -	case 0x4C:      /* INTEL_FAM6_ATOM_AIRMONT */
> -	case 0x57:      /* INTEL_FAM6_XEON_PHI_KNL */
> -	case 0x5C:      /* INTEL_FAM6_ATOM_GOLDMONT */
> -	case 0x7A:      /* INTEL_FAM6_ATOM_GOLDMONT_PLUS */
> -	case 0x5F:      /* INTEL_FAM6_ATOM_GOLDMONT_D */
> -	case 0x96:      /* INTEL_FAM6_ATOM_TREMONT */
> -	case 0x86:      /* INTEL_FAM6_ATOM_TREMONT_D */
> -		break;
> -	default:
> -		return 0;
> -	}
> -
>  	return 1;
>  }
>  #else
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

