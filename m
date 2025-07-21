Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBA18858C
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128372; cv=none; b=UjR8tV6APi2rQ7czK9+VxK0D2fj6GJkRUCUGRj5mmoCR5hAZ5R74fP6IR6Y6ZIf2YQgwhybvDT1dTRo3Yg55mAnp8TLdc3Arcu1eXHx5al6CuBcp9oijc5WM9ZXaIH3mZ8Z0nN27snm74GMWZBmMa0WIBFMC4YF+KpbN4aMpa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128372; c=relaxed/simple;
	bh=ELKHT7O3D9m7qfrv6p6WPtBEet0nC5ulQraScIVaSoc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dVGOSR38WvpMHaaCcsGBYkJn+k9dNCqsvs3UFPrJmppMlDbVFin0ODZY2ihZ3GMWY1bLaZVLVnRBkN44rbWLWiDdrj52o4zAPIeSLEzqbUDT3ftZXsu+cw5kRZkOUO3+hw4N+IXSOwJe70cP8MhPdHAyL6Sbyc5w5zT2ShyetuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2smv0nI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2smv0nI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753128368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yyHUGioFwauLweY+sdzcoGdDnCUYvuPqNDhiVgLC8xY=;
	b=Y2smv0nIMOdCQpARiNlOz3eZotj60l0YGBYyhA5Loy9iDJjdPC3ULeC/htIokmEE1aW9gm
	zQL5n5leVLNQCwxnECeBoiGXlK/seG93RTz4C506n7MAx0jYGGOmkzi9B4H0LN5uQaAKo6
	9S2fZHkLXl3Kbfqv1IMhu3tmmbeP08Q=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-MdeY3GtGPs6zgLFdZFno5A-1; Mon, 21 Jul 2025 16:06:06 -0400
X-MC-Unique: MdeY3GtGPs6zgLFdZFno5A-1
X-Mimecast-MFC-AGG-ID: MdeY3GtGPs6zgLFdZFno5A_1753128366
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-702b5e87d98so86131646d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753128365; x=1753733165;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyHUGioFwauLweY+sdzcoGdDnCUYvuPqNDhiVgLC8xY=;
        b=b4aCDHKQaVrMD9Kr+eT9rb0MiFdkPU4pHKNUsoi3CX5vsSQkNW9IFecc/jKnKLnRX1
         LcgarfviYUcg6h+u2Ynphz+8j3yjkpWdzJZwVLxdkB1IhlNB1NQR9Vzz11nGPJ8QLyQo
         ENLXYRMKuhmugVAIRYSSl9B33/SicYElEuwOIdpHJXVHMambOKkpJDarGqPL8QdIJ03M
         pvfRgVUoLcDCw8+YyFCsFkXkvO4zE8Tk41Xya2A5kmk94NmUQl8Ccm7LyqR6TTdGBrex
         3YFUGIwUohtU9x+MuTGLJhellkFzg9i5SHQwCUGIG4E/+B3WZylwv0Ngy4yinwvc8OyV
         mxCg==
X-Gm-Message-State: AOJu0Yxot3ZdOfwYfyi2T6iMPcLOZtjTS43pj1vC64h2I7/ucC9Ow7V9
	NAV7ecogP8GjWnbia/igii/Vcu1eAbdWbalxUqFayO5/IuIzQNVcSDXd5GdbXKxfWoha+KZ3Okx
	WMDvtku5J8M+A6z09l79LMNQIWgBUNvBiho0duu6UYSDUp3zuAfq5WYdBbF2tt/m+5DwRj+db+b
	sR
X-Gm-Gg: ASbGncuUge3RBGMMtW2RluaQoFD/Fsv/tOs+s2Fyl3GdAR7iRgvSF0KiJIxWYSA2ujB
	AFaX5Eo2Kk9ebUaX29YEd5PeLJz35WYt5KftGB1AYlcWdoXPr78Jx7csw1aDOUdqV8P5HD1CFNX
	/debqI+RTiNbHZHptOMkaXc+IWL1DaiiP59C7suPHmZZlJGAS3dtFkFM8sEEZlikpV3Smlsq323
	XwMTa2JFjrhkeoV+nCcUCPPUrquiI14KSSJx7XekL8vI9BwiVceeFdpgJSp672fkWRwBg52IPqM
	GmQf7OjepFDpY5hmQLfyImj0KHYsJg==
X-Received: by 2002:a05:6214:ca2:b0:6fa:c31a:af20 with SMTP id 6a1803df08f44-705071c1e69mr298725096d6.5.1753128365413;
        Mon, 21 Jul 2025 13:06:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmxlXcKXota8psP+uJgbi3QR2I/GZaTjfD9hhWvZ13g88KD5aeVgOOli7V6BsOa86kcsm2JA==
X-Received: by 2002:a05:6214:ca2:b0:6fa:c31a:af20 with SMTP id 6a1803df08f44-705071c1e69mr298724386d6.5.1753128364705;
        Mon, 21 Jul 2025 13:06:04 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba90424sm44151906d6.84.2025.07.21.13.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:06:04 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:06:03 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 23/28] cyclictest.8: Group x86 options
In-Reply-To: <20250704132721.13325-24-darwi@linutronix.de>
Message-ID: <4a92d573-0749-1d7d-21e6-5fc1670592a4@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-24-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> The number and breadth of cyclictest's options is huge, and just
> exploring them in sequence can get the manpage reader lost.
> 
> Put the cyclictest's x86 options into their own group.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index ca75884..f320f66 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -280,7 +280,7 @@ statistical information about the latency distribution. The output is sent
>  to stdout. The output format is: "n:c:v", where n is the task number, c is
>  the count, and v is the latency value in microseconds.
>  .
> -.SS "Other options"
> +.SS "X86 options"
>  .
>  .TP
>  .B \\-\-smi
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

