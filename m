Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80A4241691
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Feb 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472314; cv=none; b=IeHWLUrdBUNVDVNOi+Maf7SzYt4JUcesJvsA8G/ILa/ee5t074UI4q4x9i/91Qx8GqP0IGMX+h+hVR2lGvaYkdS41qQ9uZM4slo+8cj/m1TUwZzzDjTSnPed93vtLXmtq4sLQu/ebwv4i5Z7aAEgzQaCGrblxyIipLWGbtXxZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472314; c=relaxed/simple;
	bh=AHjlUwmDj7lOR679lSizZof6hubvQEX1T8oWlF1cO78=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qt2Objmsu3p2CuZTDff1b//ZpFaZH2yD6G21oc2EP9mQYrweAqKQY3AuYOkrx4+Aof4ABmYKU0B1jxsU1A86+PuaLmXr4kvP+kgNJRG/3h/moOdnimavg9IW1RmxRMlb66fa0Dsru8sU4o0/Asjn3vGZThILHo3XQnpWUI+ZZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4nx4RFD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4nx4RFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739472311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqtxikweeEEo3xjsCaKXzNvRXkHSAnkbSm9ILBIwhgg=;
	b=T4nx4RFDhVtQNaI9EOewIcZ6h5cW03pQnN3Vigs5LVD6iVOEcNRZVEnACz54PB6zMFVo8m
	bQHL+mnqvf1wmcTIAJ09/CZA2jzHsMpKzgG1AUUKwjFYqM5dLHYNKfuY5KDo/b+1o39rzN
	pL8/Kym7XsfdP2EHJ1Vc6z1jPDuIaPQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-akLTniuAPfSbfXPu3SjjOw-1; Thu, 13 Feb 2025 13:45:10 -0500
X-MC-Unique: akLTniuAPfSbfXPu3SjjOw-1
X-Mimecast-MFC-AGG-ID: akLTniuAPfSbfXPu3SjjOw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c07668e74bso305711285a.1
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Feb 2025 10:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739472309; x=1740077109;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqtxikweeEEo3xjsCaKXzNvRXkHSAnkbSm9ILBIwhgg=;
        b=RJR8ehLl4KEX//iYqEi15NdSeoKaCotMvX5p2Tnf56IBFA4mXMfEP0Hsg9ejX73Toz
         zVwqef0Q7TvEPDxoxemw/XdykcPhSAHbDza9sdnCilMxpYogi6HDhPbNWZJAtgveyY3h
         pbdawo2oUE2RGr3taffKZt1zr8+xbpQBsuJiwLjKDN4CR+h7uL4jamD4kCLcxSjzRG/8
         KtWyCO2cCDmrae1Uhinv2xmiFjAgbtMxsMeOcmqsztyPkE9mv3mTfDh+sjFhyKjYGleQ
         CpSdqLUYxB47B73tu//tB5PTZvUHJ3EUxQ+CV0glthUxrIobFs82jo8czeQr0qTDGHBn
         Zb7g==
X-Forwarded-Encrypted: i=1; AJvYcCXyTrOiJB8l8gH722BZL3BS24tjNcNjN9eBzyzp3xbqZ/0Rpuc148tLkwx37xuP/Q4UYuw2qA18oVOcI7WnYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUwWfKrTBKeSjcG9Fiw3n/ZtVlght3JHwW3BiNF47NUulbZ3n
	T2wcLfz+PHP9xe1P9qN1K/eGS1eoH2S9ZeUF+DhRQ/vacJuNwTFuxhkpVsahJeRXUAujW8v/hVz
	mkQyTf1vu+ym8H7DjztaKgunhBpz9MLMWPgLxN3WTSxuuiWU57IXUPkx4W9TzejN6RqMRvglS
X-Gm-Gg: ASbGncuJ/vLy1OGU4sg4Z/Xvgoqj4EUQowbMykCEUMjeH5pt54FR99GMT4XyHWoSS8f
	8n6XgXSTmd7dUK00NVD7/wvzeDCpXtkfxk4E6IUZ+pg8Z93dRMxjcyr1lgkVj+Ak/Uchzg4wpSl
	DbxEsqsg5l9ugRSuFL9eD9GYCtz3e0Il2rWvAO+5Hx43eaD/fixf4QXgHNAyP9RLo+ZeP18tEpg
	Q82wfFHD3zaMa4gH9MtfhZPottIoEVX2lCORPSa3INV/G7/LkR/8sPSESBgCfHfWWN1cp6Zm5UD
	zf14u/GST/iFndan7+GqVZrEoxC0h1anhQ0h
