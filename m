Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21F48595C;
	Wed,  9 Sep 2026 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991035; cv=none; b=gXP/cF3lG92eCjvLXvp+Wn0o9mQhVsjudhJx7eaTXaTAMX9bIcUo58AkYfhVAJLG1m0REUknXs/moXtPpOBs16m7mtIlv63LFKfA60weVVtymGOOBCsa384HCBn51slqw3A8j/m49Zd8Wf66UmaJU/D5ujh8hvh4Fm7aILCJXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991035; c=relaxed/simple;
	bh=0FDDbc2fDjPIXUhuReKynCs90aR9N02KHYqCcMGcM/4=;
	h=From:Subject:Date:Message-ID:To; b=da4aVzjTCdjmRMqbuXp6LjLK0Thu3JTrJOMmK5Z+vRitLMV3H0d/wL0/npGWD1sdAcl7+TLla6cA9EJGV6Vg+FqX+gan1+yCrtmP6Lc1jONxPn8+i/vckMuelP9WvcUrKHfSkFwBv4LEqtlJgoLqLR2vZjl6o4v0MiVeTNyDhDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038E41F000FF;
	Wed,  9 Sep 2026 21:57:09 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.156-rt79
Date: Wed, 09 Sep 2026 21:56:31 -0000
Message-ID: <178899099124.1312552.18298473758217317715@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.156-rt79 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: d36765fb87b0b4546ad185f2362986638dd3e759

Or to build 6.6.156-rt79 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.156.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.156-rt79.patch.xz


Enjoy!
Clark

