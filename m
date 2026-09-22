Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E51560AA0
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 22:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116001; cv=none; b=Dg2zkx0N3AQPOmqQlq58gaEH4yY4FdU46KGYc3UzvxCCtmMyjtru0YdGhuNqW8zESeB8ThnT1Y4Chxci7vwNA+ZFDHSUzZctmIi9F682a/lnlG6Ms+84ZxQeblSqbne42n3+P5SFIE8cWB9eopUlrJOCaJiqlfbHJ3bRIrY5/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116001; c=relaxed/simple;
	bh=4FaFxVhdlGary6f0WRDGIzbCi3Vtcm6wUO6cHI+ZNs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKKKhvwdgJWfeJrb+wAlnuTDlRZN1KZSkc6Y8DCJxDot0VYq3ONyvOCD3LNMG/bhP10eja2UnctkTzjcx/VBxxjoUTnKgPhzeWBnh5C7AVQ14lyl3YIU2V5eWX8mUOs1CHG8ldBZON7iYYPaKf3CxeAit+TUkINcyPIXvkpplBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euNgRwxd; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euNgRwxd"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939656ff6d9so35250285a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115989; x=1790720789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wx/Pa6a0/yn34THwrihODC97uBQVK1CodGfyrt1CYDI=;
        b=euNgRwxdfog81jPfExnnqWqf0GMPssRX+xaD/eqDtoS+tWi2HChN6SKx2Mwyee0ykW
         wEa43bY5+sYV0r298a1M537/Mdcwe3Xyj58QPZWbmca3EP1s4Ya6rLnd73hR8rUEtqar
         PIvNxc9ja0588LHvFkxJkSDtsvS4xg141qHUK8YH/RL4kMcmcsgfl/4r8O9Y/7ZUk0VD
         KyAtKF8plWimn2Gpv57upSLKDqYBCalHyc2whFYxIbR0eHPLRYcDy2fNYQtwp81YsKgP
         t3EkgflTuG9fi9gWn6riXrX26GTORutSnNt1Qn12L6xMA3kaKm9GgShRtNB21QCLaPTj
         on0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115989; x=1790720789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wx/Pa6a0/yn34THwrihODC97uBQVK1CodGfyrt1CYDI=;
        b=d5IuRKo+sg3K0ykUWKydFZ6jOcbT7vz/37hUJ5Q6iNZ4kKK8yxikeSRk0JMQlSrA4U
         DppUEmy3sgdfDycVIndnVJ2+GUCI+juHbeBHwb7Cz6CSC972nxzPIxKe+hh0nnrBGLwq
         sa/uBJzQEVLG9Y1tJXhCtI/rYXBJADrYcdg7zPcDenq1TOBOR/MkYmICi0eUWLfNhCEW
         +Zj2OjKi3MaRly6tBBhdOxeh105IrhjtFlMc22MvorAqOt/ngK9aYmRtFeWmRG6Z9pwc
         KtyAMgMuWac583Vsp9pc2+gJltk/c8NNe3pciKyRYjm5Jn4sI38Q574D9yiGziLqGRL0
         c9/w==
X-Gm-Message-State: AFuF++ntZVoyKs6+iCB4x8FjgRatb+ZNGiFuDNtb1TQ6L0yUmzhKERCJ
	DeKH/ehqYoWftRjHegyQ3xgr+jpmbFKl8VbxEamBEa9OvQCwlFAcp8dpkEWiOw==
X-Gm-Gg: AYBFou248uGEFbz170MVX6mwz7pHpoNe6eAYX+ZJtc3z+J9m6/PVLSVbMKHKr6UtOxU
	D9XYqGaeuiduZS363WMk7NDHMDkZYC4MTdHurmbUqMMC8kIOs6RoZo4ALSlfnsnK6zwunyjkMTw
	IPogICVpLbAEF5VNSP7XVNH8Br0oSjh6lxIYMVVPkfTpHCjCtoHaykxxYTyxUsa1WcmJaPwpIh8
	82C5IMiqwd1ZwEzyV9exHM/XbbjSs75Y4I5F8Sy21vmixYlmf2gYhApCLcA4K6lYyVNbN6ZMmRl
	AmtZFKvGHF0DiFWwzKrTyGnNqJcyAB7LaiWMFnDlqhWO/WtpNU74+AAybcrhCbcs7l/xtRAyL8L
	UleT1d7XCrO8oqE0NYqyPyVQSggc/O/CmSJM69RbeGWbgQMPScTsmlUdR6/K4EJPKKg7niFk68G
	bT0o7FtG2YzkgXevY96tBW4QiblxV2qf32ipNDvGLghb3ATRybHcLZCrvvZ+RFNv4vSnTdpOrRY
	YFtzfPS/6kXkBquwGv8/CzA7lBVsy2uQ5XqhQ+sr2YhIRxKzaZsi1xlgnlHMSNccQ==
