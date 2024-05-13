Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FA1FA1;
	Mon, 13 May 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715583581; cv=none; b=CspvTilzKHNuYkSjvjZA76i1V823wbR3/oWfibrm9Q2fn70rGTdEax0u5zNSFxnoQHMV5PjGJd8Zhni5mUhzZBze59vMZ5gLYUb8NLdcYpoVpL70JYs5mMj3CD1hh0TR33cZQyuNUj844aVDZgytXnoXFelYZxnDufuNAhafKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715583581; c=relaxed/simple;
	bh=kseFBkUq5HsQcsQRV4TQm0JvyI9MHQ0rc7z4CMsWJLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3c3mupM5ePc40fT85xf1tdWAX8CwtFWzA6aDbxGnoJtxCHe+B6mkFnyIQbPDiC7ziNVSzC/N6yRF//00eE+wP0pVQeeIuTQ/m8HxCDgvXyugEUm+FwEFdeRN9Pg1kvmmznEFFBPCZOIp8H2ljVE0KSLiic+d0ClTL67h0ygpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Ch+3oct; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qxrkdrWl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Ch+3oct";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qxrkdrWl"
Date: Mon, 13 May 2024 08:59:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715583572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhEc54QbGm/fvwnp/0OAbrqp5larSb4wu8ND20bpcJc=;
	b=3Ch+3octq58Yyf5dPcbC+rYHY1eXSp7/EovlusHMpzICaRQLsgtCjLcP5hmzYOtRJVEqhP
	uCPSc5CMv1hmcawKCRLyaap2sHr4p9mFgDnkTwxyxA8/HK/6Pnfh47uDgP8sB+f/f697L4
	n56T/R0PKBz96pYfwfDD/0S/yfaJwl7XCCXXH/4m7t/fLmGpF+kVweKZuLvhocwiXnniUK
	VwKbW9Y4ohN10rZZQ5D75BXsufD7mZd2u2+Gh6aHizeDCiVy9xQf2XYcdbzCuXOhZAD4g+
	MGbAPBlzHAiIurk0xxpbhunmbCbbjf4xi3WRsZZh0muYm2PH3L8IkF+8Kvk57g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715583572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DhEc54QbGm/fvwnp/0OAbrqp5larSb4wu8ND20bpcJc=;
	b=qxrkdrWlwSSq77lbsnfZIgZyt8svns82B3ONk9L4dOhWF6Iph2tpFJMEjo9PBwBaEt9URI
	w0FYZPou7jDByNCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT 0/1] Linux v4.19.312-rt134-rc3
Message-ID: <20240513065935.hT5MCimc@linutronix.de>
References: <20240507151648.17883-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507151648.17883-1-wagi@monom.org>

On 2024-05-07 17:16:47 [+0200], Daniel Wagner wrote:
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 4.19.312-rt134-rc3.
> 
> Please scream at me if I messed something up. Please test the patches
> too.
>
> The -rc release is also available on kernel.org

I do have to complain a bit. The whole diff contains only a diff against
localversion while the content of interest not here. But but I guess it
is what we talked about so... but for everyone else it looks like
version increment.

Sebastian
