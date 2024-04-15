Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AACF59B7E
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Apr 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176913; cv=none; b=gZEkvHsCzJr6k37viM7WR/Gx0HsjDN9JAWjnkTtZDMj4b84lG6aUZsubzDQzygRubFC7n/rWRsXWExYqSdDmL2SXibAHFVjIqJUWpLWVRJnZ2vKsgREJ90XwZWNyn8gaPCGYV4ZSl1achxhHxw2wx+ZLezlOufjzXpWgFkk0DmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176913; c=relaxed/simple;
	bh=kqj818GxnNbxKvgMfHqSvbEhsxn5sNWv9WOxPnmpmjI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UtmjWOJ/FDcxFEu86x7jsdNVVh29xVD5vOgG7gsAJtbHEdX8wlRwCBQGuNTrpDXZtssrrmU7ksAEamcd6rQtYChd3It9noSNHEMnU2hkQwKvYZNB7t2aiAyuFh1CEqiZOXdw7MT3DDo4FF1Me0+8waFAFO2Y8n0BOr/j4+rinpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BCbDl84o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+WaLiAL/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BCbDl84o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+WaLiAL/"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713176906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uauNNRHKgc+9v1c7y330VqpgzdF2i0+OOltuvK2bBRM=;
	b=BCbDl84oVrl4o+E6OKJ3SVRmT0qxmISABjNKYKoGudRxkyUs9A9cjO5Ug6gK5PNefW2wlF
	cWBxCTQtbj4pF6OA8eGZeEHL5/WyIl2Qz83U46OBqB53OXB7YFJ6z5h/z15f4iZqAKKtfp
	nw2ALFAK+Ykt1E5d7WF3Cn/WfqYAha4Kio4EsvrnZK85X7hVaUzCbaqg3fYcXQFlyLBTOq
	cUs0m7eDv4J8Yjujxak0P/rsTfgbon2PP54jWcdhEwmoZOljDQvQaQXalEiVm1PrqxvEpg
	OJN4nAgFzplWXiIeHc8WydPN8EfllbMOUE+FALhk+ePHcKFIvqpfqMqyVtfK2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713176906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uauNNRHKgc+9v1c7y330VqpgzdF2i0+OOltuvK2bBRM=;
	b=+WaLiAL/3Z2o+DiFkgPzz/2mRFLzFWOOugJTHvodZuLPfVWO4C2O01XFMBPh/vE9D7JJiy
	i0epNmHWiIlFO8Dw==
To: Esben Haabendal <esben@geanix.com>, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] serial: imx: Switch to nbcon console
In-Reply-To: <2bc0b5d3f99184d8ddbf860666513f9fa7760af8.1712303358.git.esben@geanix.com>
References: <cover.1712303358.git.esben@geanix.com>
 <2bc0b5d3f99184d8ddbf860666513f9fa7760af8.1712303358.git.esben@geanix.com>
Date: Mon, 15 Apr 2024 12:34:24 +0206
Message-ID: <87edb6gbsn.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Esben,

You are correct that there is considerable copy/paste from the 8250
driver. Hopefully having another nbcon driver will help us find a way to
cleanly consolidate that logic. Thanks for your work on this.

Comments from me below...

On 2024-04-05, Esben Haabendal <esben@geanix.com> wrote:
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index f7e4f38f08f3..2a49880c2651 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> +static bool imx_uart_console_write_atomic(struct console *co,
> +					  struct nbcon_write_context *wctxt)
> +{
> +	struct imx_port *sport = imx_uart_ports[co->index];
> +	struct uart_port *port = &sport->port;
> +	struct imx_port_ucrs old_ucr;
> +	unsigned int ucr1, usr2;
> +
> +	if (!nbcon_enter_unsafe(wctxt))
> +		return false;
> +
> +	/*
> +	 *	First, save UCR1/2/3 and then disable interrupts
> +	 */
> +	imx_uart_ucrs_save(sport, &old_ucr);
> +	ucr1 = old_ucr.ucr1;
> +
> +	if (imx_uart_is_imx1(sport))
> +		ucr1 |= IMX1_UCR1_UARTCLKEN;
> +	ucr1 |= UCR1_UARTEN;
> +	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN);
> +
> +	imx_uart_writel(sport, ucr1, UCR1);
> +
> +	imx_uart_writel(sport, old_ucr.ucr2 | UCR2_TXEN, UCR2);
> +
> +	if (sport->console_newline_needed)
> +		uart_console_write(port, "\n", 1, imx_uart_console_putchar);
> +	uart_console_write(port, wctxt->outbuf, wctxt->len,
> +			   imx_uart_console_putchar);
> +
> +	/*
> +	 *	Finally, wait for transmitter to become empty
> +	 *	and restore UCR1/2/3
> +	 */
> +	read_poll_timeout_atomic(imx_uart_readl, usr2, usr2 & USR2_TXDC,
> +				 0, 1000000, false, sport, USR2);
> +	imx_uart_ucrs_restore(sport, &old_ucr);
> +
> +	/* Success if no handover/takeover. */
> +	return nbcon_exit_unsafe(wctxt);
> +}

In your imx_uart_console_write_atomic() I see lots of register usage:

ucr1, ucr2, ucr3, usr2, uts

It is critical that _all_ usage of these registers throughout the driver
is protected, preferably protected by the port lock. Please go through
and verify that. If imx_uart_console_write_thread() is using even more
registers, you will need to check those as well.

For the 8250 I went through all uses and found several problems [0]. The
imx driver may have similar issues.

John Ogness

[0] https://lore.kernel.org/lkml/20230525093159.223817-1-john.ogness@linutronix.de
