Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C4D44606A;
	Thu, 20 Aug 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235147; cv=none; b=SLOeYdWmLZJIr9aRIK6F/OXeKnD8/LL4hOt7byyZF7p62KMzfNMi5dy1lY58HqgZzcNecjR1ArBIDYMmTwABJT0Kwxa9t0jqnxaMK3Geqfd4QH8DujtZVzW2w+TiaZKPUjSK5tlbQM3/b2zdazoHrY4QUnbc5AnQrYxBeHixQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235147; c=relaxed/simple;
	bh=nkaWwfH2TgTiQTk/ull6KOBEtpCvhxzg5a5rhtUyLnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocu0brmd2WRzsB9sr1R/kAMwntsxCyeW6ELekcL826yQXlxUmlrxU7EAEDED7ji+cKQzTT6dHWAErpmCZLzz3XJgB1uygJUywcPNOT4R30lXdThnXwVneoi7R2kSZvV6qQUnw0vyVypEr9OPpBLQA2dhyIb7b4FOrBM7panSvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cSLjwcoS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+z2dQbwT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cSLjwcoS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+z2dQbwT"
Date: Thu, 20 Aug 2026 16:12:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787235144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wauzBqHP4ewpgIG3F0G8gR1bxAgMn9637fSuYktnReE=;
	b=cSLjwcoS4aULYTKH+WQEpoq7y+EJBTu9lfBV4F7hjbYssiQ2HPLFEame5je7jnpbYrLLHE
	qMJQxrulSmiR+mwTr8IfCA6eZNDzb6toPqgMXv7QArcjectAdQo2UNx7ZK+oHWFl2CBJ/0
	V+LIp9BHgGYZt5/WA+cxi63Pv6F4C2xyddsrHwfryJ9AyMYQSXFSUx/MafD2fmzZAKLm/4
	rpG4/+cKglk/qXBDTppPu5JgvS8OGwZEEiz4S+wtjdUxwfOT0esEalLhShFaJeECf6o+hd
	x/nHwoda+zgnfamKSL+AOZvAQJbVICHR3hY611X1NALxCKuoOyLiYj2sIOfUew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787235144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wauzBqHP4ewpgIG3F0G8gR1bxAgMn9637fSuYktnReE=;
	b=+z2dQbwTV9vw6Ko2sos6vlT6/YAQZOzqcQAN+JLNC+8I3LQdtYRLkD65Cxa6ptU9ajqQy9
	LiHpQhCwrgTnTkDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Mike Schanne <mschanne@kns.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Todd Leitzel <tleitzel@kns.com>
Subject: Re: [PATCH] uio: eliminate extraneous irq thread under
 CONFIG_PREEMPT_RT
Message-ID: <20260820141222.gPkfKLpT@linutronix.de>
References: <TY0PR0101MB48672132B8525B7B39565EE4D2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com>
 <20260819150611.xWELTqJ-@linutronix.de>
 <5943e7e5-9578-42a1-b693-d79f9eef88f0@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5943e7e5-9578-42a1-b693-d79f9eef88f0@alliedtelesis.co.nz>

On 2026-08-19 20:48:51 [+0000], Chris Packham wrote:
> Hi Sebastian,
Hi Chris,

> On 20/08/2026 03:06, Sebastian Andrzej Siewior wrote:
> > Chris, what was the use case to split this?
> 
> I was dealing with having a UIO interrupt for an input on a PCA9539. 
> There's some more info on the original email thread[1] but basically 
> because the PCA9539 inputs are nested __setup_irq() enforces that anyone 
> requesting them does so with a threaded interrupt.
> 
> https://lore.kernel.org/all/20240408234050.2056374-3-chris.packham@alliedtelesis.co.nz/

so you wrote:

|    Prior to this the UIO registration fails with:
|    
|      [    6.484699] uio_pdrv_genirq detect-gpio-9: unable to register uio device
|      [    6.484722] uio_pdrv_genirq detect-gpio-9: probe with driver uio_pdrv_genirq failed with error -22
|    
|    The -EINVAL ultimately comes from __setup_irq() where it knows the
|    interrupt descriptor is nested but we haven't provided a thread_fn.

So we talk about this piece of kernel/irq/manage.c:

|         /*
|          * Check whether the interrupt nests into another interrupt
|          * thread.
|          */
|         nested = irq_settings_is_nested_thread(desc);
|         if (nested) {
|                 if (!new->thread_fn) {
|                         ret = -EINVAL;
|                         goto out_mput;
|                 }
|                 /*
|                  * Replace the primary handler which was provided from
|                  * the driver for non nested interrupt handling by the
|                  * dummy function which warns when called.
|                  */
|                 new->handler = irq_nested_primary_handler;
|         } else {

If so, you realize that uio_interrupt_handler() isn't called at all?

Sebastian
