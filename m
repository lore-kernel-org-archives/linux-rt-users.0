Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392D283CB5
	for <linux-rt-users@vger.kernel.org>; Wed, 25 Feb 2026 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011579; cv=pass; b=pYzCoKinPTigR1y602/XdUVIdhBas3QVT2fo9D0nPE5qgppVbMzTcGSbSL1dmgI251aLdQ5NM23HJBYK8eLfHxNmIplsCPIFpi3kr9dezm0KJLHuvnIDJld1nQKrpAtyGCtn6WTnjZti1lGc/1wcnKitXot8/51f2nVKfElufqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011579; c=relaxed/simple;
	bh=euBnIBhVkCd/7HEJm9Aj8rDbsv8FTh2QfTh86QRx7+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTHeSM3vYJ9cqVYtYFCRlnXIcgF69gHaxqk6o+3CCM5LUYCUlZc6r8+MttvYr6ElpkOGuSPyVDtVSkkxnYiUhANWRbgRi7iUAezthSB9xWzPgnV57vqKN5EIRAPLeXBpiBjnNk7C1Q0oYBwGarNI+x4mfxzqnoUvYY7gAlQUHqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPrb7WLI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbknZNvA; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPrb7WLI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbknZNvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772011577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSLnM3SColY2ZdcIEIbe5YBZKcP/mqr033CeBIXaTPk=;
	b=IPrb7WLIAB30gpAIlynWvZV8JPb5I4VAFAK3QsXpGZ35c3qf9LthFJf2aTphYayYkt/rW2
	+WNsfqTtzsfBb0z57u5Id3ruH/U9jCzO+0IyhfzDxUTiUiiy1v8LPNWSvDKBUM1D8nd2t1
	Fyr6kAKh6JoTQHseOfxaBibnhA8zGHw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-yt44MymiNDOUPrdN2Ux2iw-1; Wed, 25 Feb 2026 04:26:15 -0500
X-MC-Unique: yt44MymiNDOUPrdN2Ux2iw-1
X-Mimecast-MFC-AGG-ID: yt44MymiNDOUPrdN2Ux2iw_1772011574
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8839f45c3aso209083866b.1
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Feb 2026 01:26:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772011574; cv=none;
        d=google.com; s=arc-20240605;
        b=H/zi0D9iBfTDbThmgDKbWrddJuK9hxx+ODyplp5UWf+gmz/gMCFTuzZS1nh4AfFG9v
         oIR2MMquQV1VEbWnSMHIkdZSLII4ICltKDt89Ej7kMxQLDPT39B37O5Aqbu2cgUHCoHy
         LajooDtglBhjDwCp8+iZq3JOOS1R8TqVQDrHNm0IMOrvCwEyh4jUO5uWtaJWuAn77ax7
         hkRilbBWWUi/37dUq49BXLx7VSgzMfC8mJ7UWBlYj+hcp8oZrMtKoHLyh6q2cXe/MB/S
         iUTp/BoYJ7+6m5HYgVpyhcRfgC1knd5DnH3JrK829jWXIrszmIH47E2Ih812jRgGGE+5
         0QJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aSLnM3SColY2ZdcIEIbe5YBZKcP/mqr033CeBIXaTPk=;
        fh=2y0w1ffR6oRwpg+3eORpABoPywPV5STxl5upjAx4RD8=;
        b=iNcQcJ4vGXfbq50hIRr3NPQY6zxicdKOU4ThRRNhc5uzP4tOHNjHD4X+T4Sc0qm/an
         lcQojcny6BVWsysC4l7COe3nIOChTJHYPF0X43iYB5Ptz/Bk7l3O8wv32TmeCZhCXPcS
         Cpwr+2hInUxF7Clp80PQwriksHPM41Zhi9AebHF6IsXizm8VFaTL6iU1jamC676ZumZh
         IxVMJEcVb01e9PebrDRMKYZaJeWcvynOGwhZBGup6/MFXk/URDyF1gm8sfSma/UXEjVj
         5owIcXXHIEBq1tUIqfNgwKdQBP0h+u6P6ovvUqCxb6HvexRCw1uRADInIZcsRHeWo5fS
         42rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772011574; x=1772616374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSLnM3SColY2ZdcIEIbe5YBZKcP/mqr033CeBIXaTPk=;
        b=ZbknZNvAyOpuiC963QgYrd0BOSUQx26LSapVLSBOoI6DtCeArLg6fgg2Fg6x3hP3V9
         qcXE3rROHEVRNuGmfN1dfODz4mCzR8VEBKsNQ6okVAR60oTvFCP2IfwB1XPVCwlOuW1k
         rS9fX1mM2+wMi3tIixnr+hrRlIaBlEMyeYmDXWGvUW7pPr+ITHIWTc59YMgDl31uyBZN
         EAesFCozGp0VJ5IdwtW8EygfGrLhXnbavDrsREBinAtN9TUgubvonzIquoC4WoxcreHB
         DC/y2MLwdeZ6xvRJeKcF9zXD4nciAnkme8WaOlx1YKEDbp6LB69mwRSzIN8K7GBVGeLm
         /+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011574; x=1772616374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aSLnM3SColY2ZdcIEIbe5YBZKcP/mqr033CeBIXaTPk=;
        b=brBzVZ7wXmNaj7NuR701qTnav5Jc1I1eeOps5hLXiFLs32Al4ROcGUenDkrUENj2FV
         5Hd+RZJbQcjViVM4XGNBYBjZjlwFFDWP+ZqrY4PpSg+8osuVnRvB1zI3G8M5W2E7CV4g
         LSsU6xZ5BnIMbYJvF2sPL41xwj5Wgyzod6pbReeuuGJ+NHeBH1bjCV8Q/0Cmo7v1Ebcx
         n1LSHNUvj2JQZ848tOdNrwGIiyObdPeFC7PX8a7R5MUrvbxNb9+4MoMcTERA/C23xYhf
         mC+TsPI5OVOOwH5x0mNS+h7ls8twOkoWNEJTdl82KwxnwvhytzrlT8n1zVf8ZRMnX4vu
         kXlQ==
