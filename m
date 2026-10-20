Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491411;
	b=VdclQzYPWY2wp+JM5oQu1hXEsWkVYDhBeWitjoIgfEq6L79bkY1+NUzhP0qx7PvDbn2t
	 2pjlfNzZ6E5hGwa/ChDfvIAfV54LsBd633DwLtAqqCpEIV1r3e1Ib0hetXoPyJ2S2pqsM
	 uUBMu8uyEq7ipQB63GBrrFRv4bNlXvVtPKmWTmjDt1vNCf4E9pIQHRik+pBXgFDkFliC9
	 QhuN0PFXQ0CkS/G45tp1GklauQ/RmQndiHicOCBVpDTenz4Q7A0tEKCYoeXkAkam0eEL0
	 9R01rehcF8nVG68BNYYs8yZ7+U/Uui/82bnU2KiGkAk0twrjocqP0YfTS7+Hq03Y0JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491411;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=oW3QmuK8XZ6wUgA6fKc3zXZwXl0Vw/4z/Ad0o6lfSMg=;
	b=mjyxiJBPV6Qz9QM6+zkICuwWk5RH/LW0XoeLew97r91AFS5Lcy6JDRDlbWebIDYllrVI
	 XebdV7bcUMhkfpS+LddSaSK7PU7aYMTZK41Tm+bw8sTV84b7XfPBR+MeRDINAE4NcVV4O
	 WmePCTeJTVFVuuSmG/RCl8FEUllSwheMmTyYd8YKK+XNnuv9p5hmLNrjTMOfNN8MYttyD
	 WygoEU/rGim0590jHUTEjwZcFDYQ/tSZ6qGzog47ZYcAFW+XOPkHvwCjKWPd9dKIekAjl
	 DiC1TgsMa4btWEg1AuOCYfQl7PBUg7W3z1Dd7j8t4pnhTLqseBU47MMa4oIK2bEo/cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=iDPJEku8;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KCSqf1xw;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A02606A339
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Oct 2026 10:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84A02606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=iDPJEku8;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=KCSqf1xw
Date: Tue, 20 Oct 2026 12:16:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792491408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oW3QmuK8XZ6wUgA6fKc3zXZwXl0Vw/4z/Ad0o6lfSMg=;
	b=iDPJEku8UrHuidGmcdIzsgdEdqExybdXZ0sjYLWOnKE+cfQIFyi7JUAT97QeI7d4jt87oy
	UlQZ7GvjMAByHBofWovJF3SOcunDLa5XkbmtVa9QcToNE9GE8U6gdLOL0DumaWIUMoBOsF
	76KkHeG47RdfKPkID959IgW+oJqLWOVk4znOl5Y15gLZEE4Xa4KQ5V/rdWPxuN22s2+2gM
	Dfr2m46aV3D9Fd3l7na4x5BzQEzhzgOU7MXY0XTziRrMJLCRNjsAdFpdDdEfl6mJ6Fxzgh
	8Prim3Kg3YYQ9cnRNzln7JzaVlHzVSS8ty985Bi++Cyn3nXeDKXDjbLrpWvvGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792491408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oW3QmuK8XZ6wUgA6fKc3zXZwXl0Vw/4z/Ad0o6lfSMg=;
	b=KCSqf1xw5vh1uTPyYz4K8xS/ulJAnmfFK9BODtJYUYMuiJUe3Od+a2N2q5HPBfST9snWHB
	dewMQPTjmSdu3VBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Bart Wensley <bartwensley@gmail.com>,
	Crystal Wood <crwood@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Restore tracing parameters
Message-ID: <20261020101646.Xb1lEbqY@linutronix.de>
References: <20261019102909.3339372-1-costa.shul@redhat.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019102909.3339372-1-costa.shul@redhat.com>

On 2026-10-19 13:29:09 [+0300], Costa Shulyupin wrote:
>  src/hwlatdetect/hwlatdetect.py      | 18 +++++++++-

I've been looking at this and figured out that this is just a wrapper
around the tracer that we have for this.
Could you please get rid of the DebugFS class in it?
The tracing folder should be auto-mounted at /sys/kernel/tracing by the
distribution. Currently it is also auto mounted at
/sys/kernel/debug/tracing if something is accessing this folder and this
is subject to vanish. Mounting it does not help then either.

Sebastian
