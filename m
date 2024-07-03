Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92219944D;
	Wed,  3 Jul 2024 04:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980290; cv=none; b=T12oGvwPeQS3FTK4nOXQhnjEYXARNy+6dShvWxb6qAOA8WmCzEhZl+Lm54DeTgeWrlmYxv9vgJh/1Upu66RaCrp9bcLmR80mVs/eQow657pplO6zDYmkVCyBLM11X3EckWKKz1Cw9edpyX2+M4UfW24Mfu6gvqkObdQMPcPn9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980290; c=relaxed/simple;
	bh=nX4YXnfXpltlLj8W+//L4cLwsxphPECragUWkht6Zuw=;
	h=From:Subject:Date:Message-ID:To; b=oAUUAeblL55pR68SY9OxFqTcu/X5fiRJuMJn28qPvTLvpc6lgxlA4CPqHqWCwle5694KORfnX6lFbuUrLHX75BDxQS9kAhws+6V3UM3rgk2qTgAmksb/M4zS5+kMCLW0eAi7O/BBfrkl/BtSlz/eSq0gPkq5ucHeMev9zLPegPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031BEC32781;
	Wed,  3 Jul 2024 04:18:09 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.96-rt35
Date: Wed, 03 Jul 2024 04:17:29 -0000
Message-ID: <171998024922.171686.11618948234066301156@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.96-rt35 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 07db47850dd81cb7b07677019c1f9822de12a67b

Or to build 6.1.96-rt35 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.96.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.96-rt35.patch.xz


Enjoy!
Clark
