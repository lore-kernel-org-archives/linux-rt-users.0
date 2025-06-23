Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83162BDC31;
	Mon, 23 Jun 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699759; cv=none; b=ZIc/2+lGeNHBUN+pT/UgKeM4H9bvFlsh4s2PV4BfY96nuNHScJMPwLkv4ls23m6H0s0ti7aoAErniTgrdKqwYieyH9H+DytOmu9MyWydbM+xJ5QNvaVPg1bS+0SXvF0qLOx5ffUpOyQkm53iH/cEn3AWXQicb9ZR6eyEaJzCyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699759; c=relaxed/simple;
	bh=HLGgRr4feDw6e7aU1fmlGUO8M7TV2+h90PNaEi0BiPc=;
	h=From:Subject:Date:Message-ID:To; b=kEEL/S/FnqJ6UscX7XZH/Hz+RrALdpNZ90Dr44zJ0LTza+gmAz5UyU3hX8gd6oSAsjAa7Dh88wQFeTnD49viy87Fi9iwzMFFF8GH6MecE0lFFoImOyQO2lZQCb0yjo+YfqNHakDXL/33HVfMT0hhYU36N7MALsDWIccimJB93Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD63C4CEEA;
	Mon, 23 Jun 2025 17:29:19 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.185-rt86
Date: Mon, 23 Jun 2025 17:28:38 -0000
Message-ID: <175069971866.446318.5739650023063894864@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.185-rt86 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: ef9ea86ce3757cee30848df251319b0f59ca4ca0

Or to build 5.15.185-rt86 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.185.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.185-rt86.patch.xz


Enjoy!
Joseph Salisbury
