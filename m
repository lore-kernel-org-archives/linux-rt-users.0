Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568256B6A
	for <linux-rt-users@vger.kernel.org>; Mon, 11 Mar 2024 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193755; cv=none; b=L5nUhr3OV88+32VTvEsI7UZHfx9ASW0pGNPavICTwNkg4iHxNa2P3Wq32IYLV8LgVOgTifYTbn/WzcTtlNshHW8IXnJi/wzvl/99FkuP3oh7QJ7LvNTuTs4rA40w0AcsFXpgr1765OmIv+m9D/tdJN2+k2UE7Jm9FoDL+GG2MV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193755; c=relaxed/simple;
	bh=eEjkdRQEd59H50uW8dgJSWnuFy20b7EzlfZ82fVd7SU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SJMiXmzMEaFcrNNQ33d0gYtgAiRO97rnr2YQrpO+FOnzM16EbgDdOkAFcsqZ8J8KL8IfM4BnlpdQAjXRUl5TADcDMIBbxiiTtHHbShI961xJs+/IoeRN0oltHZSs0HcYF6eTil2mZqrDdIQ0GSbAB3xuY8Tod8+F+P4u98c/hOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYvpdwhk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYvpdwhk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710193752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=wIL5uIc3/B5vYqNrwsTJakvRJ6Iyj3VheIuyfLhQ2KI=;
	b=DYvpdwhkYjV6A27MKCt1kKw2BjX0uhsgsk/8sPVZGtdVAwkXA+sDqzyzJJ8KCrAFhtj+on
	m3QGROGlfSiP4zkEnM6tXpSqQB0TPI9ygq7/lV4heEKw/FtRdg1frfutZ35mnD7vhiYhXw
	dZXvYNHl2Rjh/LKqG+IhSt5JOGw1l0Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-LVJsQRu_NNituUYISq4hOA-1; Mon, 11 Mar 2024 17:49:08 -0400
X-MC-Unique: LVJsQRu_NNituUYISq4hOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D27D101A526;
	Mon, 11 Mar 2024 21:49:08 +0000 (UTC)
Received: from localhost (unknown [10.22.8.139])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 394BE2024517;
	Mon, 11 Mar 2024 21:49:07 +0000 (UTC)
Date: Mon, 11 Mar 2024 18:49:06 -0300
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
Subject: [ANNOUNCE] 5.10.211-rt103
Message-ID: <Ze98UsSvLqvlkS1_@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hello RT-list!

I'm pleased to announce the 5.10.211-rt103 stable release.

This release is an update to the new stable 5.10.211 version, with no
extra changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: bffc88bd708c173b98b61469378f763e44c733e1

Or to build 5.10.211-rt103 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.211.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.211-rt103.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

