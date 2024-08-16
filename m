Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66C1B86C7;
	Fri, 16 Aug 2024 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723813041; cv=none; b=TeiRY9TjWJ768XgHKQxCjf7PvnXODfTSkoTf9Q/nZEyzj+OeygIXZhU5QlorVM73V575IRvD+KKTBQrsLy4XL2HzSaAUL4SG2G09dfsuB4v06kIpf7QC2qR99m3/A1amjnx+nN/+Mrs+qXjcgUBhk6dRhTABw9A71XCzGEiqBho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723813041; c=relaxed/simple;
	bh=Xi1hlYq1ozQDA0W0CYA1K6q+g/PqpAWbQKrjRu3vLq4=;
	h=From:Subject:Date:Message-ID:To; b=A18OZB96OtfT+H1NwOfs7dq8M4wMPQmKt0QvnXkTN1bXUMxiUFkO5l/4d0Uuo922K5933Go4Qt02XB1bjYvXYu8HFbFyyIwJ5VWZEZtLrpZkpn9gDAEdTIEqh/MDToSPkRx6MrA/m4QsGtn3BiPTUa4ij8HEluqftk4oKVLNFp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7446BC4AF09;
	Fri, 16 Aug 2024 12:57:20 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.105-rt38
Date: Fri, 16 Aug 2024 12:56:43 -0000
Message-ID: <172381300372.327140.13138486647986112804@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.105-rt38 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 8fe1d58eff313241a0c3187db014fbccaad0b680

Or to build 6.1.105-rt38 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.105.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.105-rt38.patch.xz


Enjoy!
Clark
