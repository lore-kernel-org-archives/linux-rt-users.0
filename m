Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581FC483BC9
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787073894; cv=none; b=bC09imuOrY669yPVXd2vc4phBz1Ti6vYrVOHoG4Xa2ZBDWU25LlBHMKMk7vmCSqNrCUCvCJJoEW+H7C/G6Mn+vknVr+HlW3xlwMkdo49m59+YFXP5Y4A161tXLNP0EqneX8oAtOiExvjG6VRPG5wm33hVpu7rvYVqxuaFDH3yNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787073894; c=relaxed/simple;
	bh=qq5DMCrIou97fSr3u6kRJLZU4I25A0BtPr/uHMf9qIQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dm1Iiq3z/7TrUfjIYc//rTb2zun0Cbakfhpbrdz/8gYXToOaW4OD6xLbYyjfxT8HNZITVJEoY6WayUlMGszrKQZYUnftfDttsBvdeCiPQRCIHjZ79bIt8Dvbw5xk4ULDf4CsgsDC/Moc+vkcwDM3yN22NiAx/W8UnKx4R1QqzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YigMNYyd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YigMNYyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787073892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=OGo7Qhu2Z5FEFlwZWtgqiEJxvIqTn88a71uG5yBQ7gU=;
	b=YigMNYydNhccmqis8p9m3Sm1NXLND8vM/e2f3XMMMUWeKBQD8f28A68/LHrSrMQFv2niOQ
	RT+Y/pOvN/YmFCuutkRrksDM/Ebgx/BedyEdKDpKkQXDVr8PnDjPAIpPAF+gMmpqFbF/pm
	tI93DK49c1c5REYTRYrrWAoCIRazIts=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-9NOiuinUMZuV2s8zGaFZmQ-1; Tue,
 18 Aug 2026 13:24:48 -0400
X-MC-Unique: 9NOiuinUMZuV2s8zGaFZmQ-1
X-Mimecast-MFC-AGG-ID: 9NOiuinUMZuV2s8zGaFZmQ_1787073887
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90D7D1956041;
	Tue, 18 Aug 2026 17:24:46 +0000 (UTC)
Received: from localhost (unknown [10.22.80.9])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A0EA434;
	Tue, 18 Aug 2026 17:24:45 +0000 (UTC)
Date: Tue, 18 Aug 2026 14:24:44 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.264-rt160
Message-ID: <aoSVXJFh5Qcjxq0P@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hello RT-list!

I'm pleased to announce the 5.10.264-rt160 stable release.

This release is just an update to the new stable 5.10.264 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 95a6fb37fa80dbcdb75586d996f153d242460351

Or to build 5.10.264-rt160 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.264.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.264-rt160.patch.xz

This release has been submitted to KernelCI as v5.10.264-rt160-rc1:

  https://dashboard.kernelci.org/tree/stable-rt/v5.10-rt-next/v5.10.264-rt160-rc1

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

