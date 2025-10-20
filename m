Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909722172E;
	Mon, 20 Oct 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978263; cv=none; b=jBHyXg0dRbK41o4FaZ/H2C7rQpQwZfg3C4ciTRW5PpVXX/6sSQl3WRZfHJQz3hgUl+igJD2iwchTsb2q2/Re4Wmssapw+CkfZcbZm79veiEEgLRPIRpgtbT2MtJnF5Jdj1vf4aoAL6W6m/V2kg7mjQaWDaw791oArEtGWO7XuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978263; c=relaxed/simple;
	bh=r1ADdCq7QpKcaFJB6/7HrNVeXAU01G7NnpOwOb1EDcU=;
	h=From:Subject:Date:Message-ID:To; b=GOv7Y+vQbmfWG6BhbhB2zSz0T6uOvV6aJ1WYbPEOj/MR0mFs7OD4ZQsmF3SV03UkrOfbESkie1wx4ypo4h8k41AlxLDxLkzolJvBtgbloy7dOsxJl7RJNt29fij05sTSosJJYvBq5QQb0cyZQ2CFRlMhFQKIteJXjTTiVovwtEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF76C4CEFE;
	Mon, 20 Oct 2025 16:37:42 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: [ANNOUNCE] 5.15.195-rt90
Date: Mon, 20 Oct 2025 16:36:04 -0000
Message-ID: <176097816496.610483.5965689650890990372@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.195-rt90 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: a0c83323529d395eb71e0d2648fba5a2152e977a

Or to build 5.15.195-rt90 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.195.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.195-rt90.patch.xz


Enjoy!
Joseph Salisbury
