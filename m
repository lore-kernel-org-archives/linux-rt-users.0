Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E850390205
	for <linux-rt-users@vger.kernel.org>; Sat,  3 Oct 2026 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791055205; cv=none; b=mwis91npGSp5Pgf7a+jrOtAWp1vw4Ic6kVkb35fw/mKe/tAE6kwbMoJxJ7e/CYd3/B2EnF4r1c7lanJz+pHLZ8icyc5XeYTWCYNWh7nWW28fgBulK/7DtMaVQX7nPRVe2OozKCYk7UH4dYpAKCqPrSq3pUu/SnNM1grpg4Q3pS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791055205; c=relaxed/simple;
	bh=lQC/tzUXPUFWV7ATFp0IrLxd6rPKg89wd2TRwDOA5Xs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O/JZjhvXlFvwPoMRvFoI8lKzLKd7DZ32I02Mw9Km4b0BH74hlqpxi7fSQmQcelewQnxgzJWhRV0gHSgqIZqtcev0bWYkPwqAsdAYo4wnqbhR1JBh2Prh6b+TxFJRhV4apdXEhSrnTB9CMDk4vrWqpAKqyC2K0Mxhb4oFuRxmoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1GMvZdEf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z9RooACT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GMvZdEf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z9RooACT"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791055195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shRUBfjxsCqyUdcPcY0vYnPceFVTdw8WbE/8YyUhAGs=;
	b=1GMvZdEfgA/ABMPrhysmkU48H2yw03tDIYuv32m06lHuu6H9oKrEibtWv9Nzwlbiq+aW51
	Ep0PIO9c1WMLnZKlW5JG4aG+O4mXvdjKvst0y3Hz9zfWL6N/slqKCkUaeUncqnlKFpNBeg
	Ge5zxeVBk4IIZ2E/ZOB2+0XCy0pPsfGkK1nFtJ232cw9tSrXEc574pP4WPxSd9o20DJafA
	aqZaVAZkWMsnQHXc0CfbOPdedOhbSDioCmw6XW0m6lAKVmsS1P74aJKdM4t4A4CGVcT/C0
	dGw7mfmoH+KX1PRFJeolv+UTfIUToOIWtintT9pwHge7qvmPDyJIHR3ls7dLcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791055195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shRUBfjxsCqyUdcPcY0vYnPceFVTdw8WbE/8YyUhAGs=;
	b=Z9RooACTKIF/AAABPZVKVqEZaPiDR60YliIWHScSVdGaUy4ONrUv5TkcbvvsuAGCLzLcvf
	QOehPV75y7ceA8CQ==
To: debarbos@redhat.com, williams@redhat.com, vkuznets@redhat.com,
 linux-rt-users@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: Console Hang on SMP Secondary CPU Bringup
In-Reply-To: <asAZ1B8gBzMXIBeE@debarbos-thinkpadt14gen5.rmtusma.csb>
References: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
 <87fqytbhmx.fsf@jogness.linutronix.de>
 <arrIDCkT56aFzCdK@debarbos-thinkpadt14gen5.rmtusma.csb>
 <asAZ1B8gBzMXIBeE@debarbos-thinkpadt14gen5.rmtusma.csb>
Date: Sat, 03 Oct 2026 21:25:55 +0206
Message-ID: <87se2mlhgk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-02, Derek Barbosa <debarbos@redhat.com> wrote:
>> To be sure it is timing related due to the nbcon atomic printing, you
>> could try short-circuiting:
>> 
>> 	drivers/tty/serial/8250/8250_port.c:serial8250_console_write_atomic()
>> 
>> so that it immediately does
>> 
>> 	return true;
>> 
>
> I will be running more trials of the reproducer to confirm, but so
> far, we still hang. I wasn't able to extract some traces, hopefully
> will be able to soon...

That is surprising.

For the v6.6-rt you can manually add:

#define CONFIG_SERIAL_8250_LEGACY_CONSOLE

to drivers/tty/serial/8250/8250.h and this should cause the driver to
run in legacy mode. If you add this macro to 8250.h, does the hang go
away?

> FWIW, Clark suggested it may be worth setting keep_bootcon in the
> commandline.

If you use keep_bootcon, then the 8250 will operate in a special mode
that is compatible with the bootcons. It is not a solution, even if it
worked.

> I'm off to LPC, so I will be radio silent for another day or two while
> I have these spin on the Azure VMs.

Sebastian and I are also off to LPC, so we can continue the discussion
in person. :-)

John