X-Gm-Message-State: AOJu0YzqWzD4tMNEvrX6TrnzgfsJ0mfbHr8A0euIItLiQHoA/2Q1/Lrr
	49f3/uKRRlCBycjV8drf4GTFneoNSf9ZDCBCtS//OJ4+iF9rS/aJwnCfSzaZkKred4OUxK8x31g
	bt9uJ3xo6aXj0OMWO1wIAnj4/RHbw+D5upW8ygoGh9AZdHR+Ya1NIsY76rWF0Ul9kozWM5et/Gn
	xlbcLcL1pYvWQa8oa9DlqpxxihS30cGlFp3AGXmGlcgYj/ZR0PFVQ0gA==
X-Gm-Gg: ATEYQzwrRxF0GOTiFpbzIDdeE+uYcRKbvbLNouzju+OGBEbMR66y+iJPK+ZL6j7tmFU
	1XjTRxP39sUHmTXS/Nn6NuHhflYPIIsmdTCwCccKsAZlBy2deBdva0qJHA5UDC3R8zsvwm3Hd1A
	OjXMv9Y/boW8KINaUGkfPlHTRfvuambiGojmFjm8SSwXxfHGpY6YkJ44rD+SwP0+qd+Zy+HXHLV
	XdjetT1mRKrD/bCA4vGjdg7t3jUP8pVrXMm6Y8=
X-Received: by 2002:a17:907:6e93:b0:b88:448c:be01 with SMTP id a640c23a62f3a-b93419031cfmr110070466b.18.1772011574054;
        Wed, 25 Feb 2026 01:26:14 -0800 (PST)
X-Received: by 2002:a17:907:6e93:b0:b88:448c:be01 with SMTP id
 a640c23a62f3a-b93419031cfmr110068666b.18.1772011573516; Wed, 25 Feb 2026
 01:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220182428.75379-2-costa.shul@redhat.com> <fb8a7568-21cf-aaf2-083b-d04b4bedb4af@gmail.com>
In-Reply-To: <fb8a7568-21cf-aaf2-083b-d04b4bedb4af@gmail.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Wed, 25 Feb 2026 11:25:37 +0200
X-Gm-Features: AaiRm50CKnHmd1RJUSd6kWp7Zj5vyDJzrTPVxG62mxJStYmD08E5K3kiCHLu_tQ
Message-ID: <CADDUTFwSPOkZvZKwovF1HB=cWPTZ9jh1_e8EKD=98uG+VesQmg@mail.gmail.com>
Subject: Re: [PATCH v3] rt-tests: hwlatdetect: Add MTBF calculation
To: John Kacur <jkacur@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, John Kacur <jkacur@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Feb 2026 at 01:45, John Kacur <jkacur@gmail.com> wrote:
> With newer kernels you can get multiple latency events ie, the count  per
> timestamp but you don't know when they occurred. (the timestamp measures =
the occurence
> of the first event)
> Does it therefore make more sense to measure the mean time between sample=
s
> (distinct timestamp entries)
>
> Does the following make more sense?
>
> if detect.samples > 1:
>     info(f"MTBF: {(float(detect.last) - float(detect.first)) / (len(detec=
t.samples) - 1):.3f} seconds")

I disagree. Naturally, a longer sampling width increases the error.
While using the total number of samples instead of the number of
failures might appear more deterministic (since it avoids the
resolution error inherent in width length), it fails to estimate MTBF.
Such a metric becomes proportional to the duration of the sampling
width (by several failures per sample width), whereas a true MTBF
should remain independent of it.

Your question has led me to consider how non-sampling periods
contribute to the error margin. The adjusted MTBF should therefore be
compensated by multiplying it by the ratio of window to width. I=E2=80=99ll
send an updated patch that includes this compensation factor.

Thanks
Costa

