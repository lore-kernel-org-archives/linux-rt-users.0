Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90491624C7
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Feb 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938046; cv=none; b=GGGI1b8mgybvrxEoz0viJyC1zIKo/RRk59QHyiDeFzYv20uDSUw+TCzRPlwaaobTQY5YI2b3cmxLcIEnjnMFJ8JfBN1Gme1l3VpnHyV9d8OBQD2TCwy1Yh21tbKh/OcQbyXzBM531txJOGvMX9B4PU5zKtgJ/cMeSs+4TC6yC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938046; c=relaxed/simple;
	bh=1wGYcBGxpIU7fle693PWj/gE1jH2VRR08+OC4MFHun4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOOdzDbLeUBcGnvnojhysDan0dKyPBqlo4bVyJ2egw7QmN+DWOK+IYY1iIdDLbflPczL/2fQObwRt0CqFCts2uvtT/mst6nBOCQaagxrL2R9YxNC9d+LZyiQ75UUpfSiZ44eqHFwHKdK+ug44V0zeEDr9b+Nn5B+u9dTXMt88PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eY/Yaw2e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eY/Yaw2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738938043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9Bc6fH4VXlTyrQVfsJ64QwcZcAnovHNCzGIAL3+4fg=;
	b=eY/Yaw2eCGR/2izBersQvYjU8WBwFxwrtCtixnVUtaNduVLubLcRozNAnkqTqE/4Rk+SaF
	dgSztkzc8KTuPghFlJvfc3uuFW9KFqwBPPiA80cWqC28krNjLE3n+9qeZN8hn5tiY0hWa6
	xSW5U/PWgZR8aA+4W/roG7/esWBCEzY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-7pKK50JkNGm4Q8I1Z598KA-1; Fri, 07 Feb 2025 09:20:42 -0500
X-MC-Unique: 7pKK50JkNGm4Q8I1Z598KA-1
X-Mimecast-MFC-AGG-ID: 7pKK50JkNGm4Q8I1Z598KA
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7bb849aa5fbso474554085a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Feb 2025 06:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738938041; x=1739542841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9Bc6fH4VXlTyrQVfsJ64QwcZcAnovHNCzGIAL3+4fg=;
        b=FNsyle8ls3QYKtsZGA4/jKgcObwLCxOyK/xfGnbg3XSYDgWpN4LiKD3tFME/AoJhay
         UspM0BkAgincTB2S0+7/Gt1LJC8voZjfuWHM9HghiR2Ufx/15VAxTmrdDfXUubVT75Tq
         roovT5goMNARREFhO5B4i2theIr2AgeeAu8urug7i7q0OU9sb/l6igwNqVkzefwSqAfx
         QH3YvBut8a2ghgpd/NjLUm/fkV/K2ogIFP10d83XJI3CuiPJxcORMaTR7Cm8iMVpQ33N
         J9t4A71DOtZ3Z9sM2Z17BhSqU7TTG/tQoQrsmSzACPniDrIeQcdaxZy0fqkrftLVYPwW
         QJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnpXUNmlM1wHiMOCHUPf6+lFJ7aeBrAd1HGGDL8GuicV4exqLG9tf2bBmrgiTHWXZqcZl5peBS0MFmt3sfjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxROrabnxHVi2Dc5kar4taxQruHz5lWozacbaUexNV0R1jrOp63
	RBUDxFmmOCkqlpedDx+CF9ycOD6wFFD9ifAg0fR+WhuwJv2HQpz9kzc/y+UBK1IOFrc0IuCSh1t
	8IJALXl19gV4rFTlPXQ3qXLfcz6ys2SxeB3ypqK9o+F908vjb+E1czhuOQdVyOJlAMHBlqoJbDM
	7Ndw==
