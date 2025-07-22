Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F020C478;
	Tue, 22 Jul 2025 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208078; cv=none; b=b+k87fL2K1pTPQCv3NHZEHAtKGiIba6YflTfnNQnwL3LieP9eIVbe79Wz99e4Pfc0NscNoYntuHNlRQMcgcSPTEstWV91RUtBErNa03Yym8INJQyHf/rpnle+PQKZHhk35xTTLDXKk4kMFGfpRT+efHQbNuF075KHz5Sg/PUV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208078; c=relaxed/simple;
	bh=essyj2992YlnrOMnGwpCcMCfYy5V791IPyi+jRyIzmM=;
	h=From:Subject:Date:Message-ID:To; b=cw5u8jMpHR8z6XJ+80qi+uRV+ev1RF+eStfj34Yj2SoP2tJYfwU5LutuOnvAOOxJWK84HtAgrDbHw3MpIKi6B4PWp+Ioac3zAeEPCT+IXhSd+yU3HHUe5V1hjz4jX2AsIPTQ0dJFNrG/WII+lFqxULHT8ovGk8gQadF4hIFQpRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1443EC4CEF1;
	Tue, 22 Jul 2025 18:14:36 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.146-rt53
Date: Tue, 22 Jul 2025 18:13:53 -0000
Message-ID: <175320803315.432236.16000897060767209189@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.146-rt53 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 08ad3ab9882d43f4afb03622b8375d5ce540de18

Or to build 6.1.146-rt53 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.146.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.146-rt53.patch.xz


Enjoy!
Clark
