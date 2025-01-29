Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBC18EFDE
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jan 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738143566; cv=none; b=M8h5kh7s+H8iJkqKwGMElc0KCxCusX5iALrSJtkxqcTDrKuAjhRho4N5COfAMyNbev4D4i0kfUCLW8cDzbPSs7q7d1l0DzKpkJarRg7SdPZOaRqBckEJHzxvJEvDhN1FYl5k9zgvT2qDWbW4NJTqb2yI+apvNQCKC/z2jzINtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738143566; c=relaxed/simple;
	bh=W0/oQxxK8gYtkuhxFksQP/g0kcocbZIhkDAtg7l8M4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4afopSKY3UxQSHmlTtUyJ8sPh8BX1wJpMyVEk5yAQeT6RSEYyy37JmCEmqvqzq4rngXh5R1qWVkHNKGphHhV0bbIINX+hexJsvgyXyLbiIWNtd5e+GZXjt7KyIOvl8d/N0FnBqvfMAkz4dgTbBhTdXbjuT4xhz6pd4srL3FXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o+eOI5uW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pj2rjib4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o+eOI5uW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pj2rjib4"
Date: Wed, 29 Jan 2025 10:39:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738143562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isRTUN42zNGgGwyCPQKpwHr8jizZYXXUwMO6AFytiHI=;
	b=o+eOI5uWbugeLqwzCK2bT7NJQyLJqS03jMBhmHsyOJWpxu3LlxiPGD1l6H/y/4YODktw0C
	QqppSUn9Yktc+ZMXFIh7sHjPGIDJSDTnmHq842N5oiZ9wWD/cH32lMcBc1yUJQG4e6HbSt
	i1Zkzn9uIfRsPsMSH7G8z8S/yONcUqqA/Ra3ElGwgpdMgxp8QJHMSRItkUGzOqaYl8/S2S
	IVV0M2179uzyy3vbRJ3qupzQ6QBPZ+yRFqb4MHMy6CUkvfcbMRAsAvAihq/UE+h2LEFXta
	K8vlHytID9ErYzBWBttMGr5Xqg2xKVKmhVLV0ie1TplogKGY7erlAN0SNBl9gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738143562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=isRTUN42zNGgGwyCPQKpwHr8jizZYXXUwMO6AFytiHI=;
	b=Pj2rjib4BP+bHqZN01F2NKHDZrbqnA/+WjWLrLGmhseBR/ZghT7M0HIsQp/NPXXJLWOm17
	zHeDfv/aGtLAQEAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexander Werner <linux-rt@alexanderwerner.net>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: /sys/kernel/realtime in mainline
Message-ID: <20250129093921.Be146ONb@linutronix.de>
References: <70b66c69bdd3d4cf8dd7a7f17051b074b9fbcf48.camel@alexanderwerner.net>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70b66c69bdd3d4cf8dd7a7f17051b074b9fbcf48.camel@alexanderwerner.net>

On 2025-01-15 10:24:41 [-0500], Alexander Werner wrote:
> Hello,

Hi,

> this is about testing if a kernel has been compiled with PREEMPT_RT.
> Previously, the PREEMPT_RT patch created a file /sys/kernel/realtime to
> enable user space tools to detect this. However, this patch has not
> been merged (yet?). The commit which creates this file is
> 	3e7545de923c4e8184c2be0b95341fdc7ef1c193 as pointed out in thread [1]
> on the LinuxCNC forum. Many applications in the robotics space also use
> the existence of this file to check for PREEMPT_RT such as [2],[3].
> 
> My question is if this will be merged later on or the user space will
> have to accomodate this change.

I was not sure if we do need this or if this information can be obtained
by some other means. For instance uname provides this information. We
don't provide the PREEMPT vs PREEMPT_DYNAMIC information. With
PREEMPT_RT we can do LAZY or PREEMPT here.

If the robotics space relies on this information I would bring this to
the scheduling people for their opinion.

> Cheers,
> 
> Alex

Sebastian
