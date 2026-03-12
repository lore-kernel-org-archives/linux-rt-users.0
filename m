Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7143FA5D3
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Mar 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333058; cv=none; b=J67W8jVZa6UxHbKK4tLXNd1wjUZb2YaDx7v4yI8aCKZ9LQtZoYaFOkHHBR+v2OYdUDzJgBtOBD3Y1kO4CotTLtvnE9ReLBZaXo0LtOaUoHm/dyU7ycmuXNDAivnDqNdCxqBAJX36HqLEpQ2kotnlNG/fngWQlUhSOtY/PbEYNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333058; c=relaxed/simple;
	bh=FnOgnZfWxt4R6ekYOrtqGSKijoZ46d5lVKnkt4jw7Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJNEnZsWfiWJ1VPHIY7ukEzWnEL3gOH+OTtsVddiS8KrLwD2JdC+dqLBrNhwe6eE2ZKX6/8s+zs8ruNZ3mxx56Ns7E3YYeSr9E5ffnNEaRwAh4SmdPLFDTVynM9FqpW4TJoqjXjJemQQHnzo1901G84+4HUHq8aj1Zs/AztkpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ymFNkYAW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T13ZjKV7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ymFNkYAW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T13ZjKV7"
Date: Thu, 12 Mar 2026 17:30:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773333051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5RO/srKGOQM+A66R2bZAZfXsjPwn2AmfC30Q9I066o=;
	b=ymFNkYAWzGgT4CLWXgEHl6WW50Az1x3rYm5iRG2od2pPvb6UnUoQFdkiJJznJKCiaqfvFw
	pZVkaVYvmEqxq0ORFVz5mmXDlYHfx5GLEHXlkSeoQKKVd4z8FOSbSueKtaj+SKxBOKsgL/
	i6MjM6LZmZFf98Lkf7JtUFMLSDqeUGMyaIBnvvG0zaM3QODmr88B0oGf1WjislCB90JV7+
	3ebME034YHzmbRFb3fk8LYOaFDd10VfJ154l9yMYh5wax6SWEztStDn56Wde03piKcjxW5
	z4M0OwkMX71IQVHKEvC84M7gZ4roCJzMflv6kBK7iUk5UrT7fofPbj25z+izYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773333051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h5RO/srKGOQM+A66R2bZAZfXsjPwn2AmfC30Q9I066o=;
	b=T13ZjKV75QkqmIKucrf8+Yb8ZN7nJygP4foKLUukIsBkTwMtopLgfys3+6us4H7e2ms9se
	grJhvNqF+AOd0xBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: vigashini kesavan <vigashinikesavan@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: RT wakeup latency due to unbound workqueue execution (runtime
 mitigation?)
Message-ID: <20260312163050.bXFoRAEH@linutronix.de>
References: <CAOcTU28hkopDkCRHert9J43V_1rcq2uwnPAeE2D5r6rY0Xb7Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOcTU28hkopDkCRHert9J43V_1rcq2uwnPAeE2D5r6rY0Xb7Kg@mail.gmail.com>

On 2026-02-02 13:42:07 [+0200], vigashini kesavan wrote:
> Hi,
> 
> I am investigating occasional cyclictest wakeup latency spikes on a
> PREEMPT_RT system (Linux 6.1.158-rt) and have traced it to the
> execution of unbound workqueue items (flush_memcg_stats_dwork,
> wb_workfn) on the measurement CPU.
> 
> These are observed under default Boot-time parameters, without any
> modification to parameters such as isolcpus, nohz_full parameters or
> workqueue cpumask. The intention is to analyze latency behaviour under
> default boot-time configuration, relying only on runtime mechanisms
> such as cgroup configuration or task level CPU affinity.
> Manual pinning of kworker threads through task affinity was tried
> without success.

You can't pin an unbound worker to a CPU, this just does not work long
term. If you want this work to be invoked only a specific CPU you could
do replace the queue_delayed_work() invokcation with something like
	queue_delayed_work_on(1, system_wq, &stats_flush_dwork, FLUSH_TIME);
to have it invoked always on CPU1.

> Question:
> Is there a supported or recommended runtime mechanism to prevent
> unbound workqueue execution on a specific CPU. Or to defer this class
> of work away from any CPU? (without any boot-time workqueue cpumasks)

The hack above would be one way. But since you asked for recommended:
There is /sys/devices/virtual/workqueue/cpumask which contains the CPUs
for "unbound" workqueues. This has an effect on all of them.

> Also, is there any option to attribute the unbound workqueue execution
> to any kernel subsystems or runtime activities that could queue this
> work. To better understand any potential userspace triggers for this.

That folder
	/sys/devices/virtual/workqueue/

contains all the options you have. Some workqueues are dedicated and
have a name and allow changes. Other do not. The one you named, does
not use a specific workqueue but a generic one.

> Any guidance would be appreciated.
> 
> Thanks,
> Vigashini Kesavan

Sebastian
