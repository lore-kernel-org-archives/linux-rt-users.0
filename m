Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482518;
	b=kG7NpxdnDeio9vnq0yZeKe6J9gQm6lciMNKVAgl9QfwaHQLVgOoVD2eA/R+f7jnc3Lsc
	 spqkXi4/Tx1k95aag9bAcxGAcH2gyT8JhunTQQHVh88r/wvCeUJs9NShPtUUW84dxjPT+
	 tOiCzxjrw/D1VA3321jla6MEgRgK624w/qidbjekLuyXWrlWFVE25h7MwEqENhfQFSKjL
	 8UqrTG47yQs+1eoD2thlIZZUcGpLVlPdp0tUpN0Borq1Yn55LEnxdO6B8Qfz97J2zFsBH
	 cprYvjZ7Lq0QPrwjYWLQO4rvJZP8mHVfOrZvXNwvxEDRlo95d/oJNv/yQe60QDfOsTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nMuz/YdOluImCqwxfhfBEIm9Dp08SmuJqy1acwtPW2c=;
	b=5hq7cidAu7bE+ZKDt48MqH6Jf6sFWtfskqdoTrxen38hFwMXIMtarPdI7k2QuvnVS1ms
	 oxEZFMD0klNHDxMnismXbP05rVZ0+u+q8qGQ2wIQLI4xYPcL0aC05DX7vD2mQdC3Vm6KN
	 8Tgf7wBoHIPPJ0SxpaLAU0JcPO2wU0Lra+8PJKQtZR02jAZ6PZq3I7tHVDN2EConcPe63
	 gwvxg3ED0hZfKMgnILq4lNCU9GJZeaQQe+ehWjZy7rsrznc+v32U0pTnZ7U4QNI4nZf7i
	 AqDG8RrAabCTT1IAIKxRYSTqNPwOP7fT6kaYmyxtVczQsW0l4di6ARukoxHQcfhPyew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hSqsdJla;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45F606A32E
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2026 01:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA45F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hSqsdJla
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-9213fddb596so49123386d6.2
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Nov 2026 17:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482517; x=1796087317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nMuz/YdOluImCqwxfhfBEIm9Dp08SmuJqy1acwtPW2c=;
        b=hSqsdJlasbno+gpuRowjBg6q/daBcBrY9nFEViUL99JjbpJBRfT6LDOQ0kietgLv1P
         k9E/gzkKKEjVN0eU5RpcvmJepfy6XCZqzVJ5B0TMgNJYSt8CD/FXnSvHnrBflmf61CmB
         db8a6ADsr8QVeezJ8zFqRIn8kFBAuhC5T5Tw9gc//TCIQbSwVux8ZBcACeH+CbUQburm
         A6+1U7eRr4p0Ek7KGmTELVevRU+dbLhJLjTsbX7lbssgorIPfCa5UV8+rkXOxq583Cp6
         0vvhFsfeqAicpYPSQQV5bdCY6cNmg8rnDg3HrNnl5snK25N/5PimtL9nJQlGzBs6z2r0
         gIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482517; x=1796087317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMuz/YdOluImCqwxfhfBEIm9Dp08SmuJqy1acwtPW2c=;
        b=I+wj0P1bD7DQ8gKf69SOwlsnbD5YyjzJGJXRi3GJhvpPoGjEjDmvNhSNvWBfcPefNK
         kniD6gSDKGBSCXlJzSW5gWzsuFcrRAL+oxDJH8PMvktAMH+/b6AxT8+tMJq0p/b39Rp5
         Wau4LlqkDs+Cne0fE9qmXgkdXZDkyd0arWd5zvU7Qe1KbYZBWY2dWxllXNBhcZ90hTD4
         GGpz/BHTiweNI35Plcw5IiLba3ufYZe142mNuDFN2sIb5/17B0Y7YSi60CzdUF1pcYxv
         NDs7Hmiy8fhkoyfFziC56K6Ilq9VIktOPQh+fbNGggAbHrIXaCkX2F+sq8tmUzE91Ryw
         V41g==
X-Gm-Message-State: APuU4Z+DY8v9eQLgvA5XGuauU9svCBM1443qnA51FGzqaPxa9vEIlVQ4
	y0wge9lx/gr/yGgvaR4KklzWCRNl+rQblwFL/SX18BDGg2ijqdu2zQIw4hPONA==
X-Gm-Gg: AZFdTZeI9EIsk2AeNAjYFWRcNlLgYTkTVI3QbeYAW+tAIS1X1dbxo4zVOnNcSIFzIfz
	yS9sqfE2gW2PcK2iXjfrHuWiuyYPkz4BmN2LE4n9K+U3KKq73tH6JIL9iWtnuKV9GPgSzewQIUS
	KbR7VBVpWRZchxxnWutOyaigIG1XJ56v1U5o5VMdzgdbsc5tIT6LhUMeDi/QQT8VHd5sTyq/L3y
	2YzoidrEMY/7Jrvnb0lNPRQ2iwWglC3CJkNr1DEJNTpMfYNdw5Q1z1xfvmq6RR0NtK8gllu6wPc
	0GVAgpxGsL/IaryT8FpxyFrttFgcb93L8AojKRDxNXbYEC6eROZ7iG1VQrhmX5Fa0AB4iJ8vOdh
	wyyCUzuPM0N3A+yGaoxUhYebhPTv/Nd/t/+onn++Mt1l/TN8pSvn7G6xYph12gzd7WzG84sS1Si
	4RBCW2VZ01DpspAP0mQ7FRTBzmfUd0zb4PY5s/5ZsWYzzxlT+Xq1tXZ6xCKZYTTXmHYZteSjXjR
	bIMfEJ1RyCf0q9bSaZURFamdBod6XSW2NsFW36kbSM6+n9f/DYjAkRyZoCNlKIwAyuFq+rNsV6E
	1yOUPwPQsmG+I/MQpU3VgmUC69tzFMlX3re6K/D2H06neOssDvoaV8PSZxmX2AP4+mxisTOiP3T
	Lf+LiUqnVXAI68h4VnNd7CRoU4ibI8TOjzSjD
