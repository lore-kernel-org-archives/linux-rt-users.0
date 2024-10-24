Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED591F80B9
	for <linux-rt-users@vger.kernel.org>; Thu, 24 Oct 2024 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787214; cv=none; b=ORqQvaeo20fbFWoK8fk+tgIkDz/tLXMMJ9wO0b1EX1QG477fh+bwQGOW9eOZM18v+UiM8+QvtKczi8Px7HI5tS9mpaZSk5IvmM1yxcdtRwSRdP+bEW/nhc0NWz1eSTczTEunQvGZzCu3oKxB66StPFFB7otjRmbNB/x2ot9wTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787214; c=relaxed/simple;
	bh=Y8SzieWLcPol7nGkZ8uosTyOFuxZ9D+lZk216VEizXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eu8kfGSkgRkhvRqMz/NjuuPozJUCIc/cVcr8+u6rwDHYwqLTq7ARXBo+zZ+0/HweyFFJA6aeZLnOBnOYWqI07hOOy0MhjXqmHsp2w890BRmMJtpQGiItzrnFM59DtjrAVsbkSmOJl0pDDw4DWj4vhjt45RGDxvagET0+v6mp0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HC+dUP8J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HC+dUP8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729787211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/HckdK46781C1fVkL4dcqEDbIGW513V8OIdqoTdi0M8=;
	b=HC+dUP8JaydZsyIzXrtAvFa4OR/Zw9doN7fjTwA83ssyTrceQzqGx3aCG9A7mgA/st2YY0
	fz6hotHCeZ5RfevwZII2lAzIFGOJqzRuK6/zqnX6PhGw3vD0OEs7y1jlE2NciHgAf9yfNN
	XQ0TYVQ02Or7UdsiFM8iI12vCgqKi0Q=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-TqcGpxZkPRy5JC0db966Cg-1; Thu, 24 Oct 2024 12:26:49 -0400
X-MC-Unique: TqcGpxZkPRy5JC0db966Cg-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7180a4bf542so1120947a34.1
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Oct 2024 09:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787206; x=1730392006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HckdK46781C1fVkL4dcqEDbIGW513V8OIdqoTdi0M8=;
        b=cD1uM78ZWJTGbK+UCmrkl92eVogd36GyLQ+V5UtjJFEc3w1cCyfuifmtId8QiODzSs
         Cm8lfZFGgOZZOOyDztk8fFZIAI3pepW9XsgKoTDjdTSEvv3SYwBYJDU2oXSowbdLyj8T
         fWlriocwicNwDFQ/qPqVnbVqFWlGurxSsfo9TxIozUJ2HkRErye62yxZzGRgMs1oX2Db
         0Dag+pe1uowRfgRTx/IKQ24JVbUQDaqmGf7qumO8H6D+sblSlGV5lS7GPtAv/Uq1OUqs
         uP479Sx49F/LVBtmnyv9aFwwN1JRLZf2QmvVFht9FDKoDer7CqRNb3ksBmkshk4t6TNi
         bFkA==
X-Forwarded-Encrypted: i=1; AJvYcCU5DeH5wyKNI3ifWW3M3tWSZGohiHrewFbJEHBiDZuhdvzspphCBDLkY8W7mWpCN+eMsvxkuGqdThIq1MF1bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyykO9lFi/HypezD+TY6RFgqJEhEhI7LzwX1m4/I7vNUtFjQu2H
	ULqD5kXU3naJv4RmilV0ezGb6zH63EyXGCvsGnWJLosPPXFtxb/upU/1obbyIIEbQRbNxPsbZIj
	Lxq+Vam39EcvTJxlV8ux9T0i05GfQp+1HevTYyHakspMrho9QNof9UQ7BdkMTSNS2
X-Received: by 2002:a05:6358:60c6:b0:1c3:6e1d:c435 with SMTP id e5c5f4694b2df-1c3d80ad085mr429568855d.1.1729787206294;
        Thu, 24 Oct 2024 09:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzWjtW8b858ciuh8Wq7RskpfgM3fvL/CxILlZJBLE7jsgYxeur2gG+awUuI6H5vLJJQCIAhQ==
X-Received: by 2002:a05:6358:60c6:b0:1c3:6e1d:c435 with SMTP id e5c5f4694b2df-1c3d80ad085mr429565955d.1.1729787205968;
        Thu, 24 Oct 2024 09:26:45 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fe312sm51919786d6.49.2024.10.24.09.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:26:45 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] pi_stress: Add memory barrier to resolve crash
Date: Thu, 24 Oct 2024 12:26:14 -0400
Message-ID: <20241024162620.349934-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is also an error report seen on RHEL 9 and Fedora 40.
pi_stress crashes if you run this near full cores with one core
(2 threads) free for housekeeping. The crash usually happens at
around 2 hours of pi_stress running. This issue was reproduced
on a RHEL server with 2 sockets of 10 cores/20 threads (total 40
threads) and a Fedora server with 2 sockets of 56 cores/112
threads (total 226 threads).

The pthread_barrier_wait should guarantee that only one
thread at a time interacts with the variables below that
if block.

GCC -O2 optimization rearranges the two increments above the wait
function calls. This causes a race issue found by Helgrind.
You can prove this by commenting out the memory barrier
and compiling with `-O0`. The crash does not happen with -O0.
Thank you to Valentin Schneider <vschneid@redhat.com> for
suggesting about -O2.

Add a memory barrier to force GCC to increment the variables
below the pthread calls. The memory barrier prevented any crashes
for several 24 hours tests. This function depends on C11.

Reported-by: Valgrind's Helgrind tool

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 src/pi_tests/pi_stress.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 371e906..37023a1 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -44,6 +44,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <stdatomic.h>
 
 #include "rt-sched.h"
 #include "rt-utils.h"
@@ -952,12 +953,31 @@ void *high_priority(void *arg)
 			    ("high_priority[%d]: pthread_barrier_wait(finish): %x", p->id, status);
 			return NULL;
 		}
+
+
+		/**
+		 * The pthread_barrier_wait should guarantee that only one
+		 * thread at a time interacts with the variables below that
+		 * if block.
+		 *
+		 * GCC -O2 rearranges the two increments above the wait
+		 * function calls causing a race issue if you run this
+		 * near full cores with one core (2 threads) free for
+		 * housekeeping. This causes a crash at around 2 hour of
+		 * running. You can prove this by commenting out the barrier
+		 * and compiling with `-O0`. The crash does not show with
+		 * -O0.
+		 *
+		 * Add a memory barrier to force GCC to increment the variables
+		 * below the pthread calls. This funcion depends on C11.
+		 **/
+		atomic_thread_fence(memory_order_seq_cst);
+
 		/* update the group stats */
 		p->total++;
 
 		/* update the watchdog counter */
 		p->watchdog++;
-
 	}
 	set_shutdown_flag();
 
-- 
2.47.0

