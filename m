Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D571AD3F6;
	Mon, 10 Feb 2025 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170612; cv=none; b=gRMaQjaKphb+h0wftbH5u37V1uG6f2TUAsX0ef6skZSptIn4SOL4HtIJ1gjfAL3HZwJROsR/nM2YmIK/t2RZpz/fSVPgyyt4im1Kk3HItnI/sexrj1fmVLRQhh8nz0qgn5VhTA78R8P59mqNDmiZb5PSFhgzJE8BvuXMmvXZUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170612; c=relaxed/simple;
	bh=AmyIkv3DbnfgADTlpj58Tj6YoTuPHzz5Iun7nYljy4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fkU7WjYHO7fKKui77Xizgpp9vurnfuV7VI+jUYHGuzMVQQYDsQtYTjBS75/KZTvOkChUmUZu+mtqVA68+YZf6q39odX0dJDL7x8g4RWoqqNCKYkTgSuz4EbF1FRUBjYFy56D51iW6a1Id/kMbMP92YlQ1YNfG4Q6dvwLlDPpa+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=TVzKufVx; arc=none smtp.client-ip=210.130.202.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="TVzKufVx"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170570;x=1740380170;bh=AmyIk
	v3DbnfgADTlpj58Tj6YoTuPHzz5Iun7nYljy4s=;b=TVzKufVxTtWXFrq1Pn3E2sGu5Whj7fODdMv
	w9nlOPRLscz6hDXNDpI0aJzamzuu43loo8rH1Y93bA/xHQb/UcWci9DLyY7UXMRd+1vN5mJ1bOuuG
	Qdj2Av+uO+M63QXCx3zwl1YeM+ip/f2EI163ZwIxIENlhlY2UVcppTcRRe3Eem0DeS29ZVQ57iq3K
	x6Q+olH1Eodj23NSoDgDyiGWXRg47mwgBmZ6aC1RWLyEcCZYchU/rDHlxwva1jqZvJqHl38RuikWX
	yeaMhQH9hQBQmJHN9nXeX1ELW7DGghEOljqhXUzZKPZ/XYHk1/Qy8Bu4/pEyqlS7Z/ET4I3blRCg=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 51A6uAQ3789407; Mon, 10 Feb 2025 15:56:10 +0900
X-Iguazu-Qid: 2yAbuzQy0kRcL2Dr8m
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbuzQy0kRcL2Dr8m; m=PWtZJNLikNyw9D52ik4dbAaTKCdwJGjcTITQQVEshYE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 51A6u73m1015855
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 07/17] ACPI: Adjust system_state check
Date: Mon, 10 Feb 2025 15:55:35 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-8-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit 9762b33dc31c67e34b36ba4e787e64084b3136ff upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Make the decision whether a pci root is hotplugged depend on SYSTEM_RUNNING
instead of !SYSTEM_BOOTING. It makes no sense to cover states greater than
SYSTEM_RUNNING as there are not hotplug events on reboot and poweroff.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Link: http://lkml.kernel.org/r/20170516184735.446455652@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4031ec8024ce..5c5ae92710eb 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -526,7 +526,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	struct acpi_pci_root *root;
 	acpi_handle handle = device->handle;
 	int no_aspm = 0;
-	bool hotadd = system_state != SYSTEM_BOOTING;
+	bool hotadd = system_state == SYSTEM_RUNNING;
 
 	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
 	if (!root)
-- 
2.30.2


