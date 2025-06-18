Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5C3085AF
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271314; cv=none; b=KQKCh4mojWuj1EtcGwC1AVv4Edz2CZnptdGpCB8zg8YPT8SkJoxXQejnY9bGPuIvuP2/7aWiD5jIkcgGqRTc5Fj3CULPvTErVm3zZru9kEX16z4i/ZQ8ulru4FNgZyEicr6s36D9gGrscdgp7SqtxemslAolhbWtsaBDkiiARtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271314; c=relaxed/simple;
	bh=BsYdVkHzXK6JOzBlPA9kySC2GOLQBWsqKmr6jZxakIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ets52cUOoPHUM1CnkMDnfKHRofc14c9d+Bf428scyrkQ33bDj1nWlzcshSdxVQr9x8rpmHIJ1Zzt+H5khZRma1KC0bG0iNYZXofViYtnwlzdaYEbIcIvdMwO++CoIfRMJm1Hkqx0G83aSAAoPpZprlfyAhR2e1IKIF9bdmLT+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok1fNRWB; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok1fNRWB"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d38cfa9773so763555585a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2025 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750271311; x=1750876111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3vKwSRo+D0Tnl9anlsmMyzCkVQWagbzjdstWW6QBMj4=;
        b=Ok1fNRWBk0eW0pfviuZrZwvoldyqpJy/zj5emjJISb+utj5W3vDIWphI6yH3gif1a8
         hmZFq6Lj88MwvAGs69DS52wAnrOwL/KhTwnD9WoJ+LiHfMRcClePsIbSmVy0/7cVMS3H
         vCxzaUxCq1tLxWI+INbE3Yhwn4unKFmyYPWevT6U5GCwptUUWhWAklAdO5yh/zJ4azsj
         az4z6kMgpiX0AlDI5px90HwZYAM30iC2KNXaERa3cLbqFSQHco4nHvw/LKOjlGzVjY99
         8vcullz8h0tV/6863RR61EpkUMDxC84vC22O5CcsNT1C0TLnfWA0hQrLImatfNl0tvKx
         9AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750271311; x=1750876111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vKwSRo+D0Tnl9anlsmMyzCkVQWagbzjdstWW6QBMj4=;
        b=tJNUPmyawEa4hy8oNnBkACF8trA/720SXDRMK07B8f3pbD8mYVXWwqlM50SPfUqMy8
         rJ0cPPllawBFkTmkOVuvDF9djU4vZLED69TuSRQs+FTZQdd3Vq313ynW8C9S8FfLbozq
         sU+jgMTmXFMu08OR6T+glnLdJc9Ds4gaMKsxTDZJNIOfcKADHKfCrKRIhmsD9OI//yih
         6Cwma3LG7GLGp1/KXsEeWPcsFievmRc7hNGFoDfpX0KqsQ2f3mOHHSSy/J6enDsbhIj4
         uXntFpulouv6FaIu+4U7kqWRgpiVTS6AeEnxQDrSh0WsJUVqJ3cfmMz3/Vpq5ifb1GHe
         tIKg==
X-Gm-Message-State: AOJu0YwPoWtj2CKpusYy2FN5dxrv+h6lbDGJ+urguQEKplUzLvNyTm6w
	36Wex+JKt7RndTXBLwc6QZaai0anNIAS5S16yXgLeGMyVFVZZVNqAni1GO8qzg==
X-Gm-Gg: ASbGncuN/aSV1Z4N4GtKEoeVBiBeLIvWPyaVtUydN1hUIFBvnhI/Jg1zSFmOb3KeTqY
	jY67ufKx1NOAFcGkyV8Ip6FfYFUcLpQD1c7v7KezOLnz70I8CUjH7WyCpWes1TCvo6y2AKsCDA2
	XW6xXHzNliLnGhnjdPffPLxIiolcL9z1ge+ABxyW9/f0cTrV5pcecfJUg23Wf3yarvo6jGs2YG0
	DAj77eJpwBt7yUFJeOJXu3aiGXKwjliCRLZrSxiSk+iJtDumY4nPhCl1+TWT9k8c0qBgNfoiBUY
	kHnW7g4rzO34hjgs3MLZ4GIjxH56lAK6S348bOgY2m6jiMoC/t8HxvocVrpyk4YRJQFAcq8=
X-Google-Smtp-Source: AGHT+IFctkfxz+BXwSY61PWEpjC3Y/eJm02iZsazkmuj+LFu34CGh57JJ5IVKspp4sRnTfmoDiGxWg==
X-Received: by 2002:a05:620a:2894:b0:7c5:962b:e87c with SMTP id af79cd13be357-7d3c6cf5130mr2722612085a.44.1750271311323;
        Wed, 18 Jun 2025 11:28:31 -0700 (PDT)
Received: from localhost.localdomain ([76.71.123.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a4b148esm75999141cf.40.2025.06.18.11.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:28:30 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rteval: services.py: Fix SyntaxWarning
Date: Wed, 18 Jun 2025 14:27:57 -0400
Message-ID: <20250618182758.57946-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In services.py we get a SyntaxWarning: invalid escape sequence '\('
using python >= 3.12

Fix this by using a raw string.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/services.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
index e98017804841..c3c155354e07 100644
--- a/rteval/sysinfo/services.py
+++ b/rteval/sysinfo/services.py
@@ -42,7 +42,7 @@ class SystemServices:
             servicename = os.path.basename(service)
             if not [1 for p in reject if fnmatch.fnmatch(servicename, p)] \
                     and os.access(service, os.X_OK):
-                cmd = f'{getcmdpath("grep")} -qs "\(^\|\W\)status)" {service}'
+                cmd = fr'{getcmdpath("grep")} -qs "\(^\|\W\)status)" {service}'
                 c = subprocess.Popen(cmd, shell=True, encoding='utf-8')
                 c.wait()
                 if c.returncode == 0:
-- 
2.49.0

