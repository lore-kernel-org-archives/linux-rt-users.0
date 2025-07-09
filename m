Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B918479
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Jul 2025 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752090288; cv=none; b=HwlqHCk0wwxquAwqY3acRMDJJs/7tsd24UZSS+LF+HXfgP+NY/mJFI3SiOnvYYy2TNZuJGbaTtwp0DT6g5evQJgkaSvzTT3ZepnvjH/MhrXT4LdQQxdkZfi9mKim4TIEayzdJ9R6jr96Hxcq8nOXMHNEEUqDieKxrA3q2eqC5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752090288; c=relaxed/simple;
	bh=YHoOTaEcM7ajLztHEUilHo8GRkm1itG9TaX4e0uEIiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4FMLpWoHG7BHxD84S7MTCqdl7jKcPF3B4uj+onlCwntSrQH3FMkuf2ZAX6vItQNaw5Q0o73C+YRgUSRWfauwp5Q7maqQ3Qbr/hD6jkk7SfxITXsBtgQ/9dlctM3XuT6UhbWFld6QgMMXpMRhlpDtaTg7R2wSAxGtGud2ONA5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4mMJzgB3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dW/vjvKL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4mMJzgB3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dW/vjvKL"
Date: Wed, 9 Jul 2025 21:44:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752090285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHoOTaEcM7ajLztHEUilHo8GRkm1itG9TaX4e0uEIiM=;
	b=4mMJzgB3ZYFoYa58PwQnNDFFy69Mqgmowu8meHS0hgzlxykU1mMRWSbSPHCUa3orQN32NW
	g0m/IQuyc89/3SBLRFzHWaddP1Rjr+TIylfPE6e+JIROTpEI0AlfDjFzFR9CZfHymLEy4W
	5o9OlHCOco6TsQHn3jbVYM8rTUQ33q+05EEJWVM+iGIYIUS2w9IC2NHcg+JRip6ceYkbb3
	0bY8lGkC07fmjk1H7jluU4HZK/xw6RkDiW8SiAiQcCyT2KmZesaqEolMfpp1zt9Hp6/SIy
	pbZf4F4qd60ezL2J3HvErZ7VHD15id5Z/Mu37PeqLM3oJxxIzhA+ZsWDYmP1OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752090285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHoOTaEcM7ajLztHEUilHo8GRkm1itG9TaX4e0uEIiM=;
	b=dW/vjvKLKxXOozUk6A6mqkAE9MMMR923W7eSUUEiEGX7lVfV8bDMo0+YjZKLzOC91Arel2
	yuQxqjL9Uf7hGAAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Debian kernel maintainers <debian-kernel@lists.debian.org>
Subject: Re: PREEMPT_RT vs i915
Message-ID: <20250709194443.lkevdn6m@linutronix.de>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aG6nMhimN1lWKAEP@intel.com>

On 2025-07-09 20:30:26 [+0300], Ville Syrj=C3=A4l=C3=A4 wrote:
> >=20
> > It seems like the critical uncore lock is currently held in a lot of
> > places and potentially for a long time.
>=20
> It shouldn't be held for that long. I think it should just be
> a raw spinlock.

What about I resubmit the series and we look again? I don't think the
lock should be made raw just to be done with it.

Sebastian
