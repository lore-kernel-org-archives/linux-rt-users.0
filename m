Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA67138C;
	Fri, 26 Jul 2024 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019571; cv=none; b=SzLT5kgK1ipe8uWum9PoKZSnkzOTj7+785mSNiMbmoaAl45IVKGcqEblSkM20g/OpFr3UnZw7oe3Nf2d8UxoNsMLKnoJvJVuKG/7/EBC7vb7q3cljrP2FDOcAQgCtcJd3UIk5Fb2ZhCevMnDYTsy6pVmxqyJkk8sT5aaBEZuQ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019571; c=relaxed/simple;
	bh=D0aWI/0rlERf/WdRlW+J2JAJ6fAkIGqMcK4Fqi3ji98=;
	h=From:Subject:Date:Message-ID:To; b=A4trQfMnoLOHTUg8Vu5Kop13XL77sTfKldFz+2OZ3swNriZIxiYJNmpdoi8PIwlzj7xIjO91kUvxzvRa+2A8fj10+mYwpO/7NY/dAp7c+nD6dSM9Hgqn2mzKNZEWoH2iKJBANKaeA3RFuah2xGcqUku6JK6/4lYu8tJX+/xJQdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJNs89WB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJNs89WB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DCBC32782;
	Fri, 26 Jul 2024 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722019571;
	bh=D0aWI/0rlERf/WdRlW+J2JAJ6fAkIGqMcK4Fqi3ji98=;
	h=From:Subject:Date:To:From;
	b=AJNs89WBw3h7VO8w2PqveO1r0BicCiY6prb2I0kcUdu8hf62LmFidQwRdmr5xPgDN
	 6Jx/o2vfRP6nNUkeOEIBPnZtItthuNqzPIpSFHG5tnvS3gdGVoCwyUGAmNWvJyER9K
	 Jb7xsDs4k+ra/ysdQrA1E2rk3ZJi9tnMfF/1OFDK8mQvbSmMpdPE/unbyXaE5K8TOB
	 rHd98rBj1mQCE0uvVJ23PYi6a/khrfLendIXAmkp8VwKy82dEAl5Qv04YFLxUYJ+oi
	 Ldk7eyyCKhHBJ+RKnybjOssndLmqtVKtr7XpalALiCWJU3uQHaeea73P+jvag4ctry
	 eR2R3+YJjQe+w==
From: Joseph Salisbury <jsalisbury@kernel.org>
Subject: [ANNOUNCE] 5.15.163-rt78
Date: Fri, 26 Jul 2024 18:40:43 -0000
Message-ID: <172201924331.2869556.14919373194936706387@jupiter>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <josephtsalisbury@gmail.com>,jsalisbury@kernel.org,Joseph Salisbury <joseph.salisbury@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 5.15.163-rt78 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: c4eff16edd4cea7df29230532bf39e1eca9ce103

Or to build 5.15.163-rt78 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.163.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.163-rt78.patch.xz


Enjoy!
Joseph Salisbury
