Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773E2472B0
	for <linux-rt-users@vger.kernel.org>; Fri, 12 Sep 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663073; cv=none; b=MisK/Yc1uWgEB3Ml3H5qM39h3g3VZx0d+/K2RTyjYloUwcj2dW/5wdmEnN1a9tzBc0lNK6lWOpzepF7kry/G+kyZ1T6nyY8mK/R8anjuu3+RHqE+MVLTWarHSX362sD2yA+JDSc3w/PqX3+HITtFP0yJKw8D+O0O3hPz2y8I4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663073; c=relaxed/simple;
	bh=uzV0vqtRyJYZ+O4k0aNUIgKFUPOpMrWE4WMQjJb6bQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPGka0sPg19S/YgSHb+f8w/b7Ym71PQ0dmm4p/B7JGb3/5LHwPUx3zX9bPn8LMvKSrj0YEvGPubFuCjmT8q0rXf8uqS1hDbQ8E11UMGg+P6BOlWoVSaa0xpAXXL65COr2/XbOlJFS8HMbDsjsE/g2m8sKwVj8VgoO+ze4nD0Mt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wheMXC9a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7qO8QaaU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wheMXC9a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7qO8QaaU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wheMXC9a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7qO8QaaU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wheMXC9a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7qO8QaaU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CBE65CDDC;
	Fri, 12 Sep 2025 07:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757663068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZkSCL+XGcXr2oT3aoR7SVnX0XfuINat01GYTI82ZSQ=;
	b=wheMXC9afGAoZYUeFQl0Tr7rJbS5RwiCYO0uw6rtIBte8ut+pS2KmoCXht4Xvz+Goa9BSO
	zTk3k0rSc0wiQ+lTejd0a4qyvDec+yKos8mWhGtxaupi1poxlpzMnv47KiCfdHmhLTheXV
	6cQr1h2HrO7hH532Kyquv1MiKn7KhqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757663068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZkSCL+XGcXr2oT3aoR7SVnX0XfuINat01GYTI82ZSQ=;
	b=7qO8QaaUu4TJmvEQqi/OjuSDoxuFNqo+eHxeeEA88Cehsngkp5yRDT+589Baev6koNBUsn
	Oa1Vw+/wkrnGI8BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757663068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZkSCL+XGcXr2oT3aoR7SVnX0XfuINat01GYTI82ZSQ=;
	b=wheMXC9afGAoZYUeFQl0Tr7rJbS5RwiCYO0uw6rtIBte8ut+pS2KmoCXht4Xvz+Goa9BSO
	zTk3k0rSc0wiQ+lTejd0a4qyvDec+yKos8mWhGtxaupi1poxlpzMnv47KiCfdHmhLTheXV
	6cQr1h2HrO7hH532Kyquv1MiKn7KhqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757663068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vZkSCL+XGcXr2oT3aoR7SVnX0XfuINat01GYTI82ZSQ=;
	b=7qO8QaaUu4TJmvEQqi/OjuSDoxuFNqo+eHxeeEA88Cehsngkp5yRDT+589Baev6koNBUsn
	Oa1Vw+/wkrnGI8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B719136DB;
	Fri, 12 Sep 2025 07:44:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UNV1EVzPw2gkHgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 12 Sep 2025 07:44:28 +0000
Date: Fri, 12 Sep 2025 09:44:27 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Leon Woestenberg <leon@sidebranch.com>, 
	John Ogness <john.ogness@linutronix.de>, linux-rt-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <williams@redhat.com>, 
	Pavel Machek <pavel@denx.de>, Luis Goncalves <lgoncalv@redhat.com>, 
	John McCalpin <mccalpin@tacc.utexas.edu>, Frederic Weisbecker <fweisbec@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, agner@agner.org
Subject: Re: Unexplained variance in run-time of trivial program
Message-ID: <1b76251b-6f57-4d72-bc48-b8df6ac077b2@flourine.local>
References: <3220a6ab-19e5-4705-865a-1e1c37b67ccf@free.fr>
 <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
 <84ms73kdn2.fsf@jogness.linutronix.de>
 <11dfa501-e280-4b50-a593-a4b153019b40@free.fr>
 <ddb85a49-934b-4c11-ac2a-c8a562e76e7e@free.fr>
 <CAMjhiJjMOQN-nWd+KP4JBBNHf20M+J2fXAuTTvowXctJgvGOcQ@mail.gmail.com>
 <41b7c365-62c2-4bfa-acd7-db73dc9f94f0@free.fr>
 <c462578d-4010-4063-9f01-54008ac91f95@flourine.local>
 <60e4eb3c-3dfc-4212-bdcc-229a5b67b975@free.fr>
 <913e8f73-d10f-47c9-b608-f8f9cb9eef1c@free.fr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913e8f73-d10f-47c9-b608-f8f9cb9eef1c@free.fr>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[sidebranch.com,linutronix.de,vger.kernel.org,goodmis.org,redhat.com,denx.de,tacc.utexas.edu,gmail.com,kernel.org,agner.org];
	FREEMAIL_TO(0.00)[free.fr];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Fri, Sep 12, 2025 at 12:15:12AM +0200, Marc Gonzalez wrote:
> On 9/11/25 23:29, Marc Gonzalez wrote:
> 
> > - Not sure what the int_misc.recovery_* events measure???
> > They're documented as:
> > "This event counts the number of cycles spent waiting for a
> > recovery after an event such as a processor nuke, JEClear, assist,
> > hle/rtm abort etc."
> > and
> > "Core cycles the allocator was stalled due to recovery from earlier
> > clear event for any thread running on the physical core (e.g.
> > misprediction or memory nuke)."
> > => In my case, they're probably measuring the same thing.
> > Weird that the description sounds a bit different.
> > Need to read up on processor nuke, memory nuke, machine clear event,
> > JEClear, assist, HLE/RTM...
> 
> Daniel, seems you were spot on when mentioning side channel attacks.

I'm sorry if I sounded patronizing, that was not my intent. After we
ruled out the OS noise the only thing left was that the runtime variance
is from the CPU itself.

> https://www.usenix.org/system/files/sec21-ragab.pdf
> 
> I need to truly read & understand this paper.

Skimmed over it, it could explain what you are observing. The question
obviously is which part of the 'bad' code is confusing the CPU :)
