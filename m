Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492D308F39;
	Mon,  2 Mar 2026 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440619; cv=none; b=ts9fxQghVxlu1dX/8IqchpJAn0Y8Pa08ampwKhgTH2mO+g4nVtnhUDTUw6Pw52Z1MFlDA3tiB/oKmyty2fn5L635t6/iNg9zt+sCs6uH/lUBbffw6/rrzBZ0SuyWQI7uiadiDZlJveVqefAyTxlp9X+PquToUYqms14uqZTHdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440619; c=relaxed/simple;
	bh=NEiwcSgyGy6FkA8MhpPjAoXJytbacu/l7hUad9W4Uxc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nDEnSuYW7tJur1l8Wn62K2/XIdZsZKQOnQeYg3xL6B2SMAoIC9wbN1Ah61ChZVpSuZp5V4cB9uCbTr7B7G53e9O4uLHGultTUbjeYDWISz6IJAuaItttU+N4Ak7RPGcEpMrAo0jv7GKAX2550GJu9RhaixAIONgSgrO5qW/HAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=ReC//RPw; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="ReC//RPw"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 127D5DAE81;
	Mon,  2 Mar 2026 09:27:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1772440076; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=CWaHUhz/H3r60T/UZWrobodNSQ/vKouuac/N/VdylAQ=;
	b=ReC//RPwf5sf5kwgPHIwZNk7aefV1aMLwSf6CJVpyXz/HfiwAuVnR9ocflLyK8ao25Euts
	eXLNgsyDrbH+uxkltByjLd+epsidNsB3g8iStpNaXF0GwUGeARY9eEg3DommX4bBvYoe1o
	NRYjyUAAJIXubQTXLaNVfyrzsis7LYeL8Sf4FWrRJ4J85sTSNXUcBwxNZD0Q4KPbcXsGeM
	0pBKITnT9XtiN0FNgXt2075lch7jJ13MiDE9N7mSm+QVHmgc3KXXafk+EA0ylQGMB9d488
	BTQEKqLsu6xwNN7r98Jpt/zH7QUSx+S69EwrZZuyWSVNKzrwRogNpiPWQS5dqQ==
Date: Mon, 2 Mar 2026 09:27:52 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] v6.12.74-rt16
Message-ID: <c4bdf691-57c7-4aab-b3fd-823bd61c00e9@nitrogen.local>
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

I'm pleased to announce the 6.12.74-rt16 stable release. This is just an update
to the latest stable version. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt-patches
  Head SHA1: 4e15c62b2e312c7f96da63de703611093f63ed32

Or to build 6.12.74-rt16 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.74.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.74-rt16.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel
