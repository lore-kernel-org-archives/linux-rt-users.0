Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995070;
	b=AbZvLwGyYngTtjusIRhiIKb6eT17VXTGYHoXs3arYgW++6JPrqmnIj6nX+7lo9lwD1yh
	 P7Rxdn33pF+SX0b2mBrt6BteWZpSIurhUGLEV1cepzPub8dV7b6sNSuyI436qEf2Xs4Ci
	 h6CScVR8khEQCZu/pOD2kHdc1nmUIU1wtriLTFMeQYuuDadZyTOJDU8sHaVr6Ytl7zBs7
	 Nz+D4YnN5O/lUzEzjg09VOyW+zWSUXwRok2dg+zF2T0pKiEy6VdHcukDKv794IUShwfLi
	 YomWu43+3OJOTKPmW1Ih+wtJkgIQ/hRnD/CpzRjnaN4cak6PVb+06sgUCMED6o4i8xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995070;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:Reply-To:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=I5ho0S9dKz0F2ORIUjU0iaBbLoG8Dq0xOyEajbKpHdo=;
	b=cQpCS5XlKdMZ1I+3FyTXr/FUEuD1/grLMJ/sR2m4O1sGJpm5Py7tq+FoGLe5NH72VJQg
	 4dAAC9lYnz6i2qUfAOVJewdUPO0ysRkvaHolIgX0W9rxuK7LQjTiGlit4m1U/wPntnT4f
	 sURitf0vvGJ9wahypTRI+sK2q9503oZGmoNL1s0i62jDMlo8Gy/FcBzUhW03/fwxTLqvM
	 +ayMc0fIQGLEiTca9AmacfWxKkmS92kvvPeflR+YwLlkP1Kooejf4ha5W/3GBeUrGfrc4
	 0rksbRncuc5as4mguTex6gHhLa12E6gWBS56F/gy/nrUEgvjQJabi8LOFdsic7jp4mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AZoj5YGr;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="YQRj/ceM";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA4606A326
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Nov 2026 19:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3DA4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AZoj5YGr;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YQRj/ceM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793995067;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=I5ho0S9dKz0F2ORIUjU0iaBbLoG8Dq0xOyEajbKpHdo=;
	b=AZoj5YGr5foaiey6XekWcwWWXggttUHoV/ZBAjYiPmB0XifBLl3UJKXavZTa7Wpxl3SJH6
	L9YQHtdm39mytQnW40KaKIu2bfhPM9QzO9fljUFeTWcHZmdLzVd4/E8Z/q0wREYCBzfAM+
	wYdWJTOWREFX88kSKS/OK4PYoWryJBA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-qI-HsoqlNhWgpOy-mH3QWA-1; Fri, 06 Nov 2026 14:57:46 -0500
X-MC-Unique: qI-HsoqlNhWgpOy-mH3QWA-1
X-Mimecast-MFC-AGG-ID: qI-HsoqlNhWgpOy-mH3QWA_1793995066
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so264483385a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Nov 2026 11:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793995066; x=1794599866; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I5ho0S9dKz0F2ORIUjU0iaBbLoG8Dq0xOyEajbKpHdo=;
        b=YQRj/ceMj5UgGVLejVNi/CpH56KQiSKX5bRt6bZSxlY/BXyVwMF3d8PyxHUg+l+lOz
         y/IPVSMy1SVAX98DfMn2fH2pz459zVUNWg6WK9FF0FxtHeVM5TlhpoN0Ht68KPYd4U0C
         wKC91c7T53IU+nsY3VK8y7M74bDuVBw4tZv76jeOQgKKCDUOHiKB5+ZGh4fdkLSiTwz0
         hLR+MdcVMcPxFFVvxgbvTVT9SOYhiqNxYoLc0RrKoFEeLFC/LoEtFNWnWD8fJKKYgm8P
         fR7F/kdIfGSANKHYKbYSCYBzG/2g4P/uNxBY4Qf+tkg+qQlVHvS4mLQKtEfUZWChjD+3
         yc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995066; x=1794599866;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I5ho0S9dKz0F2ORIUjU0iaBbLoG8Dq0xOyEajbKpHdo=;
        b=xXhxnjkgYBxtH2Y/fjxOhfpLIX3Y4EOPzOqMBcoioy0nfzbIkiDAZU6N/hItutWAUi
         +z2WYjQdP5wYbUIwRFpNTJaVwALNiF61lPm86F1O7uEA8LjDECrZmpq07NpFM6kT54Gb
         2WmQ9VFFlSIMBwE75HRlYXIMQWAnRTwnTQUMdiA6SkjVUcqjojHxjHP4rx3PfyC2nC5n
         C4T7lhqKhDfv8BrgUhKtv4iRtyvHIEWXQOkY/xITyGMvFnY8ugYgb8M3DM6F1xA3rbRQ
         Ns50Y5s1+eUtRxBUiy4YWykbXRWs/6NgAnGCuKLBK3yMiLeqS/yHvhI6heUSFdKE938P
         6DVA==
