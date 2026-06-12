Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F7348452;
	Fri, 12 Jun 2026 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272907; cv=none; b=tNokUydKmqJaDvr39CFpDh+joS0PiRcNDJ8eoIO7i3M9JYALai1rNPSIHoMoB7kCEwb2Bi3IYgB5BeIMp9NreahYTrzO16bnqxgA8Y852rmioBemRH2frcfjeU5nz4pUP4J+48dKDNXYGOhaYOd4k2mIs/uumZVaEUFDpffynQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272907; c=relaxed/simple;
	bh=UGYl/5+Yq8RlyvXtVUbpTU3/pW+Q1rxn+kWhDScNiH0=;
	h=From:Subject:Date:Message-ID:To; b=pEemEWup5fxhByfoIhZ1bxRYN45XjdTt2pSkrV/gS1abGMPkOj5dlkQ6HRRuyHjQU4s7PINXJ7DSjh7dBfHMwYlaRikpChXg1YuwAE6/WGNGzbkNLB6mFyE2wa0UuZshA57Gg7OzQr2tLCETOQ7ap5ONJN+rFea5kkrfrwA7nSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1A01F000E9;
	Fri, 12 Jun 2026 14:01:45 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.142-rt75
Date: Fri, 12 Jun 2026 14:00:49 -0000
Message-ID: <178127284924.2523328.7130718293677661125@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.142-rt75 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: ff2d8f047b521d58efb6a53a4521a327a4f34c95

Or to build 6.6.142-rt75 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.142.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.142-rt75.patch.xz


Enjoy!
Clark
