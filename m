Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD45B1FB;
	Tue,  6 Aug 2024 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969498; cv=none; b=uhwzZHK+P8ylGrsIJQdykPtdXm2/sXq668CaMARBQA3fJAzryiyLLLwuDxTWtcwirEhWchZm3suvTyqIcIw08XetrVYTTCvuuJkGCocoL5l25JtxESRtzxB2E0khsaKfy7MVZBUVFrFGgzNNyx8GMr71nu0f9UNHEUuNuoiSfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969498; c=relaxed/simple;
	bh=8tS/iLnzKfvv9OSEBeEtPAOeGOIDM0EkGRPFbnSFRzk=;
	h=From:Subject:Date:Message-ID:To; b=Ly5k0LC2CndQMxmFWjY+vzkCXXQNOiVQfi+GnDAlPkPIQQALQb32YwkW/6UTzvZPCr9JoGTS9Oe5caJvMuKte+nGYGK6m9kW5yrpFzkBG6jDL8T1kk54sUqpeITdWnvA23oa4WY8hknDE96nrNjaUEJgHPqkTsQlcBfmfFMJDJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF8EC32786;
	Tue,  6 Aug 2024 18:38:17 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.44-rt39
Date: Tue, 06 Aug 2024 18:37:39 -0000
Message-ID: <172296945975.166091.16681546740404966491@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.44-rt39 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: ec8e0b665eccdbdd7def2e58aa176b72c8ba240f

Or to build 6.6.44-rt39 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.44.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.44-rt39.patch.xz


Enjoy!
Clark
