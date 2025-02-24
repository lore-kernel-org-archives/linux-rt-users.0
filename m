Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A942571A0
	for <linux-rt-users@vger.kernel.org>; Mon, 24 Feb 2025 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398162; cv=none; b=QvGis5KzVg2elfd/yRjOGPHuixU6qPPWIE2EIPEMZ6uC+xzcRusQJgyULd0UqhLeiJRESLuw01Eld7bUdwrfwcXy4VFsJCxrfBzcedPZK+48D8qFEjhgx9Xu2nGsmQe9Xt/P0DqaSfTA5mI+h5dtS/FFtjmbH0Fn6r+WUygyWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398162; c=relaxed/simple;
	bh=0SD6917174htDvkrIKg/zpUU4zwSCoaMFQv/llPpg1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM5yJgh+K6/vVJTVpNZc2ZfFqT/a/9MmhrtwNlwyXlX6NmAFJxKSgKWnkubSINkAGIe5zZx9mc+6hGrMBJyJnEG8sHmd31PizfjbtqzHgvQs7CTNxAQZhL9w2VnWfDrX5wJoCwyKAL2gTloxh3SATVFAjPnZi1sRbEIacjN6uas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WBmrTkip; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D7q2fAQ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WBmrTkip";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D7q2fAQ1"
Date: Mon, 24 Feb 2025 12:55:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740398159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRBbe458khfhsJGd2fn2pPUp/2+4D68Udp7pjkza420=;
	b=WBmrTkipJr52Qaizo0JjPFI3oKNp15+8uaZJ0xMZ1Iv9MdZ/rfjcp4xwMtiiBk4PlK+Kjr
	MGRmJUmLabZXkiRHcMIaTEdngeAK4BJ1XbDIuo2hrcXISLy2tEruuaAM3NBLc8+1vyZAhI
	bLi0s7JybMovfuPZgguOJ7PL7NX+0CFAQ88vCevh/7tj70zdKUsX2pyC7/g0gSkQDl66zP
	G2XETCjrB8HoG84GgF6PqB1EIXacEgvSZcbnZlKWf2GgwddeUcHOqmWJefeiA4npsXrA26
	ChuCaFKbuQkauhsy7TaWE74ISV3wWWa40XwLr/MF7sa5Osk3+QCi9eJkiqNkfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740398159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mRBbe458khfhsJGd2fn2pPUp/2+4D68Udp7pjkza420=;
	b=D7q2fAQ1/cdEWtjkmfXIrWgT2tUon/g8k2lzE+kLAQY23vFzFCo/buuARHaSsQDWKgcOzG
	8mN/ChjVKGYpY2Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Ziegler, Andreas" <ziegler.andreas@siemens.com>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Subject: Re: 6.1-rt: NOHZ tick-stop error: local softirq work is pending
Message-ID: <20250224115557.AIFtijeu@linutronix.de>
References: <73c50e2fb53ba8cc2f1538abccc42e98fa63159b.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73c50e2fb53ba8cc2f1538abccc42e98fa63159b.camel@siemens.com>

On 2025-02-21 09:32:41 [+0000], Bezdeka, Florian wrote:
> Hi all,
Hi,

> when stressing a 6.1-rt based system with network load we can
> immediately see the following in the system log:
> 
> [  165.260690] NOHZ tick-stop error: local softirq work is pending, handler #80!!!
> [  165.264689] NOHZ tick-stop error: local softirq work is pending, handler #80!!!
> [  165.268687] NOHZ tick-stop error: local softirq work is pending, handler #80!!!

which version is this? I think is is an imported issue. Is v6.1.119-rt45
also affected?

> It seems that
> 
> 96c1fa04f089 ("tick/rcu: Fix false positive "softirq work is pending" messages")
> 
> tried to fix this issue, but for some reason it does not work.
> 
> Is that something that is really allowed to happen on RT (which means
> that one of the conditions for the warning is still wrong) or a real
> problem? We did not notice any negative impact on the system so far.
> 
> Input welcome...

The thing is that this may happen on PREEMPT_RT. Usually because
softirqs can't be run as the CPU is blocked on locks and the lock-owner
is either preempted on another CPU or blocked on something else.
The thing is that a NO_HZ CPU should not go idle if there are softirqs
pending as in "there is work to do, no nap for you". But as I explained
earlier, on PREEMPT_RT it might happen that the work can't be handled
and if no task can be run, the CPU goes to sleep.

That means if you replace with PERIODIC, the warning goes away. If you
start a CPU-hog (on per-CPU) the warning goes away.

> Best regards,
> Florian

Sebastian
