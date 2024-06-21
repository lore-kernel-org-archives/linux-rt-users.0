Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF051C14
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 17:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992120; cv=none; b=tNGOLdWOyWLHbxbDFNXrVWjthm6DPXjk+X9teqVBhKxCHZdKcD2JJ6sE/pXVhCr1gmyhsqLzZ6uVDaFu8sSV+Iy/muS9uoO91MWf/TvYmFzEppD+IclhDhz4POGxVhaXrACWRmV7cRdwhL/6v3zEcTTvArrcnzw3wBMkwJ8yo10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992120; c=relaxed/simple;
	bh=WENih3Vlh8j0ndX938MME0Sa0Z5o7S7yap6gYd1Z1IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+Fpk3ugFi2gLRpZybPGL3KQqismxzPDA82AKc/NqH1p/hiGZo37Ku0sXCTI6lmr6EBzolZDRQFs3RV/b3dnUMH+KjZAPVRmbJS8Sn+b1Wqx1ywJhXkhiH56Awsj7uGellOCNuOWXZ3tfd03Iqja8IQ97sqhMwW2exG8q/pYuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXNCiCYH; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXNCiCYH"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80b58104615so546718241.1
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 10:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718992116; x=1719596916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sB/3zVU2sSsNq/Q6xN0oqf82IP9VU0LkdJiF1h9qvM0=;
        b=lXNCiCYHwCQ05/jy9QHxYIXPBz6Ow8666cIrfH6fwaZzkKWjeluE7M2pJqkQr0iNk8
         uBdmlD/cYq0Ww/Xkw+XdOeblf4Y+IfQ/SydNatNeooHFN6L5PXK9kMUY83bqrYaZuoRG
         iwLtMKQK8eCP69bKxqyI6bYFMkBkO6oXW6c3tJ7+Kwb9fmh4DxW5hX4RM5D2owgmlMUu
         G0DQ3Io6SudMp4bo8EcqxdHA6ZaY2anz2LTaPaYUxDPQaBdZZIfSp3KTmmzNCWLTN951
         wF5dYTpEY+Rh74yDYgmpyQ2lHwBni6VXN39SrqnMUehuvDNDgsC7N1dIH0jo4W/OnEpJ
         8l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718992116; x=1719596916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB/3zVU2sSsNq/Q6xN0oqf82IP9VU0LkdJiF1h9qvM0=;
        b=sONjcXUYY35nqYQVrI8J1Kjlp7deI5bTeFCKmvHQGDWjPnot2ebDIUpgaOUjguZ06F
         mAjLNqaU1X9rhM2CYZp0uhsGcAtdjH8g3jVMOYz1FJ00sH4fAyXBCfPdY/xv9fHI3mIT
         C9JPL1uTljH0g7hMFON9kZiaubsUGIDGWogcclVKPEKlT0cL2avoKdDxVQJJtfE8HFg4
         X3Ywrj3w2f7CoczQl+xDlnReXwkIszCFsRKdQPreH5kvvIZX8g0UgVbka+5D4mvHLglC
         623G0PJo7EleiPkc7QBxEjEy7QipphVjn+RZoxj6iI25fNobNoAhFESCaGDocNoAi6mZ
         fBPA==
X-Gm-Message-State: AOJu0Yx6tDaYCXWvDHxLGVjSKdtfKxYZrg4wbPjY+5lB0PVPYKgwCALo
	bVjHPzMpYSlHrbIAsfcs8U0/sGRiExdAWftUJpFkilD9/mlvLeXn1kh1qQ==
X-Google-Smtp-Source: AGHT+IE2Ri5r6TA7ocmwUqh4i3YKmhZ+2NwHizy9zaF0F1J7mBnY7YZylMdaE5AY5PXVeAr9odZ3+g==
X-Received: by 2002:a05:6122:4121:b0:4de:847a:3647 with SMTP id 71dfb90a1353d-4ef277801a6mr9761639e0c.11.1718992116426;
        Fri, 21 Jun 2024 10:48:36 -0700 (PDT)
Received: from localhost.localdomain ([76.71.123.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce942910sm104802885a.129.2024.06.21.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 10:48:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Fix sysreport traceback when utility sos not found
Date: Fri, 21 Jun 2024 13:47:54 -0400
Message-ID: <20240621174754.303701-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rteval is run with
-s, --sysreport       run sysreport to collect system data (default: False)

and sos, sosreport or sysreport cannot be found then rteval exits with
an error.

Fix this by adding /usr/bin to the places to search for this program.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/osinfo.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rteval/sysinfo/osinfo.py b/rteval/sysinfo/osinfo.py
index 3d6d5f8daa96..3bdbcc81e068 100644
--- a/rteval/sysinfo/osinfo.py
+++ b/rteval/sysinfo/osinfo.py
@@ -45,10 +45,16 @@ class OSInfo:
     def run_sysreport(self, repdir):
         if os.path.exists('/usr/sbin/sos'):
             exe = '/usr/sbin/sos report'
+        elif os.path.exists('/usr/bin/sos'):
+            exe = '/usr/bin/sos report'
         elif os.path.exists('/usr/sbin/sosreport'):
             exe = '/usr/sbin/sosreport'
+        elif os.path.exists('/usr/bin/sosreport'):
+            exe = '/usr/bin/sosreport'
         elif os.path.exists('/usr/sbin/sysreport'):
             exe = '/usr/sbin/sysreport'
+        elif os.path.exists('/usr/bin/sysreport'):
+            exe = '/usr/bin/sysreport'
         else:
             raise RuntimeError("Can't find sos/sosreport/sysreport")
 
-- 
2.45.2