X-Received: by 2002:a05:620a:8810:b0:939:9edf:edb7 with SMTP id af79cd13be357-93c2509c8a2mr133898585a.6.1790115988905;
        Tue, 22 Sep 2026 15:26:28 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4425f3sm7552786d6.34.2026.09.22.15.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:26:28 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 1/8] rteval: Add CpuList intersection/difference helpers
Date: Tue, 22 Sep 2026 18:25:45 -0400
Message-ID: <20260922222552.482102-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922222552.482102-1-jkacur@redhat.com>
References: <20260922222552.482102-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CpuList class exposed filtering helpers (online, isolated,
nonisolated) but no set operations, so callers computed CPU-list
intersections and differences ad-hoc with raw list comprehensions.

Add chainable intersection() and difference() methods to CpuList,
each accepting either a CpuList or a plain list and returning a new
CpuList. This gives one reusable, tested place for CPU-list set logic
instead of scattering the same comprehensions across the code base.

Refactor the housekeeping-vs-measurement/load conflict checks and the
housekeeping filtering in rteval-cmd to use the new methods. This is
behavior-preserving: the conflict messages render the same collapsed
CPU string, and the filtered lists are identical.

Add unit tests for the new methods to tests/test_cpulist_class.py.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                  | 13 ++++----
 rteval/cpulist_utils.py     | 26 ++++++++++++++++
 tests/test_cpulist_class.py | 60 +++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 69fad2cc80e4..438ead95f843 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -448,30 +448,31 @@ if __name__ == '__main__':
 
         # Check for conflicts between housekeeping and measurement/load cpulists
         if housekeeping_cpus:
+            housekeeping = CpuList(housekeeping_cpus)
             msrcfg_cpus = CpuList(msrcfg.cpulist).cpus if msrcfg.cpulist else []
             ldcfg_cpus = CpuList(ldcfg.cpulist).cpus if ldcfg.cpulist else []
 
             # Check measurement conflicts
             if msrcfg_cpulist_present:
-                conflicts = [cpu for cpu in housekeeping_cpus if cpu in msrcfg_cpus]
+                conflicts = housekeeping.intersection(msrcfg_cpus)
                 if conflicts:
                     raise RuntimeError(
-                        f"Housekeeping CPUs {collapse_cpulist(conflicts)} conflict with "
+                        f"Housekeeping CPUs {conflicts} conflict with "
                         f"--measurement-cpulist {msrcfg.cpulist}"
                     )
 
             # Check load conflicts
             if ldcfg_cpulist_present:
-                conflicts = [cpu for cpu in housekeeping_cpus if cpu in ldcfg_cpus]
+                conflicts = housekeeping.intersection(ldcfg_cpus)
                 if conflicts:
                     raise RuntimeError(
-                        f"Housekeeping CPUs {collapse_cpulist(conflicts)} conflict with "
+                        f"Housekeeping CPUs {conflicts} conflict with "
                         f"--loads-cpulist {ldcfg.cpulist}"
                     )
 
             # Filter out housekeeping CPUs from measurement and load lists
-            msrcfg_cpus = [cpu for cpu in msrcfg_cpus if cpu not in housekeeping_cpus]
-            ldcfg_cpus = [cpu for cpu in ldcfg_cpus if cpu not in housekeeping_cpus]
+            msrcfg_cpus = CpuList(msrcfg_cpus).difference(housekeeping).cpus
+            ldcfg_cpus = CpuList(ldcfg_cpus).difference(housekeeping).cpus
             msrcfg.cpulist = collapse_cpulist(msrcfg_cpus) if msrcfg_cpus else ""
             ldcfg.cpulist = collapse_cpulist(ldcfg_cpus) if ldcfg_cpus else ""
 
