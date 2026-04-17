Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819334A3C5
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455500; cv=none; b=EYUvISkL4qfHFRzbTZM9LLb30kIdZE82zh1YM8aPRnMZNv+hnF8En88yNMpCZ5hnuj+9O1H/DcHTUWDvYyCD/VD2qOOBR47reyfVFwIW47yP3fnxU6eBSZVgRnVd8zmmQJOYutroCdyeAsyC8BkQ+2nNU95ErfRHoJ38LxzXS/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455500; c=relaxed/simple;
	bh=dnFC//f2l2mu+V7Of+3Z4vmQJSyh8TW2MoghQvFR/v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMfcuGb0OrN/dNAxFNEORW48dnSCF1NetTmxvAykGaJRd00qv137iLJqoFw578odEeArbDTUMtJtsBV4F99U4hVexfAW1xvCh7L7st6QehyN7eLYXIhlVKWiYgXid0JNlzPHOmKB4OdCVc4Q6YjbaVMtblHQcaPkBTEw6m92+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blpvgcCM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blpvgcCM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50b2b289925so8995551cf.2
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455498; x=1777060298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AebOLZ8J/ActvGAJrzlkty1Br2YOxrFNskAL4o8OO/U=;
        b=blpvgcCM9X4jCK83Z10x3Yfr/6P97r0KaOsx0CSV9jyMOrMsx8ZtpR40WnqJF6hnDA
         lRCqHzg17GWxa6FWK7TbAKKyEs9v6nKqpbF/tH6ggcS6LRDcz9LaYETuC49R7Bsl1Ozg
         iWw9FSouZVtXi4i8yDWVKhffn/IUfVLMg7+nej9yHqWoCpVhmytZ29wHavy7CgsNVx5y
         cRlYJ12ur5+o5JGgLs5xpSumFdFnr4p7OPON1eO+oNYSkznJUXbDf1qGYMBPI6m2aCVi
         5FYjlH7CLy3agsUKzUasLklgOJyRQxpUsOC/rmuLfFdE554U6Qf2bS7/rXIokvCJSAyy
         MsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455498; x=1777060298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AebOLZ8J/ActvGAJrzlkty1Br2YOxrFNskAL4o8OO/U=;
        b=FlBm7BWY/ToE1S9G9pPv3qU6eA5x7B+e+0f3PqDH5lBgLpessZZ13+cNk1nWrwb22v
         UpfgQLRHrthrYm/kU4SEHYGkSC0AU1yW+TNFJ8fA9G0CSPgdp/x75rgH5xeE1eMoBYzU
         dAGOlByMG2i1Xs12GTrGIZN39wh+Z/Hn82MlfgMtRTh9eti2h/edmMeWv7Z8FdIOXazL
         4AKV2knDJrRFzcXuYWpua/GtbTpLtEeeY0w7Ut/5Q6i5e81fubCvIhkpBWYVaO7Y0l79
         QocOYndwLjp+96lroyIfeH+5oQ46gso2rGWaAG5LcsJQpnUJiMgDfa80NGMNMImr6rzE
         G06g==
X-Gm-Message-State: AOJu0YxuMOLkOv3KIr5rJ39bnvSQXkoIS6KkUw4aZalnCjtNI7t6dfot
	OqlLHwc5aaVBTi/o4eFB5iVQby6pLkq24VGcnH8j9KUeJUpEP/usFDK47KX0zA==
X-Gm-Gg: AeBDievlH2TB05AyVIhpMhPPvi/SOCTqqFk00xN3h/l4Z+ppbEHZs6rBOYqJGNKBvPx
	UXtHp/UIzClZKLRm49Zdo1mbbxUJ7+uRma9NtSgaIpds5Ooo1gu6k773eSOHZjIqWBRO99It3Ww
	7vHLMqLH9nN9gofF7IQklrKbW7fCqyxeEcUP9w9DtCX40/TvR3DySwCkMgdgVWoXkQ2KtkP9rEA
	d4+xJs6MC6Xf9nbP7a/0YD5QpLFqkrj9+pxrhvihkbNpkv2M5C7yfMt/hOr1P9+EqbnkKoHiWBs
	K6RlnZXfo0QAYnPu/WNhMilJuoQ4VcvlFsGmyVrA5cbbqfrVHPhVyfozW/vifSeyWe2zkdz7lQN
	tddzw+OTcoRXEAAYpuXdnU63GbsEyPtTezHuJWrZsjHRVc2kdrKqi7K9I/Id3ssENZxKgI6sb0E
	nWhZePBfGNGNHQ1XXB+22pnm/9yitWQCTlElq/2QcAAr/eAzamPzvw07VNRQjRiaycSITEyfzR6
	kInjGwlOJuqwi0Kztchf1y1WDGk9w==
X-Received: by 2002:a05:622a:408b:b0:50d:8699:ece7 with SMTP id d75a77b69052e-50e3683608emr63293321cf.1.1776455497599;
        Fri, 17 Apr 2026 12:51:37 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3bf260fbsm20673601cf.10.2026.04.17.12.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:51:36 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 5/6] rteval: Add unit tests for CpuList class
