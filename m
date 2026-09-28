Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD839184A
	for <linux-rt-users@vger.kernel.org>; Mon, 28 Sep 2026 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626691; cv=none; b=qgLalX+s5EJQT8hgoPdWgKx2gsXktpSyTcLq7h/pUdKuamt0uODWfb0j42tUKDPCSi5gShN9ZlnGqPockw1fUVtKlVkUy1vuC8lZtWOnyVsXlOrXzbNHZF1yrUfayMFq6NQV1gJ1GkCjoIA8lhHA6RHYrjTZnqS5qbWD1ExtRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626691; c=relaxed/simple;
	bh=JFGTh0V1iR/SZ79++8PZhtdf1ADoR0p0ekW3ZQ+FqTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1YbIMlw7fIatnaGShvVRAB+oXc7p1Np1915qfNcetkKjE/lEYaokKOytVDHXLLyuSjKNaKLBDcZKUfiv1o9OYyNoTw7fZRZTrxCG8g+c9OGGvkagFBZZ0lilmbw/+eMA3SYwLJndtmHuDtmzFGXziBBLZyW6gHSP+TgQJpEklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnxTlnr6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnxTlnr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790626688;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=O9rR9hiI1DIy9iqOcBLGols7qSSqw9xXtjqhEoE3Nw8=;
	b=bnxTlnr6HUz1JsSJ4tBsZLyWznIedRBCr2SNzTG188xXZMxoE4cVEjPHGN+jS+N9MON4Dp
	gyJ1iWd2Ek6IbTRXnzt1vCi8/Xg7JlaZXexxstm6xK/xe3FRc1bFqGol8RVjFlDX/ppoEB
	i94T99Ay6o9hOhASPuRD2erEORkR/Ls=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-gPu2SElxM7a-HZI9W1chYw-1; Mon,
 28 Sep 2026 16:18:03 -0400
X-MC-Unique: gPu2SElxM7a-HZI9W1chYw-1
X-Mimecast-MFC-AGG-ID: gPu2SElxM7a-HZI9W1chYw_1790626682
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EF571840C74;
	Mon, 28 Sep 2026 20:18:02 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 004C61956095;
	Mon, 28 Sep 2026 20:17:57 +0000 (UTC)
Date: Mon, 28 Sep 2026 16:17:51 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: williams@redhat.com, vkuznets@redhat.com, 
	linux-rt-users@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: Console Hang on SMP Secondary CPU Bringup
Message-ID: <arrIDCkT56aFzCdK@debarbos-thinkpadt14gen5.rmtusma.csb>
Reply-To: debarbos@redhat.com
References: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
 <87fqytbhmx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fqytbhmx.fsf@jogness.linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi John,

On Mon, Sep 28, 2026 at 04:06:22PM +0206, John Ogness wrote:
> Hi Derek,
> 
> On 2026-09-23, Derek Barbosa <debarbos@redhat.com> wrote:
> > It appears as though the behavior in question has been bisected to af3a8162581e
> > ("serial: 8250: Switch to nbcon console")
> 
> Since you are hacking up the code anyway, here a few things you could
> try.
> 
> First off, it might be helpful to enable CONFIG_PRINTK_CALLER. This will
> print the CPU-ID that the printk message originated from.
> 
> To be sure it is timing related due to the nbcon atomic printing, you
> could try short-circuiting:
> 
> 	drivers/tty/serial/8250/8250_port.c:serial8250_console_write_atomic()
> 
> so that it immediately does
> 
> 	return true;
> 
> Obviously you will not see any kernel messages on boot, but the machine
> should boot and with dmesg you should still see all the messages.
> 
> Assuming that boots, you could change the short-circuit in
> serial8250_console_write_atomic() to simulate the timing with:
> 
> 	mdelay(7);
> 	return true;
> 
> If it fails to boot, then we at least know it has nothing to do with the
> 8250 and is instead either delays in time-sensitive sections or some
> sort of contention bug in the core nbcon code.

Thanks for the suggestions. I will give them a spin and report back when I can.

> 
> > <snip>
> > 	while (!nbcon_enter_unsafe(wctxt))
> > 		nbcon_reacquire(wctxt);
> >
> > 	/* Finally, wait for transmitter to become empty and restore IER. */
> > 	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
> > 	if (em485) {
> > 		mdelay(port->rs485.delay_rts_after_send);
> > 		if (em485->tx_stopped)
> > 			up->rs485_stop_tx(up);
> > 	}
> > 	serial_port_out(port, UART_IER, ier);
> > </snip>
> >
> > Is it possible that we just spin here?
> 
> That loop means that the console has lost ownership. A console can only
> lose ownership if a WARN or panic were to occur at that moment. I assume
> you have neither.

Thanks for the note. It was frankly just a wild guess, I was only "reviewing"
the code that was introduced by that specific commit. I figured someone else
would be a lot better at pointing out my logic errors :)

> 
> With QEMU it is easy to attach gdb and dump the kernel logs using the
> gdb scripts. I don't know if Hyper-V has anything like this. But it
> could help if there is one more printk message you are not seeing. When
> printk() is called, it locklessly inserts the message and then tries to
> print it to the console.

I am not sure _what_ other debugging tools Azure has, frankly. From what I've
seen/can-see, there aren't nearly as many knobs and buttons as you would get
from just running plain-old-HyperV on a supported host as opposed to the
multi-tenant "cloud" platform interface. I will take note of this if I stumble
upon something similar by chance.

> 
> John Ogness
> 
-- 
Derek <debarbos@redhat.com>

