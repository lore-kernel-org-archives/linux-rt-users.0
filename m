Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2E23645D
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858988; cv=none; b=tLyiZwwyjEbNatnQ2BVswy+MTEbFeUa+8JIKA+Gzj3SHs6cF9QDFR3VDv5boAxaqFX2cOT/yktZHPjq0356A+aZU/hFk4yi0i/iqp8Qb9zuPEAUeKEAWGegUgEfr9i/IEL1GgQj6FvH5hQbFVulq2A2L8btUYPL5D9zRViNutTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858988; c=relaxed/simple;
	bh=Qq8vQFgmQ6W8PE2zq8xcM52QY7wX+Rosm3BniXRhypY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6KYuA6ZE7VkY7xnIlDJz3b6glEJelMK06ngKVdPV8IKZ8Bvoha1Zp+37ftwFQb0YH8XdzaWjxs3JAvEOxobYCZXVm2G57vxjWJWybbu+i6zNswDge1FLbmSGPVRRjb7uF2pUfR6eLPeTF5iqmit0sBlOqx+KUJLpYDfH4gTeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHLPond7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHLPond7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738858984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXWsRJiNcddYYm5H1SzYpfuNGCfbnBOW9uK89/DR1BQ=;
	b=ZHLPond7xjkzjuH2vlA3GFaf4fqhh567c2jQ1jCeLripwVoTE0+fHcVqc0cRkhDjJ2hrqY
	WijXzVTE2S57mokM2EYZ9Fxe1Rk2njqDfmVcOoSu/h4SpVFwzRFdriJm4HqQvGk7HDNRf+
	9pQMSB3kHez7+k7VXdcjHIMtAWIQ4DA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-KxLxPf3vNEuf-H30TnfNuw-1; Thu, 06 Feb 2025 11:23:02 -0500
X-MC-Unique: KxLxPf3vNEuf-H30TnfNuw-1
X-Mimecast-MFC-AGG-ID: KxLxPf3vNEuf-H30TnfNuw
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21a7cbe3b56so17254875ad.0
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Feb 2025 08:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858982; x=1739463782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXWsRJiNcddYYm5H1SzYpfuNGCfbnBOW9uK89/DR1BQ=;
        b=AGBKaC5TBLzcUVZ7QsWij+UUuX6i93A6CF4QMi07tNK25JgOTOZo5xxQTQRJhj6xXR
         Y7BDEO0ewUsBPMx+jqu5kInFKc4D+8P+oFZtIO8eKoGgRDxDYT/bIOk4Vsr64SFH/WvT
         QYQZUD2SBJFr6kXcYkv0eOBoK3DkUcpXykxX3Y/lt2DSdYqGomz73vzluG3QLm7e+524
         2K6nscocVJJAJNMXu7BnsEotl5iVZRBqTcYso4x3lKiUBsr2ckYhLtZySkae6szDXLls
         LuaRuLSyshDdBr8Y/ujfNTQLsVnYLURYqDlAXYXAojlWhXHguuAx4D5OfFtGzAOuxuw8
         TYPw==
X-Forwarded-Encrypted: i=1; AJvYcCW86FiQdD/Q9dIw22prUX8Bq0FYGJaikvcrWn1gGDfypyJz5ySGg0nn5yago6sL65oD5ykT6GAnT4PItjAfrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRO8QT7lWvzz8jJLuwlATkwKSHpSmAABL7vfgwQytJoYrHpF7
	vH5+KaIfoKAq2n3kP9awEPqIsGFv6d1YZmHF8QQvLcua9XJCz9Y3EyKYjUaTF9EAsHsiuPFxk1D
	k5687FIM1KukcIh55DarehxFZgMya55R3PcN4nTO85okRfYeQWJQQhTpZPLh1EDgp
X-Gm-Gg: ASbGncuIqVvki07lxZzw6pZDqj1eHp+JIh1TMWEBibYd5K5zngfF33BRcKrPcsalf6e
	Ld6ohR5U1+cpRJmo0rCyUeGXHoIf6KUhCa+c09jZoRlNmWydDq+pA/irBclx2se4CZYAp/PcrfZ
	8m3/6ncv9QLUI2LnVzpSOQp5w9M5j9jLX4+74H//gp6VCcWLjnsz53mSVx3Pn9wQYa2XXUaugrC
	PTBLx4zPl/ppn2mTR/pNP1rmSjQFJRMwptNXFjICdk1k3p9oXlOOONyslwzEU8ZNiQR1wB4XYjO
	5qpWKMKtDJCsaHjblT/CnOf5F+AGhQKf7ByPrIgtmatGsYbV8PDbvspaOyv9eVGpGw4k6WxS
X-Received: by 2002:a17:903:2f92:b0:216:1cfa:2bbf with SMTP id d9443c01a7336-21f17ebb67cmr144031835ad.35.1738858981900;
        Thu, 06 Feb 2025 08:23:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErFpS8R0ozHPHNBnMz1DH0cMO26fmSdXrmYU6rkps9Ns31Sts8zyOFRwHt5DkqyRsEM05Q8Q==
X-Received: by 2002:a17:903:2f92:b0:216:1cfa:2bbf with SMTP id d9443c01a7336-21f17ebb67cmr144031475ad.35.1738858981587;
        Thu, 06 Feb 2025 08:23:01 -0800 (PST)
Received: from ?IPV6:2804:7f0:b753:c149:7884:c5c7:2b46:5945? ([2804:7f0:b753:c149:7884:c5c7:2b46:5945])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368c07f8sm14707675ad.236.2025.02.06.08.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 08:23:00 -0800 (PST)
Message-ID: <4d57252b-9fd7-4566-a517-75858aa18d90@redhat.com>
Date: Thu, 6 Feb 2025 13:22:58 -0300
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
 <2cb9215a-61d8-4b97-af66-6ef4194f3e04@redhat.com>
 <20250206150947.GYesymE5@linutronix.de>
 <01ce78a4-0780-4af0-a9ca-6f654934ec9e@redhat.com>
 <20250206153638.vagnFWGA@linutronix.de>
Content-Language: en-US
From: Rafael Folco <rfolco@redhat.com>
In-Reply-To: <20250206153638.vagnFWGA@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/25 12:36, Sebastian Andrzej Siewior wrote:
> On 2025-02-06 12:24:42 [-0300], Rafael Folco wrote:
>>> so core 3 has min 33ns and max 129ns while 1us on average?
>> Yes, because avg rounds up.
>> There are some other potential fixes coming like:
>> - stop rounding up avg
>> - splitting bucket 001 (us) which is bigger (0 - 1.99999)
>> - adding the max bucket to the end (do not limit to 32us)
>>
>> ... but these are out of scope for this change. 
> 
> I'm not totally against floating point numbers here but you should add
> the bullet numbers to your patch description. Also you might lose
> precision over time if you deal with floating point.
I will add more context to the patch description.

> 
> However what you just showed me looks like the statistics part is
> working right. I mean max lower than average. At least it is above min.
This patch just reduces this distortion with Avg=1.000 with Max=0.153. Still not ideal though, but better than Avg=1.000 and Max=0. The idea was to propose another change for Avg, like Avg=0.087 instead. I can include it here if that's the case.

Thanks,

Folco


> 
>> Folco
> 
> Sebastian
> 

