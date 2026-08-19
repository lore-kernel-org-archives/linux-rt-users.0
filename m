Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5747B42F;
	Wed, 19 Aug 2026 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151978; cv=none; b=F6kte+eaPj5YXu8bpb6J07lbsEgOJfSSnXggjN/9Q/ONIvocQabrjwJZqUHU0PpLRoecbT8lyOGefIGlkFDkCdxcSz8+Ka63gBHYhhOFJgn8vySPq0+CaY3lTKnD6SglBE6KS0+GsA/2XFHB2CGEqZUQq6S23NZGznWxYVy3pZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151978; c=relaxed/simple;
	bh=PYnYBPFh488OMrSekS787vgFxrdT53ki3zlpK1c28EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VujJ4mQ5NO6u08VkNTL3Gyy4VvyYgb+UQDsixMT2D+NUOLSDma+BIUDoOSaBiNRbQxYnLrnyaua1yLGBXuFHAQYowZHE+rMJqY0fjG4nLmuI85g+PmDOVhoy2A6bK4ROAlXymy7giLa2dz9MBcA7AT/29Cl5EJSQ+TlduixGwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vc/cLOiH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SoonRtoK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vc/cLOiH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SoonRtoK"
Date: Wed, 19 Aug 2026 17:06:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787151972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hIHIO3L/iVx2Wjl3NYNyAoTXNNROo4v4ePBeHe5Jgg=;
	b=Vc/cLOiHgZe8tYSeMrFcyoV8v9Bgzm+2efKsiYrNkaWA4un9OHTfpPVSHKgvaRA1GIGmgD
	QW4kY19FnLi0zo9b/BNFECQtYgdubbjw5soDvm9MyiU9nbW2VSqzqXGdnvW+HxYO52NDjJ
	kAReisCbZvx+U4nXfFV/O7aIGtgDgJRRyt/TM3yzbqSmRkIfEEbIWwofbZ0PHVcQm5i1dP
	Bfl2UC0TMGfTh6SaKhAS9WtHW31yEQvzMydjIcUedv2hL6a8ad45b7snJSjc/Kb5C/EQ61
	KL3Vn/ptWEzCmawGKzAQKATjIh+/izXDiVdCsV7QHdFpk5WSX6pJle8/WCHeXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787151972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hIHIO3L/iVx2Wjl3NYNyAoTXNNROo4v4ePBeHe5Jgg=;
	b=SoonRtoKA7rYx12RTVEnn9zaHk3/9QQERU4e2pU6VVsgGKTOBVJUGm6BtQw5pgzuELg2/C
	bOmijE48UiGjkiDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mike Schanne <mschanne@kns.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	"chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>,
	Todd Leitzel <tleitzel@kns.com>
Subject: Re: [PATCH] uio: eliminate extraneous irq thread under
 CONFIG_PREEMPT_RT
Message-ID: <20260819150611.xWELTqJ-@linutronix.de>
References: <TY0PR0101MB48672132B8525B7B39565EE4D2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY0PR0101MB48672132B8525B7B39565EE4D2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com>

Chris, what was the use case to split this?

On 2026-08-19 15:01:00 [+0000], Mike Schanne wrote:
> Commit f8a27dfa4b82d442af1c0645a5acc70cc97c67f6 ("uio: use threaded
> interrupts") makes all uio interrupts threaded by default.  However
> under CONFIG_PREEMPT_RT, all interrupts are already threaded.  This
> results in 2 irq threads per uio instance, adding an unnecessary
> extra context switch per interrupt.
> 
> Do not request a threaded interrupt for uio under CONFIG_PREEMPT_RT
> 
> Signed-off-by: Michael Schanne mschanne@kns.com<mailto:mschanne@kns.com>
> ---
> drivers/uio/uio.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 004a549c6..4e28777ac 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -448,8 +448,12 @@ static irqreturn_t uio_interrupt_handler(int irq, void *dev_id)
>                irqreturn_t ret;
>                 ret = idev->info->handler(irq, idev->info);
> -              if (ret == IRQ_HANDLED)
> -                              ret = IRQ_WAKE_THREAD;
> +             if (ret == IRQ_HANDLED) {
> +                             if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +                                             uio_event_notify(idev->info);
> +                             else
> +                                             ret = IRQ_WAKE_THREAD;
> +             }
>                 return ret;
> }
> @@ -1038,8 +1042,13 @@ int __uio_register_device(struct module *owner,
>                                 * FDs at the time of unregister and therefore may not be
>                                 * freed until they are released.
>                                 */
> -                              ret = request_threaded_irq(info->irq, uio_interrupt_handler, uio_interrupt_thread,
> -                                                                                 info->irq_flags, info->name, idev);
> +                             if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +                                             ret = request_irq(info->irq, uio_interrupt_handler,
> +                                                             info->irq_flags, info->name, idev);
> +                             } else {
> +                                             ret = request_threaded_irq(info->irq, uio_interrupt_handler, uio_interrupt_thread,
> +                                                             info->irq_flags, info->name, idev);
> +                             }
>                                if (ret) {
>                                                info->uio_dev = NULL;
>                                                goto err_request_irq;

Sebastian
