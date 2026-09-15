Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2143846B
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492185; cv=none; b=GOuRdiKWHZdY2wFExODG2qd8FCVl65HTdSVJABC1ZMADgPzWceYkzZsr9VA0IaipT4fAoLz1TCa7RK/M99f977q5H/6DiReng7137ODw4QkqOdzQJBWsz7B3hBScqJG3nPIIDGcJEjmOXNl8BtWIjAmGZsR60paNGz3jehvtu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492185; c=relaxed/simple;
	bh=Nqs5FKY8rX/oFlQ6SlJrgqs5RTQ7w+7M4CB5Bf7pw7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oehM85HtgOPc4vGpFUl2CMYI++6dYD3gRaiDYSynd8KuuH+ZBBXR9ekrG7gn9pmD1D2g25eBeJEUoCo7yyrzNwvbfniRFY7g+BWCCtVmsqD+TAHdnVAL96Null55YXHmzb02zjCwJ3IROa9Sl/L+j+9gWtBMO4UQJRJlA+Yj8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRkRRF+o; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRkRRF+o"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a135ffb08so418385a.2
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789492174; x=1790096974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGdvogRmQpMNPXvebEu2vmy3uePnTObj/b4HXJYUI2k=;
        b=oRkRRF+oJPFiv17uE6zg44SoDAkcvWgE7qAB1Oawnv9my78533HxJgN2BS3GsnEm7t
         YjspZsAK5Y5E3fbZluZeIlAg2eksRwJQcxTJQIgB6T/H1/cX6+T/f+aRlZsq5/VWobUA
         kZHO5V8lARqZfkqhtuu/rUF1A+YYXPhrSjVp4CBI6Ek5nFYS4SGQhaLFssQvvLwOPFwl
         4GQVclRYQNLJ7HyMFT+YV6y6pHk/Vh3sO8D+06tiQPqk+LDFfmqN6PBJDAopVLpHHL15
         S/zROEYD1n/fEgsTujB1sRiL6kR0kwPRvdoChWh+MWaV8stfiNYYpqXnSDGOYLMB0SPp
         TygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492174; x=1790096974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGdvogRmQpMNPXvebEu2vmy3uePnTObj/b4HXJYUI2k=;
        b=MIkOp4OsP1+N6zX2aZtd8/6D8P3WgtZuwZXBfEs30Z/pdm40PodOMzXVMG+pGHK39x
         6B1pl8lyPWyn8FY9jvXOdVY6J/2uGGWvs9Hy9cjFkVGvTkxpieRP828ZKNhjmxn7Dx6v
         hNYTrQGixCEOAk3gjzxYMS/eaxop+ViKpx5deBmJe5B7jN3ZhTjwyCV2wfeO737cKel9
         3uRahV2Wdmrg/4orpB20Ll32yKjxShrO/dM0yKpjUTMIo2zMPu4sEtjLf9WDVChPm2kG
         y0WU9kZ10mRyrrXCerebGUjqWgG3GDqad9LUvEsgVL8NbgZn/8k5y8lVlNrG/esFyLcQ
         nSNA==
X-Gm-Message-State: AFuF++lXAO6TQV/qIuhxU/cOt9zpI1bnFzn0QdkqHovt6Rj7GUxM0dXb
	UosZa33T6bduOhQ/YBX/v8T3hvk2DcDmkyvuoecziOXWVp0K3qqU8gk9SYfTS9Ao
X-Gm-Gg: AYBFou3bPtAaY0qc/V61tAujkpkYDviX2eTIxPm0SUenR1Y4IZgavR9vGvSa3+O0GOJ
	9e8nDaYywmHK8qWSqCjUl+aZIZueCVUIug7bXAawqd+jTByEjzd3GzQKQyMa9QjRzgyHf8z9ajL
	fv/iFS28t9poFZQqitv/njjUiSLxlhGv22Vt2354f6K2XSDhEwHMcf+nbFUgjnUiig5nmQpTMu6
	7H7spjYH87aKRujqEeIPa6+0EJ9hlydOcCKLBSbYghr5wBvhd894tDipjgeQLm5V5WZbtqAxRJy
	JKKPmanwI0z/ZtC55HMk28KDB6OD6+qOADBUrLUKuRw6f7JqU7LLE27wPTATbl58Y4nihadRjLz
	cuOVfGNFeutUVXpFp6nN6lkM50WrFVnEGnxLy7C8g0j2o638HQSXyG4HUmBoYFY3M4Ok/rwhqT/
	g7ZTyklBS8bPkJ2jYHomAAQ1ZAzhww4sh3Gojkpb3aLdv2lN4iqf1jziq4CqCYoGWxqv+dd4h1J
	nz8E6guexZ0hQZZ9sw2ZOcf4A+VLeuvpTHliNe3L8RcuMAgfRBKedkn4FKxBvyj
