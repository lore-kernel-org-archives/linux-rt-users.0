Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A13433DEFE;
	Sat, 28 Mar 2026 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728806; cv=none; b=G1OytX2vjhUU4cW3Yo+DxCDKbABwXuva53WkLJWaI0Tqs89Qx9yA8esHPt+xtLRZjqS7wkR5I4AaqUqmJU83sazzXYdu7Q1ZKgWzfYnevzU5UgAeyTe1KRFUjjW6cn/UeIsfJwWHNLZm3vkwX80VLlH/yDwxq1DHfg50g5Xa3H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728806; c=relaxed/simple;
	bh=VkUx9dyQDa56XuAQ8e9cEWBFczlVKLe/TGVXuIWfWjc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C1dEYREMO4n+hj7rNnuBPVFGMwS7I2VRRIv7PJ6XQxJrJARjMKG8GmyZYH0kOY4S48AHqukNjin14VMVOUx7tHjSSyjeNSgPk4vpCWGSkh0KZMc4YtFCjH6hl0RW5G4o7qrpr6HK70Cn2YD/dTK2UADIqYAlt+U6M3wkHg2prcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=kiPA9ggE; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="kiPA9ggE"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BF60E334B;
	Sat, 28 Mar 2026 21:01:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1774728100; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=Pp6pFgBVYTvp4N+v2H2QP+GKjBfvuWHwOkI8yDEdbQg=;
	b=kiPA9ggEr08mhKQEPqtAiQNkEOHf0kXzTBwwgTBw/GmTVfi/R7UJRoqnYbdH9ujeZh0hyi
	+IBat1LWZ3u5NHmz3fULZtt9ovrrWXOGl8k0cm34wqFxYrlsLYAWpzZ2XlNc8+8wivGQwf
	KuakBuB9pWtOUOQ+t9ZjHgzM2Yy0/lKL7/OYt58jm6BpVfpBHmr6n//0/z/rYzyQupK+V/
	FAa1QtJm8h8puSMT6AMZzRMIuUP6xhIgVuUKQ/38JO1LFKAAosjdW475IE+qwj8LIQqXBg
	qABQwUoVS/OgelamZ92db+l3JZPIQNpElJIQ/Kyyr5sbdJqE+LLDxlyJR/oiUQ==
Date: Sat, 28 Mar 2026 21:01:33 +0100
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] v6.12.79-rt17
Message-ID: <ded3cf3a-b839-4907-b022-4befa693f7d8@nitrogen.local>
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

I'm pleased to announce the 6.12.79-rt17 stable release. This is just
an update to the lastest stable release. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt-patches
  Head SHA1: 8302a41dab8d54ae76c748b5c431750cb8517258

Or to build 6.12.79-rt17 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.79.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.79-rt17.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel
