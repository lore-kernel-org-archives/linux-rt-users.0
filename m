Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6852EAB62;
	Thu, 21 Aug 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804967; cv=none; b=BmlSfvG5tzFiMk1msu9sPaOohEsxPzjnQHAZAZjFRM8x8WLO10e7jm4jPZ77VWYsfgPN/C/ZC7v9QmpxkzuAgdv2gXfMgEpxTAAwFiciOBQ4ne9Z7f4ST3ULUJHwts2J2ofFzfaKQmnGiOKMiAHy4bKlFo0Iml7UVM8PCtnR0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804967; c=relaxed/simple;
	bh=0SJB2v2gnL/Ty/M+FYm1s0jKKPqo60UFMV5aWzfBzH4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ncjkda4bZX0EdvDpklzXQPebRtsYfmakMvvPkDscrqGVdXMhW7ad2NvutpwG4Zs8X2w3lha+08Fj+I+iJC7rw3ydTlUZo+Dxb8SL7zIllIzXvNuhM+DvsBz8KzMyez2LMpl2CjDKQhwTn2NwYvLukYX4V3H3HQB2ZTWLW4RFIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=pQD8KtWs; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="pQD8KtWs"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBF26E68DC;
	Thu, 21 Aug 2025 21:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1755804357; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=8HtAzJOKy99kZ4M8XY1PFEll6+EjUDg37Eg7mWEU3BM=;
	b=pQD8KtWsp2960vwZGjyL1dXg/4AnOH79oSFBxspqlvMawYsIyzgQvLzIIkvBgouUtJh+xw
	BsEOORYTNcbDlLcPeWk3TInYeZTHyWQBJ2PfnZXcdRQKnMvRwWxNGXwsh1H7ErR8dbTvp7
	rDaNcP5fPC8143TtXEoUA/HtAicQeX5ZSnGRgXcyJPV3QA4vEwQ8I8hncJyO21u5UiQbaG
	+2ELs94qaS9nZ2B8+WQCJI9RBAXEMgHyjxMFiHG/6gE+o3tKqEs714hIMnkqvV3Y5PSCTP
	7WqKPdsuj7BC42dYHi8MgpvIeHw7D6MO9NB5AAVz+IkuNYfblBBM8UOSUhZMmw==
Date: Thu, 21 Aug 2025 21:25:52 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.12.43-rt12
Message-ID: <175580420905.334958.3029444147013610727@nitrogen>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3

Hello RT-list!

I'm pleased to announce the 6.12.43-rt12 stable release. This updates
the tree to the latest stable release.There are no RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt
  Head SHA1: 627b83a89e0f4118ae7a279ca6e3cb8f5183b0cc

Or to build 6.12.43-rt12 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.43.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.43-rt12.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

