Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0825A13BAFB
	for <linux-rt-users@vger.kernel.org>; Fri, 10 May 2024 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377766; cv=none; b=qNrPjBTL8nkDnarjmFcEJ7AAU8MpSSlQfkcgoDqVLz8LtDsaGOPzvSinT2I7WyiamiwFvkx5YW9kGdQm4voZsa0gZzmFTKnQ1b2meGUe2KpQkoCFiCNsOGeWha882Tw+sx0EGPxK+MYcaNkPS6rzXHPRpTCQ7HL4Lk3k7jGHPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377766; c=relaxed/simple;
	bh=+nNK4hww+ycl2EEjZu+DB3rnPniLjPproECnJoapLfQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Swqy0urepfAfdSeaRVRUVNrMIwSmGmP9sIF9vF6YyfewDNSvGFiEvqvUZJ27anoWn+kfVam+oXjJgsrs14Z2ypQXZZSdJyoHfy8iAAykeh7H6tegvbk8S/r0Of0zYova2mHBO2gj/Nf5IktcAqXw9ORzTsG2gyH6/W7UeAjAlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqCBkacY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqCBkacY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715377764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Oowk90sqfml4YNrnonG1SBezdP9RE70uhV4ktZariMQ=;
	b=cqCBkacYXj//3oYUHx0kcKMjyZz6Cm20NBlwTTJz/oFImqlZnFmLas2bUjYeAeJ5F+6ISy
	ve3jxguyJ0eJdvZIuLpbEU7dDnXD4a+XK29e+OanUJA1B46rGDvqFnbBx4LO6enn5JE111
	VOk0vAspMI2vmXH8VtgKdzsaq5T4Rqk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-mxGkenmZNwWvFjHZ5uqEkw-1; Fri, 10 May 2024 17:49:20 -0400
X-MC-Unique: mxGkenmZNwWvFjHZ5uqEkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B3C9185A780;
	Fri, 10 May 2024 21:49:20 +0000 (UTC)
Received: from localhost (unknown [10.22.33.191])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2F6D96339;
	Fri, 10 May 2024 21:49:19 +0000 (UTC)
Date: Fri, 10 May 2024 18:49:18 -0300
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
Subject: [ANNOUNCE] 5.10.216-rt108
Message-ID: <Zj6WXvAhngh5-Iyv@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hello RT-list!

I'm pleased to announce the 5.10.216-rt108 stable release.

This release is just an update to the new stable 5.10.216 version,
without any RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: f0ba9d06ef6b1edce9a62b662415d70e000efdd8

Or to build 5.10.216-rt108 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.216.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.216-rt108.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

