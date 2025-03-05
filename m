Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965021883F
	for <linux-rt-users@vger.kernel.org>; Wed,  5 Mar 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171811; cv=none; b=qrFf4IdCglTPTHrrsl1lMiD7AvJjZSP0AjGtUAB8feNx1nGC4HdIGsl+YxrWN/JkconVYcSdL0Z7SbYrLTOEkgRzuGUnH9MsaKdYMMeZyHxIxmPmTk4ZB4TEspT0xzOW3+m728maxCaHNN4WzZCusPHrOmOCgz+eoaerW0nNF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171811; c=relaxed/simple;
	bh=PGBWl9yPog/7ujlW8n28qzNSWC2BA+nZV3uoFclQnYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AhjABxevnqNOQn39pkFaCXaFjOT6ZrGOdnBmw70mRl+HZGEYqe9gGs7lsYhn4Cu962kdiS+rycbwmvnX7LGABd4Pm4lXKbcDfIFgvbHceJwHIjUJZWjWdqtYUUdSvLhBCQLu8mMJsY5CL3Cwq/4cUEMmkPuXO4lCRtX0BsZCLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PAWpI523; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAWpI523"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741171808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oyuuH1Wtyfod3sQmeqjOasemMV+03bK4/IyWGgNrZfQ=;
	b=PAWpI523ikOpqESy1MKnatVlRsf7jETQ4a3xuknoEonMYzqRjbbMfgWE3sVnIaAvptp08L
	/bo94Vcgznp7khYPWwUemjPIAcfOYva1nDWtICdnnn/SbcmrDHRaCyvogM87om98rAAhbS
	hMuGz6cIRXYOzmkFDUcYYyLXMcBJdHE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-z4bOYVHsNB2mtiR9Wm03Uw-1; Wed,
 05 Mar 2025 05:49:58 -0500
X-MC-Unique: z4bOYVHsNB2mtiR9Wm03Uw-1
X-Mimecast-MFC-AGG-ID: z4bOYVHsNB2mtiR9Wm03Uw_1741171796
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57A8D1955DCD;
	Wed,  5 Mar 2025 10:49:55 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.44.32.95])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAE451954B32;
	Wed,  5 Mar 2025 10:49:48 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Galbraith <efault@gmx.de>,
	Peter Collingbourne <pcc@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Phil Auld <pauld@redhat.com>
Subject: [PATCH 0/1] arm64: enable PREEMPT_LAZY
Date: Wed,  5 Mar 2025 11:49:24 +0100
Message-ID: <20250305104925.189198-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hey folks,

This is a resubmission of Mark's patch [1]. I didn't end up changing anything
other than fluffing up the changelog.

I ran this under an arm64 VM, added some trace_printk's and checked that
sched_switch's between runnable hackbench threads would occurr in the right
conditions:
o with TIF_NEED_RESCHED_LAZY set
  o at the tick
  o at do_notify_resume()
o with TIF_NEED_RESCHED set  

[1]: https://lore.kernel.org/linux-rt-users/Z2B5y3HiLuRHPfdv@J2N7QTR9R3.cambridge.arm.com/

Cheers,
Valentin

Mark Rutland (1):
  arm64: enable PREEMPT_LAZY

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h | 16 +++++++++-------
 arch/arm64/kernel/entry-common.c     |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

--
2.43.0

