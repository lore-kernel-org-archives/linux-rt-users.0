Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30BC1FECB8
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Feb 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989445; cv=none; b=uyVQ7V74P4caCDNQMve3cY8rm5WcGeeHgXmBsevqw/AfXGOyiWcapKwCZjFSqZwJwwI6iMsUvzP4KdSEou8tSyCkJM07GnhGmgcs1h93+vvYHB9beLN9bNj83czlIhxipK34GxTl6V5NHoGEzy05D3wgeOUoDLdRktcZDSj6MaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989445; c=relaxed/simple;
	bh=1ghl593ouoTEOi4iLRM7ncrmBfrZ4B9HnKdgz5R9Ec0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jONYMZgmQHb0qypmRRfED6vCyrgbC0OKnKSx/sRU4Da3PZM9wb+LM4JoNN6hTmPVJ9QKXfvIw7hIX/fQRaA9x4ImWLl94kgF2UjCUyPL1O9gRJz1fnzhFTC0xF9tcHT4RvF3WbKDYH2qPlNrHNeh138OH2yEtSGk58QX4gLFom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2BT5Kll; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2BT5Kll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739989442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xgvHols8eBGZRe/0ZKbyMWC60FLXTADjOg1sl4RnbOg=;
	b=c2BT5KllaBKmjjhpFMduj63fvVIIqNzqCKSHRyYlmhSbjjalgXDGy5WlU/0JExo4EjtzF2
	+OR8wOELxjafrrjjWarjOgW89Fwi8L9JFlD7BG4sR/gxd3ZBURHPe33x0SWnSHFTwpRVFd
	2h0smxB1caT9oQ8s/r8jw0l4p3aivHk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-tQJXMDJuNxq0ovZluYhxAg-1; Wed, 19 Feb 2025 13:23:59 -0500
X-MC-Unique: tQJXMDJuNxq0ovZluYhxAg-1
X-Mimecast-MFC-AGG-ID: tQJXMDJuNxq0ovZluYhxAg_1739989439
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c09b9c6991so10585385a.0
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Feb 2025 10:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989439; x=1740594239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgvHols8eBGZRe/0ZKbyMWC60FLXTADjOg1sl4RnbOg=;
        b=NWX2kaHrPTG2LDSPNuqvWISjn7xWigySyvawogVbjc2+hHk9F9pc+8MbZVMfIpmoF4
         4kFELimcpnCPTJGjLwWz9RKODH4F0kbjvsRh1yLOOLQQksI/Jjmc3m6SX52GBsqCWLKI
         Q4qdhpkIwoZH8YePtwUoPr8Sg9zGwMAYy9HNL7Fqss2pAni4GeO/ZZMqZXbkVvfYx2d2
         DXIqeMXoRmTGrGek+W2OQU3Yfutk1JLLSiaH6cQSiXL7HFB4upEi/ayTibKM44BNkurj
         2W4u8x9Z0m2hnkeWMO/iQ39isLr+EysToLWWIvjXoAidc/V1MhGrRYkT+AYWxvVdF7im
         gWAw==
X-Forwarded-Encrypted: i=1; AJvYcCV95vsOlM89psdz1yFhiePhT0RuREQK8InD5gcy78pSol/i5LHMMm2DpAKVTp+9mS3W0nwZW/rw2q9JQzkG/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd+RiHNTFr3KBpu6chcgOwi8e6a1z7W2JtKp8hlrJXBrzoP+iG
	1YEQ8O1xSSBJaTpBLbQq/xzIC5OuSCXnXf5wpuNChZZqje9+c2ETHcIP6G2BJ/frYRhX236Ydeo
	h72IEvlFndYMUjpLPDd6HThwQeyYevpsIXprmUr64w647r6Nkb1dJZBB82SGk+jNv
X-Gm-Gg: ASbGncuLdIn1E9p+Wan6zgigKdb5YZWMaQZOGOnQE9vYxoa9LVkjGvMH+/CTgBfiw0U
	XBmT3ldeYFzAHwlZqrs29YPy/BhtGBE81gAmm8YTIV57MrLcFz8CoA+HBEwU6voAeBws7LDjNjc
	yoZohOYlsU0A6kH2HMF/NE0rl9vGWC0JNK6Y/OOExg/eXCjY0Xkk8WNY5TeXAM7xKCQgUWn4GFt
	vzu1+OBVTIQMsBw3pkIGcIMnOKqiBLogcsvY1z7dGorphDoJPcguXMgaxxxclaysb9bL6T/sYHn
X-Received: by 2002:a05:620a:440b:b0:7c0:ab9a:47a2 with SMTP id af79cd13be357-7c0ab9a4a83mr1086672685a.26.1739989438883;
        Wed, 19 Feb 2025 10:23:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzGkdmoW4Isc2uEMkwIo3ab+z8Gl8z7X4FoAH+GJBNecyDeZRXPF+X5B+Du9qTuoqHSyjLzQ==
X-Received: by 2002:a05:620a:440b:b0:7c0:ab9a:47a2 with SMTP id af79cd13be357-7c0ab9a4a83mr1086669585a.26.1739989438574;
        Wed, 19 Feb 2025 10:23:58 -0800 (PST)
Received: from thinkpad2024 ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f31b0sm77020086d6.90.2025.02.19.10.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:23:58 -0800 (PST)
Date: Wed, 19 Feb 2025 13:23:56 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2] Add cpupower idle-state functionality
Message-ID: <Z7YhvMPx8FZ03IGv@thinkpad2024>
References: <20250128014551.15058-1-jwyatt@redhat.com>
 <21714eaf-d3d8-81bd-cc27-7a8aeb0bf971@redhat.com>
 <50cda06eaa30769ebb2c3130fce5394f1d8bd9ad.camel@redhat.com>
 <Z60Rfi05LXbjGfHi@thinkpad2024>
 <2c97696aec2256cc15f2c045bfb313f7a7691c7c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c97696aec2256cc15f2c045bfb313f7a7691c7c.camel@redhat.com>

On Thu, Feb 13, 2025 at 12:45:07PM -0600, Crystal Wood wrote:
> 
> We could simplify the description as:
> 
>   -i, --idle-info       Print general idle information for the selected CPUs,
> 			including index values for IDLE-STATE.
>   -s IDLE-STATE, --status IDLE-STATE
>                         Print whether IDLE-STATE is enabled on the selected
> 			CPUs.
>   -d IDLE-STATE, --disable IDLE-STATE
> 			Disable IDLE-STATE on the selected CPUs
>   -e IDLE-STATE, --enable IDLE-STATE
> 			Enable IDLE-STATE on the selected CPUs
>   -c CPU-LIST, --cpus CPU-LIST
>                         Specify the list of CPUs to act on.  If omitted,
> 			act on all CPUs.

Will do. Thank you Crystal.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

