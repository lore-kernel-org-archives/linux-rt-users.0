Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB235A95C
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126080; cv=none; b=lqGtLTuwJ0VBFW0xXZzDdeVyuOo3Z9GLIZ8jlI1OIdK63FfLprgmUPBw1R/QpJSVwdnx5GPkq1lXNh2kqDGqj4dk7Jiq6VIRbcybHUHYq8xuDy+8nIqSvYh69CFzK7Tm0fp7HQ9fMpfrFbGO9rNCD73We/Drk/CCxOgdPJmBWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126080; c=relaxed/simple;
	bh=N9DECQEMqe7zqgl15KsHGv1UbAlfCzFLavR3VuXASwQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qAlLburDlHFPJ39N9Pu9nOjdj7Ws92HNWTDvWrUE5Z7UZqi3quLduwxm72A2w4UHKYKQbHbNppgRPyA55g3C/sOBx8seibeqMbG81G9lQI2Kj/q42O9O9vh/Fk4EW+R7UCWrD8QK7L25BKT5z6fFn1YdWkAxtPVb7f5aP6p8+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQwbTLYP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQwbTLYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753126077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=32psC5oyo06fm6in4Uvv5UQv0aMmTL1xcMuqMWtcqGI=;
	b=QQwbTLYP31AnYz5Nw89djSg8MavtNbQUbgu1MI9Pr7BatU0tFTwRWoUGfiJf/tFSqgCZYm
	Ya919EALpNxlfnEva2wPyoKzPMNuyX1yLl0ThF3AwNaZ/XDaUnSGXQlQeBNWuv+i7KPGMr
	ZsUnGG1/IFjRDNLvUeHeBA/z0Do1si0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-LzUu75D8OIyYBr7Gw094Bw-1; Mon, 21 Jul 2025 15:27:56 -0400
X-MC-Unique: LzUu75D8OIyYBr7Gw094Bw-1
X-Mimecast-MFC-AGG-ID: LzUu75D8OIyYBr7Gw094Bw_1753126075
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ff810877aaso113132806d6.3
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 12:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753126075; x=1753730875;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=32psC5oyo06fm6in4Uvv5UQv0aMmTL1xcMuqMWtcqGI=;
        b=C08dehq9aXv0JxukzVCPmIERF3misSKQkpbMDP0J/E/LosG6+eOGXoC+Bk9INwpKnl
         za1A39LHIRGmtpU2AzK/mQd0jM3frYkJnthAJY1R8FyFPasFEU6/XyIuFLMuC8UKJuNC
         FhNwNNrM2v/xlcICxpI1F8soLeZIG0aMh5gwR5g0Pa9bl+vICYVsGcGlbcjdtM1lnp7a
         LV0p+rbwmtHylcticoYWoOAji8GK5Ilfn2AJXVCdmK/W2X7WeRImlH7ei6paAsdByWoF
         d4r4Fo+3tw1irVVw1dAxvheS7IZegUUNP26K7+/0D6t6iDv++ts2y2dCSunaGGKWZtWs
         lkWQ==
X-Gm-Message-State: AOJu0YyIH9QWfeUeeYsZSz7onq3SzhetGqAGjJBMSQC9ORJrGZYBdb84
	H0B+1YxrRw0nxKlxCHUGN7f3j/qRlGHXsvBQxzVDjHrglFszPF5ZY3nbuRMhwHHniUF4VEGNFqN
	TYCgYxlDyaKP/un7CazI5lKlhnqaKcsvbag+/1IJVW00xdhVU0SCU2WNWUfxWxc/Ouz3qCwtr80
	Zv
X-Gm-Gg: ASbGncuneHmSAT1PzIszeV928pTWli3AXgyZ3z0y+w8Fe4FUuE4ADdDDqzTGSlU5o4e
	/Y3XLh/errIfijA3fixVqEXKcDpcLbGBDpmABOBKZSSvlUGQBNTbGpBmDvOGA70RJowmQCW0nRM
	+XeobPG86PSsJZlMbiJ3AgcBcpOmDEXTJyVYstVTqPxcO8uqdZNV+lVoPLvHHVdZKRhHQ6OG8Dv
	e90eq/1ZUTti2h3pRcqBDNrUYCGLjkUmIXMOswpZMHPh3VBRlxmvliJ7r8XkmULiwjkC3k05z+M
	XsjdYdxS7oQ+TztGEozxhzjwtfFg9Q==
X-Received: by 2002:a05:6214:ac6:b0:704:f7d8:703a with SMTP id 6a1803df08f44-704f7d889a3mr299334466d6.46.1753126074904;
        Mon, 21 Jul 2025 12:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAsipY7qj4doVYo7/zDlc2wtInUGHqhrTnl2WIkEj0CerR8xFwwb3SuLHWTgxSamrw7T5SKQ==
X-Received: by 2002:a05:6214:ac6:b0:704:f7d8:703a with SMTP id 6a1803df08f44-704f7d889a3mr299334026d6.46.1753126074430;
        Mon, 21 Jul 2025 12:27:54 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b24930sm44758501cf.51.2025.07.21.12.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 12:27:54 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:27:52 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 10/28] cyclictest.8: Capitalize section headers
In-Reply-To: <20250704132721.13325-11-darwi@linutronix.de>
Message-ID: <1b055348-deda-1054-08ae-aa64951fa498@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-11-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Per groff(7) and groff_man_style(7), capitalize the section headers
> without resorting to all caps.
> 
> This makes the manpage's output calmer to read as well.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index f27fe66..7f1bd39 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -1,17 +1,17 @@
>  .\" SPDX-License-Identifier: GPL-2.0-only
>  .\" For a man pages tutorial, check groff_man_style(7)
> -.TH CYCLICTEST 8 "April 22, 2016"
> +.TH Cyclictest 8 "April 22, 2016"
>  .
> -.SH NAME
> +.SH Name
>  cyclictest \- High resolution test program
>  .
> -.SH SYNOPSIS
> +.SH Synopsis
>  .SY cyclictest
>  .RI "[ \-fmnqrsvMS ] [\-a " proc " ] [\-A " align " ] [\-b " usec " ] [\-c " clock " ] [\-d " dist " ] \
>  [\-h " histogram " ] [\-i " intv " ] [\-\-json " filename " ] [\-l " loop " ] [\-o " red " ] \
>  [\-p " prio " ] [\-t " num " ] [\-D " time " ]"
>  .
> -.SH OPTIONS
> +.SH Options
>  These programs follow the usual GNU command line syntax, with long
>  options starting with two dashes ('\-\-').
>  .br
> @@ -229,11 +229,11 @@ Print info userful for debugging cyclictest
>  .B \-x, \-\-posix_timers
>  Use POSIX timers instead of clock_nanosleep.
>  .
> -.SH SEE ALSO
> +.SH "See also"
>  .BR numa (3),
>  .BR numactl (8),
>  .
> -.SH AUTHOR
> +.SH Authors
>  cyclictest was written by Thomas Gleixner <tglx@linuxtronix.de>.
>  .PP
>  This manual page was written by Alessio Igor Bogani <abogani@texware.it>,
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

