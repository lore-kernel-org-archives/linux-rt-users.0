Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D6F4F8
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Feb 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891637; cv=none; b=YxD0kFAtpqQ5HfKhGvSUT2hWX69wsrlpR6EH6its/e87eHIkYLixWg6C5tt8MyrCV3/Y6t9dvtWcONwqGmmKpTdY8VqHY+07AKAVAbzsMCIRiQdf4dqiH4UQgyknseXwLv2Q+DW4jEMHgFILjI5YnZIAbV6OYnlNvdCJ/SY9+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891637; c=relaxed/simple;
	bh=dnlmGXPEcYhTgPxZBSS7/wa9gFrkjIU/1UHPTQlBhdo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TdiFx+y/JXPCtcq4Uz/pJZCUUWibu8v6p0qc09vtuvB9kkVSM5pAXswcCU+G+xd06ALvSrbGi+HALVtm841S9AQz0lvwetZa6OmVsMeKwYhb1f/EieX3BEcbT04OgDFALYbor9Jxv0sCp3vcRGy2bzfCJF7TxJv6WaL9UFDBMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPl075kT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPl075kT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706891630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bsAGcHg3R5w+jwqE4BQl/sAhqa8aeDqmb871qT7igvs=;
	b=MPl075kTHvhvhzrczXiqlzGIchJX/sk23wngcP/mwEBkuXsm1bopHmTmV8RoRCR7sA3hhs
	oTDbyEy15D0d096XlSvQASG6G3N7X3WmBUVDOkfyo43NNl3A73jYnuUM+/+PuWu92KkVK8
	6vEwfPyvJd03wWYJSAw0vuxjcyZJjwQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-rSqY22s2NGmHROoFReHL5A-1; Fri, 02 Feb 2024 11:33:47 -0500
X-MC-Unique: rSqY22s2NGmHROoFReHL5A-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-68c4f54e6ccso28155726d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Feb 2024 08:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891627; x=1707496427;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsAGcHg3R5w+jwqE4BQl/sAhqa8aeDqmb871qT7igvs=;
        b=qzkMVwAaK28cr+6meHI39eYT0h6iAQ2jNWOIIe0M9LwBTJbrsHlqs623PL6mu+G+H5
         uE9ENWmpFH932xtcuvIsgkPVqqpc6hptgjU0oK/33u0nvVsFrVPuj64ecFj7xsm1YC+J
         nUP7g/64DbItIm08Y27wHtDapf7XWHgdqnvG+a/ms1Gvth5Kk2yTQr7s5wusUcuww+1X
         TIddyKR+VVuSU1nYiSOFdan//UWeUqXwucqnpvrQOMUrfouelPw52IIrHL2OYVJfXFPN
         +gQUbgtkBiJwfmSSdaPnQ9YgFrtQZF71985xQ6h0zrCtPXrMcGeQr/wEyO3oara0f6HG
         PBOQ==
X-Gm-Message-State: AOJu0YyPf8KYATzebb2+onf+SiZoI5SrBS9WjqFe55buzuWAQftlvN9u
	uG1GSCBfzTOCVR+PkNGDaYZ5ZHfLxOjJxKBJLWyfiEuuDTgMPVFA+rbUXlTHYlLLAGv4SEj8j7n
	h/0hAUijkfnFKnZDTHrzd8DrGM+Sx8wnLTnBNsJJehq9ucYIPGT8y+e6ToZngYT7U
X-Received: by 2002:a05:6214:20cb:b0:68c:440f:cb04 with SMTP id 11-20020a05621420cb00b0068c440fcb04mr9551251qve.9.1706891627117;
        Fri, 02 Feb 2024 08:33:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgX9KFPyIOzOIZvbNh7UGwGFhJb8GBeXvOVpVV2UaHyITvHSXQSa96Rili+/AQCFrT3umiCw==
X-Received: by 2002:a05:6214:20cb:b0:68c:440f:cb04 with SMTP id 11-20020a05621420cb00b0068c440fcb04mr9551242qve.9.1706891626866;
        Fri, 02 Feb 2024 08:33:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUo/BTaB54XpEGRtRqRZpsxVEde6d/f9vPHpe3cARbVNmtu2UCRy9nKaEOqF8JhVg8Nmpq+nIE/7e9KwFv6/gyH6D4Sxw==
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id mu1-20020a056214328100b0068384d86347sm942400qvb.96.2024.02.02.08.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:33:46 -0800 (PST)
Date: Fri, 2 Feb 2024 11:33:38 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
cc: linux-rt-users@vger.kernel.org, "Newman, Chuck" <chuck.newman@hpe.com>
Subject: Re: [PATCH] rt-tests: oslat should use MHz, not Mhz
In-Reply-To: <ZbvBUmLef6FabeUa@tpad>
Message-ID: <5abaff95-34f1-bfd1-316f-24f07cd73d9c@redhat.com>
References: <ZbvBUmLef6FabeUa@tpad>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 1 Feb 2024, Marcelo Tosatti wrote:

> 
> Usage of Mhz, in oslat, is incorrect:
> 
> From https://www.nist.gov/pml/owm/writing-si-metric-system-units#:~:text=NOT%20250%20mms.-,Capitalization,the%20beginning%20of%20the%20sentence:
> 
> "When the unit is derived from the name of a person, the symbol or the first letter of the symbol is an uppercase letter (W for the unit "watt" or Pa for the unit "pascal")."
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> Reported-by: Chuck Newman <chuck.newman@hpe.com>
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 4bdca64..e398f20 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -501,7 +501,7 @@ static void write_summary(struct thread *t)
>  	calculate(t);
>  
>  	putfield("Core", t[i].core_i, "d", "");
> -	putfield("Counter Freq", t[i].counter_mhz, "u", " (Mhz)");
> +	putfield("Counter Freq", t[i].counter_mhz, "u", " (MHz)");
>  
>  	for (j = 0; j < g.bucket_size; j++) {
>  		if (j < g.bucket_size-1 && g.output_omit_zero_buckets) {
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

