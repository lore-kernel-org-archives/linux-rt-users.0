Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66D384
	for <linux-rt-users@vger.kernel.org>; Fri, 19 Apr 2024 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487208; cv=none; b=EYYLbzAg6qZ44xRXYYM67FpVgtPXM3fVb/dHWIHOf2UfdTR+mzEE4pgEulyzdikg+ZYd57qj8aZdQFsg6JY21i/+ZvSa3xGdt/IPNLYMlPDPyfKndrsiUKB/6hpNSssWlkutIK1NbHASx+ttytmUzzl9WAjNfC1xCKsC2qaOERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487208; c=relaxed/simple;
	bh=uSfbOIFusL7yPA50dYF5H5x/u32T7cdQCxoVsUks114=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XkGD0HuLVMl1gEsgq2RRW19ICHftt+oPTc9HMjnvzNi+c6SCvI6ji2XUh8xcB4nHNyhYWYPLjp68Aii2o5jfd13xoby4XReG3gYuysbaCQgdtaV/+BLUquChUGd/DjdI3nj+Pkz2qrf5H9GmOH191BgrJKIfEqAFKjwNs4tmxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBB1gilA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBB1gilA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713487206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=m2bpW9rm2qv+2Wunav+fPG5Qki620lzFcR5jp/JLSVc=;
	b=UBB1gilA6ido81bi2mEFy6PknEYpKYHjwglpBGeTcy/EbWSRmVp9Q6C+Mon+4RB9fPv3nw
	5PjjFeejbSXEJAKx2KI+wjlo8tObDSUVeVNSp+ZHmzkaJoPw+KdbCy6HgCJhGLicSKplQH
	EVVbJ8dDAVJ5XLsnfT4bgRI/2xvj4mo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-dhEQf1NgPf6CB8kNhSyeow-1; Thu,
 18 Apr 2024 20:39:55 -0400
X-MC-Unique: dhEQf1NgPf6CB8kNhSyeow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECA383819C64;
	Fri, 19 Apr 2024 00:39:54 +0000 (UTC)
Received: from localhost (unknown [10.22.10.25])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EAE9D1121312;
	Fri, 19 Apr 2024 00:39:53 +0000 (UTC)
Date: Thu, 18 Apr 2024 21:39:53 -0300
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
Subject: [ANNOUNCE] 5.10.215-rt107
Message-ID: <ZiG9WanmSqCUNTuq@uudg.org>
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

I'm pleased to announce the 5.10.215-rt107 stable release.

This release is simply an update to the new stable 5.10.215 version and no
RT-specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: b850d563e91f696a605c28e8d6a968a950cff491

Or to build 5.10.215-rt107 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.215.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.215-rt107.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