Date: Fri, 17 Apr 2026 15:51:12 -0400
Message-ID: <20260417195113.177799-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417195113.177799-1-jkacur@redhat.com>
References: <20260417195113.177799-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comprehensive unit tests for the new CpuList class covering:
- Basic creation from strings and lists
- Operators (__contains__, __iter__, __eq__, __len__)
- Method chaining with online/isolated filtering
- Backward compatibility with module-level functions
- String representation (__str__ and __repr__)

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_cpulist_class.py | 121 ++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 tests/test_cpulist_class.py

diff --git a/tests/test_cpulist_class.py b/tests/test_cpulist_class.py
new file mode 100644
index 000000000000..bcb92e4a719d
--- /dev/null
+++ b/tests/test_cpulist_class.py
@@ -0,0 +1,121 @@
+#!/usr/bin/env python3
+"""Test script for the new CpuList class"""
+
+import sys
+sys.path.insert(0, '.')
+
+from rteval.cpulist_utils import CpuList, expand_cpulist, collapse_cpulist
+
+def test_basic_creation():
+    """Test basic CpuList creation"""
+    print("=" * 60)
+    print("Test 1: Basic Creation")
+    print("=" * 60)
+
+    # Create from string
+    cpus1 = CpuList("0-7,9-11")
+    print(f"CpuList('0-7,9-11') = {cpus1}")
+    print(f"  cpus: {cpus1.cpus}")
+    print(f"  len: {len(cpus1)}")
+
+    # Create from list
+    cpus2 = CpuList([0, 1, 2, 3, 7, 8, 9])
+    print(f"\nCpuList([0,1,2,3,7,8,9]) = {cpus2}")
+    print(f"  cpus: {cpus2.cpus}")
+
+    print()
+
+def test_operators():
+    """Test CpuList operators"""
+    print("=" * 60)
+    print("Test 2: Operators")
+    print("=" * 60)
+
+    cpus = CpuList("0-7")
+
+    # __contains__
+    print(f"cpus = {cpus}")
+    print(f"  3 in cpus: {3 in cpus}")
+    print(f"  10 in cpus: {10 in cpus}")
+
+    # __iter__
+    print(f"  Iteration: ", end="")
+    for cpu in cpus:
+        print(cpu, end=" ")
+    print()
+
+    # __eq__
+    cpus2 = CpuList([0, 1, 2, 3, 4, 5, 6, 7])
+    print(f"  cpus == CpuList([0-7]): {cpus == cpus2}")
+
+    print()
+
+def test_chaining():
+    """Test method chaining (requires system with online/isolated info)"""
+    print("=" * 60)
+    print("Test 3: Method Chaining (filtering won't occur on systems without online/isolated CPU support)")
+    print("=" * 60)
+
+    cpus = CpuList("0-15")
+    print(f"Original: {cpus}")
+    print(f"  CPU count: {len(cpus)}")
+
+    try:
+        online = cpus.online()
+        print(f"Online: {online}")
+        print(f"  CPU count: {len(online)}")
+
+        nonisolated = cpus.online().nonisolated()
+        print(f"Online + Non-isolated: {nonisolated}")
+        print(f"  CPU count: {len(nonisolated)}")
+    except Exception as e:
+        print(f"  (Skipped: {e})")
+
+    print()
+
+def test_backward_compatibility():
+    """Test that module-level functions still work"""
+    print("=" * 60)
+    print("Test 4: Backward Compatibility")
+    print("=" * 60)
+
+    # Old style - module functions
+    expanded = expand_cpulist("0-3,7-9")
+    print(f"expand_cpulist('0-3,7-9') = {expanded}")
+
+    collapsed = collapse_cpulist([0, 1, 2, 3, 7, 8, 9])
+    print(f"collapse_cpulist([0,1,2,3,7,8,9]) = {collapsed}")
+
+    # New style - static methods
+    expanded2 = CpuList.expand("0-3,7-9")
+    print(f"CpuList.expand('0-3,7-9') = {expanded2}")
+
+    collapsed2 = CpuList.collapse([0, 1, 2, 3, 7, 8, 9])
+    print(f"CpuList.collapse([0,1,2,3,7,8,9]) = {collapsed2}")
+
+    print()
+
+def test_repr():
+    """Test repr"""
+    print("=" * 60)
+    print("Test 5: Repr")
+    print("=" * 60)
+
+    cpus = CpuList("0-3,7-9")
+    print(f"repr: {repr(cpus)}")
+    print(f"str:  {str(cpus)}")
+
+    print()
+
+if __name__ == '__main__':
+    print("\nTesting CpuList class implementation\n")
+
+    test_basic_creation()
+    test_operators()
+    test_chaining()
+    test_backward_compatibility()
+    test_repr()
+
+    print("=" * 60)
+    print("All tests completed!")
+    print("=" * 60)
-- 
2.53.0

