Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D111B87D3
	for <linux-rt-users@vger.kernel.org>; Wed, 19 Feb 2025 22:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002888; cv=none; b=jvE/vK7d7HOMAN1SeXuolEMJ8+9HK4NIVMTGFxXDeeGcOT1ecHCXmwtfwixa5w+Qnw8zGIjSh3xfTzLL7WMeMlBgoLJoIkH+kZXAWiVZJoia0qbiObdXziedjC/bYBQuLnQwwT2uV/ld8Gz7z2m3/Tj/nluxncV45C2txYuIRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002888; c=relaxed/simple;
	bh=V7vQwxlXblaaAQl8viuJCWdjhEPlGxq1ACXzj2mXEOk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gNjnW3OuApFqlcV1jaA+jGVxkhLkrULE7dvx0W2hAd9zlHmxTnQcUD2uzb4AZfwoLCEtf4epkpQXOKbA1HSU5/Pa2AR2f90P0pBe4Cg5vewaABcCVhkl9NG0Fiuaucadq/frAgXAW6pRqnf0s1Q80TXvujSisDX7VYdvYe6/b6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxWd9+vK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxWd9+vK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740002885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=y53EOOATlCn2DG42QtqaHZJ4PEMtSyt/jgLIyo3SRRQ=;
	b=gxWd9+vKCKlaJ55+jwVFgA/H6XlvGP1d6G2S5/H1VnkCJqqcQTQUG9XpFuq3NDwaVDNWYK
	ZfoPsJmVaxAZqq4/nOym4vY7ngsTqc+qnp6Rsw7As/miaAYs5Gs9CsQEZlHoJZOofgIh3F
	KwH9IvdJ2JDP3qyf7ykLcI+Tea+PCP0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-eBS3boTROP-p1xkX01lmLg-1; Wed,
 19 Feb 2025 17:08:02 -0500
X-MC-Unique: eBS3boTROP-p1xkX01lmLg-1
X-Mimecast-MFC-AGG-ID: eBS3boTROP-p1xkX01lmLg_1740002880
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C83231800874;
	Wed, 19 Feb 2025 22:07:59 +0000 (UTC)
Received: from localhost (unknown [10.22.64.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6131D1800877;
	Wed, 19 Feb 2025 22:07:58 +0000 (UTC)
Date: Wed, 19 Feb 2025 19:07:56 -0300
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
Subject: [ANNOUNCE] 5.10.234-rt126
Message-ID: <Z7ZWPGBt4Pv9o54T@uudg.org>
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

I'm pleased to announce the 5.10.234-rt126 stable release.

This release is just an update to the new stable 5.10.234 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 5c5f37fc0ab0914da38776700e77a46ca3e30bf6

Or to build 5.10.234-rt126 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.234.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.234-rt126.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

