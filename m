Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AF46AF02
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627463; cv=none; b=GTYpUrhX0QLJWsVtO6g9eYNeE++JmGAYEYKlowVc0t90RjNqYaG7Xvc8QuAqbY4xaewU7m4v+dDdDrob+yJRKfn4FbqT+dE6K+QdL3d+b9CgOUvW9j2cwukjH/o2ueOmHs45azc5meXaG9wLtxLQgEcWKJC+Z1GtVTsO7tKpObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627463; c=relaxed/simple;
	bh=efDWY5SnjZ4E/M5hE4GzwaOQiwmepMquI9VkxoDQV1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fhSWcaSFwPfvrg/ioE8UCFHS9K6bgMxNJIIPO9acK3caLsTmpgl2grXjT9/E3ZLvwzvbBK9cUvAwQiDDKzmOUrmN4ivdpmRDKz+pgnZAs5kXan4niDhnnekGuMMExXIFcboHS080qXLPFRymvwCGhsF65LK51q2i+GS/hsnR+/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkYNTWSG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkYNTWSG"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8db4b249ebfso2454556d6.2
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781627462; x=1782232262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dIvrpljWMz1q4ijz7hrwcWrJI8VtpUCYwNKq3FPUDvw=;
        b=YkYNTWSG/kuE9tM1u+vOZFEVrf89STta21ANwMPwsVcHb8vRmI/jh3tIyXBA2ArwNj
         MjDWQa4IhK54JlsNyeccx7bvThVMOUVc0nJc95x00UgN1LjdbJkL0XXlCdkbhUZQ3goC
         iJeRKWgP3E3HC7a5W2ZmnsygjwDYCd4PcQf9C+1c9ybhAGM+JaiHcr9FOAON+KbtNkYS
         vhoYnvtdJ6Db73eBMP6pIteTdBDPu1SEGPOY2diR2704fEbSooAx0xUqOlfiPkocF0pN
         R+j/jn7YDVuLpSG/55isr2gU4dH6xapoth78u90NIB2JS4bNkC033KwxXw+9oKDzNjb7
         7vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781627462; x=1782232262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIvrpljWMz1q4ijz7hrwcWrJI8VtpUCYwNKq3FPUDvw=;
        b=oYRma0j5gFC+xem3+Vic8v6ceVGviu5vnkNuzFCjadva2f2BOzgE9lhPPIBgDnsizL
         A73L25d14l0aDm6Mc03LljqELOVaEuguB9+GiSwnT+Lyla0T5Umc7dAwp4uG+Yo/kbbJ
         8rvcyj8YjtpXvcYiXoUH6ozrr7P0b6TmtWAkmtrqg5AxBA7S01x85A9ErSwoJoXhvzw0
         0D/CeZ339PJBS8VtV7Z8V3bXGSws6OxNSGG2XizzQhkifekkQ/x6acbgFqOjelyOty2V
         MIxnHV1HDmbuuThuNlgx1tMqWPXfAaRplM9SVkTKC7GoJ5ZxOBra/vLfcnX4nzR60GC4
         iupA==
X-Gm-Message-State: AOJu0Yxrqm7Q8PrLAQcl3MP5PGIxbwCZ8WZiSwVZiqJZ0UH1JnHde0ry
	SgQNDP4OBt9MGHxnzS7xYOBjXgP57/RY2Q4hJmS2hJ54kaVlScYGCczhJPRQRQ==
X-Gm-Gg: Acq92OEn9zbk6r3lzrrnym4bEH9qSBCEPHx+75xuAF84LLGWJmgZXcoqH37/kmGXoTl
	g/e6UbggpJeKI4irtEkfH5gpKB9GE2VBWvFBCODj9IK+m/CDk6wx3x4/4l5DQyTx5RBWdPPpSJy
	mNo+Av9sjXiCL9o7CRTBUgztc+/FaKnre2LkoSoVYxBhlLSp1lakmmhE7aWTpxonlN65AYkKDJ+
	MEdu0csuxqzuOXKk+Jj7JuZk+I4WvgN0lGh5ZMm4STV0O0YtmntdU2KTU+20Uv4vFoEXtDOoypi
	er1/U/R4GC+3gEFYCfAPIBFpBiEy9A24cfx/pIR4fo7cpifaL5CTY2Ge6auXG45pYsjgSGsWVUT
	3/gmEjT2I/ROXEzDf65CyTisgyEW8iiOF9XNKfGpZWOdu4BhmJXT4BFwF76usDh5lUeV5TUV9lR
	GDFCsdGCmK/Z0+f3Qvo3KGxZBdARKmsCo6CK0XY6qK3IL6osQDywsZ0c0CgVZZACU3wEFTfWX/N
	7yBRyb2kyX4j+jZPLs=
X-Received: by 2002:ac8:5748:0:b0:517:29b1:5433 with SMTP id d75a77b69052e-519a8e1068dmr3411561cf.24.1781627448142;
        Tue, 16 Jun 2026 09:30:48 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb815976sm143761731cf.25.2026.06.16.09.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:30:43 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 0/3] Container detection and AGENTS.md documentation
Date: Tue, 16 Jun 2026 12:30:12 -0400
Message-ID: <20260616163024.233604-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds container environment detection to rteval and includes
documentation for AI coding assistants.

Patches 1-2 add container detection functionality that warns users when
running rteval inside containers (Docker, Podman, LXC, systemd-nspawn,
Kubernetes). This is important because latency measurements in containerized
environments may not accurately reflect bare-metal real-time performance.

Patch 3 adds AGENTS.md, a comprehensive guide for AI coding assistants
working with the rteval codebase, documenting architecture, conventions,
and development workflows.

John Kacur (3):
  rteval: Add container detection module
  rteval: Add container detection and warning
  rteval: Add AGENTS.md guide for AI coding assistants

 AGENTS.md                        | 466 +++++++++++++++++++++++++++++++
 rteval-cmd                       |   5 +
 rteval/rteval_text.xsl           |   4 +
 rteval/sysinfo/__init__.py       |   5 +-
 rteval/sysinfo/containercheck.py |  92 ++++++
 5 files changed, 571 insertions(+), 1 deletion(-)
 create mode 100644 AGENTS.md
 create mode 100644 rteval/sysinfo/containercheck.py

-- 
2.54.0

