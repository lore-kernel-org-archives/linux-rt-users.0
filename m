Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDFE227E8F
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129082; cv=none; b=P8SZen0HaCPf2QVitjmG9sQ4p9nxDDP4CW7XpGT+MZp8tm6DGxpfi3c8e0NmsuGZamHndis9P6I4ih0x56tfFHJaA7ibOaZ4TS0Ri1hSS118ACx9jeVmzhxH9diSNktcTYU1aUJBBcQrzLtuJoyu6hjuiiAcRd6+en5O8/vJabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129082; c=relaxed/simple;
	bh=ynJTYekzH88trjwKlbIyzwLO9baqV8aSUuLqgZRJ4vY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h+Wch0xIE6YEX62IPotg9C1ittxCR/+kJnbCQjFAMeJ51lo5lJa7xtJn/lcwgi2g8KIj/bWl2X1T6nVCmba0suNDnc5IyvLIHyeqN0jFQ2Ep20osTXyhL7Wi01NhX/j3kaA+e8dLA+fa2VTM/fgqhzD1/6W/HUhOaopaP9pvgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvZ55SuG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvZ55SuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753129079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frB0fmb0EMt4DiGKpFDMa5KZG6bomXH0RUzAhOv5AgE=;
	b=NvZ55SuGQuWYu9K6Sz6CoPN61TSMEpFgC46L4qoMKIK20L8etDPIJmjIecjU8W8vFR8P8a
	YCj/O+MMhs1rn75CnOjiGNi+EUpOL0RH/uJ4d9qol41bV+hApXaEYDuOt4iaWqrR03lKAT
	61MFzrho00rOae4xbbSPfPfhltwT1bU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-v86a4rjQPJmyDky7db4B-A-1; Mon, 21 Jul 2025 16:17:57 -0400
X-MC-Unique: v86a4rjQPJmyDky7db4B-A-1
X-Mimecast-MFC-AGG-ID: v86a4rjQPJmyDky7db4B-A_1753129077
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab5c1b5553so82087551cf.2
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129077; x=1753733877;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frB0fmb0EMt4DiGKpFDMa5KZG6bomXH0RUzAhOv5AgE=;
        b=j+YoVBB3Y+hXGbM9dezOXSEs51kYbQDqYFOdXRa14f2q0PVRjJkvP3V/c6rmUsvNP+
         OOz4/iCF9QtUcrZh869AI3GoKHTQmQit8X+9+MdopYnnI1ZlQNED7Di42W4aqD5UeoZV
         LFrkV3b9TfftBQb+H4WRM/uh35b18LpykYVZIOemnmfZiF5AXLdI5/UIUHlRwUNulLTV
         ND7Ih2a3TrXc1uorBl4VMZNdzuO/EF9Yd0vlN4OWwFBV4mwdDhBFQ67M0ZVta1+ksUbg
         amylUZwz6OS0iN9Sxqp5ef0upkUK71FI6oe0rEulAhsOT1g2noQEwF/f46CL9jCZGPqY
         LynA==
X-Gm-Message-State: AOJu0Yxc0kLYidmDoflCRCZd/R+928BbHDIpAYExKh//wWgHDdBq6anb
	qRZmMBBeRP4/IsZg5IwafZe13ZjJhJ8VlNTWWosqe1PUjG7drUrU4J7tMPNCrulImqdThzxjROr
	Gk0I9P6gzH1D5FW1fltcXIrePeAd1229H6Cq3VbJg7Nw3O2BMR6tO9LKR/bSn3piN0BsNmfZbPy
	/l
X-Gm-Gg: ASbGnctIZA6xXKaOexFjLASTNd/gl275Aa9kb3kGnJnACQKT6MBsVY/2H3CyDZCVgql
	uAPTclxQ80y40LcJku1KQpFigCygcU+6X9D+Ekoj+jYt2+GqHuDMIdBJuXrlgXWKAoj/B1zLwz0
	TRehw84Dtd0pHmXHklhF0RbInnFyEL9oK4x9aRYaW4qi70DjzwmHPdaU2HsdXMGC92mmFfx5IHX
	R0YwZ/yrgXPOSUXpeDdzgwQiFvnY2lb9ag+d2wjpdncaf+jTopXldgY2RaFTw3dMWQaRTDwGTDL
	OSiKH9hqlfF3iqEu/ZPpTFDPQdXWtg==
X-Received: by 2002:ac8:7f8c:0:b0:4ab:95a7:71d3 with SMTP id d75a77b69052e-4aba3e7a159mr253670801cf.53.1753129076177;
        Mon, 21 Jul 2025 13:17:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE38e37Kg57tCl9DPAR6Q+0U9Gn0dPACu0+kGEsgDHKOoBbgmg4GrGD3fcTWMn1Ur8EEiaDJQ==
X-Received: by 2002:ac8:7f8c:0:b0:4ab:95a7:71d3 with SMTP id d75a77b69052e-4aba3e7a159mr253670331cf.53.1753129075054;
        Mon, 21 Jul 2025 13:17:55 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b24930sm45180671cf.51.2025.07.21.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:17:54 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:17:53 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 26/28] cyclictest.8: Options: Reference
 clock_getres(2)
In-Reply-To: <20250704132721.13325-27-darwi@linutronix.de>
Message-ID: <3bfdda46-9e88-ab65-a6e2-3091e54db3cf@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-27-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> The cyclictest's manpage references CLOCK_MONOTONIC and CLOCK_REALTIME
> multiple times without providing a relevant description or reference.
> 
> Reference clock_getres(2) where such clocks are extensively described.
> 
> Pick the Linux version, instead of the POSIX (3p) one, as the former has
> details that are relevant to cyclictest's "--secaligned" implementation;
> i.e., Linux's CLOCK_MONOTONIC starts from 0.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 6982234..12fb9c1 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -100,11 +100,15 @@ Obsolete option.  Please use \-\-default\-system instead.
>  .
>  .TP
>  .B \-c, \-\-clock=CLOCK
> -select clock
> +Select the system clock to be used for calculating the measuring thread's
> +latency. Allowed CLOCK values are:
>  .br
>  0 = CLOCK_MONOTONIC (default)
>  .br
>  1 = CLOCK_REALTIME
> +.br
> +For more information on the Linux implementation of such clocks, check
> +.MR clock_getres 2
>  .
>  .TP
>  .B \-x, \-\-posix_timers
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

