Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F733F8C5
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298472; cv=none; b=dearCbfWJoKCKB5wn8xKxmnVYiIY8sdiLW0MEEOXzfluV6GVQ5Hp61YxdMBNP+cqDGw07yNG85BzM8YAx9u2b5EA9nvQwtUPX+Wr2Tp5JuCHo66qjq6scxZYyvmE8mdbzr8+aiOnefVsXSAjcpJ9vbICYTpYdm5z7A7iKeVHhi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298472; c=relaxed/simple;
	bh=+3S2SBBc9jds0YEA4leRCujVZucIp9pw/pdT5ejiryw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxf3qIcYg91ZnQ8mjhcVyYktI+pPuGH170IGoQNI9Na/Acw4LMyw2cBaL9ZQP3He8KKNmQl4/nWKTgxGTMue7V9DsnvTYKDTRo3sHPCU3+rjHixrfrgl+i2pktRkCLM6P+2pk+QbypcIaCf4QQHPjii/j0QRsp/HhZi2RJh0+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edzjgQE3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXb2e7uh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edzjgQE3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXb2e7uh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768298470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2PrErr91gquyb9mtResO9elKUy7VayA92l6M2sKEy8=;
	b=edzjgQE3XA51IMaQG6Ypo+kP0PFCS8V0XjJnpD3iT6Y+prI0COcHTka2xXAnh3/ZMhEzgN
	IMQgpZPN+YnGTJX4QFPCc7/qA9Je/1D1Ic2Wu0C6tGmSsSCn845+3Z9g+W3yko6x4Q0fhk
	8KCITjqs2kO7asHJdO7mPA+ibsPKkGI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-omICS0R6MYGI-4WhvTf3Lw-1; Tue, 13 Jan 2026 05:01:06 -0500
X-MC-Unique: omICS0R6MYGI-4WhvTf3Lw-1
X-Mimecast-MFC-AGG-ID: omICS0R6MYGI-4WhvTf3Lw_1768298466
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8701175a88so191718066b.1
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Jan 2026 02:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768298465; x=1768903265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N2PrErr91gquyb9mtResO9elKUy7VayA92l6M2sKEy8=;
        b=FXb2e7uhHGJLTTsw3vz2SlxwMPDHT95zXJJh9Sp9Xy0PCo9fmVWzds2hulxUImoENl
         6QeTUM/o6iVL5/c8pk/G3H21YNQ0dWoVBkSIzeE1fp5hwfu4PMcgmh19PZ8kOAhj2mfs
         Nv+sLRU38o6DCT79QiU1I968+tk1N9sybIsaW3VUllUA+75JPUgPlqfrQg52qFxRNZ/Z
         jPjuRpYM3v3ceDaapsr/36qKoh2ua3cVND+17wS+ZrFuEX1WpJf5zftuPE/bgmYHIxF5
         Msn5Ar7tg+CPLfW2WHlsVR/e15BufvordqhnskyM/6Em/D7FcqLqPDSFSQeoxyHh6JXS
         LOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768298465; x=1768903265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2PrErr91gquyb9mtResO9elKUy7VayA92l6M2sKEy8=;
        b=wa5gPt+vj1TaEl8RBt/+R1p6mJG6fsNO/3YCFxNYd6HrdYlru4QaWy+W9bWUoYL634
         bCEujB6SDDwVsBXYxyR8wNjaj64B7awIkSw/67tA7nSqcOINO+NZusN+crzpphESRGe2
         2ELVGu9RrCgAJgCM7nuFhQjlhb7FaZu11mqPwBXtqmkGzArA42nwgAsWFfcMUIPqUbWI
         FXV5/jQg1sBDcp1VmH1g5uq3A25DF/nt+ueOpzxB1zXBdgY5ovUNxSBbR87HoG2FYmef
         tFbfBWTOlaH3lHsgqMJ5Zn/fZVlK9lnfNZCkKU2JkGqTEu4blLu29fr7IrEVqkXJCr9M
         2jmg==
X-Forwarded-Encrypted: i=1; AJvYcCXEPGYn6i+mCddGS81U3kb2ZSQLG9aYADtGutPTO8r7Lmdc0yVQDynmqxm7Nf/VpMmRtJcN2TGPRR1GtdRXcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQlKNKhqHForvDttYVpnZwO6iOLaJBGZ2rCANJTh+I2OxoKJZ
	+jq2Wbbyw49k2UNuglRWVj2aUMqRxYSXtxhmZPLw/aH4y+3VfK8mDfSUVIvVIxCIi3edGXJG/3E
	yJE+1ZCQYU7uIs/dhunSvublolA5HTBhU2rI8Xgex6nIBHP4lHJxXYpPsv+jTIbeHygESAbXhcK
	k5dZ/zPaNuUFwWrhIL3WTPhSKaHT0JFeN0diTJe2EJ9qE=
X-Gm-Gg: AY/fxX6QNqBsw6RcefFcPPigqAS4/ppelQ0DkDVITh4Ee63YkhJ1LzRoaMpekeWZQpz
	nQhE5ya7S3zT6eKg8Lt8N9DID1NwKL0KzeBFBCWsv2Hd//W53FRUlPFd/s2bXK2zb00lHHJwxMj
	RcVnCTOFUYxw2kjMd4/fbFhCZ8BTRzlY1qmD1/T2NY3UQfUMinKqMy0JudCFRKWX/n/Z/0lOJl0
	TWp8FennfzeNNfLWIDEhaEqYw==
X-Received: by 2002:a17:907:3d0f:b0:b76:eec9:a1a9 with SMTP id a640c23a62f3a-b84451ed72bmr1862461666b.7.1768298465654;
        Tue, 13 Jan 2026 02:01:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMoPrQQtr0zlycqSLuPlR6Mujb+2HNN66anZ3BOPKSo195dH9vokVRR4UjV/MnJCFqoDpjTdtY5VMjux93UxM=
X-Received: by 2002:a17:907:3d0f:b0:b76:eec9:a1a9 with SMTP id
 a640c23a62f3a-b84451ed72bmr1862458866b.7.1768298465186; Tue, 13 Jan 2026
 02:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110113738.2376456-1-costa.shul@redhat.com>
 <e64e7188a920634fce126fc71ccc09696984f42f.camel@redhat.com> <20260113081300.s3s115wU@linutronix.de>
In-Reply-To: <20260113081300.s3s115wU@linutronix.de>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 13 Jan 2026 12:00:29 +0200
X-Gm-Features: AZwV_QgENxl4ElyDDsUJIQhAVfRCW4cdbDohGj6uSHb5uvwlb7cw9wlNszf6E98
Message-ID: <CADDUTFxQHSP1VWqEG1ksL7sOoTOKkjXmz=JP3_HPWajz07GjoA@mail.gmail.com>
Subject: Re: [PATCH v1] cyclictest: Generate optstring dynamically from long_options
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Crystal Wood <crwood@redhat.com>, linux-rt-users <linux-rt-users@vger.kernel.org>, 
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 10:13, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> GNU ARGP might be easier to parse and maintain in the long run
> especially if 20 other options are added.
>         https://www.gnu.org/software/libc/manual/html_node/Argp-Example-4.html

It looks impossible to port to ARGP without CLI change: cyclictest has
options with optional arguments (e.g., -a can mean 'use all CPUs' or
-a 0,2,4 means 'use specific CPUs'). ARGP handles these differently
than getopt_long.

Costa

