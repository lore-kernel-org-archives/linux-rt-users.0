Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856D7E8;
	Wed, 12 Jun 2024 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202820; cv=none; b=dNN/XKphEWQG2GBNJ73WIxB7iC8coK9RdFgPi6/mMCQyZsPbxT1Ah3hfEVE5ius58Ni5v6deI5usaTPLZEWypW6UoqNBJ9V7vO3BYCZY3Q51SRrWUR6IeFZYDYgtLjMCZ8AhjzeZjaGv3/Jw6eVQlA76mAY78Y703Ir7ywKFLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202820; c=relaxed/simple;
	bh=lM0105xhUEJAZ0rF089XCyWZwmPEVyWloqojg7qhDH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JURq5uFpLKQO2EaHRpJtKUJx35SZmtXk23BG8/uAMez3riPmlgkOpM998mEAjoQLKDzaS0E0PQIiinDu9zBf3EhgcLGZhM3uJGMEcY5aiMh6WaQKUczWRwuOpfC1cHrwnBq8gqOY5P1ze4oIOUSQ+AKP0mKXUgZxwlRh9kP1Kac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mYxakUdv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QYdjqIRq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mYxakUdv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QYdjqIRq"
Date: Wed, 12 Jun 2024 16:33:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718202816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWd8QKQQ8IGdDR33Y2JGlmwXUNokIoZ++i3blHSZ1fs=;
	b=mYxakUdvyNrBCqpcRSjdX1A8dEKzpapsGp3U6FKoYvAGrwBpN+4UexO/2QaeQRzC73tLRA
	vG0FxyFHW00KmxcJGhzsqzxy/VpbM3KDhLjwbbmJJFaVfbPnndjbZR7hI6O9XCOLG1SwP4
	IALeemhBLWFhLKEquxK2oduCDGWDpYeWS6OgnJ+W4EyR1tpt4gepJWaFKweJG8SrF59o/M
	6Yuk9X0a2diAvkpE1dVEqxTnE+wcobDFz/JG5Bz01Fgj8A7x8NS6S0zvm4j87zlvtuV1Jy
	kV3DunhoAuHi2XGPeetgoBpf9ZjsqusWkitzTpJsdNC43G5TBT0TOA+OsnvooQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718202816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWd8QKQQ8IGdDR33Y2JGlmwXUNokIoZ++i3blHSZ1fs=;
	b=QYdjqIRq7U4BsCtlGvexKdRXtTSLhXFFuvIqQ+K/laOQrtllh+WdF7M5Cs5wpn7tmFQRpk
	vjlakbtYzjLxM+Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: xu xin <xu.xin.sc@gmail.com>, xu.xin16@zte.com.cn,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	liu.chun2@zte.com.cn, rostedt@goodmis.org, si.hao@zte.com.cn,
	yang.yang29@zte.com.cn, zhang.yunkai@zte.com.cn
Subject: Re: [PATCH  5.10-rt] printk: ignore that console preempted by
 irq/softirq
Message-ID: <20240612143335.1smVOgke@linutronix.de>
References: <20240523235537910_yxfGMbTcSOmMkcfuK2d8@zte.com.cn>
 <20240528064003.776618-1-xu.xin16@zte.com.cn>
 <20240528152933.ns7uyFSD@linutronix.de>
 <87cyoxeqh4.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyoxeqh4.fsf@jogness.linutronix.de>

On 2024-06-03 22:17:35 [+0206], John Ogness wrote:
> On 2024-05-28, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > There is a `may_sleep` variable set earlier. Couldn't that be re-used?
> 
> Since the printing thread cannot preempt the softirq context and since
> the printing threads are not started before @system_state is
> SYSTEM_RUNNING, using @may_sleep is OK.

will there be a repost?

> if (!may_sleep &&
>     con->thread &&
>     task_cpu(con->thread) == smp_processor_id()) {
> 	continue;
> }
> 
> John Ogness

Sebastian
