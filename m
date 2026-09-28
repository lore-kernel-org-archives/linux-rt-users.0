Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B474D6C55
	for <linux-rt-users@vger.kernel.org>; Mon, 28 Sep 2026 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604028; cv=none; b=f50t6cAChbza4u7QeaSFOlETSbgd5Zg0PJoAretFOSnZ4SoMyBnl35jmrSxBAkwnhWswA2bZe7Nmad495O8fJAVDQe8N+lS2q6Fyi91V7OnISU25AeELKyHWNBQLjcD4hDJ4iJVxetRo8XFDJB0cMaJBr7SNK3d1qu4sORjKyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604028; c=relaxed/simple;
	bh=78CVplWbF/uryaNvL8KJRi1HHLwkE25f/AtJi9u8y5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gL4sJrtAEqK7Iaw5fc33EOs8sHVPw9XFag7Wfmh55LwceGC7rz4VqI7B0XXbJCnHta4B7NYjMipbpN0SpyEQKFglfKM4fGZrxvcS+oKqiygL3qblS4zp2DkzucWeYOGUtmfhq53krvmUSDnm/1XkvWJhT0IgR+ik20b3g055Y3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iXfnszcc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HfnZrXmz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iXfnszcc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HfnZrXmz"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790604023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4gLg0vGLCkwGjesQa3VAhiCTT1fNqMhO59IeH76iTc=;
	b=iXfnszccLLCSknyglLmFr9SD4UR4rLfouodf92qkNUML6rL3wcE4x8eh8JqNh0B4jCq99X
	a8ZG1ePOWX9AnBSD5/5Y8QouwNT53lGawL/POEYqdGPEaWB778yCQjAdWiyYkhlPwXKSLc
	nE4EXeK2BYAQcNWPH8Lf2UDkMfAuh/OgcZqvCmgtUXfeKBi3E5BaOgfMO/hz9YL2AARQkR
	9SnrIXM197bXWOKcvD2By/P2zotI5e6PiKBMBDR3FV11xcJvJc8c0f85vOdwA12CFdVAmM
	f2ykVruIhsr4/tmKFoL4SBYZqB3DlaZLy8g3XKTizZx8ZjSBD9Gz+lWs8A/0lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790604023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4gLg0vGLCkwGjesQa3VAhiCTT1fNqMhO59IeH76iTc=;
	b=HfnZrXmzUyMq9K4ZKXwl5SJknwiYIWcXYZNjxQrI4IT3R9ytUC0I356NQyxQCbTFelaGut
	k26cbXitOPDtKfAw==
To: debarbos@redhat.com, williams@redhat.com
Cc: williams@redhat.com, vkuznets@redhat.com,
 linux-rt-users@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: Console Hang on SMP Secondary CPU Bringup
In-Reply-To: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
References: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
Date: Mon, 28 Sep 2026 16:06:22 +0206
Message-ID: <87fqytbhmx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Derek,

On 2026-09-23, Derek Barbosa <debarbos@redhat.com> wrote:
> It appears as though the behavior in question has been bisected to af3a8162581e
> ("serial: 8250: Switch to nbcon console")

Since you are hacking up the code anyway, here a few things you could
try.

First off, it might be helpful to enable CONFIG_PRINTK_CALLER. This will
print the CPU-ID that the printk message originated from.

To be sure it is timing related due to the nbcon atomic printing, you
could try short-circuiting:

	drivers/tty/serial/8250/8250_port.c:serial8250_console_write_atomic()

so that it immediately does

	return true;

Obviously you will not see any kernel messages on boot, but the machine
should boot and with dmesg you should still see all the messages.

Assuming that boots, you could change the short-circuit in
serial8250_console_write_atomic() to simulate the timing with:

	mdelay(7);
	return true;

If it fails to boot, then we at least know it has nothing to do with the
8250 and is instead either delays in time-sensitive sections or some
sort of contention bug in the core nbcon code.

> <snip>
> 	while (!nbcon_enter_unsafe(wctxt))
> 		nbcon_reacquire(wctxt);
>
> 	/* Finally, wait for transmitter to become empty and restore IER. */
> 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
> 	if (em485) {
> 		mdelay(port->rs485.delay_rts_after_send);
> 		if (em485->tx_stopped)
> 			up->rs485_stop_tx(up);
> 	}
> 	serial_port_out(port, UART_IER, ier);
> </snip>
>
> Is it possible that we just spin here?

That loop means that the console has lost ownership. A console can only
lose ownership if a WARN or panic were to occur at that moment. I assume
you have neither.

With QEMU it is easy to attach gdb and dump the kernel logs using the
gdb scripts. I don't know if Hyper-V has anything like this. But it
could help if there is one more printk message you are not seeing. When
printk() is called, it locklessly inserts the message and then tries to
print it to the console.

John Ogness
