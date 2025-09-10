Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3837160
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Sep 2025 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463400; cv=none; b=ssHw1HdUPY7QMaBbfj0p3MgK6c40rAJq+pzR8lAWRaDzlcmQUV0zLM5a8Cp34ujQezxSjtuz/6HpSgGold0zbMEVzSc/bl59rY3tZL1vzLrXfKO1cS9rQX28IzgZWy+PbVN72O4cahe3IXxtanZwZ0jJvqn+5A1E2V5yu+RVgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463400; c=relaxed/simple;
	bh=jE0+8Pm3ucz6ihmMOGP2buLTGmVRol7Mf7pHdZ4YxqY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VYFKXhVAQTmnRCoH3fbUwolBZ3a6URULvbAg33OPyTLqj4g+AFeofS8try3Q7i8dxuu34HvrwqD7DpmNbJnDyYM8GYq5Z8hXYWXxrrSBrZWXoHf292I6ZhQsuk8q40kjV6qI4U2C8VjeiA0DjBHaA51dIN2HBLuVc+ZvHCO8hAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNU3nwSE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNU3nwSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757463397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=reiZcYS1rs95iqH9ENKEpho/m1+5VWQZYJCHL88x2mY=;
	b=UNU3nwSEZOUWqKl8vUVvyR+MznN+nM2uqoGe3oo71mOKYG1mcRTufkNPDUQ1L2W2dY0EMT
	lwWd1yJnG3PPupWZA62670i935NHl9MbNEnMscd46SyxE6FgirZqMd4nQHhIXkyfXufTt7
	X1LL38bgzNNRBx8s7Y2O3+39+KCXxwo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-93VqpowYNW2A2ZpOfyKRvQ-1; Tue,
 09 Sep 2025 20:16:34 -0400
X-MC-Unique: 93VqpowYNW2A2ZpOfyKRvQ-1
X-Mimecast-MFC-AGG-ID: 93VqpowYNW2A2ZpOfyKRvQ_1757463393
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 573D8180029E;
	Wed, 10 Sep 2025 00:16:32 +0000 (UTC)
Received: from localhost (unknown [10.22.81.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63C003000198;
	Wed, 10 Sep 2025 00:16:30 +0000 (UTC)
Date: Tue, 9 Sep 2025 21:16:28 -0300
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
Subject: [ANNOUNCE] 5.10.242-rt136
Message-ID: <aMDDXPp0Wn8Wslym@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello RT-list!

I'm pleased to announce the 5.10.242-rt136 stable release.

This release is just an update to the new stable 5.10.242 version and
no RT-specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: e9649d7c452c4703d354f6bf1acc06107009aa67

Or to build 5.10.242-rt136 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.242.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.242-rt136.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

