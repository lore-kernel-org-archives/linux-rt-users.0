Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F023642A
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854177; cv=none; b=CXhUnPRcYyifAtiEp/YdvifMF9Yfy3xzQ+VgFTmpT8kvW9gcHIfRpu3D3bICECA9j/wqa2iSq3i/rODY3lTcyKRfS5hRf3CqTbEMQxYRi5vd6gyeCdkySHtZIA3HeSR1j9kVTb/z8Bw9IJgEVHpapsj/W5uofteH4kH6JRr9Djo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854177; c=relaxed/simple;
	bh=CPYyfnIpAHenG7QWWNymcFLc+2zv1S0qV4H/GeLHfyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV5ycXyL+9kGTQp5FHZ8KHfyo/CWiWqLh0TZqCG2qlb55NZ5a73cIKzLZ/i6g9Z6X6IxpHPQZB8l7YQ9RztLv/TSdy5WvcRxLY1kpifZRWNCuKLkF3Y6shPyydSOiV2zzFfojsm0GAOe3tO+7zIpa5LJfOpy5+jFFSS7wV+4Ni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1SgTGRH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1SgTGRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738854175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IosOSjiyf5wI2cgcDaKV04ZIafkGLPK73T7wF1ci7+Q=;
	b=E1SgTGRH9K/tnEacEs9ySuvSimA1/y0putHdTSepJCgJClBBhoivTwSm3YChsxkjJffCt1
	M+5gE51ck2V3+LK4BER3Lm7wxM/nzsXE8RLpsoBovmCKDi7sHb6Hjijh5nVFxr1cOzjDxa
	kXTwg+LO5jKpVJdLjuFmezttsk29RKA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-t1ypTiRBNpyQl5xQz0MZUA-1; Thu, 06 Feb 2025 10:02:54 -0500
X-MC-Unique: t1ypTiRBNpyQl5xQz0MZUA-1
X-Mimecast-MFC-AGG-ID: t1ypTiRBNpyQl5xQz0MZUA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f02d17cd0so18204675ad.0
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Feb 2025 07:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738854173; x=1739458973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IosOSjiyf5wI2cgcDaKV04ZIafkGLPK73T7wF1ci7+Q=;
        b=rdL2JcMtEoc/CIfuc0L9gMXkAq/Mc+tHMX4eQYA+1AbuXPDUuA7qLfaRVzc15nT7AH
         hYUGRqyV9Zt8k4IqwdBRsXqdri7HBTTCPk7ZoOT2mJdNhWogvrgVckbgB77RbUSaIyVV
         NL0zycZWcfGglrn+OACMOeU+FPhCeVQdBgq8BgW9laZR+adP/dcFeYkeE7AjGDRDq8OC
         QcacoLJgi4Va+65FVZQGYrFQJImoSWMQheBGtFRsSEZxG3z2wHIteqGKL5Y6+d+kuHYy
         zyFdLzpUM4SES0/47rr5EsmUw/zj4gQFFVc76P0Bq6l2wtY6LYOCiJ4YyBsjBci4eESz
         iyng==
X-Forwarded-Encrypted: i=1; AJvYcCWTF1dNpJEYgtiuTEP4aa4wHbktSJDzqc8Z+g0xPMbSutyID34YihYWSIGjwernp0+CEzWS2t1JRcylPIN7Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3QP3vrFTce7JVFxodUwmn+exUA2Z5sCODK/4WVo1/U2jbJKw
	LojxYWswGmR4Qudh99GC8VlhiRP6fquTcoSUHm2QuLT76ODkSy2e0oVCElNjEQgv2MQS4LI09NM
	dKNXjHyuk2WjXn+GbRGWIBcrqJDlGKHYhcx2EvCz7QJCNfY0NxK34scAGtYSwoLY9
