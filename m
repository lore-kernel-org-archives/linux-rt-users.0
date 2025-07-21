Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080723506A
	for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129026; cv=none; b=U7y2bo0KFAWs/33h8dRDuNDWR6WAHXsUnoCIMhhIR+ihhFrqCTR1eX44dBL41C2giAm5FIWoKEMp3E467jyIJ77Y5WJEtjxWaE2XXHvjc+0egua0Ln5zqVTteVA7yd3kvLkQ0O+H/QrXQkMvtITAOiME1J6u5eF+WikZVIF4Jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129026; c=relaxed/simple;
	bh=jzfjzy9kWBkDyCcdXBwuERzp36u5pck+yNSdovXKeZs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VhsMcSGwcMZhA+QyOhD802XcmSSUrF4IFq4QdxxUZhHW6IBq/30HdM73SuF76M02GLOQQ8hGs2WIjijznq+2fH6Su4vBAmW8DgCkL4fK17cUZB0DEiKjOYDMbcJFzYFtvUGA3rGoE8TxoN79pvOyzqP+7RUlHS+muO0RkqcS1Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOq/6f6B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOq/6f6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753129023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9fcmNyE7LN3+Q8P5rziX7iX204RlmMX9aaCylH3imjs=;
	b=KOq/6f6BnEvk/b5niBY+txU1dZNVAYIRY1/xMThSJ6IBbNTeiyM7dv9l6zDY2KZzzd5dMq
	sMgyGKZnZTslqJ4sdhmQaO7xaAFKdqmrNoDOOXKdxF2WPmE7bvTJGsWtYZPFR+M0pz4EF+
	cWkrGI7mGJekXU0IiqRhhSyCQcgrLac=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-uMrFQQAKMJiWoQDZeEcHww-1; Mon, 21 Jul 2025 16:17:01 -0400
X-MC-Unique: uMrFQQAKMJiWoQDZeEcHww-1
X-Mimecast-MFC-AGG-ID: uMrFQQAKMJiWoQDZeEcHww_1753129021
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e32df3ace0so389105085a.0
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jul 2025 13:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129021; x=1753733821;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9fcmNyE7LN3+Q8P5rziX7iX204RlmMX9aaCylH3imjs=;
        b=fI9VFekwUCw/l9aQsCoQiyNRWo6KREbaxtb5JOfJwNWDsJEUNIxDZ7wqtT8gDPxFji
         kvRGKYboTyd3OA498r4uBZ6z4QifKBktSM96T9MVuIcwaX0JEZR1jlCmRdLtnrGK6uua
         VTmezzQRPwvRaj+LqhnLeTxpA3//6cqnWAt6RIoT5xL51mykuEuY85QqB3nuBBwg9P4x
         79xIMeERro1NfRaN2lHkuG9VHT2/sTTFwpYbt2/y/ZhhYKzuNLh+UEJNKRFcirUmep37
         ypiwQYeiCLwap/xb07kiJ9aKYj3ZD7oa8DRYn/6Hud4EBFmMqvPKfpl6cSxxdUnpu6d1
         D6pg==
X-Gm-Message-State: AOJu0Yw84hzXKPyM31TZkcPrhKTf3wDWzDsIPKDR5KLuAhpcVl6UCDSU
	+ueqM2E+l0h9N8x4S6kDJPM9hEKQ/gjic9Xc0oYvS8DSgpFSDKNUrJlNvBveuf2ja8hBbjPcU8X
	EsyUKZ1yHdUFZUtJ5ziemPfiN4dXn2lW4SX4E253vjzcqDwvAU03MlKAvAWvZIcO5BJVRXiR7GH
	B0
X-Gm-Gg: ASbGncttuNLI+NWEtbEteHZ1Hb9SFwAEp8go1JZEjEDlsk+tymSpgQLMpwaX0DZ4c2t
	e5wvPpzu+5NrQY79KW0wY19dPe5pf2pTBJM9k+F60rObMs/+46cjG+AXn+tXxZ4+X4g8tAJNHd3
	uGbfcgTNkOp276Cz4XC22MUZgZ/ySH2PGREylF+lUf8H3GchzQFcFEwE7M8n7lP+D+Iz/3wJ5vO
	67VX0SuW6cE4b8LwdI2sZn1XVzu+6xbVVCs0QvEAmllHU0n2yX6IEFvioWmIiuICQq1WD4BjW0U
	FQRAan0ZRmubQviI//ETa6mkdQ1tkw==
X-Received: by 2002:a05:620a:6ccc:b0:7e3:49b5:d53a with SMTP id af79cd13be357-7e349b5d756mr2474397085a.11.1753129020745;
        Mon, 21 Jul 2025 13:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw6gzNln7e3zUWG4inxPc8ISLdGYTniE/2Ah6Db3TROEl9zKbxkLvcx8MGDemu+J3IXOM4Bw==
X-Received: by 2002:a05:620a:6ccc:b0:7e3:49b5:d53a with SMTP id af79cd13be357-7e349b5d756mr2474394185a.11.1753129020265;
        Mon, 21 Jul 2025 13:17:00 -0700 (PDT)
Received: from fionn ([142.189.102.151])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b46b84sm444322985a.38.2025.07.21.13.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 13:16:59 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:16:58 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v1 25/28] cyclictest.8: Options: Expand --default-system
 description
In-Reply-To: <20250704132721.13325-26-darwi@linutronix.de>
Message-ID: <114bfd04-76ff-6fe3-3aad-0ba1ad64c71e@redhat.com>
References: <20250704132721.13325-1-darwi@linutronix.de> <20250704132721.13325-26-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 4 Jul 2025, Ahmed S. Darwish wrote:

> Now that --laptop is explicitly obsoleted and --default-system is
> recommended as its replacement, better formulate the latter's help text.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  src/cyclictest/cyclictest.8 | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index aff900d..6982234 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -75,9 +75,11 @@ display a usage message and exit.
>  .
>  .TP
>  .B \-\-default\-system
> -Don't attempt to tune the system from cyclictest. Power management is not
> -suppressed. This might give poorer results, but will allow you to discover
> -if you need to tune the system.
> +Stop cyclictest from force-tuning the system. Without this option,
> +cyclictest writes a value of 0 to /dev/cpu_dma_latency, which prevents the
> +CPU from entering deep sleep states.  While such force-tuning might help at
> +showing lower latency numbers, it obscures the fact that the system may
> +require additional tuning.
>  .
>  .TP
>  .B \-\-latency=PM_Q0S
> -- 
> 2.49.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

