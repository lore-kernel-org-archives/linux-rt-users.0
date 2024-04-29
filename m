Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426CF175A4
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714383922; cv=none; b=gU1795tLIblXxThdSdoxGeJtOHWh5geSI8dL/cDJgnS1+CuIdu1qIWtMjBZH6Ma6OE4ubWKNjvtU5/CSG6mM87PVoUZGpo3E1X4WY67rDjybdfjH9PfRhl7oDodjmjAQF464HJ28OuZDdNzHYqiW1R3+xFsgvW3yAdCnzSfMl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714383922; c=relaxed/simple;
	bh=KeWhTxBxGtjKkZfdD+pn5B3MZahPy4BuWpj0XFoAedk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbs9t5+FP6x04kkwp5yBktlANHUrSiUt7dNrA6xZ3JqnB5QXq/tRs4ZYvs+cNSHummwYwT9Br8wM4usDXYAMg/BgJpl8MpHocF7wThe2QLtYhXWEvTdyraciHaXXsQOU64bFxGP7OM9J8gu8QEkWJjxe7ORTfUH+/vB5O//93QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NCnlAj0r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EIFIQM8h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NCnlAj0r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EIFIQM8h"
Date: Mon, 29 Apr 2024 11:45:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714383919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2jgx0CocHFB+M7DhUm2LcI76GGn+1+TKXRlrlEDgVG8=;
	b=NCnlAj0rVHcGR5plXSYn0HgpmGAfJXxuRG/eKfdaNNlunYHAzAl657KdcTVMXu6xxSlR5K
	8mJjraqcjGQXy2x24nmZKdQPQQXd6E2bymzZSMrxU2fDhXKNHP9Oyk6UTIq8PAen7kwY+m
	NaeehvXESY3eRrd68wxyAVWzheV3isrXAb7XvPedH9wyTdachcOMBwWwJY0EZzeMk3mljl
	lAmr/RAVgpX9aCZeQUPcPNl5CB7vJJD1qFB7vW0UpBF9IpyriAX9rLjLXfXa5q5+FdvGmG
	IqnR92ehPj6OzSm8IswG1bEz9edrNtNECv47iYPcYxtSCRvm5Y/IBQjRp+XjtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714383919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2jgx0CocHFB+M7DhUm2LcI76GGn+1+TKXRlrlEDgVG8=;
	b=EIFIQM8hFPyFzVzLcLydECf9x2B1HHWA+hkXEE6tfMAFzm+8thMUAyz3T6YdPHk0V2SacE
	a3czaTY3H4rw4fDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Miguel Miranda <mmikernel@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
Subject: Re: Seeking input on beginner-level bugs related to preempt_RT
Message-ID: <20240429094518.3SXHHssO@linutronix.de>
References: <27cfdcdc-f0d0-42ae-9b53-937828a4fd7d@gmail.com>
 <ZiAJ60Ugb-1MaTkQ@thinkpad2021>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZiAJ60Ugb-1MaTkQ@thinkpad2021>

On 2024-04-17 13:42:03 [-0400], John B. Wyatt IV wrote:
> On Fri, Apr 12, 2024 at 05:00:39PM -0600, Miguel Miranda wrote:
> > Hello everyone,
> > 
> 
> Welcome.
Hi,

> > I am currently looking for beginner-level bugs related to preempt_RT for the
> > Linux kernel Bug Fixing Spring Unpaid 2024.
> 
> What is your experience level? Have you built and run an rt kernel
> before? (Selected Fully Preemptive in kconfig?)
> 
> > Although I am not an expert in
> > RT, I have been trying to identify some bugs and our mentors have suggested
> > using ring testers such as syzkaller and test frameworks like
> > kernelselftests to find and reproduce these bugs on our own.
> 
> A lot of the bugs we encounter are around locking. RT changes
> the way locks are handled in the kernel. That is one avenue I would
> encourage you to study.

I would suggest to build the PREEMPT_RT kernel and starting using on a
wide range of hardware and seeing how it behaves.

Sebastian
