Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD015A856
	for <linux-rt-users@vger.kernel.org>; Mon, 27 May 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828974; cv=none; b=WFw1Z9/GKDuiMe+NDTcJlJsXWb66EngxcZXdXOT/VEcxasJIdJniKqZbvc5DSPK+RL1+RcrWbICFPMtD22ZvODY5QyH0l1gpg7ZVFMIH6Jh69yfyLS43asTyVy9ztIxJnigQ/cOUh/4eOh04XyYB8hdKU8fuq7n8xZ0XSjNOmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828974; c=relaxed/simple;
	bh=MOQGj/O9nENAfDWnS43JBU7cZMPlMpG68N/EL5rH1mA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Utz3xS4Z7xE5N9cXxA87sSbwhVl3rzKA/kaKJQLElqh2NKh3Vleew3RVKZML4DtJLqggU/gVbIJBqGw3Qeurv7aqv5l5WFsw+0LeV8GTJyGzSkcNUEkFODEL18aL1/IeICWR3gU+Q90UaBCToNmS3y8YNMwgBhuju4/4iF8Fjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQ4hKRQk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQ4hKRQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716828972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=sM+GG+48pRGOiykDbhBtwf9oqy2W+a03FxmKjzpcs/I=;
	b=JQ4hKRQkvuWnnqrooVip5bgakjTszjiGCF+JjPXuVyFaEhVG0grXENRIf9sEfDDYArfNgj
	CMy49okHxfhnZ+SfzrrDu1PVyF7FNM7fUOYRW6A6VENr3hVzxhHQgooyCeajbtxPafEaVS
	y6U7kKUqgZ4+zYjuWriXZTLp/7C1+TQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-FOM2wALuOK-8mPMov245Kw-1; Mon,
 27 May 2024 12:56:08 -0400
X-MC-Unique: FOM2wALuOK-8mPMov245Kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33E3C29AA39D;
	Mon, 27 May 2024 16:56:08 +0000 (UTC)
Received: from localhost (unknown [10.22.18.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6713F200A6E7;
	Mon, 27 May 2024 16:56:07 +0000 (UTC)
Date: Mon, 27 May 2024 13:56:06 -0300
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
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.217-rt109
Message-ID: <171682474597.368964.6174084453548790852@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hello RT-list!

I'm pleased to announce the 5.10.217-rt109 stable release.

This release is just an update to the new stable 5.10.217 version and
no other changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: a4119312fd0c5672efda3c8487c92e7962c8c212

Or to build 5.10.217-rt109 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.217.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.217-rt109.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