diff --git a/rteval/cpulist_utils.py b/rteval/cpulist_utils.py
index ac91651b1d9f..859ed56381e7 100644
--- a/rteval/cpulist_utils.py
+++ b/rteval/cpulist_utils.py
@@ -111,6 +111,32 @@ class CpuList:
         """
         return CpuList(nonisolated_cpulist(self._cpus))
 
+    def intersection(self, other):
+        """
+        Return a new CpuList of CPUs present in both this list and other.
+
+        Args:
+            other: A CpuList or a list of CPU numbers
+
+        Returns:
+            CpuList: New instance with the CPUs common to both
+        """
+        other_cpus = other.cpus if isinstance(other, CpuList) else [int(cpu) for cpu in other]
+        return CpuList(list(set(self._cpus) & set(other_cpus)))
+
+    def difference(self, other):
+        """
+        Return a new CpuList of CPUs in this list but not in other.
+
+        Args:
+            other: A CpuList or a list of CPU numbers
+
+        Returns:
+            CpuList: New instance with this list's CPUs minus other's
+        """
+        other_cpus = other.cpus if isinstance(other, CpuList) else [int(cpu) for cpu in other]
+        return CpuList(list(set(self._cpus) - set(other_cpus)))
+
     def __str__(self):
         """Return collapsed string representation (e.g., '0-7,9-11')"""
         return collapse_cpulist(self._cpus)
diff --git a/tests/test_cpulist_class.py b/tests/test_cpulist_class.py
index c16934077052..8e2ef0122f26 100644
--- a/tests/test_cpulist_class.py
+++ b/tests/test_cpulist_class.py
@@ -109,6 +109,64 @@ def test_repr():
 
     print()
 
+def test_intersection():
+    """Test CpuList.intersection()"""
+    print("=" * 60)
+    print("Test 6: Intersection")
+    print("=" * 60)
+
+    a = CpuList("0-7")
+
+    # Overlap with another CpuList
+    result = a.intersection(CpuList("4-11"))
+    print(f"CpuList('0-7').intersection(CpuList('4-11')) = {result}")
+    assert result == CpuList("4-7"), result
+    assert isinstance(result, CpuList)
+
+    # Overlap with a plain list
+    result = a.intersection([4, 5, 6, 7, 20])
+    print(f"CpuList('0-7').intersection([4,5,6,7,20]) = {result}")
+    assert result == CpuList([4, 5, 6, 7]), result
+
+    # Disjoint -> empty
+    result = a.intersection(CpuList("8-11"))
+    print(f"CpuList('0-7').intersection(CpuList('8-11')) = {result} (len {len(result)})")
+    assert len(result) == 0
+
+    # Original is unchanged
+    assert a == CpuList("0-7")
+
+    print()
+
+def test_difference():
+    """Test CpuList.difference()"""
+    print("=" * 60)
+    print("Test 7: Difference")
+    print("=" * 60)
+
+    a = CpuList("0-7")
+
+    # Difference with another CpuList
+    result = a.difference(CpuList("4-11"))
+    print(f"CpuList('0-7').difference(CpuList('4-11')) = {result}")
+    assert result == CpuList("0-3"), result
+    assert isinstance(result, CpuList)
+
+    # Difference with a plain list
+    result = a.difference([0, 1])
+    print(f"CpuList('0-7').difference([0,1]) = {result}")
+    assert result == CpuList("2-7"), result
+
+    # Difference with a superset -> empty
+    result = a.difference(CpuList("0-15"))
+    print(f"CpuList('0-7').difference(CpuList('0-15')) = {result} (len {len(result)})")
+    assert len(result) == 0
+
+    # Original is unchanged
+    assert a == CpuList("0-7")
+
+    print()
+
 if __name__ == '__main__':
     print("\nTesting CpuList class implementation\n")
 
@@ -117,6 +175,8 @@ if __name__ == '__main__':
     test_chaining()
     test_backward_compatibility()
     test_repr()
+    test_intersection()
+    test_difference()
 
     print("=" * 60)
     print("All tests completed!")
-- 
2.55.0

