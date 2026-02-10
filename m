Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EC3EBF1A
	for <linux-rt-users@vger.kernel.org>; Tue, 10 Feb 2026 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770687075; cv=none; b=H1Di89Im4zvZ3+nuAdAVQfWqP92lg8xcC5oBQVIFzgnBhsRezMYUaJSdFhLpvN/jxArNFVIAz8qQAG1TIX6qHY/FHUGzpYCJjIwqsOA3SQQ4X48HQaruhm9QV++vb8+IwR/rR7d1RDModtiEHmt887FJxVpPhJjY+JMVLzY4mDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770687075; c=relaxed/simple;
	bh=g1K+B0QjqL5uD4nNBn0Ys0TYRWSJDMrxfRDfPa9Di60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fzwmdlGvpIyX2ltI+jLZxG9tL7UzjqjrrMt8hRXZoyJr6hQHXQu56OFZC0WKVqDHkc2AiFpxowbDil5X9NOw/06Lwx+He8kHxCN7Ks2WfS6vEI0R7XxqtBM9T1bJqwEZjwHbv9J9QuM4I6mLkZAcZQY+qEiC8TlowVO3uWvi1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RA1eP3Kg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA1eP3Kg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770687072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1r5aiodQNDdQTJS7bFvtFUu8dl2GbVRopvx9ZxJXmE4=;
	b=RA1eP3KgjA6U+hBP+y/qN2uTbeG8dr5O5+oG0RB3MvTrQ6z7wa3dl8RNeyhod7YwUM2Mes
	e+UKnlPfJI6+9BilGhdy1ulllHvLCGBOWWe2SCRDUoZ0VzXtbM3QRb/QWm4NKuHL7B8P44
	5wgjhVAHzSmrlCTDwXrAC/ihiCi8YtE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-pMt1yusMP6SCnl8eCKYtmw-1; Mon,
 09 Feb 2026 20:31:09 -0500
X-MC-Unique: pMt1yusMP6SCnl8eCKYtmw-1
X-Mimecast-MFC-AGG-ID: pMt1yusMP6SCnl8eCKYtmw_1770687068
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EF3218003F5;
	Tue, 10 Feb 2026 01:31:07 +0000 (UTC)
Received: from localhost (unknown [10.22.64.105])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B82B330001A5;
	Tue, 10 Feb 2026 01:31:05 +0000 (UTC)
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [PATCH RT 0/2] Linux v5.10.248-rt143-rc1
Date: Mon,  9 Feb 2026 22:31:01 -0300
Message-ID: <20260210013103.73763-1-lgoncalv@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Dear RT Folks,

This is the RT stable review cycle of patch 5.10.248-rt143-rc1.

This is just kernel 5.10.248-rt142 with an extra patch suggested by
Ben Hutchings to fix a build problem introduced in 5.10.247-rt141.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release is also available on kernel.org

  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

on the v5.10-rt-next branch.

If all goes well, this patch will be converted to the next main
release on 2026-02-16.

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.248-rt142:


Chen Ni (1):
  net/sched: act_ife: convert comma to semicolon

Luis Claudio R. Goncalves (1):
  Linux 5.10.248-rt143-rc1

 localversion-rt     | 2 +-
 net/sched/act_ife.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.53.0

