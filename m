Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053975;
	b=kOWIOTa1fsB+u7o+NaOMhiSRND6PdSsUmWzC6eD0BfrMhcyHmxn2L6lHgYInF3QTzMwt
	 9vZMJVmvxVTYng6EuRSC6MqMljetlvt4aC6WR8IKDXsC54WoxaAKNJuO/KVK6ikN7hcmu
	 peGc5xvp3R287SS2/6O9kqgK7+atF2Ts+zWiMN1LwY+eDAwuIC0dBjG1vzZUIgkQojV49
	 91Pjk8umHeR8nCnR6cFOeXIIqJsKHyLKk3PRO6pIIChzRBUrlfXfyhLL96oklZ8d29dAs
	 ROrPfAg+cQDT0UV85Rc1Ptiyk306Pb9RiENnxpu7ZPIq2Xe5t6i+jpcKcrt00+TdinA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053975;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Scanned-By;
	bh=G1d8k563YQDJ71mmcda6Rwptt0xRXOtWeCJDb9Kk1Vw=;
	b=3O6ecAelfdbQ7er0xYsKBut7PRDecCGCKIeDWGbHqNziOS2M5JZMlRRUOibb2lygumpb
	 vW/NfIh82/tBvAWHMSj2u2YbTMz7s4Qk21Ux6nEt9pESab89cgnkTSN7ZHg3FpSit+2EM
	 ggU1YDE2MAzBPgG9u0OBB4xbxgtdQFW23I8PI6li/it9OwJ+4YmrCyrP0VZUjW1g9RBDV
	 q4xNBPnFStWNQRmAOXOBJ07CU9yp6KYBH+LLq/SXXSo2giJG2QH2j3YSSI64VfrdGrV3/
	 OVzmG4hYb5Ni58eFDkjpF6t3q+IQPyE33LqtRjog2xtfm+S26ZDMmGzKB6Qq4kB5maw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="BV/LdLhZ";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B21606A326
	for <linux-rt-users@vger.kernel.org>; Sat,  7 Nov 2026 12:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58B21606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BV/LdLhZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794053973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=G1d8k563YQDJ71mmcda6Rwptt0xRXOtWeCJDb9Kk1Vw=;
	b=BV/LdLhZwZLLlLk0ph6ffSLKwCQXILwLELose7fJj2IV5nz595KBBzcvLO/DziUrYz6rp2
	em8T6WifTNV22w33N39OWAett/MR6UxIx5BDgitn4K/Di/fjmdGiWUxqghloWcSG9uAeIy
	ZQ31KG5k5YCTgR1Q15/3HQ15JlcF8P4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-RmDsp9HPNe-eInhw8J_KWQ-1; Sat,
 07 Nov 2026 07:19:29 -0500
X-MC-Unique: RmDsp9HPNe-eInhw8J_KWQ-1
X-Mimecast-MFC-AGG-ID: RmDsp9HPNe-eInhw8J_KWQ_1794053968
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAD0418002A7;
	Sat,  7 Nov 2026 12:19:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CFBE3001DA8;
	Sat,  7 Nov 2026 12:19:26 +0000 (UTC)
Date: Sat, 7 Nov 2026 09:19:24 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Joseph Salisbury <jsalisbury@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.15.222-rt104
Message-ID: <au8XTBJ-xFngrtZs@redhat.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello RT-list!

Joseph, copied here, asked me to perform the v5.15-rt release this cicle.

I'm pleased to announce the 5.15.222-rt104 stable release.

This release is just an update to the new stable 5.15.222 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: f63f7e53a7d5b10e9074bfb35abe9dff68a5cd22

Or to build 5.15.222-rt104 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.222.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15.222-rt104.patch.xz

This release has been tested under KernelCI as:

  https://dashboard.kernelci.org/tree/stable-rt/v5.15-rt-next/v5.15.222-rt104-rc1

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

