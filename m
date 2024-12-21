Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008C6AAD
	for <linux-rt-users@vger.kernel.org>; Sat, 21 Dec 2024 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734743202; cv=none; b=nntFD5MdhPrhE2Z+/gfy6NQfKw8ap++y8yedmAePVbtPyB2iSXgQ9CrqwHEXGTk/KSUDU6fq7EMFzpDD09WJeVk1mm7S3+mGpXM4rmAR0XT3NjymzKSiHSDugkjrLyoLO4U8gkRK0N4ftAaeEkw0dPcKP7hxs1QwGMHQ8+de7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734743202; c=relaxed/simple;
	bh=XfgafNCmHL7nA1Kqh/9cs+Qz3z8Q7pcVjwC76INbHvw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2WML6Q8xt9EDz77lzhhfQGh9kGMCyYmkPxhU4cZp4CRPikfBbSBnHCvyyo+/W7vwcgwTdQ+kHkLBgFnI/TTB1CfLaE6WGICOMvawAfbeti1c8cYd7WtSgHOrcQgfHtqBJqCMWwZW/n9a9f4bvjg956iVN7aTHa0DMeViI0exbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4OfSBVA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4OfSBVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734743199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkIoZxXxV3WrfpjTYG0sDEf6E8cG4HDV0s8h+MZcJ0g=;
	b=g4OfSBVARPVfAdFnP8Ck4GEf/IL3WWwbSzjq2jzcFDaprgDHSln+M0Vd5GHQwQooMPnP4k
	QwEh+e/IqVTZ2lDdX1EY43w0G5oXFrZA0qkrOjcWYXl62Hw1z6i4lTrh6nNRsyV3n4BEea
	JmjLdPEu1QAk0GykMIWtMHvh8BUQXQo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-f3wEsniWNcm8CWRbuMQPOQ-1; Fri, 20 Dec 2024 20:06:37 -0500
X-MC-Unique: f3wEsniWNcm8CWRbuMQPOQ-1
X-Mimecast-MFC-AGG-ID: f3wEsniWNcm8CWRbuMQPOQ
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6ebe1ab63so630000785a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Dec 2024 17:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734743197; x=1735347997;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkIoZxXxV3WrfpjTYG0sDEf6E8cG4HDV0s8h+MZcJ0g=;
        b=CdkW0MclPkCVHJMwEeNhVC0PsqhRMRGz2mr44WuworUyb2uHWngyz+FXZumfRJp3mR
         aA6UnHyt+yIn5Xq88zqyCq4Zx6O3tdX7xeeI1t7lxFTcpfSa8XRqAvlaCInncHEcA9fu
         8ZB76Ro3/RgILKcFmvVPRLugpJNrqQsVBJptDWB6Ks0Wwt5e4e9gK9SH6pyLnR0Bpm4x
         JP4xYlT2zGtiU0OAxymQZMBDgfM9rjuS2CBW4To6lvB5GTfWuY5D4XSq6sucQ7aIIfpC
         AzFH1R63ubj+0DYEWBdZFh6uXoUdbRGMnZ0E81sRJDJMaRsenC5JDWPXHcq1WWzVlMbT
         oneQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1TNDu+9SvQURAhog6zqxWK1pkuV+ypGlzf1Xj5EUS5mzLfRVyE96SmtSTu48vcGPBZDjK9yhugpy1PmpLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0nWiQCiYmqPz5Bo3xieMDmlkGhsCEMev6q5pZDlFf4OYrswQ
	0A+2GfiymnsgpiDYzEr7isKBcjcYGSIoAa2ULBKQ6bTYQ7SRtcO3RHvcl33e+KPnAzclT/0qzoA
	B0icRoYEDP54dece8HiR+OsGsKnQdA3otXQBZqfB0nuBXlnoxBAkcnkvzKrH7T/f0jRaB1bQt2I
	8=
X-Gm-Gg: ASbGncvcx8HwzRVSu6ngDge68O+h0NOSO5i/7Kyr+SzxVnmynSbItLUw98VxYZ89RpC
	CPTt75QTOWErp1u+myN78DydSzGPQOjgMt8uUKjLaKWePfuJSnO+Q59m10iHYIspiccWKDcQ+oi
	HzMjR5O5UCOIMxtxhFquRoJNiEg09p/vBMGwlfyB1qkj+C0zvnZAPeizJmPhdJ0wJVZraRptjzu
	v2GoCn4bRZYZK+cq4lQ6ddFDLSw8q0Gzaw8qS0gog7r71zwrUeTjEkEjGQQgFTYTFWMuu3puTND
	bZ1IPJ4cx4Ds
X-Received: by 2002:a05:620a:1727:b0:7b1:4a48:56bb with SMTP id af79cd13be357-7b9ba833dffmr618867885a.56.1734743197022;
        Fri, 20 Dec 2024 17:06:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm6VpO1b4teJE4EzxKyLhYwef+tYx8JadZ9pe2bT8keo68zTXSMc5E9CzXVFso3MqETO8XLw==
X-Received: by 2002:a05:620a:1727:b0:7b1:4a48:56bb with SMTP id af79cd13be357-7b9ba833dffmr618865785a.56.1734743196764;
        Fri, 20 Dec 2024 17:06:36 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4ef0f6sm183671985a.123.2024.12.20.17.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 17:06:36 -0800 (PST)
Message-ID: <583707cfd55996a753fad241b869ae4cc63bda67.camel@redhat.com>
Subject: Re: [1/1] rt-tests: cyclictest: Suppress unused parameter warnings
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: ende.tan@starfivetech.com, linux-rt-users@vger.kernel.org, 
	mtosatti@redhat.com, williams@redhat.com, leyfoon.tan@starfivetech.com, 
	endeneer@gmail.com
Date: Fri, 20 Dec 2024 19:06:35 -0600
In-Reply-To: <ca9f9d61-a81d-9343-7872-f1110ef7b247@redhat.com>
References: <20241212162453.2618945-1-ende.tan@starfivetech.com>
	 <afa631a73622f8b0d49dbe4608764b353841f472.camel@redhat.com>
	 <ca9f9d61-a81d-9343-7872-f1110ef7b247@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-20 at 13:02 -0500, John Kacur wrote:
>=20
> On Fri, 13 Dec 2024, Crystal Wood wrote:
>=20
> > On Fri, 2024-12-13 at 00:24 +0800, ende.tan@starfivetech.com wrote:
> > > From: Tan En De <ende.tan@starfivetech.com>
> > >=20
> > > Mark unused parameters with `__attribute__((unused))`.
> > >=20
> > > Signed-off-by: Tan En De <ende.tan@starfivetech.com>
> > > ---
> > >  src/cyclictest/cyclictest.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > Can we just turn off this warning?  Unused parameters are entirely
> > normal in functions used as callbacks as well as with ifdefs, and it
> > seems like a low value warning to begin with (there's a reason it's not
> > in -Wall).
>=20
> I believe it IS in -Wall
> https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

-Wunused-parameter is in -Wextra, as per that link.  It's a crappy
warning that just causes noise to suppress all over the place.  The
kernel doesn't enable this warning, FWIW.

-Crystal

