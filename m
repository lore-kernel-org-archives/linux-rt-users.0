Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC318BBBA;
	Thu, 12 Sep 2024 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172041; cv=none; b=oQDK3VWbX9a+IunqKeNyN7/LlbqUYZJ4Z8ooXY5sXRy0/+shThhR8i6YFj84fA9lIsovoSKkxtSUurcTc+fW8MlkotDPXrHRLzsE841q/o1jtJbQyMVixXgUWUt1M90r8IHMZ9ymlA7qSh+mGryhh8mxqkj+GgNC/HYGGmeVj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172041; c=relaxed/simple;
	bh=hOzQXgTTxcp84rMW68d/nNLlRkspGBVcDO1jwicy5s8=;
	h=From:Subject:Date:Message-ID:To; b=SWS5hb8hTpsueY4SWXozaTaTC+9OCfVmVCX1pw4KlaJEnL+hRLThmggcGQpp04u8bj0gfZsLSRcZRcy/MLKZ8F8eiVHk373keg47DXGeF2nvHzcdvJjV6hcAb2h+lioeWGXxBcofi3uXe0f4P0XHmbNsx+xwyLFwVTLrX6eNwHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6574C4CEC3;
	Thu, 12 Sep 2024 20:14:00 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.50-rt42
Date: Thu, 12 Sep 2024 20:13:29 -0000
Message-ID: <172617200995.2014080.932999697521344375@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.50-rt42 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 389acb7d94207338ac88e7c06a7cbcfd72ffd1fa

Or to build 6.6.50-rt42 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.50.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.50-rt42.patch.xz


Enjoy!
Clark
