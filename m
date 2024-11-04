Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00F25776
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Nov 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731252; cv=none; b=L2f71dfAjCBRi+ezx5u8TF6ffRd6Y6ULQP4OIPdq7oenpipztwmFcugb0MF2fZZTJv8YcUWlrdWBycyWaWR1sN+jSN1hUBUnE+l2zP8JVexWimLjrseVIz6Out9RFgWs+tmn1KfKHHhm4q+iEJs/JZM+g/wqeETD3ySO9zYCaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731252; c=relaxed/simple;
	bh=FIN4xvVGvkHE7SwBV2m59rE4uTtjWI8cgxQ9JJgGnxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jej+ipvlIz+3AuHW2+UyTu1nQcji2MbHWI7bDsBfyH/DM5DWbx3Siq5zMEPFuzI3DDwkmgMeZwNYm1ru9zlNtMaRzaNs9JHylZfX7eG+A8X/yI4RTHyGNnIxxkFX+0WorqOxnoPzG/UrA5TZA+9G49eTujVhw/AcYP5T3k2Ckxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0I5bjTPV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8D2A05J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0I5bjTPV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8D2A05J"
Date: Mon, 4 Nov 2024 15:40:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730731249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSLeNpZjZ91E2yLVKIgjPQrMSe6Zcd+z+CIn62HVGfY=;
	b=0I5bjTPVDGarYNJSR4RG5Hxa0UyRM494Bz/b0NBw82qGQPZe+WKsiGiD3xNtrbdfaJRIjW
	msqLfu7Uz7B8ByTc0jpTCJN9S8qCRAKjwzsAbTTUL23PoC93r8nDshTk9xrvf6CUqssNQb
	o5TfzmCaZ4sDlXlI8oxBAHic7z55gMOEXbo0q5VXv0fNysVM0VpyGoHt15SIdBwQzJoNmg
	oIwz5+GiFgnrH7D6UGHBvu84+wbwDbWHg5aiEbughQkE4ssW3esC7woGi7k7vGmhJYi6em
	DqCoqx4VLMDiODoaQgHi8ym2JT+ATmuQbCuvmYNSqi5J8NXYlMGXXkwP1SPotw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730731249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSLeNpZjZ91E2yLVKIgjPQrMSe6Zcd+z+CIn62HVGfY=;
	b=Q8D2A05J0zOw6mwzHxx/mFAxkp4MRis6LIlC7bOBa+EnYC3NBJZ6OH/9O4PVCdn0dc2m/B
	+HRAz0eWstvVTJCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Derek Barbosa <debarbos@redhat.com>
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org,
	ajhalaney@gmail.com, john.ogness@linutronix.de
Subject: Re: [PATCH v3] printk: nbcon: Fix illegal RCU usage on thread wakeup
Message-ID: <20241104144043.oOsOBXP2@linutronix.de>
References: <ZyjaTu8ktE119iwW@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyjaTu8ktE119iwW@debarbos-thinkpadt14sgen2i.remote.csb>

On 2024-11-04 09:29:34 [-0500], Derek Barbosa wrote:
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
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>

  \o/

Sebastian
