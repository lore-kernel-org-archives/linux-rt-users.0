Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC28271824;
	Fri, 28 Feb 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764572; cv=none; b=iHtgY39pne+gznlS1xkNynHGGsHjE+XVWcKTKh7dmeENB3duAQKwVZYVAEXPSaMlEIrbVKkiWYiP9zVyxbiWOGJXUDWDBt9D3JbioSukclQFxtuuVX9xQnp3/iIrDo6w5S6R0vXQBtzTR7YzZKtAhBqLjFymu9oz3KGbxDpBNTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764572; c=relaxed/simple;
	bh=x1twO6YnZZ/sWY1m94EZYUHK/qtRmUVTrtlSawdlqB0=;
	h=From:Subject:Date:Message-ID:To; b=Za3DePyND6nsnfJ8bSlz1u5fJblW0vk46iJH6z8HYOM2hlmWfwUvVBQsQH38HSLLOq6Wfua74/7vg3TJ+EQQLX8pU8W02HoyWND3BdVqix2GwnGTCBrY2ay4p8G0N7wcZMWO5TTaisli3zyaOnn9GIzJRGUbOUaF98GWhuHorvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D0C4CED6;
	Fri, 28 Feb 2025 17:42:51 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.78-rt51
Date: Fri, 28 Feb 2025 17:42:09 -0000
Message-ID: <174076452994.288705.977807225526228038@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.78-rt51 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: fc36cda2eb1ed7af3b76422cb3326224b230e5fb

Or to build 6.6.78-rt51 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.78.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.78-rt51.patch.xz


Enjoy!
Clark
