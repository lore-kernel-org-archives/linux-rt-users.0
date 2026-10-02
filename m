Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB52F0661
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Oct 2026 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975234; cv=none; b=EWLJr5HBdYhemLTAj5JfHJ0LzuSlR8woqbuxCj06aK5E1N9hhYCr/6qnmX3TjP1W03777cDIaVEaMViXBZ2Z2oqe5tuHpsDLpfpDw+nMiRRK/6XA5Uto3kBFxwAJw8z3Q2ZY1pVVBsGZ8voMD3YQM+OBX1qh8wU0jgqcC/4ruzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975234; c=relaxed/simple;
	bh=VDC9aRg0jeBGpu6G1XZmnWMI79TFaHJ9Gm8N+w1gyeo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6Cs6hhkuGEGzmTCf/pSxit5Wj+WJiecGmW2tsqdgfk5gc62YzLx+ysoOers3VeASFcbg7eL+QV7RIKR6HtGbennAZP4h3IH0choxL20W941CAhAIMaEy2vA544gWEf6DIe73/DVnMFRbqkqV3U5nYgiA47/1nrYhoQlEfX8cq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGijSxgA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGijSxgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790975231;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=oGuUlGuDrC0eUC/ehVlJiFgSP6+ElG6Xg6mp28vvlgI=;
	b=eGijSxgA3haX9bKgq/RAg9bgYlSkXxBh5VCuBKIJjwLZgbD0R2jCwsIEPAUvLP9eMKCIj4
	eCRXUD4IuR1/1zJNTJmAlfe2dmh/y0MDqlvMvDq0TyuKtQqtDUr5ZX/V05CGHhnSPrbw8W
	fUuUFL1tA0Mg/YBrP2OM5nmXNUkV68M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-mLuQSmN4Mz6yd2K15NfTCg-1; Fri,
 02 Oct 2026 17:07:07 -0400
X-MC-Unique: mLuQSmN4Mz6yd2K15NfTCg-1
X-Mimecast-MFC-AGG-ID: mLuQSmN4Mz6yd2K15NfTCg_1790975226
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3EE91831352;
	Fri,  2 Oct 2026 21:07:06 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48D521956042;
	Fri,  2 Oct 2026 21:07:06 +0000 (UTC)
Date: Fri, 2 Oct 2026 17:07:05 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, williams@redhat.com, 
	vkuznets@redhat.com, linux-rt-users@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: Console Hang on SMP Secondary CPU Bringup
Message-ID: <asAZ1B8gBzMXIBeE@debarbos-thinkpadt14gen5.rmtusma.csb>
Reply-To: debarbos@redhat.com
References: <arPmYPbFLf2EldIl@debarbos-thinkpadt14gen5.rmtusma.csb>
 <87fqytbhmx.fsf@jogness.linutronix.de>
 <arrIDCkT56aFzCdK@debarbos-thinkpadt14gen5.rmtusma.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arrIDCkT56aFzCdK@debarbos-thinkpadt14gen5.rmtusma.csb>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi John,

On Mon, Sep 28, 2026 at 04:17:51PM -0400, Derek Barbosa wrote:
> Hi John,
> 
> On Mon, Sep 28, 2026 at 04:06:22PM +0206, John Ogness wrote:
> > Hi Derek,
> > 
> > On 2026-09-23, Derek Barbosa <debarbos@redhat.com> wrote:
> > > It appears as though the behavior in question has been bisected to af3a8162581e
> > > ("serial: 8250: Switch to nbcon console")
> > 
> > Since you are hacking up the code anyway, here a few things you could
> > try.
> > 
> > First off, it might be helpful to enable CONFIG_PRINTK_CALLER. This will
> > print the CPU-ID that the printk message originated from.
> > 
> > To be sure it is timing related due to the nbcon atomic printing, you
> > could try short-circuiting:
> > 
> > 	drivers/tty/serial/8250/8250_port.c:serial8250_console_write_atomic()
> > 
> > so that it immediately does
> > 
> > 	return true;
> > 

I will be running more trials of the reproducer to confirm, but so far, we still
hang. I wasn't able to extract some traces, hopefully will be able to soon...

> > Obviously you will not see any kernel messages on boot, but the machine
> > should boot and with dmesg you should still see all the messages.
> > 
> > Assuming that boots, you could change the short-circuit in
> > serial8250_console_write_atomic() to simulate the timing with:
> > 
> > 	mdelay(7);
> > 	return true;
> > 
> > If it fails to boot, then we at least know it has nothing to do with the
> > 8250 and is instead either delays in time-sensitive sections or some
> > sort of contention bug in the core nbcon code.

I haven't had the time to try the second one yet.

FWIW, Clark suggested it may be worth setting keep_bootcon in the commandline.

He also suspects if the hang is really just that we missed an IPI ack from the
Hyper-V code and now the whole stack is wedged, with the kernel still running.

I'm off to LPC, so I will be radio silent for another day or two while I have
these spin on the Azure VMs.


Cheers,
-- 
Derek <debarbos@redhat.com>

