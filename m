Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745AD30F534
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Sep 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491210; cv=none; b=CZ5Spgdg14gbFd7Ew+GefvSm7rqObwlsUJFqUDDUblZsxG4vVS/sh3Dir61vAtgVsN1NhLndfMiVMsWAArF1raCD/W8JzNGXqUnZ5mOoWJcQUOiqFoR05l5dtVB+qsCF1F1QZUiEF/8Tq8kgc+6vPZOT8yJmAoxU0yXKv92B6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491210; c=relaxed/simple;
	bh=iUYuMGJ59dhpkhJu36EDSpYG9cBgoPvPuMlKVviaNQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPcZ4k1OOmgFjxqN6CX9Ju09ASu0eCdkjyCMmK22RFmI6OhbAUYSspg+PXcbk1AC5tKJxCvIOtUcM8u1p89gMkfthBwk7KLmd9AL3KnQFMLUla7IyITZsLMlX60at1IyOSTcC2ju+W1WiHUYa6QjQDubSTS4MYtHPfBKntAnzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kd3osHgQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8FuTzBxw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kd3osHgQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8FuTzBxw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kd3osHgQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8FuTzBxw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kd3osHgQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8FuTzBxw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F1645C92E;
	Wed, 10 Sep 2025 08:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757491200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMd3oxijO5/cda2pyN9fVUmZJYHxWqh8Ou5pcpvpP4c=;
	b=Kd3osHgQDsfQr7YFnWt5jN4Uz640zzwOg8DNshODOHFNEZm04NNsS1ZhSJbV5ihN4G3JXq
	96QF266yYDIt77AOkUhJ6ACZAR+SH0yDwMZY2sQ9LUadQgo66gKfyf6SZpPkoD0YNeQZun
	w7mTgXi1+aXo+V+Jz9YKHHs4P+fo1aY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757491200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMd3oxijO5/cda2pyN9fVUmZJYHxWqh8Ou5pcpvpP4c=;
	b=8FuTzBxwcyW67S1xj/yn6HEtjTJetuAFfjZthiUxhu7RjOtKNp4aDnyT7VNFKO51SGuJXP
	JhxvtNUPMEwblqBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Kd3osHgQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8FuTzBxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757491200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMd3oxijO5/cda2pyN9fVUmZJYHxWqh8Ou5pcpvpP4c=;
	b=Kd3osHgQDsfQr7YFnWt5jN4Uz640zzwOg8DNshODOHFNEZm04NNsS1ZhSJbV5ihN4G3JXq
	96QF266yYDIt77AOkUhJ6ACZAR+SH0yDwMZY2sQ9LUadQgo66gKfyf6SZpPkoD0YNeQZun
	w7mTgXi1+aXo+V+Jz9YKHHs4P+fo1aY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757491200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CMd3oxijO5/cda2pyN9fVUmZJYHxWqh8Ou5pcpvpP4c=;
	b=8FuTzBxwcyW67S1xj/yn6HEtjTJetuAFfjZthiUxhu7RjOtKNp4aDnyT7VNFKO51SGuJXP
	JhxvtNUPMEwblqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BAE213310;
	Wed, 10 Sep 2025 08:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IRXSBQAwwWhvIwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 10 Sep 2025 08:00:00 +0000
Date: Wed, 10 Sep 2025 09:59:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Leon Woestenberg <leon@sidebranch.com>, 
	John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <williams@redhat.com>, 
	Pavel Machek <pavel@denx.de>, Luis Goncalves <lgoncalv@redhat.com>, 
	John McCalpin <mccalpin@tacc.utexas.edu>, Frederic Weisbecker <fweisbec@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Unexplained variance in run-time of trivial program
Message-ID: <c462578d-4010-4063-9f01-54008ac91f95@flourine.local>
References: <84ldmp8ewv.fsf@jogness.linutronix.de>
 <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
 <d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
 <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
 <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
 <84ms73kdn2.fsf@jogness.linutronix.de>
 <11dfa501-e280-4b50-a593-a4b153019b40@free.fr>
 <ddb85a49-934b-4c11-ac2a-c8a562e76e7e@free.fr>
 <CAMjhiJjMOQN-nWd+KP4JBBNHf20M+J2fXAuTTvowXctJgvGOcQ@mail.gmail.com>
 <41b7c365-62c2-4bfa-acd7-db73dc9f94f0@free.fr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41b7c365-62c2-4bfa-acd7-db73dc9f94f0@free.fr>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2F1645C92E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[free.fr];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com];
	FREEMAIL_CC(0.00)[sidebranch.com,linutronix.de,vger.kernel.org,goodmis.org,redhat.com,denx.de,tacc.utexas.edu,gmail.com,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Score: -4.51

On Tue, Sep 09, 2025 at 10:30:49PM +0200, Marc Gonzalez wrote:
> On 9/9/25 21:34, Leon Woestenberg wrote:
> 
> > Basically, you are reverse-tuning a multicore CPU system,
> > that is heavily optimized for time-sharing and overall
> > system throughput, back to act like bare-metal single-application.
> > You can get close, but you will never reach the determinism
> > of say, an Cortex-R(ealtime) Core.
> 
> This ignores the fact that I've been testing 2 programs:
>
> - P1, toy code that just calls dec 3 times in a tight loop
> - P2, a few memory accesses, everything fits in L1
> 
> I then loop P1 & P2 2^16 times to compute their average run-time.
> 
> Over thousands of runs, RUNTIME_P1 is ALWAYS the same (within 30 ppm)
> 
> Over thousands of runs, RUNTIME_P2 varies by up to 12 PERCENT (!!) =
> 122k ppm

Modern CPUs are highly complex systems with their micro architecture.
The result is non-deterministic runtime behavior. I can't tell what you
are measuring is the ballpark of non-deterministic runtime variance. If
you don't want to read through the CPU manufactures documentation, you
could check if the Spectre and related side channels attack papers give
some clues on timings behavior?
