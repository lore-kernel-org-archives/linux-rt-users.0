Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2A26C3B0
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2026 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511972; cv=none; b=WtrmCw+3PUxiay9XvUouj2z95TrQnlEOlCIIiFOcC0NvIRGHg5yC2DpPaagE0omCsuU/xzxc8Kr9boM1s5Rx/M8QXqeMiyEnVdf09leqv+Yj8qlAQxBv/aT2AfKUnyhOtD0gtGWH3Cbl3zv2Re+dmBPPvNoKS6SPuLapG1QVV3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511972; c=relaxed/simple;
	bh=xjA9EvduX5pmJC8ytNmaYzmN4k9fQ90AOTXbT3HijlY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pC0bvhKYd2Ubn3M+vS+Hzo+7MqvLUQu8yGvMv7outKaiLzMoo3aQStQUi74LJ/rw3pV99rdtteYl8k+cBBdFGoq7uef5VJ0Mp7/2/+2J9/1As4GuHXkEqNFhLulwfOZFjkru4QMHtx/j66OAhwbPuf2+PLkC0M8cY6pK0gLKFec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KJI6ASjv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KJI6ASjv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771511970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=YWa6SLfUzdm7cY0qsrftmMOfyjVwtsqvVI7kJilzSfc=;
	b=KJI6ASjvItb51aT5qn9awL5Z667q/nYxp7R0F73pvocbuGcYJ4nmHHcnWk32vzuDvyQba4
	xeMghtMrFG72KLLnbyxTBsXJ+wTqQfcbk3PNEtWVujL5XEEjG3STJxEbqb+bnaKuwvvO1K
	HeDZyUV+RTDrIKhV0A0lNgz/J5ZPrtk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-59miVG5XPkC7F-KxwZDScg-1; Thu,
 19 Feb 2026 09:39:26 -0500
X-MC-Unique: 59miVG5XPkC7F-KxwZDScg-1
X-Mimecast-MFC-AGG-ID: 59miVG5XPkC7F-KxwZDScg_1771511965
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D152A1800365;
	Thu, 19 Feb 2026 14:39:24 +0000 (UTC)
Received: from localhost (unknown [10.22.64.100])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A769619560A7;
	Thu, 19 Feb 2026 14:39:23 +0000 (UTC)
Date: Thu, 19 Feb 2026 11:39:22 -0300
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
Subject: [ANNOUNCE] 5.10.250-rt145
Message-ID: <aZcgmi3OLYUAn7k8@redhat.com>
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

I'm pleased to announce the 5.10.250-rt145 stable release.

This release is just an update to the new stable 5.10.250 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 291e6d8d18589f662e9e02185277222f4d7bed4b

Or to build 5.10.250-rt145 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.250.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.250-rt145.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

