Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482516;
	b=4yfAJJdBILZ9+t9ix0SYjkA5/OJyuIyyS9WW6oVPvfRrL61AsKJbGz135t5K9ZUKX+jU
	 OzAHlKBh97+xrUmHCRZdniuJH9aN4bA7Sz60D5b+yLBkTSKbnHpVNndRGKNdzOtQ6vqpi
	 8BS7GTP0iLCiQLn9lJDIoVPGpqHH7b9s6qgxqVbcPzp/gNtOV4dh/b2FmBNEka/D29mKq
	 CAtSu7cgzeqjjaXgaSBbVJoX0spQpHiYdwsi7WZFKniFc3+0EcAWL79/uwyDln6FZxuuK
	 6Prc0xmerXYtDoCcsm+qUUjfq9tyT9vA82AmqxhOFoAqlKucYexiC3wcxeIrAoIqbdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k53qb80BuDDrVx8TdgPYzOXepk57HTnu97m5mswrW4Y=;
	b=0BdOVGts70arOaseekeWl/4q7zgPYPQaKGZ29s9KbdIU22B9p4b1tG8q53+0IYO9BFzn
	 AO0fQgRmdYIMbeujaMwbg0BRPCMtX3Dtcx3nKOpr39yNw4yjrvpXCRZx1m6JvVMhtLgvu
	 vCZeBVLchHWFuzoSPM5T/03xkJKn0nF4hvCjrm9/MTofVK1wGrzF/FK+eSp3YeYoWiMXO
	 VU+Or+S9cVg0x5o9qDPHXSHTycnoj07YWFQP8ZR9sNYLH+HowAZqROBqj9lOIwHPxIiBI
	 Fi6pXCqw9mKULAis0ySmOvCi9QyT04E+t8oQL/N1AH9jGSx9QIjdUhHJ6fMf/kV8KbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mty+UAWl;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6477606A32E
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2026 01:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6477606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mty+UAWl
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5495d549924so44236901cf.1
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Nov 2026 17:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482515; x=1796087315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k53qb80BuDDrVx8TdgPYzOXepk57HTnu97m5mswrW4Y=;
        b=Mty+UAWlXFRol7h++Xq5nUrghMQgOD99a+1Hjf7EeY54zu6pKhlFDX4e1FagXNCWdQ
         JPadJRSMwXZn/uHY5of3obnkC9PCudYk6RwbYa/nQqkxNOQoCvRVXskFG5z2bDVDPfcg
         24unBb/P7aXlr+YlH6m8ky31i6tK5h4mOf3d6Y7/SPRvwAhbjMQXN75JcGR4jLaDMEZ0
         FPMIMnJ6oTl4xtoRJiTyN8WbdZN+Vy1NI1RX4lBKoGsQrskQOgt/6No63GbeWcPQC4k3
         D06Yg50lFEuTaU3kcAoCjjaRIGOrUIbC0yW74mAi/Q/f9MrIbUgS9mmfZ7pnjg1UPUhH
         8UVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482515; x=1796087315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k53qb80BuDDrVx8TdgPYzOXepk57HTnu97m5mswrW4Y=;
        b=otWxdoROtcNCL3lNJnoT4tJvOX5QepfiFVcwVfeFzRh+cogHsyt65jcHbRVdba61nP
         YO6wXMSFoG8sX1tCPEc1tjPTwf4TuSMkNrBmFjhk5tYFnvmJsM2lv0pgFI+z2gSDO2RU
         ybrQgPO66anAEyaXISEmAo9gT/9AEGPM0VSroKDnRRhro+iart1mQFmzG6rHmSOC4GcM
         xvdvVA4ffgiW7CspBIH/6igtE7mSwUcx9BnagITvYpECLzBCqsjcMkO0AFoZlxMUok2r
         c81M+C4IDkqxOrU4ttZwQjJ9onGrMFqPxYyjqD3xU3zKc/ThDhV3zlGXoSpHyRs6EOsk
         Nkfw==
X-Gm-Message-State: APuU4Z8jGugTytIBtoi8mZIdne5NtMk2Ta7UP93PJ9D3Dn3Bdu2Aox0t
	qQrADQ5WFZ2OtLgBLspGiKky1UOSe6LE7K+Z/AK5p5fM3wLEKgp+s1yzlEN/vQ==
