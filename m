Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3191FE47B
	for <linux-rt-users@vger.kernel.org>; Mon,  1 Jun 2026 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780354953; cv=none; b=aUmCyUZP0yMiKxyQK1RJ/xrxlnqrnOLS/yOUIXWrFiHE9mA40aROFHXwWt93A+Yhl5YcKlF7GziwsTQx8UoFlL4lLZnSjdM+UbEZda7MfrOIAmZPXwFtupP4kpzICCTMAU3X9JZuOCrSFno6//xg/FlwSggfTtDRCTx6eK1NagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780354953; c=relaxed/simple;
	bh=wUij9BOHg49xvOfgnzGjdPT1SWp9kKja2JDb9p/LaAA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m8HLSTNRdMll2Aqa9ru/vGdICV73ZzYr7b2xA96BAYsd/82fyGJ+XPD0ANklZdHebCufptmqWbTTGlmxWj8+Z0sHEAP3aeV2o1UsRfcIUl6ImMa5jW7z5mcfuAff/8EOlggxFIfK9b5F7DTALwMyDYzGtG5lyHi11G5p7YuJyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9eDFnmB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9eDFnmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780354951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=M/Y5i4XX78RgoZcJwlhfeQkJGF88G3gkjKGKYvOcJoo=;
	b=H9eDFnmBOB1fptigTJEh7Gg6bOf/eLNmmfgGn4hQkIg6WQW2gzzQkJ6qfaS2eX5oWlqXU9
	lPmAAQw1ChfWdBc78ARpZET+1FexM9X/ATm0+9bZxNC73p11M0uasreT/ZqO+bUj2b5HZf
	GD9oDzJm8kia2RapPld3hjf/g1LlB5A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-thxnCtUqP1a_64CaB4BIEw-1; Mon,
 01 Jun 2026 19:02:17 -0400
X-MC-Unique: thxnCtUqP1a_64CaB4BIEw-1
X-Mimecast-MFC-AGG-ID: thxnCtUqP1a_64CaB4BIEw_1780354929
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6416195608A;
	Mon,  1 Jun 2026 23:02:08 +0000 (UTC)
Received: from localhost (unknown [10.22.88.210])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15B2230002E6;
	Mon,  1 Jun 2026 23:02:07 +0000 (UTC)
Date: Mon, 1 Jun 2026 20:02:06 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.257-rt153
Message-ID: <ah4Pbhk4sLKpPodS@redhat.com>
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

I'm pleased to announce the 5.10.257-rt153 stable release.

This release is just an update to the new stable 5.10.257 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 5399a67d7d071c8c17ec7e6521f0579fb06538f7

Or to build 5.10.257-rt153 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.257.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.257-rt153.patch.xz

This release has been tested by KernelCI as v5.10.257-rt153-rc1 here:

  https://dashboard.kernelci.org/tree/stable-rt/v5.10-rt-next/d7e10365c32e1b5bb3d62bc9f41a651b10387160?p=t

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

