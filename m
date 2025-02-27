Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B222577E
	for <linux-rt-users@vger.kernel.org>; Thu, 27 Feb 2025 20:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688911; cv=none; b=YjN3BEhWX8XItLFK6RsT8L2XXazcVwWJCDWvOWOBKwuwLBDj/WRVYbsJJ2bAeYjvvlXyTa7wxRAewPNyluGY5KDXxk1/mMiDsxxqYiBXOzdMoQMXs2vyFoza2yjm+U3562bPdo4+pJ1+p1m9w0OgxI2r35ZwZ1TNa/5doDBxx/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688911; c=relaxed/simple;
	bh=6LTxI8a3/d+OQjCxXu8wDP3vstpBq+nfEl028+NtUjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2+J1gpCwITsXH6iGcuqcjAIVFsdaTwlTU2DNS7kXWaZGy+Xgi61r1KNshsj7rRGzOfKQ80bDOgq020owMCsdM1e8RrlXbOK9g/MdzaDs7vQvr4cZpR0gFCNY5mJRR7csk32brYP4tkkR9NxVmI0EkfMyHKtIOyI/4npxo1jAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZyLh8aK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZyLh8aK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740688908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EabnsGltAahWOo/fKE7qu3HfRkovwzrofr/YQNrKPPg=;
	b=XZyLh8aKwwjYImAMc7vauqRUX+Awm67pXZdSNQx6Sjrcdzer/OZmxitZ/s54vLPrJyAVDp
	6P6ldmAzXYYJO1Hkq8FQFsoF4DKlzaoQ7EaAQGD16qpAb1gTuBndgK8CZqvZTS+g2ZxOtm
	cx7FmNeWvsMOu2917tWKzM8jy0DYtPY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-Tf73d-KaM82JmrDCi9awOg-1; Thu, 27 Feb 2025 15:41:46 -0500
X-MC-Unique: Tf73d-KaM82JmrDCi9awOg-1
X-Mimecast-MFC-AGG-ID: Tf73d-KaM82JmrDCi9awOg_1740688905
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-84cdae60616so144563339f.3
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Feb 2025 12:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688905; x=1741293705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EabnsGltAahWOo/fKE7qu3HfRkovwzrofr/YQNrKPPg=;
        b=YdJCCxF8fqq4r/898+/JMSwlGphUYkS5hOVqGvbLSRMUt9ZD6z/Iu0sjOQ2CjK4aRe
         X0jKNr2MyZscXEDna1j5Ed960aoiRMFcqyYOG0uzYsvfLmXZF6LVpGAVcC/wz6aDimho
         DbBwNE7Mg0CfexkOA1uBoybN2iRH5OjAzfMEZQ8brWu1Ayc2sZToaaugxUqWoeZREry3
         SW8rNEC+6At8QBQYtLy1mdxyb14OyJ3ouO3diXTTPNTWdmx4blBe91quhI8AnOsJ/Y63
         q+CuhE8uriwBn4Es4F2gfx8LrW0OYFgxRHYERBVAP1srV5AsZz149celMf39m2L0Szjf
         3JtA==
X-Forwarded-Encrypted: i=1; AJvYcCWJZfTK736aKmv8LKXGzFsK4VbzbvE2+9V7cb/z4aD7401IrFSNw7mERuzJGwVr/GYt+9xdRAhJxP4SlykTaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxixdQbqioWzvpQIekhF/ie/FDDtvCZQTXHAvNUMCi8rGBcuJJD
	wRCNvQMa1shUydWoIqHZb1oE7dzUAdVVgUYfM6h8zw4WA9NIFVrn7VJKCCH1LR9NbibEzdrHGaz
	wb0qThd0130f08jg8KPkVMSGWZ0MhnXpIoUj93cidNepQ6VgaT/P3TJ7bWCUa6Uc/
X-Gm-Gg: ASbGnctPI0ew0f6Qtbp9cckV5JUCO7OD6KrVaky86+OP7GcPQfGjTFN/Yc/5INeQIAH
	WXMRThEfIupnd2ZxMkZOQGu1nVQms4e8eI+2GeYDgtLEi2/gdpDtPY5Y3VFboI8+ospA5CBERak
	QYaZMWSIBJ8vCtQILoTZ1qKbroLiErrMXBNyGn6CY17y7Mu17zl8tInZNbAD3dnxGN6z1lKGOjq
	FZJi+AE85RKbwOA8jvOlOoMLBdrOkdOxzRVK8tg1e5t3q+nFGWDcfAg1xDtz6sONW8nYlgD8+7u
	aHgzGy2s69EPEuq9J2GUs38zGA==
X-Received: by 2002:a05:6602:1406:b0:855:ac69:32a4 with SMTP id ca18e2360f4ac-85881ef0c9amr49693639f.1.1740688905540;
        Thu, 27 Feb 2025 12:41:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8GiNmIeApPoK4VU8JTVIfe8jpxWZNRTAUxHcSa05pLOQ2ZDvhKrVAzVZ/iBDO4no6TC8h0g==
X-Received: by 2002:a05:6602:1406:b0:855:ac69:32a4 with SMTP id ca18e2360f4ac-85881ef0c9amr49691139f.1.1740688905215;
        Thu, 27 Feb 2025 12:41:45 -0800 (PST)
Received: from thinkpad2024.redhat.com ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85875130401sm46182339f.24.2025.02.27.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 12:41:44 -0800 (PST)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v2 0/2] Add cpupower idle-state functionality
Date: Thu, 27 Feb 2025 15:39:39 -0500
Message-ID: <20250227203944.23622-1-jwyatt@redhat.com>
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
  tuna: Add idle-state control functionality

 tuna-cmd.py      |  64 +++++++++--------
 tuna/cpupower.py | 184 +++++++++++++++++++++++++++++++++++++++++++++++
 tuna/utils.py    |  28 ++++++++
 3 files changed, 246 insertions(+), 30 deletions(-)
 create mode 100755 tuna/cpupower.py
 create mode 100644 tuna/utils.py

-- 
2.48.1

