Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A735836A
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Mar 2026 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315121; cv=none; b=Eju3TdMP3ndf4vaiFBhszi06UhswqaoSDxKnVx5A+CkF/XuwYU4bkI/MvGuqwcyoUsVaj4qHJDgHK0+7TaUaTG2NyKUef8JLhzSaDQ8BqTLnwAy4BsnYZiLZPLVIOL6Gxyk4Lwihowv/Tg+YaKqbJ9m7QYrK+EttkIqTYXaxvbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315121; c=relaxed/simple;
	bh=CpMgw5H9A0bSuyR2hTfMP1DQI8JvEK0pw3QdMxoYLKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRyEQpUjD6gf+fw9xz4vtfh9XQ6R4p4Ee3doDhduXVwl6asS3Bqjt5BYR1TrUu+NW0GeaGkhOm0sGAdKLLyMJqowKXZvG20ISnnDCQq12z+HI5AbZyzhXdhx+Wnmb6umZTouSeOgKboSfngpZ7HgQGHe0bVatu38v7fMmGrlAC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x4up6PP9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqSJAWaA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x4up6PP9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqSJAWaA"
Date: Thu, 12 Mar 2026 12:31:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773315118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4YpLeb3ALOtqb3g4/yY+bK+8UJe0AwKWYUbdkXjiZMU=;
	b=x4up6PP9xOiIhe8AU8fDDuvrovT8wVW2Z+zEPR4GBN3LdOLgFg5tR2U/NdKgHElovBqchu
	4cOoOOcVPQWQDMJO8dhMTwWsl78QLeufMgv48P+LY/VMG5dE7Lb+GMP3WWf0p5TurZq0l3
	46pw0fRILfRsWMVj8Zhr4F5vZ2h6yCkOsaB0l6fzg6gYDLdZAX1rSdi1nVIiuI6TN8Hs3Y
	0hE09WgPB1NSIdrMdKegwI5meZeUa+pm9bB0Koa7su3gGeSBE1xn6p5S0ElivcEnXcRlYc
	1jw1LIqf1b9gJXMbALkAmJvNdX754xPjLOLdjdsXXEAFxOyORJzNjnOTRemsrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773315118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4YpLeb3ALOtqb3g4/yY+bK+8UJe0AwKWYUbdkXjiZMU=;
	b=AqSJAWaA9v/tEfSJfEbKiZ173GTGEIhsIEc5Bb+e1lJKnAijPua4SOB4A+ow56FyHl114t
	3Of6O5LOdzY2ZHDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Markus Ongyerth <markus@ongy.net>
Cc: linux-rt-users@vger.kernel.org, ongyerth@intrinsic.ai,
	cschiemann@intrinsic.ai
Subject: Re: Ist drm/i915: Depend on !PREEMPT_RT. still necessary?
Message-ID: <20260312113156.yINqVd8t@linutronix.de>
References: <4b7478ba-e10e-4877-b2e6-63203ffa9094@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b7478ba-e10e-4877-b2e6-63203ffa9094@app.fastmail.com>

On 2026-02-02 17:16:00 [+0100], Markus Ongyerth wrote:
> Hi,

Hi,

> in https://patchwork.kernel.org/project/intel-gfx/patch/YgqmfKhwU5spS069@linutronix.de/#24761794 the i915 module was disabled for RT_PREEMPT kernels.
> The associated discussion mentions that it shuld be save to revert this once more patches have made it in.
> From what I can see, further patches did make it in. But the dependency is still there.
> 
> Was this an oversight or is it still unsafe to use i915 with
> RT_PREEMPT? If the latter, is there a patchset we could pull to make
> it safer? Or is there some place to read up on the dangers?

If you look at the latest 7.0.-RT queue, there are still i915 patches in
it. It is not an oversight. There is this series
	https://lore.kernel.org/all/20260310115709.2276203-1-dev@lankhorst.se/

which once landed would get rid of this !RT for i915.

> Thanks,
> Markus

Sebastian
