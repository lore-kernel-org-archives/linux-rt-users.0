Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A761E493
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2025 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638614; cv=none; b=JL5RpuYzafHkiVNfnT6Zgodv05mdFOHnOwxWsworAOXIxr1cKTGiuR2o+jgKxFmh7tcfBKgVFahGpQjnM0gih3ZXqoeD3zsQckzIFutK764u9UdwJJMQzmJKAWI5Uj7ZVOgt0QdvMD4NUFWjEFwIo1HlBLIpQ6kVJVo4RttqI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638614; c=relaxed/simple;
	bh=DqwhJNWDTAxPjCsGtddZ+FO0fhjk2waSCP7bjOqOS7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McRR0qSbWNdYyoZ8zDzNf+RrDXCF5whFQanDcH1K/Ict2l0d1XetZcp3WKbNMn+NylruZN3CLDHjaNMj+iAHeoyklTpth+uiBsJGJg+U6fU6hnVRPPJkuDuwSdvDMjXsf+HpYrwaMwjKMV7i1SryXaRyMvy5bSU6FcS2kpq3sHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bJJFHrNl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t9qseaes; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bJJFHrNl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t9qseaes; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bJJFHrNl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t9qseaes";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bJJFHrNl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t9qseaes"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20C9D2116C;
	Thu, 23 Jan 2025 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737638610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80es+Ei4UFgm0M3I7JRAixsbnKC2zORzF/2annW/wFk=;
	b=bJJFHrNlzPMYD7k2Zxd/VVpEz9Z5fCRHsmcYhZvYPAyd+alrA5AhRvpx5ag50tPsO61Hcm
	cdKATHZqnEYcsvQqKPrSHtzTpRhdfNXyaNipludr1eFj8Eedm0Hj65qYlR4yfmh+FwLMSu
	3dvbF3XAElCjMRyne2sKHQEyeY+iawU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737638610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80es+Ei4UFgm0M3I7JRAixsbnKC2zORzF/2annW/wFk=;
	b=t9qseaesITkL+rbNoZsxdXiS1T2v9u6Ij36n7X8YXJLkpytHwn2Qeev02qCbzdwLHJTufy
	zLA0D246qPBzQuCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bJJFHrNl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t9qseaes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737638610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80es+Ei4UFgm0M3I7JRAixsbnKC2zORzF/2annW/wFk=;
	b=bJJFHrNlzPMYD7k2Zxd/VVpEz9Z5fCRHsmcYhZvYPAyd+alrA5AhRvpx5ag50tPsO61Hcm
	cdKATHZqnEYcsvQqKPrSHtzTpRhdfNXyaNipludr1eFj8Eedm0Hj65qYlR4yfmh+FwLMSu
	3dvbF3XAElCjMRyne2sKHQEyeY+iawU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737638610;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=80es+Ei4UFgm0M3I7JRAixsbnKC2zORzF/2annW/wFk=;
	b=t9qseaesITkL+rbNoZsxdXiS1T2v9u6Ij36n7X8YXJLkpytHwn2Qeev02qCbzdwLHJTufy
	zLA0D246qPBzQuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3CBF136A1;
	Thu, 23 Jan 2025 13:23:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 11G/OdFCkmclQQAAD6G6ig
	(envelope-from <petesarik@suse.de>); Thu, 23 Jan 2025 13:23:29 +0000
Date: Thu, 23 Jan 2025 14:23:24 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petesarik@suse.de>
To: Jillian Donahue <jilliandonahue58@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: Spinlock in f_midi_transmit causing kernel crash
Message-ID: <20250123142324.449f21ba@mordecai.tesarici.cz>
In-Reply-To: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
References: <CAArt=LjxU0fUZOj06X+5tkeGT+6RbXzpWg1h4t4Fwa_KGVAX6g@mail.gmail.com>
Organization: SUSE
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3k1sS_r.J530x7DnuzkZN/F";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Rspamd-Queue-Id: 20C9D2116C
X-Spam-Level: 
X-Spamd-Result: default: False [-5.61 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SIGNED_PGP(-2.00)[];
	R_MIXED_CHARSET(1.00)[subject];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.61
X-Spam-Flag: NO

--Sig_/3k1sS_r.J530x7DnuzkZN/F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

V Tue, 14 Jan 2025 23:05:10 -0500
Jillian Donahue <jilliandonahue58@gmail.com> naps=C3=A1no:

> Hello,
>=20
> I am working on getting USB MIDI enabled for my device and keep
> running into this issue:
>=20
> [  125.702601] kernel BUG at /kernel-source//kernel/locking/rtmutex.c:104=
8!
> [  125.702607] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>=20
> [  125.702764] Call trace:
> [  125.702770]  rt_spin_lock_slowlock_locked+0x280/0x2b8
> [  125.702774]  rt_spin_lock_slowlock+0x5c/0x90
> [  125.702779]  rt_spin_lock+0x60/0x70
> [  125.702792]  f_midi_transmit+0x90/0x5d8 [usb_f_midi]
> [  125.702797]  f_midi_complete+0x11c/0x138 [usb_f_midi]
> [  125.702809]  usb_gadget_giveback_request+0x10/0x18
> [  125.702814]  __usbhsg_queue_pop+0x3c/0x58
> [  125.702818]  usbhsg_queue_done+0x44/0x60
> [  125.702822]  usbhsf_pkt_handler+0x80/0x120
> [  125.702826]  usbhs_pkt_start+0x10/0x18
> [  125.702830]  usbhsg_queue_push.isra.0+0x44/0x50
> [  125.702834]  usbhsg_ep_queue+0x2c/0x40
> [  125.702837]  usb_ep_queue+0x24/0x40
> [  125.702843]  f_midi_transmit+0x238/0x5d8 [usb_f_midi]
> [  125.702848]  f_midi_in_tasklet+0xc/0x18 [usb_f_midi]
> [  125.702860]  tasklet_action_common.isra.2+0xcc/0x1f0
> [  125.702864]  tasklet_hi_action+0x20/0x28
> [  125.702869]  do_current_softirqs+0x19c/0x248
> [  125.702873]  run_ksoftirqd+0x24/0x40
> [  125.702883]  smpboot_thread_fn+0x1b0/0x2b8
> [  125.702887]  kthread+0x16c/0x170
> [  125.702894]  ret_from_fork+0x10/0x1c
> [  125.702900] Code: a90363b7 f9000fb4 f90023b9 f9002bbb (d4210000)
> [  125.966631] ---[ end trace 0000000000000002 ]---
>=20
> Seen in the driver code here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/dri=
vers/usb/gadget/function/f_midi.c?h=3Dv4.19.182#n683
>=20
> We are running a 4.19.182 kernel patched to PREEMPT RT.
>=20
> Has anyone come across this before?
> I also ask if we've uncovered a bug when using the midi usb gadget
> with PREEMPT RT.
> If so, do you have any suggestions for a proper fix?

AFAICT the proper fix would be to replace tasklets with a work (as done
in commit c7d9efdff68e). IOW either upgrade to v5.10rt, or backport the
referenced commit.

HTH
Petr T

--Sig_/3k1sS_r.J530x7DnuzkZN/F
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQR36mnYrQDNXFnn8/Pem5ZkryZSgUCZ5JCzQAKCRDPem5ZkryZ
SgV+AP9aHI3DvQMA8BDQihDMz5A+hyWvGM4yWbo97tUOUEEz3gEAtIU2aYt4uQKL
tuMqbpGDJd5C+mveaG8TL/kmjZgXxg4=
=7wqt
-----END PGP SIGNATURE-----

--Sig_/3k1sS_r.J530x7DnuzkZN/F--
