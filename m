Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBDF201258
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Feb 2025 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395461; cv=none; b=KFv2lKdDXHCbLuXOibqyP7SiCCIXTrWJVoabEyTh9e7PbSB56ag0+1W4moH/53fWpCZxpyZbDjwC4EksMlCHJwCZKXZpZt82AJZw5/QfMoVA6UhzF1PdfTDqDisWsbhdg17J56MSnpDShoiQbXfYC0F4Nxq6Mw4yzqzAMKrcFB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395461; c=relaxed/simple;
	bh=ElJgdTueVeiaZXHwmONPm/0Zh3YJ5PIPKgPVlgmWZHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuELcrqnC6MJhb8+Hj9WWsIpCaaV8YvrrboIUvWk+M9foMqXfqNVH0hTuthqgTerOMiYPLITzsfmWuWJc2oEIxyFum6yr9NUpI4eaa6rpJBhYdAb3S9rcDDcJPbvDKsuaYGo2zMjvMsUvTrPcawXGAr60kvGzF3YSAPAawV+FAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3DkAwCI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3DkAwCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739395458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2oyFMmA2f0EeBfD5OyOB5g4cAKzjwIAi0lY0lmmOe0=;
	b=L3DkAwCIrD87eryU/dk25NruEjJRjdvL5d/iFG0Op1rD8P7DoopOa6IWGtgiwVZ8IEonI8
	irFphJ+iea0GZP54NC9iPma1wYLfQyNCfsubOp2olCdl02KekAW0xzVnXccHHGOKRajGUM
	e4qVIrcUDTjcuTl+3HFrQ/WZsnoViVQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-T9BLHYZJMy2YiJu6Gyp1bA-1; Wed, 12 Feb 2025 16:24:17 -0500
X-MC-Unique: T9BLHYZJMy2YiJu6Gyp1bA-1
X-Mimecast-MFC-AGG-ID: T9BLHYZJMy2YiJu6Gyp1bA
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e451554bc2so4265916d6.0
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Feb 2025 13:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739395456; x=1740000256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2oyFMmA2f0EeBfD5OyOB5g4cAKzjwIAi0lY0lmmOe0=;
        b=JpZUhgxTwrSOp1rP0KODA83bEwxoqyRmVlTLj2jGW8ZPPablIy3egBR0YaJZypXDuN
         vzsxlVCvJwczgb4NpzBVYk5nn8J9KB7FwSgSNcv0brL1qbBFlqBWxVqYiq09ZiawY/nv
         CFpAA2cgSZGUS8jMAGw3olmiBxoxvWTpAOTE6EFVcpmc65lfVi1c9sk8j7m2/eDD9QuS
         jEKW3DpLjw0sAWfu99LLcQg1uZANSZ6rERIj+VsM8q4rdt7mpe9aqtXKRU+DoLiugvWB
         koKBidbrftyG5+MdyVHpUgTajhVRc+nSwo0wt3il1CWITitoL4DxSrzC/5Nq4BhWrspc
         MwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8l1IbkHxgY0i5qIbDaYANFq0wQwxRVpW5baw0ZbD/+NL3voRshfK3xiekvnzCRGpcEwGxUZtnSAGrQYsCIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5lyZ9ZETtADzHewkDvO2bE5R9XiCLrMQdhzTH37oHSD7Od7V
	KMeHpA5CdHMz4gTLo/POyUQrCW5kXYdaht+qadgR9ijJYFk7zU7U3r6J0RPY/0CuCpZnsBzIpEv
	BBxSx18A3eyeQTkp7rLHWO02oCbWDPh5T/dT9DsbJ0YMGK8CNhheSRu5nNeUYHmsL
