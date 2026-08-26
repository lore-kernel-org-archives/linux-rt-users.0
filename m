Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0931A045
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762943; cv=none; b=DzY7ZoFO1TRBTif85AqwAhx04WRI5RUiGi1paDmJinGkUj58J6aj4nSAg2f1SFI1CMVgW8e/03meuDw5M90w3rRZNVxuu2++wmQl21QlqT5YdTKkG+Kpj8PCJ/LmkZhr4Fpe5ORdHhFokOdY2V7W6qd9vYEo6ySmZahPqTXBtoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762943; c=relaxed/simple;
	bh=3PrLaBZtMYKla/FsPHjUyzkQldgwPr2aNAM7ciovlj8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TVzpbxMg4VxBXPvrMY9PELEjL4lLV933cSNOl02h6VyX7h3z6WwDiNyKh0tzgx7esNaPuvTZmuSwnf3fjeSrM68WSYBa6+mPib2FQCSajeUBChD0Zct2YxKjveT1ZWYjGZ9e2iY272Z7ymsAHDGlKAnIg3Ca7Zr/84g14jDX3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnRxf7Ua; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/uASR5W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnRxf7Ua";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/uASR5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787762925;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=/l8N/PDSgDotqDsYu/5ghBrmJqFKtNHPclT8vHNxlWw=;
	b=RnRxf7UaMpyMlNuFnOKGcBYMtWMITrGJtO/QlmkVFauqQ4nIduNy7iQv1tBe+rxpbzK1x7
	YYyK08vk/cEedddVa3XbsDMCYrbeXKxvjUdInEjCTh3rj4i2av7PCs32Pvs8JVczCSeKah
	DGqe9zq8r/iff35p56U2ssRjSWCsyuI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-VksVBet4NBKHuuOfUY5ULA-1; Wed, 26 Aug 2026 12:48:44 -0400
X-MC-Unique: VksVBet4NBKHuuOfUY5ULA-1
X-Mimecast-MFC-AGG-ID: VksVBet4NBKHuuOfUY5ULA_1787762923
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-937795a3ac5so157643685a.2
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787762923; x=1788367723; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/l8N/PDSgDotqDsYu/5ghBrmJqFKtNHPclT8vHNxlWw=;
        b=f/uASR5WRPbhbLLa+l3iGHOVj3kB8FxOnp4bNWufNd5gvi7227Ofwkk1Yrs/Op17wt
         Q3R+6oClqICanRYHKUUh1QiLedBgnIWrsADRojkL1pmU9+qnMRTOF705t082eHWDXlPP
         CoxhN03TgOQd9ymwjmA4bOwEjj90+Qe4nBhHfxTcQ7aOMPoEXgAm4DLIPF6gLv75/Ko4
         FtuGdyfmoWYAgcepruHopd2A38kaHxrzcU9B/yjz7Dv+xLspI2ZKEW++nI1O1iDc74Bv
         c+pWtl2bQPHlnN/RerjPtmXBSZu70ZZRJI6xsTFU0OiL7zopmDCN9CXLaY/02itqptaY
         spHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787762923; x=1788367723;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/l8N/PDSgDotqDsYu/5ghBrmJqFKtNHPclT8vHNxlWw=;
        b=HhwvJ5rJEQQJXPU5UWUYo4wGV1NRFg6UPriHv12P/PU9fZARUGG7lWBeleStJ09o5h
         bOYEx9YJI0Ve5R2BN/d/DFPQiHhth7ztk6RhSIeZ5vzpfRImS/6sKUlwjcJqyfjFIqkp
         LZMcgwQ7AR42ifSB1tnqE3Wz7RRF03y0sbefBjM9SS2GPvfCq6gJg/Zyv/u6fKs0MYpQ
         IkzwXs2F1vhKEVcD163X0THOyfp2H6ggA5Z42fHYOzUAGHhPXvehr5Dgiu0khQ74Iw4d
         7QYg8/jUrMmKD48R+ozcnTLJkpaVOkT3MMN+osxefPTC3kiB8n25b45+0alCXPMkQ5wJ
         cCQw==
