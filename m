Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902E2EC542
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Nov 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261063; cv=none; b=O6ODZtFa5MLmr395IKv0nKS3f4sUK8rEOnVWToZhMDw/zKlrY8iya8ZLp7p7RI9uB0C/sQMZduopPJv3jwLL7RpNe+l1XbIE0nMm2PTzqhDISAC3c2TDqJ2gGWKgyNtcqrzpPyNf1nrJ9PHZNGXELnT56woJl/9GcxfktpeZWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261063; c=relaxed/simple;
	bh=U2zh8wBTSkr73H3kLcgWPYBL2C6gEuf36qbKHVMFrao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng2BI37xwqeDdBkLxJ+NFlvxyxXkDfOaOwhrox2LcgHeIA0N9IIhkaDITWMg38ARdT9swP4dSbV9uXTKB7/WZhLtFnQxYHH0o//KEX0NEmuGMh+PEOW/amPcm80Mr8GEWwIj4875QJMOvpWfI9nrHDcxUa6/kEC6uzWayVjlS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiP8MMBV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7Mbx9pq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiP8MMBV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7Mbx9pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762261060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZynXAoarmi1t9GOZJ06w3Mck3UXKkNbjAu+M7NDmUU=;
	b=MiP8MMBV3y9uquSdNBmtriEuWJqrz2esluZnbXqxz2oYc04zTzz8I4HWsipJKdGGpOke+K
	z4PHrwNBUaVkAgEIk7pQNJK1F5+cPHP8hi18EPHUd6sqomOfUV4yhSJROZPiECwMM/DOdD
	x95ipgN4iUXE4+3GuxtGINADyezRrRc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-n572SuLRNBysLo2eSOSJMQ-1; Tue, 04 Nov 2025 07:57:39 -0500
X-MC-Unique: n572SuLRNBysLo2eSOSJMQ-1
X-Mimecast-MFC-AGG-ID: n572SuLRNBysLo2eSOSJMQ_1762261058
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-592f6f0a15eso3373553e87.2
        for <linux-rt-users@vger.kernel.org>; Tue, 04 Nov 2025 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762261057; x=1762865857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZynXAoarmi1t9GOZJ06w3Mck3UXKkNbjAu+M7NDmUU=;
        b=K7Mbx9pqSMWBV9oFWtCCnsLS7f3m5WnaT/bdN3gFsz0YduEzUc3Gk03A5BiFhLmies
         F0hwkbAWehI+vfX2LwgqNyQRqwv+egDNlEEQHw5VUjrSJdG1wsBYGOmt2vPx0HmfW4OF
         sSBmzuFSZdePcL4x3TWPQmEUvptAQHVN0vlZUhR4wFzpL6Zrb9icOf62Q/IqqVGgUjZL
         5n6FcQf63tZ6kpqxvL5/qS7h03h50xa8mXXG+kG2bLt0iy0DYw4KHLsTQXV1tIQbAVg9
         /so29OhtFvjjUIj4MAavO7VVLzevdIZFkAkiy8tb6pDH8vV+xzvE28FgE6mLjw6gjRIx
         craA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762261057; x=1762865857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZynXAoarmi1t9GOZJ06w3Mck3UXKkNbjAu+M7NDmUU=;
        b=bndLo7ZgO/EcLqGDSYhJ3tEgdLC1LSAMxu/DAioFMoBbkXlJhcGSP7cB/K21cHRMeo
         YxTjKKVWmSKlDVyrKMmOrU3Gnh/7r0WCgFGbDdnMa/L7AYn4uKtYZtftl9V7VQEfBnwL
         ruiKg999mU3GY1q/Nbsg2JUEpBLdns/jkL/g21ztH75jvw/7NFRLxMifdDWlU0linBms
         km44HCiviMtZ9kkRt/0K+1m72kh8Yr+mOHuA5mK0FWFn9vZUegMeM5hMuUgTmmOYqiHB
         ZR94mO9SOdbCY253Tzv7065fbm1U8ByhSW0lzWTBl/xI704TnmI0lr44w+JF1QWi2W01
         mK1A==
