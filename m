Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DD20296A
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Sep 2025 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060755; cv=none; b=MKBSOKCEvflb+NrVMdSGdkZcE6/N2gVyLeWpNZgd0ZVXxl6y3oJQbRw/Mnk5QKqYES47QEVuy1rrEblXUSe3wFBalfw/IUgdSC3HIg6BnQaPgE+Ak7T3Nii14g0Pdu8pWU+xyDvseQHxDjxU8aJIgu6QFnyOwhnZxnpYQiEwu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060755; c=relaxed/simple;
	bh=TOmJ0HseSevcIBJHFahqWzz0hnk2bDHGp+LyepLxRfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apy5vaRkVsKYryljGpghYCvPvaiWXqRhaKsAfvtYCsox0N5ym8qZq/PF4xrmpHm4v/mIiJFxbLP0jccTpxpiOfi0lpDM70fzHsnfZX1akNAWod9viVv0PBn3QgAMqzTncXFxgP8R3+BA2mUmXIyATxO0Rd517XCONHe/1iPegb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uWlxbMUD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pr7Zamlr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l2qbM8QQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DB45cUxz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uWlxbMUD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pr7Zamlr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l2qbM8QQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DB45cUxz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 621CF20051;
	Fri,  5 Sep 2025 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757060751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxtNW6Tbs5tU8ncN2m/DHfsrey5scAdRTt051oJETFU=;
	b=uWlxbMUDelNWy5mt4BtjC9yrpRQgvmv73kyOGukGxRgTQEr7BcQ5ZPc1WD+rLlNHPYkCjd
	fzhvNYe/EJopYjM61+ptVHz/DvxIKc6bHJW0iu20kUiU+9ITqOyrMiDn5p64eX1T0dJ0KG
	+aquxM8bKELLYsM012lX4p1jJsQrGPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757060751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxtNW6Tbs5tU8ncN2m/DHfsrey5scAdRTt051oJETFU=;
	b=pr7ZamlrAKBGjwokyInHCtSokA4ffQUL7ZpQBPeslG894MXk9KYgRfFqe/SoYvCPKxvkFb
	E0nKcOzaObGTD0BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l2qbM8QQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DB45cUxz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757060750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxtNW6Tbs5tU8ncN2m/DHfsrey5scAdRTt051oJETFU=;
	b=l2qbM8QQCe+F1hoGXfSgs4Z6r7OzVH4Az7QXDgS7iS3OItSA6ahWn4/0j3/QZcT2/MP8cc
	TeLzCNYXedtCf2LaYrg2wXRCKU7+R7LZMLwmcQZq37kq/IAAUYxZv40bhamXHODmhN28dR
	D7gtfx/utTAhHTRD2GUVCgPoPwhBtSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757060750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxtNW6Tbs5tU8ncN2m/DHfsrey5scAdRTt051oJETFU=;
	b=DB45cUxzYKEcJdymsDr53VOPFj8fXcmJcDshSzLrbFSES1PsMdB6bRrwU3sHCyimUMSdeS
	MfFj3Iy3ZI50/MDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EC9913306;
	Fri,  5 Sep 2025 08:25:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NilBEo6eumjKGAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 05 Sep 2025 08:25:50 +0000
Date: Fri, 5 Sep 2025 10:25:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Daniel Wagner <daniel.wagner@suse.com>, Clark Williams <williams@redhat.com>, 
	Pavel Machek <pavel@denx.de>, Luis Goncalves <lgoncalv@redhat.com>, 
	John McCalpin <mccalpin@tacc.utexas.edu>
Subject: Re: Large(ish) variance induced by SCHED_FIFO
Message-ID: <ac1ef5df-aa30-4b63-9beb-3e0522dd3cec@flourine.local>
References: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f7496eb-bf62-4cc9-bef0-9cae97a93dca@free.fr>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 621CF20051
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[free.fr];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[free.fr];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Spam-Score: -4.51

On Fri, Sep 05, 2025 at 01:45:31AM +0200, Marc Gonzalez wrote:
> Then I run this script as root:
> #!/bin/bash
> 
> CMD="taskset -c 1 ./a.out"
> if [ "$1" = "fifo" ]; then CMD="chrt -f 99 $CMD"; fi
> 
> for I in $(seq 1 30); do
>   T0=$(date "+%s.%N")
>   $CMD
>   T1=$(date "+%s.%N")
>   echo "$T1-$T0" | bc -l
> done

This set setup is forking processes in order to get timestamps. This
gives you uncontrollable variance in the measurement. Use clock_gettime
inside your test program.

Also you might want to reduce the prio to 98.
