Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9428F1D31B9
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Sep 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639081; cv=none; b=KN8PAVZ/BhpQtxQJWNdj4YsC2kCB/IogFLAybjOQSQUa2Rt2nmGMizeEG2rjAaPYOASwHyeDfYmMTC578f4Ttm/j3VlDibsmjjv3LF+NxJG51r3Mpig1C2k0B+r7l4tBSg+25y9NvSVf5ghinQHm+Hrn8QN4v83y+XL0rROIqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639081; c=relaxed/simple;
	bh=oykpAfwcT94UMpePiEz6LwFCZ3iGfocljObZ/xyUUFM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fO6nLAgVzvrWx4KoRTDvcGgI16nMDtUjt5f/cpvQ2b9M6iTU5cMASkV6flvhFt4A6i3sRHDhjzSbNhEFZ1hzKm+qeapoQFKiPTeaGCZQClT3YeAHLb79D4nKvMdyO56AuyKyrnjYNJdaGULOm3ZTw32gCQ57hQzLDZYfASdoZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmeB1LZL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmeB1LZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725639078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Ed1iMS2yIj8ipO/lLIK7Zkfp1eGpMGD3p1/JyN6nqnM=;
	b=JmeB1LZLD5A8C4uSQiUAr0nn49ob2NTglI0etOJKo5lA7h2zkrGKAr+LY5MlQSC5H+NnwP
	6xNjPLruxe0UW0evG6RpYWQh4Ocy5t1ijtkPt+onE01e+LR1FPekzApQVQsPNTlwcMhVHR
	6l8djbcxRs/S6uEB8KB5zPMuCD+v2Bs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-1sln7If_PUqoA8CRoEAdAg-1; Fri,
 06 Sep 2024 12:11:15 -0400
X-MC-Unique: 1sln7If_PUqoA8CRoEAdAg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 611A719560B0;
	Fri,  6 Sep 2024 16:11:12 +0000 (UTC)
Received: from localhost (unknown [10.22.8.96])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E47EE3000238;
	Fri,  6 Sep 2024 16:11:10 +0000 (UTC)
Date: Fri, 6 Sep 2024 13:11:09 -0300
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
Subject: [ANNOUNCE] 5.10.224-rt116
Message-ID: <ZtspnYW_sBaMvb31@uudg.org>
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

I'm pleased to announce the 5.10.224-rt116 stable release.

This release is just an update to the new stable 5.10.224 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 05045e6fd0d63692cc45e269a67cda8cd8f14b09

Or to build 5.10.224-rt116 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.224.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.224-rt116.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

