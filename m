Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C398254861
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Feb 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752913; cv=none; b=Ae/NjcPgJ/o+hvO/UgCDWTte4WJyoa6v9hFXSR9/SNc3PHr071Vm7EBk0XtUgrEdR0tZaK2bOsG2imeLbjY8otVXu4xG61NAViTb/1uw+X18hJm7umKDeY54u1Ug75FchxsRk/IkLLgIXeDCERpEqJgSDyJHxfhqpx3ppOnJ794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752913; c=relaxed/simple;
	bh=hrOAWKr4hEC7OU+j7reGw8DdeCu0IP7h6/HU0sY41DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htWmE8ePHTQv6gqyP/RiubmgpqQmK12jsicCYRAKjR4GYaO38DDxd5/fq1nNhDj6uSAjV/q5D4iefzRVJ4RkdI9Odq5lvUZ1M/uOPOUG3HrX/BY45p+pSCgxtyQhv5mXgm+ZU7KbVVkFB/Zkk5Uk4a96QR/YIozNJdmZuvKsaFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q/9GuOW5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8x+ntldY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q/9GuOW5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8x+ntldY"
Date: Fri, 28 Feb 2025 15:28:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740752910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrfcTrIZ8fw4RGguIBkE0JrTZR7ePsKi+tTpkW08sBo=;
	b=q/9GuOW5a7u/1P6qXmYLc3LqEWf2ko70UCGSY9OF3IVXSRQ5nSQhpaao/dwt5PsnFN4+wR
	Zj9dbLbHnqINt8fyjoGjFkUTVs1c8M+caFq4Qalh+CCjGE7UDxNt1OlvI/5IbN/o02S5XK
	qSaUOU16/avsYHG5YWO7B11qo7O6P20RbufjkzN+nr7wpLjIx2FGeH5olBW+KUvp3BT976
	PodPayPWRSWx5GD0OagNp4Fua+XOGAfT58rHKlYKhbQlZRBC0Pmn/mWudU/5opowdMXQZZ
	8vQoMjjV5IWW1Gk8MG5cqQ4KPMCyZIi+fEeCeuiMO93diqRoVtRaBU+w/ONaEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740752910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wrfcTrIZ8fw4RGguIBkE0JrTZR7ePsKi+tTpkW08sBo=;
	b=8x+ntldYg1H9NMVi+jwPHtHBfkwWoW0gXnpAM/eNmYy/2P+Tmgz0peQYkDyVJGI3kJpnq5
	XhXtUpqox9fquFDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: Linux RT Users ML <linux-rt-users@vger.kernel.org>,
	Florent Carli <florent.carli@rte-france.com>
Subject: Re: "BUG: scheduling while atomic" with nested KVM and LVM snapshots
Message-ID: <20250228142828.wQvZ_Tpm@linutronix.de>
References: <Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local>

On 2025-02-28 11:44:30 [+0100], Yoann Congal wrote:
> Hello Linux RT users,
Hi,

> I got a setup running nested KVM virtual machines on PREEMPT RT kernels
> (all 6.12.12 RT kernels from Debian):
> The "physical hypervisor" runs "virtual host" VMs which runs guests VMs.
> 
> When using LVM snapshots on the "virtual host" (ie the middle one), I
> randomly get a "BUG: scheduling while atomic" trace in the
> ext4->dm_snapshot callstack (full trace bellow). It seems to happen more
> often when the whole system is loaded. There are multiple BUG traces
> each time with slightly different stacks, the deepest common function is
> do_origin in [dm_snapshot] [0].
> 
> Does that ring a bell?
> Do you have an advice on how to debug or even fix this?

dm_exception_table_lock() is a bit spinlock. This needs to be replaced
somehow. I have no idea yet.

> Thanks!

Sebastian
