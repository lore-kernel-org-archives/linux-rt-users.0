Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B6EAC6
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127869; cv=none; b=gYyoQEySYhUQdW0WvdXMx03XonXD5KVDbNUONkiWqPxqnjVSuNIYLuiGUCNPaW6B1q7e8QHAvYBv1Pe3VDKvTSFcpbbkaaBrz836xfS+CbwbM1QkkSeQ7U9m40LUoYUNiRa+txUW+NMAoog6HCSbhK4wCLd3/E7Au5j2+omwGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127869; c=relaxed/simple;
	bh=g9rj5UbtlViZFgwkH9P0QIhqWB+k5RaeSclSXHoLWT4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uGujiY0IOPCOlDXVHsV/+30wTAZtE+TY9SMNZifWzvYShUalzQ8d7u+PRua2ILMuK0oOI90NvqZovW0l0EK/0fVnpzt/ORrL5GYFttadnnhjR1qk3HiUhOsuSO51fQbzabB35U7F0XPKHCou6xfFhMRf5g2gGc15VzwH8VLptMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOhQhcx9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOhQhcx9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753127866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1aHPGj4+tFGk5GCj4lcaDnUF2CyVkccnrkiENKJi36E=;
	b=QOhQhcx9ll6Xg6DnxQKKzA7jo18Dctfm3tQTafDLqEo6NVwwehdJ55LWpgyxaM4C4coRWr
	+8jqAaYjbH4hODVOdycCfOmdOCqJyfcsZ/CUD7dua3mTHrPnYd476A+Y+izJ3/x4VL7iP8
	46Lo8WUbna8qRW0MOQEJjX7vYXQoVc8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-6pKzjkwXNV6XCfvok1-ZFg-1; Mon, 21 Jul 2025 15:57:44 -0400
X-MC-Unique: 6pKzjkwXNV6XCfvok1-ZFg-1
X-Mimecast-MFC-AGG-ID: 6pKzjkwXNV6XCfvok1-ZFg_1753127864
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e34399a08fso1081010185a.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753127863; x=1753732663;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aHPGj4+tFGk5GCj4lcaDnUF2CyVkccnrkiENKJi36E=;
        b=iLVCptPiBbivYDZneJYrC5h6Na4rkwKTi9rjLvOuHS/zcmdkEN6cYDhuhsveHFDUs1
         gUK7kNOvAMFo9TeY5tD0Lk0WLt45bZpaBWgIwP/4T+Z6Oo4sXdeR6vDldpyYQJIzhFql
         hkyb6Zwcz3FJzY59mZwyXs4p3Gs+5+carra9KA7ZEsUqp8Z3p0LwbOd+bvVRKPrIzAwk
         3B7u9v6IJhUXpRe9rb+XoNb9qbbWKOwhQLl2udGqmlLRyUhNmj/ibnqQYWXWTDITGd0a
         bJxZNN6OhCAAKlwpf39qux2CnIEYROnpppPlOihwYJUuVpN/0dIoasNkPhqdsx8c89bu
         oElA==
X-Gm-Message-State: AOJu0YyonS6pN9t8oz0u7m9/TxL1/SSSlQrXrLtcV7mLPi91WNLjSfHS
	qwNv6p00KpqYi8gZ5IPtinoDuyvtc1/Rr1H+V2RfgiKeJOXq9Y2viY/KuPvpwOredgZnvrh4Tu9
	bwzVM+iyiL0iCvORI7ESfiD1EnRkIha2llnThMUikaZbIe8qK6bi05EHfWxpeTIVQmZ8ijZiLZZ
	+U
X-Gm-Gg: ASbGncsdraf4SRgyKSwcAnxTTertE2HGWnvLWQcxnqNr0AEN1qheKohAwVsN8ci1qyy
	yjBF39qWUNFHzaQ+NDPNBf/MGOG6dPr4vVRvDGJWHiAiQIbaC06LC+wkZfarBlloEKaxdeSuMtc
	29OsXK1qNhmM6v65+caRjTJURJeymZZim1gGr3FoK2vH7BfpRDn/b4LJ8Mv9Psh5pYV/Ah09ua7
	8czzwWuI27Yuhv1ZtPgaCqxQ2qqAeJGqB1tq5xoz5OVg6rD9zpjP1WkCQKS5U+hoEyV6TD9M4qg
	neZbXjytpEknFs08b3UeIz1ZDVOawA==
X-Received: by 2002:ac8:7f50:0:b0:4ab:6499:7864 with SMTP id d75a77b69052e-4ab93caf116mr275128431cf.22.1753127863412;
        Mon, 21 Jul 2025 12:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZq+cBAa9f4QiR4MN9auFNzkPGwZvED13Flfw2cZ9xt/8SkToYUTZ9uINaUUdvZs6pORIQUg==
