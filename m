Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC623816D
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129244; cv=none; b=cev6u1ynecLCD/Q5TUaC+RIDa1ubzEFKOu2q1IKGgTMLI3InYRiEiz9GjShx2sEmBXrvN1nlpXtfaLn4YIQVAcL08KNUcrd6M2s8P6PaHWmIuezV0D6pLrgJgctmq6qdGpZTPJXYl+D3UmQQUJS0TYIYsBLY1ph7RnpFyf75h40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129244; c=relaxed/simple;
	bh=7ae0JGSp2ySxcj3x+fR05QOflwrztDGDR7pR3gX+InY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TWsUcq939V4zAL/5O89Q6X2MdQ5/NyV0fxixn2opyonX4vU3+viJFNJ7FrUOTqDSGUcI5GmWFJFcRShBENyeSqsr1p4f2uaRE/ixFthJ4UzNM/SgCSA5AN5Si2EbLJiYFSrsdE9lOTRpbngH7SrXSpjAYbYJoslZXEnoTi1a+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLnhH1hj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLnhH1hj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753129241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mt0giYKyHfaXzHBb96RJ15Vos0bkuVrq2Ba05ZOCK2w=;
	b=JLnhH1hjSzJAE4KCTNjKMQgOGdPK9Lgfz50xcZJGW15CS/H32j76RKMl7PugY31t4QowTY
	jeSU3F/4AUb1UrO4RtyNIQWdwk1u72uMIGF4K6SSDr1oVrBjQSZfU5M1VrazD9028mGiqA
	jdI1a0Qi/8dSZlAewaXXZrQyTnNEZWc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-e4DOsNkNNiWtpTh3ZI1yNQ-1; Mon, 21 Jul 2025 16:20:39 -0400
X-MC-Unique: e4DOsNkNNiWtpTh3ZI1yNQ-1
X-Mimecast-MFC-AGG-ID: e4DOsNkNNiWtpTh3ZI1yNQ_1753129239
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb5f71b363so88432616d6.2
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129239; x=1753734039;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mt0giYKyHfaXzHBb96RJ15Vos0bkuVrq2Ba05ZOCK2w=;
        b=VCthDGBzARPKoo0n02PSSTWGJae8Kr7up0KvddpCEDWvTUJjRsnd1QTzmhcaZJ7RkD
         1S7BcN0nCDbyzW+O1i5cavKZTIA1yJHbGKKqw4wKRYnofVXK676Lz7fWtyygfvmVR1xQ
         v8X5oYc3zd4KwlidYNIPTH9BnIVRu3NuuH+0O9YijYMP+4GH0++WRgOL6O7DZg1nJR+L
         7GgCHF8MozGAVNY9QkZt/dZ113imfNZicY5RerWG0mSGgeGHcatUlOhb00LWafk934wE
         lhJerSpYJcJLZj/rFdTheclZWWF/cdOSeeB3s7jYgKTXIA1H//T5vL/Ie9jYCaKKLxRn
         yKTA==
X-Gm-Message-State: AOJu0YwPhHFbQ8jlfLMT+NoC5TARYQbjCaRPwl3w4L/qothmP35E4K0d
	DAhKEB9nX3tW1BcBIn+2ZVPJnJ4sMBjCGf+Jc7nsALE85d5rIxgVnU/x2Ri1R/6KgLCyQCDJs6e
	jJMDVX/f9namf+sg1o8QW8A5tBXEwrQ6kV58OseyKPqpPIqlRvU9Wf3lo+hm6wsjXlyryZfCJvn
	ff
X-Gm-Gg: ASbGnctMImZCBKEZ/I2ncl7sryCvuROl0eoYVkHlkB6xHZtrBot9tdqwrtszBGOCjxr
	+l04Bb6it5CXz4SdV35H2G2ZsgyHDEN60ESFY9S+VOBd8vCLR3vOa2TvKWp8mR28znbd5XZpduj
	m3vrIr3h1UuPGaz26O2NI96PuGKkXVRZ1BxLI8uM6udNHGotf/LUWKNRlgkziF/U8LtTvMCWldb
	gcIxp125IaYbpiTfjMCW80/LdcVorDIpTQO3XOUfgz7ahDGqj1zXcVqtQ2OItmLUaaOICv8c4W+
	lmVO2JzjhAozBn7610u8adXpKCf+qQ==
X-Received: by 2002:a05:6214:448d:b0:6fa:fe02:8229 with SMTP id 6a1803df08f44-704f6b0dc85mr226530486d6.30.1753129238508;
        Mon, 21 Jul 2025 13:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi4dNS0ZjQMkYVjGjl95Nxs7x/r6Y1GDQN6EABzWDFA3JzqCFS77BTGTxL1pFoXM99eyw3WQ==
X-Received: by 2002:a05:6214:448d:b0:6fa:fe02:8229 with SMTP id 6a1803df08f44-704f6b0dc85mr226530256d6.30.1753129238095;
        Mon, 21 Jul 2025 13:20:38 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8e3ea0sm43503056d6.31.2025.07.21.13.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:20:37 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:20:36 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 27/28] cyclictest.8: Add example invocation
In-Reply-To: <20250704132721.13325-28-darwi@linutronix.de>
Message-ID: <fdc4222e-5507-7b08-d751-c044916e5a69@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-28-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Add a cyclictest example invocation, while warning the user that testing
> a realtime system is hardware and workload dependent.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 12fb9c1..16e8190 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -291,6 +291,24 @@ the count, and v is the latency value in microseconds.
>  .B \\-\-smi
>  Enable SMI count/detection on processors with SMI count support.
>  .
> +.SH "Example invocation"
> +.
> +Testing a realtime system is hardware and workload dependent.  With that
> +in mind, below cyclictest example invocation can provide a good start:
> +.PP
> +.nf
> +.B cyclictest
> +   --default-system
> +   --secaligned
> +   --interval=250
> +   --distance=0
> +   --mlockall
> +   --smp
> +   --priority=98
> +   --histogram=1000
> +   --histfile=output.txt
> +.fi
> +
>  .SH "See also"
>  .BR numa (3),
>  .BR numactl (8),
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