X-Forwarded-Encrypted: i=1; AJvYcCVJvcF6xzl9QzQl+sXpnmkaUkkuCgDYdD/iXU2xhCGq/x8zkFCr5vTiHv4wJJrBc1AVKmmpjMnk2Ginvkm0xg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwRxRkFlEYeIs8GuLFno3GPceIRgOIdVA2WlcoKRXD2tI69s7
	pLUgw804swtB78Hu6MXkzVeuFRo66eY3tW6GvqM9wm7pE4s2dnnqME9wmtTtFGX2ZYgeUHXJm4K
	jectJfcbfIw3j6RAM1t4B/HG6VfeTmhw7Rt3JLKY2Np7H2cu1yGWXC03PRk7SgaBV56GhkY9pg7
	zPdVAnxpMdY0vXRuyi/DPoWNeHmwGa6sLN5FVNPs6xATcjDpzdVV/5hQ==
X-Gm-Gg: ASbGncv1T2muRtRFx4XP2Ld9qsQmCK5MSLgr5VB+teP/OH3qATo6Gyen8uDkWSbtxux
	MYDs3vwTD+e4DbvlQbt2/oQnSHizp8Ky8SQ6A9e3kN59+MDWZI1QqW8MOyALaO3i5z0bee/VZgh
	x2g0wXCHyjRzDioKmxobnBn+Hxf2mbEUBigbWKPwspuA3BXbYhlxB4eg==
X-Received: by 2002:ac2:4e09:0:b0:594:31f4:d657 with SMTP id 2adb3069b0e04-59431f4dde1mr1797988e87.51.1762261057154;
        Tue, 04 Nov 2025 04:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhH7wzuagLxju5LrPuVgdWOtG/INwIPjOSn3dUDEe4h19//0zsLHG3a3L34RP/0dhH1G6+QEHWcSgiEe8g6Kw=
X-Received: by 2002:ac2:4e09:0:b0:594:31f4:d657 with SMTP id
 2adb3069b0e04-59431f4dde1mr1797974e87.51.1762261056692; Tue, 04 Nov 2025
 04:57:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725090201.32656-1-tglozar@redhat.com> <6f2a6564-ecf0-e77e-2ccf-5250eddab97f@redhat.com>
In-Reply-To: <6f2a6564-ecf0-e77e-2ccf-5250eddab97f@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 4 Nov 2025 13:57:08 +0100
X-Gm-Features: AWmQ_bm94N_2JDeFb6KZbtPOcaHU0QQ2GCx-pL2CrtykmRFWFQjv50F8siAfyNk
Message-ID: <CAP4=nvRd+CGkNO2K_KMfzWqf5vtezPurCt_nnk62p4WxWQBywA@mail.gmail.com>
Subject: Re: [PATCH] rteval: Introduce E2E tests with output checking
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, Linux RT Users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 18. 9. 2025 v 19:56 odes=C3=ADlatel John Kacur <jkacur@redhat.com> =
napsal:
> I got this after running make check (skipping some of the output before t=
hat)
>
> # Output match failed: "Command: rtla timerlat hist -p1100 -P f:95 -u
> -c[0-9|-]+ -E3500 --no-summary -T1 -t=3Dtrace.txt"
> e2e-tests/measurement.t .. Failed 6/19 subtests
>
> Test Summary Report
> -------------------
> e2e-tests/loads.t      (Wstat: 0 Tests: 8 Failed: 1)
>   Failed test:  5
> e2e-tests/measurement.t (Wstat: 0 Tests: 19 Failed: 6)
>   Failed tests:  13-14, 16-19
> Files=3D3, Tests=3D33, 308 wallclock secs ( 0.06 usr  0.00 sys + 146.20 c=
usr
> 281.79 csys =3D 428.05 CPU)
> Result: FAIL
> make: *** [Makefile:22: check] Error 1
>
> How do I identify which test is test number 5?
> Am I failing tests because of performance reasons or because the tests
> expect an environment different from mine?
>

It is failing because it is expecting the timerlat interval of 1100us,
see the "Output match failed" part. The interval changed in the
meanwhile to 100us, the patch simply needs updating.

I'm working on a v2 fixing this and incorporating feedback. It will
also enable verbose messages, so that all test names are printed, just
like [1] does for RTLA.

[1] https://lore.kernel.org/linux-trace-kernel/20251027153401.1039217-6-tgl=
ozar@redhat.com/

Tomas

