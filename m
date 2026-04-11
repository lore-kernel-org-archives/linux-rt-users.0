Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821FD38A292;
	Sat, 11 Apr 2026 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775922374; cv=none; b=tS/CEMPAc5xHhkK/PSB4pluZjqdvxMQvahEeW7ff6XjOq83yOwMRv5ExiHQWzZeQ7PfVhw4/tbpI0fmEjWvUOtQCiyQlc3LcoC67zz3+UixyqmW4Fuos/n3Tj324aIP4wiu4c0WohOHcjW7pJeIzoU7Uq5ZcVHhfoRbdP2h/waM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775922374; c=relaxed/simple;
	bh=ArVuACrfFFBr3g3itTGpCNo14VeX4Nr8ZlsRE5Y5qfg=;
	h=From:Subject:Date:Message-ID:To; b=azYsm4VgMRj6bsVtOd89zBVPnk5xhsYV7CFxDQt4SDlE3OdOeKwAlvOv0a/iP8OAqxe17eFi+P/QZJdIwjsBE5HF57nQ8ZFT7+5pVs85OJuh2G2fFL7SuM7/UgiPviODu0PHqGNiIPTP20IQ7egoaDcwNFMMAUPDyYsBTtw3Nig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150A0C4CEF7;
	Sat, 11 Apr 2026 15:46:14 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.202-rt94
Date: Sat, 11 Apr 2026 15:45:54 -0000
Message-ID: <177592235492.379814.14883171501529069393@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.202-rt94 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 60aadf6cc180562d8fdbb323104509bc85749a4d

Or to build 5.15.202-rt94 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.202.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.202-rt94.patch.xz


Enjoy!
Joseph Salisbury
