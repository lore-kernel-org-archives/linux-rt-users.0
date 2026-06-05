Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F81A3165
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Jun 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667131; cv=none; b=X7EK3yAXtnxcizK6nu17rIGKT42ytDMpwD0CNADmgXJ1TqzA/HwqJygKcsN+Wk3V36LOfvPv08CHZqZ/FUKXO8KuP6+SuSsyM8t3Ctk+zd57/blDF+x44UowSiVk+iYXsAmjLZ/v6Wy05h0zTNo1jkuSQQ6YkV7iXlZ8wk92RuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667131; c=relaxed/simple;
	bh=RDxI13l3N4MxwmyKhpL4QhZgx1iTb4f0x04UMQ0O4zI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZQz2pqksKX6BQqVKgfRGQCYrBBnBKlYtKqtAYF04XH30PZfCeuaOk21v5Mcxn3BsxFSSGeAdr/Zpv6q3aJmxy1ShaJkHJTf4Fs2ojuYXSN4HmMQFMe9qIpTfD0PJB5mX3ot4qqLxu4PmMuBcmlS3uXDANR6nwR0gHErdcVRL6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMB/khQY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMB/khQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780667129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=5JeW4K9mJUOHlsB6KUJfK+IMQlNmCwck1xVVSS/yDU0=;
	b=hMB/khQYVd4ytxiamUHENE+h/uYuuH6e4WOctnvxugKknUJCen7nX7vgjBbYTVTJMJwoun
	WaXatnQve0Mmllw7kjRCy9d6oTIWkihS17c5wUQBV5ByHzZce1R/yFs+nVZ8UlwTk5t3L2
	DQaecC3RM5kUHANnPDdRWWTlgcAXGy8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-rQ6E50EFPnetEKqh8reymQ-1; Fri,
 05 Jun 2026 09:45:25 -0400
X-MC-Unique: rQ6E50EFPnetEKqh8reymQ-1
X-Mimecast-MFC-AGG-ID: rQ6E50EFPnetEKqh8reymQ_1780667124
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D23E11956095;
	Fri,  5 Jun 2026 13:45:23 +0000 (UTC)
Received: from localhost (unknown [10.22.81.28])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FE0C1955BC0;
	Fri,  5 Jun 2026 13:45:22 +0000 (UTC)
Date: Fri, 5 Jun 2026 10:45:21 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.258-rt154
Message-ID: <aiLS8ccN737OGR7T@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello RT-list!

I'm pleased to announce the 5.10.258-rt154 stable release.

This release is just an update to the new stable 5.10.258 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 5e3fd0dc3c85f82e56cdd6979984ceefd5b0640c

Or to build 5.10.258-rt154 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.258.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.258-rt154.patch.xz

Tested by KernelCI via v5.10.258-rt154-rc1:

  https://dashboard.kernelci.org/tree/stable-rt/v5.10-rt-next/998284d58ef829fdafbf42aed96c63b07f084696

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

