Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598161366
	for <linux-rt-users@vger.kernel.org>; Fri,  1 Mar 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311083; cv=none; b=HGQLQiV0E7dNZKl92m871VI8qo45T3wNs+XqNz1lSgEoc5oetY1uZDeaE/KvFzWkTOHksaKN48YCmiI1gPiDVWbIdzbAVLwONCYPfNlok2p2qxNxd8KJTzTL246NzgJlk/EuYdtJbAM4EgckHNsC7sz0X1CWkeEquJLZ4snrHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311083; c=relaxed/simple;
	bh=aS1+wesxMC3304+Y6xIr3I7pfuQIDNnZAXBMf1sELWQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XlxBYU1OWGcZOA44inGTxDDjyluSowtDBMIzBMorR8O8itlymu+NT6KPMdtmw4j+6F1HAp0gS1YsxsIxUczx2e4CrHWnQ0loe5q4gmSTFgZ2yyOJSwPd5UDJFApYVDiihO6u8H2SF9jdnU050kRbBuWGMiOZg+6ywAm3ibbbQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YImwUKoV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YImwUKoV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=w5kX5tNV5k9mZgn3zO6nEfb0LWgxJCKy7vnkIWzw2ws=;
	b=YImwUKoVG3BS8h/mpTr338TaDth5ltIFuTMzeLlgUw58DCZgYxZpbARSumRAlPookxEjjC
	YctSBmx+uJg/t5et1Vg7Rp9x2/0rJ8+84wvxMayG1Ftay3M6OqbAZjyWgunRCD4XWWrq7C
	JslgN7Mgmk3ZbxV3AMMjnfOI8CWwd7I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-fdQLSedOMiKO2bl8bYyBpw-1; Fri,
 01 Mar 2024 11:37:56 -0500
X-MC-Unique: fdQLSedOMiKO2bl8bYyBpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E3793830094;
	Fri,  1 Mar 2024 16:37:55 +0000 (UTC)
Received: from localhost (unknown [10.22.9.150])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A24D2015B7D;
	Fri,  1 Mar 2024 16:37:54 +0000 (UTC)
Date: Fri, 1 Mar 2024 13:37:53 -0300
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
Subject: [ANNOUNCE] 5.10.210-rt102
Message-ID: <ZeIEYRctrbzCHDZh@uudg.org>
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

I'm pleased to announce the 5.10.210-rt102 stable release.

This release is just an update to the new stable 5.10.210 version and no
RT-specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 2e4f63341da86cf080b22925a8f4f8cb746b8e25

Or to build 5.10.210-rt102 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.210.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.210-rt102.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

