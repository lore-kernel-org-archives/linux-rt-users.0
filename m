Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976F247DE1;
	Sat, 18 Oct 2025 04:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760760858; cv=none; b=g/actKUz9EKoCMggxWIy0eMqiUtgCe2pe208akKlUupM1fncqcYDXjfyD5y+DKEwpWutCqMtU/sx/c785wREBGQXwVLSxBgoasYMO9zPQ2Gic7WOamCbMJXovTa/AA8oC7YXM8csZTZyqJufK1HkuHvwiVZOHplCllgmUrrKTnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760760858; c=relaxed/simple;
	bh=BGY3Tp0P4z0fvE9+cSGbdoYOQXwkUMFeZo9ZYa4jAC8=;
	h=From:Subject:Date:Message-ID:To; b=QcqoVT+8KFnOktOEPN+K/gU749ew9KyGYqm3/izBgl6rayAbJ4nIwgZXMMAsYrOGe0RnlQeJp1z6ue+VZfmFb1Zkt2oQWyZqvYTEVBT0uEs9IV6fss0X6vRzurzoJgMXBRwxl0Z+8U9n2haYnpn+CCJMosC3L5fF5XXfpdhNl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BBEC4CEF8;
	Sat, 18 Oct 2025 04:14:18 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.156-rt56
Date: Sat, 18 Oct 2025 04:13:22 -0000
Message-ID: <176076080202.1476781.7944549551525553977@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.156-rt56 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 50a28f95c66f40f394b6ac94b6552a16564b45ef

Or to build 6.1.156-rt56 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.156.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.156-rt56.patch.xz


Enjoy!
Clark
