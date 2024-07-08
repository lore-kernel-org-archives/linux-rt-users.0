Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA40137923
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Jul 2024 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447168; cv=none; b=DFzyxMRXN7fNvh0ECbdT4h6ybrIuqXYImQ/E6EdpbUQLQ1iU05y/OWI7ksxwc5uT5TbQVafZBTUF3uzPRWM2uJzzQdmKRA6WPUwh6yukdvcs4Js00M8HURN//gjXerDJPRZBAYOPnRo151gD3X2TqGcI2LpRIowNS/7AqrN5Xbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447168; c=relaxed/simple;
	bh=yi7JrulTN0Mbojt/7Njkznq3vcn6UXspr/8evVclDcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS07IFbZ3O+PAiFBgPa0BlAvlHjfofTnjAVaINwpA6o87DJxpJw6asL0sT7VfXKkECh6FMw7ZxD7gvxiHBs/MHjKJTMIEgQGFkd5/1m906LEb5KreX5p9Bkm7ebic3+Cy9nBKDwHTRsUWSmRWSgeuu8ZilLvdBZMikafWhChxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6NLMNc4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GYEM1loJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6NLMNc4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GYEM1loJ"
Date: Mon, 8 Jul 2024 15:59:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720447165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0p0oY4+IRpHa68HyuomDL7Nc3c2doREH/MU6nP007g=;
	b=a6NLMNc43tDMgznS4oVcwvaIHbwsCJh85JMZhE+8usprfLeLukAkKm2l1/fYPjUcVWFJRZ
	r0SyrPakjrqWLqnMAQIt0J6XWATA176RdnjXjo8PcWy0T5QjLwUa782AGNr9iQKPoFK8Jy
	ECDyqqfhiKLWqjIrIP/4CrFF8x/l2K38LfTkw07/2ClAAYP2vnHxW5dWzfpWFTQLszZm7B
	nRFl8wZDLyyOv0KF2QsZa+xvmwVHLkDwSJITzDqdWin6qlFKIM/6tYleKeDzl219efaV6R
	wnmdWsfmM8nzyyiim0C0x45hopHmwXsAPGOrjyFTvcJUGYiDCQsR4q89NsfwSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720447165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0p0oY4+IRpHa68HyuomDL7Nc3c2doREH/MU6nP007g=;
	b=GYEM1loJ9xSiWcJKcQiIcr0gF7t87K4D10nbVLNoneFzJpqVV8U1k8UAH3q4xsPsz2ITdP
	IQCLjYS3jZ+/FuBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: miaon <miaon@neusoft.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual
 address 00000034
Message-ID: <20240708135924.X6_1i-lw@linutronix.de>
References: <000201dab6f2$b0a25360$11e6fa20$@neusoft.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <000201dab6f2$b0a25360$11e6fa20$@neusoft.com>

On 2024-06-05 10:47:16 [+0800], miaon wrote:
> Hello linux-rt,
Hi,

> This has a null pointer bug.
=E2=80=A6
>=20
> Can you help confirm the reason?
> Thanks!

no, but we could start with

|[    1.884903] BUG: sleeping function called from invalid context at kerne=
l/locking/rtmutex.c:974
|[    1.884907] in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper=
/0
|[    1.884911] 6 locks held by swapper/0/1:
|[    1.884914]  #0:  (&dev->mutex){....}, at: [<        (ptrval)>] __drive=
r_attach+0x64/0x118
|[    1.884940]  #1:  (&dev->mutex){....}, at: [<        (ptrval)>] __drive=
r_attach+0x70/0x118
|[    1.884955]  #2:  (&desc->request_mutex){+.+.}, at: [<        (ptrval)>=
] __setup_irq+0xdc/0x7f8
|[    1.884974]  #3:  (&irq_desc_lock_class){....}, at: [<        (ptrval)>=
] __setup_irq+0x100/0x7f8
|[    1.884988]  #4:  (rcu_read_lock){....}, at: [<        (ptrval)>] rt_sp=
in_lock+0x0/0xf0
|[    1.885005]  #5:  (&picinfo->lock){....}, at: [<        (ptrval)>] tcc_=
pic_set_polarity+0x8c/0x158
|[    1.885023] irq event stamp: 288040
|[    1.885028] hardirqs last  enabled at (288039): [<        (ptrval)>] _r=
aw_spin_unlock_irqrestore+0x5c/0x98
|[    1.885033] hardirqs last disabled at (288040): [<        (ptrval)>] _r=
aw_spin_lock_irqsave+0x24/0xb0
|[    1.885040] softirqs last  enabled at (0): [<        (ptrval)>] copy_pr=
ocess.isra.9.part.10+0x430/0x1978
|[    1.885044] softirqs last disabled at (0): [<          (null)>]        =
   (null)
|[    1.885046] Preemption disabled at:
|[    1.885052] [<        (ptrval)>] __setup_irq+0x100/0x7f8
|[    1.885061] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.202-tcc #1
|[    1.885064] Hardware name: Telechips TCC8031 Evaluation Board (DT)
|[    1.885067] Call trace:
|[    1.885073]  dump_backtrace+0x0/0x1d8
|[    1.885078]  show_stack+0x14/0x20
|[    1.885084]  dump_stack+0xb8/0xf0
|[    1.885089]  ___might_sleep+0x178/0x210
|[    1.885093]  rt_spin_lock+0xa4/0xf0
|[    1.885098]  tcc_pic_set_polarity+0x8c/0x158
|[    1.885103]  tcc_irq_set_polarity+0x20/0x30
|[    1.885112]  gic_set_type+0x84/0x98
|[    1.885117]  __irq_set_trigger+0x5c/0x1e0

this is out-of-tree. The lock used in tcc_pic_set_polarity() should be
raw_spinlock_t. This makes the warning go away.

Sebastian