X-Gm-Gg: ASbGnctFhnPCE4oDJxf+pU3EDxLRjim2gbzd79A6CYdD5wS+ngs93DGaXSHOUhI76cR
	+I+fYbNSx8BO8pH7uY4dvNtjyjBIe2ztLOS4owFthPmiPCBnvZbtphBdBhOzsGymYDZmC3zXhw2
	1uKUva4FfyK45Gp7ifTS/b1PNDuDQEpWDRqbL3uxzaJ7pXV/5MQ2866O0QQXat3lwvnJGTtyA9G
	W4ZaOAtcnbRYZ+iqsDCRbIUqFK82yL4PW9udXhxNPgLjdYcvaGv8JSGzhQ7ssaj4yPD5Hkht5Cd
X-Received: by 2002:a05:6214:d09:b0:6e2:49eb:fb7 with SMTP id 6a1803df08f44-6e65c8c0796mr9780196d6.3.1739395456675;
        Wed, 12 Feb 2025 13:24:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFAiUaFDvVHy8vJO/qnFBPOczoRXUKwL8tpL7+DIIdUSKE2UK30qH1mBv4W0P1Py2uin4XYA==
X-Received: by 2002:a05:6214:d09:b0:6e2:49eb:fb7 with SMTP id 6a1803df08f44-6e65c8c0796mr9779836d6.3.1739395456341;
        Wed, 12 Feb 2025 13:24:16 -0800 (PST)
Received: from thinkpad2024 ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e453819913sm62448076d6.16.2025.02.12.13.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:24:16 -0800 (PST)
Date: Wed, 12 Feb 2025 16:24:14 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2] Add cpupower idle-state functionality
Message-ID: <Z60Rfi05LXbjGfHi@thinkpad2024>
References: <20250128014551.15058-1-jwyatt@redhat.com>
 <21714eaf-d3d8-81bd-cc27-7a8aeb0bf971@redhat.com>
 <50cda06eaa30769ebb2c3130fce5394f1d8bd9ad.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50cda06eaa30769ebb2c3130fce5394f1d8bd9ad.camel@redhat.com>

On Wed, Feb 12, 2025 at 02:53:35PM -0600, Crystal Wood wrote:
> On Mon, 2025-02-10 at 14:50 -0500, John Kacur wrote:
> > For the -s option, why do we need to put the IDLESTATEDISABLEDSTATUS, if 
> > we omit that can't we just get a result like running "cpupower idle-info"?
> > Could you rename IDLESTATEDISABLEDSTATUS to just IDLESTATE_STATUS?
> 
> This was confusing to me too, but it looks like the argument is actually
> a particular idle state, not the status of that state.  So it should be
> "IDLESTATE" just like -d and -e.  Or better, "IDLE-STATE" like "CPU-
> LIST".
> 
> -Crystal
> 

Apologies for not answering you earlier John. Did not see this email until
Crystal's email.

If there is no objections I will go with Crystal's suggestion.

Here is the current printout for the patch series I will send (note I changed
a few items to address confusion). Please let me know if this addresses
everyone's concerns:

options:
  -h, --help            show this help message and exit
  -i, --idle-info       Print general idle information on cpus in CPU-LIST. If CPU-LIST is not specified, default to all cpus.
  -s IDLE-STATE, --status IDLE-STATE
                        Print the idle-state (cpu sleep state) of the cpus in CPU-LIST as enabled or disabled. The argument is the index of the idle-state of the cpu as reported by -i. If
                        CPU-LIST is not specified, default to all cpus.
  -d IDLE-STATE, --disable IDLE-STATE
                        Disable cpus in CPU-LIST's idle-state (cpu sleep state). The argument is the index of the idle-state of the cpu as reported by -i. If CPU-LIST is not specified,
                        default to all cpus.
  -e IDLE-STATE, --enable IDLE-STATE
                        Enable cpus in CPU-LIST's idle-state (cpu sleep state). The argument is the index of the idle-state of the cpu as reported by -i. If CPU-LIST is not specified,
                        default to all cpus.
  -c CPU-LIST, --cpus CPU-LIST
                        CPU-LIST affected by commands

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