X-Gm-Message-State: APuU4Z+31jTUzOPec5DyN/bZyAMyc5TcnAXKUJl3Smi5LJMpmg7lUOYp
	u9inG7WcYARPyCt75fQAbbO6AXr8fe0J/M+G7iRkQoJypDs5gAGduR134xmB3fBuQHrJJtBI6vs
	ir5YQCdBaGPJKxrsnH24oOoYCYq3So3DdrVnGqR7KPL0bh3UYiRrv1vuWPInNqzHG8gWuAfuQSW
	hSc5Y5PjWhcLJDImpuVrMqu4o76FSxfIjHoyb/LIPrnZC2TmzWiK/C4iw=
X-Gm-Gg: AYBFou2J/tV9DHYW0B8QpJPp+lhSs11Mw6co6oUfSTLzJK8SIXyQpFzcK+j5aLrptik
	FuAO4s6RGRP19x1MlCcuIPj7RY+06Fqn5B69TkYYxI03O5+oGk6EhzJ6EW6z+HWOm9ZngFvfoaZ
	dyYgGogmPxcY7K6iTWBBWor2kdMGtvRN32X8vB/rJQd5gmsM+N6GBckM2SL9rBaEcxLCbqCqDFt
	vfrOrh1BVbA96UEVrUqNecDnEF0fBl2JFj0tP/JnkJN+jwkOTCwEd8jctst/E0/6hQTJQikcWu7
	zIIRbjD1VF9w4ANgIFMsdK1NXTQdRYKbfS2BfTf+pnUFzZv0cTz0Bah80QPqPy82NLGsCh8A6aS
	cCCj1n9eehaE8xFEVHcq2H2UtNUNP9FHtG/5FcjASLVv7XVNlwzhy9mA0i9Y604tSgcGsaWh2e7
	H0zCgNrw==
X-Received: by 2002:a05:620a:2b89:b0:943:f31a:c0a8 with SMTP id af79cd13be357-945f34b7160mr452262185a.17.1793995066102;
        Fri, 06 Nov 2026 11:57:46 -0800 (PST)
X-Received: by 2002:a05:620a:2b89:b0:943:f31a:c0a8 with SMTP id af79cd13be357-945f34b7160mr452259185a.17.1793995065423;
        Fri, 06 Nov 2026 11:57:45 -0800 (PST)
Received: from localhost (c-71-234-51-224.hsd1.ma.comcast.net. [71.234.51.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f58be35asm218182685a.6.2026.11.06.11.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:57:44 -0800 (PST)
Date: Fri, 6 Nov 2026 14:57:40 -0500
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH] rteval: Changed logic for when stress-ng is absent
Message-ID: <au4xNH5aozR5P2MD@sansshar-thinkpadp1gen4i.boston.csb>
Reply-To: sansshar@redhat.com
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Changed the failure in case stressng it not found from a sys exit
to return an empty list so as to make it more graceful

Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 rteval/modules/loads/stressng.py | 4 ++--
 tests/test_stressng.py           | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index ec59bf9..ec812dc 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -78,10 +78,10 @@ def get_valid_stressors():
         return result.stdout.strip().split()
     except FileNotFoundError:
         print("stress-ng is not installed. Please install the stress-ng package.")
-        sys.exit(1)
+        return []
     except subprocess.CalledProcessError as e:
         print(f"Failed to query stress-ng stressors: {e}")
-        sys.exit(1)
+        return []
 
 class Stressng(CommandLineLoad):
     " This class creates a load module that runs stress-ng "
diff --git a/tests/test_stressng.py b/tests/test_stressng.py
index 090822a..94e7cbe 100644
--- a/tests/test_stressng.py
+++ b/tests/test_stressng.py
@@ -42,16 +42,13 @@ class TestGetValidStressors(unittest.TestCase):
            side_effect=FileNotFoundError)
     def test_not_installed_exits(self, _):
         """Test when stress-ng is not installed"""
-        with self.assertRaises(SystemExit) as cm:
-            stressng.get_valid_stressors()
-        self.assertEqual(cm.exception.code, 1)
+        self.assertEqual(stressng.get_valid_stressors(), [])
 
     @patch('rteval.modules.loads.stressng.subprocess.run',
            side_effect=subprocess.CalledProcessError(1, 'stress-ng'))
     def test_query_failure_exits(self, _):
         """Test when the stress-ng query fails"""
-        with self.assertRaises(SystemExit):
-            stressng.get_valid_stressors()
+        self.assertEqual(stressng.get_valid_stressors(), [])
 
 class TestValidateStressor(unittest.TestCase):
     """Test suite for the function validate_stressor"""
-- 
2.55.0

