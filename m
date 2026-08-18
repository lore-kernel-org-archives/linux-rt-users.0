Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA346F485
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056342; cv=none; b=tlqQomXYjNjOrAryGsGeVlrV158rtTAm0h4Ie4wkB5wNgAB4/d31dhHkFtgxLo9QbKwRH4aNyB373Rs3gt/Q77yD789Q5kqZ05KA9c8mjyBOtT1nz15OPRLV3jZPYv/jjIm5qhsJdNWqFyd/q7MF39CGTb5rRx/wIkyWLXpAeHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056342; c=relaxed/simple;
	bh=QQsqADjG0Jg9kfF0BIFh0b4JrL5tkLli1o2/bQmgxuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u95R/dHy/ZMC/FssZckj6K5N2D35PvfaNv802KxGg7gYaoTBynM9TFPCqRc0b4yQkpV5LgXOsGbmhucJbTH+Ptj9yBcHfRNlg8m1tS5CJwij4UZlSG/7NLWGCsGy+LxG/XcmpwpcXtSbKomBYTtZutz2rYzNH91uXZ/xQ7sGgjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HSUxynP1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmkgWnEQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HSUxynP1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmkgWnEQ"
Date: Tue, 18 Aug 2026 14:32:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787056337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/DfYOSyCZR2mJEe81YzZfHCpRgYblZqsQVFQV3FdHA=;
	b=HSUxynP1DC48E+uk9zr0jdOYaxQB9fnsVlfJUANLFJ4C2jZ2vxn38muozWOpvHUU5bmo2O
	XkjxH0LhI1OcIsfOobDfkvg+Yy28SijOTc8iYmD5Xt7DFRu5erAdI3aaGi6zGn6cUxdSLV
	vN/wMKvzg4CPK66E5ah0jNi28FDK821H8DzzZWo0Mv8eQTjkaxLN6wy03y2DD/iBOxyg1q
	0MEGTCAqL0yFgaYp9Chcld3nd1pAg3KauCbupEP+xBq3/1xDBOm4m8cFQ3gXPeUMD2iv2l
	fYcHafFagTf4Ms8it5muP9RbVj8Olw72wgKksJw233gw2zYMWKfKUcBkcApb3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787056337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/DfYOSyCZR2mJEe81YzZfHCpRgYblZqsQVFQV3FdHA=;
	b=qmkgWnEQaRQv7uNaWNt34tXKEdS+wuBG9bCcZ1hMfS3Bi8D02P5IaRv4eSbkbBh7qBFZX5
	hDvcyKIi2K4zqkAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v2] cyclictest, cyclicdeadline: Exit with failure when
 breaktrace threshold is exceeded
Message-ID: <20260818123215.M5aHgJrQ@linutronix.de>
References: <20260806120732.1371118-1-costa.shul@redhat.com>
 <20260814090801.lZ8dlRaB@linutronix.de>
 <CADDUTFz8mfM1upYo9qPbUpNvZ0LOrTZx2f0sG1Unz1=qwQb7rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADDUTFz8mfM1upYo9qPbUpNvZ0LOrTZx2f0sG1Unz1=qwQb7rA@mail.gmail.com>

On 2026-08-18 14:06:10 [+0300], Costa Shulyupin wrote:
> On Fri, 14 Aug 2026 at 12:08, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > Why not pick a dedicated exit code value for this scenario and document
> > it as such and use it for this purpose only.
> 
> In standalone RTLA we use:
> 1    Error: invalid argument
> 2    Failed: the test hit the stop tracing condition
> 
> However, returning 2 here would be inconsistent with oslat from this
> project, which returns 1 on test failure via err_quit.
> What do you suggest?

Pick a number and document it. Make it unique. I don't like that there
is an exit code that could be a failure of some sorts and the "trace
abort condition hit" at once.

> Thanks,
> Costa

Sebastian
