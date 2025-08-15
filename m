Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7041B87C0;
	Fri, 15 Aug 2025 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755294685; cv=none; b=k71to6QHWvjKaqUhklX+0LjBk+qbCPckjwlG3gwxhGfIqYjCZE0o2FEHwcIWR684ziIu1wjMduEfOGp7OBLm+Tiu4YMGns5iFv/hea8UvU4TJG2HNNk5g2ELfDR/ZAxrDmOBG/CTowX3mn4L1w6NWvLJdl9/O3IfOKzndzetOmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755294685; c=relaxed/simple;
	bh=pSVjxAJ7wLLSVmnGrWhrWVz53jkWHqx2HLMr3EHa6SA=;
	h=From:Subject:Date:Message-ID:To; b=ArwuxAHKz9swGakBB1/wXAdga+ULEbdZGhk/RgDz8h2IVSTtU8fubiWQpIC6bUM0mToYdreetRjhakNhIvWkdOqVehJeF4bvm1hqXVeaKmWLfvh4wuhOEM0RC3sV2XoRZ7a+DXNHUyA6UQ7Ln+XiJ8hRZdsc6RjTNU0wFX9BsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAF1C4CEEB;
	Fri, 15 Aug 2025 21:51:25 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.101-rt59
Date: Fri, 15 Aug 2025 21:50:47 -0000
Message-ID: <175529464749.438234.18305308246120433084@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.101-rt59 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 60cd74b07c62041e678aaf0bdb49e3c542033e8c

Or to build 6.6.101-rt59 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.101.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.101-rt59.patch.xz


Enjoy!
Clark
