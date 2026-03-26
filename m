Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E71425776;
	Thu, 26 Mar 2026 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567614; cv=none; b=KfMT2bajFV5IbD/9DmsCvD8b5Aa35dsgIzH5ds24JXA2o/z0hjeMmCQKwhtQESYFw3c/qVQrsdIZzzwzCj6YeM8wXGud6HlS5ECTCLQot6MUmJoj7Gftp4WHqRCjMYkhoHCs5WpeLnQOkqFfa6MgEMDeXxh9ImVa/UKT0G6Aqt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567614; c=relaxed/simple;
	bh=7z36/WB/L1O0DZ6rG74OpjeTJ47oFFiHdR2prW5Hj3k=;
	h=From:Subject:Date:Message-ID:To; b=cIJZLV8kqkOjkfdxztiQ53Cwq3C2BOy9RJGVkO5cqyesuhYpsBI9tHKCM/X3NRIi3q+wSCf453jxp8WL8kLdzWGFY7bdjzO29sOZDBRjQ1lZcSyRXUhTtrfJi/dbKmnS3xkON3SJqBT/0++aXXjFda1edebHVDRU6BhRnT4Q1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACE9C116C6;
	Thu, 26 Mar 2026 23:26:53 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.167-rt62
Date: Thu, 26 Mar 2026 23:25:44 -0000
Message-ID: <177456754453.346486.18111828172917179483@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.167-rt62 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: ea157316199e70a56d4952a3f3e4b4cae05c2bc0

Or to build 6.1.167-rt62 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.167.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.167-rt62.patch.xz


Enjoy!
Clark
