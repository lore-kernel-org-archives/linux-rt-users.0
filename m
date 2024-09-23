Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9D26AFF
	for <linux-rt-users@vger.kernel.org>; Mon, 23 Sep 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106840; cv=none; b=rZlnn1lpVrhe3itkvcFuV7IUmvypGNaovxWJXwYZ7PP691SUB49LhF65f3wWaBAsQDd0iNK9q/IZYHetsQGbOxQOpTsf5R4oCobCAVvekjVU8ntaWBNamB8yWy7iMckiT+RSPCRe/6AG3DAVw1SdV43Do0fMrgV++YlBarPt0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106840; c=relaxed/simple;
	bh=zznRo55fMhg9QBRlMf7aRMXMQHY5ylQ3zB982OKxCIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfUskrihONA+Ga1sydly46rUj7ilE8TqqkuZRz5zLF/CJk3KqcvN5A3cUZzvw2wD1Zrn9B6YVuq2IHFlkkjwh3FMAeIWOUxuX+FpD+Qo3uvSs/+3fwoOcJbt6ObUsJVVb8uutPXtRh25MW3haFxhniDExTkhW4xAmFbC/MQO4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoYCJ5Sy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoYCJ5Sy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727106837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p/M4AR8hA+Xv5wJZp/+BRnP4+Dslg9mIPaQq7sl7MwQ=;
	b=aoYCJ5Sy+h8Pov+p2+7TxolVsQeZwiMTNzANl7O1Q8GgFMSN+bLNcx3mUAUf4IXrU391kR
	3OTD/evji4jEDt1t31yy4FqF6eeoMhmYoW2AMFyiR37JjvR3d7YT8hhpGmghV3i1jEwxNa
	O0IS1fpUuUk2EDbO3SbzqusRFLGk8ys=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-RB8OyrTVP_25Q6TexY1JEA-1; Mon, 23 Sep 2024 11:53:56 -0400
X-MC-Unique: RB8OyrTVP_25Q6TexY1JEA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d8759255d4so6624137a91.3
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Sep 2024 08:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106835; x=1727711635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/M4AR8hA+Xv5wJZp/+BRnP4+Dslg9mIPaQq7sl7MwQ=;
        b=UeRB1spev1eDqR5Wj3MAPqxapjymhqOLsY8ZozTtwpYLg7cMJ/+SBcR4Yykv1VqEh7
         XZoGS+JXTA+ZlXLWRVEMvH4esBivFaSCJQk4j4N/HcPF6XK6yzVMuw3RCfiGl8ZqpZMn
         +Tzp6kT2MKP5WduX7hbxzDIGLHfWnuSXykyzu3ogRyVDGnQLKU/hGWuTDCyWCYU1xjlE
         mN3bZXqKpzvwZKKF+KKTtwMfRmE6FS3H6WF99oroVQqM3bfhQi0XA7eLTCn1ZbHnMV62
         somBN9dSMC3WZUmPVvlhi43Wdk9mrwIEQAXmq5ml8sFSBPXMu1K1ZUTYbA8j3NhD+Go6
         GYuA==
X-Forwarded-Encrypted: i=1; AJvYcCVR9CtUTttclnbRj6Rs792ADriSFrd2derkdyGeJrIdcenHhh1m1lUkZjbFNOGob31jiAS61Bi46ufaYkvnug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzI/fzaku6WdRMUVhzixl6AV+UaUQole8rLuaGJyJOokqaTL+p
	OeTZDZ+lESEPSvT2IPJyFxsZQqsOxKiPo+nODb1/Iv0vXSuLDR/oXoOW/nJR/azfqm8kZl0Owwd
	pnwMURegTPJhtYFr6hxMDUeiqQI1esFn+8qBuOjZzOA6pu+pEFRnP+pQClgT/tUYN
X-Received: by 2002:a17:90b:274e:b0:2d3:bd6f:a31e with SMTP id 98e67ed59e1d1-2dd7f6cc3ddmr16528907a91.28.1727106834898;
        Mon, 23 Sep 2024 08:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0CajS2PGRLs47/IPmViVe/5Uh330v1VjR7s/FJAOr/t3H7u+WMYHwLNS2aMQkidRlvD7Vcw==
X-Received: by 2002:a17:90b:274e:b0:2d3:bd6f:a31e with SMTP id 98e67ed59e1d1-2dd7f6cc3ddmr16528878a91.28.1727106834512;
        Mon, 23 Sep 2024 08:53:54 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f8ce8ebsm7409031a91.40.2024.09.23.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:53:54 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] rt-tests: pi_stress: Move unlock into if block with matching lock
Date: Mon, 23 Sep 2024 11:53:41 -0400
Message-ID: <20240923155343.43720-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve unlocking a not locked mutex.

Issue reported by Valgrind's Helgrind tool.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 src/pi_tests/pi_stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 673a7bb..371e906 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -552,8 +552,8 @@ void *reporter(void *arg __attribute__ ((unused)))
 				printf("Current Inversions: %lu\n",
 						total_inversions());
 			}
+			pthread_mutex_unlock(&shutdown_mtx);
 		}
-		pthread_mutex_unlock(&shutdown_mtx);
 
 		/* if we specified a duration, see if it has expired */
 		if (end && time(NULL) > end) {
-- 
2.46.0

