Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6C3054D7
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Nov 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871764; cv=none; b=npjZmuusVEVfWaEr2skpuDRQihfm1aUxNLkhLWcXxoEiOUsoa3FBrSJYFpQuBJ+O4YXrcpXy9sbI1lmcA1A6wj51IZNKLyVtxejBRBfPZajlLbH1C0djSRaGkdS3JlnQRh37Pv48zbHMlN7klDr6wjpJ1o/CLpsiCEyeeW5Ejq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871764; c=relaxed/simple;
	bh=RN1K27+o24KSab9xVKwcxlnIycEtGI6/UsxC0jvylvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqjEdhIvUxMlFkEgvILMjkcf3XNEKGBmKJJ+kDO++DuDMli/KwE0Xlv3gulmMXtu4XvM3J8tGswDIy7mX3vit8/BokFBSeii3Cm/hoEV07Fi3I4K5bjF2/lSqgzhY3/0q3JZh6DNfGNTl7NT+nrQwMj0QNuknu5lI/jptxVP/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l3+1e1ts; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f5kmFr9d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l3+1e1ts";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5kmFr9d"
Date: Tue, 11 Nov 2025 15:35:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762871760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44RAM5TE43Yehva8M0RWwdEEPdA9vsxjSEEBfnLjR4U=;
	b=l3+1e1tsWkPP44yzW9lSZEjiQuQXjnUIvDUFtuHZpPsPhEnLCoIvl/gjSQcqdXzUwklUUH
	2iAuu+I3eGJhuf2ITNH4dhtVQZwff+0Pr4/t/95Wo76UABFZKLW2+KskL6mVmdwz8fUnZ5
	Xe8Zs91SEZNIqqaN8+PC+FJsQWyze7sWrlrR/OcuBZGdH19z0EV5opYWsD7lvo+5C8kOry
	2a7EeTqGZ9Xz1jLeoPw258yxtNKQQyieytd594wd9TuFn1dM538xPQXS7sxTZU/ObcTGcn
	d25vMO1kPB5RPC/eljQaT1BU8OxQNNqiIlh0Xt3hBefOKXj823Kf/6WgRCPihg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762871760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44RAM5TE43Yehva8M0RWwdEEPdA9vsxjSEEBfnLjR4U=;
	b=f5kmFr9dQLg3Ln+1ex46zlv0hzdi2OHy3JOWAj+N90Cgqmm+xhOvXW9itd92l3v0wxG76b
	KYIpDtlWaA+/2EDQ==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: "Preclik, Tobias" <tobias.preclik@siemens.com>
Cc: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: Control of IRQ Affinities from Userspace
Message-ID: <20251111143559.ZjXzPpIL@linutronix.de>
References: <a0cad8314124ca98d7c6763e3e08d7192598cf92.camel@siemens.com>
 <20251103155322.Aw9MSNYv@linutronix.de>
 <3cbc0cf5301350d87c03b7ceb646a3d7c549167b.camel@siemens.com>
 <6523960abaff2054ed25bf57b2a12e381f305a3e.camel@siemens.com>
 <d07f30064dd7eed0b4fc337485fdb0bda4f69064.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d07f30064dd7eed0b4fc337485fdb0bda4f69064.camel@siemens.com>

On 2025-11-05 13:18:16 [+0000], Preclik, Tobias wrote:
> The conclusion got lost:
> 
> Other drivers like for example igb respect the interrupt affinities
> (both default and per-irq affinities). This leads me to believe that
> the irq rebalancing in the drivers should only affect the effective
> interrupt affinities. This admittedly is more involved than it appears
> at first because the interface interrupts would have to be balanced
> subject to multiple (potentially totally different) cpusets.

Exactly. Maybe it would work to align the driver with what igb does.

> Tobias

Sebastian
