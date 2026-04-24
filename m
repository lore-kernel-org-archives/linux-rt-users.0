Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA9345CA3;
	Fri, 24 Apr 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045726; cv=none; b=Y3KAdqjsC1qanS8pvc3P2Rn3uZPewimTniBKsKDG0HszXVGfZ3zF0EFCxCXa2gZqB3LBLBmxt6JTXEo/Q9UAWhUoRbNmwd1VYTg2eTg6m7XtB170bNx+1Fsn5jK+7+4KzxV6g37Vd64lGYobkI1gvVD853nMAW/daUhDlztlmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045726; c=relaxed/simple;
	bh=HPHVs6ippkK2HHtzpp/QzxKTiRbQcsW0SIYdInx/MJQ=;
	h=From:Subject:Date:Message-ID:To; b=eDwOQqtbNMTIlUMvM09vONONc/znBNr2tHofN67Pcd9EezVZB7CLE/O/aW311ueLXPGJyzEQsB6+28MUWzs74lqYTOtLI/NNir2y5A2YO2oKblshMA75dsYulbbk8FWNVNZHHcFA+YnGWZRvJ/QzfRH0E6CMRQHhGkl6Nvn/Ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C15C2BCB5;
	Fri, 24 Apr 2026 15:48:45 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.135-rt74
Date: Fri, 24 Apr 2026 15:47:59 -0000
Message-ID: <177704567979.1387124.10689556755581821291@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.135-rt74 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 63252271e16cccba62846ed7329b7c0d676b3e2b

Or to build 6.6.135-rt74 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.135.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.135-rt74.patch.xz


Enjoy!
Clark
