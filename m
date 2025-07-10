Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3919172602
	for <linux-rt-users@vger.kernel.org>; Thu, 10 Jul 2025 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129018; cv=none; b=SuQ+30TIppqd9PBxcunvJ1IyjSEs2C7nsEMa+QC3Rndgj4N65wAAVKXeT5YT74k5OGkuiQgUXX4JiXSnhZ4YFoiFGI6G6/GyCv3YZcfXBlKDPahvBEUHSJdPKKymCLO3HW0kpu2P4h0RSlO3vsBtBwWxOxQqUhCM1A3htb/kVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129018; c=relaxed/simple;
	bh=aLDHg92V75Rj4XJLC1A9CCY+LjpQkBCkXgC6W8/cXpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZwUkVw9uEJEJxs5EeFMBr7mQwTUJHtAENS2J6dVvVRI041aIX5M3BP6UWIBbp37xRN+tw7X7/SPvJpVmSfjqGxhXP+8Gc/m1Pjo7k9gPMiauPP6xDS4yxv1w5jF2uoMHofAmqw0MDtdBJu4Mero0yaTUACuDAh9Pok9/VZ+RdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYpcZujD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CCAkeryw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYpcZujD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CCAkeryw"
Date: Thu, 10 Jul 2025 08:30:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752129015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sRdUqJjRDXKQa6NQYpQE+ckcA6YtCcbj5vZJklfRA18=;
	b=cYpcZujDbNh9B6/NbLvQQw1Kht+CgA/cSlkZ2L1MIopf++un9VlvT35zeEix7QUG+uwC3H
	qCOChh2K6EggkM4k5Lu+Stbf7o1MwV7e5eyP1M7RPETg+I8lNRrEZVTp6wC2hb2eFxuWQG
	OSC/aT9PtnRBv80hkWsCBV29sNxaTjxb2euNezy3uzmil5adzaJLyEECHACFLPh/T2TDOm
	lKY+MT2axbIOYGZCowmg9mB98Rqo9j/VYMzrjTzkzvXtF1XyENYFSFHBuvNLxKgOeVR0nz
	bmpz3G7AsVrc71e3kCs6lorD3VttKmv6yhT6Fep5HFIykS7CW0wDzfCrFXS5tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752129015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sRdUqJjRDXKQa6NQYpQE+ckcA6YtCcbj5vZJklfRA18=;
	b=CCAkerywn1eJ+UnJPqqXMR7WTXCCc39pEF8gTfbmEH3iso4ETorQyY50+ogKLvJvZlWt3b
	HGLWPAXCRFUtnwDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
	Ben Hutchings <ben@decadent.org.uk>, linux-rt-users@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Debian kernel maintainers <debian-kernel@lists.debian.org>
Subject: Re: PREEMPT_RT vs i915
Message-ID: <20250710063014.eOrcpX6Y@linutronix.de>
References: <7c42fe5a6158445e150e7d63991767e44fc36d3d.camel@decadent.org.uk>
 <aG6nMhimN1lWKAEP@intel.com>
 <20250709194443.lkevdn6m@linutronix.de>
 <aG7MckLkTuzZ5LBe@intel.com>
 <aG7na/6m/IcrJ3xx@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aG7na/6m/IcrJ3xx@lstrano-desk.jf.intel.com>

On 2025-07-09 15:04:27 [-0700], Matthew Brost wrote:
> > And IIRC the other remaining problem with RT was the spinlocks used
> > inside tracepoints (which is uncore lock, and probably some vblank
> > locks). So that too needs some kind of solution because it's going to
> > very hard to debug the timing sensitive parts without the tracepoints.
> 
> A bit of a drive-by comment, but taking locks inside tracepoints seems
> like a pretty horrible idea in general. We've managed to write an entire
> driver (Xe) from scratch and bring it up without doing this. I'd be very
> surprised if this is truly necessary in i915.

Steven made suggestions how to get around it make it work but my
impression was that this was not appreciated by the i915 side.
The general unwritten rule is to not to take any locks but simply assign
variables.

> Matt

Sebastian
