Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9B16CD01
	for <linux-rt-users@vger.kernel.org>; Thu, 11 Jul 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711050; cv=none; b=rR74ZwYDHPTLR8yltR031KLL2P1/NH6ERGe1w+BmqPkkQoQ3PUylQGlBgDNwvfQTtto3B2l2kvLgIi7wxGoH/Ecyf7H9jb6LGRdQOhyMckluvOiHVxpBAjy+e8ew9uwVCGxFbQl/lp79g/PcoDLNNIqke2YZf+482Ayryw0Uz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711050; c=relaxed/simple;
	bh=1oergYkWXTm94y5+7ZzuMTJoIeNgn0N1IrJVu94BCi0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e3SHd7M4dTNgyThwr2B7qmoIkUWHJ2CCfYBgMhY1lwle7D5KYoYkt9rq78ZO/TZ4bn1hNLGA2ekPz5OXLovg9X6FnXqEYPRgFIWHCSuBpY4pR1OV1CgfDpG5QVGIRq/KSmKk0UH3b+kGQZG+KVZZiahjcGXoi95soKbpwcdAZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJhmDmk0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJhmDmk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720711047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=putu84WQ0rdP2ZeyMOIhOvpzMiIiotZXLet2mvMCZ2Y=;
	b=AJhmDmk0MAzRL5lCj8QpWCgwvLHGEiUxovY43JfAV2GWQLgn/Vawccc7U9vXByZaKa9j4W
	OFGQDx3ka5RR9i1CkgZffoP3kyN2A2hY8ZxjzsWVfPtOnEWJK18WkEcS+vh0gdH5pf9Q/3
	0H+T3I0U9RhJnLFXMI0O4+NReBsDFP0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-hnxNToyFPdKo8fdvXgjQTA-1; Thu,
 11 Jul 2024 11:17:22 -0400
X-MC-Unique: hnxNToyFPdKo8fdvXgjQTA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A12BD196E08E;
	Thu, 11 Jul 2024 15:17:19 +0000 (UTC)
Received: from localhost (unknown [10.22.32.84])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6498719560AA;
	Thu, 11 Jul 2024 15:17:18 +0000 (UTC)
Date: Thu, 11 Jul 2024 12:17:17 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.221-rt113
Message-ID: <Zo_3fcnMWknpZ6Ml@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello RT-list!

I'm pleased to announce the 5.10.221-rt113 stable release.

This release is just an update to the new stable 5.10.221
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: ea80a8cd61dcdda428f61d90b3ace2c4d7682d2c

Or to build 5.10.221-rt113 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.221.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.221-rt113.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

