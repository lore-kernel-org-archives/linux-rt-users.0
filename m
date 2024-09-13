Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88313F42F
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Sep 2024 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214395; cv=none; b=rHPaJZ7hyWmkuFuM8b1rjXWYKN6L74GUp1ovXBn8psy4jPVGYPSuFWCZ5Dzc87nrtnhcMGuFjxl8OCxrhLLAXB0H9GTcTO0FkEd14fkYcno6a6M/y/17GkFI8de6PKkNmbLhvppf11+hNvjgvlTAc8ymsBgSv5IRdORgwfbwvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214395; c=relaxed/simple;
	bh=EO55u/GqyJQmHfeC4qyZDET25WksC5VwV1/f0dyeIzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eMuxbbL2Jip7dAfBJb6AQjMPETiKNhYpMaknYgcJnAamR5UFYxA78EwVswnj8IU6DTBaJqFGB4sCIPuT8jVTw95RfMCx8rqX6r2y4C5RnnJS9pul4gwMvybXU11r3bimoVTYyOsNqcoQ858Om+KVu4lcUtgGzbeqRrJoBsY8XMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vX9S5UnM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D79R+rCZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vX9S5UnM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D79R+rCZ"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726214391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EO55u/GqyJQmHfeC4qyZDET25WksC5VwV1/f0dyeIzo=;
	b=vX9S5UnMYyrtUupB73opbWJakWnbl9lfiw0WjPtHGVTUvvcSQNZGnWfzv4vOiHi1Abi02R
	E4GAWCoF50dKgHUw9m34lwvyd9ieNFbLko8Y04+ooWKPV01W5yTfrO7NYOWAWQp2kUx1c3
	dCU6SPcQxEZaLc9+QAGTKKmP4VmmQHiKuJN+PChvx8IG6M7cmSzvWofcZQTroujZwjQ6wd
	aJFvmk6fnusRfa28y/d/YnRo001YrFIKBzPihlDIXEuj4SMpos1M2xASdDxdB/sH7Uucbb
	qo7ntOHCDHhA3icVib7yWYPhv7DTMuHoSP2HUpVtr6Q9Woyj1YsqE1fRp4IezA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726214391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EO55u/GqyJQmHfeC4qyZDET25WksC5VwV1/f0dyeIzo=;
	b=D79R+rCZ2F7p60y8BMu5al45zn1R65FwLKCVFERFxMsjcJC0lA/Y5jPW5+QRjSj0dFbj4d
	eYmJltGk8dS5FBDg==
To: Esben Haabendal <esben@geanix.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] serial: imx: Switch to nbcon console
In-Reply-To: <87frq459iv.fsf@geanix.com>
References: <cover.1712303358.git.esben@geanix.com>
 <2bc0b5d3f99184d8ddbf860666513f9fa7760af8.1712303358.git.esben@geanix.com>
 <87edb6gbsn.fsf@jogness.linutronix.de> <87frq459iv.fsf@geanix.com>
Date: Fri, 13 Sep 2024 10:05:50 +0206
Message-ID: <84ed5o9e6h.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-13, Esben Haabendal <esben@geanix.com> wrote:
> I have now gone through all usage of above mentioned registers in the
> driver. I found a single missing lock/unlock, but other than that the
> driver seems to be in good shape in this regards.

Great. Please send a separate patch for the missing lock/unlock to
mainline. It should be a mainline problem as well.

> In the _probe() function, the following registers are accessed
> unprotected: ucr1, ucr2, ucr3, uts. But I assume this should be safe,
> as the uart port is not registred yet, and interrupt handlers have not
> been registered.

Sure.

> I will send out a v3 short, hoping we can get this in a shape where we
> can get it merged shortly after the 8250 driver nbcon patches.

Great!

Note that I am currently pushing the 8250 nbcon to mainline. It is in
the review process and there have already been significant changes. It
is all 8250-specific changes, so it probably is not related to your
work. Just letting you know. I will CC you on the next series
submission.

John Ogness
