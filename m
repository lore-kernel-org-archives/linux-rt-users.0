Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70B2F6562
	for <linux-rt-users@vger.kernel.org>; Mon, 20 Oct 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952991; cv=none; b=iwHcphjHBqfaAGNvG9dRUjTwQOdsY9oiWRbj4Z9EPYS2doHQtVSmMwA4YGNEBzEJwiVQHCv6Y+C+d4od01VplB5rhRAF4H5Y7FT0DX+XPAQWod9wNKMC/T6ElcWRiDxN0NHvgeX0IEZZ5zaorXaDtaHgJ8Re9nYtCURyY8AqglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952991; c=relaxed/simple;
	bh=nv64yYdmoN5c3+vEUosI69JhKEk9es5iIO5HSv4celg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThcWLoNUvQwlh+DXsT29A9N+gTc9lU212zeSW+pxszQugKlQvy06X7F3JjCVqCHodhSBHYqF+qq3/mGPKPJkdYrIoDoJcKcwPuFi8/0LVo3tsHLMmn8yYY9TlqraA5zHFOceOv3sH5yq+c9bGMKu/EDXTHm8rv7oFYXvwzKGjT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l6HYv8EN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7fxQilT9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l6HYv8EN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7fxQilT9"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760952983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cY7RLOJbTd06kAcJHTNWgKQKjzH/qE0BFbO/Dzq9cE=;
	b=l6HYv8EN82xspq2lU9RXJmWYairmI4sJjr6EJ3O/TqI/0zyhZQA23t27gPMnSt63pUEhzo
	Q1HduuPF6tO8+l5VL+UNbwo3GERmAKtAkmr8lxC6tss+gAWUpvhE0GVCiY0DKmOurWtUBW
	Tv9l3fRrsBmVb7J5c0KPfwgH9YJQa+PHJsAsIb3zXWVqZj3MWkYyAfqOuemj+ZgoGqsCCb
	cMmhpcgxMRj7INtflSLKf7CnntsBBOLkHBjgFwRvIBvHmtGYyZ41OPYH+YjDthMNLpkpob
	iMtHKtbrkCI0BHPIt3f9IzkiUo0sE3BR5bYffRk9T7GrHQQv6pDmo2kLqpV0mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760952983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cY7RLOJbTd06kAcJHTNWgKQKjzH/qE0BFbO/Dzq9cE=;
	b=7fxQilT9hyHSwEF18qMAfHBg27On0TdIbbVY44bUwYIFbEjKowBG7J+MI/14ErDX8o9iZX
	NJ6HEAsJStQNt+DQ==
To: "KHUENY.Gerhard" <Gerhard.KHUENY@bachmann.info>,
 "'linux-rt-users@vger.kernel.org'" <linux-rt-users@vger.kernel.org>
Subject: Re: Realtime throttling and Real-Time group scheduling
In-Reply-To: <AM9PR05MB777740C6836026CE5A7F5F1C9BF5A@AM9PR05MB7777.eurprd05.prod.outlook.com>
References: <AM9PR05MB777740C6836026CE5A7F5F1C9BF5A@AM9PR05MB7777.eurprd05.prod.outlook.com>
Date: Mon, 20 Oct 2025 11:42:23 +0206
Message-ID: <874irt6hk8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Gerhard,

On 2025-10-20, KHUENY.Gerhard <Gerhard.KHUENY@bachmann.info> wrote:
> I'm running a 6.12.39-rt Linux kernel and have been experimenting with
> runtime throttling on my embedded hardware.  However, it seems that
> the settings for sched_rt_period_us and sched_rt_runtime_us have no
> effect. In my kernel configuration, CONFIG_RT_GROUP_SCHED is not set.
>
> Is my understanding correct that CONFIG_RT_GROUP_SCHED is not required
> to throttle real-time tasks?

Yes. But instead of adjusting "throttling", you adjust the guaranteed
bandwidth for !rt tasks. You can read about the fair deadline server in
its original commit message [0].

Basically you can adjust these debugfs files:

/sys/kernel/debug/sched/fair_server/cpu*/runtime

to guarantee bandwith for !rt tasks.

And yes, we are aware that proper documentation for this is missing.

John Ogness

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/Documentation?&id=a110a81c52a9de73e2e57e826dd3bf0fd4c22226
