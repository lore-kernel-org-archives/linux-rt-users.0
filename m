Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253E21C19E
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281123; cv=none; b=b3teAPVApKSDwGIEb1AWJSJnkCYo7sNQjJJx1rwifonCfTxxok2lPFa/mlXnUE0HhvEazCinW7rt4pMIQu8uo2vJC/U+L/VbnMncqcfYza3K/FREP77jCt021im98oIaJ7ClrssQTvjy3ik7U/m/xmd5UEzqUDTYzEWo5KyE/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281123; c=relaxed/simple;
	bh=hU6LrB4u6zHdEtjzLO2tMhBFuBmhLxFRILKm9QhJrOA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tizSEBWR1xr/ohEymj+OOuCwvS8Z5FaLfbVGWrLaUY2gXYbSxS04wWtQJX6Of4tNPDM8SQtn0cfBd4e2TeGcx5ti1xWt2P5EC2HXOdG8dlmYJZbWVOsUxjxqjMlU4Qaq+swG3ya+2QgRnh9c3L9iQ0oc+Ph3aT/anXEQWwGWJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUbdTcmX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUbdTcmX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750281120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=si2yMjR7q7rjBdseCBAaci15mleBdg607YB98sx0/R0=;
	b=YUbdTcmXoLSyhGsmGnGdviL9IIJ8RJgtlwXD42Vt1rh3uXBZF+OfT03qOgehtJ2DOCrCHI
	A1ilQcpuW21Z50ahH80dKCbc6RcDKxyDa44iZPobY559joUSFp0uMD79L/V7VfrKk7aKQc
	1QNkHx6n53nTZJ3NZVmcyopEb2XBNCg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-MWzXy6CtO96X_crPo8LXfw-1; Wed,
 18 Jun 2025 17:11:54 -0400
X-MC-Unique: MWzXy6CtO96X_crPo8LXfw-1
X-Mimecast-MFC-AGG-ID: MWzXy6CtO96X_crPo8LXfw_1750281112
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2ABDB180028C;
	Wed, 18 Jun 2025 21:11:52 +0000 (UTC)
Received: from localhost (unknown [10.22.89.94])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 021611956094;
	Wed, 18 Jun 2025 21:11:50 +0000 (UTC)
Date: Wed, 18 Jun 2025 18:11:49 -0300
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
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.238-rt132
Message-ID: <aFMrlTjdVnfGJBEI@uudg.org>
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

I'm pleased to announce the 5.10.238-rt132 stable release.

This release is just an update to the new stable 5.10.238 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: e14e2866718ae8b8a52ebcc0ed567a0964001c55

Or to build 5.10.238-rt132 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.238.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.238-rt132.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

