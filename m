Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89963486E5F
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Jul 2026 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330962; cv=none; b=hUhAlYY7C459N0IpalpJb1iDhXSGUokQvSm0PxmYHri6aFA+DPUDIPTVhPgIaT7tSc6JOhNRKqNyWp3DsXHTZZBuzEV48FQ5qWBEo9gFqD2q9yfw8pthl0RwkrDYduKjrElXmwYEvHvVMuZghMk+j9rF4IjwVKuscwXHhkJP0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330962; c=relaxed/simple;
	bh=HtVAmAgPUn85evEwL89OZyJbMozv9oeYxwsEiXF6wyE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qYdeoPZHDybaFwI5T1uourn+q9TMBh9sxyUfxH6xRtwQHBEx0P0GMbOxF3Sn7wmcdSKwKZ7OFkEmZoeqYlVsdnC7vblMS6/5vh1kV0vzig8tsGMuvNqQBMe0NznqhSNCNbwIxCAi8ccmTsCJHDZFTkcYh6bTsE2jc19OGFTOpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drFVRsae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drFVRsae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785330960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=46HDWoO7wpug+J4EQFZnp5uoWM8nPAphNROMYAv5mGw=;
	b=drFVRsaeGXqNH3fODTll8knrx1VjYEIWaoxe9spsAU2OfPn47tU/MdJxW0TIj65CurL5IR
	8mX7tN1X1dcay0MAOdA2MKP5myshL54Cf+mZj/hp3WC68rSbtU5C41PqdPWYppwIZFr4EQ
	D8UuOI/6byqMNMo5FSXH+poQxtlyzu4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-jmybDbreOKWRek8ojrHuag-1; Wed,
 29 Jul 2026 09:15:54 -0400
X-MC-Unique: jmybDbreOKWRek8ojrHuag-1
X-Mimecast-MFC-AGG-ID: jmybDbreOKWRek8ojrHuag_1785330952
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61510180029F;
	Wed, 29 Jul 2026 13:15:52 +0000 (UTC)
Received: from localhost (unknown [10.22.88.130])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5878519560AB;
	Wed, 29 Jul 2026 13:15:51 +0000 (UTC)
Date: Wed, 29 Jul 2026 10:15:48 -0300
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
Subject: [ANNOUNCE] 5.10.261-rt157
Message-ID: <amn9BEdIB3bYxcuC@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello RT-list!

I'm pleased to announce the 5.10.261-rt157 stable release.

This release is just an update to the new stable 5.10.261 version
and no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 27640dfd3dc9f64c7843a6988968e934e3cc5352

Or to build 5.10.261-rt157 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.261.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.261-rt157.patch.xz

This release has been submitted to KernelCI as v5.10.261-rt157-rc1:

  https://dashboard.kernelci.org/tree/stable-rt/v5.10-rt-next/v5.10.261-rt157-rc1

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