X-Gm-Gg: AZFdTZcdvqYdFgkydgW1MFSipHqfBn0mfmIFcNlNxi1YdmfD3U/bH3w6aWTFVf3zv8E
	pHhqH5hu8C7I1gb+Gy7M/1SNpFokxV5JlErn2MXflPG+bd1n0HirVM+2DJdHNMGca8Dm4N5FRJu
	O4HIjgROYixiDsW3wchuz/p6+JlnyTzmu/duUS4/07V5vjmhf2IHl1u1qVqCD23OwgkaVKXvJE5
	zbzPBphABuXN7IoejISjX1uzEY1TlSuyBVD5ef1jwWjlqa37bCNwImcmWjZTCOqGCSiPhf55Usa
	PcclPr9DLvRT6EyQMr1ha1V9sX4HlXpJC34j24t3AR6C8NlbU8H3bSd9R02VS1Kovuu7gCStYxO
	ZvOeT/ZQw4rrhcnp6RmodEPYOICLi9GOfUgB+dRP3JXKy/uziUz2+wtLE2Lh6dZhLKv+RLyom4h
	duJR51aPN8KdfX5FtUZnF24ooiFfP9Hqv+fE1m8+ObAsp9ftG9OJKTPMJK3ZUMce/I7Ja+96R8a
	RZaZl2sBQYsoHpbkShu+n/1VQr+lsv0BQekKj+QZHiHezuUA5ymqMEfDusZimsJ8YeaSkld0jPV
	qkK/jR/O5jg13RfRiydtnuPWbB4ec4sndeAVb/twXH9cff8hdxYFSip9bzLU13KWk6eRK0xpVad
	HR5LKlWmljJqd49DHHM2gZo7i86zyvgWcCUcx
X-Received: by 2002:a0c:f007:0:b0:91e:cb6c:a50f with SMTP id 6a1803df08f44-92134ac3de1mr194174226d6.33.1795482514836;
        Mon, 23 Nov 2026 17:08:34 -0800 (PST)
Received: from jkacur-thinkpadp1gen8.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm120624806d6.18.2026.11.23.17.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:08:34 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 4/6] rteval: Make core-sharing tests independent of host SMT topology
Date: Mon, 23 Nov 2026 20:07:46 -0500
Message-ID: <fd73ec160d0e0168acf4d1160db4c24d175b8edb.1795478784.git.jkacur@redhat.com>
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

The core-sharing tests in tests/test_core_sharing_validation.py mocked the
isolated CPU list but not the core-sibling data, which is read from sysfs via
CoreSiblings. They therefore assumed an SMT topology where CPUs 0 and 8 are
thread siblings and 1 and 9 are thread siblings.

On a host without SMT (and on many VMs) no two CPUs share a core, so
validate_core_sharing() produced no warnings and, in turn, no
CoreSharingWarnings XML node. Four tests failed even though the product code
was correct:

  - test_housekeeping_measurement_share_core
  - test_multiple_conflicts
  - test_isolated_marker_in_warnings
  - test_xml_report_generation

Mock CoreSiblings.share_core() in setUp() so the sibling topology is
deterministic (0<->8 and 1<->9), making the suite reproducible on any machine
as the file originally intended.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_core_sharing_validation.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/test_core_sharing_validation.py b/tests/test_core_sharing_validation.py
index 383b028516c1..05de4590bd35 100755
--- a/tests/test_core_sharing_validation.py
+++ b/tests/test_core_sharing_validation.py
@@ -26,6 +26,19 @@ from rteval.sysinfo.cputopology import CPUtopology
 from rteval.Log import Log
 
 
+# These tests assume an SMT topology where CPUs 0 & 8 are thread siblings and
+# 1 & 9 are thread siblings.  The real sibling relationships come from sysfs via
+# CoreSiblings, so mock share_core() here to keep the tests reproducible on any
+# machine -- otherwise they fail on hosts without SMT (where no CPUs share a
+# core) even though the product code is correct.
+_SIBLING_PAIRS = {frozenset((0, 8)), frozenset((1, 9))}
+
+
+def _fake_share_core(cpu1, cpu2):
+    """Deterministic stand-in for CoreSiblings.share_core()."""
+    return frozenset((cpu1, cpu2)) in _SIBLING_PAIRS
+
+
 class TestCoreSharingValidation(unittest.TestCase):
     """Test suite for core sharing validation with mocked isolated CPUs"""
 
@@ -33,6 +46,17 @@ class TestCoreSharingValidation(unittest.TestCase):
     # Based on typical topology: CPUs 0 and 8 share a core, 1 and 9 share a core
     MOCK_ISOLATED_CPUS = [0, 8, 1, 9]
 
+    def setUp(self):
+        """Mock CoreSiblings so core-sharing is deterministic on any host.
+
+        validate_core_sharing() imports CoreSiblings from
+        rteval.sysinfo.coresiblings at call time, so patch it there.
+        """
+        patcher = patch('rteval.sysinfo.coresiblings.CoreSiblings')
+        mock_cs_cls = patcher.start()
+        self.addCleanup(patcher.stop)
+        mock_cs_cls.return_value.share_core.side_effect = _fake_share_core
+
     @patch('rteval.systopology.SysTopology')
     def test_housekeeping_measurement_share_core(self, mock_systopo):
         """Test warning when housekeeping and measurement share a core"""
-- 
2.56.1

