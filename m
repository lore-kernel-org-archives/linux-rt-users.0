Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADB2206A7;
	Thu, 25 Jun 2026 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349424; cv=none; b=OhWCsltiXHtIMZId+twhPmEhgXZtSX9qM862uCyqCeImVpbgt9dpvv+Y7ydzvFPzdyQXJCpGXbYBk/H5l8M26K47iXiHxV4Yia7ntEcLFbGPEf/hMtlLu+KdZ95tCqLk5fFYqc71FaVRo5E5kuHuBPRlbARavWYf20MADLtdWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349424; c=relaxed/simple;
	bh=kPnclz07hLpa1aCvLO8lG5+NbrzXi1nrZA35uxxLy8M=;
	h=From:Subject:Date:Message-ID:To; b=Uhv4/4Bwgct/VQjDiye3TMgDTWb0Zw9vKtwXJL8wf4TfIWHUZ4BfhF4o3dueEdGZAL7l2ml806b/d9odD+iYdfhxWjCHOeaAHMSNd94lsuRTEs+dkWpfSY4o3pTGpItkLXUCAZ+lweYFjtnKleWUyfo4eF0qJMDOIKkA1PlwXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763B81F000E9;
	Thu, 25 Jun 2026 01:03:42 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.176-rt64
Date: Thu, 25 Jun 2026 01:02:26 -0000
Message-ID: <178234934602.577601.7242945522688547933@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.176-rt64 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: d94347436e28aacf444d25b05311ddd151375921

Or to build 6.1.176-rt64 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.176.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.176-rt64.patch.xz


Enjoy!
Clark
