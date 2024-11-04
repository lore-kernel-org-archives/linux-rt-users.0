Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3A23A6
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Nov 2024 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720666; cv=none; b=iY4NB2EXj4Z40WeS3MRdEF7Jp9V6Kr1xq3UJwhvSAnNhFGtkeedk2BpozbiK9RCMeakc8GwCt8JF8KhQJXlD/YYTgtaaH/+9HBxe/HOGLD0ws1R0VV1klhRHQl2IJBK2y3EiyRabDbwcVjgJQBRtAiA4lI/FsMt1ggsrQomY7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720666; c=relaxed/simple;
	bh=QBnKv8wiWrwkDU/xgYW9p0JEH97O6RjXa1MJuOKaCyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiCniPWQ1rtkVDBTDBBFbp9gZMEQWHDEpZi+t6pKXqq3cTra/ppetqfJAGbdZ5KGjvsj1t2FCaEXxQDC2cwZ0UN9asJOjXGQlw0ChBwy1pU0MJOqJpkkyrjW+L7Rwdp1pec3o9bjuQXrM6Sud1I/jUoG8hjcP010S3Y5Tvba07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qrUSxy2J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MARcgnko; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qrUSxy2J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MARcgnko"
Date: Mon, 4 Nov 2024 12:44:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730720662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrhSpjPEoEh6s6ElDiF9UWotY2BFTkB/dE/LO6dXyxU=;
	b=qrUSxy2JbS2kuZ/vXThd0gYoGbJ+/91dqlANxCWQOSIhcW+YD5sLm4A4QaOvpQrwzDJ/Bp
	BFSHocpnv4LXno6Wv0lzNLdpOVPXf+HcaHaHXiPheH1dLFB/z1Cgj8zKQ4N/k5lrN+gULC
	CbUX5U7Tzq+ME8Ijy85McApqyMcQhQT1CVohf6zo/0wZL4Jn8ywZA/ZDoorWjPxzCgtReP
	m/6uw7l8aciSRdEGIP+ffYG7BHd7XS87fwjjcYl2nb+ZHuthzOPYB6WOEsCvcK7hT5hNr3
	iAV3kvPoo+zZ2RZP/R48lbFT1Z1IPqQXq6VQrGxLaFnncgeMfmr3IdUVhPPmYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730720662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrhSpjPEoEh6s6ElDiF9UWotY2BFTkB/dE/LO6dXyxU=;
	b=MARcgnkocwcy9FmOZzDDl0DSoZV9qkr719WOG5m0j6PpU8JI0E9RaO9n//c0c1iPJy+Qgm
	LjVZ56MKRSE0oFCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] v6.6-rt-stable: printk/nbcon: Fix Illegal RCU Usage
Message-ID: <20241104114421.swk05Mks@linutronix.de>
References: <ZxZ5WXV6umbL9XG9@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxZ5WXV6umbL9XG9@debarbos-thinkpadt14sgen2i.remote.csb>

On 2024-10-21 11:55:05 [-0400], Derek Barbosa wrote:
> From 1188b21c357dcb750a6851d7e5fd2d1f70ca9690 Mon Sep 17 00:00:00 2001
> From: Derek Barbosa <debarbos@redhat.com>
> Date: Mon, 21 Oct 2024 11:30:30 -0400
> Subject: [PATCH 1/1] [PATCH] printk: nbcon: Fix illegal RCU usage on thread
>  wakeup
> 
> In debug kernels, printk'ing during the SMP startup of a secondary CPU
> results in a splat [0] on boot that details illegal RCU usage from
> offline CPUs.
> 
> This patch aligns rcuwait_has_sleeper() with what currently exists in
> Torvalds' tree, at commit 76f258bf3f2aa, and will avoid the
> aforementioned splat.
> 
> Furthermore, this patch makes it so that we avoid the use of hacky
> rcu_derefrencing through the waiter's task struct,and instead leverages
> the correct RCU API with the rcuwait_active() function.
> 
> [0] https://lore.kernel.org/linux-rt-users/5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn/

If you could replace the [0] notation with
 Reported-by: Andrew Halaney <ahalaney@redhat.com>
 Closes: https://lore.kernel.org/linux-rt-users/5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn

then it would make me happy.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
