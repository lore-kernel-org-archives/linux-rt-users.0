Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F21DDA0E;
	Tue, 26 Nov 2024 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647538; cv=none; b=pw80kgtd1r+s0mC/ga60VlgQDdcfmjKyzNDEFOkbpvcgzRw057AXwRFBzhQsC24UZGuWLhnpPjd8DGVVsIuEJRCgu/eBXF9GZabplQgfdoDIGaW/tMvf0Q9wEmiMuQU0ONlDs9+Rht7ZUdx6p2X1qmjLWEKdcMagYxbNnMCmLzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647538; c=relaxed/simple;
	bh=2EAnG+8PM14abzsYmF5zqPpaHFCDiiTckk4RIFs0euU=;
	h=From:Subject:Date:Message-ID:To; b=jxA2RCV4reXs7jISw3QkhhgzgnxFi2Ed2AA7gaFtDF/Kq6gLZDN0lSE9ujrDUL5oO9DRVMFCOxf3T6b8WEtTZvO8jsNfTx9axp/kQrKvx4JpinbJdHXAFQaHZYYlSrDXxUg9VxGVE+8h5yINZ8kWB5igWKxaPzsmZLN4BYJOPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CF1C4CECF;
	Tue, 26 Nov 2024 18:58:57 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.119-rt45
Date: Tue, 26 Nov 2024 18:56:53 -0000
Message-ID: <173264741329.345124.12384539966964537166@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.119-rt45 stable release.

Note that in addition to GregKH's 6.1.119 changes, I had to pull in
Jan Stancek three commits to deal with openssl compilation issues with
file signing and cert handling. Please let me know if you run into any
compilation issues here. 

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 10c8fc980d4b95b76750dd68a014ad3ec3ed2a95

Or to build 6.1.119-rt45 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.119.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.119-rt45.patch.xz


Enjoy!
Clark

