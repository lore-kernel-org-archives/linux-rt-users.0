Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03F1B78F3
	for <linux-rt-users@vger.kernel.org>; Tue,  9 Sep 2025 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416877; cv=none; b=DCV22G30+J5r2FVaWa8JYJb7GJjS3IcOLbn0uTTAmdZnswUjPctRZjw4yCYX7bW+AqkcJtfAYGLC3lbSlNRNytOQuvb156kGuR6wxaA+irFKhd6acmKktcyyWhcxPmE96wYptVKnx1tFvqQ3yWUCXqRo7zzIh/07Q2oqQ1b237E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416877; c=relaxed/simple;
	bh=VpYODHn/H9g4IphktpFYO9V2iZw71rIvpkd61jGXoIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkdmonjiolDEX9FygU+ncMNH9nTqbFn2AJY0CpjR5RCgV7n9SyfkZs/YwrSCoaChvWc5a4TaM1oQamzljAgAgsfE9ey8Do9MuhKZWp8zboxbi9hcjyGNLWoOesB5Nc/D9i4lSnmCOUV+TOFs3wX9AU/nKtcLVvTrlESOhcZrAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FL3OaVwX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pzI1p6yH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J5prGLAA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TyltVeqt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FL3OaVwX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pzI1p6yH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5prGLAA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TyltVeqt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E410D33751;
	Tue,  9 Sep 2025 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757416874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/wLJfJW7fDRhF8DyBKfFtUGe+MrbfXnX9W1eJnXlTo=;
	b=FL3OaVwX188qlNSZQ+SCNML69stM+bPGBaeak35MSjR6CH+MRyM1HIKv+doUKyPneZQAXQ
	2ia2x1y5HKZ2XkXhhcRMxG16qTo72ZaPSfi30xX4yAu8Rhd3ykDYScSbkC7n/x7aZLSp/f
	voALoZrKZ/2tmKWCJ2JTOW52YwhuhI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757416874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/wLJfJW7fDRhF8DyBKfFtUGe+MrbfXnX9W1eJnXlTo=;
	b=pzI1p6yHhylFHzeApha2AOH4qsFEEM9sgSLt8uZMEzw+r72VW6lzgEwzK/A7DPDV3abB4m
	Z8X2viIviKVQ3PBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757416873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/wLJfJW7fDRhF8DyBKfFtUGe+MrbfXnX9W1eJnXlTo=;
	b=J5prGLAAWA8VTZcBc+wkCMmR2OlOFvYmBYKkYXd5RwrLfyFQLiZx2acPX9jmdgvnn0ygSq
	h8e0rX3ZAzWApGD/bCe6+0M5kyM7oVmrk51EtjYGhJrbyUYjhDR2eALpNZehdC4BaXutH3
	Y9lVmL+IhjJM1UruBSmIajXfkSM35Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757416873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/wLJfJW7fDRhF8DyBKfFtUGe+MrbfXnX9W1eJnXlTo=;
	b=TyltVeqtfk7XHx6H0Jw97aAycD+tqlpfZKcVMXgznchP48qp6P9Ve5GEYn4/AIxPiax/1z
	r2Js5sJJNAnSg6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEC5E1365E;
	Tue,  9 Sep 2025 11:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yeoEMakNwGhNMwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 09 Sep 2025 11:21:13 +0000
Date: Tue, 9 Sep 2025 13:21:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: linux-rt-users@vger.kernel.org, 
	John Ogness <john.ogness@linutronix.de>, Leon Woestenberg <leon@sidebranch.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <williams@redhat.com>, 
	Pavel Machek <pavel@denx.de>, Luis Goncalves <lgoncalv@redhat.com>, 
	John McCalpin <mccalpin@tacc.utexas.edu>, Frederic Weisbecker <fweisbec@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: Unexplained variance in run-time of trivial program
Message-ID: <79de8d5e-bf07-4c24-89e1-1ed5bfab9361@flourine.local>
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
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d87e3c3-8de1-4d98-802e-a292f63f1bf1@free.fr>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,sidebranch.com,goodmis.org,redhat.com,denx.de,tacc.utexas.edu,gmail.com,kernel.org];
	FREEMAIL_TO(0.00)[free.fr];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

> I note that IRQs 25 & 30 are still effectively pinned to CPU3,
> despite the smp_aff setting.
> 
> $ cat /proc/interrupts 
>            CPU0       CPU1       CPU2       CPU3       
>   0:         27          0          0          0   IO-APIC   2-edge      timer
>   8:          0          0          0          0   IO-APIC   8-edge      rtc0
>   9:          0          4          0          0   IO-APIC   9-fasteoi   acpi
>  16:          0         25          0          0   IO-APIC  16-fasteoi   ehci_hcd:usb1
>  18:          0          5          0          0   IO-APIC  18-fasteoi   i801_smbus
>  23:          0          0         29          0   IO-APIC  23-fasteoi   ehci_hcd:usb2
>  24:          0          0          0          0  PCI-MSI-0000:00:1c.0   0-edge      PCIe PME, pciehp
>  25:          0          0          0          0  PCI-MSI-0000:00:1c.3   0-edge      PCIe PME
>  26:      23328          0          0      37250  PCI-MSI-0000:00:1f.2   0-edge      ahci[0000:00:1f.2]
>  27:      86091          0          0          0  PCI-MSI-0000:00:14.0   0-edge      xhci_hcd
>  28:          0          0      51308          0  PCI-MSIX-0000:02:00.0  0-edge      enp2s0
>  29:          0          0         22          0  PCI-MSI-0000:00:16.0   0-edge      mei_me
>  30:          0          0          0        604  PCI-MSI-0000:00:1b.0   0-edge      snd_hda_intel:card0
>  31:     198664          0          0          0  PCI-MSI-0000:00:02.0   0-edge      i915
>  32:          0        631          0          0  PCI-MSI-0000:00:03.0   0-edge      snd_hda_intel:card1

Many drivers are not isolcpus aware. At least the sound driver could be
unloaded for you test I suppose.

> Almost exactly 20 ms in excess.
> Could this be a hint?
> But there is absolutely NOTHING traced between 4606.628019 & 4606.811832.

Ensure your clock source is working correctly and...

> I guess either my time source is incorrect.
> (Next slide in Frederic's guide)
> OR there is something wonky going on inside CPU3.

...there is no SMI running on this CPU, and no power management running
(also in the BIOS settings)

> Looks like IRQs are not the issue here?

IRQ handling should be visible in the trace.
