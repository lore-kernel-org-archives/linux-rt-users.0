Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE313959D;
	Fri, 23 Aug 2024 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397105; cv=none; b=qxH4qvAqgWoHlHfWPMSYJQY7R39RP39gYIuRVkwqqLXtlsVSZkI+Dc1RCLp0i+7P/A/0lxBlx7mTozBENI/gYBUSxlinfAATLCMSSkyRzKlgAaPPs370u7OiBfVLtSBvhG3CC8br7a/ykCg2AF61nnxCk3nG2FWN1E5SMt2FgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397105; c=relaxed/simple;
	bh=Jayald4Katio5aLTprP9W5CAIVwLFsjHRfBhF5nIChM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkPvlzUjdn/0xqr91nq1Ez0ns/1emyKkr8XxjD31sSDBMAMFqfQ4h/E3yrOjKHgNDznAj1CFYlfrwpqtWTE8cQINHdGlQ7cyOUAKrIfDqQWAuHcnIMrC2GMQwGTuP7DfvtYuSCI5kOyxnPliLnHcVNBqF08jQS72ehLAJUdatT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bTUua/IY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZISEXs6r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bTUua/IY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZISEXs6r"
Date: Fri, 23 Aug 2024 09:11:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724397102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zP+bUoeBqUw+8ExQP+EVY6XY5NKStTtQ7noACJ4Tdek=;
	b=bTUua/IYXOIhYn0FXUqFXmPywumTQYdVgHnqGwDaGu9bM3c11A2fGqhrMFljKxEGNqTPsG
	2cX9+G1mecIDdhlDIlWgYxMdTrQolAHSK7WXbQX4GrQdebWTLlxRPdZE0eGgHJRyd30oP2
	Kk+qDklZH/UXJmOemzbLKuPcywBuYeqiKVGVqgVtOCau4qdb1VwdQqpEiPyQABxD3y0tRR
	jgWrqLvI02fGPgmNimDrQ1s15R1VIE5lw8vL+xB0YkCMXjdPn2lZ/5iWk+JpIqqSwaDgQ0
	B9U5FbMv00a5VjSi9/j1pqDB+JIWIdoaC+qMTBc+GPYb9QLlQpzEBGCTF11Cvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724397102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zP+bUoeBqUw+8ExQP+EVY6XY5NKStTtQ7noACJ4Tdek=;
	b=ZISEXs6rdLqgociRq0zsMoOGOR8f+NMof/+gutuyNcf6DoSco7u5ppIG60hdAHTkIe7zl4
	u9nBaPcUjfNUbWDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: williams@redhat.com, john.ogness@linutronix.de,
	Derek Barbosa <debarbos@redhat.com>, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: A Comparison of printk between upstream and linux-rt-devel
Message-ID: <20240823071141.IJwRFmZ8@linutronix.de>
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>

On 2024-08-22 12:32:15 [-0400], Derek Barbosa wrote:
> Hi,
> 
> TLDR: plain, vanilla 6.11.0-0.rc3 is slower on flush and 
> does not print traces in panic/crash context consistently.

Petr, the whole thread is at
	https://lore.kernel.org/ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb

your email address had a typo in it.

Sebastian
