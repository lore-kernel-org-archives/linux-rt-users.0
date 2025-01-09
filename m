Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9A10A3E
	for <linux-rt-users@vger.kernel.org>; Thu,  9 Jan 2025 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409960; cv=none; b=nf5OyWE7biAYApThE/rAEbn1uxZC0pzcnuunXm5suHO227nJ+d/T0C1OmDLTPrvNaVOdkaAxMCllNceszbMXUGj1Bih3c87MKIi0mNpfpGE+VftFO16lcoroJT/gUgQQKYV5/qm56lQvsQpdf/tiFb+7mBdclAZQCr0MXv5ibb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409960; c=relaxed/simple;
	bh=Bt1Ba7GAPBY4uNBLO8x0rktvki6gs+/uNf9bpQyuoAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0H8Mu8r6zWbFRfPVaMIloxxsn9CZ22bsKKQeonXK5ts2HcIR6v4tv1LTzDmgnVejH6tQYYOaLIwQN9G5CFZFNNwL5ZxSFEPzQbR0LodEgZS0ju8CKOHEILXZtuthVGaVA+NVMLNYLEF3b8dXgs5msoYgzuWc7kGvLVLSKoDZ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1EtTomVj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lggfNQ++; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1EtTomVj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lggfNQ++"
Date: Thu, 9 Jan 2025 09:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736409957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbdOpg4e5wAOlrnS58lncLWO2RWT3EFA5XGK7Mdcsw4=;
	b=1EtTomVj51+9Z6rEeGop9UBu5MvRwZ3GG1SsU1q1KhtULHAusKYU21681FWgZBq+7tTTEj
	N0FzylySTKcMnA151nfViIuVBscNs8IEaIJyjjBUqo4tjjktM5dLbxrgvFDL3ki6oeovkA
	cRwuNu8UnJU758m4RQvsfvLkzVToQXxHzmwcF3WzXKin5JBgo1FIKjBmj4gSbcX9gy0xAA
	NWDrXWoxare4DVUx8NwZseIhJaUwQtlKHdh1vPnSqKF+f1d53YS/p1i+I2GwwWgNbvO15b
	rN8bUUSz9UZLJsotNQrxx8nEX6oA6aVWQVr4ZhOxD+2EXXZ1AB4yIs6AxTQe/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736409957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbdOpg4e5wAOlrnS58lncLWO2RWT3EFA5XGK7Mdcsw4=;
	b=lggfNQ++6VYe+scIqtWvasR6KXlFp+Y+0QJX/m1a2VsHfCaS5xdOLWnay132ZEaQq7PUY5
	959P4m8kVfi/5tCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: rt-tests release tarball location
Message-ID: <20250109080555.WpQmRgu0@linutronix.de>
References: <20241228114346.6020d6b0@windsurf>
 <87h66b2c6m.fsf@kurt.kurt.home>
 <20250107141424.EoC5uS6y@linutronix.de>
 <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f87b2d77-7925-8678-d0fe-9a0d471a38f1@redhat.com>

On 2025-01-08 13:21:19 [-0500], John Kacur wrote:
> We've been doing this for 15+ years. Normally I would expect the package 
> creators to come-up with a work around and not expect the people offering 
> the packages to accomdate your packaging software.

This does not mean it does not deserve to be fixed once people complain.
Debian and Fedora download the source package and host it themself so
they don't rely on upstream's copy of it. Other, such as buildroot or
Gentoo or even yocto download it on every request.

> How many kernels back to you need to keep? Could we come up with a 
> compromise where we keep the newest kernel, plus say the last 3 in the 
> rt-tests directory before they get moved to the older directory?

What I am asking is to either please keep all rt-tests releases in
	https://www.kernel.org/pub/linux/utils/rt-tests/

but this would also mean that the older folder becomes removed and this
might upset more people.
Then there is the alternative especially if you prefer to have only the
latest release on top to please keep all releases in
	https://www.kernel.org/pub/linux/utils/rt-tests/older/

even the current one.  This does not sound annoying, does it? The latter
is what I do with RT patches while I release them after people
complained so I have the latest release in
	https://www.kernel.org/pub/linux/kernel/projects/rt/$version/
and
	https://www.kernel.org/pub/linux/kernel/projects/rt/$version/older/

> John

Sebastian
