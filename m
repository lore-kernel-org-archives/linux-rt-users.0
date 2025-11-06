Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159E12DF716
	for <linux-rt-users@vger.kernel.org>; Thu,  6 Nov 2025 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428762; cv=none; b=oQwXC5ae7zcD+oOg+2lWXTBur11sAH46Xu4tiF2JE5FvCUZklUFMI6b/mmkI3kr70ME4jA5/ICEtOw8vBqx90bWkgXVg2J/d33kwjhjlGUZqMe6jEtCy5vfyypnpScSlALmHnbnU5KVU5R1NYk/RcYMpcLBiV5JH69mpmJKFRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428762; c=relaxed/simple;
	bh=rXdwkC2kpzeOskXcOpVmw3AQky91ZGRKR5wdWTGOMOk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pOaPjXtSK2+50e28itme7xhbFRoLg5C1kCsZvR9Fx2t9NmQQfk4RwkM7mad2j6sKOfMB1jV0eiYpdl+e66rfLw1F7YznRTtEMzsP5dC+eLLn5PlMGU3MSTsQ0vWPuAOZGjTLVy6P0p8LTAG1gbgn3vj1k/oanduDo50l9+cn6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CE6QCku2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CE6QCku2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762428760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ZtAYXPMxLgYjZTh5H3JFSB5dtUOxCvr3cjQwTWjPznw=;
	b=CE6QCku2fytSFf4oUMYpiQKVg60EDcUhk4HotgJTAR7U5GPvOsB1tX6/di2I0zHt1j5v8a
	zxHl3/fmkM5WVoe5tOKGsU6txUrUM950b8BbXCvFfcNWZksxB2Y+LiBuC50Sda5E0Lz7+H
	6kh8QjnkjEr/MQ9H4sHOJRt9fHdWDi0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-8a4OgR3pN8KGrkdEJCOFFA-1; Thu,
 06 Nov 2025 06:32:37 -0500
X-MC-Unique: 8a4OgR3pN8KGrkdEJCOFFA-1
X-Mimecast-MFC-AGG-ID: 8a4OgR3pN8KGrkdEJCOFFA_1762428755
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B47EA1801230;
	Thu,  6 Nov 2025 11:32:34 +0000 (UTC)
Received: from localhost (unknown [10.22.64.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 894D530044DA;
	Thu,  6 Nov 2025 11:32:33 +0000 (UTC)
Date: Thu, 6 Nov 2025 08:32:32 -0300
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
Subject: [ANNOUNCE] 5.10.246-rt140
Message-ID: <aQyHUB0nONxUWe1R@redhat.com>
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

I'm pleased to announce the 5.10.246-rt140 stable release.

This release is just an update to the new stable 5.10.246 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: f897d4f7c89fcc13524137c2b79b7c26ce0703a0

Or to build 5.10.246-rt140 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.246.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.246-rt140.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

