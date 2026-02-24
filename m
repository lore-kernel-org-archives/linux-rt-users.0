Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9322129B
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Feb 2026 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771976703; cv=none; b=HZ5F73YheU/j5i/rF+s+PnahN0TlXAjcoCeH8PsX9OqWh1uHElOzCiEQNpqopU85TtRy0VqFiwQTf1bz1cfnTmXBN9IbZD3FakA6RehfWqiTiiTl7Mb54w+9TKkljpnhYtpc44Y8rnJNJOyUSTdHz/DFE3Pabhh+uCwx/1AkuOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771976703; c=relaxed/simple;
	bh=5Bt42mNFJAU6xHcI+pt/SBPZ2TE33gm8dhMyUvy+bOc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m7Uojjnuki897elZ7fr/B2P8rwwGUuiqVr8lMF4gCYpsxRXpRPkQ2c9JE3vwThFxAjZRGT1F+3/NiapSxyaFvTtlu7K3k8OJ+mGrOsbBbCRzFUW8WTlCZV3XG4+kSy2jIBS3MLRh35iMc4g6PddxMKGgSVeswDPtuqPedYZamKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnEs6Lac; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnEs6Lac"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb4136d865so748265185a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Feb 2026 15:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771976701; x=1772581501; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzp5RN1ssh4asTnm0SnghYRxa1MLh62NOzLsFoYXty0=;
        b=DnEs6Lac0vH9eOEiHHVJDDCY9XTDczg62Z8eE7bEzrgmuoLGnzyY8hjJpL/lNMrzQ+
         vJrd4gApCXyzEugPaVIKkAd1uxIp6TywYzjMQm9Bx3KmFXFiGR1ia5kYvbQabTDk7Xk0
         ek3asAZLcd64bFjEIv9Ow3C/I4KAUz3W0cLzm/e2sRqRSamMYBnoeA8zm8Xyg79OP7tB
         84RBUd3YZEVosYjUePiXuotFDfXLJfhRew4dhPRj7XhhBDrMwVcypeRhXA9zH0aplvhT
         XOr8CBTrLYwv2mddS1g33xjXP2THNeSYKdTItaS+aVWRiLR+0Pj28ZP6t5MtB9506QmI
         Wjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771976701; x=1772581501;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzp5RN1ssh4asTnm0SnghYRxa1MLh62NOzLsFoYXty0=;
        b=PcTY8J15l/o0jKXXMaI4FkWfgHAyUvj++n5xdNXsUvs1tdzIhbiU3/hb+UqdqNPTvT
         NhHJ4Ff2Pu9xQzFUpqRrHV/lr693eNXQM3UAa4OHf0mcdhhAVSv3zfo81MNui0zOMQPp
         NsYhMFXLAgRKZss0qErTj/d0ntlTjckO/4uPOcqVsrlTFAXAJGJC8dMRxwPZj7gbz/3F
         SGuTgmyzfLDBS5v98a7y3NL1yutiuv7UZnce2A0S2qP/B+E+oobYCj8WAuo1HJPCX2uS
         M4yOX3C80TjbBJwGHoURWszJYUzmuyZDp6ACByF22Ueb6vn2k8OKbXabFsvStS024dLe
         Y8oA==
X-Gm-Message-State: AOJu0YzraUIUoFzLDa+yrT1YRHBSv6h1CeZ29pHHyZnuJo2+AUnghPaE
	DdNv+GTZQFrXnHNAegxZ6S40/IFXe/osoKeb3s1DLK3X4w98W+sS6usp
X-Gm-Gg: ATEYQzwCCrRtii+TqXmumw3EdR106Pex8RXXAa2UXgzAhCVlOLeCktg7Q80glUvC9tV
	Joiazui3zfw5b+3UyedIEmgp9e/+a4zhzHVBtCpawIi0+OIx1iO4e0OFxN6E/dvn1Lat0BPCcDe
	OMR6F8egem4Ckk1cWQ1S58PJuueas0TXKTHQUPXyaOnypUN0rNC69ueZrqLLJ+sRUemlfH0Grat
	VoWGK0aWTcWDZMg/WaOny5r31TjY9h+P78QlqkTrPIpyIoVnJAd4ewEYG6pVYO62tBwCm7Qe4gv
	SB8431OzzJY7sxEMjQrD7T2tGcoy1XKXu8MWlb6QdFgc8x7170XZmiOb73G8PIc5D+tRWff2ETH
	M5q/sY7AP9y52YuYORnb2YHitDJV985/RKi0uwUUnzgSV7SuhZXpZZ/RGUIyCPB1hM3spqDeNje
	FrotjJFNupC87rg3vnZIDpDsbs8cUHOKoa3C0oc47GePv8XpK1O0KcPCqCS2H/d/7hteBDRymNL
	A==
X-Received: by 2002:a05:620a:1a0e:b0:8cb:72b2:2a03 with SMTP id af79cd13be357-8cbb578caf2mr64441685a.4.1771976701511;
        Tue, 24 Feb 2026 15:45:01 -0800 (PST)
Received: from Cumhall ([142.189.59.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0468cbsm1040509785a.4.2026.02.24.15.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 15:45:01 -0800 (PST)
Date: Tue, 24 Feb 2026 18:44:59 -0500 (EST)
From: John Kacur <jkacur@gmail.com>
To: Costa Shulyupin <costa.shul@redhat.com>
cc: linux-rt-users <linux-rt-users@vger.kernel.org>, 
    Bart Wensley <bwensley@redhat.com>, John Kacur <jkacur@redhat.com>, 
    Clark Williams <williams@redhat.com>
Subject: Re: [PATCH v3] rt-tests: hwlatdetect: Add MTBF calculation
In-Reply-To: <20260220182428.75379-2-costa.shul@redhat.com>
Message-ID: <fb8a7568-21cf-aaf2-083b-d04b4bedb4af@gmail.com>
References: <20260220182428.75379-2-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 20 Feb 2026, Costa Shulyupin wrote:

8< -----------

>  
> +    if exceeding > 1:
> +        info(f"MTBF: {(float(detect.last) - float(detect.first)) / (exceeding - 1):.3f} seconds")
> +

With newer kernels you can get multiple latency events ie, the count  per 
timestamp but you don't know when they occurred. (the timestamp measures the occurence 
of the first event)
Does it therefore make more sense to measure the mean time between samples 
(distinct timestamp entries)

Does the following make more sense? 

if detect.samples > 1:
    info(f"MTBF: {(float(detect.last) - float(detect.first)) / (len(detect.samples) - 1):.3f} seconds")

>      if detect.have_msr:
>          finishsmi = detect.getsmicounts()
>          total_smis = 0
> -- 

John
