Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585718FDDB
	for <linux-rt-users@vger.kernel.org>; Mon,  8 Sep 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347355; cv=none; b=fn8L/FMVeqwoLr9zJemnN06jdU1Kw73COn/53lGsI9qOdn3crW4r03/idenDhf8O9VJf4nS0W6hzylZcp1aAxItkwScgGR8NvjMMOxlrrv9QdKTCYFeMbsH1/3poLKQmPiIYwEjcDIsqmut7wdJ5Kolu8j5RU5pE482yhEVV78I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347355; c=relaxed/simple;
	bh=nl0epWdJHZz6aZm9E1D6tuJ0WYVCSNRMpcH4Fa3j6v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqIUVxyS/M7j/MhAsx0v7KvEZnOH8U5MCLoIzVw5e9byTnwUml6JLU5qIbX78SojEXg0qOnwBvlTWlqS+X70on5XYiM0NIbN3XQkRtnZh2xfi1RDaDwScbzpqHF+yM7r73EsMSAiLK00kU8RqLNHQLEr7B1kcCfsas18kW+l9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aYXik38U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4hJjj9Uk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aYXik38U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4hJjj9Uk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aYXik38U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4hJjj9Uk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aYXik38U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4hJjj9Uk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1FE0E27494;
	Mon,  8 Sep 2025 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757347351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmebEy0e8usYZjEFhYRTPosriJ9Rjkj6wDN8JPYW7wU=;
	b=aYXik38UWW66A+6CxlQOJ68zZJPPc/JVcfEoKtpeJXLxSAJLDpieelJoMXz+p5BatIKZOn
	UC1bCWK2TM7Qs2rzkOEkErcIG59mrrBHBHNe/91IbkCp2eVS3ye9JS9N2GFrL4m2yymi4Z
	XUyS3xLAzGFFeA5ahI+Uwbt6KmLMOSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757347351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmebEy0e8usYZjEFhYRTPosriJ9Rjkj6wDN8JPYW7wU=;
	b=4hJjj9Uk9S4Gn9yKGkqqCXEmoYs1xEJgJoIYFJEMxy7421R7yX2Dmb3FTNIRoBkv/cIKQ6
	eeVhI+gGgFI6kXBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aYXik38U;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4hJjj9Uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757347351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmebEy0e8usYZjEFhYRTPosriJ9Rjkj6wDN8JPYW7wU=;
	b=aYXik38UWW66A+6CxlQOJ68zZJPPc/JVcfEoKtpeJXLxSAJLDpieelJoMXz+p5BatIKZOn
	UC1bCWK2TM7Qs2rzkOEkErcIG59mrrBHBHNe/91IbkCp2eVS3ye9JS9N2GFrL4m2yymi4Z
	XUyS3xLAzGFFeA5ahI+Uwbt6KmLMOSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757347351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DmebEy0e8usYZjEFhYRTPosriJ9Rjkj6wDN8JPYW7wU=;
	b=4hJjj9Uk9S4Gn9yKGkqqCXEmoYs1xEJgJoIYFJEMxy7421R7yX2Dmb3FTNIRoBkv/cIKQ6
	eeVhI+gGgFI6kXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ACEA13869;
	Mon,  8 Sep 2025 16:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gKlYAhf+vmheaQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 08 Sep 2025 16:02:31 +0000
Date: Mon, 8 Sep 2025 18:02:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Leon Woestenberg <leon@sidebranch.com>, linux-rt-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Wagner <daniel.wagner@suse.com>, 
	Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>, 
	Luis Goncalves <lgoncalv@redhat.com>, John McCalpin <mccalpin@tacc.utexas.edu>
Subject: Re: Large(ish) variance induced by SCHED_FIFO
Message-ID: <d5f3d4c1-714b-46d4-99e6-c71ebf64e76b@flourine.local>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
 <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
 <afc4c145-4758-4924-b106-e7844624d269@free.fr>
 <841polf13z.fsf@jogness.linutronix.de>
 <42c5fb53-d423-41a5-80d9-557ff2a3e804@free.fr>
 <84ldmsevcm.fsf@jogness.linutronix.de>
 <3f1d4229-a95c-4d99-a98f-249d9e488b32@free.fr>
 <84ldmp8ewv.fsf@jogness.linutronix.de>
 <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe55967-b4fa-4bc1-ae2b-58b5d1bbf3ea@free.fr>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1FE0E27494
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[free.fr];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[free.fr];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On Mon, Sep 08, 2025 at 05:42:58PM +0200, Marc Gonzalez wrote:
> I've run out of ideas to identify other sources of variance.
> (I ran everything in single user mode with nothing else running.)
> Perhaps with perf I could identify the source of stalls or bubbles?
> 
> Hoping someone can point me in the right direction.

There are few guides out there, explaining the common pitfalls. I
suppose you have already found them. Just in case you missed Frederic's
excellent blog on CPU isolation:

https://www.suse.com/c/cpu-isolation-introduction-part-1/