X-Received: by 2002:ac8:7f50:0:b0:4ab:6499:7864 with SMTP id d75a77b69052e-4ab93caf116mr275128151cf.22.1753127862932;
        Mon, 21 Jul 2025 12:57:42 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4af44d7sm45347121cf.38.2025.07.21.12.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:57:42 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:57:41 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 14/28] cyclictest.8: Group system-altering options
In-Reply-To: <20250704132721.13325-15-darwi@linutronix.de>
Message-ID: <1c2472df-f200-6462-c611-5f060d51c4d5@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-15-darwi@linutronix.de>
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
> Put the cyclictest's system-altering options:
> 
>        --default-system
>        --latency=PM_QOS
>        --deepest-idle-state=n
>        --laptop
> 
> into their own group.  Adjust the Synopsis accordingly as well.
> 
> Further groupings will be added next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 58 ++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 1fd550f..0bc2fc1 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -9,6 +9,11 @@ cyclictest \- High resolution test program
>  .
>  .SY cyclictest
>  .RB [ \-mMNqrRsSuvx ]
> +.RB [ \-\-default\-system ]
> +.RB [ \-\-latency\~\c
> +.IR pm\-c\-state ]
> +.RB [ \-\-deepest\-idle\-state\~\c
> +.IR idle-state-num ]
>  .RB [ \-a\~\c
>  .IR proc\-set ]
>  .RB [ \-A\~\c
> @@ -37,14 +42,10 @@ cyclictest \- High resolution test program
>  .IR thread\-prio ]
>  .RB [ \-t\~\c
>  .IR num\-threads ]
> -.RB [ \-\-deepest\-idle\-state\~\c
> -.IR idle-state-num ]
>  .RB [ \-\-histfile\~\c
>  .IR file\-path ]
>  .RB [ \-\-json\~\c
>  .IR file\-path ]
> -.RB [ \-\-latency\~\c
> -.IR pm\-c\-state ]
>  .RB [ \-\-mainaffinity\~\c
>  .IR proc-set ]
>  .RB [ \-\-policy\~\c
> @@ -56,7 +57,6 @@ cyclictest \- High resolution test program
>  .RB [ \-\-spike\-nodes\~\c
>  .IR num\-nodes ]
>  .RB [ \-\-dbg_cyclictest ]
> -.RB [ \-\-default\-system ]
>  .RB [ \-\-priospread ]
>  .RB [ \-\-smi ]
>  .RB [ \-\-tracemark ]
> @@ -71,6 +71,32 @@ cyclictest \- High resolution test program
>  .B \-\-help
>  display a usage message and exit.
>  .
> +.SS "System-altering options"
> +.
> +.TP
> +.B \-\-default\-system
> +Don't attempt to tune the system from cyclictest. Power management is not
> +suppressed. This might give poorer results, but will allow you to discover
> +if you need to tune the system.
> +.
> +.TP
> +.B \-\-latency=PM_Q0S
> +power management latency target value. This value is written to
> +/dev/cpu_dma_latency and affects c-states. The default is 0
> +.
> +.TP
> +.B \-\-deepest\-idle\-state=n
> +Reduce exit from idle latency by limiting idle state up to n on used cpus
> +(-1 disables all idle states). Power management is not suppresed on other
> +cpus.
> +.
> +.TP
> +.B \-\-laptop
> +Save battery when running cyclictest. This will give you poorer realtime
> +results, but will not drain your battery so quickly.
> +.
> +.SS "Other options"
> +.
>  .TP
>  .B \-a, \-\-affinity[=PROC-SET]
>  Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
> @@ -103,18 +129,6 @@ select clock
>  1 = CLOCK_REALTIME
>  .
>  .TP
> -.B \-\-deepest\-idle\-state=n
> -Reduce exit from idle latency by limiting idle state up to n on used cpus
> -(-1 disables all idle states). Power management is not suppresed on other
> -cpus.
> -.
> -.TP
> -.B \-\-default\-system
> -Don't attempt to tune the system from cyclictest. Power management is not
> -suppressed. This might give poorer results, but will allow you to discover
> -if you need to tune the system.
> -.
> -.TP
>  .B \-d, \-\-distance=DIST
>  Distance of thread intervals in us, default = 500
>  .
> @@ -154,16 +168,6 @@ Set the base interval of the thread(s) in microseconds (default is
>  Write final results into FILENAME, JSON formatted.
>  .
>  .TP
> -.B \-\-laptop
> -Save battery when running cyclictest. This will give you poorer realtime
> -results, but will not drain your battery so quickly.
> -.
> -.TP
> -.B \-\-latency=PM_Q0S
> -power management latency target value. This value is written to
> -/dev/cpu_dma_latency and affects c-states. The default is 0
> -.
> -.TP
>  .B \-l, \-\-loops=LOOPS
>  Set the number of loops. The default is 0 (endless). This option is useful
>  for automated tests with a given number of test cycles. Cyclictest is
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

