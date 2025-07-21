Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE522F770
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127690; cv=none; b=W4XVaSb9tW5QR7BoY9ufKbJOcOaOgd5hBRovpEocOGeMbIZeMuKLSYdHxweyyfDOUaTlgX6zfzCI+IPwOeUx4xbg3AAEIDEM0Aon/g66SCtSvSLG7DB9U7hle8iygqbai9cx24+XsBjUKsvvXoKt/2xCvSDDLboJRAuinH2u7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127690; c=relaxed/simple;
	bh=ZaIsOrV7WofibX3zQZExfFivv+FkNl+qqXmNc/yy42s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jwk3wLPd/O8pYxcSyLdOVVfj0OUf65Wfm+GvzyIAHiC9Q2VXfDPuSkaTUbzGtA2ZqRUwYF2HLsGZnejAkJjdrb3GiygqokhAkl8q91T0b34OiesCbYSL0dEzGnxyRUpiSyPCFBGiBAIvA6G068sdjr+CMnalIX0byNSRluNUeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cidt8kzX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cidt8kzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753127687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+NPNJ4EX/dmEsSQ0WB+V3v7qxHNbG29fvpT7s/uAAU4=;
	b=Cidt8kzX/uvVvQkxHcZRobsUR2OpcMqpfQkKqHP2IqOedsw8q09IpaZS6UeVan9JofpqH2
	QPrBajSC8f/iSyJzNGdMU2k+eTXyGteLeGrWvr4snUlMQ8XkWnLNDyCd3drt9whs2AzLop
	+qw2R8JVCX9/dyaUE8o+DRNgwaEi6hk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-_N2KUS7WORaIJCFiEe39fA-1; Mon, 21 Jul 2025 15:54:46 -0400
X-MC-Unique: _N2KUS7WORaIJCFiEe39fA-1
X-Mimecast-MFC-AGG-ID: _N2KUS7WORaIJCFiEe39fA_1753127686
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-702b5e87d98so85885726d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753127685; x=1753732485;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NPNJ4EX/dmEsSQ0WB+V3v7qxHNbG29fvpT7s/uAAU4=;
        b=wZ8gTn3fktszdzLsm/4T91j3Khgy5Q5966ZWBMqgXioAvxCInRgOivYqZlofzBqcLy
         TCIIeYKBZRoaaNX6PHQmfOgX5vYySvzNO3fSmw3oZZn0Q5BLPiO4JK2QZMF5+nKz9Z9M
         gPs3+nqhWnzBBmwLX7rUT1Cv/kRlBDEDETdSfp5nBA3x7hSPW53sHP9oCWZvuuwQ7o1W
         ie7yn7IZqFNy+q2UCQcTnyfNtNf48WAHVmVLBJ03nW/LjTr5wrboQt2z4rM9HtHDf495
         RNRZB8Kx+X0aLtsJswCHe4BpR2Yi0dCVXdtpiooeOUKRieXcv5v8DWM++IKJVrkHKJVh
         YDQQ==
X-Gm-Message-State: AOJu0YwfR6ILGogJeMKBAxRGc1tGLj/2l4L8EtpIAgdAqpOQQX2Nf1gt
	wK170yBC6sjtNdpahAfq/Wb6NcWeCp1s5Lt5JdQrHbn/K6bG7VIk90i3CgAxJUmYConDVoVJL5c
	+L1/EAhuRrZx7uLGLaBvKJDgxRsJiMQ03QUb3S2SSU+qxLMbn+P15s8GGXgY70e/YJLyCTjAQDz
	DX
X-Gm-Gg: ASbGncvl2DdQLKEGxxDcF2+vI89iBUatoG9a2+CREXi6eNtxIsIEWFZ1oQUrYreE/qd
	lcy1X2Frg/TWG5R5Jhi1FblBJjdW8tkwHN8mI36IbLmeC2N2YqYB5lqubuC0Xj0wBaTmzgAGEqq
	p/oZ7NC9bJ7NoB8VDEzkVTZJIIrFzrYm+Y9bfRuyxE5/dpoBOXhLXEKYO2rEu0RdaPI/DaqG2Me
	bWhNqOKXgzIxeCYa7pHHzpZLXV9oi7cpO0VUiIn1DhBVgw6nRrBlxnFxBCui7m8TjBumEO4x1jO
	NPbk3JCPZSFBN5R8EaHviTofjPtOng==
X-Received: by 2002:a05:6214:20ca:b0:6ff:1548:6f0b with SMTP id 6a1803df08f44-70507448814mr222065796d6.44.1753127684899;
        Mon, 21 Jul 2025 12:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsWwwzKKBYMCVx0xeyeRJDb2UydAxPIiW3+lWo39bTFmRlNqsFCCXg+XIeJ49lr6hJRRh09Q==
