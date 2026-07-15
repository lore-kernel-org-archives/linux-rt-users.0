Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962F3AE6E6;
	Wed, 15 Jul 2026 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132923; cv=none; b=jbTW7IzRGhAK+Cxj8EThcFMVjyODfYSZAwfUwJ/r0labw5tc/C7ruQznVc5VstrTOkuCHczNVMXBJdd8NTDkfCKpcGdWKNqnMEC7G3Lmip2tD72IR9FvvdxXkpAOBtm9aZ9AfV51fiwWQ1Tc7jNdCleMujEsWxWPzTS6jToMjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132923; c=relaxed/simple;
	bh=dXhf+XgXqb5ke6e5kU3er8Hjnz+ahyg7o6n4gW2nXb4=;
	h=From:Subject:Date:Message-ID:To; b=Z4Ip+aXluX5T06IfACUSiiVQY8dPpRTzRBdy3lZftoXC5iSlLXEtSiP8pf4i88IAJjq6FdlSZlENFtGMl0HetDPJykq/alukhQLHUlDurSngQkt5uLuG7wG2NNEB90gsHukcIuOtd2EQSOXo2S5LPOhV8nCiFBYu6rohMGG/t50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF3B1F000E9;
	Wed, 15 Jul 2026 16:28:41 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.1.177-rt65
Date: Wed, 15 Jul 2026 16:27:16 -0000
Message-ID: <178413283669.375606.12976825835885637278@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.1.177-rt65 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.1-rt
  Head SHA1: a9d5491b53aa5b098f5c3550aa4e9304417f4f50

Or to build 6.1.177-rt65 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.177.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.177-rt65.patch.xz


Enjoy!
Clark
