Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BA63CF
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Oct 2023 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="BXIdvRFe"
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113C1B0
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 23:49:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so12512720a12.0
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1697698179; x=1698302979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4fsl24vaQ5lmWfRns4tUEmavIiZ9vqKS6NpTss6DALc=;
        b=BXIdvRFe912W2wY1lunjJuSzWHKMGWBn24yApL4ppDN5QNkz/1ZJ73HRgYJniLMStT
         47bCUt6++lazzgcnezhYuVbQwear7IM0iWc2GDPuHdhd4rPh8tK9L7DEgV/3KKkTbDez
         QNubqb3QMSsXJp9cDNdS08EIIvawZMm0pXLWJJs8dDLkKLbgQrCV9Hl69CDCn5sgV78A
         JXS4RsZosgvsubzaAJ3GRRns2tcX0OIbjMWP0c69OTk7XyMMGzyV7VWwagiffR+4jvBd
         cVO/uCGFBQ4IrvWY9h2g2fUzI4FrX0Jvz62avCaxCRr2RK53IMFX2MDYcpTHADiAAJro
         3/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698179; x=1698302979;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fsl24vaQ5lmWfRns4tUEmavIiZ9vqKS6NpTss6DALc=;
        b=L/sQZA6JMqscoxxUGfolRiA7MmV0JwBVVap+nA7sALLccmT+bZSGwqzzfzYxbe4q0g
         5DsxOxM0n8Lg7PAEjD9aAkoglMfuWada2JQFv1K/9pQbMB59oCTwUHpndcoEqrNWipUp
         7lyGBzoL+YaKMmy9OGveVXEr5b+6QwWeXl2/A1nnetDZ496zMXOeHiKHEgH3iiarPV1E
         Skzwqs9WRfVkgwg1xV0rbEHe+79W0aT8wc50RjAtNr7lt2dYMqtc5UCQLaJSbdqvsmZC
         v2xHYOPam0Ra9RGJKRGZUfOSD8UBzs6bTvPT2uo/KVb8Yr/wwb8In6WR9wfOLV57qRDx
         0H/g==
X-Gm-Message-State: AOJu0YzMy72iewPPrMpBiaDVAFtn1EockvH4mkoP9KeguojFKbE2Ts5s
	EOpKiN7tZ4Bopg6XxBg1scZ1hg==
X-Google-Smtp-Source: AGHT+IECd4X2PS/1XJAnT+uLIZhhuKhzuhMsn464LAhsAwq87IPhDVP51QWFQxr9OS0ythPROMbfRQ==
X-Received: by 2002:a05:6402:2688:b0:53e:bb41:7506 with SMTP id w8-20020a056402268800b0053ebb417506mr845188edd.33.1697698179423;
        Wed, 18 Oct 2023 23:49:39 -0700 (PDT)
Received: from ?IPV6:2003:f6:af16:d500:92b8:d27f:8e42:2e4b? (p200300f6af16d50092b8d27f8e422e4b.dip0.t-ipconnect.de. [2003:f6:af16:d500:92b8:d27f:8e42:2e4b])
        by smtp.gmail.com with ESMTPSA id s23-20020a50d497000000b0053dfd3519f4sm3984196edi.22.2023.10.18.23.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 23:49:38 -0700 (PDT)
Message-ID: <d80768df-120d-4860-b3bf-7a96d02f7f7a@grsecurity.net>
Date: Thu, 19 Oct 2023 08:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "rt-tests: Makefile: ctags: Change obsolete extra
 to extras"
Content-Language: en-US, de-DE
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
References: <20230926110409.1244298-1-minipli@grsecurity.net>
 <01a0d368-5bd5-4c63-bea7-753205d710fa@grsecurity.net>
 <96accbe3-1755-8b4-ecb2-3dd4e7c320f1@redhat.com>
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 kdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <96accbe3-1755-8b4-ecb2-3dd4e7c320f1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.10.23 16:03, John Kacur wrote:
> On Wed, 18 Oct 2023, Mathias Krause wrote:
>> On 26.09.23 13:04, Mathias Krause wrote:
>>> Commit 974241c78a6f ("rt-tests: Makefile: ctags: Change obsolete extra to
>>> extras") not only broke the generation of tags files -- at least for exuberant
>>> ctags version 5.9 as shipped in Debian -- but it also added -Wextra to CFLAGS,
>>> leading to many warnings.
>>>
>>> Simply revert the commit to undo the unintended change and unbreak ctags file
>>> generation.
>>>
>>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
>>> ---
>>>  Makefile | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 32a9f41198a4..3b9e90d528e5 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -30,7 +30,7 @@ prefix  ?= /usr/local
>>>  bindir  ?= $(prefix)/bin
>>>  mandir	?= $(prefix)/share/man
>>>  
>>> -CFLAGS ?= -Wall -Wno-nonnull -Wextra
>>> +CFLAGS ?= -Wall -Wno-nonnull
>>>  CPPFLAGS += -D_GNU_SOURCE -Isrc/include
>>>  LDFLAGS ?=
>>>  
>>> @@ -253,4 +253,4 @@ help:
>>>  
>>>  .PHONY: tags
>>>  tags:
>>> -	ctags -R --extras=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
>>> +	ctags -R --extra=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
>>
>>
>> Ping?
>>
>> Can this be merged to fix ctags, at least?:
> 
> Sorry, but the problem is that Debian is using an 
> old version of ctags. You can either just edit the Makefile to build on 
> Debian, or compile a more modern version of ctags by hand, I'm sure there 
> are some other solutions as well.

Ah, I see. It's an incompatibility between Exuberant and Universal
Ctags. I'll sent a patch restoring support for the former in a moment.

> 
> As for the warnings, we want to see those. People including myself have 
> sent in patches to fix the cause of the warnings, but simply hiding them
> isn't the solution.

I see. I just noticed that ctags broke on me, dug up the offending
commit and saw the unintended(?, at least unmentioned) change to CFLAGS.
But fair enough, I'll leave it to you to fix up the warnings ;)

Thanks,
Mathias
