Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896A1917FF;
	Mon, 30 Sep 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710941; cv=none; b=Lz4OeKAA9eDWe3jCwsJeh9CE1QCF+nMelpJYZIT3UaeXOmNOeW1fIUdUJqz1rqGh25lOaSoQVnW2Unbh5uS0hLJkxEm/XVYCFqdgBo40gV/B0UAphtzB20hcwRPt2nfEcBs3nSjDfKNIiD+a10cK8zTCaBCZvx/X9fsG1sAxp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710941; c=relaxed/simple;
	bh=72Fwc82csBHX1yYHcF3YSU/MkefXjlYgCuVUjgPljVU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QSSN9i7Lxr+gTnVZAYtFeW2nlbrkQqRsSExuY/oNz3Lqx6XcH112KekFc5smh5FPsU6iGtXb0bB/1O3fGtrN9odsoBMVcTih7yM7J5J77mUZNmMKZCwnm8HgHIZWxZELWPi3mZNod3/Kfw/3W9VS3GIJkMgQaaKRYoxgANw5GMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2skAnshz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WouAlOvr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2skAnshz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WouAlOvr"
Date: Mon, 30 Sep 2024 17:42:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727710937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6hOUC4vKSw/TkGzAPlg+JSA0OmQu2RHMwDcYpg6iIoU=;
	b=2skAnshzV8Js6gsJ6eJeANcMGYEsKNa+mLaT6WuTtXZ87u9Fucr4oaSeU/oh01XF/ekaRd
	WorUocuHgptcb8cbJDAHREXq8ulCVO+UDprigVXnAjBlXxHeP12RZGT1bwPYL+RwXElpua
	ih/PKwzJZMO1u1iD2SraH+YMLbssJTo/L4M9wBlspGZvYfkUm5AaNFIlVHAHsk1BTwQC5G
	JZ/XpIsU9jt1LvHOwHLWrdT1XZpD/vnVR0WWGGbn3Y7vDniEsyI4l8UJ0D1TTB4gLpcFgY
	2pM9p8K+ZEaa18MHamPNg3vv/Htm8AwH81M1kaldK3stYb7439uOqidP3ZU8OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727710937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6hOUC4vKSw/TkGzAPlg+JSA0OmQu2RHMwDcYpg6iIoU=;
	b=WouAlOvr3+JPd+muImtqRMQdMDCLD9F+L4jtWnvFs8HCBHXb+AtVEerTViJUzRvWSXiDpn
	/QVGXGNYGIsB+aAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.12-rc1-rt1
Message-ID: <20240930154216.ua_fDZt4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.12-rc1-rt1 patch set. 

Changes since v6.11-rt7:

  - Update to v6.12-rc1

Known issues
    None.

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.12-rc1-rt1

The RT patch against v6.12-rc1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12-rc1-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patches-6.12-rc1-rt1.tar.xz

Sebastian
