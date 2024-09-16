Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE71849
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Sep 2024 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726447991; cv=none; b=hX2eFhEYfrSUmvrPbAuadTD0MVASVgxr4svgP7NOe63TxpXayvqWWfMyNGDyCA4+7fSOToVPAJFhJH6NM51lcmxyBczIrvw8s1rl+QgyHqvbF9i7MquHp2mFdVBzv97jzdkGdJ2ExNJJXxGJF9XQw3fiS7ISCITqC1Y9EuBQTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726447991; c=relaxed/simple;
	bh=7ptS4d+Kez5x/n0q5w9Xw6UVDUrwFHouEupdqfSrkns=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d38GpmB5aXUOvESYfR5A3npHJH4z2afYbNfejZ0ltmXLVfn4nGlAJWs/U6Ytbd+H1vY956kEZnI12IaWPpTZBrGTZJXQUKMvsydXfN4I32m8PvWSLQdy5jH+ZFVrSskoWGsbveHi20S4fw56bd+e9QTTfJKkIOwi+SbQuG3BewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCCOuZw7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCCOuZw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726447988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=W9xeun1rS2VIHMtxn2PXsiferWGfZ34revYU+3HcvLM=;
	b=XCCOuZw7YqbZxVa0R4twq1SCakmgqggFSGzf6HXLqPYNFizpcGEFKD8txC2ClexhxElml3
	+RygtJsAZWWtqWvndJNh2gK6NCt3m6JLFmg+NfRDUJIkqNkTkfB3+R8ZgGDg8azvF7IMh0
	5o+oOeBwUn/B4tRVyZsUVVdMrIhRCkc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-it04YT9wP_mV3SPFkoRLJQ-1; Sun,
 15 Sep 2024 20:53:05 -0400
X-MC-Unique: it04YT9wP_mV3SPFkoRLJQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9240019560A7;
	Mon, 16 Sep 2024 00:53:02 +0000 (UTC)
Received: from localhost (unknown [10.22.16.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3B2D1956086;
	Mon, 16 Sep 2024 00:53:00 +0000 (UTC)
Date: Sun, 15 Sep 2024 21:52:59 -0300
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
Subject: [ANNOUNCE] 5.10.225-rt117
Message-ID: <ZueA_L6tsYyy7MT6@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello RT-list!

I'm pleased to announce the 5.10.225-rt117 stable release.

This release is just an update to the new stable 5.10.225 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 144317400e6c514f3bee1da73d940149e3a7b882

Or to build 5.10.225-rt117 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.225.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.225-rt117.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

