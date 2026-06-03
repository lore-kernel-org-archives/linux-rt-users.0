Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3D3C5855;
	Wed,  3 Jun 2026 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484803; cv=none; b=C/yjvPbX+VTiT56h1C/OSC0f/he5H9ZRzdM1nqVuHwhlQu5SibtK9Xs3q8HWS1uiTQGkpTCQFHlUw+YmyYB0fEQTULQlDfkvP1a/ZVuq4QpnGvJEwGWLuMh3G5FKDYgbw5xKJUr1lHQezfFSe5SMaelAisOyO3GnWXykGD39mb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484803; c=relaxed/simple;
	bh=R1CXJesFB5FOp36O1SCpL2ILpN7BMqECmtc3/EkYnRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYeEOdQ7axUGTXXD004td/4IdEvKRApDou8ai8DsPaqU+ZFKPbA8Fx/XxQleKEOHSegWAPTKYMX5WzeL3o6YWR417IeSa1cU8j/eseVF5c3mVJGzugIX0tUQvMNBFaaDI4y6FgPFiT7apJWW21JQ3Tn43wbnjbLh3gvCoX5USeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGbh7Gi2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uwam2fAH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGbh7Gi2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uwam2fAH"
Date: Wed, 3 Jun 2026 13:06:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780484800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1CXJesFB5FOp36O1SCpL2ILpN7BMqECmtc3/EkYnRA=;
	b=lGbh7Gi2Y8O4yHLzKxZJk0JArJ+InC+bpJUMs416bvvEWApqqgsHnloFnIrMKarQzOsAwJ
	jlxL9eT6ukgaS92yA5j3q8goATbilVPABIhpFwPdM6oNa2mcQduH7+L9QKlCePeLlHEiuu
	78PMFDYM5cUKbaRUTQwbobaGwi4P9x6Ui6Bz0JYyG3b1UsXyTksNMZNXCAkhjuhmbKOMBa
	4aEWK9wPqIJE1p7MWeEPJcutYTw6MDmQsmf1W1DD/MI6PDVeneCMu+yKDtYOVwy1sfnoE3
	arHF4QEuBVOg1BuBeFjjpa3YRfmxNscBEuUXxx0GyP236cagLsqfvwgKQfklfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780484800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1CXJesFB5FOp36O1SCpL2ILpN7BMqECmtc3/EkYnRA=;
	b=Uwam2fAHkXFhdx1glIutphK3UhMmdPvPn/sRTnD2Hkq1ef3PTzPmHMiiDUVKpztn4bP/8l
	jm1++pHenPK59MBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"open list:Real-time Linux (PREEMPT_RT)" <linux-rt-devel@lists.linux.dev>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: index.rst: add entry of other
 sub-directory
Message-ID: <20260603110639.orWE0pyG@linutronix.de>
References: <20260603080430.344391-2-manuelebner@mailbox.org>
 <20260603102020.ZsS16TaP@linutronix.de>
 <a553f123de4b4887e8e78e751ca727f9992d8b00.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a553f123de4b4887e8e78e751ca727f9992d8b00.camel@mailbox.org>

On 2026-06-03 12:55:57 [+0200], Manuel Ebner wrote:
> > People have been complaining about this=C2=A0
>=20
> Maybe with the help of them we can figure out what's happening.
> adding linux-rt-user@vger.kernel.org=20

good luck. What I managed to find out is that those, that did not copy
statements but run into trouble themself, were using in a multi-CPU
scenario. Based on other details I *think* it should not happen single
CPU usage but nobody confirmed.

But this HCBS thingy aims at replacing/ removing it entirely=E2=80=A6

Sebastian
