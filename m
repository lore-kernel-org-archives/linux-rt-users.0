Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895E36125
	for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348876; cv=none; b=uk3oybIwXNjUiDtiV8aYel5Mr8120ACJW6x0kWpGO2e/qgJ0IfGtbTAAI5yPDPfLmHEnuNTU7M/PnUrj1cPJM+uSmOyW7H8fwY8EntyBKAub8nwAsXqoKqso3Uqs074iCgqVLln0WKx9oIwikdHtsO8VmAWWXeI887vGxWSUxLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348876; c=relaxed/simple;
	bh=A1FGWysJZxX2wAfnqfI2yyWSE3DqDc8YJSBOoh2yRDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HMgZWUpGkY5kFLSQ9qp1yjZOCCub1AyBHBFMOPtRMc0s5A37uKM3dMak0uRKlMbFqTIXIBSgw7PHpwLAHYGa3T+Luo4XJEHjJHZreNdAF3TzVB+QI2n0rCm0SDJT5TwMC1XYJ9Dt91HvvGD35liYaMrcd+7kXwFenCKdy7i1uWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvl4Yl8/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvl4Yl8/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708348873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1FGWysJZxX2wAfnqfI2yyWSE3DqDc8YJSBOoh2yRDE=;
	b=fvl4Yl8/7gQN2UsoBkOOub+2kHppv0+OZi7yHbIP4yhYkz5HYpjWk/CsCe8wTxh/m2W4mk
	pgALFn8N3IPyssaAKmTxO2AdufM+yeM83iJlTmrULu4P/LFHRIsSWh2wybrDkLZdGs1luY
	C/Ptg5tirTfjSmYNUeQaQlPuVtXHkZw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-4Xqc17K1MFqfAe6zhmDHhg-1; Mon, 19 Feb 2024 08:21:11 -0500
X-MC-Unique: 4Xqc17K1MFqfAe6zhmDHhg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3158fbb375so165371966b.3
        for <linux-rt-users@vger.kernel.org>; Mon, 19 Feb 2024 05:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708348868; x=1708953668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1FGWysJZxX2wAfnqfI2yyWSE3DqDc8YJSBOoh2yRDE=;
        b=MdANU2FSz/Gcu0WFEcIRxDsQ/Y+en4MYfItTnuha6S6qh8pEdTWowEiHKNfiSvTYhi
         mXFK8R399+rruvCfMjZ1LZwY/HTxW+/c/QVWpFIGWlqD8VTBYTegVIgVOLPU5VKkR0Fk
         IbsVXrvK8g3MFE/ozIA3P1Zg+0OjFLObZ2gQNQbG0h7hO95wsvkhFfAcxzXNBIRYBgb1
         b8VQggt9WoMT6tsdFGxPkQ1UvDkWOWj/uh0ZwsJZHQQmKmW4wDCy3oKHYQUrb+MNbWSM
         +Xxw0wZyAxcRqO6oprfhwchrYjPDJ1Ey+YukYgWYEcU6jAIw/H839txWePP1Y4NN5WBU
         VHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkiJdPRvK6uTinM/uwdX/m+6A+4Tf/hvENgwtc+aHQ1mT9hFqg1OUHOc62xVToWimCQU2y1aW7wliyo8cjKrHTJHzqHIA+gyuVwR6s6R0=
X-Gm-Message-State: AOJu0YxLL2/mBZ+3gXCSe/IYFj4R7W5P+5Pf3BhL/BWuy44EwIkfBn2r
	hNtSiPs7WgaPscZcNDuyZVYWy7F4QztZQSvc3Ol1WwazaqyaSGXktzr/RunLKB9F03swqDouW4w
	Cd23xYWitCERrM6e6PgRunMDwsbWOh0oLRoVJUErgHwJG0yNnT9+om5Lc6DNVQKKS
X-Received: by 2002:a17:906:1b4e:b0:a3e:665a:52d1 with SMTP id p14-20020a1709061b4e00b00a3e665a52d1mr2477246ejg.0.1708348867953;
        Mon, 19 Feb 2024 05:21:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEjzIt9fWlwPWCo81hUSvDsjZS1JFyyqKR06M/cIFlcmUsxBDvEJXXupgDbSZ9CPUz5UOJnw==
X-Received: by 2002:a17:906:1b4e:b0:a3e:665a:52d1 with SMTP id p14-20020a1709061b4e00b00a3e665a52d1mr2477234ejg.0.1708348867654;
        Mon, 19 Feb 2024 05:21:07 -0800 (PST)
Received: from [192.168.0.182] (host-79-53-201-232.retail.telecomitalia.it. [79.53.201.232])
        by smtp.gmail.com with ESMTPSA id i18-20020a1709063c5200b00a3d5d8ff745sm2964478ejg.144.2024.02.19.05.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 05:21:06 -0800 (PST)
Message-ID: <7f10669d-fffa-40f1-86e2-db3033957b19@redhat.com>
Date: Mon, 19 Feb 2024 14:21:05 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Alternative to updating has_smi_counter?
To: Rodrigo Queiro <rodrigoq@google.com>, linux-rt-users@vger.kernel.org
References: <CAMnS4ZDigjkexNdJT3ZhLcmAMeodTKsPi+b91sSjE5sky7ZfqQ@mail.gmail.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <CAMnS4ZDigjkexNdJT3ZhLcmAMeodTKsPi+b91sSjE5sky7ZfqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/24 12:36, Rodrigo Queiro wrote:
> What do you think about removing the checks on the model number, and
> assuming that all processors with family == 6 support the Nehalem
> MSRs, including the SMI counter? Any user running a recent cyclictest
> on pre-Nehalem hardware could still run without --smi to prevent
> seeing bogus SMI counts.

When I added that option the smi was a relatively new thing... nowadays I think
it is pretty standard... so simplifying it is a good thing.

Nevertheless, the SMI counter is just part of the story. Most
of the hardware related latency problems goes outside of SMI "domain"
so... the best thing to do is to run rtla hwnoise (or hwlat) on
the hardware to detect hardware latencies.

-- Daniel

