Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93933B6CF
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540041; cv=none; b=QenJpBg0DZK2WgosqB18Ial05BjDSyc/k+QCv8ceR6B9yUcKpY4vuifOi8tN7X8sv2VvF0u0D60uTi4t8OtiL5r2/0zr2WcbfAAiq6uMBTwHzx+iUYseBho3fES9pdyYbLf+ujN3C5kAgx2VBF6O8vTh0XT8VJlrYPfFIgMdcd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540041; c=relaxed/simple;
	bh=82u5uvQf7FnzfhBVZBDnloY2O887AwfyHZp3Qv8O3w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Astw7NpHYGDls2OZUOeA9KCR4XCBMXhqFlFzISPQIyBkE123+AwspKFNbLFmtYgBlHvXY+tJKNOjtJLjfxZmGZ7gKa01kdCpAaPBzTpXaLvgqXEfA6/rzrVCVTGE4+6k2bzqNN5J5cBnZrPoyKwwbW6ClJOAs21CIfP4uZK3zj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnivBJzo; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnivBJzo"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-891667bcd82so109534685a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540039; x=1763144839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap2QzIK0eVOddS3/A22CQkSrK7N+b00HEZb8iHAoUmk=;
        b=YnivBJzoWbiUrHdztdd3oUydynxaJW9nvu2Wyg5H0MsRomrmiVQr1rMEIy3+/LzVwH
         3KwS7jXlm3w9/P79JrHPmJkGMebIP8WHTy5ZyuduVMon493ItPfT6wdD+BriWpQl/sDl
         eVDVIuGBPDZh0FTquCdky0C7ie4hv5A1C0XErV3v+6N5SOhNaj0voT7vrTxZsexmlLFX
         T3JULdgsPox695/Cxk/QRAB56JZv38CNZndsNtT4F7+3FMLqINX/F5RzjiqmL999FJL3
         TTa3j/rZOz378DQe/fk9+m5C9Kej72OnQtNztsfYUJ0MePNfR38hTMe59YhDm90PNBZ2
         IBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540039; x=1763144839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap2QzIK0eVOddS3/A22CQkSrK7N+b00HEZb8iHAoUmk=;
        b=VY6UuENp9RKFTT/d1B9qMwoAJK6Ey4xd8ArwW+2UwCvyH5OgYc2qBXpkjZLoyDilwf
         iXa7GCXRGhVkwr8+mrDcoqWvKD/mlsa/Z1K3LYDpDiUXGlHCSDJNjNek+2DiE1UN1a78
         +ggZ2J/AGb9zy+iCPV4nN01UypoWUkBvgR55npWc/iiGCSlGkwBXjl9+a/WJZftkTPTP
         UssV6/9ui7brPaz9mG1EvJzByeugSyv6MmdieJfdU/Mxy77mMInN/qU4dyxtiSZrnO1P
         kQs8nIaQ0Pfb2o/ryf9L7jWvD8OPByDteWx7jJ9LSYTBgIhP3uQ0n0cUz46KNW/toF9O
         mUeA==
X-Gm-Message-State: AOJu0Yyt1X+OPwkHM1nmCqS14L7fQjcwCvvEKQ5tS3V6EWw4BRDs9nBV
	5oE7rlCluoMPqeySAHZ/Wcb0EFu2s71Pwe8wYwyHv0G1gCZBlD2oFDH+HVOUVzZx
X-Gm-Gg: ASbGncsrHbY9DAh4KEz5tamunDy3jslu2xEgFeO/ZNPg0/1EvfKQv/oZz2WnbsRE3Fh
	V0Z0oVMMKVi9vnIe084Sr8K+pzcAVnl4bSYNjw11n00jRNEr2qNRJmVC8nqTLzrK5cTKZ0xSA4U
	iKSmS7wMCyfi8qMiFBTIBBC4l52azNvsFlb9YbwG7IxZmZH3Jq+b7FKLyvcTbe8UqDmiPxpd/xC
	LqH3pz97DizBcRKuxSoBDPSEwvS1aU3gCSg+5cuk5RLhqW9qxRBvXptaB7s639C2dlWFvfxJS+d
	/O15ziyg3c6Riq+bStzSJVr/J5ifhhp3NwDXja4vT7qsNBl8mS4hOKWEZ2/WGGeTMNRInNv51Iv
	NKfwulC5tglsi4VmUyU/lWyag4mtwnqWoKlWseAO9UtZK5gn27sPLyT0Qs+k/pZ4=
X-Google-Smtp-Source: AGHT+IFq2E5fHvcnCfzqHTnAOEpjkERHswDOWUlmw+iAB3eY3bGE0Lg2HgFqZxqMmdmMcDZ4M30J6A==
X-Received: by 2002:a05:620a:4095:b0:8a3:a42e:6e14 with SMTP id af79cd13be357-8b24d6b146cmr348984285a.10.1762540038631;
        Fri, 07 Nov 2025 10:27:18 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:17 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 10/12] rteval: timerlat: Add dma_latency option with default value of 0
Date: Fri,  7 Nov 2025 13:26:33 -0500
Message-ID: <20251107182645.19545-11-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the rtla timerlat --dma-latency option to control
/dev/cpu_dma_latency settings. The option is enabled by default with
a value of 0 to help reduce latency by preventing deep CPU idle states.

Users can customize the value or disable the option entirely by setting
dma_latency to None in the configuration.

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 95fb7f136c25..1c7fb1607682 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -232,6 +232,12 @@ class Timerlat(rtevalModulePrototype):
         self.__cmd.append(f'-E{self.__buckets}')
         self.__cmd.append('--no-summary')
 
+        # Add dma-latency option if configured (default is 0)
+        # If dma_latency is explicitly set to None, don't pass the option to rtla
+        dma_latency = self.__cfg.setdefault('dma_latency', '0')
+        if dma_latency is not None and str(dma_latency).lower() != 'none':
+            self.__cmd.append(f'--dma-latency={dma_latency}')
+
         if self.__cfg.stoptrace:
             self.__cmd.append(f"-T{int(self.__cfg.stoptrace)}")
 
@@ -523,6 +529,9 @@ def ModuleParameters():
             "trace":    {"descr": "File to save trace to",
                          "default": None,
                          "metavar": "FILE" },
+            "dma_latency": {"descr": "Set /dev/cpu_dma_latency to USEC (set to None to disable)",
+                            "default": "0",
+                            "metavar": "USEC" },
            }
 
 def create(params, logger):
-- 
2.51.1

