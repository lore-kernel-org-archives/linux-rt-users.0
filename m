Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6AE27293D
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Feb 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760152; cv=none; b=nb5JW445Nqsio5efP41jZWCX+M07ekR9y4INspmhXDyCxO6G/mGEu/ilK18UZ5lqSBHWRvNJnFr5CoBX0O74Kww9XRGIoE7+Cz1QOjIDBdcW+T42Ql3BnpsTsa7JpxtxsvwaJ4Wg4USw80LR/2FGDWoTOB3fLc2YEgZS/H6l2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760152; c=relaxed/simple;
	bh=+UxCAC1qx+iZAPTLZ2vVPMozgjss7qpAU8RzVP+GUsI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=REal951jFqgilFqlaZ8AT8YdtWdETwYxYBtO5N6Fgc70i4pl5MYh10AXrogrrQfg3AePsq6OVHhPaLiOQ+ndKhN/2HZkCOIOSjMb41aLSxmq/1cdhJCiLY5iV+aXnf57c16fF4WYnr3QFrfpZ75Ds9D9Trx55jsmMh5EfG1UtSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=AhFnZ6eF; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="AhFnZ6eF"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202502281628565c8f730641f721f262
        for <linux-rt-users@vger.kernel.org>;
        Fri, 28 Feb 2025 17:28:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6INQuKOsHX7i+6Vt3LXb8jGBUclSH3RFohhJtMSo9GA=;
 b=AhFnZ6eF5n6O/Aamo/5M87pfQZMixSuH111bLr1R4H1fUNKL41x0mRWahq+bPcCdL8sDow
 Awq8ojOmRQsA2+EbWedrf85tj36EljEDn4behGgnxbP4gVPpVcP2So9JhKg840vMSU1elCGd
 2KxHRp7+1iLZm0a+ZP6gfkwBZ/MRjpLlo27WiQnHAc4RZa1Fwop+5cFPBmBHV1hAKATc19e9
 6IiSx/CFICi7z5g2LicwP5prkqNiGVmRETJHl4cQOYenMqotLr1vKiBDp1xq4OUFjiFCAi7M
 CyYBH+EaUp1xXMM+U9atwfmH718d99/GilXpoVXzoxSxkxosSKyoMqFQ==;
Message-ID: <2d38f77a2ca81a7112ada30b03698c383aee9035.camel@siemens.com>
Subject: Re: 6.1-rt: NOHZ tick-stop error: local softirq work is pending
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, 
 "Ziegler, Andreas" <ziegler.andreas@siemens.com>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "MOESSBAUER, Felix"	
 <felix.moessbauer@siemens.com>
Date: Fri, 28 Feb 2025 17:28:56 +0100
In-Reply-To: <20250227134304.xLBfiIC7@linutronix.de>
References: <73c50e2fb53ba8cc2f1538abccc42e98fa63159b.camel@siemens.com>
	 <20250224115557.AIFtijeu@linutronix.de>
	 <d31ddc467399b53c3f0687db63cb64a3a7c77ca5.camel@siemens.com>
	 <20250226091752.jCsLqq66@linutronix.de>
	 <7cace5d70278f8ae1debe8cb8d392fb3f59291ff.camel@siemens.com>
	 <20250227134304.xLBfiIC7@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Thu, 2025-02-27 at 14:43 +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-26 23:23:30 [+0100], Florian Bezdeka wrote:
> > > NAPI threads? You have RPS enabled by any chance?
> > > Would commit
> > >     dad6b97702639 ("net: Allow to use SMP threads for backlog NAPI.")
> > >     80d2eefcb4c84 ("net: Use backlog-NAPI to clean up the defer_list.=
")
> >=20
> > With NAPI threads I meant the kernel threads driving the NAPI poll
> > which can be activated by "echo 1 > /sys/class/net/$device/threaded"
> >=20
> > RPS is build configuration wise enabled but not configured.
>=20
> If RPS is disabled then this might be something else.
>=20
> > As Felix already reported, backporting the mentioned commits to 6.1
> > would require some manual work. Simply picking all the dependencies
> > seems too much for now. Will have a look again...
>=20
> Can you reproduce this on a later (more recent) kernel? What are the
> steps to reproduce this?

I haven't tried that yet but after some tracing I have a much better
idea whats going on:

Our RT tuning sets ksofirqd threads to FIFO, which seems not the best
idea. I have to ask some colleagues why they thought this is necessary.
As those threads are driving the NAPI poll in my case they might run to
infinity and with that into the RT throttling - forcing CPUs to idle
with softirqs pending.

Does that make sense for you as well?

I can force the system into the same situation with threaded NAPI
enabled and assigning FIFO to the NAPI threads.

FIFO for threads driving network RX traffic doesn't seem wise. A DDoS
should be quite easy...

Florian

>=20
> Sebastian