X-Gm-Gg: ASbGnctoLJhQjTXxPYuTIO7GY1O+vzA1AdZ2Vg796sEyRb9bv2q0C8hn3MnYQyM9E0h
	GJg3b30iAdom7irWUKMim0vtNOnFHqVfhAoY//uicO3a2BK5JjOwu6x+45LmmhfIOYC68u8LG/l
	tzUmdqZh8vU7h20Bd2iHPUXEMQJm80pBOn1LJCaeJKHzJXTgte2837nd488TnDMs9oMPUekszxL
	sAlMfurERMpJQACFgfvu0N7NF9PQkbv4ergrozY3mRhqvyu3WV9KjVccdlNqm+V43BJBO0nidn1
	Xr5S7mmoKsSElorwMeGLE21XmUMq7WprTBZGjdO2GtX14f4RgUvvKibPr84+d1RgRdpd0OR7
X-Received: by 2002:a17:902:e803:b0:215:e98c:c5c1 with SMTP id d9443c01a7336-21f17e74e67mr113052145ad.30.1738854173013;
        Thu, 06 Feb 2025 07:02:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIkdNA/7VtzxklZu3UhjGa392JhzWC73gGOptBwbIWfTOOT2sNrB/VEyTNFZ1gWzVvkkRuKA==
X-Received: by 2002:a17:902:e803:b0:215:e98c:c5c1 with SMTP id d9443c01a7336-21f17e74e67mr113051805ad.30.1738854172691;
        Thu, 06 Feb 2025 07:02:52 -0800 (PST)
Received: from ?IPV6:2804:7f0:b753:c149:7884:c5c7:2b46:5945? ([2804:7f0:b753:c149:7884:c5c7:2b46:5945])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3655e23bsm13881105ad.90.2025.02.06.07.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 07:02:51 -0800 (PST)
Message-ID: <2cb9215a-61d8-4b97-af66-6ef4194f3e04@redhat.com>
Date: Thu, 6 Feb 2025 12:02:49 -0300
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Change min/max to float numbers
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: williams@redhat.com, jkacur@redhat.com, linux-rt-users@vger.kernel.org
References: <3a9f0f10-2e7a-4eb6-b094-e5492b43505f@redhat.com>
 <20250206120056.oE88fgG6@linutronix.de>
Content-Language: en-US
From: Rafael Folco <rfolco@redhat.com>
In-Reply-To: <20250206120056.oE88fgG6@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/25 09:00, Sebastian Andrzej Siewior wrote:
> On 2025-02-06 06:16:22 [-0300], Rafael Folco wrote:
>> Make min/max consistent with avg by recording the latency samples
>> as float numbers instead of integers.
> 
> Why?

- More precise numbers of Max/Min for extreme low latency cases
- Distinguish zero latency in bucket 001 (us)
- Distinguish values from upper/lower boundaries in a bucket
- Clarify confusion on average (round up) vs maximum in the next bucket (casting)

Instead of:
        Core:    3 4 5
Counter Freq:    2100 2100 2100 (MHz)
    001 (us):    14880514 14880447 14880442
    002 (us):    0 0 0
    003 (us):    0 0 0
    004 (us):    0 0 0
    005 (us):    0 0 0 (including overflows)
     Minimum:    0 0 0 (us)
     Average:    1.000 1.000 1.000 (us)
     Maximum:    0 0 0 (us)
     Max-Min:    0 0 0 (us)

We'd see:
        Core:    3 4 5
Counter Freq:    2100 2100 2100 (MHz)
    001 (us):    12578842 12491108 12578752
    002 (us):    0 0 0
    003 (us):    0 0 0
    004 (us):    0 0 0
    005 (us):    0 0 0 (including overflows)
     Minimum:    0.033 0.035 0.035 (us)
     Average:    1.000 1.000 1.000 (us)
     Maximum:    0.129 0.153 0.134 (us)
     Max-Min:    0.095 0.118 0.099 (us)


> 
>> Signed-off-by: Rafael Folco <rfolco@redhat.com>
> 
> Sebastian
> 

