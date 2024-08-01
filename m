Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D480013C914
	for <linux-rt-users@vger.kernel.org>; Thu,  1 Aug 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531850; cv=none; b=MnWe5OZerhKPE2rboE0Rr7tdGZ4w/PfxdU/SRF4KMomRutP5lihJRou3ccx1K1f2QH9lGrlP0kvmTCnN9082gEhPlyxzFe/jGlsMlvy7Q7L/9ZmmevmgMzfX/rjQRmC7krAQQMhg8kci3oNVeDKtDtvOyuFeMZcAQhTYxI4AnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531850; c=relaxed/simple;
	bh=MLmprcZyVDLDR7X34VpLPzVJs3GttAZM4v7jyvirOiU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gCOIsAhiWKUX9BoKHOvw4Pn5mWdT74jrpanUtq20DJtVaqFh66vA56QVIoy2o4ULjqIXK1zjLL9BTy3rcJ6U0JE08/FjPUoKcDNhc6UzwXIgMJxX384RI6RhB+WOMyBBd1rbnj9TsKUD+IQ9wUo2xjr74su4uH3xDUU/QAfPtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGQFD6PH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGQFD6PH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722531847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=BVu+TyGnqswgeJMSXlcBDfSQmVXi12Uf1VERdb2hIew=;
	b=FGQFD6PHHOp5nAaP/IM2H79/N4W5bOX6JtHBOa5v0tHbOoIclB6tosmQJ05NsJpK965vVE
	FY9ox33Xel9bjR2F0LCFKDF6aXCwVK3NPNy58mAlkm3mz/MVIetk2RIQ44F3eilWqGdAvH
	sk/v7hpfbL5TklYtNz2O6JfaPz7tNsY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-iAqqGs6HMZ2yBwFccAKtIQ-1; Thu,
 01 Aug 2024 13:04:04 -0400
X-MC-Unique: iAqqGs6HMZ2yBwFccAKtIQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB51019560A2;
	Thu,  1 Aug 2024 17:04:01 +0000 (UTC)
Received: from localhost (unknown [10.22.34.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1377719560AE;
	Thu,  1 Aug 2024 17:03:59 +0000 (UTC)
Date: Thu, 1 Aug 2024 14:03:58 -0300
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
Subject: [ANNOUNCE] 5.10.222-rt114
Message-ID: <Zqu__oYh42j4dY0M@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello RT-list!

I'm pleased to announce the 5.10.222-rt114 stable release.

This release is just an update to the new stable 5.10.222 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 22b07fa4133af0ef5ed5661e0534afabf9abc535

Or to build 5.10.222-rt114 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.222.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.222-rt114.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

