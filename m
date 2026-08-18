Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB29F35E1A8
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2026 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051217; cv=pass; b=lPDH9a36p5PAq5tpgCuiewXHf1K8Nits3spLJPj7Gqlx3Meme1Eo/oRIkPWQ8MaLX4IVZA2Cw1vSpOqDrE1oQqOF4FZcI16tRzdNMpXnplHPDdexLTktzbe/rhuyOCmywiPQid/MCa/1oieXZGXO2sg9vg66CS24NVRTGX95PRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051217; c=relaxed/simple;
	bh=i8SpZhNKYDWFl4ckhZsf1fmaxUXEyd+K7fdnTNP/i1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFLMJxEWDmZ42Yr9ddHhkFJnMZf34tWzShDVHEKJHxD39Ws6Dfeiuz0gsqP911Q+tkdAVP70WgnuD2aXoY9wZZMgyCTKzr83M948xHgo7aKYxbwSX4fI/i54yy8XM3Q6Gxz8dSQ5MxMilXnm5yRJEBzAAoHIaxSZo9lBW07CsMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKSVMe5f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=be27ZeyA; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKSVMe5f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="be27ZeyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nrydW3hbQimtgnfSi62v2+0v5MdguMEcbSdbT4F7zW0=;
	b=jKSVMe5fiCiO9gET+P8BKsAJJkkgAEettozAtU165tEfh5jJm+CgkgU18G0f5AMD/e7bMt
	E6VMlo6/+XE+qqJMJdO2eM0vNEVvMNfpw4g1Q7eQQ0BVrpsGV+s/exvsbke1Yn5I2/UGyR
	hyBQnfkbrIKAtIoTrBg53epZ5UFMspk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-9Bq7bnyVM4WFeIWrUhl_0g-1; Tue, 18 Aug 2026 07:06:48 -0400
X-MC-Unique: 9Bq7bnyVM4WFeIWrUhl_0g-1
X-Mimecast-MFC-AGG-ID: 9Bq7bnyVM4WFeIWrUhl_0g_1787051207
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1670dd0f5dso344750366b.2
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2026 04:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787051207; cv=none;
        d=google.com; s=arc-20260327;
        b=n4f1vlgZFlBcPzFrpp5lUe8B+Yzj/WiV3hznJbBkd1U8bgFEvW+fZ+RwvWCW9dgFTl
         lBy0keuWepSZchEyDX9C6ewIf4gaY+Q+fOiJrxItwVKgKtkC7UiXY6su+1e1+pkVr/wy
         yvJsgUGXLVJ047niPfEMkccb0lYiCcsZPe6cUhMAkVrO2b4nUpP8K707XM1jMNOsV55r
         3OXyPCjaJfjvTWXLL87TPoRCaFH3jEAe5afQYwcAzKEAt2hNubQxqUeitZo65PmNWLCs
         fh0y3zammCWWYZuHhNwugrUojWFTo7AsQqqjh8BHA9FvO/sIPehlC8PT0OIKwMVbMBAH
         PVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nrydW3hbQimtgnfSi62v2+0v5MdguMEcbSdbT4F7zW0=;
        fh=F7GOMNGVAcRW0bjZjN88Sb+4ji5CpLDw+zhaU1ywlsg=;
        b=FDpzQVVCtxgbOLCK9KXfLj5MiAxPdHlI5zfVoP6bH8fZTVFCDI139TGyYsDZvJyLru
         q6nc1bKNWOqiYfUPXBh8hAmbM4zDxh840dnpehHv+oMWab7K+e7norQmpK2p1v+46ZZ1
         uhczIEv1ChtcGsXw13v9R7PGatDHzmpLlus6ZbyT5vIQZ4ICSoIAd60KPlW7PlS+uHBP
         cQeKdlx7jmizr7bvXdZHixGUQUaSEGzv1PckI5CyAVVRwz10LNHxKGJb24Qf49cWyD0b
         9wzcalieBWFf8sGPcTJFsz+28FZdjAlcQPhpQKzwVnw/bNE8+Siw2kbBqMJ2/dYc036W
         UQJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051207; x=1787656007; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrydW3hbQimtgnfSi62v2+0v5MdguMEcbSdbT4F7zW0=;
        b=be27ZeyADskbPXPtvRs95wgGNc+xi9KuPpwXX8602dW/wt5aIJAIukm4G/nAx0PcSE
         WVbwoPqoG6ThagPLFLmpocbzZ9QpQEXBRWYHG5VtcaR7NjQkB3Fgks6+JP13dG7WKK1e
         h1AGBJ1mCt3+3GTNZXbSXRRi+n48yTNvserzqb2tCku0BYwPmZXjYbLaH0vqOIzIugYD
         KYVEViLMlSiU61rWO4j3TxNLK6s2Wividq0LbEhXlj2MHPbErmKIWcWmoQ8zA977gxmK
         /YYdvZyDrzblVrGSa7Pw4O9B/YejW8ZZxZfn6oZzyt3Lvab9P4b0q4qTdtClb/9DcINs
         gYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051207; x=1787656007;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nrydW3hbQimtgnfSi62v2+0v5MdguMEcbSdbT4F7zW0=;
        b=ivcyQqgG+rDmKekWuFGWqrOt/O7H/y2uvXyAGkaxWSs4K4VtEfZLGppbjq1SlhPuCM
         lM7fpulf6+ivXgiWRP3tIedpx93ybEjcAydablPBBc/A094l5GyEWxgf1v7zP0F8/zw5
         HikHnXSmIzzObd7kl87MmFmEshBhtHICMOQhzTR2XqXXztqSGskxIowSgu+dp42zr+xo
         Uk9b5UV62hYQc/ChW6zHfYb7O6oE8NZSU026C0sRnKVWJ7jBpRhTcpT8MB5Obklqwg3J
         dCSWUaY6x0V/f71uEhJBPv+sTvfkzwyf34RmwaTB4yHLANyMvlK2s2xeoSGtnT6VuRjF
         WqQQ==