X-Received: by 2002:a05:6214:c6e:b0:91e:d612:a120 with SMTP id 6a1803df08f44-921347740ccmr244237126d6.0.1795482516718;
        Mon, 23 Nov 2026 17:08:36 -0800 (PST)
Received: from jkacur-thinkpadp1gen8.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm120624806d6.18.2026.11.23.17.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:08:36 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 5/6] rteval: Skip cpuset partition tests when CPUs are not cgroup-usable
Date: Mon, 23 Nov 2026 20:07:47 -0500
Message-ID: <bdff64f75c1d83d6387c5ea6f913c2989da42556.1795478784.git.jkacur@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795478784.git.jkacur@redhat.com>
References: <cover.1795478784.git.jkacur@redhat.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TestCpusetManagerHousekeepingPartitions hardcodes CPUs 0-3 and asserts that the
housekeeping/measurement cpusets become partition=isolated. Some systems hold
CPUs out of the root cgroup's cpuset.cpus.effective -- via isolcpus=, or a
systemd/tuned cpu-partitioning setup (e.g. Fedora CSB reserves CPUs 0-5 with no
isolcpus= boot parameter). Such CPUs cannot form an isolated partition, so the
kernel reports:

    isolated invalid (Invalid cpu list in cpuset.cpus.exclusive)

and test_housekeeping_isolated_flag and test_measurement_always_isolated fail
under sudo make test-all. The product code is correct: an isolated partition
built from CPUs that are in cpuset.cpus.effective works.

Skip the two affected tests when the CPUs they use are not in
cpuset.cpus.effective, so the suite is green on such systems while still running
normally elsewhere. A follow-up should pick usable CPUs from
cpuset.cpus.effective instead of hardcoding them.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_cpusetmanager.py | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tests/test_cpusetmanager.py b/tests/test_cpusetmanager.py
index 3da042dbeaad..50ec478a7427 100644
--- a/tests/test_cpusetmanager.py
+++ b/tests/test_cpusetmanager.py
@@ -23,6 +23,43 @@ from rteval import cpuset
 from rteval.Log import Log
 
 
+def _expand_cpulist(s):
+    """Expand a cpuset list string like '0-5,8' into a set of ints."""
+    cpus = set()
+    for part in s.split(','):
+        part = part.strip()
+        if not part:
+            continue
+        if '-' in part:
+            start, end = part.split('-')
+            cpus.update(range(int(start), int(end) + 1))
+        else:
+            cpus.add(int(part))
+    return cpus
+
+
+def _skip_if_isolated(test, cpus):
+    """Skip test if any of cpus are not usable by cgroup cpusets.
+
+    Some systems hold CPUs out of the root cgroup's cpuset.cpus.effective
+    (via isolcpus=, or a systemd/tuned cpu-partitioning setup -- e.g. Fedora
+    CSB reserves 0-5 with no isolcpus= boot parameter). Such CPUs cannot form
+    an isolated partition, so a test that hardcodes them would spuriously
+    fail. A later change should pick usable CPUs from cpuset.cpus.effective
+    instead of hardcoding them.
+    """
+    try:
+        with open('/sys/fs/cgroup/cpuset.cpus.effective') as f:
+            usable = _expand_cpulist(f.read().strip())
+    except OSError:
+        return
+    missing = sorted(set(cpus) - usable)
+    if missing:
+        test.skipTest(f"CPUs {missing} are not in cpuset.cpus.effective "
+                      "(reserved outside the root cgroup); cannot form an "
+                      "isolated partition")
+
+
 class TestCpusetManagerBasic(unittest.TestCase):
     """Test basic CpusetManager functionality (non-root tests)"""
 
@@ -74,6 +111,7 @@ class TestCpusetManagerHousekeepingPartitions(unittest.TestCase):
 
     def test_housekeeping_isolated_flag(self):
         """Test that housekeeping_isolated=True makes partition=isolated"""
+        _skip_if_isolated(self, [0, 1, 2, 3])
         with CpusetManager(
             housekeeping_cpus=[0, 1],
             measurement_cpus=[2, 3],
@@ -89,6 +127,7 @@ class TestCpusetManagerHousekeepingPartitions(unittest.TestCase):
 
     def test_measurement_always_isolated(self):
         """Test that measurement cpuset is always partition=isolated"""
+        _skip_if_isolated(self, [0, 1, 2, 3])
         # Test with housekeeping_isolated=False
         with CpusetManager(
             housekeeping_cpus=[0, 1],
-- 
2.56.1

