Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A0F9D6;
	Tue, 28 May 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910178; cv=none; b=HjktMQjI/Ol+8yLcLgDNALhoLftbcPxGMXtPyOFa31VNbJjY2AJPLQLrhTa/t3kOZZfJT7QSuUBZn8mkLMs+iDRwCmXvgy7f8l6jU+4Jz91g1Psds5dBqZGeheLJrvGTGN5vbPT0zsKnipjRQvIzH3K6kV1B+9pwqOgld5YbtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910178; c=relaxed/simple;
	bh=jzJP3Fky911b4ocDJ+GsZFP6sKcE5qUte5Ird8Aqs/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLYi6m6Re+KwX84o+bXiTJ3lTlp3m8p+sA3akSYGY7IpQRLbTMAAWwW5ioKGR7WCnKjDRKa/49jsXEtySvBHizfZ6Fp8SRUUtSFolig3bEIrfo4d7h+SVMXlLifi0Ca5C53LDf7wUv1xUwiUzHYRzeCY4DX8191lKkyuU3QO9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQUyxnjF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TDb2w276; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQUyxnjF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TDb2w276"
Date: Tue, 28 May 2024 17:29:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716910175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzJP3Fky911b4ocDJ+GsZFP6sKcE5qUte5Ird8Aqs/c=;
	b=uQUyxnjFCNLiC9Nmmmpwg0CdlFlgRSl7Xe2SlFEc1Eg2R0W3I9cg2/ovi37RbpyD1OXTOo
	+sqlCUOBHib1wnRvJt7hNoOWlteMOpJWu+xZJUOHeDOsmnWfoYsMuBDhocQ4a8Am0gfq8u
	X2Vp4CQb4raPvF4uG7WGalZOz8+SjzT/VY/kLA6pyHFigtzcwoysojAXBv/N/zxoNL5Nuo
	08WAEsIeX9MO6caBCYfoYIGh5ZnpmMi5OXaD3iQuK10V0jeM3rOw/tWS+y5M5QHHVFNfFR
	imDUSdsA6p8GKKe7m74CL1cmIj/w2ua56sve4g6hhQpZQUOW7TBwb7gt9J79MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716910175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzJP3Fky911b4ocDJ+GsZFP6sKcE5qUte5Ird8Aqs/c=;
	b=TDb2w276k5wtugCN3y9ZjixxCEkl6mN0W41sdzaCqEEOdbuLCIdD1tc0JJOqNRSrUkpaQ9
	r6zIh5Rowuvau3DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: xu xin <xu.xin.sc@gmail.com>
Cc: xu.xin16@zte.com.cn, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	liu.chun2@zte.com.cn, rostedt@goodmis.org, si.hao@zte.com.cn,
	yang.yang29@zte.com.cn, zhang.yunkai@zte.com.cn
Subject: Re: [PATCH  5.10-rt] printk: ignore that console preempted by
 irq/softirq
Message-ID: <20240528152933.ns7uyFSD@linutronix.de>
References: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>
 <20240528064003.776618-1-xu.xin16@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240528064003.776618-1-xu.xin16@zte.com.cn>

On 2024-05-28 06:40:03 [+0000], xu xin wrote:
> > This does not apply.
> > There is `may_sleep' set earlier.
> >=20
> > There is no console_lock() around for each=E2=80=A6
> >=20
>=20
> Sorry, I don't get it.
>=20
> To clarify it again, this patch aims to solve the useless waiting of pr_f=
lush
> when the console is preempted by the current irq/softirq. This has nothin=
g to
> do with might_sleep().

There is a `may_sleep` variable set earlier. Couldn't that be re-used?

> > The other question is which kernel started enforcing might_sleep() for
> > pr_flush(). This should be applied to all kernel or none so we don't
> > have random behaviour across kernels (5.4 yes, 5.10 no, 5.15 yes).
> >
>=20
> Sorry, my understanding is that pr_flush didn't start enforcing might_sle=
ep().
> This patch can apply to 5.10 and 5.15 where the problem exist.

Starting with v6.1-RT there is a might_sleep() at the beginning of
pr_flush(). This means that atomic context can not be used anymore.
Therefore is patch needs only to be applied to 5.10 and 5.15 as you
said. I just didn't see the information the following kernels (>=3D6.1)
already had that might_sleep() check and the previous (<5.4) lack
pr_flush().

> > This is a delay of max 1 sec during bug() and panic(). Not sure how
> > "critical" this is=E2=80=A6
>=20
> In some industrial control scenarios, bugs and warnings containning a
> pr_flush delay of 1 sec is very critical to the upper services.
>=20
> Especiall for watchdog timeout(< 2s), just WARN can easily lead to system=
 reset,
> which is unacceptible.

Now this would be important piece of information for the changelog in
terms of _why_ we do this.
You don't have an atomic console, do you? Because if this BUG/ WARNING is
printed via the atomic console then it could also raise your 1sec limit.

Sebastian
