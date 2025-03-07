Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8419223F296
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Mar 2025 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370857; cv=none; b=hkeH8TET25Ehzj0C51qIs9ZcRkVCag3eOsM3dFLPzpa8+6LE0VrJEea9+6eX7T70NXO3wsYm9/y5ef+vDXOtcxWeGVDAlbuXH8kuRE1v6ytjF9bqnw2V7gmoHS7rRgLcLbsxiZmS3mNhKbPKXBfIoYGAAVGZ/OyuD8DM/aQuL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370857; c=relaxed/simple;
	bh=DakMEWOTia5A6lyhKeC6ly6rk19wvW0E3rhEdGATllM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTb1XYDGTr5etLaTQHMfIos3TIVM2SHaqSokmMTrsFbrn0HTi8ZmO/NqgOnUoA342RaSqfD4x3HbeVERMHusW0+KiVIGZzRyT6t0UPYzx205tDUHImZv8tWdTha/ZtKTgFXXR1KfgJ9wvaijDF1PX5lMv2toIwtOqoJ1fD0ikRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYWsUnZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYWsUnZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741370854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=60Q/gn4JB4GzLAnw8aqrmwqFgiPhy+2dpG/YUOjgTW0=;
	b=BYWsUnZJ3TXouRPoRsTWtGNuiDDZjeh9ZS+wmZVl4FzyA6c3UXwvVisLrvf7iywOu3Zbm0
	724eOHU2EerSqdoWqw9Ni2MQVLmS0P57QJVolh60QWmMnumrnhFd7XnzNH+DEt75H3HlwN
	m2K2kuL70AHnfpe/MT8dBYl025aWh0s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-7-nVzhzpM_y3IMO26095Qg-1; Fri, 07 Mar 2025 13:07:32 -0500
X-MC-Unique: 7-nVzhzpM_y3IMO26095Qg-1
X-Mimecast-MFC-AGG-ID: 7-nVzhzpM_y3IMO26095Qg_1741370852
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4765f7bbe1bso6286871cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Mar 2025 10:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370852; x=1741975652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60Q/gn4JB4GzLAnw8aqrmwqFgiPhy+2dpG/YUOjgTW0=;
        b=v897zWNIZAKbzF8Fgyevjk9+ytiXG3jebo7TjmJlkwSgfVZcg7iVbKFqlJFnVu/kNb
         5iDx8hra/5a+A8c6Q/pbnu2iEg3Wsg/O1vyeZI2IQc1dUz49dVaUH8SYgPTis+QTy/AC
         eJMeOCkvGyIZKB+GZQdpB7QlwWSkPoOZ9816oyMbU/DFFFZvl1J8AL+VbkI8knI2V5w5
         uyo82XQazNShh7PzJHF6giR+lqdcUty7JDaQVlMLJar51EbdaidbU5PdNISdCPUw9+dE
         47WsC3J2BK8HEojDTMExZW2+oyBYyle+I2uBtCfcHpg2fkLaVF+fWqXrJEsU/Ycccj5o
         SY5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3+F5IwURq7H2KPHAdT7U8uEJk/sd8uHp8i3sTuHNF9an8SX46XZzMqjZzPkShvaOKM19KHqdkE1cIbaS96Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZ6xfu6PHsw/bTSkIcWzFvDParxbtTP/UHRomMdi4CNbfFeXD
	KE6aUt48D/F+NK1wHwIEKyXKmOs2VfeiamtjxGx4bIwV8qz1rMPQLVDLU3fHXp7W5OnB8cxhRPC
	W61rnXdvpkg4MWc96tKxGMbY1KKzVCuvgVjNLk86hXBtidqEDC0B/Vmx0AhjtwPRR
X-Gm-Gg: ASbGncvCNY1i5gwAQT9vHSWIETixv1z8jcsZ5lvkv5vXkL7CEEgJ9bjA3IJc7jOZJka
	LiYjnk7cFvKoZMLKSYw1KhgNBh5vuGtmLgMrtMgOdfT22DkFrx8CLWuYeyT77KSILLMyEuKh18U
	E5bkwULh9KQgUEPYYFz0PgWDAuTYBZDGsdQskTo50d63EUThwdC/gF2Nn6/fFmUaWL18OUOEqTh
	qVBmV9/P+FiG0Qlr77+gJm+lcRCLVGnuAV1tKfw07BbdkP54KIB7n3yzmJMdZ8kKit6/BicIznu
	1yMMPS/SqZlfrY9kgupeQPXfcA==
X-Received: by 2002:a05:622a:1344:b0:474:e655:2a3e with SMTP id d75a77b69052e-47608bc2fbamr56046241cf.0.1741370852185;
        Fri, 07 Mar 2025 10:07:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNOPe+sIWmXEWVjJmq1/OsSGQCEEJ9Tvsdx9hCiiiLnK1+ooLKXb0H2GBU1sl8/2dIvL3Q5Q==
X-Received: by 2002:a05:622a:1344:b0:474:e655:2a3e with SMTP id d75a77b69052e-47608bc2fbamr56045971cf.0.1741370851930;
        Fri, 07 Mar 2025 10:07:31 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751db2f15dsm22684601cf.52.2025.03.07.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 10:07:31 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v3 0/2] Add cpupower idle-state functionality
Date: Fri,  7 Mar 2025 13:07:01 -0500
Message-ID: <20250307180706.5875-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds idle-state functionality to control cpu power
usage and to test idle states.

The number of cpus was needed in the cpupower file; I extracted out the
previously local to tuna-cli.py functionality to a separate file so the
cpu code can be used in any file in Tuna and reduce duplications. The
nics code was similar so it was also extracted to reduce the number of
global variables.

Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

Changes v2 -> v3:
- Several small improvements suggested by John Kacur off list including
  removing unnecessary string interpolation, renaming idle-set to idle_set,
  and correct placement of docstrings.

Changes v1 -> v2:
- Numerous improvements suggested by Crystal Wood including message
  text, output, error handling, moving a function to utils.py and
  structure of the code.
- Fixed a libcpupower bindings detection error that did not show on
  my local machine but did on a fresh install of Fedora GNOME 40
  reported by John Kacur.

John B. Wyatt IV (2):
  tuna: extract common cpu and nics determination code into a utils.py
    file
  tuna: Add idle_state control functionality

 tuna-cmd.py      |  64 +++++++++--------
 tuna/cpupower.py | 184 +++++++++++++++++++++++++++++++++++++++++++++++
 tuna/utils.py    |  28 ++++++++
 3 files changed, 246 insertions(+), 30 deletions(-)
 create mode 100755 tuna/cpupower.py
 create mode 100644 tuna/utils.py

-- 
2.48.1

