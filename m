Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE9BB674
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jan 2025 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738028795; cv=none; b=ljMvX04Mv56XsIoQQmlRZ9NZYAEx2BuFIQ6LLGiN/fU7F1q0Cphrni2UG4a8qv2GjnvQUXvUphXJwMEelnaH4QJQBfAmP1YMq3vck4uo/nDkMzwk7cht3Vo8bMaVRkHTy01kRMuDlMMKbXTMf1CNpP1yQokbR5reFPZZKBC/J/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738028795; c=relaxed/simple;
	bh=DlHa6lIP8ww4IFt6EbQE7lPDL7jCPKzKGhOMyBW3fPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NH8u1o5RDOSjj4OssJPZHEF9konADzOsNR2hYb3jrCcIVRpmM3Ur7w8QqxvOHM3slvbmcRvfWyk6iGaGKiFaxvzOtI6oP1O1W/C/3hfiTPIWU7QbDaWr+gKjMD1Ou80kpCm+5cDXsUHWxdWOD0NYBnZSyUz5iNhgBG2bn0R6N9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdO/JRde; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdO/JRde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738028792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+E0EsIk5/uWqoBh0XLGNokuGj/UltItZk6PnKcl6Sxo=;
	b=LdO/JRdexxLKdffuhUbtpjYEFuJmcIEF4N4TTzeqBKbUNf16JleatvU2Fp3xi6tsduta2F
	cPkpRh8bt90I9VhQVxkDvMsmYgg8W+Z3TZDzPZ+/I7UUs0kPIbbjQW1xGp+2Ybdq8OR7XK
	SD1he8NqWIaf0lAUZ4GTDG2aaTbD/M0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-6JXUd5wSPVKZp8X-7A1IHA-1; Mon, 27 Jan 2025 20:46:29 -0500
X-MC-Unique: 6JXUd5wSPVKZp8X-7A1IHA-1
X-Mimecast-MFC-AGG-ID: 6JXUd5wSPVKZp8X-7A1IHA
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467b645935fso89311261cf.3
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jan 2025 17:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738028789; x=1738633589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+E0EsIk5/uWqoBh0XLGNokuGj/UltItZk6PnKcl6Sxo=;
        b=hz6PuPd9JWGjiCEZUV/F930KETdDj1M3HgHcJwLgIPI/8GMtTo5O/W/rbicfgxsv0s
         Og1HQQWUk0iqF45XZ8NoPjaSyoAuS0yMdGqqDTyJk5q0lnhkaVRhFX0LLyYIlNVQBdmk
         4fnZieYU9xWYg1DHJvhxqERFQJ8qa5NyRt7GUBChzx7catx663lcJ122jLjrP9xgA7nQ
         +BbovMam6saAtXvq3YvJdEQHxKWoM7E3+1D5jG8r+5cKffOWJjY3DXFTjKceLbeRUPUU
         reVu0zaO3ekRUEwE9T/w1HGPF/X83p3roVUgFL7gy+86JC0fMxKE3AE2hkIloJsq6zCW
         DxiA==
X-Forwarded-Encrypted: i=1; AJvYcCVwc8SO6ftfNx4Jq3sqwux7lsRD9i4kypNxJNemz/NmyI91MnPGXeTRMc3B+uxyRJGb5aTjR51oNd7q/btuMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNc67eMt46PZeodBnSSeCMQFFCVZvL8ctEdLOLGKB8B14x4q5
	wiZUrOLA2dR+oDotTYoG/MTRq5Wjd068hz/CyqrC2oVNssXtLoXKvqk7+Ja+E0xNH0PyL1KR4yR
	MdpCbWBHMlEmlTZ/FGwsKN+lGJkzl06TGpRYPQQsBLfUHfZWTKN0AsWoU0J277bV6i9IZZxF3jX
	A=
X-Gm-Gg: ASbGncsGyASscI8rkwtqPAx8WzduyOuQo3NhTV2n4P7aIMFPusEos7VCqSBOOy9Fbld
	CV2ffdupyivmkT1JyurGSLE3G2JDJe0PeLdlWtQetwQchyg0hk6gBQ4XjTTbx7bG0vhfo4RmPJ/
	j5X1Iaw1YrWFxmar78BGxhuYYwx2pC8hZ3BEeWf/WxSnaZr/gAFGxmSynAsKLGzfSKXQgyufi7K
	2kaWmLiMJE6EzWb7LIoeorwVEWBWRPAtlLOEVZXTu8Vw07reZ0zAE0+pgcSaYXWR2xlRBnyJoLJ
	1E1OsbXW+pMMo7M=
X-Received: by 2002:a05:622a:15cf:b0:466:9197:b503 with SMTP id d75a77b69052e-46e12bb3aa3mr649444541cf.46.1738028789279;
        Mon, 27 Jan 2025 17:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu/Ildyvm3jCiRMBPCzyoL0jEC8ibzas6Hceg6HQjREFt+X4sxz4xMzDIPGICKsnaZlWq6cQ==
X-Received: by 2002:a05:622a:15cf:b0:466:9197:b503 with SMTP id d75a77b69052e-46e12bb3aa3mr649444291cf.46.1738028789005;
        Mon, 27 Jan 2025 17:46:29 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.51.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e6687f10dsm45570161cf.25.2025.01.27.17.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 17:46:28 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 0/2] Add cpupower idle-state functionality
Date: Mon, 27 Jan 2025 20:45:46 -0500
Message-ID: <20250128014551.15058-1-jwyatt@redhat.com>
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

John B. Wyatt IV (2):
  tuna: extract cpu and nics determination code into a utils.py file
  tuna: Add idle-state control functionality

 tuna-cmd.py      |  67 +++++++++-------
 tuna/cpupower.py | 202 +++++++++++++++++++++++++++++++++++++++++++++++
 tuna/utils.py    |  27 +++++++
 3 files changed, 267 insertions(+), 29 deletions(-)
 create mode 100755 tuna/cpupower.py
 create mode 100644 tuna/utils.py

-- 
2.48.1

