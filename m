Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8F146D57
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Jan 2025 22:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287361; cv=none; b=stcqgDB1jAssxVd8cCJj0xdNsSG3zR0+QgcxBmPpHpfGftxeIirtQuQTB46cv25uMOuwediy+8g2cQZMPcpo9Oa62GNv/7G4+ARlYESO3cfrKK+z0R6Qc07Of+QzhUnGFecmCJ5xL8pMfcqpt36/tUSRljNjWHaYSzab4gk6H9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287361; c=relaxed/simple;
	bh=8MPi/qiASsEBVUuvUngL0NJursIhW1YjFvyTDCSErfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4650+lOwVwZNW4DJ3YDKMLxEpmODjw0zXctoNR1pd2LXjbRo/dL3MnVFHxF4LSFnGciuL2J1ff9w0IijEniyVs0jpzdnkBxGG6FnMQ3hhPyucqMSjaERcSa7v6RsXMyw54SecpL4p8PMK3r9cd2QJPLXI/4kgseXpgSLQPmjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkte5LQF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkte5LQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736287358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rvP6mxlibHlhXHzgMqvT5/pAt4NYTiYGl2sZTTJqQg4=;
	b=hkte5LQFBWsJ9QEBPmn42TutRgJfIYdZu+29QNtEDHpJrgNd1K3WbgVJ0c34awf+hxI7Hk
	KoM3rA6XXz77xrcpUpFU9E6ADySTl8ZBxvB0hCBbm+oWEE7nRxhRl49wbXiaDD9kFz2ABF
	fEFAHUO3al/Al4W5ol3WYhkBZ8RuNY8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-nikaRDtjM3K9a2by8aJ3tw-1; Tue, 07 Jan 2025 17:02:37 -0500
X-MC-Unique: nikaRDtjM3K9a2by8aJ3tw-1
X-Mimecast-MFC-AGG-ID: nikaRDtjM3K9a2by8aJ3tw
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4679db55860so321294511cf.3
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Jan 2025 14:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287357; x=1736892157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvP6mxlibHlhXHzgMqvT5/pAt4NYTiYGl2sZTTJqQg4=;
        b=D93i/AKcauV+8pg6ltHHbHEVd5jjhJAYGaW1p3iVpXznH9zwykQIm6YTmyp0Z7H7x8
         eoRqz5qIKZjpcpA02u89MLOe/aBxMsKQ4vgrnR1KO45gkhkN2Lke7S9Npg3qbaqB6Bud
         TyI9x+lE+o4c1AttKAO4oYc7zqPpjJrOHXQi96juXJ3iexsC82flnNWgwRACodv3Wgx/
         prFLq8Yzxk037TwkQoRle0NAZAJuuYuVwPQOUFlOTUrUd90wQrHyX1tiG25NvS4xRYPZ
         3myvsxKuMk1KcSkjaM/SKaBPpr/7w/8y2yseX2kJCe1JZjp3vthaDbVTb7ubX1CzS7eX
         MYrw==
X-Gm-Message-State: AOJu0YwrpEpmxw7j82IAX+aO9gGpZPFs0oPKX/vyy4qcpDxFdYkzX2HD
	TgGSBOUlotErRDSMLeVMHwh4FFKCqgnPfwpk+e7/Vjw6I0XZLRlrthY6IYkEwk2atFg4V5w9K5Y
	+g2zwb6nZi+QWqR1EZIbJ1fXervQ+V6Eywbb+7UfeKsjycyvAo1aBNwGSOChBZitg
X-Gm-Gg: ASbGnct0WnOCpUh/cFuFx9qeS5RipFI/WjrD2aX4c3Mxhh6thFfL/INNJwf3N4PonYn
	G9vFqwW512htim/llGFvLDCXqGa2uqy9ZkbLdTI9GNEzs1nyqQu5y7BqZr0dZT54RTQZVaBKnEQ
	ziJ5tRDCX4WNz9nRohhsA4RsVT6HKQo8lAlQqahoWcP5ysTB2VYreVJi2vSgjvxVgi0oE0ybfAY
	DHKgXSxTaSjDB2C6xSUGgsTL6uuz1pyi2GvtrtrQCeyrCgczabspz8owoKMrFRs4hEh3LJr27Ac
	46ph08ggaFT521hdZR8U2TpaLW+ruK9o3BNiXUhdIkMugQ==
X-Received: by 2002:a05:622a:1a19:b0:467:6e45:2177 with SMTP id d75a77b69052e-46c70ffed13mr7375721cf.12.1736287356989;
        Tue, 07 Jan 2025 14:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErquDYqFFTYyBGd5upVonOrMpA4LiGwCe8OOhEwlKE35ePeuh+ntf4jtRULLxuPrhSW9Q2VA==
X-Received: by 2002:a05:622a:1a19:b0:467:6e45:2177 with SMTP id d75a77b69052e-46c70ffed13mr7375541cf.12.1736287356723;
        Tue, 07 Jan 2025 14:02:36 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6ada4fsm189884261cf.52.2025.01.07.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:02:36 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 0/3] rt-tests: -Wno-unused-parameter and -Werror
Date: Tue,  7 Jan 2025 17:02:26 -0500
Message-ID: <20250107220229.156201-1-crwood@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable unused parameter warnings and remove associated annotations,
and enable -Werror to catch new warnings

Crystal Wood (3):
  rt-tests: Turn off -Wunused-parameter
  rt-tests: Enable -Werror
  rt-tests: Remove unused parameter annotations

 Makefile                              |  2 +-
 src/cyclictest/cyclictest.c           | 11 +++++------
 src/oslat/oslat.c                     |  4 ++--
 src/pi_tests/pi_stress.c              |  4 ++--
 src/pmqtest/pmqtest.c                 |  7 +++----
 src/ptsematest/ptsematest.c           |  7 +++----
 src/queuelat/queuelat.c               |  2 +-
 src/rt-migrate-test/rt-migrate-test.c |  4 ++--
 src/sched_deadline/cyclicdeadline.c   |  2 +-
 src/signaltest/signaltest.c           |  2 +-
 src/sigwaittest/sigwaittest.c         |  4 ++--
 src/ssdd/ssdd.c                       |  2 +-
 src/svsematest/svsematest.c           |  5 +++--
 13 files changed, 27 insertions(+), 29 deletions(-)

-- 
2.47.1

