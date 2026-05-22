Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9171A3172
	for <linux-rt-users@vger.kernel.org>; Fri, 22 May 2026 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779409251; cv=none; b=ncrAFqWBleH4xgQigszQERjIXD6BvrfaPBskVNpLbIcdETUEnFs2DCqXhjNZaQ+jfP9aZMsbKi2XRMn2ykHvi7UufvdndNWHmbGlv0RTNGLr6WxUxNvy7Ozb2J2XwJttLxvJIFQzJfOp3jVO1zB0afcuoZBD3IU21w30eGaP8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779409251; c=relaxed/simple;
	bh=yUlbaiv3WNtyjPBMZYM/f3Y5r8GGjyNxE5XeKZYCPHA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uMwmvNoevadZGAHzdgz/p3BSt53lSpko+whyRygrSvhq/wlkRZQVw9iS2jMppQoMdYXqibNHFm7Kwmr+lfGew9lxBwDofIr+6dF4eIOU7jKlRmkYAVMsiBpOsdNfV8cXvKUA6BV55xzcenkPaGl8bwFMDb3KGAJFT46BVhac1Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/Yx/EBa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/Yx/EBa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779409249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=WtozGPuZxTDGxW7FIZN9CTlNDCQeQBiosgPoSCaTWbQ=;
	b=a/Yx/EBabojRlEe32Imtthi1nb8NbpNeo9gtILFmoGUMUzp1g/G31kJKvcuD6eR8sE5LUY
	8ty43Ll0Puia/VD3Cwx6XC1UoRuOCYRqp4SPI3Wz8aVpP4lhOLsF1TPGWFbxAbitA1Lre6
	J9d3ilcY2duXCpAo4y5E15LaFJqyzvw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-_0U9shuGMcqS_4hcXrERKw-1; Thu,
 21 May 2026 20:20:43 -0400
X-MC-Unique: _0U9shuGMcqS_4hcXrERKw-1
X-Mimecast-MFC-AGG-ID: _0U9shuGMcqS_4hcXrERKw_1779409242
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 566B81800451;
	Fri, 22 May 2026 00:20:41 +0000 (UTC)
Received: from localhost (unknown [10.22.64.8])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37DE41685;
	Fri, 22 May 2026 00:20:39 +0000 (UTC)
Date: Thu, 21 May 2026 21:20:38 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.256-rt152
Message-ID: <ag-hVkiKF66IQOhJ@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hello RT-list!

I'm pleased to announce the 5.10.256-rt152 stable release.

This release is just an update to the new stable 5.10.256 version and
no RT-specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 4a5c544709565d0f6910be5c3134ae33972cfc76

Or to build 5.10.256-rt152 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.256.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.256-rt152.patch.xz

KernelCI tests for v5.10.256-rt152-rc1:

  https://dashboard.kernelci.org/tree/stable-rt/v5.10-rt-next/c6fcc03330fde184543f0cd3435516580a6da16d

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

