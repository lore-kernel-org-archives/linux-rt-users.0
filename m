Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCE3546D6;
	Mon, 28 Sep 2026 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584244; cv=none; b=ZRBPzojCZ2A3DMXl6hYfXQWUeTs1Hsq3DHmqOJ6owRN9jaDXskppBJzj2F/eINrKXD+SLuzTcHSRgQd8rA9UMI0sqojMQ+R1r15JmzZcM0hi1GS+vJ31Qegx9ya6Utet/spSNpLCagh1bATfdLi+vlKxDjxVgaQfwP7h55FbkQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584244; c=relaxed/simple;
	bh=oQjHm7sEy+oh7SJWSJZ8N5kBh62Zvmh2K4EEsJpmSDQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IlGAhprRIIKH+YHk0wG8WQj0LKIiw/MxFuM3iDkG8X7l0sV6vn0CgU/qRcsl1jW3U81xuVV8Roi2+RxRtPcG3YqaA45DAPvg7WMi+PCiWTfwF1mosoLg2P1z7gUJkyEoPAiPdlkTCrO0t3ZW7dkd3Fip1s91JLcKOv3geEuXSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=permerror (0-bit key) header.d=monom.org header.i=@monom.org header.b=VwnbiQF5; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=y4WwN7GG; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=monom.org header.i=@monom.org header.b="VwnbiQF5";
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="y4WwN7GG"
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1790584229; bh=Z+E1mFhW1QTgJSUbNOSCRFP
	vFVqJS8RcT7jrbS3GYek=; b=VwnbiQF5X21M3/oU488sXwZm/b6eaY1OTKFuGz3ESi0bREhwf9
	yusv5uzf/QFTW2GzIJIS+zzT1LgnBVh+bxBQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1790584229; bh=Z+E1mFhW1QTgJSUbNOSCRFP
	vFVqJS8RcT7jrbS3GYek=; b=y4WwN7GG0PjPYB2Z1i0I9oi3YdSxtyPq9fyw17sD6TFcxOGAzs
	73Sb9MTFk5C+gNUxNUkdArYMRb4urHRYUSxD8RGHfMgyp3QOei42fXTIQwZkerQ2rJHTYDzhY7l
	iF+Kn+gjAeL2gpTd9InbuiXIwdiabEX66LNa2kPvlnApm+pkgl59MZSLQOJmbfuU7uo+0ykTYbQ
	WfTQBKr/qK53mbl4Up/y24FoJQ1q/n3MQskKVJeGzAifY9D/jFTbuVQSvxetBCzgs35aIn+IOro
	kjcIt7FOwYEbe8Rg7itud7tvimR2MYeI77KBZ2bvuVW0pW5YXHmR1tOW1joTLEunUgA==;
Date: Mon, 28 Sep 2026 10:30:28 +0200
From: Daniel Wagner <wagi@monom.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, 
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] v6.12.111-rt21
Message-ID: <f2e55011-72d3-48fd-b680-68421d77239c@monom.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello RT-list!

I'm pleased to announce the 6.12.111-rt21 stable release. This is just
an update on top of the latest upstream stable release. There are no
RT specific changes.

There is a bit of churn due to upstream backporting a couple of paches:

 9482507381c7 ("powerpc: Add preempt lazy support")
 6421a07d2ff2 ("ARM: ensure interrupts are enabled in __do_user_fault()")

and some updates on the patch context/hunk. Nothing serious.

In my test lab, I see that x86 seem to hit higher cyclictest values
than usual. armhf and aarch64 have reasonable numbers. I suspect,
the stable tree introduced it but it might just be my test box.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.12-rt-patches
  Head SHA1: c49530ec12e3772dd6e6d7e5cc23d3512e1fdd73

Or to build 6.12.111-rt21 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.12.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.12.111.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.12/older/patch-6.12.111-rt21.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

