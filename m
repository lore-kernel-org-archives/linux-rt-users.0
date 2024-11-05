Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746511DD0D0;
	Tue,  5 Nov 2024 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834820; cv=none; b=UMdFKKkS3qy/vYxAYdmTQeEn8aiozL0+N80Q7v93pK4PC7VTyseOl25unbaPsX/r6J6sYOp+v42UetV5xLbffxz9JLoAu0IBLAWQF1HB/rjIQ+izciD33fe+rK+VAGDvLC8pbgPWOhqXjhfiKqvDoXhXfqDyLuQBs6v7kUY9fI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834820; c=relaxed/simple;
	bh=ppFYKIycRQN1UCr/BhPE0PxqvuQbbQz0mcNgkk4P7zs=;
	h=From:Subject:Date:Message-ID:To; b=JRJzixnZpZ3A9tWxjcpG4n8JA5106efP6vOml1f7LHfhcEIDL6jyd34+GJK3UXNOP38dNAT9MHlFWvJYNpEmaJRRGtmx3lL3NIliivx+cvNkv+O0t/o2USqPKGxvWx8Y4aD+mT6RUPbLRILJj+TCF63z//XlK7cV9XmwPjARb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62FAC4CECF;
	Tue,  5 Nov 2024 19:26:59 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.167-rt80
Date: Tue, 05 Nov 2024 19:22:00 -0000
Message-ID: <173083452006.2664817.11460487576699098758@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.167-rt80 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 708bbfee6ce39a211c71b1b7247e4c433017cab6

Or to build 5.15.167-rt80 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.167.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.167-rt80.patch.xz


Enjoy!
Joseph Salisbury
