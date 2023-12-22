Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3C2E836
	for <linux-rt-users@vger.kernel.org>; Fri, 22 Dec 2023 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5rmGmKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703276165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=8xtxj/V4QGdZ/hKKDXa1uzZd1V/LLe/jGwDV19XAKAY=;
	b=D5rmGmKNGvdEKtCb26dI6V8pXY69HahmwIh+yZ1/ptoxRyXJsO2yCTSZ1atpd/vheXQe6k
	of8y5iCUArCKGmM2/DH7aby60WkPVn8GyFX67EqfRIIaIkniyosFpGKPjNzh7CxIVr4zvA
	b8QgFsWpzLZmKDqIexawkhrsrZ68GEM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-AZyB6zB4MY2mwLq-md5MGA-1; Fri,
 22 Dec 2023 15:16:03 -0500
X-MC-Unique: AZyB6zB4MY2mwLq-md5MGA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 026EC280D46A;
	Fri, 22 Dec 2023 20:16:03 +0000 (UTC)
Received: from localhost (unknown [10.22.8.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 29D60492BE6;
	Fri, 22 Dec 2023 20:16:01 +0000 (UTC)
Date: Fri, 22 Dec 2023 17:16:01 -0300
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
Subject: [ANNOUNCE] 4.14.333-rt158
Message-ID: <ZYXugVo4O53IWwE3@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hello RT-list!

I'm pleased to announce the 4.14.333-rt158 stable release.

This release is just an update to the new stable 4.14.333 version
and no RT-specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 33cbc8b5610cf1ec35407cc3434385dadb71b8ed

Or to build 4.14.333-rt158 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.333.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/older/patch-4.14.333-rt158.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

