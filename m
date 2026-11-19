Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046743;
	b=jZrro/4c13MpwUcQq1eXQzPKrqQPop9DRWJfeYKVFuKQmK4C6fuhuL0ZmXmBWazU2h0K
	 juqPR7/YKgRjBarJTTzuyLLGnEF2iH6VCRN0ofaHbcGj8HFYXKdnXEcC2z+yMwzXj1ORe
	 4Rv/UYQHEVu4usgA3b/HtONIcxdfbuS2MI4Z7KfReFxvdr0OZopmPRh5VWk7BrOUcyIZr
	 i7Htflmo+7PB1AcLnldgXwx85BQT85CUDO0eV4ALwBus5xUR5LFfR9KYtUlTb8hnu+hHw
	 I+tKyGaKEIt9q3gMPbfmt+/VB11tHPo55yAXevOL5497YcNE6PAf8PGyoxROSvefuEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046743;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Scanned-By;
	bh=3ZLR5Xm0QEt+rShTQLBvnsAfT6oRZ1fJCpUNYLZ7EAQ=;
	b=AsWzbos/GE3RGgZotai+mVoCCoDoO/DsMJFktYLyf0VhhE0nnGMHE9YEe5D22dv8813h
	 T3RSYqhdGPD4wVEqJlKYPQ8jGkdej1Ve5Zz/3q83gOtVLSO6z8TlIXZ6/rOnueflyapZF
	 6NiFxbmD/NxG4WqbdnJ5rn3MuEFfSa5qbjYCbLPWpvwFC6ZsP45xJFegIheN3nmz/4OhV
	 zwh8G/0xT3UDBZ0gd2pDewVPBBu3DBfLf0qR+FSD1LDt/Ypmn4rIlq0aDu+xSixX2CqMB
	 q8XO4q9Goxdq05hZWVLdTXVAt+hv65P7g27Xx3WDlTyH+JrlKfoI/dLv7DzTf55pVMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CJuJ4zE9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D1606A32F
	for <linux-rt-users@vger.kernel.org>; Thu, 19 Nov 2026 00:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 218D1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CJuJ4zE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795046742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=3ZLR5Xm0QEt+rShTQLBvnsAfT6oRZ1fJCpUNYLZ7EAQ=;
	b=CJuJ4zE98M3Nlv1dLKImW3PId8Mos4J1tnsNPWBYTuIRil9SZrm3cdNrDi1GrD1dhrgYtE
	nHVYtgiccs2/iKgMtvSRUPVCst92NAi1yA5YrrGVuoaaEDH0bfp9YDKjVHaogMvMJspD9s
	CE7ZjeeP4f2rdgfQc1HGp9ZdeTCIDbg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-ZUVCGgeAPZewB0HbaIFCtQ-1; Wed,
 18 Nov 2026 19:05:38 -0500
X-MC-Unique: ZUVCGgeAPZewB0HbaIFCtQ-1
X-Mimecast-MFC-AGG-ID: ZUVCGgeAPZewB0HbaIFCtQ_1795046736
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4E531955F7A;
	Thu, 19 Nov 2026 00:05:35 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFF6441F;
	Thu, 19 Nov 2026 00:05:34 +0000 (UTC)
Date: Wed, 18 Nov 2026 21:05:33 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Joseph Salisbury <jsalisbury@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>, Pavel Machek <pavel@denx.de>,
	Joseph Salisbury <josephtsalisbury@gmail.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.15.225-rt107
Message-ID: <av49TSuHbtteaepq@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hello RT-list!

I'm pleased to announce the 5.15.225-rt107 stable release.

This release is just an update to the new stable 5.15.225 version and
no RT-specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: f3d59c0fe6c62c4f6cfe7ab67318dcbcae56af18

Or to build 5.15.225-rt107 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.225.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/older/patch-5.15.225-rt107.patch.xz

This release has been tested under KernelCI as:

  https://dashboard.kernelci.org/tree/stable-rt/v5.15-rt-next/v5.15.225-rt107-rc1

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

