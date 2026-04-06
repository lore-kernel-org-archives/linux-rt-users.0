Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60723C503;
	Mon,  6 Apr 2026 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775501687; cv=none; b=QCOB4VgJWI/d3Cx322r/tvItw0m6RxOyDImwhYGZeq1dcHB/pjEiv3tfZb9iJtyQZcbZ/o1vMqsOgSRCN9cfc4PmJJYWo1wkiUad+lIo2JPnOA5oUb+Mev7DI4cGo2X8/i1lh3AdQL7dD2124yfkrLjIKQmGsfZlqpoTYS3GRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775501687; c=relaxed/simple;
	bh=y2GvP0tWNYkIrwiryJD2cmCxIUXoyyF+Fhm9W4dzkS0=;
	h=From:Subject:Date:Message-ID:To; b=Y+9Z4/Y0VQwt7Gjr9djl9QDHpTIRUlQRCVw+YD1XZGaYw62NW/Pj/Z0xxhN5RgG/PtGJ78UWFYTYv4Ag8WBr/9WyYkyPoz9fOQqk5CYEixRsPa5KZ75FC7jRqRv4uE6XOmIOGaQp+aFrP4zkI2Py1xYU+DEwKxUJThUWB++Y8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D19C4CEF7;
	Mon,  6 Apr 2026 18:54:46 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.132-rt72
Date: Mon, 06 Apr 2026 18:53:42 -0000
Message-ID: <177550162290.1942373.17537417649048488918@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.132-rt72 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 9bcf677615903420471c261307c08e7f444b3d5b

Or to build 6.6.132-rt72 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.132.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.132-rt72.patch.xz


Enjoy!
Clark
