Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6238F633
	for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759676; cv=none; b=Y6WScLzvW8tnpL/jF9VAF8Lmz3nbUUh6HPZLGkFD1jUcxeiJT/ELumJlGffsK+NBgiL7sQHwgDRtL50tnBB3/ipQAEhfKr6fJ9ULQF2kkJ/zyj+mOoyIKqC67c7AGmmyoajEAFpNUdwUf8zh7kz7hbARyWMIu4liurYfaL1tWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759676; c=relaxed/simple;
	bh=D+jJvZfeJBI0xu4AxauMjl60BbFunOCHTeIDsCPRtkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EwYMuG4hrK/3Tv0PRvaKMigJ4pdxaAZ6cwqDGY/yUjEFkwVw4mgDGmXlCKVecCZBAh1fd2JztVp49cIB5Dv+vtQNVhaxdDSOETd5wB7zJT79Sl+59ptwL17vFB5oZJNYrb8h6PYEu6xCjdH/wg7QVzt3E4Ssf773lSpeVHYqyIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHhNHnTa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBKXXEi5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHhNHnTa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBKXXEi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787759673;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=Bk7Lb1XKIj6iOI9AsIzHpJ5nhTGwIG9JvPpGRo0HXGI=;
	b=RHhNHnTaIIeDxeTi0904tAKpBY65fKGg8XOtgnxmHoqZyRt+sf0qIJ1X9i5JgLmiYnY7iv
	XAqKBw8dMrPnR8SygUGUuN661NUOHuzXwtTVr/VjWj6RwsJ3s1tv40hn4fvnLdcOOtgfUC
	6IPFMMb8UF6DVJQ7pKr7kMD8YgIzva0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-reUHt5foOmiR_Lqk5rlaog-1; Wed, 26 Aug 2026 11:54:32 -0400
X-MC-Unique: reUHt5foOmiR_Lqk5rlaog-1
X-Mimecast-MFC-AGG-ID: reUHt5foOmiR_Lqk5rlaog_1787759671
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936708f129aso69221885a.0
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Aug 2026 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787759671; x=1788364471; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bk7Lb1XKIj6iOI9AsIzHpJ5nhTGwIG9JvPpGRo0HXGI=;
        b=eBKXXEi5Vg7b9j8O4UL9wsxflGa/Fld3HJpJi2/Fi8NFMGLWb/RuSzxdbbhmml2MUb
         2jl2PR/40h3zIdbS5Nh94VnsEsH9MmhPWqjnipUhJP8OmHWhQ7Lxy3BFhLz//6WpN/AL
         PQEJVLzRNwtWsv/3ykuaS4hB4P4l9T0NSCoVduorxLiwevuw2OPosuvy34q/Mj9v71To
         3SEpt5jN6O6gHvWq5XhHUrFXc9En9y8F5gtMwTk26FQQaUXQRpc6AMSnX+TZCZHVq0P1
         EkTGrgEzCXc0gm9rVC4wMVLKJq9XblmSGhu0/9BQrNPk7eLDDxUVpx6wdlAa9mWTy40s
         uKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759671; x=1788364471;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bk7Lb1XKIj6iOI9AsIzHpJ5nhTGwIG9JvPpGRo0HXGI=;
        b=r/hm8WzERBkqzP821YVvgUDtxDTTt59do2zxA3cAoGsScO/HD0nPEkBbFq9TIFMGBA
         LDh6plgr4IfJeuH1aZP/s9IlJiBByMMCj08RsNbp7T2ufHOSnPNsi2qhbInO+ywibGxB
         BGojS8bMJTZ0FyyYgdXj7YWtUl+I5yVCUbmXXr5RHF5K1cY2Ml7tLCyE7qMhePsmjAfq
         Eoog8/2fOWf/GvjGdAzaHGT2sTeDgRb2AMaJjbTlsl7IDE4DaMVie1JeApuR+g17Kzr5
         nguEYI/wqZmcb8s94eZ3V9BEvS7ZNhmZRTYVAbLMkYGp9jRaPpSHTZFhpbrSEX+w1eNa
         Kdxw==
X-Gm-Message-State: AFuF++nM1NCJdAffxx4bt5iJAzdBmC7Fm/sHNRrwNf76EE3zh7KWEZB6
	R7xq4ReSV8om1md6WLQBH8bcsn3Nc2TGt3LlXaWjasfTyEoKEXpSs8XFgfCX7eBJWBveJoJhJ4z
	1MvwsGGxPR1rhq7IwodpJTEPDmDSkZYm8j04SimeKrD0doBhfz1TnNyZ80ye+j90szK+yekTV2G
	SYYIxDqWtXsMm0RAsN81vgVKmkY2dNkQUGqLWfClPFaBkHorREv6ed
X-Gm-Gg: AR+sD10ieymfet+XyWSEryEOtpe/XR9sJojEyBIMPkuKWiBui+gGGODFdI1828KmDmv
	NH6eoCDTE4/EX8MzAfprpbuZIlvL6BePdED6q5NLQaPtXw4bZfrux4/WIsRhW3aH9zXE0HDrBWQ
	0zaSKm8A22mgobCZscSLpIyCp4nBJDH7y4lZdRZ+IND3Hm+cnAeOWaaptew9CJjXEnnhk+FIQ+S
	6Rj/ku/0jf2ZzTTg7/UjM4t/5l2zHO385s74LOy3nE8K2voBo57HEKOCAqtRE3Oeh8Xf/1iLM9s
	idpGiiUN+PROUDN5/fOImIvB2Wc8fmzay70DrhrqADWdEjqADeg2VB7i2n3WFs7hMYNo8EWbhC8
	=
X-Received: by 2002:a05:620a:2253:10b0:92e:745c:6c5a with SMTP id af79cd13be357-93780133e74mr585652185a.14.1787759670744;
        Wed, 26 Aug 2026 08:54:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2253:10b0:92e:745c:6c5a with SMTP id af79cd13be357-93780133e74mr585644585a.14.1787759670082;
        Wed, 26 Aug 2026 08:54:30 -0700 (PDT)
Received: from localhost ([2601:18a:8383:fb50:b58a:9574:42e:e066])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e30ed0esm237905585a.9.2026.08.26.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 08:54:28 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:54:24 -0400
From: Sana Sharma <sansshar@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com
Subject: [PATCH v4] rt-eval: Adding stressor validation for stress-ng
Message-ID: <ao8MMPPQAnmLMHi3@fedora>
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
"stress-ng --help". The list of stressors is created dynamically
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

