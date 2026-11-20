Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215644;
	b=1Av7TAPdlsez29tMGitgJM3xCXAMO7Fs0ZbuTC+kNMjuu9Js6DL/oc+izY1WmlwnSVmo
	 qE/SuCAgOEZDs7J97dpjulPdDCL/ejljWX1xeYH50naONdbWOWGlJlEuZRRSAyzxbbwgq
	 QGkka+ckWCsCK73QmPtlnVlKRhND9F9MxVbPS8rCt4i8nsiw7nW0fLknwxcAd2HdTFVoC
	 Y6QXxLDGrgpdOOBZmMd5sN58k2E5bpq2yZB4KohvbqRQJarTAgM+IaCR02FK/Ndmjv77z
	 dZw6ZESD5gF4U5E9VUOIvGRnn2BEeSbvRJAqmli2VT0GW9zIryKP8sqvBqA62cMtVaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215644;
	h=Received:From:Subject:Date:Message-ID:To;
	bh=eZu0bnUqJ9Cs4bGoZYLH5I9fM+JWXL0YaLdYJ2tNGqk=;
	b=k345blS2Wt/skhMbZ48M1KS+gnfgJtAPOxkSlJjgTZwLNFAT3rPiu7FkTHDIDhedvIg8
	 VPm94v8qmm2efMB+IHweTbY+D9369478hUODcU5Ozqf6ojlwYka4AydEJkoqrMyTVu/iF
	 x548ojs5VXrI7QY/c3uUboV2SUvhMGnWDFVfLbm1/oZiacAuauQ+bhVU5EZ8f+hdqGLSp
	 EGYMVzg8jHlREOpIzY4C5mxI8XEeichkdS8C/++uWmX0+3VCq7923r4UlrUs4H6dgOQA9
	 FSctDX+kkRNgAgKGeKzJpoxUABX//YSHH98g/DLwPqHyx7dCs+3lopWtDS0jZCAEJ+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3352606A6AD;
	Fri, 20 Nov 2026 23:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B9D1F000D8;
	Fri, 20 Nov 2026 23:00:43 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.162-rt84
Date: Fri, 20 Nov 2026 22:59:50 -0000
Message-ID: <179521559005.483420.2437360514904890198@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@oracle.com>,Luis Claudio R. Goncalves <lgoncalv@redhat.com>,Stable RT List <stable-rt@vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list

Hello RT-list!

I'm pleased to announce the 6.6.162-rt84 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 9750a36c0653aef3376bc6daa07de1429662e3f9

Or to build 6.6.162-rt84 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.162.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.162-rt84.patch.xz


Enjoy!
Clark
