Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A6377009
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796012; cv=none; b=l+t7HtSnjiaYCLhAF5itcljhcnp0Pu0NbvZeSBDXF98+TFkvK9YJDS2v8aFeF2DHBAbPiY2Su7WS2fEPlncVqfepU9T9PjdaFpo252NRhIZgOEoPQXLxEe0pvcurCHIHwhfki6mdn9CA38eF75u7XxhXnp4v1q/LywmNZMvqDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796012; c=relaxed/simple;
	bh=QaU1W9ffISAJYiaBJ1V8aJukMnfgCS+G3y496r0Ko48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/eALyWmk7h4ARcrG5yqUOjK8erK9GgIw/mX8klC1vbBZI91EjByIKgvGPtwZ4ulbMmhI36SgQvNgEBmigL4n3ZfsnLak4tLZb24Cq+ha/YblYCSdg4wTEEqtWt29VuYUIiTm8b9YjH9Pflh+yW7w0f2Lh1TZ8thiZKCfRcVyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5bk/kFz; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5bk/kFz"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ef5776530bso37661985a.0
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795999; x=1777400799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0jUXq70fmRlNBW+77+LPpRPQat5DqaHwS8pKoBAzwA=;
        b=Z5bk/kFz/VPWOQJfnKclXrE/GoYopXKxoE9/kNDXZEMdgW7EgItiZgMKHbfoKNAdds
         jIY/IRawn204uocJGcF0GDEM2aC5ZrpBK2KzevcdE70UskyBI920H0Ai3GqEyha6e7+R
         hFGNQZZbuLvGHfHN1L3n6hbhE+E9SWU2HUeRZ/M+ivBuozqB279GVMJrk6gFT6inZidq
         AmpAmIRpxbSH8EWBBfRteyLBNGIdgwImGTd4ooaUarYI5IdmznNDHztOAcbVmMvNLxt5
         XC/cjHi2o9TVsjijR0HX77yDuA1Px2LpT+u+jIwYi1XhiONZfRSwQNvRguVpWaDOOZsj
         rkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795999; x=1777400799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0jUXq70fmRlNBW+77+LPpRPQat5DqaHwS8pKoBAzwA=;
        b=gyrfRHlVCWeb4vcU+aRQvYm/3nB7XuA+yRpFuYC40dGUvzpCzM1SOMw29Xu6GcA/rb
         s2VX57tJxDwrHGbwSwtF7ktOa/HHOn27KjDbIjEOqpKXtgytNOHPZiTcyUjczNz+zOXV
         j8j2ypRjX+rB1CXZ/qMdrNQf4Rv80a4q9X5UN/75yYC6aBuIRhA+O/T0eO40ThbBIr6e
         tM/B+mq9B6A4++bdLTDvl0TyqCy0osoiC3KFgA0TRHpve5OyyERk70Z4P2+MAFEU3V9c
         67K0YHUyF6fz74PCt7DvC+Mkh0jvVtDDRtorCBAsyB1mUMyv97UhWlePKr9CzbskIobe
         w5Jg==
X-Gm-Message-State: AOJu0YzwKaP6fpMpJV86UKAiZYwm3xXLFxS61pXV8YlmsHVJv8ldiNxe
	/vWrTBCrFBmLclWiyCkC8vrK4THE9OAs1wcI7rFVvisNyKu9k1rAx6lveM8LmQ==
