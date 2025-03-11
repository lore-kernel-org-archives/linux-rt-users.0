Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2DA264A61
	for <linux-rt-users@vger.kernel.org>; Tue, 11 Mar 2025 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725043; cv=none; b=Ud3IMOExNR9mLeo51mpP1MVQw9mCDtfr7DUM38zy9hserrbwW6JbWLYw9NBbODrQRG4N7bv6mDqfXFxFTSqO5mOMigUBdysq87IEWwRp7v8xaBXjy7VIdcl7KBoieM7NnISZJ9+F2HQNUI56y8n30Ja7edfJH1gXcg4jO8Fmq4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725043; c=relaxed/simple;
	bh=u/tO2GJMu6V3UP4upkCTuhi0cI3qkf1vf4Vpx6fXrlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UAxx+fc28rPScRK1MDbqIqfwlhJg9VsN3I+HdhbvpCDcte6svhL4Tjoibjv2VsEHfovK+beNddQuTmEAObIH3v9zpCg4IAfKWsihjlrOa8/TjeF+Frbf+QOzfbGnX4r8cv/dVWnx7csuzOvbXiI/QHnrIfBNnZCMqTaNsNRPqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGzXYyhN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGzXYyhN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741725040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DUqN+B7AJnYcd5aRrl1ZJc+vbefVb6EZzaocHsVSCe0=;
	b=PGzXYyhNDsuQ3BiD1V5OVkZiZy368RSvqF5RMZdHNet4ZXv+ELZfrB948V55ZC87e9HzeL
	T3V71BsVgponBI/kpjxcq6PWxnasWN4T/nDCytXoZA4Hb6sQNU7WKEwMejyv/fP3p9Futg
	YLXCaAXM2ve57uqpOp17rPypT/ksZhU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-_UcObf9COoKERSlXyrXewQ-1; Tue, 11 Mar 2025 16:30:39 -0400
X-MC-Unique: _UcObf9COoKERSlXyrXewQ-1
X-Mimecast-MFC-AGG-ID: _UcObf9COoKERSlXyrXewQ_1741725039
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b7ee195bso1192273085a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 11 Mar 2025 13:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741725039; x=1742329839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUqN+B7AJnYcd5aRrl1ZJc+vbefVb6EZzaocHsVSCe0=;
        b=loVLJz96uvxD5CdG89et4jagMni0Go8AkSPjpSP3GMDDUsw31NVW2RyGEEKDUjUsKx
         7QD9vE61Z5QTpuy5VplMv4UYoxF6GWNeDvyHroG00CWg+sHJ5IqaJa0PdqTUc+IoOfsq
         xAzrdN/Q4eFfsEug4i8UnUCc+7H/c8Us6xHOBw8OqeteEBcbTIdXmAUOUhHXZKN43s5G
         3M4UiJdoxsrqD/+ztEzzZN4wWbZQ9BhGU0PC79B3oGxfT8wo9yjOYEp/glnH6mCez3Tl
         1SyoGS3WZcF3ui3NiuaoewN8DxU5bk0GcFzuV4N5gTxkbYLz+gSaZrKpSdx/J/owh9Q8
         r/0w==
X-Forwarded-Encrypted: i=1; AJvYcCUXZtG+8NgmI3keepz5ODjh49/CuPpne8l73p6LPmklYto+1wDGUvfxrMpRgstr8POv6Tj6jiS28tUK7pRWXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxguOVtV5vCqXrQYpxCAtuBmNV/rwfkV81gQjWYuxKJpr2yHgV1
	U58sSGmKtxXZOI3o7xkvmmT7EJJmXSdlfqnZFVdPor623Q9LLkqPGoRq5xDVc8MgHmPysc1ZBDd
	oDBZYtmr0PJnxX4W5lIRdccRZNFtFwRy/uNZ1Eryq839xEb1sXt9UE0TCb9dAftwg
X-Gm-Gg: ASbGncvIAx/scQGyWnHWdW2Jxq5f7Sl427803YHK9CQGJlRExSs6oJnaybJL4Wfc1vK
	0VUPGDRB2uxYiRd5WwM28egKij2qkYOK6iPRuuxHypbgkcugZ/pw1pb5zxzfAjyuUSgnIHIZW1Q
	FrHwQPLU5Rc0c7JTUGmEG3ZMyycM6l5iyDZNzMag03IcApvGAqglQ3CyJJxDXrxabGGOKtpzcl4
	p1x9BDNicjQwlzM0yjhtiU1BaDv4O1LWWktIla1WldaSBA2+Vn6WQwldTk5COeqPOzkRUXrmf4X
	0OjxnWxALaJ2J2rvuRBcFq93zg==
X-Received: by 2002:a05:620a:a503:b0:7c5:3b8d:9f36 with SMTP id af79cd13be357-7c53b8d9ff3mr1691045385a.24.1741725038973;
        Tue, 11 Mar 2025 13:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvBNPBhCzWrVZ4TK6EiRKxnDRfbGZATeokX5pdrWY7mzDIe12oqkFei5ROl4DQXAaTdw5CYQ==
X-Received: by 2002:a05:620a:a503:b0:7c5:3b8d:9f36 with SMTP id af79cd13be357-7c53b8d9ff3mr1691043085a.24.1741725038670;
        Tue, 11 Mar 2025 13:30:38 -0700 (PDT)
Received: from thinkpad2024.redhat.com ([71.217.65.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c555b74a32sm357658585a.19.2025.03.11.13.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:30:38 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: "Clark Williams" <williams@redhat.com>,
	"John Kacur" <jkacur@redhat.com>,
	"Crystal Wood" <crwood@redhat.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-rt-users@vger.kernel.org,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH v4 0/2] Add cpupower idle-state functionality
Date: Tue, 11 Mar 2025 16:30:17 -0400
Message-ID: <20250311203034.8065-1-jwyatt@redhat.com>
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
 tuna/cpupower.py | 184 +++++++++++++++++++++++++++++++++++++++++++++++
 tuna/utils.py    |  28 ++++++++
 3 files changed, 246 insertions(+), 30 deletions(-)
 create mode 100755 tuna/cpupower.py
 create mode 100644 tuna/utils.py

-- 
2.48.1

