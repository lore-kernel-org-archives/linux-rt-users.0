Received: from krieglstein.org (krieglstein.org [178.254.28.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF52F29
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jan 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.28.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738067922; cv=none; b=mXBJ+Yt0TDa2TIezNqG2hmFsVAtrR7+BeSfCd51/GAp4+IOe17Yb5Pe3KbIjURmS93BK9UkUaBsC3ZQPtO9h+pl3c+TDQafwq+abYezLGB1yxreEySQ8nvcrTUGedQXmeYtPBUBiikpgj9qQYDsTUvTwIcH2RbI8erBmfIqwH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738067922; c=relaxed/simple;
	bh=scPL2EVrE3+kNWt5w0xhALz5frCNCyacUc75MjiiHjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=czNTD3oDbjofh3Jen8SLG3qqfIMKlW0ksO2x8OIM6FLTAAi/56wXUZc0Ka2AAvR/VnkoxSgA6hEfDGQ6vahaGTr469ytr/ITKX0HDsmZfFBFPraOKcKctoTRgcPA027QIZo/DJIY1S8OWU7l0KjSUodzM4YHn2nP0+HFbr3ys+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=krieglstein.org; spf=pass smtp.mailfrom=krieglstein.org; dkim=pass (1024-bit key) header.d=krieglstein.org header.i=@krieglstein.org header.b=hhaiUO6m; arc=none smtp.client-ip=178.254.28.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=krieglstein.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krieglstein.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=krieglstein.org header.i=@krieglstein.org header.b="hhaiUO6m"
From: Tim Sander <tim@krieglstein.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krieglstein.org;
	s=selector1; t=1738067459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZACzEivFOg5h1PCEyS06h7JNf0SOUhpBY4qE91dQSY=;
	b=hhaiUO6mqy9lPDH+Gg/sFUD9hv49Xlxc26nuGErK5uvU7N2TJrREn+l8V7C3pYxKJ9sp9J
	SjUG8bAy0ZxM9W4HsaxlYg5F5+dKscK4dTmDaOd1xVo78rRuz/3UvR+vZ1H2H6vIY4swFA
	+/uJ3wq+eomYboBE9wLGzOD+pJwmjVY=
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Florian Paul Schmidt <mista.tapas@gmx.net>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
Date: Tue, 28 Jan 2025 13:30:59 +0100
Message-ID: <4625492.LvFx2qVVIh@ripper>
Organization: Sander and Lightning
In-Reply-To: <6b290601-7112-410b-9a85-bde02f62d7c3@gmx.net>
References:
 <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <20250107143937.d_ho7CXb@linutronix.de>
 <6b290601-7112-410b-9a85-bde02f62d7c3@gmx.net>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=tstone@krieglstein.org smtp.mailfrom=tim@krieglstein.org

Hi

Just my 2 ct.

Am Mittwoch, 8. Januar 2025, 10:48:56 CET schrieb Florian Paul Schmidt:
> Hi!
> 
> On 1/7/2025 3:39 PM, Sebastian Andrzej Siewior wrote:
> > On 2024-12-20 14:18:43 [+0100], Florian Paul Schmidt wrote:
> [...]
> 
> > The backtrace appears long but everything up to folios_put_refs()
> > appears preemtible. Then there is the interrupt handler. This looks
> > okay.
> 
> That was my impression as well. Nothing really surprising (at least for
> my limited knowledge in these matters.)
> 
> > Based on this trace, I don't see a section which disables preemption/
> > interrupts and be the reason for the interrupt happening.
> > 
> > One thing that could delay your doing are small caches.
> > Then there is looking within the system: An inaccurate/ low resolution
> > clocksource and/ or timer device.
It could also be the TLB infrastructure. I found that these events can also be 
very time consuming, probably combined with memory contention?
I think this might be traced with performance counters but i never looked into 
this further than musing about the possibility.

Best regards
Tim