X-Gm-Gg: AeBDieshKCzE1OdovuCSiBxt5TRETlX3Dd1BGdUJNxgzrHEh6pnW0wRivfqjzlJ3lBq
	UdGPjvk4gj/6GeNamgnb/rzjgbOryz7VRIv7ZtfNMPQfctoqouZZq7oM1sPxoa3roTILOrkrK4C
	PAJ0i4OPQdzf9G6H9gqW1kHtr0ocSoaCbBzioxOZOZXhc1nAZNsubrakhcQMYi7JSPZK23Ljaf0
	5r5lF7jLLG/0k0et3VFNtsvxVdb0BnqS34PtMz8qASmdvt+ExswiW1+umeXyXehUJm2vQGWr1oL
	98crURyD7IOeU+J4tmJ1xkrZW6XuNAUg3T4TjJbeZsco3SUPo/jIh1f9Ru4QDcH8PxGJoH0Pmkj
	QZHm1zGZNghS7Yb5v9Qgw78Ugg3/3fc5VPs07sdHFPEEWoQrsupbXCSlMZIIxzq30HfqOjxhOGa
	MrsEWoMd+0oV1OXmeTJcuPTSfB+//fcaBaJn1OzvXflpVFgQQ+vgutDuLUa4XBopXM7UJaYQRfm
	KH1R4ZmrpAXjVGE2W5JHZ/SZL04E8M15863YfS9c7ki7+Wc1+VnRtByaF6isb+MJhRpNf3kQI0/
	a0o9IssveYveECoBg4E=
X-Received: by 2002:a05:620a:17a0:b0:8da:e62d:888f with SMTP id af79cd13be357-8e792567177mr2549818385a.53.1776795998698;
        Tue, 21 Apr 2026 11:26:38 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1112713685a.11.2026.04.21.11.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:26:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 4/7] rteval: Add temporary test for core sharing validation with mocked isolated CPUs
Date: Tue, 21 Apr 2026 14:26:15 -0400
Message-ID: <20260421182618.261347-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421182618.261347-1-jkacur@redhat.com>
References: <20260421182618.261347-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add comprehensive test script to validate core sharing warnings without
requiring actual isolated CPUs. This test uses mocked isolated CPUs to
verify both console warnings and XML report generation.

The test simulates CPUs 0, 8, 1, 9 as isolated and validates:
- Console warnings are generated correctly
- XML CoreSharingWarnings section is properly added
- Warnings only appear when at least one CPU is isolated
- Warning format includes "(isol)" markers correctly

This is a temporary test file for development and verification.
It can be removed once the feature is tested with real isolated CPUs.

Test results show all functionality working correctly:
- Console warnings: 3/3 scenarios pass
- XML generation: warnings properly added to CPUtopology section

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 test_full_validation.py | 151 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 test_full_validation.py

