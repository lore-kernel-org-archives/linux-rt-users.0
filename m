Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58823CEF8
	for <linux-rt-users@vger.kernel.org>; Mon, 24 Feb 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403784; cv=none; b=Qb0P/u7kgf2NEag5PVtfcWpdXh4W72K6RxcTNA20rFL7iQDlS+2fEyLx+SRTMN6e/vezlpVi32OUtkzUbVYs0py+JKFcVT1sr/xsYpKBtxTZIReSXipa0RVCbEybIDGIjuypsghTt9gcyF9vYN/Cc7dy6JhNmZo6PiXa4mjwJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403784; c=relaxed/simple;
	bh=q9/TtM1NG+ifOqQFSbmWbZoInNyjK7xJ99Snl4OUlIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjJQWbhiDMVbnU2Phs5zrGS7vvPHRb7kFor4XxeHOwFWsU7Wbp9k1pjpyWhRiPGE2qPamuGVjFYT4M5OnyAWlrOCjeBFZrW8aPsV4/x+wqFdsqK2KV+s2s2RhbwSBf/UWJSei62bdOZmAG3X770QF6tbWH+gCLpxwXjwqIeHBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rme7mC03; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rme7mC03"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740403780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9xqhh1X8+oxDwhTT/zyF9J7eY23U1qqffowUkxLKRu0=;
	b=Rme7mC03fwGue2liO0VoXPdVH3UT4lB7ybdddLnzVu3Fo5IGM06/1k8ehDE+YsOcNzwTJI
	cH56iwp8SQ58v3CsEZ+qFymw1GJqo9RAYnX+toSzl2fLqySbk2EzErY6syphh2Eej+dZUI
	q/VM10hC0LmSM3xyubpVjehnt8eBo1A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-zajP-Y25PeeaW0gZRgMbhA-1; Mon,
 24 Feb 2025 08:29:37 -0500
X-MC-Unique: zajP-Y25PeeaW0gZRgMbhA-1
X-Mimecast-MFC-AGG-ID: zajP-Y25PeeaW0gZRgMbhA_1740403774
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BD6818D95F3;
	Mon, 24 Feb 2025 13:29:33 +0000 (UTC)
Received: from localhost (unknown [10.22.80.185])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59D971800368;
	Mon, 24 Feb 2025 13:29:32 +0000 (UTC)
Date: Mon, 24 Feb 2025 10:29:30 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.234-rt126
Message-ID: <Z7x0OuwMk0rVIy_E@uudg.org>
References: <Z7ZWPGBt4Pv9o54T@uudg.org>
 <26f102f6-4e35-4267-b6ec-9ebd0c7572f7@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f102f6-4e35-4267-b6ec-9ebd0c7572f7@siemens.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Feb 21, 2025 at 10:50:04AM +0100, Jan Kiszka wrote:
> On 19.02.25 23:07, Luis Claudio R. Goncalves wrote:
> > Hello RT-list!
> > 
> > I'm pleased to announce the 5.10.234-rt126 stable release.
> > 
> > This release is just an update to the new stable 5.10.234 version and
> > no RT-specific changes have been made.
> > 
> 
> Was [1] coming too late for this release cycle?
> 
> We may have run into this bug independently a second time here, I just
> don't know the exact kernel version yet. However, we do know that 5.10
> needs the fix as well.

Yes, I had v5.10.234-rt126-rc1 in testing since the day v5.10.234 was
released. But I will push v5.10.234-rt127-rc1 with the patches you
submitted and another fix I have in my queue.

Thank you!
 
> Jan
> 
> > You can get this release via the git tree at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > 
> >   branch: v5.10-rt
> >   Head SHA1: 5c5f37fc0ab0914da38776700e77a46ca3e30bf6
> > 
> > Or to build 5.10.234-rt126 directly, the following patches should be applied:
> > 
> >   https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz
> > 
> >   https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.234.xz
> > 
> >   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.234-rt126.patch.xz
> > 
> > Signing key fingerprint:
> > 
> >   9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26
> > 
> > All keys used for the above files and repositories can be found on the
> > following git repository:
> > 
> >    git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
> > 
> > Enjoy!
> > Luis
> > 
> 
> [1]
> https://lore.kernel.org/stable-rt/CAMLffL-PTp+Y-rXsTFaC5cUJyMMiXk-Gjx59WiQvcTe46rXFrw@mail.gmail.com/T/#m67dce3408cac40318ae3dbe1c713b13621ac66c9
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center
> 
---end quoted text---

