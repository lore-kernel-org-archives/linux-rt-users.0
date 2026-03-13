Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DE386C25
	for <linux-rt-users@vger.kernel.org>; Fri, 13 Mar 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405799; cv=none; b=rr/1sEp0fBpvor+GnShkR7uqLwN8zIWCzQIQy+ZmyS7yc4Buecz2FE9N4nGebTYdlbJ12CNzlGsTbLyJUA2Z07+OpwS3oPCAVRXZXm43Ou/nlTg7BcTHIPZnJwQkrRfxRdNaeMNgnpxe4VeDX+cfL8EgTYMyf5B8lcucqK0+Pbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405799; c=relaxed/simple;
	bh=IAQVsjRO+RiyVdOGzAgknPKVjr+thCr9G047Mes93L4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MJnOQIPEGGlSdZreb45F81G+6JSa0hnFqhzTnqXlykwMoy++4Hk6ZpZLUI/5APvRkLUkKz3deNG4m7hcunLWTDLxto1wimIQEa00t5yVLjYCy1KavLJp4KJdXHq93IHE0GHi/NV/QAgkdp3db364039eL/5sor3TulXiEc8P3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bd+MczY5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd+MczY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773405796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=eLQPcCMEQRDhWYvkCK1EJtY/q+F0Q0CVhqrNaQoj2io=;
	b=bd+MczY51KWoKu4E8Idh6KSaA3pTJYluGIAdQcwVuA2LcNlojIFo+r0FsO+ByzmjR/tKZv
	8hUUHuAtL3Fmdp70pVRL0xU2Casy3IQbvACpOsZFh6Z46RlTQMusEaG3UGMbbLFdYs6HmC
	tGW6DlcI3a8tuYHI5nIpUlfWpeZLsyk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-1DD4jDjAMF-1iYCjr3dKSw-1; Fri,
 13 Mar 2026 08:43:13 -0400
X-MC-Unique: 1DD4jDjAMF-1iYCjr3dKSw-1
X-Mimecast-MFC-AGG-ID: 1DD4jDjAMF-1iYCjr3dKSw_1773405791
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AA051977694;
	Fri, 13 Mar 2026 12:43:11 +0000 (UTC)
Received: from localhost (unknown [10.22.80.108])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80B5F180075F;
	Fri, 13 Mar 2026 12:43:10 +0000 (UTC)
Date: Fri, 13 Mar 2026 09:43:09 -0300
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
Subject: [ANNOUNCE] 5.10.252-rt147
Message-ID: <abQGXfngmgtUwgUI@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello RT-list!

I'm pleased to announce the 5.10.252-rt147 stable release.

This release is just an update to the new stable 5.10.252 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 55969871939e781871ca912e3dccb39d8ca6b977

Or to build 5.10.252-rt147 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.252.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.252-rt147.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

