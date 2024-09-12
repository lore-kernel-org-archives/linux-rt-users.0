Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFDA18EFDB;
	Thu, 12 Sep 2024 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177620; cv=none; b=niLtFhFeKUFlSPf343TpKc//TgBzuzFSAVvAanvWZrcldYSsLvAqxYCqaOq2DeItjb9KSkK28F/6Z5pmonWfTW6XrWP+HD9viIoQvcv89JF5ovrAmBSaoAE/+numS3i1MOgfMvsivLGQfK26Gk1DiAetAgqccT6YVPt8iHCAhpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177620; c=relaxed/simple;
	bh=krSYYjyPMQeefoH5prZPVGYwp4FrMDNFwDZqPXGQgTY=;
	h=From:Subject:Date:Message-ID:To; b=Hl3sFPnB4PTrFDG4ssuuF7KDu9tqhPZKieFD8jcWsPQSIUQrmrq4GcfGY/ueXRL6b9PLn4YYcML5AO2iFYiol7Vo+XKL7WSc0Y+nesplW0Lz+LD3OHPb/X1VogDFIzlBj9LNqjItEqA/hKYgW7EPT5H/czw6P9rnbEhVWYFylWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A845C4CEC3;
	Thu, 12 Sep 2024 21:47:00 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.109-rt41
Date: Thu, 12 Sep 2024 21:46:33 -0000
Message-ID: <172617759331.2151848.2033497699821892330@demetrius.lan>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.109-rt41 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: 377daab18c5c4cb9b4c0478b6d30fe1f09b8548e

Or to build 6.1.109-rt41 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.109.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.109-rt41.patch.xz


Enjoy!
Clark