X-Gm-Message-State: AFuF++m8m0eB8jom4xoPS4b5qSwa8rK4WV9EcyXRqYWzQoDAmFIJG1Wu
	COpw+uaEDJ+0hvXkh4WiJAck8YWcNL/RxjeYYp30VDjn5NRRR8WpGUjWokyvgtsFdOwY/rA/GmR
	XmLZ0fP8Oh3tfhiuaqa1FtwSLdkx2Ue6CncY+8z3Ige86odZDfqYxjWDQpLQonEg1D3JVH+6xHO
	PZohPPTjC4Ah5zn1xVEu+0wugfddCWMxcwZGMcl6qOBSeIKf/ZYRom
X-Gm-Gg: AR+sD13DK3322YNrdXMoc0+DoBbBwOBhHOBPVpq+rGAPHXHK7ydL8zGeUFIOcqM5P90
	D8UIKuYoC49SfOuAIVB8PT6u1XYEva1Ub1odulD7VSaEK8gJlEuSk4S0CuXNalLkZBk2OiUIJFx
	rvkHHm2D4EjmoRSys8HHN0y3weyq5hsQ627db0WKOasf1xcWB+UANqtnXqL0kDwKrp88UvQ8YLq
	OotcvgOH6m1K8sVBJiNSycczu1y72XeMAReNhYPpW6xcj6rnk6CTLmaxizEWWf3gfxmBRYXB2JD
	Zu85YJnJMDDCFajTKu6wRqBcqYRH3k+Zbr4GSJA38Onot9rih9Ua/o5uBjR2uq7qj4Mp9KbrI8s
	=
X-Received: by 2002:a05:620a:29cd:b0:934:b6ba:15d5 with SMTP id af79cd13be357-937805d1212mr763913285a.39.1787762923454;
        Wed, 26 Aug 2026 09:48:43 -0700 (PDT)
X-Received: by 2002:a05:620a:29cd:b0:934:b6ba:15d5 with SMTP id af79cd13be357-937805d1212mr763907085a.39.1787762922913;
        Wed, 26 Aug 2026 09:48:42 -0700 (PDT)
Received: from localhost ([2601:18a:8383:fb50:b58a:9574:42e:e066])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e31037dsm249747185a.7.2026.08.26.09.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 09:48:42 -0700 (PDT)
Date: Wed, 26 Aug 2026 12:48:38 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v5] rteval: Adding stressor validation for stress-ng
Message-ID: <ao8Y5tpZbpK-IPbc@fedora>
Reply-To: sansshar@redhat.com
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Previously stressor names were unvalidated.
This has been changed so that now if the user inputs an invalid
stressor name, they get an error message telling them to check
"stress-ng --stressors". The list of stressors is created dynamically
during "WorkloadPrepare()"

Added error handling for when stress-ng is not installed

Signed-off-by: Sana Sharma <sansshar@redhat.com>
---
 rteval/modules/loads/stressng.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 32e2dbd..df4685e 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -5,11 +5,33 @@ import os.path
 import time
 import subprocess
 import signal
+import sys
 from rteval.modules.loads import CommandLineLoad
 from rteval.Log import Log
 from rteval.systopology import SysTopology
 from rteval.cpulist_utils import CpuList
 
+def get_valid_stressors():
+    """Query stress-ng for list of valid stressor names."""
+    try:
+        result = subprocess.run(['stress-ng', '--stressors'],
+                                capture_output=True, text=True, check=True)
+        return result.stdout.strip().split()
+    except FileNotFoundError:
+        print("stress-ng is not installed. Please install the stress-ng package.")
+        sys.exit(1)
+    except subprocess.CalledProcessError as e:
+        print(f"Failed to query stress-ng stressors: {e}")
+        sys.exit(1)
+
+def validate_stressor(stressor_name):
+    """Validate a single stressor name against stress-ng's available stressors."""
+    valid = get_valid_stressors()
+    if stressor_name not in valid:
+        print(f"Invalid stress-ng stressor: '{stressor_name}'. "
+              f"Run 'stress-ng --stressors' to see valid options.")
+        sys.exit(1)
+
 class Stressng(CommandLineLoad):
     " This class creates a load module that runs stress-ng "
     def __init__(self, config, logger):
@@ -51,6 +73,7 @@ class Stressng(CommandLineLoad):
 
         # stress-ng is only run if the user specifies an stressor
         self.args = ['stress-ng']
+        validate_stressor(self.cfg.stressor)
         self.args.append(f'--{str(self.cfg.stressor)}')
         if self.cfg.workers is not None:
             self.args.append(self.cfg.workers) #default is 0
-- 
2.54.0


-- 
Sana Sharma <sansshar@redhat.com>

