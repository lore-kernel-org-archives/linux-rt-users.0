Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB82231836
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Sep 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427779; cv=none; b=MvNr6bYqeHtKcOxb7jcmChcmCMe9RYSDGurL7KGGbR2XSyNfD+cOSu/ktACpyBLB3lcj68Iu3u/7Bid0NWvIKQq9xprhC5kcemQqvV6PuowVln7Zpnsrj2tHvxjJAomio5CmGLlUH5ew57zAgP7XAGSnQ4b2vkLRxguRNM2Fhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427779; c=relaxed/simple;
	bh=YftkAtaQjcXFZ/orVg1QS0wYdYzZ6cnOFe75kAvjTUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7CGdtU3HfbIuj2l8qPOeSsaPnpMUfmSDNbfKHTrzjdoFqIuDuIsgZCBLzT1SXIXIpG7e5Zv2MH2x1c5UJJntukf7LhKztRJD8GLLejp70qBpeFXMvLL7TIIxOjxJWLm5y1hIu0nIpo8ojoJyct8iEojLMzzO63WKVaxCW5XNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id AB3E311A43F;
	Tue,  9 Sep 2025 14:22:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id C5D992F;
	Tue,  9 Sep 2025 14:22:51 +0000 (UTC)
Date: Tue, 9 Sep 2025 10:23:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Daniel Wagner <dwagner@suse.de>, linux-rt-users@vger.kernel.org, John
 Ogness <john.ogness@linutronix.de>, Leon Woestenberg <leon@sidebranch.com>,
 Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <williams@redhat.com>, Pavel Machek
 <pavel@denx.de>, Luis Goncalves <lgoncalv@redhat.com>, John McCalpin
 <mccalpin@tacc.utexas.edu>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo
 Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Unexplained variance in run-time of trivial program
Message-ID: <20250909102339.26604f42@gandalf.local.home>
In-Reply-To: <1e374b4f-5410-4986-8849-ed2e8acdc23f@free.fr>
References: <afc4c145-4758-4924-b106-e7844624d269@free.fr>
	<841polf13z.fsf@jogness.linutronix.de>
	<42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
	<84ldmsevcm.fsf@jogness.linutronix.de>
	<3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
	<84ldmp8ewv.fsf@jogness.linutronix.de>
	<3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
	<d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
	<3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
	<0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
	<79de8d5e-bf07-4c24-89e1-1ed5bfab9361@flourine.local>
	<1e374b4f-5410-4986-8849-ed2e8acdc23f@free.fr>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bmbmxxgwc9sychg8ruwdhpo6717aojgs
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C5D992F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18BrNIo2OE3QIO66gT0y2kVtK5GlP9Bytg=
X-HE-Tag: 1757427771-805249
X-HE-Meta: U2FsdGVkX19BaPQmaYb00nCN9I7HXEQh9kiEIgSqgXjmHZg47wR8sbFXhh3rB/wQIM0SkQnmTpv3KqGXS7bqA/SYG8UY70t/RZdsbrpxVwHEVCE1XWcT/+bLsyU0NT/+v7A1UOtMokdX9l+qHCi4dio7UHhRp0T06fvaFUL/YMmrEybT0H3MGkQlhgVMXnzQ7XPKq/Xr3gRJRhqhEkoYIb5ZBFofrhAsQr/dPKFtpG7vqt7r4q63/j+R2bVDctxYmGc+Tl8sGBW1p/ywbWUvPLRRnOlB4zMxPC7lpcebSCo9uzHW0PUmFqsc8Q4H8q7O

On Tue, 9 Sep 2025 14:42:54 +0200
Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:

> > ...there is no SMI running on this CPU, and no power management running
> > (also in the BIOS settings)  
> 
> Actually, I'm 99.9% sure that clock source accuracy & SMM are red herrings.

You may want to run the osnoise or hwlat tracer to see if SMM or anything
else the kernel does could cause issues with your tests.

-- Steve
