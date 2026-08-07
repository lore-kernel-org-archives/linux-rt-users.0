Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CFF4756B4
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Aug 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105814; cv=none; b=sfSIRP/VlD2zUCOB+dsg5Wmw2c8x6hedvHzBrMEZFK23rgReSGkkwuKSrZdgv4D5cVMrqZcZD6jPoH9beDreLkgqgum9R5J4xErNXXZnrwEXEz28pD3aSAC6NtyuX3FwnKFhR+wqpRWPpMKZR8qYp9ggdAA69j0l8/C6UmTUeoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105814; c=relaxed/simple;
	bh=3GyTo+0486bI01439Xy95bdRzXDqCmv+SSrbqAXSqIo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GpQQS6zenNyEAnnhNcsJleaVeqgG7u8WHUJJP/0JTysK4pCIpYmpbe2O9TdGXfWuv0Ufu+TnpU0f4PifpHb0IAhFDH52QJmMlJwyVW3hsFFBu21rgR7s3xb2xJEDCyn8NfrTygmNw999bCETc4hd3PZBmXH98xEWAYq0JYglaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0CysGaw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0CysGaw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786105805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CsdzUDUChihJI+aWl5K55lkPq2+4dWEtYUwLHsUaXuY=;
	b=R0CysGawsq0eaOGw9geKQEk6LrwcX1qljprFoHqdQedbuzR0WXGKmuZH38TV45HKWcLFxf
	0pIVao7xzl1Ut+qG73ipaS6qjo49+KCm3UgEQEs1VGCAvMJoy3l3+/xHbvfhH31m4j6We/
	4UmpQ408SSxMJOPWIFaf0EVi1ZC4Qjk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-0UmbqE_cMEm2pqjdaZ7PxQ-1; Fri,
 07 Aug 2026 08:29:57 -0400
X-MC-Unique: 0UmbqE_cMEm2pqjdaZ7PxQ-1
X-Mimecast-MFC-AGG-ID: 0UmbqE_cMEm2pqjdaZ7PxQ_1786105795
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3984C1956089;
	Fri,  7 Aug 2026 12:29:55 +0000 (UTC)
Received: from localhost (unknown [10.22.80.165])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 52CF4180034C;
	Fri,  7 Aug 2026 12:29:54 +0000 (UTC)
Date: Fri, 7 Aug 2026 09:29:52 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.262-rt158
Message-ID: <anXPwFKAVv4b7L2i@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello RT-list!

I'm pleased to announce the 5.10.262-rt158 stable release.

This release is just an update to the new stable 5.10.262 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: c5392483fa8165b743971abf841ee67048bb1931

Or to build 5.10.262-rt158 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.262.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.262-rt158.patch.xz

This release has been submitted to KernelCI as v5.10.262-rt158-rc1: 

  https://dashboard.kernelci.org/tree/stable-rt/v5.10-rt-next/v5.10.262-rt158-rc1

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

