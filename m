Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533B39B969
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258386; cv=none; b=YVBb0NN7ZAdeZkK1p00J+14aaDLUPhOaY3R0Cj9nAqryUQm3ccmBJkchmwO6d2CqHKkMQiLMKkH3AItLimu+lICCeowkEkBD41OT5zU87RamU9iGMHQUC+1adspQI1+B9KyoU8ZablmBy2lUqm+hBfFBb4O8PiLvHQqwBJVSiyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258386; c=relaxed/simple;
	bh=yvHfNuw3t84XIXbnVA9Ohx0gxNHN3dwkbzgdfucMHa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHiJp68pXYyySKpXXTV2YGKR8oGppLt8xighLXI/1/z+TRC3LA+OWuJyGEfENBx43/1EQCAxKn3IybuuQNU6ZFB/MrudjLfDvFubDp7flUMbzT2lHG6S1rxc1MTUNe/J8DmpRmjMSlPZeAZ71u5MH5PNL2DZXSQIbG3iv49W4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rTSsMpFV; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTSsMpFV"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f256eaedf8so202146d6.2
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258385; x=1785863185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08uCyORZWVaXQVOua2Dc+kdKBV/ovehZvUOg8D9FQ9M=;
        b=rTSsMpFVJD11w+8dLQnJGqY+a609eUEptxpfSkK2612LpW7NxW97RsE5hiz2N5n6Ov
         fYI02gALPQcIvsaWAGKGQ0VpBISt6FlbSFGhpuudCcixVeSRUzqgdfHh8vQwwn0iSLLY
         57g8pUDJNdq/l3doud87Asz/ySAx/KLbDPNCKohaXhgsmm+KTAKz5fu1LA7OeWCs+Wka
         X81JaeAc9F6F+THE8OWDIOekvngTm0IDnP1q7iWUmfHEKdaF+03DzHDYaUa4VERXY/a7
         VLdG0wdPlWeS7EUJicHmr2eG/e5QjrPs3JvgerQhDaAz//LC6nWjS6mEKLjLxfGnR1l7
         Xejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258385; x=1785863185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08uCyORZWVaXQVOua2Dc+kdKBV/ovehZvUOg8D9FQ9M=;
        b=XWwdep1HJAHKz3qVmp039Bmo/t0fpB62BdUN28eBxGtKdQaRRFu8DJczJSlzSbBo86
         /xN9w5hn+Z/jZpwdiF2U9Uw54phxuOPmW0B9uaB5Ur9gp91KuJ1hYCeYK/VdxDe6GhQT
         KwUGoZw7Nj0twt/dvTcGISACNmrKAQzuiVC49ccuroB2th/nbFKPJHfHG3+KzYQyGJXU
         IU93SBGVhBVCBPeW/BgluVGMqc9vr2Z0O4SHDvyn7XcXHv6bXn1/J+fPv17tHu8BlLmc
         MOOnd+MN9vJDCzyzGxmL0K51wghMYaowytt/8U3YLjPeC1DTY+XpLR82wbHp8dxIuwkA
         /hgg==
X-Gm-Message-State: AOJu0YzYJjLPfPDyzIbWkaM+74YtqXPDayyBwggikEdA9R+blkufhf0t
	tkB7XWnGt6Tx9jo6hcMz6EuhigYOyI1RBCPu8958JBL/dbu4elbPTGTOxmzRWA==
X-Gm-Gg: AR+sD10NO9JDHOPKjPPtcIpnH8m+vUMRXWwgZPzmfvtjH+UeCpeUrq7735sGH51V36F
	ZZepOvp8aZwTFeixsj2FYGtDD2CcVVooj3YjlRiwn2Znk/3Hs0cUtKU0wpQCrOvfsxwjVsGjF0h
	2tOcGIkuWIPBwi9p9b8/GgYu94lVq6LwaLgrxsYgYRog4K8tjufGEkTNAlYgyy7zVFjNqVcRxWf
	FjU5BKKdkuuS21GyeL6byyto11cmfdmpVoTSE42VJJZAAH94O/CcHLX5ZJzg/xqZ+WQoZCqT7up
	TPnROSyCTmQ3UtnsNfva3UqOKAPp2jnvx8YqwcJp1TmSxEqnJdobpuMw8ivVWl0tsM532JfiZA2
	HGRgxE0yvCTTHo/0uQGbHFJqYierCKCVIlfqu63zyS8Uh43DSw6njtzpJ/YqPnTq+F6a8rzz06V
	QFy1YuU6goIsetts3mK2k7W2N2bomxCRxcl0n/w6t7QdLeuMGBdVrmewBxEsPygq+mt998
X-Received: by 2002:a05:6214:5085:b0:907:88ec:6002 with SMTP id 6a1803df08f44-90816fba2b3mr37544236d6.12.1785258384608;
        Tue, 28 Jul 2026 10:06:24 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd3aac2sm3229676d6.30.2026.07.28.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:06:24 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 2/5] tuna: Use context-aware default path for cpuset profiles
Date: Tue, 28 Jul 2026 13:06:04 -0400
Message-ID: <20260728170607.176811-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170607.176811-1-jkacur@redhat.com>
References: <20260728170607.176811-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detect execution context to set appropriate default path for cpuset
profile files:
- Development (tuna-cmd.py or tuna-cmd): ./cpuset-profile.yaml
- Production (tuna): /etc/tuna/cpuset-profile.yaml

This allows developers to work with profile files in their git directory
while production installations use the standard /etc/tuna/ location.

Users can always override by providing an explicit path argument.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tuna-cmd.py | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index d2ba0238ab28..cf33af13d5d3 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -104,6 +104,20 @@ class HelpMessageParser(argparse.ArgumentParser):
         self.print_help()
         sys.exit(2)
 
+def get_default_cpuset_profile():
+    """Get default cpuset profile filename based on execution context.
+
+    Returns:
+        str: Default profile path
+        - './cpuset-profile.yaml' when running from dev (tuna-cmd.py or tuna-cmd)
+        - '/etc/tuna/cpuset-profile.yaml' when running from production (tuna)
+    """
+    script_name = os.path.basename(sys.argv[0])
+    if script_name in ('tuna-cmd.py', 'tuna-cmd'):
+        return 'cpuset-profile.yaml'
+    else:
+        return '/etc/tuna/cpuset-profile.yaml'
+
 def gen_parser():
 
 
@@ -324,13 +338,14 @@ def gen_parser():
 
     # cpuset save
     cpuset_save = cpuset_subparser.add_parser('save', description='Save cpuset configuration to YAML profile', help='Save cpuset configuration')
-    cpuset_save.add_argument('filename', nargs='?', default='cpuset-profile.yaml',
-                             help='Output YAML file (default: cpuset-profile.yaml)')
+    default_profile = get_default_cpuset_profile()
+    cpuset_save.add_argument('filename', nargs='?', default=default_profile,
+                             help=f'Output YAML file (default: {default_profile})')
 
     # cpuset apply
     cpuset_apply = cpuset_subparser.add_parser('apply', description='Apply cpuset configuration from YAML profile', help='Apply cpuset configuration')
-    cpuset_apply.add_argument('filename', nargs='?', default='cpuset-profile.yaml',
-                              help='Input YAML file (default: cpuset-profile.yaml)')
+    cpuset_apply.add_argument('filename', nargs='?', default=default_profile,
+                              help=f'Input YAML file (default: {default_profile})')
     cpuset_apply.add_argument('-v', '--verbose', action='store_true',
                               help='Print detailed progress messages')
 
-- 
2.55.0

