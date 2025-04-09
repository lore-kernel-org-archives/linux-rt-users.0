Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCA1E32D6
	for <linux-rt-users@vger.kernel.org>; Wed,  9 Apr 2025 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227110; cv=none; b=o3ITokgvdb6fxSENv3nntXlJ4toKDVm4YZSOHLr6LiDf5MqfNNDeBWS1oLF/cFaF8u7QynMYWbwhzc385H1bGo786Q/hvoOr/slKPA1UATo4wAMheQ6pmpDGE2SRf9fxR3VUQpyBOQoNfvQatKSZqQ+1kRT711W29t/zUVjzpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227110; c=relaxed/simple;
	bh=MPYnPjql3/Hd9GAHi4Bu1Ijzy9sTLuOzIx9aaCI8oKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3jlMar/mcenXYPGVPnYn0Kgcq4eQRC494+eGISaEbzY4S2gUfISGBM8hUBrO8jbXuPm4w5FuKoLU5GKGgfRIpB4mfjFRCv6Rg8Wm182DtY3jriHoUm02E/AJr74EgNVoX1OFK+JNdbckZ7meC5C0yAqyFAQuJ/CaogG6MylTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aG22WCKn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aG22WCKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744227107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IO84X1P13nvj/6E1jFR90gRF5xHRm7am6ANSLursWZc=;
	b=aG22WCKn3W4AGjwPuGzLsl7gk/mJ3SJCe5ZKz5Rj1dyr9CCQlgQHMJqLbx/aiEYJ89zfDy
	VJ6/UiNiGM3+7Q7VneViLNApcH2kt+lyCcP5PiSlAKLjAoZImVQ3nAau1QqqCQqZDwVok0
	9EG6egIlEYWayp7IacE1dxyTQRMg5UA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-UYjesfqvODSUkro8lyXx5w-1; Wed, 09 Apr 2025 15:31:43 -0400
X-MC-Unique: UYjesfqvODSUkro8lyXx5w-1
X-Mimecast-MFC-AGG-ID: UYjesfqvODSUkro8lyXx5w_1744227103
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8f9450b19so1734566d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Apr 2025 12:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744227103; x=1744831903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IO84X1P13nvj/6E1jFR90gRF5xHRm7am6ANSLursWZc=;
        b=veOfZCn36ID87BAqjh1Fw4loduhuGCK+Q45pedoDJCXPYPISjRVuGkMSJ6F9OOAwDv
         gOr3g/NqD5I5tLNIqeCPo2pdSrZLq08Ch19hOMkkahjMfy/TEd5wwBQPqjyCkSRiJyxZ
         R5FYuahGT6GFG+PK8qRqZQh8DGrxBPzQVMj0cavqz6giZTlBZQxW1c4TcNJqLo4ncPu7
         xcNLHL6l0XA7pyNdHKQ7dURWd4fLBSpff/wj5rqbY8WeTUc6rUED8JdiLusMWRLV1r1E
         lCcNOapaBJEexAHiMhOtpj/NIC/lyIg4PGPAsEAIt2LmTOrqMQlhc/N0fu3IF8ECJC8K
         PfJw==
X-Forwarded-Encrypted: i=1; AJvYcCXiyCcR5de5Ssmp1pvyn8FrCSvUJKkeKOsmu5cn5E3yR3Dq/fx3JszV+5BvnvuJSxfrZUVNF06YQYHvcGgiRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnKvv69ryaw4IXGpdW35YgJPFCe+3wjp1yQ99SJkF0PnPg7Gj
	YyNf4mNkFdTe7BhxKteqRIRdO6YPGVa4zVbkjRLd82BkHFkNq2z9p8do66TTllSIeuq7sw8edIn
	ycHqvwFmii4mIfwsO9rHvD62w3qt93msb+fCmw5D8wxIIsWVlSu9o/Qi7cSZ/dGyH
X-Gm-Gg: ASbGnct1MVWCG716Y3fM38k7qaebKIg/z3cggIMnOWWGspXa6j858Mrku/vs7AJxSNR
	eGUKGqOdSuZLVdwma2IUZyB5VjkcTXgkhwi4Dsaftg1n2pE+EJEdO88js6G/Eg3r1P3QFxx3r8c
	Y4F5yRPZnDjRw7DD62pquRzdVZUicTWxZAq3CcuxPXR+VyzIAywUOysKtkXtVNT/e37znArnyG4
	L8e9cLlzQpabzaVq5N9+ao1Xa74AHiEmfmQWC4piIMvFz6Zh4K5VhHxveZAReCYhllZjVOl2JlM
	38+MnQ7PEw==
X-Received: by 2002:ad4:5b83:0:b0:6ea:d604:9e4f with SMTP id 6a1803df08f44-6f0e4d38926mr13767686d6.19.1744227102858;
        Wed, 09 Apr 2025 12:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELXJVkLmh1EJ7q3stzw8xHNQIN1ZsXYyJvlIkeCneXEAvU0qZcqWC8hGV0/VOKp336DDfTzw==
X-Received: by 2002:ad4:5b83:0:b0:6ea:d604:9e4f with SMTP id 6a1803df08f44-6f0e4d38926mr13767326d6.19.1744227102569;
        Wed, 09 Apr 2025 12:31:42 -0700 (PDT)
Received: from thinkpad2024.. ([71.217.69.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea08028sm10808586d6.90.2025.04.09.12.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 12:31:42 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v5 0/2] Add cpupower idle-state functionality
Date: Wed,  9 Apr 2025 15:31:31 -0400
Message-ID: <20250409193136.44411-1-jwyatt@redhat.com>
X-Mailer: git-send-email 2.49.0
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

Changes v4 -> v5:
- Additional changes by John Kacur suggested off list to make the code
  more Pythonic, changing idle_set to cpu_power, and resolve some
  miscellaneous issues.
- Changed error messages to use stderr as requested by Crystal Wood and
  other suggestions.
- Removed Suggested-by for Crystal as she said it was unwarranted.

Changes v3 -> v4:
- Additional changes suggest by John Kacur around the use of
  @classmethods that they should've been @staticmethods and the changes
  needed for them.
- Changed the SPDX lines to be at the top of the files as requested by
  John Kacur.

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
 tuna/cpupower.py | 177 +++++++++++++++++++++++++++++++++++++++++++++++
 tuna/utils.py    |  28 ++++++++
 3 files changed, 239 insertions(+), 30 deletions(-)
 create mode 100755 tuna/cpupower.py
 create mode 100644 tuna/utils.py

-- 
2.49.0

