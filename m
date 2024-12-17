Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84261FA158
	for <linux-rt-users@vger.kernel.org>; Tue, 17 Dec 2024 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476893; cv=none; b=Y+HpohRBRunFoa0c2O+aCz1HcMVTSH8Z8yLGd7X+KyBYOcUMzPd6SYvNrcM9BaZ+Jjh5h7ARvZ4+y5kPb0UVG41PsMu2ElK85qE1sJ6W8dYUSDryeTmvkRAO/NY11KSqa3+WtiB9nmEZqryy31ACjR8JmwXCIaBAaYdNNoGBv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476893; c=relaxed/simple;
	bh=Q+PfKU23sKIq6E3iPys14d3vTNR8xp9ewlWy2vem6fs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G1EjhrftDB8834kFQBXkggShrPWNK4X0KPGX43Wy5CoSVZ5JT/nSZXs7q50Fra4yQUC/Uo/c6mk4LQQtRW4FRKFEQuSTpbueDCi1wQ5UPKPT3V5/h2FTSi3lt+cA5q8ddNpSZrlbtEnMo7tARs3dF9exWfs+m9s5E1ys+mAx1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOpU/Raj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOpU/Raj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734476890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=YF1Vr7mO0xryeYQAOtEkhYalKlih/mse5aMf7DZQalc=;
	b=gOpU/RajNl/rcpzEBdrnXg6RxsfZnae5BRagtSW0n66fBPtNFh4NAhgIik5OLiId4E0BUd
	LsgxhCvQctYWFOu9RHG3zMhJmiv+j1YnJLP8GQ6DhHAWXfpsFcw3ymLGJ98yeJuUR8qQa3
	xrRnspK1aYnEPQW1P+DLa9NABR6cifI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-wcnwE_STP1a_k--huHxV5A-1; Tue,
 17 Dec 2024 18:08:07 -0500
X-MC-Unique: wcnwE_STP1a_k--huHxV5A-1
X-Mimecast-MFC-AGG-ID: wcnwE_STP1a_k--huHxV5A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FF0419560AB;
	Tue, 17 Dec 2024 23:08:05 +0000 (UTC)
Received: from localhost (unknown [10.22.88.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAA721955F41;
	Tue, 17 Dec 2024 23:08:03 +0000 (UTC)
Date: Tue, 17 Dec 2024 20:08:02 -0300
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
Subject: [ANNOUNCE] 5.10.231-rt123
Message-ID: <Z2IEUkxl9jEgBVyh@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hello RT-list!

I'm pleased to announce the 5.10.231-rt123 stable release.

This release is just an update to the new stable 5.10.231 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: d22f070041ab4370938ab8b420d81ef987e84128

Or to build 5.10.231-rt123 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.231.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.231-rt123.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

