Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940171527AC
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Dec 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498953; cv=none; b=ANrhZK4dr7AsO7c0yMpR0O0QmBpPfsP+spl88UatkkY4xm/vy3Tl7PRGvqQUcz1qMv1RrABEZsKAzopWBwse4ZNCkxBfOmNIbSuAhRWn1ApriwnbEPMmm8or6+VVR/C55XVY/4aw2QTsA794cbQw6Vyfh30mZJeG5c25finMTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498953; c=relaxed/simple;
	bh=CyVJ6oVTxTVMqbfYhLnMTGpczG1PGHBhe54txYtVKmI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kusw8nY3AkiNjHToC5dYcMaJgO3x8uTM20pkg/bOVWqXuUS9HeJY4iz7G2zMy7RCGTlLhxnET03G2dXKxsTinXiXBgjTAeAi1BS1AmKo37WEnRPcQt0B1qMmrxKf2klApLatMPlLfMhmnHZjsPUJpLony68w2WBqwNM/OIZ23kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExTxuwK+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExTxuwK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733498950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sHLRg5eU6bShp+lyFI1xilniBJjUwSl9Qqtn27KDpOg=;
	b=ExTxuwK+dfG/l7qf+pkDi5EIaV/R81Bn4P2I/cpQ+SMlIebnX31JJYs1ziucNDrdkHt/E2
	/sTFyjqGYJy0l7vxg4NJxZi/d6YD4hxa2zmzlJWpMpdtvSmRg/XVHpRxMvSz098OmprROc
	wkvJinc3VDeDbNeSYq5Ah7hMUHpuqdo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-PFw47ONqOgqdpGCKm_ndOg-1; Fri, 06 Dec 2024 10:29:09 -0500
X-MC-Unique: PFw47ONqOgqdpGCKm_ndOg-1
X-Mimecast-MFC-AGG-ID: PFw47ONqOgqdpGCKm_ndOg
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-466cc21afa6so28950761cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Dec 2024 07:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733498948; x=1734103748;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHLRg5eU6bShp+lyFI1xilniBJjUwSl9Qqtn27KDpOg=;
        b=RcwpOPmNFPAEWjhk2fY4MUUZ4rN7ZADUnylItLKjujaj/3ER9Ex241X4tf5wOtft8v
         K7xkkdJG9d2bxuF/N6GrFRSkintVMpImkPwcJgvc07jrp+BW/gJr+ZSBZxH9X+QsQgqz
         44quDsBlpzSl6DSpi7dvuaKer7ST4z4e3qv+xcncALU59uTzGc1njL1Wq12b9z/6BuQ+
         fETFaU+NXmJUk52Xm4slKhc0kMB9SacC5u48Pfm//9zRO2Nl8XiN91OoU4jo4kqH5+iH
         HfAOa6OZhnmtmUmkFU1vBk/QbYthLa19nURuQopiw5sYmWLPcXIWpw484g2t1haE6HcQ
         lvQg==
X-Forwarded-Encrypted: i=1; AJvYcCXnpBGx/DsPiPK/1WNAhJises8SglwbY/8bq4JQ9Uh7UYjLSoYJCT0FKX4H1lSc24FOE4uV1x4SF8C4fforMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRQEIi8MRD0xxtfdWPdkAptRe8p44IF6mNDVvT3IV2TJEqAjs
	iImltjcZxOVYzJjnbqnK1lnhxQp75vI9fq1pWPX8T6DNRhKNsKBvQV6KcihQOYOVwy5nK6KnSXx
	gmaP17bXKrb7NMk8HjQaFSS+WKq//ZcsFJqupWqFgNTeRCBxAhR0p8iNbZ/dLXrNY2OEQvDeE
X-Gm-Gg: ASbGncvpJTDh5l3XHe4kA6sPQo3gYNfsRx7zqAbfVOsCxNbC19knagWqrs+Z6C7p9nV
	78gpf5TzEsY9BJZ9LXpNeEdbD/KktYnbohxws8iIHYPeR+U9sbsu31PmqiX2tffBasJERTPsbyi
	6AJi4NtIzqRUIGXCvdnO+Mhd97r4dtPp3G8r+LOWF33ZuxDKP+xxx0Jk8oKeyKhgtuym5TJDn6Y
	n/puLbhzsXFlZ7mPh3C0rlNfVv28XnyTcS0wnL3
X-Received: by 2002:ac8:59d5:0:b0:460:8b7d:11ff with SMTP id d75a77b69052e-46734d0885fmr46583941cf.20.1733498948386;
        Fri, 06 Dec 2024 07:29:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfM0CDNgb7umjDKlsh8iIDjfMSlGFLs2v2ih1dQtJpqfOgEDuO2DIoYw0QghgpOPAj+7Pw+w==
X-Received: by 2002:ac8:59d5:0:b0:460:8b7d:11ff with SMTP id d75a77b69052e-46734d0885fmr46583681cf.20.1733498948080;
        Fri, 06 Dec 2024 07:29:08 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467297c9419sm21908501cf.72.2024.12.06.07.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:29:07 -0800 (PST)
Date: Fri, 6 Dec 2024 10:29:06 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, 
    linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state disabling
 via libcpupower
In-Reply-To: <20241206115201.RJsDmOXi@linutronix.de>
Message-ID: <f297686e-69f8-e2cf-5ccd-0f37cb3192ac@redhat.com>
References: <20241113114509.1058593-1-tglozar@redhat.com> <20241113114509.1058593-3-tglozar@redhat.com> <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com> <0da561414289c7b929da1513962756bb8630e32f.camel@redhat.com> <CAP4=nvTZ5nLrP6O7rSU+c269M-=OFTX=3zNSp6TDDxzg2Fq2fg@mail.gmail.com>
 <20241206115201.RJsDmOXi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463748606-752487532-1733498947=:8108"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463748606-752487532-1733498947=:8108
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 6 Dec 2024, Sebastian Andrzej Siewior wrote:

> On 2024-11-27 10:45:49 [+0100], Tomas Glozar wrote:
> > st 27. 11. 2024 v 1:09 odesílatel Crystal Wood <crwood@redhat.com> napsal:
> > >
> > > This could be said about the laptop and power_management checks too...
> > > I'd go with verbose info prints rather than warnings for all three, if
> > > anything.
> > >
> > 
> > I agree. I believe my code is consistent with what we already have.
> > When you do cyclictest --default-system, you also get a warning about
> > not setting cpu_dma_latency, despite it being what you have explicitly
> > requested. My patch just does the same thing for --deepest-idle-state.
> 
> What is the default behaviour and what is the intended behaviour?
> Couldn't we somehow avoid adding yet another option?

The default doesn't change, you don't have to use the new option.
We want to be able to measure whether using some level of power saving 
will still give us acceptible soft realtime behaviour.

John

> 
> > I suggest deferring this to a future patch that would remove the
> > warnings and another one to refactor the code.
> 
> Sebastian
> 
> 
---1463748606-752487532-1733498947=:8108--

