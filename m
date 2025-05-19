Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F54B1E5E;
	Mon, 19 May 2025 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698878; cv=none; b=grHzRd5P8PnDJXt+S0lhi4aRXbwXmCpk4D3zeV3dG5BC4BA3+JuzC3wolj728RsOMwI+cQyvyCdi6JWfMfnsK4RZqH3MLG+td7g7/cvN6sySdYrqQioBsi/+Js3o1T7oe248kvu4yUlK3bM5UIHNxPxg09hp761z3mzcig87xYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698878; c=relaxed/simple;
	bh=u5ens6YOjkWjKkp8WbhrBoQcPps2NySdgb7DS3wpd3w=;
	h=From:Subject:Date:Message-ID:To; b=mb9JrhkCLqjDFYtkH+aJfjfM4s1LA0kj4rxJon9sNvtAcu9okzMXA6/GnplBatMFcu1lryDNA0oZLYfJgBG+JN4tQVN8Bw/jSwfDmVxiQs3+GPJeod/u+CFBj9NtEVKxb+1n6Xs4ZYzCfStgTr3nx4fb6SU/5KH7nPEg+EEkTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B4BC4CEE4;
	Mon, 19 May 2025 23:54:38 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.183-rt85
Date: Mon, 19 May 2025 23:52:42 -0000
Message-ID: <174769876257.4075337.16846187194915253572@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.183-rt85 stable release.

This release has a new patch: 0182-printk-ignore-consoles-without-write-callback.patch 

This patch is for the following commit:
("printk: ignore consoles without write() callback")


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: cb297afd9aeb9a53888bb2e0fc2008d863fffa23

Or to build 5.15.183-rt85 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.183.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.183-rt85.patch.xz


Enjoy!
Joseph Salisbury