X-Received: by 2002:a05:620a:2b83:b0:939:6de8:43dc with SMTP id af79cd13be357-93a29bf9892mr249402585a.48.1789492173733;
        Tue, 15 Sep 2026 10:09:33 -0700 (PDT)
Received: from Cumhall.redhat.corp ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81cefa3bsm1887885a.34.2026.09.15.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:09:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH] rteval: Improve test_stressng output readability
Date: Tue, 15 Sep 2026 13:09:17 -0400
Message-ID: <20260915170917.122102-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite the test docstrings in the concise "Test when ..." style used by
test_measurement_module_selection.py, and run the suite with verbosity=2
through a main() wrapper so each test prints its description as it runs.

The tests exercise the stress-ng error paths, which emit messages to
stderr. Without descriptions these messages appeared on their own and
looked alarming. Now each one is preceded by a clear statement of the
test that produces it, making the expected error output easy to follow.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/test_stressng.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tests/test_stressng.py b/tests/test_stressng.py
index ac1a3b707321..6211fb36a42f 100644
--- a/tests/test_stressng.py
+++ b/tests/test_stressng.py
@@ -15,14 +15,14 @@ class TestGetValidStressors(unittest.TestCase):
 
     @patch('rteval.modules.loads.stressng.subprocess.run')
     def test_parses_stressor_list(self, mock_run):
-        """Tests that the function works for multiple correct inputs"""
+        """Test parsing a valid stress-ng stressor list"""
         mock_run.return_value = MagicMock(stdout="cpu vm matrix\n")
         self.assertEqual(stressng.get_valid_stressors(), ['cpu', 'vm', 'matrix'])
 
     @patch('rteval.modules.loads.stressng.subprocess.run',
            side_effect=FileNotFoundError)
     def test_not_installed_exits(self, _):
-        """Tests that the program exits correctly if stress-ng is not installed"""
+        """Test when stress-ng is not installed"""
         with self.assertRaises(SystemExit) as cm:
             stressng.get_valid_stressors()
         self.assertEqual(cm.exception.code, 1)
@@ -30,7 +30,7 @@ class TestGetValidStressors(unittest.TestCase):
     @patch('rteval.modules.loads.stressng.subprocess.run',
            side_effect=subprocess.CalledProcessError(1, 'stress-ng'))
     def test_query_failure_exits(self, _):
-        """Tests that the program exits correctly if the query attempt fails"""
+        """Test when the stress-ng query fails"""
         with self.assertRaises(SystemExit):
             stressng.get_valid_stressors()
 
@@ -40,16 +40,20 @@ class TestValidateStressor(unittest.TestCase):
     @patch('rteval.modules.loads.stressng.get_valid_stressors',
            return_value=['cpu', 'vm'])
     def test_valid_passes(self, _):
-        """Tests that the function works for correct inputs"""
+        """Test that a valid stressor is accepted"""
         stressng.validate_stressor('cpu')   # should not raise
 
     @patch('rteval.modules.loads.stressng.get_valid_stressors',
            return_value=['cpu', 'vm'])
     def test_invalid_exits(self, _):
-        """Tests that the function exits properly for incorrect inputs"""
+        """Test that an invalid stressor is rejected"""
         with self.assertRaises(SystemExit) as cm:
             stressng.validate_stressor('bogus')
         self.assertEqual(cm.exception.code, 1)
 
+def main():
+    """Run the test suite"""
+    unittest.main(verbosity=2)
+
 if __name__ == '__main__':
-    unittest.main()
+    main()
-- 
2.55.0

