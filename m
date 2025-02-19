Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB51CAA95
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Feb 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959039; cv=none; b=ILIVU3270xOCERI/iBUCOqivggwSjrbFNDY8FUcClJIWhBLiPsrkShr/wgL77DGCw2Y5C7P1tUMp/h53baNoEXfmnaSkIrXkc7+v9hxnCYM7/EahIjeGbxBLXvrExjRndayDQOmxBXkAruqp7m1flSZ2DMtBG8kIynsEjLEJi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959039; c=relaxed/simple;
	bh=xrnjRDvivMDOi0A2qndfDcMtg078OZOCkRDaYvIqXAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJ17p1H4SyKYY1Gwu6VPr8FVCKSmObU1/cK+QiHHqO+P/TADd/KAtHY2HNuUNOXIlFjPs4zXyrdl73fu0FjbsRHahwHyX1T+IcZqwJOiS6AlGbaVFTNRmxqFXerRTlCFKVbDL64aoKZsK2/+QP3IO7G2/sazb39aAP1ej9F/lQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=fail smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sZyNVBdN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aKd2ZvWZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sZyNVBdN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aKd2ZvWZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sZyNVBdN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aKd2ZvWZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sZyNVBdN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aKd2ZvWZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4646E211EB;
	Wed, 19 Feb 2025 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739959036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYPtHhrOZqSR80wcQw/ZwcANxIF6RSKxdvdzzcBIqZg=;
	b=sZyNVBdN2uySPsW3lM8bw9TP2Fjv+L3+Vo2NnWm5OOTURC5IsK6zxgHY2Bu++g2YaW52O0
	RWsuHiw+1UB4VI3tuIhb007i9qBKw8J012g3ImekUKohBJKPVtIEh7D4q3QVy3HixvBq3v
	cWrMhTu26Rcn17BzB4kVsCgJH/BPVzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739959036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYPtHhrOZqSR80wcQw/ZwcANxIF6RSKxdvdzzcBIqZg=;
	b=aKd2ZvWZdTM1e+FsIvmVlWJL6kRyO+m2QxXSLiGUb8WKTgMDiB8TrkT6DrBDedmSZBPRu7
	tRwAX9r6kyd+QOCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sZyNVBdN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aKd2ZvWZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739959036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYPtHhrOZqSR80wcQw/ZwcANxIF6RSKxdvdzzcBIqZg=;
	b=sZyNVBdN2uySPsW3lM8bw9TP2Fjv+L3+Vo2NnWm5OOTURC5IsK6zxgHY2Bu++g2YaW52O0
	RWsuHiw+1UB4VI3tuIhb007i9qBKw8J012g3ImekUKohBJKPVtIEh7D4q3QVy3HixvBq3v
	cWrMhTu26Rcn17BzB4kVsCgJH/BPVzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739959036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FYPtHhrOZqSR80wcQw/ZwcANxIF6RSKxdvdzzcBIqZg=;
	b=aKd2ZvWZdTM1e+FsIvmVlWJL6kRyO+m2QxXSLiGUb8WKTgMDiB8TrkT6DrBDedmSZBPRu7
	tRwAX9r6kyd+QOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ECFD13715;
	Wed, 19 Feb 2025 09:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j6IOC/yqtWdsPQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 19 Feb 2025 09:57:16 +0000
Date: Wed, 19 Feb 2025 10:57:15 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "pavel@denx.de" <pavel@denx.de>, 
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>, "daniel.wagner@suse.com" <daniel.wagner@suse.com>, 
	"tom.zanussi@linux.intel.com" <tom.zanussi@linux.intel.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, 
	"williams@redhat.com" <williams@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "C.Emde@osadl.org" <C.Emde@osadl.org>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "joseph.salisbury@oracle.com" <joseph.salisbury@oracle.com>, 
	"jkacur@redhat.com" <jkacur@redhat.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [ANNOUNCE] 6.6.77-rt50
Message-ID: <03a47c72-02d0-433b-872a-5701554dcf2c@flourine.local>
References: <173968881796.265269.4992139552085083465@demetrius>
 <79b04ea5771ea19470a1fe72e32b651e510ddd3d.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b04ea5771ea19470a1fe72e32b651e510ddd3d.camel@siemens.com>
X-Rspamd-Queue-Id: 4646E211EB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, Feb 19, 2025 at 08:47:52AM +0000, MOESSBAUER, Felix wrote:
> On Sun, 2025-02-16 at 06:53 +0000, Clark Williams wrote:
> > Hello RT-list!
> > 
> > I'm pleased to announce the 6.6.77-rt50 stable release.
> 
> Hi,
> 
> I noticed that the 6.6.y-rt announcements are only sent to the linux-
> rt-users ML but not to the stable-rt ML. Some other announcements like
> 5.10.y-rt are sent to stable-rt as well.
> 
> Is this difference intentional?

No, it's just that not all of the stable-rt maintainers share the same
stable-rt-tools configurations.

Clark, could you add the stable-rt mailing list to the srt.conf
(MAIL_TO)?

Thanks,
Daniel
