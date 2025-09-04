Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEF4A3C
	for <linux-rt-users@vger.kernel.org>; Thu,  4 Sep 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995708; cv=none; b=CPmYv8OzuCBY4esJW10nHqt4xvm0w86ZSzkRBXY6V9BlD/igXVYJuFBUiML5Kby78c0tcSqului8TF3bX4eMm5w7rrALkGEmjQBLm3YRDmq3u6cHFe65JMSsQ07cZIiPJ9Bh7PuhPCubFVDgFQ8JKSCXwQlNp+i5j8CMYlYxumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995708; c=relaxed/simple;
	bh=Dy7Rd6n72zPh2uMay2T7FL5dIAC5fJnhoWKuHz28blU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYG4d/AKVYgqYcjNIkLjHVePbAMjZr+1yQaywet71eE2828ugYlPWvrdfhtz/jQ32iLf2Cl2y2kEGdALH4m2JFZHLkaPCr+Iq+LWS1wt6xh4aLqPZNx+E2EZNSoe1ABnLYyb13G1AnwQ2bpBFMdmKuLz6ct5SnoxhyRDQibBECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HMO+gD2I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMO+gD2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756995706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ueDHaAzCP7B7bAfsuqWOlkxtdLHlPk8l92ZblXdt11U=;
	b=HMO+gD2IoSp5l22eyEzsGe4br36fXxHVjMr94lgnGyIGkOIvn0LotW+fiRHnxBzeMahghG
	lrccx4CqJof6TMn8Hx2cgI+lySzataDwm0VRPuMusU9ECqc+q99wbuzydxhrHFKWjSEa4X
	xlUZSbPx3Ntxgpt5u0ckeStsEmU4vHI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-RJ1q4B2CMsKAmDULxp7Jhw-1; Thu, 04 Sep 2025 10:21:44 -0400
X-MC-Unique: RJ1q4B2CMsKAmDULxp7Jhw-1
X-Mimecast-MFC-AGG-ID: RJ1q4B2CMsKAmDULxp7Jhw_1756995704
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b29cdc7417so20351331cf.0
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Sep 2025 07:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995704; x=1757600504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueDHaAzCP7B7bAfsuqWOlkxtdLHlPk8l92ZblXdt11U=;
        b=M2/dKOuGa/vlNZZ7HFayy0H0Wqi+5n1iWgIGBzyFxhyl11yJh1Exu0WGYG3imBQwj0
         U6ukPFMXK454tHiKnOtBtCXE2IXJNY3ompOhxM2WpTi9AHoKAXUdKzf5BskFl91Vs/Yg
         wvk+mwmWNhN49NOCPe6IEREOHt0BNvX3y8X0mKIrzcc6oaFa5iIrJQp1c/nBV+jW1WSV
         DCvHD0RXEGEI68p21IbRXAvskDr1CuOhK4oPNjhGs7N4Kttxtx/DK/n1MEQWwCrcTaPu
         4yJc4O4Ta6onXSNhnYjAyUOtXG27KPxlfAPgh/ux/Jk66i3Qg2fhgRrcBdqcO3LwsHK8
         wYkw==
X-Forwarded-Encrypted: i=1; AJvYcCWSbJTh7jnypK/tLAArU2VhOgmJkZm6JriJ3HF2bNxeALbVoPjPWjPPQwuBCtvrStPHC2W3X6fErtMjtMLQlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEiOXWYsTfs+kf00RH1zRpV8K0kEACnA5OCmdsWOkoPzw3mit
	eH1N0YLyqzSkjeffWnfdJTu2MeqrSmas2cIpg1SjE2YzPUo8ya2jlFMzJjHzDcb5yeA9LtHgfx6
	7XrPiBnTBjUTSrT+3SHYXfm60BNGNW0unFgSbPe5WZsYqwJ8smP0HLZmDAWAhCt+bxH9z
X-Gm-Gg: ASbGncuysxfyRDUYIp3qZMxbcJRHW1U5UtzE5KYrU1AnDZKHev4Ub1MhnwQXaOy4DAY
	z2fgqarCb7C9Tt9j2XcrO8RZJpKy1OO6VPDc2V9ROYMMZe2mii1dgaUS3uQ+XaxAKBmv9hQZiuI
	v3JdcHIAqWdAwX3ea3D8tdwp6c1T/v1MgPYj3KoYpG9Q7wRSBZYgiloJ6Try/eOmkpCXbKJneF8
	xTSXTymAREegrQl23xWyM6fx6VuuzjGjqRrcRF2B2np/LjLhFmHbS2sTEsCEhUYQZrVZ6PwGWkW
	LS0mAToI0gT1OzxF9/jJ6k9MrtHY5b/3Fd8HR9FnbpQ/V80p+lAV
X-Received: by 2002:a05:622a:1111:b0:4b2:8ac4:ef5f with SMTP id d75a77b69052e-4b31dc91336mr231935071cf.66.1756995704245;
        Thu, 04 Sep 2025 07:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECcXgFmnI6gGybziP5HAYZiR+Bc/7cEqd2eGgqM9OfPiN6WuYRdywh+z4E18FBtWSQXr/QFQ==
X-Received: by 2002:a05:622a:1111:b0:4b2:8ac4:ef5f with SMTP id d75a77b69052e-4b31dc91336mr231934591cf.66.1756995703803;
        Thu, 04 Sep 2025 07:21:43 -0700 (PDT)
Received: from thinkpad2024.redhat.com ([71.217.50.216])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f799b83sm29260431cf.45.2025.09.04.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:21:43 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH] tuna: Proofreading fixes
Date: Thu,  4 Sep 2025 10:21:31 -0400
Message-ID: <20250904142134.41426-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some small proofreading errors.

Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
---
 etc/tuna/example.conf   | 2 +-
 tuna/gui/profileview.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/etc/tuna/example.conf b/etc/tuna/example.conf
index 7bb293e..0d3353f 100644
--- a/etc/tuna/example.conf
+++ b/etc/tuna/example.conf
@@ -55,5 +55,5 @@ net.core = core
 
 #special section for this file description
 [fileDescription]
-text = This file contain some features for tunning kernel params.Mainly this is example file for demonstrate tuna new features. Params are set as default or most uses value
+text = This file contains some features for tuning kernel params. Mainly this is an example file for demonstrating Tuna's new features. Params are set as default or the most used value.
 
diff --git a/tuna/gui/profileview.py b/tuna/gui/profileview.py
index 7570bc0..e5022b8 100644
--- a/tuna/gui/profileview.py
+++ b/tuna/gui/profileview.py
@@ -104,7 +104,7 @@ class profileview:
                         "%s\n\n%s\n%s" % \
                         (_("Config file was changed!"),
                          _("All changes will be lost"),
-                         _("Realy continue?"),))
+                         _("Really continue?"),))
                 ret = dialog.run()
                 dialog.destroy()
                 if ret == Gtk.ResponseType.NO:
-- 
2.51.0

