Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB11FA1
	for <linux-rt-users@vger.kernel.org>; Sat, 11 Nov 2023 01:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKP/+5Zt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1088449A
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Nov 2023 17:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699665805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=o1A+pdnJXjMJkQyrzlTB6QKNGSkUIRGvX4wgLP5GhCI=;
	b=UKP/+5Ztv0O2fl2yKfeEOtcyXs88gjy97no4cWxWqnKWsSTOzHDncAm3To/ylwkebexZuH
	cTTMqGw2dyqGlnNr1dD+KMfRUQoEUArhbx/kc1HZq50MBt5vxAcD6wrgeC9b/dIgOrDMuR
	g/x4kPOL+eaDuKaqq1VSKUWsywrqEhU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-ThnGvmezNLe8DU_L2mMylA-1; Fri,
 10 Nov 2023 20:23:21 -0500
X-MC-Unique: ThnGvmezNLe8DU_L2mMylA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0BBC1C0518A;
	Sat, 11 Nov 2023 01:23:20 +0000 (UTC)
Received: from localhost (unknown [10.22.9.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8161FC1596F;
	Sat, 11 Nov 2023 01:23:20 +0000 (UTC)
Date: Fri, 10 Nov 2023 22:23:19 -0300
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
	Mark Gross <markgross@kernel.org>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.328-rt156
Message-ID: <169966573344.87715.14465550502037567772@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hello RT-list!

I'm pleased to announce the 4.14.328-rt156 stable release.

This release is just an update to the new stable 4.14.328
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 45b1e061478c963779792ea50ecd2462e75a76a4

Or to build 4.14.328-rt156 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.328.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.328-rt156.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

