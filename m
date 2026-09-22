Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B218D390217
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088681; cv=none; b=CJ6A18DT7K40DjKBd/iC4ovMX6zpBbl4JyPke1rhhMLQy9NBIxjAHIkzpcmoI9bg47r6LAdQ8fUvMTn97hTNubWRp8oOSXmVRFFR0og288M5cVLHw274kKEkLUDguAsCgNcVSt/1HZof9+S6PXnoTpbsZ1iNfre/agPG60Y0qaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088681; c=relaxed/simple;
	bh=2z1zpbxC8oYExU9SOgDe5XlN720Rusdcl/05DmSqd5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQceUzNUhLbXwJcarcqtoPFlgyTRlcLgtbIHeVI4j5LB/hNM4Wcb6eAtAW35uyNEUKLo1U/FGlxFTRAmF7AkeEMoUinSmnhSyDv0Gm0yGhrW3UFt5C6s0PhHKqcjft0mIThIQaYNDrE05Ul2ECTrixo5IFnqYKDkaSX/xNq7tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l0dUQhon; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TvRcx0zG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l0dUQhon";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TvRcx0zG"
Date: Tue, 22 Sep 2026 16:51:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790088677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omry2w3G780u/Bb4U6FnxaMVAsVco6MbPs1PdlXQNlc=;
	b=l0dUQhonU73gf0dJk20ecoJnu+6akgi9PStOCNULtInYzAZd+ozOdMUuTNgIVuOVsKR1QC
	yOlgPvFA3vdByv76ZBaY4H2dUjGT1t//Sr3tF8VERiD4k5T/H+a2mwy22ns2Pxl0PxDRtY
	pj0N14BkdrNolRHwxTw1aB12xG17boggI2e3HNPPJTlcOCT2ly9SbGAUikOYyp6uL4+gEP
	ek2KkUTWw9dLR8WytAU+k41x/To2zyrwYHkKY2OVZyHqhEK5ymFKhlddZ0cccrwQrp8QRe
	aGXYHLvVEqMIbizolvRJkR4XZM8Yn3smDdddWRdeJL7VRSxbI5u++zCewRKzIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790088677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omry2w3G780u/Bb4U6FnxaMVAsVco6MbPs1PdlXQNlc=;
	b=TvRcx0zGOEcwHhGWEZfyB0hA2LdozEvaGrG7VGi9HlXtFFN6N/VxI/H8/hht/A58nEzQJo
	I4F4N+dy1apZeDAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Aryan Sewa <aryansewa2004@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Inquiry on PREEMPT_RT
Message-ID: <20260922145116.BuEvhqJ-@linutronix.de>
References: <CAB05US=e0o2dm1DBxjHkraL+vDgA1M-ufSqrQbxG5RsbRfdjQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB05US=e0o2dm1DBxjHkraL+vDgA1M-ufSqrQbxG5RsbRfdjQA@mail.gmail.com>

On 2026-09-21 09:51:42 [+0530], Aryan Sewa wrote:
> warm greetings,
> 
> This is Aryan Sewa from Measurecal Instrumentation pvt. lmt. India.
> I'm new to linux's kernel and i was looking for an RTOS for raspberry
> pi 4 model B and STM32MP135D, i went through the linux kernel code and
> i actually need some guidance on how to activate the PREEMPT_RT
> feature of linux. If possible pls guide me through this, i don't mind
> if there are any documents or videos I have to go through in order to
> achieve this. Anything, please l;et me know.
> 
> Looking forward to your reply. Thank you !!

I suggest you use a search engine of your choice to find some
information how to build a kernel from scratch. Since you are new to the
linux kernel, that would probably a good start. There is some
documentation from raspberry pi community and also some extensions
regarding the PREEMPT_RT part.

> Warm regards,
> Aryan Sewa,
> Measurecal

Sebastian
