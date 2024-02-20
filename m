Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792CE1534F2
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467977; cv=none; b=cspUR5QEBPQPrOQ1CTGQXL3Ozjb3kJG0RNtrd710D26AW1mOH/nvdyL65NLPworXD0ubkaOo9D3EJ386f8kTjwA5p5nV7GGpf7EMf2Eyt3jhP3EBPqA00uz5HKVoVsILLanr6zqcGidHT/Zvz44a3NBHw8JMgXlLZ9EvV2eU0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467977; c=relaxed/simple;
	bh=fK9sjV2iYgk6EEpywtKXdHIXojjey3gn/L6ZBE72Rwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2RIwVCbe6jhCarlQv9SbGgZmwmXrgxWGDH/PCBYDVkykwUU9Yi0mUkKj6bjUtiXP7lnI84EZ6mJy2+77f6u1h1jq2YGl1O6o8N1y/7ZoAjdDNDRjnkT52jiQLDHvfQ64XfB4TBwsCYxWSAhOpaxy3xB2vFlfzXBWKqECRZsq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNJWFwMt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNJWFwMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708467974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPHpbIqvGI3GZAeZJOSIdpwg4OWy0KxmA+JMGQUGRJ4=;
	b=hNJWFwMttVscQjuTYWPXahaEkEL+YzyanBuqGc3spRy2vSEa73B8m0Z/d9paS5UkqN6qIm
	Uio/NmTYklBk5Ud928tLvvwdPBg1OIY913WqbaFSM+zyvuje5Y8Wa022fyXK2oQmpMPZYP
	oWOuY7ORxubnr6qa16Ul71Medc2oiQo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-_jX1jAxZO320ru42x2UGpA-1; Tue, 20 Feb 2024 17:26:12 -0500
X-MC-Unique: _jX1jAxZO320ru42x2UGpA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78776154916so238525585a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 14:26:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708467972; x=1709072772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPHpbIqvGI3GZAeZJOSIdpwg4OWy0KxmA+JMGQUGRJ4=;
        b=ZHZgRLFOpIiCZjNJhYh1kQVcyvw+AZFd4x1cCwlsq3JTdV/VQa2jU7RA+ef742y6L9
         FNbNrOna53dgV+GdF55TGXbpFZ4HAN3Jh9mUy4dIXq0JxnDuYYnoYTbO1RP12Sj5jt9s
         ObbJ8s+hyzvXzsW1j2WU4fL/a7AnxI5LstvUYrco7U5yiPrcsxUfrtcB2K6Lc50N4Xk/
         cbkGxbOg0Z+V0BfGb6bvfosyz5G61dvfQfK47dPlGbiIT/xMGaaI80irlEUF2fJHhH8E
         KRFz4XZ21aB6r2ktbNj/etiDK+giczuPF1Z0QNB7ZObEj56w49cPOgpGVt8ubFBGEZH8
         rjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT7B6bOTugOjnelEi+y+Lvpar0sVoLwQfq/SCcNdwh4W+S37m5faKTheVJnRVUBtCwza14cBLJOuLMP+hYPDkUbwYkfCukY76r8QuSZg0=
X-Gm-Message-State: AOJu0YwtIKtDDrpcidnW0OvgBHHK7B94zfuGM4z4CACF0B7atKTIU368
	K1MQ4cUn778ffbzLuyeVKIvr9G2e4Cv4bdH2SbZXlakhxMlfh57Tlf9tvwYM1pFZkO3pcHdYXbw
	AS4DPcyHR7YUVgfdVEsGkzCKO2nMplJ6x3Ry2KSe/3mTtHcPvjg+b8vYNYowVAKo8
X-Received: by 2002:a05:620a:13c3:b0:785:c3b7:4e84 with SMTP id g3-20020a05620a13c300b00785c3b74e84mr25773184qkl.35.1708467972248;
        Tue, 20 Feb 2024 14:26:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDxpqQD+BPPqTlPrne7pDxsr8iJlYVf/WMcfo/C/M1OEfbvY9gUL6WrF/kIV/P1TVnpH561g==
X-Received: by 2002:a05:620a:13c3:b0:785:c3b7:4e84 with SMTP id g3-20020a05620a13c300b00785c3b74e84mr25773161qkl.35.1708467971966;
        Tue, 20 Feb 2024 14:26:11 -0800 (PST)
Received: from thinkpad2021 ([71.217.33.204])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a000a00b00787702a13c0sm1619411qki.114.2024.02.20.14.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:26:11 -0800 (PST)
Date: Tue, 20 Feb 2024 17:26:09 -0500
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Clark Williams <williams@redhat.com>,
	Juri Lelli <jlelli@redhat.com>, Derek Barbosa <debarbos@redhat.com>,
	Bruno Goncalves <bgoncalv@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: Automating console_blast.sh
Message-ID: <ZdUnAdrJC4VWRlmv@thinkpad2021>
References: <ZdOQ2KzOIgYc8Ber@thinkpad2021>
 <87frxo2vhg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frxo2vhg.fsf@jogness.linutronix.de>

On Mon, Feb 19, 2024 at 06:57:23PM +0106, John Ogness wrote:
> 
> It is called "console_blast.sh". ;-)

:-)

> SSH is fine. SSH sessions are not consoles. Consoles are specified with
> the console= or netconsole= boot argument and receive the kernel
> messages automatically from the kernel.
>

Ack.

> > The license for our test suite is GPL v3 [2]. May we have your
> > permission to license it under that or permissive?
> 
> Yes, GPL v3 is OK.
> 

Thank you.

-- 
Sincerly,
John Wyatt
Software Engineer, Core Kernel

