Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6B59B7F
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Apr 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231667; cv=none; b=Al3+IGO9njiQ45LeWuHXQWlMA2LYdVYUVSjsiNBuwWUCnHUycS9QOCAcJzsAu7x1uoDOJ7KZbMLSLB8ejPQCSOOiOyNF3EVAblQi7BEHiL1A2vdA3+tQTqCFdLBv7q3FvUYAKxtO4bMa+smxsqEFfXFgPKN57+Dk2XuxK+iUBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231667; c=relaxed/simple;
	bh=JSy9pBHL8tOwduv09FD5GfZoBypXkX8ebWt8NNZYdCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=US7cOUYW+juLPFshJ63PHyb++ujSehkHY0S0wiNlRvXiY1zkDENjPBiZyHv69gHGezKTBRDAnLy0Fqiuaw3qc7iR5MbMbGfdeA4kSuyE8gTXOs9ipUdgFQ8uzdGd4GDcLg6lbsxmknkHpwiqRdZJWoNnMFoCkTRaFx2+vFq6T2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mwQ2e6IC; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mwQ2e6IC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0Kz1W7UvAteslxVz7P706XUl5mVRWhCWrOTNK8RjOPc=; b=mwQ2e6ICgU/OTWTP81BvJUCQWj
	ieq3InH47n6loQ7rdyqwll6bBJki0CLWOqTIYPj3NDDnT1ZtP5OK2QV16seWwCrc1p6rnksEqYg5p
	DPs1s0jFE/mU2Dr0aM/Nm0fScNz0wcFkevX+TJ8LuVa5NEqy+dwK6o0NToQoHPIfFP8ooBB7wkvjj
	rVCJ6UmmTB3NmGh/j0yfQg3g1q+Q1XAR4fiyqWK2qjx+wZQOydPiwi9A6VOVH4FdR9+20Qq8VUnUJ
	nbmRn0Iq7DlaN2Z3lH7G9VnW2DcrhHhAY7On+AVhxEENXAWPME4qk+X2V8016lN+IzpjOd0HUzOxI
	xMIgBIEQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rsLfi-000Ljr-QY; Thu, 04 Apr 2024 13:54:22 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rsLfj-000BjQ-0y;
	Thu, 04 Apr 2024 13:54:22 +0200
From: Esben Haabendal <esben@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-rt-users@vger.kernel.org,  John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH 1/2] serial: imx: Avoid busy polling for transmitter
 to become empty
In-Reply-To: <20240404-preseason-varied-75427e223409-mkl@pengutronix.de> (Marc
	Kleine-Budde's message of "Thu, 4 Apr 2024 13:33:53 +0200")
References: <cover.1712156846.git.esben@geanix.com>
	<9895c8f9553523d158f47a9718bd24f22dbe0455.1712156846.git.esben@geanix.com>
	<20240404-wobbling-cyclic-90880ac17562-mkl@pengutronix.de>
	<87bk6pl77o.fsf@geanix.com>
	<20240404-preseason-varied-75427e223409-mkl@pengutronix.de>
Date: Thu, 04 Apr 2024 13:54:22 +0200
Message-ID: <877chdl4wh.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27235/Thu Apr  4 10:24:59 2024)

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 04.04.2024 13:04:27, Esben Haabendal wrote:
>> Marc Kleine-Budde <mkl@pengutronix.de> writes:
>> 
>> > On 03.04.2024 17:22:52, Esben Haabendal wrote:
>> >> Busy polling with readl() is a rather harsh way to wait for a potentially
>> >> long time.
>> >
>> > This read_poll_timeout_atomic() is compiled to an
>> > imx_uart_readl()/udelay()/cpu_relax() loop. Does the introduction of
>> > udelay() bring any advantages?
>> 
>> Good point. Probably not. I can set sleep_us 0 to go back to a tight
>> loop.
>
> Sounds good

I will do that for v2 then.

>> >> While there, introduce a 10 ms timeout on this waiting, similar to what
>> >> many other serial drivers do.
>> >
>> > But you don't handle the return value...
>> 
>> True. But this is similar to all the different wait_for_xmitr()
>> functions, which does basically the same. They are all void, so the
>> timeout is handled in same happy-go-lucky style.
>
> IMHO the patch description should mention that the driver now ignores
> the state of the transmitter after the timeout.

Ok. Will do.

>> I think the best we could do would be to show an error message. But
>> maybe that is not the most sane thing to do to report a problem with
>> writing error messages. I don't know, but maybe that is why most the
>> other serial drivers are handling it like this.
>
> Writing an error message within the console driver could lead to a
> positive feedback loop :)

Yes, probably best to just silently ignore it.

>> In fsl_lpuart.c and uartlite.c a warning message is printed if/when this
>> timeout occurs. I am fine with doing that here as well...
>> 
>> On a related note. I am unsure if 10 ms is a good choice for timeout. I
>> picked it because it seems like a common value used in many/most
>> drivers. But at least some drivers use something like 1 s, which to me
>> sounds more sane given that we cannot do any meaningful error handling
>> on timeout.
>
> Not having any experience with console drivers, I think the time to
> empty the FIFO depends on the size of the TX FIFO and the speed of the
> UART.
>
> With some numbers (FIFO size and UART speed) pulled out of thin air (and
> neglecting start/stop/parity bits):
>
>     32 bytes * 8 bit/byte / 9600 bit/s = 26.7ms

I assume that typical console usage will have messages much larger than
32 bytes. But on the other hand, most use cases will be 115200 bit/s.

But in general, I would be more comofortable with a 1 second timeout. It
should be more than large enough to handle all realistic cases. But
will avoid spinning forever if uart for some reason does never clear the
TXD bit.

/Esben
