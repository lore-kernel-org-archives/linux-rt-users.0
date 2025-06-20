Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B12D29CF;
	Fri, 20 Jun 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433209; cv=none; b=XoRdJg1jQAZqwfj3hYxQbLOE9M2c7yqh9mQaoj7c1pHXPbxgVgSacqTaHMUwf57uPq+mjwp/Onj6ibt3totR8gt+NmkziG+18cpGBMdJ+ul7EjMWFJO8MVic9bAsqydHYGyOMDUk/JQrgxvauZwz0GNuY1r2vamfOYnj7/agSBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433209; c=relaxed/simple;
	bh=+0zhKy1g6PNtANTN6ZpcZbuS0dBxEP0BtiSLjAgOTp4=;
	h=From:Subject:Date:Message-ID:To; b=eYTi9WJnA3qS2pw6VkqTOl6gHQsNX8AOQnk71de4GVGszfA+Ncc7alktapTCpSc986ry7jsNluxWIhVra1BDrYJxTbHEE3x1ygXlxfHSysQJUozX55FtVV+2YSA9+/TSWwxLqEebyE3x+U8k8DT0cDiQZ/FXD+2l1xrj2PZt4yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66C7C4CEE3;
	Fri, 20 Jun 2025 15:26:49 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.94-rt56
Date: Fri, 20 Jun 2025 15:26:05 -0000
Message-ID: <175043316566.669148.13236685764068104135@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.94-rt56 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: d2cfda749eb5e01dd572b9e293dca7cfdb4ccb8a

Or to build 6.6.94-rt56 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.94.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.94-rt56.patch.xz


Enjoy!
Clark
