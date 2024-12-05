Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743A1AB517;
	Thu,  5 Dec 2024 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385983; cv=none; b=GD+dxH6JJ/z8joLVqjLOm0HG53pq6hIsqP6r+v4CZ2oAN1eKCGD81SbSwEahf1NKpgIU8xOIcyvJEaziBCHaZPkf/8O+bmEGMFs9l2SSyNJbSckqVjznvDA1vyOTg4bsD5hiM7TzaXvrC+R+9bqjI7WA8QMWh1EpKIbiEuv3/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385983; c=relaxed/simple;
	bh=r0wP7qtB8URx3RVoQGA+/3/H1v+F966PLwqFXxAdweI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVdoIc/ZVDsJkOqJPlbyJWMAYTUKqiVwSEYsdDOcrWonNmoh2QfK+hpHV/t6mhgn0xsYwcxghUI1oOR4qOcHmXBRuL9+M0LVgEY4bidrNfR1zDqLg7f29r/lEpBymW/jHfk5sh2Yc6lIzPTEnwhPqDs8s5YOd6NqHLDur6ypwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dfjx5Yrh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJednpoY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dfjx5Yrh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJednpoY"
Date: Thu, 5 Dec 2024 09:06:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733385976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCazH0VmB7UgSvWMFArA5ZBz50oQvuUH5JGqjVT/xlw=;
	b=Dfjx5Yrhj0FQw8F2cpM/tc3DIBWT07KJAIoLh6Bz60KFMKxyzQfhIXk2d3ddxW7GSxrxHE
	M1lfvMdhdoWUAEYhArAktKFyZWpuKnjPllaFFGjFx3hAHk+WMdg5cvY3ZFIL4KbKmiVhce
	ac4trUVlfcF+mQ7GWDgF1abEVMx/STaCW7Utem10KLbztwDPc+bXQNqNxe9F1RsCO/aZjf
	CobL/B6w3O9ElV6OVsxopfaMK0GkHX/O6VvJa+aCzKFbWfuXsfCw+G9aBf4NdnN+3DIr4J
	tkHkq2DSO8m+CSQEaMG4IQi81AtkReEJ1PTOEauUuZMVQf/+dxzBCpzsdB0lzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733385976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCazH0VmB7UgSvWMFArA5ZBz50oQvuUH5JGqjVT/xlw=;
	b=OJednpoYD+PY3Mm79DnYxXOzXutEU7mn+KK00m23KJfYun0FRpst1muLITnvTVIVz3ploz
	QEBhlQOrbVky9XAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: EnDe Tan <ende.tan@starfivetech.com>, stable-rt@vger.kernel.org,
	Clark Williams <williams@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	"endeneer@gmail.com" <endeneer@gmail.com>
Subject: Re: RE: [RT,1/1] tty/serial/sifive: Make the locking RT aware
Message-ID: <20241205080614.y_512eFh@linutronix.de>
References: <20241203094009.67697-1-ende.tan@starfivetech.com>
 <20241203103611._nfkyEXJ@linutronix.de>
 <NTZPR01MB10187B77E803325E8C88F383F837A@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <NTZPR01MB10187B77E803325E8C88F383F837A@NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn>

On 2024-12-04 15:24:38 [+0000], EnDe Tan wrote:
> > -----Original Message-----
> > You need to state which kernel this needs to be applied to.
> > The change you looking for is
> > 	32c694ec3efc2 ("serial: sifive: Use uart_prepare_sysrq_char() to
> > handle sysrq.")
> 
> Thanks for pointing this out, I overlooked the commit in the mainline kernel.
> BTW, the commit is not in v6.6.63-rt46-rebase. 

Indeed. Clark, could you please backport
	32c694ec3efc2 serial: sifive: Use uart_prepare_sysrq_char() to handle sysrq.

for v6.6-RT?

Sebastian