X-Gm-Gg: ASbGnct7JyaZLXW4SUrd7FFRWfRGDa8YOEO8rq4f3Wq7Wv4OEkQkj3S1++DoeC/RLaQ
	/tXDsELr1Zex/o2PEIkJ0GpVWzq1E6kFI51pEY3ftPlD6LKTjmYOPKsg3XwzbAf2i8aZMdyUath
	OXGRUmiqh5B0mK+XjNrDCa9Ki8UXBlYmH76iMRQl94vvUzxHQX7aMOd2wgndY+eeOGkzQJt9L8N
	iajNsS0VDD26tSuCutiTH/cI6v5tjrfXpiO5yZ0TStyMfgsLRC+O17HKy1rbJCjyydpNiY/oC6t
	YrB/qHFx9n1T6EHpXz1mPnF+ai9z0Q3keSpxwtmapZJzs3r5gqWJfrdgo1TO09+A8cvK0ZTa
X-Received: by 2002:a05:620a:1793:b0:7b6:cb81:95d with SMTP id af79cd13be357-7c047c41e85mr557791685a.21.1738938040892;
        Fri, 07 Feb 2025 06:20:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc7pr7K4BHGaZyLEuCndR5UyAULic9AZAjXHSDUZ3hwX9wtwlvWxdbYUxqBO0mSCqOY4BO6A==
X-Received: by 2002:a05:620a:1793:b0:7b6:cb81:95d with SMTP id af79cd13be357-7c047c41e85mr557788785a.21.1738938040625;
        Fri, 07 Feb 2025 06:20:40 -0800 (PST)
Received: from ?IPV6:2804:7f0:b753:c149:1db6:646b:8893:bc83? ([2804:7f0:b753:c149:1db6:646b:8893:bc83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec312sm194800785a.11.2025.02.07.06.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 06:20:39 -0800 (PST)
Message-ID: <37c7e3c7-d9fe-4e8a-9b5d-61d041a9151a@redhat.com>
Date: Fri, 7 Feb 2025 11:20:37 -0300
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Change min/max to float numbers
To: Crystal Wood <crwood@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: williams@redhat.com, jkacur@redhat.com, linux-rt-users@vger.kernel.org
References: <3a9f0f10-2e7a-4eb6-b094-e5492b43505f@redhat.com>
 <20250206120056.oE88fgG6@linutronix.de>
 <2cb9215a-61d8-4b97-af66-6ef4194f3e04@redhat.com>
 <8144971da4d48d1f3fc75decfff2434fc44f082d.camel@redhat.com>
Content-Language: en-US
From: Rafael Folco <rfolco@redhat.com>
In-Reply-To: <8144971da4d48d1f3fc75decfff2434fc44f082d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/25 18:23, Crystal Wood wrote:
> On Thu, 2025-02-06 at 12:02 -0300, Rafael Folco wrote:
>> On 06/02/25 09:00, Sebastian Andrzej Siewior wrote:
>>> On 2025-02-06 06:16:22 [-0300], Rafael Folco wrote:
>>>> Make min/max consistent with avg by recording the latency samples
>>>> as float numbers instead of integers.
>>>
>>> Why?
>>
>> - More precise numbers of Max/Min for extreme low latency cases
>> - Distinguish zero latency in bucket 001 (us)
>> - Distinguish values from upper/lower boundaries in a bucket
>> - Clarify confusion on average (round up) vs maximum in the next bucket (casting)
> 
> If you want more precision, set --bucket-width to something lower than
> 1000 ns.  That will cause everything to be reported with ns precision
> (though maybe not quite ns accuracy, depending on the hardware).  We
> were hesitant to make ns precision the default in case it misleads
> people about the accuracy (plus I didn't know if the change might
> confuse some tools that consume the output).
Yes, it works for precision. Average is higher than max with default bucket width, though.
> 
> I don't see the need to change things here -- and I definitely don't see
> the need to hold on to the unit_per_us stuff if we're going to always
> print ns resolution, regardless of whether we use fp.
Ack
Thanks for reviewing.

-Folco
> 
> -Crystal
> 

