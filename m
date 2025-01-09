Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2F2594BA;
	Thu,  9 Jan 2025 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419688; cv=none; b=AeiW/Xu7GQQMyCE1xEozHE6r9b3WHQgLRFZCcISxUlQ9fpC9+JwmXZ3ySbVyqVeM7YZE8lDqGkTQb9vS6nXpnqXFLb52mnyzwvgANpcKNSDPqK5rSWlEbHPgk5QJ1BNtB0QRFBvtjOxvaU7apdlCyHiU4Oag8+m3UY11QAeGzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419688; c=relaxed/simple;
	bh=eet1vt7h9KZXpWS2lZkZkcP2OsOdh1WfMY62jCiMg4s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCYGxLAC/R6eQWHEiTcyyXYMHgjkB/uRSmslUQ1cWXuPYJUOR8k39wXqoiXV84axBC+7sQPP59gCCSBCH3RNhoces4KZI0qCWAQZ2y7V+SbSsxngEyyFaSJn2cOjS/NEM7h8HTKeYC2OyR6nAuQ1zql4EVbJbhcZZ6scoU1UWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NiPVoPlm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rBo5TMgr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NiPVoPlm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rBo5TMgr"
Date: Thu, 9 Jan 2025 11:47:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736419678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAoMh6zYpVO541IvzTj+T1fwKYtnFK1Jf1u0ecw73lU=;
	b=NiPVoPlmECE0ps6N23Uf5cJrg8sh4sk1X4V0kkwyR+AYV5bKRq3klX1tW9juJpYdS6xpzb
	aN86vmcXuO65rHhKWtcIr/RwGa8su6GzjNWFD8KjbQbyIsseUTFJ4OyRJJu/ygZM9nsq4W
	yQJF7AuDTINx9BZlrELgDnFkEqXIg7ow6dfbldQDxAOE2pzTARuOkqxIOeM6iDKoiUIghE
	BgJr2bKl4VCFa07S2cTVFxb5gOJhqIQEDl4QZliv6Bvqq3VDMrrVBZF6x5o59HuuDOFRl6
	2sNhhJjzHpBmyumzeAti1U4B0sO9dzyrN0YVT0Umq5jZo4hci2qWGXX71wXKIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736419678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KAoMh6zYpVO541IvzTj+T1fwKYtnFK1Jf1u0ecw73lU=;
	b=rBo5TMgrisHm23sk5tdzVKBcPB7Uhcf7nG76yPaR33G/PaR/WGsrHxmceU+pANwLrYfEXh
	VJwLVR8V+eXD3lDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christian Eggers <ceggers@arri.de>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RT] v6.12-rt stable branch?
Message-ID: <20250109104757.lszbnJUq@linutronix.de>
References: <2732654.vuYhMxLoTh@n9w6sw14>
 <20250109-sensation-diabetic-9b082008c6d4@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109-sensation-diabetic-9b082008c6d4@thorsis.com>

On 2025-01-09 09:35:20 [+0100], Alexander Dahl wrote:
> Hei hei,
> 
> Am Thu, Jan 09, 2025 at 09:23:23AM +0100 schrieb Christian Eggers:
> > Although most of the remaining RT stuff has been merged into linux-6.12, there
> > seems to be still no out-of-the box support for RT on ARM 32 bit platforms.
> 
> This is also how I understood it.

I've been asking who needs ARM support and nobody spoke up. Arnd then
picked up some of the patches and for v6.13 the ARM queue got smaller.

Looking at what affects ARM from the queue there is just the ktimer
thread and the ARM specific bits. Lazy-preempt isn't implemented.

> > Are there any plans to release (and maintain) a v6.12-rt stable branch? Or shall
> > I pickup the necessary patches into my local branch myself?
> 
> We have some systems with Microchip AT91 SoCs (SAMA5D2, SAM9X60) and I
> would be interested in those patches as well.  The last patch
> published was 6.12-rc4-rt6 from october.

v6.12 is a LTS. And I wanted to add some PowerPC bits because it does
not boot on some parts as I've been told.
What about I make a release for the current stable tree and then update
it once the patches no longer apply on a newer stable tree?

> Greets
> Alex

Sebastian
