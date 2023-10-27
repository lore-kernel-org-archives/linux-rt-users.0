Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD23AC22
	for <linux-rt-users@vger.kernel.org>; Fri, 27 Oct 2023 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4XxPT/d"
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7651A1
	for <linux-rt-users@vger.kernel.org>; Fri, 27 Oct 2023 12:25:07 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce2b6cb933so1514811a34.0
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Oct 2023 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698434706; x=1699039506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/66J7KziCcE+KPHsYjkX3vxxi2ndJJc+rH/xzURQ0NU=;
        b=W4XxPT/djWx3JD9dp4P842uRDpFUk0+sdw2HJRI8VY+vR6iVWdWu6Xt6AglCUL3FoH
         aeB7ehXeRtwkMYSZb5BKGncj1n2FUNui6AHfwfFXS8if6GnaC+5J2/UOHjyU0i1bj+si
         lN2vCemp2Ns1rYjGy1VHwk6/kCdXakYztJAJvqdd0zPQvwfUKXS832q5i6bSUIdNDqwR
         1Z51sSpgobAsd6OlLJQ+wxFazw9SG829qDATXbwVXWSI5XZ+RAuHZ+w6CbTbeD60W1tZ
         O1Slo+K+bowoda6ujmebRa56A0K0IoeFEZB67spWRFaiX2Ghj87+BDmIgLTUvPluOVDW
         WUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698434706; x=1699039506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/66J7KziCcE+KPHsYjkX3vxxi2ndJJc+rH/xzURQ0NU=;
        b=NmPGN+8JlNnQ0s2bINpyta4MuekqFcoqOarpFbvp6+N9kZtUSQJx3CINS++eY619tp
         Gg8v+ocwYs0zYX5b4AwZPcQs+972FZzEow/90EZ6/IMyhvSZG16IxWvuuc+VXFeXRxQl
         IU3bxvyFF2soJsMWSMdLitinq+fNDbZneWzBLwsBZNOWPZ9FDGv0kzZCzGfvEikRpC/c
         eXxtAMM+1TWALIEYsfcLyaHwhIO7CaZAkuFPnskDRE7qtI0kHIJQQDNXXAVr+BeW2NwH
         +KYbCJtgvMA8EKj3ONMT7JKlys5BbVlxtallLcXs+a+EuREa2SheTg51hDIorQnTnneg
         0GTw==
X-Gm-Message-State: AOJu0YwOe8b6JyWiYId2iBLaC0Kk27ziJ0yJT/UPHpXSsKUdFBC2Idvq
	9OY+mfjIJgpX14h7MSYVRXjC0e/Cup+4Bg==
X-Google-Smtp-Source: AGHT+IGs1HqrEy2DEL+q/nFJ+phdL2twNYUvdkOc8CiGz+6jOZcCcqTN+g1HUF8LwqZoh4QMflRJGw==
X-Received: by 2002:a05:6870:581f:b0:1e9:fb1e:8704 with SMTP id r31-20020a056870581f00b001e9fb1e8704mr4044002oap.21.1698434705965;
        Fri, 27 Oct 2023 12:25:05 -0700 (PDT)
Received: from fionn.redhat.com ([174.88.88.29])
        by smtp.gmail.com with ESMTPSA id dk19-20020a056214093300b0066cfb9cc087sm856083qvb.134.2023.10.27.12.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:25:05 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Remove remaining unnecessary texts after adding SPDX licenses
Date: Fri, 27 Oct 2023 15:24:46 -0400
Message-ID: <20231027192446.42936-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove remaining unnecessary texts after adding SPDX licenses

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/signaltest/signaltest.c   |  4 ----
 src/sigwaittest/sigwaittest.c | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 4737c253b1af..5412c50f7e17 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -5,10 +5,6 @@
  *
  * (C) 2007 Thomas Gleixner <tglx@linutronix.de>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License Version
- * 2 as published by the Free Software Foundation;
- *
  */
 
 #include <fcntl.h>
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 818e3a8e680a..55855769c63b 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -5,20 +5,6 @@
  *
  * Copyright (C) 2009 Carsten Emde <C.Emde@osadl.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
- * USA.
  */
 
 #include <stdio.h>
-- 
2.41.0