X-Received: by 2002:a05:620a:244a:b0:7b6:d3b3:5757 with SMTP id af79cd13be357-7c07a12eeffmr701010685a.13.1739472309608;
        Thu, 13 Feb 2025 10:45:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvMuDyaB2S5UYm0sxJRIdflrU6XFIVCDDt8m3PyUE0Cflm46VuGsTabeL8punndCb2bMVnpA==
X-Received: by 2002:a05:620a:244a:b0:7b6:d3b3:5757 with SMTP id af79cd13be357-7c07a12eeffmr701005685a.13.1739472309140;
        Thu, 13 Feb 2025 10:45:09 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c6174a6sm120432385a.65.2025.02.13.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:45:08 -0800 (PST)
Message-ID: <2c97696aec2256cc15f2c045bfb313f7a7691c7c.camel@redhat.com>
Subject: Re: [PATCH 0/2] Add cpupower idle-state functionality
From: Crystal Wood <crwood@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
 kernel-rts-sst <kernel-rts-sst@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>
Date: Thu, 13 Feb 2025 12:45:07 -0600
In-Reply-To: <Z60Rfi05LXbjGfHi@thinkpad2024>
References: <20250128014551.15058-1-jwyatt@redhat.com>
	 <21714eaf-d3d8-81bd-cc27-7a8aeb0bf971@redhat.com>
	 <50cda06eaa30769ebb2c3130fce5394f1d8bd9ad.camel@redhat.com>
	 <Z60Rfi05LXbjGfHi@thinkpad2024>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 16:24 -0500, John B. Wyatt IV wrote:
> On Wed, Feb 12, 2025 at 02:53:35PM -0600, Crystal Wood wrote:
> > On Mon, 2025-02-10 at 14:50 -0500, John Kacur wrote:
> > > For the -s option, why do we need to put the IDLESTATEDISABLEDSTATUS,=
 if=20
> > > we omit that can't we just get a result like running "cpupower idle-i=
nfo"?
> > > Could you rename IDLESTATEDISABLEDSTATUS to just IDLESTATE_STATUS?
> >=20
> > This was confusing to me too, but it looks like the argument is actuall=
y
> > a particular idle state, not the status of that state.  So it should be
> > "IDLESTATE" just like -d and -e.  Or better, "IDLE-STATE" like "CPU-
> > LIST".
> >=20
> > -Crystal
> >=20
>=20
> Apologies for not answering you earlier John. Did not see this email unti=
l
> Crystal's email.
>=20
> If there is no objections I will go with Crystal's suggestion.
>=20
> Here is the current printout for the patch series I will send (note I cha=
nged
> a few items to address confusion). Please let me know if this addresses
> everyone's concerns:
>=20
> options:
>   -h, --help            show this help message and exit
>   -i, --idle-info       Print general idle information on cpus in CPU-LIS=
T. If CPU-LIST is not specified, default to all cpus.
>   -s IDLE-STATE, --status IDLE-STATE
>                         Print the idle-state (cpu sleep state) of the cpu=
s in CPU-LIST as enabled or disabled. The argument is the index of the idle=
-state of the cpu as reported by -i. If
>                         CPU-LIST is not specified, default to all cpus.
>   -d IDLE-STATE, --disable IDLE-STATE
>                         Disable cpus in CPU-LIST's idle-state (cpu sleep =
state). The argument is the index of the idle-state of the cpu as reported =
by -i. If CPU-LIST is not specified,
>                         default to all cpus.
>   -e IDLE-STATE, --enable IDLE-STATE
>                         Enable cpus in CPU-LIST's idle-state (cpu sleep s=
tate). The argument is the index of the idle-state of the cpu as reported b=
y -i. If CPU-LIST is not specified,
>                         default to all cpus.

We could simplify the description as:

  -i, --idle-info       Print general idle information for the selected CPU=
s,
			including index values for IDLE-STATE.
  -s IDLE-STATE, --status IDLE-STATE
                        Print whether IDLE-STATE is enabled on the selected
			CPUs.
  -d IDLE-STATE, --disable IDLE-STATE
			Disable IDLE-STATE on the selected CPUs
  -e IDLE-STATE, --enable IDLE-STATE
			Enable IDLE-STATE on the selected CPUs
  -c CPU-LIST, --cpus CPU-LIST
                        Specify the list of CPUs to act on.  If omitted,
			act on all CPUs.

-Crystal