X-Received: by 2002:a05:6214:20ca:b0:6ff:1548:6f0b with SMTP id 6a1803df08f44-70507448814mr222065426d6.44.1753127684164;
        Mon, 21 Jul 2025 12:54:44 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bc393sm43601516d6.1.2025.07.21.12.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:54:43 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:54:42 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 12/28] cyclictest.8: Rework the Synopsis blurb
In-Reply-To: <20250704132721.13325-13-darwi@linutronix.de>
Message-ID: <686c16a3-73f8-5b7d-9c88-b38feda522eb@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-13-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> The cyclictest's SYNOPSIS blurb is buggy and incomplete.
> 
> For the cyclictest's flag list:
> 
>   - Remove 'f', for --fifo, as it's not a flag and requires the fifo's path
>   - Add 'N', for --nsecs
>   - Add 'R', for --resolution
>   - Add 'S', for --smp
>   - Add 'u', for --unbuffered
>   - Add 'x', for --posix_timers
> 
> For options with arguments, expand the argument names with something
> comprehensible since the whole purpose of the SYNOPSIS section is to get,
> in a blitz, an understanding of the tool's actual options.  The original
> argument names, especially when -combined with the one-letter option's
> shorthand form, were totally -incomprehensible.
> 
> For consistency, be coherent regarding the arguments' names; e.g.,
> "*-path" for all file paths like file-path and fifo-path, "proc-set" for
> cpuset-related arguments, "num-*" for counts like num-threads and
> num-loops; "*-usec" for microsecond arguments, and so on.
> 
> Also add the missing options --deepest-idle-state, --histfile, --latency,
> --mainaffinity, --policy, --spike, --spike-nodes, --dbg_cyclictest,
> --default-system, --smi, --priospread, --smi, and --tracemark.  Do not
> add --laptop since it is deprecated.
> 
> Note, this makes the cyclictest's SYNOPSIS blurb complete and gives a
> comprehensive view of cyclictest's abilities in a glance.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 57 ++++++++++++++++++++++++++-----------
>  1 file changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index f093677..0271f5c 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -7,33 +7,58 @@ cyclictest \- High resolution test program
>  .
>  .SH Synopsis
>  .SY cyclictest
> -.RB [ \-fmMnqrsMv ]
> +.RB [ \-mMNqrRsSuvx ]
>  .RB [ \-a\~\c
> -.IR proc ]
> +.IR proc\-set ]
>  .RB [ \-A\~\c
> -.IR align ]
> +.IR alignment\-usec ]
>  .RB [ \-b\~\c
> -.IR usec ]
> +.IR break\-usec ]
>  .RB [ \-c\~\c
> -.IR clock ]
> +.IR clock\-type ]
>  .RB [ \-d\~\c
> -.IR dist ]
> +.IR distance\-usec ]
> +.RB [ \-D\~\c
> +.IR duration\-mhd ]
> +.RB [ \-f\~\c
> +.IR fifo\-path ]
>  .RB [ \-h\~\c
> -.IR histogram ]
> +.IR max\-latency\-usec ]
> +.RB [ \-H\~\c
> +.IR max\-latency\-usec ]
>  .RB [ \-i\~\c
> -.IR intv ]
> -.RB [ \-\-json\~\c
> -.IR filename ]
> +.IR interval\-usec ]
>  .RB [ \-l\~\c
> -.IR loop ]
> +.IR num\-loops ]
>  .RB [ \-o\~\c
> -.IR red ]
> +.IR oscope\-red ]
>  .RB [ \-p\~\c
> -.IR prio ]
> +.IR thread\-prio ]
>  .RB [ \-t\~\c
> -.IR num ]
> -.RB [ \-D\~\c
> -.IR time ]
> +.IR num\-threads ]
> +.RB [ \-\-deepest\-idle\-state\~\c
> +.IR idle-state-num ]
> +.RB [ \-\-histfile\~\c
> +.IR file\-path ]
> +.RB [ \-\-json\~\c
> +.IR file\-path ]
> +.RB [ \-\-latency\~\c
> +.IR pm\-c\-state ]
> +.RB [ \-\-mainaffinity\~\c
> +.IR proc-set ]
> +.RB [ \-\-policy\~\c
> +.IR threads\-sched\-policy ]
> +.RB [ \-\-secaligned\~\c
> +.IR wakeup\-usec ]
> +.RB [ \-\-spike\~\c
> +.IR trigger\-point-usec ]
> +.RB [ \-\-spike\-nodes\~\c
> +.IR num\-nodes ]
> +.RB [ \-\-dbg_cyclictest ]
> +.RB [ \-\-default\-system ]
> +.RB [ \-\-priospread ]
> +.RB [ \-\-smi ]
> +.RB [ \-\-tracemark ]
>  .YS
>  .
>  .SH Options
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

