Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E251EDA1A
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Feb 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855490; cv=none; b=VWIwJzlEILoeQqcxArbuvdosUZXG0bnuYPxV2y31C7idp41KNYw8Y8k+Mht0C7Vlsnl6CfnO/NvqiOVgQaSrJdOL3UuyfYEn59w5q0fDdmNpX9kBFxrfyDoQD2kec103NvQp+X+fWTX1CC6AiQHUN2JPlIH4VGf2Tgu8WNkXqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855490; c=relaxed/simple;
	bh=CpT07rbmdSdcQUBTbJOG3sNXI3OWGgw95FbH6Vuz2cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USom7sD71o8Hr+mJUvB5CHDSmmUZoa4qKNpVBawxms0pl/WadeMnF8KZY+wEAyeYVXz7mzlFmezXFPOrP2SyZk9CQYN9CpO/mhgDNJyBRKAw5ASf9habYKANBwC2bWwjkffZvE+PcsaNOzp/GMu7nTsUvKGKFtLp6ApwqV23pTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7o7S7rt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7o7S7rt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738855488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3A2jzCKMydEWdX1jRBbfW5jtkKqlApwGSKFA1pnDlM=;
	b=T7o7S7rthDwMFvgb0qGksuOCTE3+HLZhCr4Rdqtuvt64hDm186TPr9u6s+V2dPy1iXeq6j
	q4XUlEW7PzgLDDtRHxgnw1NKrqmXofZfkJPDR8+YxFh2hs4FdF31NX0bVV3rTTWwpAV0Xp
	Ewnhj0dJa7UT7kieSriLClIZKsD78PQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-U4zG5JBBOnSDBMpR9AwlBA-1; Thu, 06 Feb 2025 10:24:46 -0500
X-MC-Unique: U4zG5JBBOnSDBMpR9AwlBA-1
X-Mimecast-MFC-AGG-ID: U4zG5JBBOnSDBMpR9AwlBA
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f464b9954so5207015ad.1
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Feb 2025 07:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738855485; x=1739460285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3A2jzCKMydEWdX1jRBbfW5jtkKqlApwGSKFA1pnDlM=;
        b=otWpvutGQNGlwkszfnpLtVcl2p2mXIf21Z9puGCuK3/Wpnrw5YsCqIzYREkLD4zM09
         FSKVANzmPkwbEG/9VxhhyrrqXC4jdS1adlkFuV8UOj4p0FL6Ig/O0OOMH2AWDFvkfWhs
         /hFkTI2r6xqg/QP2WcWcyW/dUq8s8ZCI25dYC3Q1hk4TDBxQlzs+1zDk+7PmuWand6E+
         PyYMiorImn/Oh1GFJKUWOagNSNll0G6620UZb+qT4bahRLEXbxt2o90BPEoXn315jJs8
         Z0rw48a9xfG0BwXUOfMs6/PJ7d2LNBZdrb94bfdTn95PUtz6s9xX/IaWUsgu0JR9BjEW
         80GA==
X-Forwarded-Encrypted: i=1; AJvYcCWXzLmDdLhprdgcjScYhChQDRZN8Ke99AE2796EWYiMmTtS1aLPWYPDM3BMjUGUzphB95F22yR73bp480fnhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9aXxzCnRrgUSyPZUoxVwLiW23V5IujfD8OkvlYHBRg0hHKNh
	zHGzI0RXH+5Gz6xKvRKFe+1H8cMGtM4kGZmNDqoNrsattaOsxKCqYXglWeBVKDLov5SdoS0tC03
	WxDwmSxa0eTmPm7CEhzxUp5kGMZYUDpYqNXoK4v4LWNkwcjN1Yokv+mkHxzBEiMhG
X-Gm-Gg: ASbGncv/PbzF41gmL3PqZ3Y5c+gkFy0NkQYgo3Dh0v7vBPSE06HlbG3U8gZy+i51rUO
	T04Vr74HcxvyHG2g5xQ2cA5gbg8EziwsKBFquY4jBe81tFcZyhBnTsE6nU6WQNCyCBKvAFNXDIa
	ws8etZ+5pmnqS1fsNrTEXNCl5kCji0KUOQN9xBJQWAiQ9gB5k0pfigWF0dV4tGi9e3oVNnAEAtS
	GuGRVlX+za88u9fLRV4cv626ssiFOZCua2Y666zhTR+BV5+EevT2FGLtqeGeoNJ8vw6bIMVf636
	SdKXGWVt5Tl2SVPUiWHXaA8EBXkgly3Pi1UWhAf8vJaP/OCwcoDgaPmHNdRZxV7pDOucPZYG
X-Received: by 2002:a05:6a21:998c:b0:1ea:f941:8d8e with SMTP id adf61e73a8af0-1edf36b8f9fmr5796121637.16.1738855485673;
        Thu, 06 Feb 2025 07:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECEp7043yq38OUoTO23Srka3QUsDQ3ZiXSwm1F2dni256sJU5+LDQmdC0MrW5LTUdzIvHFDw==
X-Received: by 2002:a05:6a21:998c:b0:1ea:f941:8d8e with SMTP id adf61e73a8af0-1edf36b8f9fmr5796095637.16.1738855485362;
        Thu, 06 Feb 2025 07:24:45 -0800 (PST)
Received: from ?IPV6:2804:7f0:b753:c149:7884:c5c7:2b46:5945? ([2804:7f0:b753:c149:7884:c5c7:2b46:5945])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c1623dsm1450077b3a.132.2025.02.06.07.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 07:24:44 -0800 (PST)
Message-ID: <01ce78a4-0780-4af0-a9ca-6f654934ec9e@redhat.com>
Date: Thu, 6 Feb 2025 12:24:42 -0300
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
Content-Language: en-US
From: Rafael Folco <rfolco@redhat.com>
In-Reply-To: <20250206150947.GYesymE5@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/25 12:09, Sebastian Andrzej Siewior wrote:
> On 2025-02-06 12:02:49 [-0300], Rafael Folco wrote:
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
>>
>> Instead of:
>>         Core:    3 4 5
>> Counter Freq:    2100 2100 2100 (MHz)
>>     001 (us):    14880514 14880447 14880442
>>     002 (us):    0 0 0
>>     003 (us):    0 0 0
>>     004 (us):    0 0 0
>>     005 (us):    0 0 0 (including overflows)
>>      Minimum:    0 0 0 (us)
>>      Average:    1.000 1.000 1.000 (us)
>>      Maximum:    0 0 0 (us)
>>      Max-Min:    0 0 0 (us)
>>
>> We'd see:
>>         Core:    3 4 5
>> Counter Freq:    2100 2100 2100 (MHz)
>>     001 (us):    12578842 12491108 12578752
>>     002 (us):    0 0 0
>>     003 (us):    0 0 0
>>     004 (us):    0 0 0
>>     005 (us):    0 0 0 (including overflows)
>>      Minimum:    0.033 0.035 0.035 (us)
>>      Average:    1.000 1.000 1.000 (us)
>>      Maximum:    0.129 0.153 0.134 (us)
>>      Max-Min:    0.095 0.118 0.099 (us)
> 
> so core 3 has min 33ns and max 129ns while 1us on average?
Yes, because avg rounds up.
There are some other potential fixes coming like:
- stop rounding up avg
- splitting bucket 001 (us) which is bigger (0 - 1.99999)
- adding the max bucket to the end (do not limit to 32us)

... but these are out of scope for this change. 

Folco
> 
> Sebastian
> 