X-Forwarded-Encrypted: i=1; AHgh+RocvurLVLFrI4RtqU1UgY5aaGsdoQDKOHJ0VieqNW2Dent0+GweAeIlU7rfOyu5V55BF643T0mQtG/Yn2BitQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMNAM/RZZB6OTeXnTA0FmLpYz+6NfpLQaPW6RKjS6Q68iKhw8
	QFvesHmf39PntNM0P2N3Omh5gRy4ZNuY84lHw6io2fIp7Y7z2BjeyNrxKqopNV0fgQP3DfUoWrQ
	FELC1G1bWn9j8u1tV1dWJGxy6UAfYEKdpOY+xVbk6wkOk4/xhdG+9pDU73wZN+3dxO4K1wkfJDm
	8LZjA3Jz3UnIVsW1ixH5qqWcsaTRvqpSCn343jl8IfkQzyztjL6qCtPw==
X-Gm-Gg: AR+sD1000Zar4remGq9x/6Evp4spqUg6OtzBBXxPFvNi9FzE3IxbNpBBkb7TL+/Lo4X
	854rldIvUWSzjASR0fFRlWtolZC4ipf6N+RqeACxrMvRSqg8kh7czGWXH8vyXCqyLrjNpDkTIY+
	SvtxLHOlHGx2sj+Ah6LG/B3eK0HO68w8yGVQpqAyFxoxsCH53ro7+WV9ELMu66THJyEKpMwoDI1
	UcT4m/wXzr90eJ/Kg==
X-Received: by 2002:a17:907:1c94:b0:c20:d90b:2cb1 with SMTP id a640c23a62f3a-c212920a2bamr1702722766b.0.1787051207254;
        Tue, 18 Aug 2026 04:06:47 -0700 (PDT)
X-Received: by 2002:a17:907:1c94:b0:c20:d90b:2cb1 with SMTP id
 a640c23a62f3a-c212920a2bamr1702716766b.0.1787051206810; Tue, 18 Aug 2026
 04:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806120732.1371118-1-costa.shul@redhat.com> <20260814090801.lZ8dlRaB@linutronix.de>
In-Reply-To: <20260814090801.lZ8dlRaB@linutronix.de>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 18 Aug 2026 14:06:10 +0300
X-Gm-Features: AcwNN1V2EKykaOlawIxU0UWrUiERCIUeNRj6JhEU2pmEc6r53oWPN7ritoeymYw
Message-ID: <CADDUTFz8mfM1upYo9qPbUpNvZ0LOrTZx2f0sG1Unz1=qwQb7rA@mail.gmail.com>
Subject: Re: [PATCH v2] cyclictest, cyclicdeadline: Exit with failure when
 breaktrace threshold is exceeded
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Kacur <jkacur@redhat.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>, 
	Lukas Beckmann <lbckmnn@mailbox.org>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Aug 2026 at 12:08, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Why not pick a dedicated exit code value for this scenario and document
> it as such and use it for this purpose only.

In standalone RTLA we use:
1    Error: invalid argument
2    Failed: the test hit the stop tracing condition

However, returning 2 here would be inconsistent with oslat from this
project, which returns 1 on test failure via err_quit.
What do you suggest?

Thanks,
Costa

