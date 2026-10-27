Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127510;
	b=wZWlMTJTZrPDLBVotsYfkRXdLNbjtFeoEAim6fEqyrOPfveyB00368ZhsXCGvD7JgqRt
	 88lIxHp1ILwW24qfuvL6e/BGt22iJKnqXjQ7r8JU2h0Ic/w2BHXziOZEt1oyu9eb8liN1
	 JnoY+0jY+net4nMKp4dsVsy5Xb4p7bKsh7SLE5EUqVsQXxpSDePh1Z5YN7brTffTWe/wN
	 aGIQoROF9tdZBqZppld3pz7EnyVjz3I4tqE5g0BDPOU/lCRoJpQeEkXxd7U0wOUZjifqc
	 jKnMJjM9VeoClvDUqGDRsuXkkP9ovV1IabQ7aC70Zu/dJ61uGmpmOtsMh/SXx7CjLTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127510;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Scanned-By;
	bh=JThLiNjGPgBcHpi9LsSr4xDdGpVZCgcVP8gr6/Kzs6c=;
	b=a0J7Mr5RTupTmd1/drdamY0yTtQF5LADL20OZGtvFo4s1od38xbVsGMji/x9vizZEd1n
	 KVpRoHzRTQDaLZs7uU7jilpO1ZMeBluOGj8sZBAqUCc2v5OgpjV0AfVqMoI/nXZFcZxod
	 vSP1WZwNWDCjWF6qZPUfsT5twCyp5xF1/SKEoGA0xE4A5P41kgOw2qyexsP3ZWq+fAHSe
	 EZguYTKmnilGTmTynCPHMPiBgYj3C9YR+Hw/iK30GbxIQ840h6G3WopwUx8KWrwt7DUyw
	 mmpKvYfxSfcAq2Doy9AYWeyqzCRGErResHwB6ui+8/bLII6Ewc7StCBeMt4qBl4y3ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=istekYQe;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B98606A326
	for <linux-rt-users@vger.kernel.org>; Tue, 27 Oct 2026 18:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B98606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=istekYQe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793127509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=JThLiNjGPgBcHpi9LsSr4xDdGpVZCgcVP8gr6/Kzs6c=;
	b=istekYQeDKb268NsJB9cWz0m84HMaCUQgKLkRt0TS7vczpqn37YGRJr1fI2XtAob1lavQ+
	XbfwScD1O4jyv4EA8CW/wuOHnZHr8BcJioybmImmwipfD9hgaxcFJVTmIQFEkMszoD1GT8
	trgod6HHSrUfiA7TEO4IK8IAUTbaSC0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-400PbuDJP5yk0JAb_H_DoA-1; Tue,
 27 Oct 2026 14:58:23 -0400
X-MC-Unique: 400PbuDJP5yk0JAb_H_DoA-1
X-Mimecast-MFC-AGG-ID: 400PbuDJP5yk0JAb_H_DoA_1793127501
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A3371954238;
	Tue, 27 Oct 2026 18:58:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58E421956049;
	Tue, 27 Oct 2026 18:58:19 +0000 (UTC)
Date: Tue, 27 Oct 2026 15:58:18 -0300
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
Subject: [ANNOUNCE] 5.10.272-rt168
Message-ID: <179312713996.233155.17570690892326419739@lgoncalv-thinkpadp50.rmtbr.csb>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello RT-list!

I'm pleased to announce the 5.10.272-rt168 stable release.

This release is just an update to the new stable 5.10.272 version and
no RT-specific changes have been performed.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: eda0354ec577de6b8b4b2080c740a51b720cc826

Or to build 5.10.272-rt168 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.272.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.272-rt168.patch.xz

This release has been tested under KernelCI as:

  https://dashboard.kernelci.org/tree/stable-rt/v5.10-rt-next/v5.10.272-rt168-rc1

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

