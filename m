Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C371A0728
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Sep 2025 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080999; cv=none; b=J85nPGf6VnWpjdxiZ6Vw1SoBcsHMItHXE4AFJEu4bYzzfUcinpf64RMyDZnh8hZQUh3BNTO2KyM+B3Um7D8eV7gppS8wepWQCXE1XHin9snjTR79BhwLlIsAk30FAPyYy27vDw5wFyr20Xv07T/1VJAr5lZuYGaeg++Y79I+oXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080999; c=relaxed/simple;
	bh=wO2ewgLw1pAmzKTO66fNA+QZsZ4gNQmcpk2APGSqLj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j4qU6IPNv66aya1sKMT23jSns+lT+oCdsaxGEGVwptYITCyfsZbGTp9QB9MQCmWBW69z6l97J8f2fIe5BZ2F7ABRxGnkRPcA8nGntqdKp39Oy/zWungjT0/WJCxBkXMApHE700aiz288ErFHyyajZ+F0qYBqfV8+BXxgEzygXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lxMa0Y3i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NfgPnJ3k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lxMa0Y3i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NfgPnJ3k"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757080992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wO2ewgLw1pAmzKTO66fNA+QZsZ4gNQmcpk2APGSqLj8=;
	b=lxMa0Y3i+nN+fDtqARQjoZplk+Slidu44rr8FcKUuZWeRlJqr1vLMkHyoG2YlkfuVARu2T
	rQ5TMoL2EvOIL4VWkFQ6n0gfW4w71aLJ3CxfVAtw5q2L52Jo1DrmtPDo6gO/krSHmjuxSD
	HpTBC2/XiNRXsLdkqsCYrEO+MULjeZt3Y4w4aT0Y+6WqiSJCpq9idMmcASP9RoXB9S7Dcs
	TX9EFIu/sPVdsPeodgzeUZF05otxxel0YdpWe8gMM5MQbaFCxHcgprp72O6BDwwSlPzOj9
	89WJa6vlwCeKKeTg0Xs1IFD8xwVwaaxaTpFI/j68bpu/B5Y17vj34cdOntWjEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757080992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wO2ewgLw1pAmzKTO66fNA+QZsZ4gNQmcpk2APGSqLj8=;
	b=NfgPnJ3kyaflHCDWh+3NDrztOipsgITdTtdrxtyloaml5seRW2nrDNSer2cdYU6haftfFL
	IrN3w+ThDkmriyBA==
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, Daniel Wagner <dwagner@suse.de>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Daniel Wagner <daniel.wagner@suse.com>, Clark
 Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>, Luis
 Goncalves <lgoncalv@redhat.com>, John McCalpin <mccalpin@tacc.utexas.edu>
Subject: Re: Large(ish) variance induced by SCHED_FIFO
In-Reply-To: <afc4c145-4758-4924-b106-e7844624d269@free.fr>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
Date: Fri, 05 Sep 2025 16:09:12 +0206
Message-ID: <841polf13z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-05, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> (I used CLOCK_MONOTONIC_RAW.)

Not really relevant to your issue, but you should always use
CLOCK_MONOTONIC.

> It looks like there is some kind of 50 millisecond quantum
> involved somewhere somehow.

Did you forget to disable RT throttling?

$ sudo sysctl -w kernel.sched_rt_runtime_us=-1

If you check the kernel logs, you would see a message about throttling:

"sched: RT throttling activated"

John Ogness
