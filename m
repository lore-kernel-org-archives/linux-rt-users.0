Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F3436A6
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Apr 2024 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184541; cv=none; b=o7ruRZkiEmYmm6T67bKZSZp3Z0wdcg1EUi7SIwu5RnAI7Cl7U8XlnWKNUK75kir5coiX48Z/3r//e7f5vpi7IqS3r6GGJitVCPw65Zqjv4UswxMngavlKgYCd6ENyjL+mhKnP0AOx1cR/phiY31gVtS4n2V0hrpAkSxwoOHWf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184541; c=relaxed/simple;
	bh=x/KPjovEA/yFJrg8jHFyhdNqIvozS9PyYfSqcYTlzrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcKsC1e23eYropvRoDVyTE6vVUYgtMuyhvNPB9+ilZXVZ8v6hdnHlmYGvIR+cSO+8n+Jyeo02vo80La6Zo7+ujJTNIL4ApaMY+nwbR3/u0d0ny0Y860w4VE9cgJ1q7Gdg+AKTaHnXWvgEIQsRCRs6Yod7Ix2VssY7vvIgeBtucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UO73SpD7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UO73SpD7"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so13356a12.1
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Apr 2024 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713184539; x=1713789339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+m99dMu6nu74LL7/6GwhDV83h2jmoItj/TqWmxDl74=;
        b=UO73SpD7YDto9Vp6vM3kDZVTM+5rLOVOooKGcZ3TcGWaXtVZk6LQL+niZ3qtts1XHn
         3Ul7rm0x8M0Yi/XCy44L7VWqUGpwZZWwXRPoKMwhEJo9Q+kuxHIpfe7owUU8PLNklqNx
         Nd9F6fP2E43FTb32OmkZD2U/GdvDNYdrrnu2s7AZPhAuovniDkm09L3lHtl3hbcK/jIK
         jymlEl69ZqWzJw/10uUx5M1xELHg0KNPHykyR5geSTEgIdgU/WkCsD6lCSJ50FQS/fGV
         oI4M/iwvsAIpDKVZ1SBLiuBZc6p91vRjMLgEtHb9vsgOz2KFU5Q0Lg2hSr2ovjig3cg5
         qisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713184539; x=1713789339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+m99dMu6nu74LL7/6GwhDV83h2jmoItj/TqWmxDl74=;
        b=r+saT/forjBTraGwP52EYCMLHAd87YyXu7TDR0CyGqs+V3lbf4gB2WHydU5/LpmoQ1
         t53LiKEP2rLT5dEB8yDdA4IWb9AIpYnQwYN1u6hNR1geDjLwjCxuPl8Ri8j3WdjmmckQ
         h/Rxcf1gQEZ3zPr2GzXXEUWrjszGkTkfqis1Hq+96DIMSg3nkTuVsFpDOsbDoHdZDc6L
         tJBgCYq3jceLpXARgfjzpkhy1biHE8kbLr7iQ9+W/DxvQF7Mm3K+1B6HhE4rWpYBAtTF
         cqv2GcEB+taNVIPfH8ID4iMyeHnLq1+S2RjgkSKAzEcp6ijl095FfWvwNqkdcYaxQpSp
         lEkg==
X-Forwarded-Encrypted: i=1; AJvYcCV3nF0vPLVKum+fDoyZyUha+4AOvN4YPvaJLSTIBO+Y2p/vhCGgtnG465by5UH1rfvn1y72CzLqm2G7GYrnbEWidoZlGnYaX/+UjPywJQY=
X-Gm-Message-State: AOJu0YwtqVBfhyZO2qvGFQIbNv+BwjTltKsnWgjuSlAsfJNkDsO1G/La
	UvUaItvi7G2HjGY7i6VDOiGewe1H/b4Tquo+/obhfeY4L1uBpMHGLh0dOfI90rHxAxdA4IlEThz
	5dv8sna34BgE1a52Rtq9HBuoMvaUNYkcwJEfv
X-Google-Smtp-Source: AGHT+IE6S+TSxd4EsWXWZTzuCgnCVcAcnlwRSRLZS14INH+865qtauJF0v2rUCxEdSvXouYC0WJtvlbdfgOCf1eBCrY=
X-Received: by 2002:a05:6402:5253:b0:570:2ec6:56b5 with SMTP id
 t19-20020a056402525300b005702ec656b5mr100509edd.4.1713184538481; Mon, 15 Apr
 2024 05:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415113436.3261042-1-vschneid@redhat.com>
In-Reply-To: <20240415113436.3261042-1-vschneid@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Apr 2024 14:35:24 +0200
Message-ID: <CANn89iJYX8e_3Or9a5Q55NuQ8ZAHfYL+p_SpM0yz91sdj4HqtQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] tcp/dcpp: Un-pin tw_timer
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mleitner@redhat.com, 
	David Ahern <dsahern@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 1:34=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> Hi,
>
> This is v5 of the series where the tw_timer is un-pinned to get rid of
> interferences in isolated CPUs setups.
>
> The first patch is a new one stemming from Jakub's bug reported. It's the=
re
> mainly to make the reviewing a bit easier, but as it changes behaviour it=
 should
> be squashed with the second one.
>
> Revisions
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> v4 -> v5
> ++++++++
>
> o Rebased against latest Linus' tree
> o Converted tw_timer into a delayed work following Jakub's bug report on =
v4
>   http://lore.kernel.org/r/20240411100536.224fa1e7@kernel.org

What was the issue again ?

Please explain precisely why it was fundamentally tied to the use of
timers (and this was not possible to fix the issue without
adding work queues and more dependencies to TCP stack)
