Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3212AAFD;
	Sun, 26 May 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716745593; cv=none; b=myGBl+wZfdaVZBff3rCItZn6n6e0cZ9owrWGwT8m40542dSpBUhU/Rl1uub/aHpb/9Ilmpl22YGoRpzgBukjPMhE28GxZ0rIA7lm6yizjxbRdOftbZRca18oodyzAc12Rvbt9DRDIGj2NirTAnbkYTPA8Kze2GCC55IRwZy1JkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716745593; c=relaxed/simple;
	bh=SG10spT8kOZLRGmi1O53yPmrdvIOBMWMHXHEKrgTTnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f595nnjI2oS9TUgdBVikMbcwxfmK6nkcC8qHKxCtGWwTnc28H/tbvh1bQ2rKafwpkIMxJ6KkVJVCXaz3Jv2vmSsslMlC13g77vl9BjPL0VfwSruBYifJuufEjGNeHPZ+S2uqyZHfjqOKDbMzPNtSwGOuObXhkiVYgpeVi2top18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M60/ROcx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QFH2Fv0y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M60/ROcx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QFH2Fv0y"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716745589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SG10spT8kOZLRGmi1O53yPmrdvIOBMWMHXHEKrgTTnE=;
	b=M60/ROcxn4rl8Wotg64E0mZPCpxX0MK4EmnjAkleTjUQzocN6qpymO4W+QuSGx2iPJHsll
	4yZwIdoKJWpzyeUJhT/1tQ2vfzM1AbmOydgeRcerTwMblIZseeYh8ENqwLOvwkuZumDO3V
	ER2pc+1FQXuEbvlLWyFdbXUpx+5/HJMeWJEQAkNv7ycK1oY1HvfD6Ju/QYsoLpVQOvsxRY
	/tMHS5545LI62ZzrTNDRCsUfwJ3Efj1X5zPZAXSCDd+RbmQL7jMoZrb4FWSGNbCDZm+JEa
	Rjno3f9KjrSck8yYHvrdkf3MDBFh7xt2LyL+c2ewRxOxgSqkCWzFi8hZnmODwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716745589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SG10spT8kOZLRGmi1O53yPmrdvIOBMWMHXHEKrgTTnE=;
	b=QFH2Fv0y1J4erbIu20WL0yTg0NNuCqpDNptQEbF+CCw+ec0WfcIzuv1rUUy4ouVdp2yaTA
	2R0MnMjNJgZYxSCg==
To: xu.xin16@zte.com.cn, bigeasy@linutronix.de, rostedt@goodmis.org
Cc: zhang.yunkai@zte.com.cn, yang.yang29@zte.com.cn, liu.chun2@zte.com.cn,
 si.hao@zte.com.cn, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, rostedt@goodmis.org, xu.xin16@zte.com.cn
Subject: Re: [PATCH  5.10-rt] printk: ignore that console preempted by
 irq/softirq
In-Reply-To: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>
References: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>
Date: Sun, 26 May 2024 19:52:04 +0206
Message-ID: <87ttiko49v.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-05-23, <xu.xin16@zte.com.cn> wrote:
> From: xu xin <xu.xin16@zte.com.cn>
>
> When we're in the unpreemptible context on the same cpu with which the
> thread of console locates on, we should ignore this console for
> pr_flush, because it's a vain and always lead to timeout until the console
> thread get cpu resource.

Newer RT kernels do things quite differently. But for the 5.10-rt
implementation, I can see how the 1 second timeout could be annoying.

> Fixes: e65be5f4dc3ed("printk: Update John Ogness' printk series")
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
> kernel/printk/printk.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 7f27cfee283e..faab85dd4439 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3735,6 +3735,14 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
> diff = 0;
>
> for_each_console(con) {
> + /*
> + * When we're in the unpreemptible context on the same cpu
> + * with which the thread of console locates on, we should
> + * ignore this console, because it's a vain.
> + */
> + if (!preemptible() && con->thread &&
> + task_cpu(con->thread) == smp_processor_id())
> + continue;
> if (!(con->flags & CON_ENABLED))
> continue;
> printk_seq = read_console_seq(con);

The code is OK, but you have lost the tab indenting. Perhaps these can
be added by the RT maintainer.

With the correct whitespace:

Reviewed-by: John Ogness <john.ogness@linutronix.de>
