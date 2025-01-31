Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C21B4145
	for <linux-rt-users@vger.kernel.org>; Fri, 31 Jan 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738328493; cv=none; b=nJEEp/DmIqr16g2TuzSuKPHJBESx2Kxk6q7i3NPFs15ucjopy5Jo+ZIoDI0u4O77xEFXXChcHwDwhBxjPKOM6AeorhCZoT0FlPrJnhZVSLt1u7sYQyydGTGwWaAEuRIphOCxqYlLjv/ST+xWmj2TZIRixx+o/qIqYYGaU4zu3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738328493; c=relaxed/simple;
	bh=K05+FfcXiTgru81MiFZpfQN3Qmjb01549pLl5qOilRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgdOnyStYN4+yu2Yei5Sjz0u0LFrEMfLCct59kx3KukF1+j8aJkinedPu7dsv0s1kAg+ALuWDq6h3G/tKcgYgBYTAfjJSFfAerHnBtmWnSGdo0sIfvh2CCqSYilvdWX+1PrDIxC4WLIqWDENkoLJkyap3BxDI9M3cKt3r5PhJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogW376Ot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+VBU29Fe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogW376Ot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+VBU29Fe"
Date: Fri, 31 Jan 2025 14:01:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738328489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FpIS03Kcu0WaCYercWW5W2erQDKgW0WWXjbGBP14ZXM=;
	b=ogW376OtADTA+CfwvwVNNgI0AMY/nMba6NuF0IjVYmaPT2fUPTpAH5V9JwI95aXvaw5x/V
	TaVbt/BMtf9F/Y5E55D2PWxqmpfppv6rP2ZTQfRBFX/IqTifxMxqAPW95C+6CZt1RUUkca
	dniEZ0q39ubNsnY3KVTddv3p24h3DpTWRaZe8zz39Dv6sEAXozGlF1liqzXo7iGZPa7jT4
	I/gdTOHOXgIrRjuA7IHus/tqioxtO7RICQWkwO27/yXtE0ZN1wmccydb9SSaNMZP5RmMGY
	a9nulYpuczaoRpxM2wFwlc9KLqEynmW9PNxFQ8ofOdh1WDXfn+xI++2M7WGNCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738328489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FpIS03Kcu0WaCYercWW5W2erQDKgW0WWXjbGBP14ZXM=;
	b=+VBU29FekkvNmcN9qUctkm5QsQAJueNKitIeg0FzH+foZa4JMm75/hHc5d80StRZv8LoXO
	Uo+Aqp1pbwjDbYDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yann Collette <ycollette.nospam@free.fr>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Build error with gcc 15.0 and kernel rt 5.10.233.rt125
Message-ID: <20250131130127.GrbskvsW@linutronix.de>
References: <79dc829d-8a6b-4d8d-8084-8527ec438c51@free.fr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79dc829d-8a6b-4d8d-8084-8527ec438c51@free.fr>

On 2025-01-31 07:33:17 [+0100], Yann Collette wrote:
> Hello,
> 
> I met a build error while building the kernel rt 5.10.233-rt125 on Fedora
> rawhide with gcc-15.0.1.
> It looks like gcc-15.0.1 switched to C23.

This should help
	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ee2ab467bddfb2d7f68d996dbab94d7b88f8eaf7

But I would wait until it gets to the v5.10.X series. This is not an
RT-only problem.

Sebastian
