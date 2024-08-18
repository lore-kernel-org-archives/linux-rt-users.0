Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E7136E0E
	for <linux-rt-users@vger.kernel.org>; Sun, 18 Aug 2024 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724010153; cv=none; b=d5ii95O8+SyqLlAzOt6awFPHpK80qb7X+pm7d33nkkTP3Nh9WMN5mCdIiz5Swq94wXkaR8jfO2tia1eqnSco9nPxFNUnhSnYEx5I7daCnL/d1fJDnXEivgIUW9Zb92BS/V9faklV+EF/8ZL64RMOxjenR4gbcGmEjtU1/SnMBfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724010153; c=relaxed/simple;
	bh=l6yTIfr4N5/sKX3NtPfD8zXPRC6mrAYirKRaMjb6lGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMdm3M96CSZJq2wXQKsUqbtLDmKIB/+2IM6kka/pqrD/1fXvLLSmtHTArRhMAkD91m20MLWh1XUWhsbgmTBXQ+gT3PV+cWDOPyl17cipL6++RtkeuLuLFcg26h6Ibeugd2Ne9nn6zZ3eg6rkMRTPRciFsO+K3KjfLFq6pU2QDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i03Ez2Nf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i03Ez2Nf"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf99fee82aso3311176d6.2
        for <linux-rt-users@vger.kernel.org>; Sun, 18 Aug 2024 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724010150; x=1724614950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eYpQyBXE9X29mHcEr5yryAso5c481fW755//mNEBUIA=;
        b=i03Ez2NfP+mQEYWuH/XZuvwBXHEdzCWbASZqiXL29a1IsBxs2fu7GpA+fvtj4Im7cE
         2WgJ3gBGV4sQ+0JJ1VxFWvWbehonaqvqAZMfZdozs0qkQU8pRzMgpI1RSGYpJm2WJAI1
         bC3LyOIq6l0cU+yXoixys7x8S6ye1xYBl/Fb8KAWuj2ZdwcsmKdvrTSvuPDIQy0/nrFz
         RMgPMZz3QJ/9QqUq8Q85dXYSpS3PmZsioLP0hUEmdQxQ3xQGDwLh9reZgUf5+v4dZX81
         hnYkTDCbSAxhmTB0pcPpRhQoUbwUav3bivvaYVv+cPI5q5RtdHNDGuq6tUvwLZ8PEJFR
         momA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724010150; x=1724614950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYpQyBXE9X29mHcEr5yryAso5c481fW755//mNEBUIA=;
        b=CcSEtzsn2OWz+MmJcQGkJ4qqS5sQON7tRj6QBBRfjB3P6CEdCnRI5wW+7+0r1OOgyB
         YCN3zN/IHPmZ4MCUUGcz72SceuJt8THg5ZwDLX/8/tBaqlL3Uy3F2xkyOSI5zbzngYCr
         VgXyMj06GKOJ0MVeqbZRaT2C3UenFekuf+X9kBlviDGpGLwOLQoNG0lYsHsZpUGImYcz
         ZPplkoggGEpVaXnVonOAwl/lWQbQJOoQ4ODnHhaEGFeoeG7br01LERB3wkRRo1FIoN3s
         ABqQ0QmgVHAf4eqvDrj0fOklyKcuRzXC/ip/IAofgRA6SnyBLAktU2+8AgtH7khcjUmE
         YpTQ==
X-Gm-Message-State: AOJu0YwjWY/SbmPlElUA+LjTyEJfzTIcn9B/Iw5au7yMzWXc72oSdtq/
	+0E6LS/TFNrGGTh2jyZcPo4HKE1tp3esUjlL7Qz2gXcgnNFJMLCqLeGIsA==
X-Google-Smtp-Source: AGHT+IEo8bkxzlHHoEjTAFkYw9xFbFgdC5bmZOn/DPXFRLYbz0kn3q0HrsLuJUXMw4jltxZ+pWOtHQ==
X-Received: by 2002:a05:6214:3d0c:b0:6bb:9aeb:c04b with SMTP id 6a1803df08f44-6bf7ce88ca9mr93931086d6.47.1724010149652;
        Sun, 18 Aug 2024 12:42:29 -0700 (PDT)
Received: from localhost.localdomain ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5f4fsm36909566d6.84.2024.08.18.12.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 12:42:29 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Chris White <chwhite@redhat.com>,
	Anubhav Shelat <sanubhav1000@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/3] Changes to supply a customer kernel
Date: Sun, 18 Aug 2024 15:42:13 -0400
Message-ID: <20240818194216.299176-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rteval compiles the linux kernel as a load for measuring real-time
performance.

If you need to supply a custom kernel for kcompile, these patches
allow you to do so with a "-rteval", for example linux-6.10.5-rteval

These patches allow you to do this by adding the ability to parse
kernels with that naming scheme. They also fix a problem in which
a kcompile would not always compile the correct kernel. For example,
if you requested a 6.10.5, kcompile could end up compiling
6.10.5-rteval instead.

If you are using an up-to-date distro, with a newer tool chain, the
kernel that was the default in rteval could fail to compile, so I
updated it to linux-6.10.5 as the default as well.

When testing these changes, I noticed that the --kcompile-source option
had disappeared, so I fixed this as well.

John Kacur (3):
  rteval: restore all load module options
  rteval: Upgrade load kernel to linux-6.10.5
  rteval: Fix parsing in kcompile of the kernel to compile

 Dockerfile                             |  2 +-
 Makefile                               |  2 +-
 rteval/modules/__init__.py             | 22 +++++++++++++----
 rteval/modules/loads/kcompile.py       | 34 ++++++++++++++++----------
 rteval/modules/measurement/__init__.py | 12 +--------
 rteval/rteval.conf                     |  2 +-
 6 files changed, 42 insertions(+), 32 deletions(-)

-- 
2.46.0

