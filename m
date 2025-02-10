Received: from mo-csw.securemx.jp (mo-csw1122.securemx.jp [210.130.202.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B31ADC84;
	Mon, 10 Feb 2025 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170613; cv=none; b=hg0IIHw9Z3wrDbW95VDYXoSvlMtNGI2Vmiwl0bhhTZ9FVQnVjBpEmwifGWBTesB0Y6mwXMcnMPcp59ykxbBxPZh2a5GO4tlKm7r0QJlOnQVa+TM/XLUSkNn9XbKhiL7H1qGpRTzuWvfPhXGtzo3exMjSjg0t4bRRAvS/U21VNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170613; c=relaxed/simple;
	bh=5MfGl6e6Blv62gnNYU5ipLCi4CnP2QBHtpDPl+oXTF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m/8y/LsjUDZ38NG+xhM/nieeyf7P/0wFKc5neetWX2580MRsgk21j7AMkMlWn6pdjcDIlDtoOnxe/+QBh07nsSyh+KGf0If6gTxDvjk6flgFe5nZyLZZqcLR/YS9/07EhWE+ntxOSyHFpx2UbtGCNliZwSJjqGMWSvGCqhLnXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=DYQuxs3E; arc=none smtp.client-ip=210.130.202.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="DYQuxs3E"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170574;x=1740380174;bh=5MfGl
	6e6Blv62gnNYU5ipLCi4CnP2QBHtpDPl+oXTF0=;b=DYQuxs3EEqvXXJ/ztGbr1tuSO9A80FHA+BY
	lDh9ciSj1K38wUG97jMcXu+ZqH5/jZbF5bXYq3xG+wyXKvtYzZ7gUzhaNzAFgz/HlKfIqEzNqizm6
	6Dd2IPfLizDJxlsI5NGOMCVDrRM4O9LDiZSVuUkzUFrSiVrougRR2KcGMseqy3HvnzuX34Vg9zK/A
	5xrDQkScj5/tPKW0ryMapv+PxM6HBclO7ZNS7WjD05HnxEZtuWpvG4F8p25gJd9zz2+IRZhfILpAk
	m2a4UWjc5PLpuxULKn8SnW4PXnK1r7Ynd5W7UYvqr0C7elEu2A6i46wIkkGSx9RJmua8VV3sDIYg=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 51A6uEr3605391; Mon, 10 Feb 2025 15:56:14 +0900
X-Iguazu-Qid: 2rWhg4sy0fhlZpldaO
X-Iguazu-QSIG: v=2; s=0; t=1739170569; q=2rWhg4sy0fhlZpldaO; m=za6T2eJrO3RRQIGN4B5VThZHvkjZ0EevlFFIbYCfizE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 51A6u7Gw182853
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:08 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 10/17] iommu/vt-d: Adjust system_state checks
Date: Mon, 10 Feb 2025 15:55:38 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-11-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit b608fe356fe8328665445a26ec75dfac918c8c5d upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state checks in dmar_parse_one_atsr() and
dmar_iommu_notify_scope_dev() to handle the extra states.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: iommu@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20170516184735.712365947@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ed6cb3abf645..a8a221b9a3b5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4182,7 +4182,7 @@ int dmar_parse_one_atsr(struct acpi_dmar_header *hdr, void *arg)
 	struct acpi_dmar_atsr *atsr;
 	struct dmar_atsr_unit *atsru;
 
-	if (system_state != SYSTEM_BOOTING && !intel_iommu_enabled)
+	if (system_state >= SYSTEM_RUNNING && !intel_iommu_enabled)
 		return 0;
 
 	atsr = container_of(hdr, struct acpi_dmar_atsr, header);
@@ -4431,7 +4431,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 	struct acpi_dmar_atsr *atsr;
 	struct acpi_dmar_reserved_memory *rmrr;
 
-	if (!intel_iommu_enabled && system_state != SYSTEM_BOOTING)
+	if (!intel_iommu_enabled && system_state >= SYSTEM_RUNNING)
 		return 0;
 
 	list_for_each_entry(rmrru, &dmar_rmrr_units, list) {
-- 
2.30.2


