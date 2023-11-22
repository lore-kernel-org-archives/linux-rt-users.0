Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhZxIzTb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6421BC
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Nov 2023 17:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700614889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=/FxUcstQgrYUJ8g8gi/zeZbuKlDUSNBAqxK37Zwps/0=;
	b=DhZxIzTbL5BgT6FBtl/PsqrgCzwhpOCR611y2qKUwiu/ETrVjxsiOlLidOTAuDHJxaUpmC
	MpvIHqNtd2NI4Ii2f1DuFq6XbgWVh82puls1+KgcKwDj+KORIcL8sbApYirfiqz08FtMVL
	8kbaAk1Aeac/EYt1qbPZrgER+yNdaRY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Q127aqWFMH-YmbjCsyPiZA-1; Tue, 21 Nov 2023 20:01:25 -0500
X-MC-Unique: Q127aqWFMH-YmbjCsyPiZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1395C185A780;
	Wed, 22 Nov 2023 01:01:25 +0000 (UTC)
Received: from localhost (unknown [10.22.8.167])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 308831121306;
	Wed, 22 Nov 2023 01:01:24 +0000 (UTC)
Date: Tue, 21 Nov 2023 22:01:23 -0300
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
Subject: [ANNOUNCE] 5.10.201-rt98
Message-ID: <ZV1S4yDcPKwj5_N1@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hello RT-list!

I'm pleased to announce the 5.10.201-rt98 stable release.

This release is just an update to the new stable 5.10.201
version and no RT changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 3a93f0a0d49dd0db4c6876ca9a7369350e64320e

Or to build 5.10.201-rt98 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.201.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.201-rt98.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

