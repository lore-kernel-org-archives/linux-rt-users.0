Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C9639B974
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002823; cv=none; b=eN5NZXPa9BBFph/Vp+/hsHa3PYVhLxVR72kktwmtEB1qG8dcREg6MIO+yYGbvH3CVg7eJu3SzHk+90sxDkiZZEz/Th0tWlS/CJcPe2LtvUeCwuZes8S3VgCwMMdtCdd0K4bynQi1IQRIAOsmf81GNhLHRMvrNoS3Std4lY66EdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002823; c=relaxed/simple;
	bh=m8D9DqI4YmeYPx25nYgcYGuCvfaZ7/3R1TNCUp255pE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FS/kOCnCe1yB+4TqRmKJOQeLKSKzzl6OdGlQVSuhZ+sQ1zV5fNVlbVrnGPZQ39GVJeYvDfqj2eN2paqEGEL+ZR14mExJcusIIDwe5fQJWapOmzYzum3eH0pDqdjGUzSEWtKW+rimg40U+rYa/d+JZZ6wfhmJYximoFfJRbkjIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXecGdIQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXecGdIQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778002821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Y+2/bgg3acAP6Tef1uDEaFzFjB+7X1GJU0EeFmhllx8=;
	b=cXecGdIQqX90nhRbS08zIUT8NEaZoGECpomUsYHtMMEP5ug3qaHTA5vXVljsc6ww+u/XCZ
	5t94hVsvaXJEaUn6xUL0HwgtBLdSNe9YVGnyGYQrLoaq273x8GQOowDealm0f3JtBwf/o5
	FO7t4Ho2lH9Gq3PVrH0B7gSHhpJUVCM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-ETXN-bQMM020RrtOgojavQ-1; Tue,
 05 May 2026 13:40:18 -0400
X-MC-Unique: ETXN-bQMM020RrtOgojavQ-1
X-Mimecast-MFC-AGG-ID: ETXN-bQMM020RrtOgojavQ_1778002816
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 401751800345;
	Tue,  5 May 2026 17:40:16 +0000 (UTC)
Received: from localhost (unknown [10.22.80.183])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FE8219560A6;
	Tue,  5 May 2026 17:40:15 +0000 (UTC)
Date: Tue, 5 May 2026 14:40:14 -0300
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
Subject: [ANNOUNCE] 5.10.254-rt150
Message-ID: <aforfpN2Y_oYr8e8@redhat.com>
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

I'm pleased to announce the 5.10.254-rt150 stable release.

This release is just an update to the new stable version, 5.10.254,
and no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: a8821e9aac9b10589a170665e857ffd233281225

Or to build 5.10.254-rt150 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.254.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.254-rt150.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

