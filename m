Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D8551988;
	Tue,  8 Sep 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876777; cv=none; b=Ba5AYITmEH+3jxgdctUrHVjpDdR/s87Vu8didfJFcBEho7/vJtgC9N0axCLkAvLRgdNf5uuQKgdh/+pBNqZkDpwI1tfYYxxZTa+VEAIcAgfOP1NFd47z3lN5TAV3fuDpiAsUAxr2V/5TgrptIcer40caxX/MQyJhx12kzjMesUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876777; c=relaxed/simple;
	bh=Rnde3LnERbBISGFPjvAhGuoIfBj6UgB760DpGpKIrhM=;
	h=From:Subject:Date:Message-ID:To; b=j9XKIXXRjc0KKPvH6EVw5hrhYxG0fMGmMd6R50SigymS3ff/3NVUtv6cjqEGp7fIdJ5SdW8B6plGHsniueCYegeYxdDjQe4Lm9FqtNLscDViXREghQmuw5Ga+3WabtD0t0v7Rh5FYacJQNywYYwHQh6QUieYSbOo+SejmGhzeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366F81F00A3A;
	Tue,  8 Sep 2026 14:12:51 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.187-rt68
Date: Tue, 08 Sep 2026 14:12:05 -0000
Message-ID: <178887672559.938703.5575015017829953375@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.187-rt68 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: c1d28e881fc23290450b0ba3a5d9a78431061256

Or to build 6.1.187-rt68 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.187.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.187-rt68.patch.xz


Enjoy!
Clark
