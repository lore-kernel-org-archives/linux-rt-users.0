Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B94A95C
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124594; cv=none; b=rJGn/m9lHGvbEripAJnP7GD0GYlFU9NM5bofwENIYmtf5FB5C2Bs8ToKJIWqFs0grJC7hZWoL8nGS69tJxcK/Iykxjr2940no/RZXqK+j4v0p/W9HhGTt6/jOC++Ko/x4M8yP9LjfURkpTmUVEv6+HsT4jDh4l/p/eOwcWFRwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124594; c=relaxed/simple;
	bh=+3Rt42jssHHrY8C9CIDo+RKgwQQkQtpDv49AxVi9ZLc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AZtpnsVwSQPEG0Y+7LiBlnRBRD9/0yrPbyWc3gyWlEHPLZblPiRDkBdkEkxEmxSCYRAprnKPOVT1HJJz36iHT3x7b9EBzCNyu0+8bOExpeo9YI5oaojbDsxuGxipR1Tipgvgf3WEic8mT1n4ve5A0QK0e/7UlPEH0IfIf1aZssI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiHeiu7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiHeiu7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753124591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KE2jKps+hgmd0d2/1de/IJrru8bpv1Ds7IZVsbYIfGI=;
	b=BiHeiu7MHFoDMkAHVkAJIuNYPoNrjeE5UV9fBqADAaoNJZSnYDUlKDyi6GUbJ4l5j9F8AO
	iAw4kP5TDbM9XFCBjKOtCdVI0rrQuyCI61TCKwUeBgVSoiHw2Ken8j9RBHeO4x47n8XprC
	nSJqlB4AqcgSlgauLI02c9x8RjAemq0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-IKWwZ8vfP2SUnRiOmTE5vg-1; Mon, 21 Jul 2025 15:03:10 -0400
X-MC-Unique: IKWwZ8vfP2SUnRiOmTE5vg-1
X-Mimecast-MFC-AGG-ID: IKWwZ8vfP2SUnRiOmTE5vg_1753124590
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ff810877aaso112560836d6.3
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753124589; x=1753729389;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KE2jKps+hgmd0d2/1de/IJrru8bpv1Ds7IZVsbYIfGI=;
        b=N4I2zjytEdeLleIvfmEshHdrfVWHDugYaamQHYy5LrHEPkMaK2iGAElHTBTRAvmxSL
         toq0CabciNvoJUbXElu1/Gy09aqYmUctEjqDD8YSHyX73YEuVl6ybb5JV3zzUjnmBgEN
         O6jeWh0GvJtzzdSGi4eF0dV9T7QAdpXf9uNeRmQbXBzwWhqfN+qOVMAsxspY2DiM6rLo
         O62CW2uvqw394RTO+3EjtPW2FUTFdicl75tJ02oA2+2sZircRIFv6OyaWToi34GwOUhJ
         wwsApEA2dr/uNaM4eHAHrc21G4hJth65E8ieEaztSWXikAO59ddcdAnEq7FODMNf7JRJ
         WnfA==
X-Gm-Message-State: AOJu0Yx2TFTntrlV+NEUPbk1NRhvRcMHR8MXt6WPtz3qUowt3Tkjtlex
	0nvMjukia0nGgOdBZtBOzfSJJWPWo88QlT7WlqQsX/9nTyoxaaD8L9Cm3FBf1tg2Ic1NnbBNqEs
	iWUJvwlJvTTqHPCO8p1CTMY8UMLFxlxHAF+akmP6VK3LMY2XY/7pVZqUr3ugO5K/f04tbWEiM3w
	2O
X-Gm-Gg: ASbGnctWR3dVb1Y2QMFPXx4amfjkBSQwTIU+LV3HknOXEj91A7Lbrjf2Fync5nF8azP
	rEKMUog+JcLXP8shQdDshLrdEWb1O/te2mlzb0NCTnpxp8lhEVKq6Nn1dtOrC4sy9TbmP8yfmE1
	07+U4nct+SB2wTnhf6b3SrY6fO248A6gvIRmRUUyiWZGBRPVQTMY7ub1iD1Tz3Mm6eVKW+c3C67
	rK7rpfoj21K6UbM7O/GGsTx9JrVWgWh2f4YNKPQigmsLoaGN2cadu/L4I1oCbTjqABUIlwZM3kl
	h2GdfQHd0sM/lEV2cM542w0KjQsp1Q==
X-Received: by 2002:a05:6214:c4e:b0:6fd:151:a58b with SMTP id 6a1803df08f44-704f6b0856emr295571676d6.18.1753124588941;
        Mon, 21 Jul 2025 12:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2X8rGdQ6lPK9awfNkVTbUpUnSvgpCdCXer+xgW6OuXjvEeSuOcuj4CZDkPdtdNAohmS5WKw==
X-Received: by 2002:a05:6214:c4e:b0:6fd:151:a58b with SMTP id 6a1803df08f44-704f6b0856emr295571116d6.18.1753124588349;
        Mon, 21 Jul 2025 12:03:08 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b92394fsm42154596d6.51.2025.07.21.12.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:03:07 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:03:06 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 04/28] cyclictest.8: Synopsis: Remove -y
In-Reply-To: <20250704132721.13325-5-darwi@linutronix.de>
Message-ID: <3d862d04-6982-26f2-44d6-8977b5af3b05@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-5-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Commit a3a7ee1a6831 ("cyclictest: modify option handling to use
> enumerated types") removed "-y" as a shorthand for --policy, but forgot
> removing it from the manpage.
> 
> Remove it.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index 312bf7a..76b10f3 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -19,7 +19,7 @@ cyclictest \- High resolution test program
>  .SY cyclictest
>  .RI "[ \-hfmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
>  [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
> -[\-p " prio " ] [\-t " num " ] [\-D " time "] [\-y " policy " ]"
> +[\-p " prio " ] [\-t " num " ] [\-D " time " ]"
>  
>  .\" .SH DESCRIPTION
>  .\" This manual page documents briefly the
> @@ -41,7 +41,7 @@ in the set in numeric order, in a round\-robin fashion.
>  .br
>  The set of processors can be specified as A,B,C, or A-C, or A-B,D-F, and so on*.
>  The ! character can be used to negate a set.  For example, !B-D means to use all
> -available CPUs except B through D.  The cpu numbers are the same as shown in the 
> +available CPUs except B through D.  The cpu numbers are the same as shown in the
>  .I processor
>  field in /proc/cpuinfo.  See numa(3) for more information on specifying CPU sets.
>  * Support for CPU sets requires libnuma version >= 2.  For libnuma v1, PROC-SET,
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

