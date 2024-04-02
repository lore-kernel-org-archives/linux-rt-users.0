Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663079B8A
	for <linux-rt-users@vger.kernel.org>; Tue,  2 Apr 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064192; cv=none; b=UTE9l2GUKTi3ALy+bCmUa94/06CHM7/WC++FTP39sjzdAyhYxDuUjB+XYknB/jWprUf5j9HrfQ42fPxA/zSMgM4U+fPzHtzeTHUNtKVhGAmitYZ9+VkOce6ZN5uZ1cCR2FoXjV+Y2Mh0b3VYZdEdSuiXtanLgtySATpT2bU6SaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064192; c=relaxed/simple;
	bh=aYvO4dnXrd9W7YLJVmL1y1aAk1DV08YQFtWl2GKE3/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PzOBYLFxoJqRGcMM87HWG+r2BmK9mzt5V/HwJwmrKwOi0SLsGmlgiXVVNuCs0p7K4yFccGpnNefvIuOM9QOPitD9kP5dHs5VcJb9ke02rr/eUctTp0UUC/UDqSom+LiYnFED7RYbXpJbyEv0Jw0CcpVMYkrj9ll2fnw6++4h2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4eqsF6wR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A0ArCW9b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4eqsF6wR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A0ArCW9b"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712064189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYvO4dnXrd9W7YLJVmL1y1aAk1DV08YQFtWl2GKE3/0=;
	b=4eqsF6wRjdc2EaxMvRcjQL+IHnCqphbEIFOWZwQe1zCFIqMJYli3Z7yvc8KHlx8B1HpPcw
	/vg3foLZQxfZY3xZMegZGnEvzDNM8KD3kwXp9NraODcBB3nDCCWK6aFogiJj8nQ+L0y6d4
	YBIpl7R6Fx4L26arcwLKlELEBO5sw5BfE0ytxIufLz5niZaA1JmY9TxfVNP4srmJPWKwJF
	vgXCrPJU+yRMN5CzW5wrNuPLHv2Fs5wHO+BxFSuPuGJGCFXb+jfgOrH9lBHuWtC6Ok4VwD
	U8by959VXt4WR4U+HlkNOzXJnIMC5hwreuRWhP1ZLx00F5s+qsAwc4BZm0lF3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712064189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYvO4dnXrd9W7YLJVmL1y1aAk1DV08YQFtWl2GKE3/0=;
	b=A0ArCW9br+lf+zfkeCDvA8i0NfvljVbfiTSVklM7SP0KcJhRd0unQxjoHs82sseuMiF7VZ
	fPqiftrfbtwZDfAg==
To: Esben Haabendal <esben@geanix.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-rt-users@vger.kernel.org, Martin =?utf-8?Q?Hundeb=C3=B8ll?=
 <martin@geanix.com>
Subject: Re: [PATCH 1/2] printk: export pr_flush()
In-Reply-To: <87jzlgf1w2.fsf@geanix.com>
References: <d65ca57567e245aa99a944cefc195f2bc6974384.1712051763.git.esben@geanix.com>
 <874jckqcxu.fsf@jogness.linutronix.de> <87jzlgf1w2.fsf@geanix.com>
Date: Tue, 02 Apr 2024 15:29:06 +0206
Message-ID: <87wmpfq4p1.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-04-02, Esben Haabendal <esben@geanix.com> wrote:
>> printk() tries to print directly from the calling context. Are you
>> experiencing problems where you do not see the restarting message?
>
> Yes, that is exactly what we are seing.
>
> It is an i.MX8MP system, and console is attached to ttymxc1
> (drivers/tty/serial/imx.c).
>
> Booting up, and simply executing "reboot" command. Without these two
> patches, the "reboot: Restarting system" message is not written to
> ttymxc1 console. With the patches, it is.

This console driver is using the legacy console interface. For
PREEMPT_RT, legacy consoles run exclusively as a thread and thus may not
have a chance to flush messages before a shutdown/reboot. The correct
solution is to port the driver to the new nbcon console interface.

John Ogness
