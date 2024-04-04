Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA080C16
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Apr 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228679; cv=none; b=pZJW0MUFvJ49vb+WJJ2GZ4C8G0bL36Yt1cZ1ikAgX2oWCj6DNwsHrIZCZOjRoW2D8PhXXBQ+D+uUzRWq4DOvDiSX8oh2D555VR7w0i96Wo9UjevrIVI3AqrK0eNG3p3wkC+33tpKFy1CZaLmetC2LHpd/jHei+2zj/w9Anv/UOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228679; c=relaxed/simple;
	bh=oIIf0vikWPrRRdkh04loeQilB8kvWLR/p7Owygrcnyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UwSQ/M1TnzOqXlyQmC40zlUd+LRFJc9rWJC+qDg+9bjBs+sfkt+23HCC1yBN1hluD/juCLkX0CkuVtD+QBLGFcx+Ki8j8ZtMdX5epLNCBxOaOl4UAGPgpSQkvVW/599sq7NV7ECHZco33Qokxy6HlwpFowuGrMGrpR8qHnekHYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=s0wZ/ctj; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="s0wZ/ctj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oIIf0vikWPrRRdkh04loeQilB8kvWLR/p7Owygrcnyg=; b=s0wZ/ctjO1gvPhnCMLVzLs8lUp
	tg7TtkjqyvwtambMoHpXLcj28KlYB8VkRkMkE680akgkantQZcnxtitgjGF/aKfYzxpibVMmV78Bg
	ImzYBoSKLPqMBzl0yH8EV04UNxE2JfYRsB2NYd8Ne7Rsp5ACgDGL69y0gT2kzGrNpuDV50vQQjigZ
	m2fHvUfU+wXH1IBmqTDIYfxAMiG4B0TfrWydxBp/ImpRevvUxliQhPTwTHm3QHezwvSWAvtrp46hS
	8aNj9cKgFOm/wPCAXE4Jv2rjX8K9B0QJXfltIDCSfmWUHx7g03Of4YAoozg3Gh1kOsd63shoN/dNy
	2AxRYnfA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rsKtQ-000Cg7-AI; Thu, 04 Apr 2024 13:04:28 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rsKtQ-000OGS-2T;
	Thu, 04 Apr 2024 13:04:28 +0200
From: Esben Haabendal <esben@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-rt-users@vger.kernel.org,  John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH 1/2] serial: imx: Avoid busy polling for transmitter
 to become empty
In-Reply-To: <20240404-wobbling-cyclic-90880ac17562-mkl@pengutronix.de> (Marc
	Kleine-Budde's message of "Thu, 4 Apr 2024 10:15:17 +0200")
References: <cover.1712156846.git.esben@geanix.com>
	<9895c8f9553523d158f47a9718bd24f22dbe0455.1712156846.git.esben@geanix.com>
	<20240404-wobbling-cyclic-90880ac17562-mkl@pengutronix.de>
Date: Thu, 04 Apr 2024 13:04:27 +0200
Message-ID: <87bk6pl77o.fsf@geanix.com>
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

> On 03.04.2024 17:22:52, Esben Haabendal wrote:
>> Busy polling with readl() is a rather harsh way to wait for a potentially
>> long time.
>
> This read_poll_timeout_atomic() is compiled to an
> imx_uart_readl()/udelay()/cpu_relax() loop. Does the introduction of
> udelay() bring any advantages?

Good point. Probably not. I can set sleep_us 0 to go back to a tight
loop.

>> While there, introduce a 10 ms timeout on this waiting, similar to what
>> many other serial drivers do.
>
> But you don't handle the return value...

True. But this is similar to all the different wait_for_xmitr()
functions, which does basically the same. They are all void, so the
timeout is handled in same happy-go-lucky style.

I think the best we could do would be to show an error message. But
maybe that is not the most sane thing to do to report a problem with
writing error messages. I don't know, but maybe that is why most the
other serial drivers are handling it like this.

In fsl_lpuart.c and uartlite.c a warning message is printed if/when this
timeout occurs. I am fine with doing that here as well...

On a related note. I am unsure if 10 ms is a good choice for timeout. I
picked it because it seems like a common value used in many/most
drivers. But at least some drivers use something like 1 s, which to me
sounds more sane given that we cannot do any meaningful error handling
on timeout.

/Esben
