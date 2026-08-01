Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CCD3803F7
	for <linux-rt-users@vger.kernel.org>; Sat,  1 Aug 2026 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785554699; cv=none; b=McAF6PE6LCYvi0Vt0QF25fguT/eJ6Zx1i0ddaNlEXxZqtsJnSVfykmrTpK4qfjhb9MJOQvo5KGmadtPk2mV9qrpfb2Q0eO/ipGkEZeXEfDfsfkQRTVENylGWlO2HaiIfk2FgH0UkNsISt7+or+7WanRb/Hd4gXeTNnLQUv/3p0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785554699; c=relaxed/simple;
	bh=FmOpTq2+iBSsrWKdMYdJ+Xcws4k/f1mU0/wdD5teHms=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qBC6bwlTAzHKXv2OUQlcpOLQD3yrl27Nkvpm7+Dbt0RtguTSDx6s3PjzWVhxQwefpKoZN+soHgEVwsgfywU+xQO87o/zATzXFQR5w2vzY5Z8j3FgToICTM/P0/ZK7OLOqYGpLPYuw5IN5FH0T0d2U8so7A3NaeXspIyodeP+Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leB5c6RP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leB5c6RP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e65e18969so103785885a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 31 Jul 2026 20:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785554697; x=1786159497; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=edUGgfF2uA2NNrmYhVn/JdXvAe/RotP7vWMGf383zPA=;
        b=leB5c6RPebnnwN/7mE0SUqZX3Fooeo3cmR+xzpU1ySah1uzpo7njREX70qN0mqEaOE
         LNONDgtWGwFzwdnttluPPBbRJejcoe1PxpuO1AXxJUFGtuV75FhQ/BLl1VF3fHUweiYC
         DDrwLQLAbS5ulLkdCrtsWpsUv0InSjBPElbo0hyMyWDuW0CmJa7wfiebR7cqbCeICyP8
         qAZFFNbUmsU4yy7pqddXo/CeUBCRsfo4tD+LIaanreh1sFNROB2guJGruZu/EX1xkTfY
         oeWkfAEPYE/7olStg4Hhh9Q9tONs5UKRddxB8f3LXOueL/AdoxVbPyv8GJPX4nj0Ldy3
         Hm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785554697; x=1786159497;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=edUGgfF2uA2NNrmYhVn/JdXvAe/RotP7vWMGf383zPA=;
        b=O/MTGjgl+uisAJAQ7e0kF5nWrO/5RgJFeKaMffUuygrsoj1+qDOLWx/ypdiCPsdupG
         pn3+wC2ZXp9+Rvf7jC8+Ad3wTFXWKN40+P2ocdNz79alpILtaTsGzlcBqwLRfgQctA+1
         XgLcwh+kVWW5FD1ygqyWU8U6GyayLVyVmllyY5h4YldNTc6MpWWSm+UTCY2/hRciQ4LW
         Lo7baHjRinBYve1Mm4g+3XxgzoYz2TAedAQBmXxJDRu9ZSTLl6b7UZMfcOKUb8lQMBlZ
         lMTCijSFH90ExkKadA8PrzUvKLndayA8y+YSL5dwCrJkaC07P2MmJUe/YhxYSNsNOugS
         hWyw==
X-Forwarded-Encrypted: i=1; AHgh+RqeXfbqDTaG2YeL1vUkKvDP3V/7NN+WtL/c1FiyKnFoY7go840XFs0SfmAE0K/+x7LUTWYoEGcVU8EQhVjGsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrjbpSqXSumbDASWS8KfkeCoaF1COglAxCZKZOx8xLyoDw6pg
	gFvnBkERMSr+eCmJEI7/G7jk954KR9QwYYblm+LzOSvShwtT2mCpw/jf
X-Gm-Gg: AR+sD13ElaYA1bqHWpNhbBb1ccFacM74i98YiW61sTET1JjNulh6BotIp36TqIh5tDY
	7HWJGYUQuVNiTt8+DD7FPae9RZC1c5QwrBIjKpGn+py5gcEr9P1H/+8KzhWvo/v+M41QbH4uxMM
	IeeUpVrfRUDPi01TH2F5126DAuzK+wCXGkkgDLmJ4aDqlj6jCtqZFyV5oXp0zAN+d3I4uagDOdN
	DPkFuLc+wd9IoU5BBf2YnZSY8JH9/3a9w4LdZQbulguTPmpXw1ZZJi0dl0LTIIFg3WV/If9sKRC
	sVke7lsG3HJ0iRYpdhvc5RyX4aTe+eQRVibT2iJElS2Drl7S9Uspn+GzwgtDL5Qtbn6bXRma3FQ
	a7W5yxGu6UAoeYP7/nibQAuF2iLdJGwPiPI6QVzK2NuqwD0avLjYVYSZRfe0+v7Cv8rdqV7M9bq
	wFUNZKLHqUgMJypfFQjBXvLSdv1as50T7WVkdrACYug7FkP02fJ1zHy7QwzWVVnRYYPP68jIl1q
	BS4WZI5biRmUNdg9ToBjo4sUv+iJCdf1GzLFE6H48llQCczVi3IphUgYNRs986cQPGZgQMwVlJC
	rS8B27VmgRYpVnuBbldJYg==
X-Received: by 2002:a05:620a:4556:b0:8cd:d688:7aef with SMTP id af79cd13be357-934a1110c8emr447423285a.19.1785554696920;
        Fri, 31 Jul 2026 20:24:56 -0700 (PDT)
Received: from Cumhall (modemcable120.222-201-24.mc.videotron.ca. [24.201.222.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c199641sm196721285a.22.2026.07.31.20.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 20:24:55 -0700 (PDT)
Date: Fri, 31 Jul 2026 23:24:53 -0400 (EDT)
From: John Kacur <jkacur@gmail.com>
To: David Runge <dave@sleepmap.de>
cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org, 
    Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] tuna v0.21 released
In-Reply-To: <amxtfI7-b5L_5Grd@hmbx>
Message-ID: <668a7fbb-ee05-2109-e2ee-c9455002fbff@gmail.com>
References: <20260728213631.285648-1-jkacur@redhat.com> <amxtfI7-b5L_5Grd@hmbx>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 31 Jul 2026, David Runge wrote:

> On 2026-07-28 17:36:31 (-0400), John Kacur wrote:
> > Tag: v0.20
> 
> Hi John,
> 
> congrats on the new release!
> 
> As tag v0.20 is from nine months ago, I guess you meant v0.21?
> However, this tag does not exist yet. Did you forget to push it?
> 

Yes, I forgot to push it. I did so now. Let me know if it works for you.

John Kacur
