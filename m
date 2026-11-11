Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417923;
	b=opaeFRAcurCuBTwgjKJJxagbr6p4xRsCcIhavtIFXSEYkSoKvaZTZmlD8OO5JBP29kCe
	 LdWI7s3KEA4xFeFRRwtb9rrEM1EKtzZFWeRv5i6fdy24HdcqZlXrCZ0vYqEsv4E5dK6bj
	 vDxepGnF8av6lamwLVtvdX5rixfWwhgLnaHyoibAinvcuC/BTo1hsb177SvGacsvJrVIy
	 rOP8yzphv+f1sxOcxUMUVpB0uPbfO94Mf7oDQ62zEMhQs9cbPx0Do1h341l7fjf/og+Uu
	 W8X/iEgAO1oW6EV4pjv/N4oAxdD33MwPJOaZ8DP2JNumTU2xBZa6p/ObUyqdHg3ZCpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417923;
	h=Received:From:Subject:Date:Message-ID:To;
	bh=tuJ2SjwU07T2fCRIlgfWNCsiBeVOvs8/QSa8o+QJUFg=;
	b=4qqRQYpPSWkOMe8yTbUJBFCe1yNhXnhQtilp9pOLcl68BT73gO2bMqIAPbma5c4beU2c
	 A+HgYAf5iJwcTwd2qwSa+yTzYWkPoVQmqwSV9DNggmZzRHxjLSG3yr7wqjd+K47os0c3G
	 wvwESzp0EX3tkT7lt0HKhduf7p5buSSAJDBYdhopaVBr5yz9NBnNJ49J4oiJw+BfMU3EB
	 E2uWd23iqOVCdZhjt+SBfLGuep26thE2QeNKR6YR/Yp7R7PpaFO8tBM0mCsjFoHNOt7io
	 TjJPTO5O/Xur8uamEaYhLhdUReUOCCA+SfFdZZZ7PCPbe1NpmIJNpRN7pqiQbkjfVVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FABF606A31C;
	Wed, 11 Nov 2026 17:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED441F00A05;
	Wed, 11 Nov 2026 17:25:22 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.161-rt83
Date: Wed, 11 Nov 2026 17:18:46 -0000
Message-ID: <179441752601.954647.10853815893189325757@demetrius>
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

I'm pleased to announce the 6.6.161-rt83 stable release.

In addition to pulling in the v6.6.161 stable update this release contains an RT specific
change to deal with a HyperV problem on boot. This happens when enabling the nbcon logic
on a HyperV VM in earlyinit; the work around is to defer enabling nbcon to subsys init
and is the following commit in v6.6-rt:

5d3b844b381e printk: Postpone kthread startup

Please let me know if there are issues introduced by this commit. 

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 97c4bdc10a4ddf647a09cfdbcf590dbc77dd25b5

Or to build 6.6.161-rt83 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.161.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.161-rt83.patch.xz


Enjoy!
Clark