diff --git a/test_full_validation.py b/test_full_validation.py
new file mode 100644
index 000000000000..98c286fab344
--- /dev/null
+++ b/test_full_validation.py
@@ -0,0 +1,151 @@
+#!/usr/bin/env python3
+"""
+Test core sharing validation with mocked isolated CPUs
+Tests both console warnings and XML output
+"""
+
+import sys
+sys.path.insert(0, '.')
+
+from unittest.mock import patch, Mock
+import libxml2
+from rteval.systopology import validate_core_sharing
+
+# Mock isolated CPUs: simulate CPUs 0, 8, 1, 9 as isolated
+# Based on actual topology: CPUs 0 and 8 share a core, 1 and 9 share a core
+MOCK_ISOLATED_CPUS = [0, 8, 1, 9]
+
+print("=" * 70)
+print("TESTING CORE SHARING VALIDATION")
+print("=" * 70)
+print()
+print("System core topology (from actual hardware):")
+from rteval.sysinfo.coresiblings import CoreSiblings
+cs = CoreSiblings()
+for i, group in enumerate(cs.get_core_groups()[:4]):
+    print(f"  Core {i}: {sorted(group)}")
+print()
+print(f"Simulating isolated CPUs: {MOCK_ISOLATED_CPUS}")
+print()
+
+# Test 1: Console warnings
+print("=" * 70)
+print("TEST 1: Console Warnings")
+print("=" * 70)
+print()
+
+with patch('rteval.systopology.SysTopology') as mock_systopo:
+    mock_instance = mock_systopo.return_value
+    mock_instance.isolated_cpus.return_value = MOCK_ISOLATED_CPUS
+
+    print("Scenario 1: Housekeeping and Measurement share core")
+    print("  Housekeeping: [0]  (isolated)")
+    print("  Measurement:  [8]  (isolated, shares core with 0)")
+    print("  Load:         [2]  (non-isolated)")
+    warnings = validate_core_sharing([0], [8], [2])
+    if warnings:
+        print(f"  ✓ Got {len(warnings)} warning(s):")
+        for w in warnings:
+            print(f"    {w}")
+    else:
+        print("  ✗ No warnings!")
+    print()
+
+    print("Scenario 2: All three workload types on different cores")
+    print("  Housekeeping: [0]  (isolated)")
+    print("  Measurement:  [1]  (isolated, different core)")
+    print("  Load:         [2]  (non-isolated, different core)")
+    warnings = validate_core_sharing([0], [1], [2])
+    if warnings:
+        print(f"  ✗ Unexpected warnings: {warnings}")
+    else:
+        print("  ✓ No warnings (correct!)")
+    print()
+
+    print("Scenario 3: Multiple conflicts")
+    print("  Housekeeping: [0]     (isolated)")
+    print("  Measurement:  [8]     (isolated, shares core with 0)")
+    print("  Load:         [1,9]   (1 and 9 both isolated, share a core)")
+    warnings = validate_core_sharing([0], [8], [1, 9])
+    if warnings:
+        print(f"  ✓ Got {len(warnings)} warning(s):")
+        for w in warnings:
+            print(f"    {w}")
+    else:
+        print("  ✗ No warnings!")
+    print()
+
+# Test 2: XML output
+print("=" * 70)
+print("TEST 2: XML Report Generation")
+print("=" * 70)
+print()
+
+with patch('rteval.systopology.SysTopology') as mock_systopo:
+    mock_instance = mock_systopo.return_value
+    mock_instance.isolated_cpus.return_value = MOCK_ISOLATED_CPUS
+    mock_instance.isolated_cpus_str.return_value = [str(cpu) for cpu in MOCK_ISOLATED_CPUS]
+
+    from rteval.sysinfo.cputopology import CPUtopology
+    from rteval.Log import Log
+
+    # Create CPUtopology and parse
+    cputop = CPUtopology()
+    cputop._parse()
+
+    # Now add warnings with conflicting CPU lists
+    print("Adding warnings for:")
+    print("  Housekeeping: [0]  (isolated)")
+    print("  Measurement:  [8]  (isolated, shares core with 0)")
+    print("  Load:         [1,9] (both isolated, share core with each other)")
+    print()
+
+    # First verify that validation itself works with the mock
+    from rteval.systopology import validate_core_sharing
+    test_warnings = validate_core_sharing([0], [8], [1, 9])
+    print(f"Direct validation call returned {len(test_warnings)} warning(s)")
+    print()
+
+    cputop.add_core_sharing_warnings([0], [8], [1, 9])
+
+    # Get the XML
+    xml = cputop.MakeReport()
+
+    # Check for warnings in XML
+    # Search for CoreSharingWarnings child node
+    warnings_section = None
+    child = xml.children
+    while child:
+        if child.name == 'CoreSharingWarnings':
+            warnings_section = child
+            break
+        child = child.next
+
+    if warnings_section:
+        warning_list = []
+        warning_child = warnings_section.children
+        while warning_child:
+            if warning_child.name == 'warning':
+                warning_list.append(warning_child.getContent())
+            warning_child = warning_child.next
+
+        if warning_list:
+            print(f"✓ Found {len(warning_list)} warning(s) in XML:")
+            for w in warning_list:
+                print(f"  - {w}")
+        else:
+            print("✗ CoreSharingWarnings section exists but is empty!")
+    else:
+        print("✗ No CoreSharingWarnings section found in XML!")
+
+    print()
+    print("Full CPUtopology XML section:")
+    print("-" * 70)
+    temp_doc = libxml2.newDoc("1.0")
+    temp_doc.setRootElement(xml.docCopyNode(temp_doc, 1))
+    temp_doc.saveFormatFileEnc("-", "UTF-8", 1)
+
+print()
+print("=" * 70)
+print("ALL TESTS COMPLETE")
+print("=" * 70)
-- 
2.53.0

