Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9415F41B;
	Mon, 26 Aug 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724695235; cv=none; b=fvoxpYI7pAVtYUJlcSXYdmSzH1cyRSBgP7Sgv75SZRnLrlFw/cQBoWsUTrBWfBVPrhE0i4PtmXwMEOH8GwWIMT2UsybJPXhfM+Z+KkAVSifCy3Ud4q9HsxVmNefi46QFHrGHGwPM7IRDS+uSdrBdJ/6nGaY5Vl3zJ7RbkQluodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724695235; c=relaxed/simple;
	bh=G9y0cnu6WaX8lCNmJVUZ1SNi426o9h/MNjtqmUcLGC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ktCKQL/c5X0TNd8dO+ln4Mz4ja1uBXq9ubTo8nPOEblPMjAKJvnQbsKAHHfPZHUWl2TdTGNbnrJD33njM3qn1AkJ3MFqkbYezMHYI8RwBwS9RtPIpbtuiyO1bXNN+DulYafbCLuqkLrGpE8Tti0xvsvAfvXQKXOIm4h2JRNqHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0lTchuZ3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8+BgpRi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0lTchuZ3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8+BgpRi"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724695231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9y0cnu6WaX8lCNmJVUZ1SNi426o9h/MNjtqmUcLGC8=;
	b=0lTchuZ3RmWfLT/OIweKq33x7naoyHnsqQ8AvtbDPge6nTR7QEwhWqmVQDRfkLZisnYlsH
	GVgmnbMqDb9TnOA7pWE8UL+VEZjDzIIWd+DxN1CkwjJjwf10gCVvE6eynyGMje1DmKDfPj
	ibVUeDp4ztzhaJCD+cfA5U5Oyx3I5VWLrwxXGvh1ogbXGcOa3A73L+L99aK2s/DVMWTg4S
	Bv8dWSvikO98VvKmqiL2XZGbIsI7XIUNLd3slv7Hbf8NjQzlTZdTOhtteQ0nbcas3+oM8P
	gdLhijkrPH3/PQcOQHzCojp5KnIyznATnn5pqRNDLF6DKSViKAkDTUzKfiDg/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724695231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9y0cnu6WaX8lCNmJVUZ1SNi426o9h/MNjtqmUcLGC8=;
	b=Q8+BgpRi7dwHICpOAVlmyvIoxDAivAMJ0CwoQSNP2Y3EEtAAlZ+5m3H+YaaxeqzeJ6LV+Q
	JY3sRPdXIJye/JCA==
To: debarbos@redhat.com
Cc: Petr Mladek <pmladek@suse.com>, pmaldek@suse.com, williams@redhat.com,
 tglx@linutronix.de, linux-rt-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: test 1: was: Re: A Comparison of printk between upstream and
 linux-rt-devel
In-Reply-To: <Zsy12a7DQqu7h4zp@debarbos-thinkpadt14sgen2i.remote.csb>
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZshiIdUFQs4CKW2t@pathway.suse.cz>
 <Zsjd0WUNIU8_kprt@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZsyK-s2D8eqqBrXU@pathway.suse.cz>
 <ZsyVXMqM2SK0aYyV@debarbos-thinkpadt14sgen2i.remote.csb>
 <Zsyafduo2UItzLAK@pathway.suse.cz> <871q2b8bou.fsf@jogness.linutronix.de>
 <Zsy12a7DQqu7h4zp@debarbos-thinkpadt14sgen2i.remote.csb>
Date: Mon, 26 Aug 2024 20:06:31 +0206
Message-ID: <87wmk36u68.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-26, Derek Barbosa <debarbos@redhat.com> wrote:
> This is not running in QEMU. I installed & booted this kernel directly.
> Considering that this produced a vmcore, I could try my hand at doing a crash
> analysis (with some pointers).

That would be nice. It would be interesting to see if the trace is in
the ringbuffer. If not, it probably means the system is hanging in the
console driver while trying to print out the messages synchronously.

> Do you think running this kernel in QEMU would behave any differently
> than it is now?

Until now, I have never needed bare metal to debug/fix printk issues for
serial. This is because the 8250 UART is so simple and QEMU emulation of
it is good enough.

Of course, this is one (of many) reasons why I am very grateful that you
are running all these tests on bare metal! Thanks for this!

_If_ the problems are reproducible using QEMU/KVM, it would be really
easy to dig deeper. Even if it is just to confirm, "Oh yeah, we know
about that problem... not fixable with legacy printing." But sometimes
we see that it is an easily fixable problem to at least help improve the
reliability of legacy printing.

John
