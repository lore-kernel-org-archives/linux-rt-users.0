Received: from mo-csw.securemx.jp (mo-csw1801.securemx.jp [210.130.202.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833171ADC67;
	Mon, 10 Feb 2025 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170611; cv=none; b=G0NzgysGnH/Kd6IVN4LMfZeoFXMxcTC9Ge5mVB651TvAckscVRQleM6vDldX1isd88YNiDmfZPz6S8Rge2OqtyNB0gfdJUnN9JrveeST42q3xaPooMwkvkYeQiV6eHyssOL1zWrk3uTN57xKPYGR/sjLgWfOd1tYwTdrbL1Sjt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170611; c=relaxed/simple;
	bh=4emG1fYMu+rWyyvKetgiXXHgCkawl0N1QUtTZSf9NIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BjcdKxJV04HmmUufMkt9DWOxrNw3mOWctGMb4c5IkTs2teltdZRAm8duX5t1d7nsxN9VP0gY8w9T2rmS/h5KNybGtvFwzNbwjjPCe646nXqCyDrc+ztUXv3tMrc7IHrnt/plym3jdMgzRQnciwnr7obMZCWG2TU9U9YsGX48vyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b=ddi2hDLy; arc=none smtp.client-ip=210.130.202.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=kazuhiro3.hayashi@toshiba.co.jp header.b="ddi2hDLy"
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id:In-Reply-To:References;i=
	kazuhiro3.hayashi@toshiba.co.jp;s=key2.smx;t=1739170571;x=1740380171;bh=4emG1
	fYMu+rWyyvKetgiXXHgCkawl0N1QUtTZSf9NIM=;b=ddi2hDLyj7AZI8SvUvj+zhVTU+wGxcZxNqA
	gt2GWybQDfOS1REWTI55qw0cbYacbXa8Hwkuv0GHM/Gou0GyScHtanpoq0OuMPJ0gVhoXi1gVSBAm
	LiIFleRfrA2F+ELG7adrJQ9ngWQ9Yzx/6hP6r9FrSHDCFcrZBvrmHUJDxbKzuX8YmwhWtx7hUz73K
	n6M9liIc6u6qUoIEMbkTulMwiUoojAdLHVVLE3D9bU7YqVKabGiF5JzStCeLMzciriiGsiBnNmnFI
	gpePV8kWlgbDHilNn1RBRjdz6GTCeUUoHhyjLDfMlFpNxe9Bg49JNU/B9FwFdqf6dft0IJvZ1rMg=
	=;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 51A6uBK33258823; Mon, 10 Feb 2025 15:56:11 +0900
X-Iguazu-Qid: 2yAbaKzOfppz6rTlSO
X-Iguazu-QSIG: v=2; s=0; t=1739170568; q=2yAbaKzOfppz6rTlSO; m=boQJg9V3t8HvCwF8iFZ2EZNiBnK1BmEFkLAJHF9T+PQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 51A6u7401015860
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 15:56:07 +0900
From: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        cip-dev@lists.cip-project.org
Cc: bigeasy@linutronix.de, tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, pavel@denx.de
Subject: [PATCH 4.4 v1 12/17] extable: Adjust system_state checks
Date: Mon, 10 Feb 2025 15:55:40 +0900
X-TSB-HOP2: ON
Message-Id: <1739170545-25011-13-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
References: <1739170545-25011-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

commit 0594729c24d846889408a07057b5cc9e8d931419 upstream.

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state check in core_kernel_text() to handle the extra
states, i.e. to cover init text up to the point where the system switches
to state RUNNING.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170516184735.949992741@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
---
 kernel/extable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/extable.c b/kernel/extable.c
index 4f06fc34313f..83f9955735d9 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -72,7 +72,7 @@ int notrace core_kernel_text(unsigned long addr)
 	    addr < (unsigned long)_etext)
 		return 1;
 
-	if (system_state == SYSTEM_BOOTING &&
+	if (system_state < SYSTEM_RUNNING &&
 	    init_kernel_text(addr))
 		return 1;
 	return 0;
-- 
2.30.2


