Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943541F37A3;
	Tue,  7 Jan 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263888; cv=none; b=pu7QOE3uqqmMTReNPxg796Qx0glpfiSLw+okvyRkgpLM342MnfuMUXSqjKpyrSjbKOHMUF05Haed7axwd2caphUtZhj0ke+aRKI2GoTipRJOyPsPr/+M4tgOu45Zf8E6Niff17pOqr46IAF9HbQ7VlP4vNZ51GmtQaqBpLGrQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263888; c=relaxed/simple;
	bh=RLc9nncHsc6LW3NQ99AW4XLviRQFuTnG9ZDt9wKUZ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEIuEhdRRjLd/q33eZ+3+ULJjpVL4+8tc4h/mHBtv6hCu2o6fKksOnRf2d63PSSrkkicMDPGTaMZOMhwos79pWgZbjTksoumELAG0dHlNJ1vnsYFHoh+v7DV3au40WdbAODAu6clz8JTmMLU1xx9mUHhGm3YgYOrlFozWFyN+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y6Ooebd8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WGwEca5w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y6Ooebd8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WGwEca5w"
Date: Tue, 7 Jan 2025 16:31:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736263882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bTn7u8yv17tHCBNDNKuGs43mjHfqtYO16hpQvxYTdZ4=;
	b=Y6Ooebd8b6LnmbVwOrO/EGwqzafYhZF/AYTWB2HgHNTWpfXWE6I/W6A8eG1DJZ67MNzUWw
	WY/613LTC/GYRs/8WCLHm2BMXm3TMcpGnqawPu5kmgPFjUmiKAHp7x6p7KUes12ywvQoVi
	LUokwo6HlFjAFMLTJNxu71a3RfdHW69vFttnQV+OkkHjBgKv/Y3ELPgmxhXF4G4nw2k18N
	4Z5xLP5FVOUxLi+durE5uUtZVjxj4WeY7rf1tzXy4SMWHuzOzjGHdZBKVxhcABsnnWknw5
	JRChGuw1ss4gdzn2O+C/1pDMqT+yuf2o8YJR/fkYPcwPDFEwlvjyd5AMt0Xwfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736263882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bTn7u8yv17tHCBNDNKuGs43mjHfqtYO16hpQvxYTdZ4=;
	b=WGwEca5wNOalFkcDaA5K1B6FMJ/XPWwKyJknumU3k3qKfc3YOzWI4BiaDA5G88lkeczzDX
	TRJ290V4F1NaYdBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: alison@she-devel.com
Cc: corbet@lwn.net, gratian.crisan@ni.com, triegel@redhat.com,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, achaiken@aurora.tech
Subject: Re: [PATCH] Documentation: locking: update libc support status of PI
 futexes
Message-ID: <20250107153121.wAL-TfKG@linutronix.de>
References: <20241228181546.1315328-1-alison@she-devel.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241228181546.1315328-1-alison@she-devel.com>

On 2024-12-28 10:15:46 [-0800], alison@she-devel.com wrote:
> From: Alison Chaiken <alison@she-devel.com>
> 
> Update the text of futex-requeue-pi.rst to explain that, because of a
> conflict between POSIX requirements and ABI constraints, glibc does
> not support requeueing of PI futexes.  Add some information about
> librtpi, a library which provides an implementation of condition
> variables which supports priority inheritance.

Are you sure? My memory is that glibc avoided using the internal mutex.
The old problem should be gone and pthread_cond_signal() and
pthread_cond_wait() should work.

> Signed-off-by: Alison Chaiken <alison@she-devel.com>

Sebastian
