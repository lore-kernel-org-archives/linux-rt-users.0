Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC617F4F6
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Jan 2025 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738223430; cv=none; b=SdS/uDPLj14jNNW28hOnWoWu3YkuB7JitmclY5tBWwx6mPqGMIlHQC/yRj9IJs1EfoJet1SyErTGPHmgB7e+6fvZWh5H46TPuIdWrwSMoUVkF9a9ES9iIFfhLDx+dX6MArF2rZhT2pGwjnwAWIxnp0nk8xeW2RHUaqPIFSioWic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738223430; c=relaxed/simple;
	bh=rSlvfd7khr+bQcWRmY/mkwiy8fdr+KV5U/iL0aaiT/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYK0z7t6UHTF2UJzHOonctRNb51UMvcTMwG0bvP1Lh72NCiuhVt8LoZWydFXB2zgLaTu354vYbIYBocMrZ5qgDrbrx6tR6foMHzNnVut7q7u7PG28j9RSovnUT+QZmEchcmG+PW7WxurduypoBEvx+2OZi0171w1tfTpjeR3F1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5F8DrMb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cIBYE4L/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5F8DrMb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cIBYE4L/"
Date: Thu, 30 Jan 2025 08:50:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738223427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qqe3IPj3e8sJc9iS6W5oMiFf9lmmOlDAK9M1jnnkHhI=;
	b=L5F8DrMb+an4M0+gvXjwLNwmmb/f4gxi4iRxobPKh6I1dJljE9jFTwWDmLPQd9VZL3s2X0
	wcV7+WbpPJgYrYxhq5qeUn+EwOX8IABLQjQ27XRz2SqWIt9JZy5lWzDDHz2v8JYE8UEBzr
	YJTwmYQz/Gd9SIYpjzdsaZuQOe4DgMyqHEG4IKl9/vsp8sJ7I9I2Q+VNxoT43+jq/e38Pd
	ziYZ2clWJjmyITDfreIjMTM9zvXUB5JdS7HAG0Gxa40DOaOpPMvqHUeEzBmnxFDqZKKFSQ
	byKDU6kBqeTrFz+UYU15dMOBAqpMA9WmNOpzhItG6zXTR0nAweubQUA2MGkQ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738223427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qqe3IPj3e8sJc9iS6W5oMiFf9lmmOlDAK9M1jnnkHhI=;
	b=cIBYE4L/IeRPed1buuApBfFyoiDPjTsSbEJxB/z8iTGRmheO/qh5rNaD02jteYS3ijR8zu
	7jLEH+gsO0w/grCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jillian Donahue <jilliandonahue58@gmail.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petesarik@suse.de>,
	linux-rt-users@vger.kernel.org
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
Message-ID: <20250130075026.RVen6mGf@linutronix.de>
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
 <20250123142324.449f21ba@mordecai.tesarici.cz>
 <CAArt=Li11gQ1XsfpsZuV8afd4E5UjcuHa=r1Ng9q6HG6AjxJWg@mail.gmail.com>
 <20250129103925.7TEmpCt_@linutronix.de>
 <CAArt=Lj5byHfx7SJXzHiB0ecFDWjhjODyM05=5y27PYj8bGaUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAArt=Lj5byHfx7SJXzHiB0ecFDWjhjODyM05=5y27PYj8bGaUQ@mail.gmail.com>

On 2025-01-29 14:59:19 [-0700], Jillian Donahue wrote:
> > So a simple "tasklet_hi_schedule(&midi->tasklet);" instead of "f_midi_transmit(midi)" in f_midi_complete() might do the trick.
> 
> This fixes the problem - do you have any insight to how this worked in
> the first place? Trying to understand the change.

There are possibilities. The problem is that you send a packet and it
completes the same moment and the completion callback is invoked which
deadlocks.

Now:
- PREEMPT_RT may have moved the timing a bit (makes it behave a bit
  different or simply make a UP device behave like a SMP one) to the
  point that it sees the completion of the request where it did not
  before. So does it occur without PREEMPT_RT?

- It never did work in this combination even without PREEMPT_RT. The
  driver (f_midi) was never tested with the USB device controller you
  have and the one it was tested with behaves differently so the
  recursion never occurred.

- It is an old driver (f_midi). It was never tested on SMP or with
  enabled lock testing. On UP spinlocks end up almost as NOPs so a
  deadlock (as in this case) will not be observed.

Either way I would blame f_midi here.
Once you have the pieces together, mind sending a patch?

Sebastian
