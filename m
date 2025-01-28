Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22B1DE4FA;
	Tue, 28 Jan 2025 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738092032; cv=none; b=idq6Wo70D7SSOq0QYp95iQJJJOQUbFgsp9MhgsXZh1K8eky9whSO2xSUsaN9zXoIDDYJ2nJZK8Pw3TEP+2S5/XG5gMpEaCzLgw29p4WaZtKFwEI5M/06BMRkI1NWyMIS8EZe6HhD0eIWFyK5VZM7xGRcVY8DYeo9QEl7DhSj55E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738092032; c=relaxed/simple;
	bh=YPT5i5/69s3EOBeTPl0heEUulctfwiQKO9FMLCoi+PA=;
	h=From:Subject:Date:Message-ID:To; b=OVZ+2ijP0G1JVbi7O+zZnRjYtiC+RqDkhVR9NpBGrv5I2CMhKtYfbsb4CEUNwIkQHbzfuEnrCgC1CqNsr9dm3jfU9qRfgvZwwGy/gEdz/3BZn7VqBBb+PpVrwXurr0Su0ghXL0e+9kJ3aHzB8r8kgz/LQpd8/9Ho1LOHqW/j8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2A7C4CED3;
	Tue, 28 Jan 2025 19:20:31 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.127-rt48
Date: Tue, 28 Jan 2025 19:19:31 -0000
Message-ID: <173809197155.165335.6314149421319482303@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.127-rt48 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 9373b3c1538f82fe1f4e79346f70d3b29361793c

Or to build 6.1.127-rt48 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.127.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.127-rt48.patch.xz


Enjoy!
Clark
