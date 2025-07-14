Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0EF57C9F
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Jul 2025 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509717; cv=none; b=sQUwlR61IsD3b+a/gxS877bkAKI7o7WlpqhIO45DP5qSap82bZgfsyMDnMNAQInygvuYMPCx7tAPEqe8z3zmm3Xwe3wyoZQWhvMZClDeum7Q6MEaYEp8dJgh1RSSYl9LDLsmsy6jnhjN1MfXm2+52agI8TlDExAq7OVV0zCea/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509717; c=relaxed/simple;
	bh=Cyr5lciz64kOSh8D9hGSE9gY0AQUul4P8HPMITlPfCo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=owsnO2w/a83fTGKPTpPCu1LXI6hIC3JNn/cbX42qwz7wrkTEW4htgOKhBpndEmmNs6vaH7Lx343Meufbs0L3ZD14ZXqdX7wvtpOC3earKImfVmGx8vLFZEISUiyMIHp3jxnjNvQylbZPRDbVU7/j7H0Hr5iy0zJK6JlhuG6+PxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGg2KPu0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGg2KPu0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752509714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tuvjOB5ZANfwdF0+OsjVx19SKM8M89zp+hXxnkVC3vo=;
	b=FGg2KPu0tX4AUDD6vg/l7kqxUxXW1NSTa6K+W8jJWCQMtbui08CmMBrk3lrOtxvl95SigX
	y+opk/YC+FmBWj1NYu/st2+3gqKWvKNgomYn99sJnSNG8uk5jrJdKTYHetw+mjGBT/HFDS
	jAOJMkNwoe2rFLnmZxdHfLC4qaPvFy4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-ecyx2WSiOAy0tWn4jvEJaQ-1; Mon, 14 Jul 2025 12:15:11 -0400
X-MC-Unique: ecyx2WSiOAy0tWn4jvEJaQ-1
X-Mimecast-MFC-AGG-ID: ecyx2WSiOAy0tWn4jvEJaQ_1752509711
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fe182a48acso103918976d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Jul 2025 09:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509711; x=1753114511;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuvjOB5ZANfwdF0+OsjVx19SKM8M89zp+hXxnkVC3vo=;
        b=wsE6Q6TTwLpBZtWELOPRKHetTg97qvqWSkEALL3syPW3Yk8AzvdjKEUeVC0QzKrkc3
         UnEPz32iFRlsNzIN8kzKxyoLtMQI7zfneDHn1ieUqWpLs6aDkIcgQidV457iy1cW7JQp
         pKcRthTc9pLW7ZcNfxRrJVStab+CnBZs/KrkbbKHIvcRwisY3+wgQ02qGyEmtXBfQyw1
         PY7HfcrmP+Ol6QD0fZ3DozcLFCDX1uTqXD4pymyL5ETlH0wmXV2Ii2ewFqE8u+JK9/uf
         iAuAI1QD3qxNLXySh6WfpKKxKUmM3Mxd2nMeWdiEt8bXgq173+tSuMUhHPzrf/n770QD
         Z8sg==
X-Forwarded-Encrypted: i=1; AJvYcCX9X7vn+Dmq2VTgWADgpCnzsXCMasbUcCB4aN4E5YVS2SiVH2w2o4DVkAJeDQJZYJqsAYloZDdV9XUMSQ6Gmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpxsHOYm5FNoK7cOmIzMc62xG0kZCHKLqeBysETOmHWJamKTh
	DSERgf0mfPot7t175rynHfDU1MBzFAal9GHF/LU0sOvng/natlHeBZvgj4n8fZ898o0Rb8FTLwR
	IFchUghhDv/QLfOcgoIs5ptxlFRzOgQwe5M4Zlt3BzoFy9a8iljcm1zKDCopE4fnB1esx
X-Gm-Gg: ASbGnctwfGVahiNKEpo4GvhvolT6fE5YMijo7IodYPeNMLKrYmgSgQf5VNfbeoB4DLa
	j2UtI6LP4xd5PHwQDMoGxEDe2VySMFXTRGmGhMwlL9gajgV8fFJ2TVACBHyf7fZL0npyVvoyDRt
	gNmciIG4LMUOuKfNdzXYJuzP20/n11qCmJr9DFqJxKq68/as25fv18S/P6lAp9TjZOCmgy4U66C
	aoFFypb08UeP8be8l+S15AS6sLW0BNw4GyVTCL+1Bt1vxtDCdlfU/qppbZZFFmtOXBLTT9eSCXJ
	J4ZEnbn9kC8PeCOCL/Pv+UiizW+53Q==
X-Received: by 2002:a05:6214:2c0a:b0:704:8870:122 with SMTP id 6a1803df08f44-704e1d8c546mr2290286d6.11.1752509710828;
        Mon, 14 Jul 2025 09:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5/ZGGMkCWW1o2irBd3cdq3BjRE5E2o829dkvpH9HetSk3+K7UgmNvrtAoDWQZaq7xGoF4ZA==
X-Received: by 2002:a05:6214:2c0a:b0:704:8870:122 with SMTP id 6a1803df08f44-704e1d8c546mr2289786d6.11.1752509710404;
        Mon, 14 Jul 2025 09:15:10 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39d2asm48457096d6.77.2025.07.14.09.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:15:09 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:15:07 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: "Ahmed S. Darwish" <darwi@linutronix.de>, 
    Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 00/28] rt-tests: Rework cyclictest manpage
In-Reply-To: <20250714130104.29nUrEeQ@linutronix.de>
Message-ID: <da95e7b6-a1f0-c2b5-0b9d-3c2a5878c96b@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250714130104.29nUrEeQ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 14 Jul 2025, Sebastian Andrzej Siewior wrote:

> On 2025-07-04 15:26:53 [+0200], Ahmed S. Darwish wrote:
> > Hi,
> Hi,
> 
> > This series provides much needed bugfixes, cleanups, and updates to the
> > cyclictest(1) manpage.
> 
> I would merge the "remove $X" flag patches. It is a few times the same
> thing.
> Then you have update troff syntax, re-grouping options and then you
> extend a few/ update them.
> 
> Given how difficult it seems to be to write these things I would suggest
> to either switch to asciidoc or pandoc and let one of the tools
> generate the man page and/or html from it.
> 
> perf uses asciidoc while rtla uses rst2man. I don't care which one of
> these is used but after I saw the cleanup I think it is easier for
> maintenance to use one of these simple tools.
> 
> Therefore I would suggest to write a new page for cyclictest based on
> what we have after content wise after #28, let rt-tests generate the
> man-page from it, remove the current man-page.
> 
> John, Ahmed ?

Sure, I'm open to a new way of doing things. I would prefer rst2man
over asciidoc.

We can still accept the patches that Ahmed sent fist, after I review them.

John Kacur

