Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551EB7DA7F
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Nov 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728223; cv=none; b=jZFdT66S4cJiYaSMKyk+BBZKomubQbjEs3uHTLzRQ5lTQQJwkFDW3+FTZhidOorW3I/ZI5ZB4kGXfldUBJYfMzwGgL3FaSfRhLuBx3JEnbiO3O/nd1pSS3rQLInjALzEsCPieGN+L8EyiGV0IhFHfQhsaefBvzjeyZ9zIPpXlak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728223; c=relaxed/simple;
	bh=qCk+cExESPiB5bVWmeEOI5x4m1S2COdaqA4BcpaGacA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibYsZoG6T7+onO4ACtelbsW7QXro+8TLOyPUl9ikk7sAbHs/ggmAKT+YthBdQctSctFl8bLwrKW3d/JS4ilR1uNsKnVPjFqwrbph6xHOB24WeC+eP+pkLUiCpa2cwdV8kfW1MeSyeU+r139Xn/9A8iig79tHAljHZkv42IiPMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbOYAKX4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=61FSrJiT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbOYAKX4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="61FSrJiT"
Date: Mon, 4 Nov 2024 14:50:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730728219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIq5/qCcB7KhWZMSzoIege0DtOeKnqEBegXgMgzmdGk=;
	b=AbOYAKX42fUqmZbgpadmLiEu9NuIOgLWGL1S8nRarLFY4WlpYVO17nVBs0Xuf9FAnUhkej
	upW6GeXqREBs8q7eXge9hBSwp8foPRU/I1QhLo4mt11IizvkKEVlhdXsc/4QQfsl9XSP9C
	oXVcjgopmZgJ9LZ8AOSqZrRA2Mb+006IZA+DiiunLrX21726XNZUOJi7PPCYFyDHx/Wfg3
	WIw5VLvM8AO7+KB+/LDPZ5Uob8UAHA+uC/HyRAVKQbncOI3Fq6AJ8CClQJx0gx5xXSB9ay
	zshB2L12ZOArDwmOsrNUYXhSlGcNUFU08Y8okZNkQQGNa/WGerE5xibfHxUt8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730728219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIq5/qCcB7KhWZMSzoIege0DtOeKnqEBegXgMgzmdGk=;
	b=61FSrJiTBiMRTcLqIQRXJgqupywso6E9BuQUluzjaF7EKqaXfFyX8bXNA38KasY3iA0YwF
	jZBYQtVnt/068iCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org,
	ajhalaney@gmail.com
Subject: Re: [PATCH v2] printk: nbcon: Fix illegal RCU usage on thread wakeup
Message-ID: <20241104135018.grxgmVTt@linutronix.de>
References: <ZyjLsAK1z7wcrv4N@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyjLsAK1z7wcrv4N@debarbos-thinkpadt14sgen2i.remote.csb>

On 2024-11-04 08:27:12 [-0500], Derek Barbosa wrote:
> In debug kernels, printk'ing during the SMP startup of a secondary CPU
> results in a splat on boot that details illegal RCU usage from
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
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Closes: https://lore.kernel.org/linux-rt-users/5x4nejpojrtny37k7l6loewqwuaituq77zc3tkkojvawcuvmml@thwg65fdb3vn
> 
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>

Thank you.
You missed John's and mine review tag.

Sebastian
