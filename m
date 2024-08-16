Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19684A50;
	Fri, 16 Aug 2024 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790791; cv=none; b=PcB4NQOn3i44T+NmQHMhsn3N2Q5FCGlWk0ovL9WqqwRUZmIPPybxiQUcpxPPvZdec66vOAby6yFQLLJrwfe/o14h6TaQzTFQsHF5MzT1o0rBdmEcotFVXo+ksbCV93/e/evvakzMH9ZV/elZ/6RUfvwwDPkRZf+ikF1YIhPRWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790791; c=relaxed/simple;
	bh=jqH3IPUBmlk5CJHZe/ya1Vn6jOlKhdXnk3bFhUvhBo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuXd5D7qxZaoxN6S/6OqLRAPle3LSjul19xElBX9NM/h7j/jzWI0KcBoDBObF1fB6XYtd+eIpLUqjwEP3LOTiP0jZq1pxtqzzgSGr1ZZx11t9TH/go7VLR+Y9mGVoXhqwOJThTMIh+69UL9naRdj7lekWLV2NlZQrNDT1axUGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NietzO0/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GYC2ZW7T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NietzO0/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GYC2ZW7T"
Date: Fri, 16 Aug 2024 08:46:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723790786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FinlM4uOgai3PNH++w4smqCDaI0kh8aZwxHAxnn1EyU=;
	b=NietzO0/JsBgCv8Y8wTr5ZMOayzLK0H8aGn7ZU5FQSwA0pM3FrgtiXZ2qeS+8+NLtuYpf5
	oAEJ175TFJKERSfmFd909hNuA7P70UFoOFIU8htFaoN0y2ElrfSI7F8JC92ebaThe7i7ip
	bvP+zo7SBJRgnAYuKuLV7gVEHIaI7uroc8KRF5KKbg9gbFSnOAnGaj4XUpTQTNMnI1RUoF
	dmuRb7NrD49wJFnKSvzvipJRSY7haQPmQIZb3wqO+sFTR15CCP15/0slLFM8n4au04yEhE
	QwgEjTFIlErEsvkSH386WqjdYnD2+DXJzyO6/0n4qO3KtMVkQPqn83I2XerKvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723790786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FinlM4uOgai3PNH++w4smqCDaI0kh8aZwxHAxnn1EyU=;
	b=GYC2ZW7TlvSoYxRTUQNZ4FEIdd7F0EudmfoKoZvlUR9eT2PJbOgVxH3nUhFTM0J4A3+umn
	GWD0L0VBVwlDZTBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [PATCH v5.10-rt] rt: dma: fix build issue in at_hdmac
Message-ID: <20240816064625.J6zQVz6r@linutronix.de>
References: <Zr6gH7SNsAD0LHWV@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Zr6gH7SNsAD0LHWV@uudg.org>

On 2024-08-15 21:41:03 [-0300], Luis Claudio R. Goncalves wrote:
> The functions atc_advance_work() and atc_issue_pending() both have a
> similar statement
>=20
>     return spin_unlock_irqrestore(&atchan->lock, flags);
>=20
> That results in the following errors during the build:
>=20
>     drivers/dma/at_hdmac.c: In function =E2=80=98atc_advance_work=E2=80=
=99:
>     ./include/linux/spinlock_rt.h:115:9: error: expected expression befor=
e =E2=80=98do=E2=80=99
>       115 |         do {                                            \
>           |         ^~
>     drivers/dma/at_hdmac.c:487:24: note: in expansion of macro =E2=80=98s=
pin_unlock_irqrestore=E2=80=99
>       487 |                 return spin_unlock_irqrestore(&atchan->lock, =
flags);
>           |                        ^~~~~~~~~~~~~~~~~~~~~~
>     ./include/linux/spinlock_rt.h:115:9: error: =E2=80=98return=E2=80=99 =
with a value, in function returning void [-Werror=3Dreturn-type]
>       115 |         do {                                            \
>           |         ^~
>     drivers/dma/at_hdmac.c:487:24: note: in expansion of macro =E2=80=98s=
pin_unlock_irqrestore=E2=80=99
>       487 |                 return spin_unlock_irqrestore(&atchan->lock, =
flags);
>           |                        ^~~~~~~~~~~~~~~~~~~~~~
>=20
> Fix this by splitting the spin_unlock_irqrestore() call and the return
> statement in both functions.

If I see this right, then this code has been replaced by commit
  ac803b56860f6 ("dmaengine: at_hdmac: Convert driver to use virt-dma")

which has been merged in v6.2-rc1. This has been introduced in commits
  fcd37565efdaf ("dmaengine: at_hdmac: Fix premature completion of desc in =
issue_pending")
     v6.1-rc5
  c6babed879fbe ("dmaengine: at_hdmac: Fix concurrency problems by removing=
 atc_complete_all()")
     v6.1-rc5

This means v6.1 is affected and the earlier version got it via the
stable queue.
This compiles here with and without RT on v6.1 with gcc version 14.2.0.
The question would, while it is bad in your case and I don't see. Also
if this is visible in your RT queue, it should be visible in the stable
queue without -RT, too. And then once all details known I would like a
patch that goes upstream and fixes the breakage at its root.

I don't see anything in v6.1.104. Unlike the recent RiscV fallout, this
is not RT specific.

Sebastian
