Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662C357D03
	for <linux-rt-users@vger.kernel.org>; Mon, 24 Aug 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596818; cv=none; b=eN8baNJJ39CdmBx9PTCD9L8mGZTSyZD4DZjEuCst7306eOakXMLoS4Q/g8mDT54cnPvg/c1PzUsJkf6tt+ky8rpMhPz1xD+6ILx/ANdbdhW1uwvMcp53lSNGVs4jR3bdH2YISaz+4rmx8cvaGn/25a6Wnv9YudRNymYx/c2JTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596818; c=relaxed/simple;
	bh=LV5TEYPZnBLiGZ7fqhneFswoAI09vHQHlCL+Pt6cy4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZQfvvoWgoAs6JZUDE3KkMtk+8RhKADVw+Qqudv3duZnXnrGLVoOwWdlaOruCHVvOit9/hWppjmX1N+DlIjrsO1xr/APQcwXk3SX+JOwsqBWan1tEmK+3bFXbB1xjp+uLJeP2Clp0AZ3rroVUMJ4AUW1m8xUd55fNupfxOsj2jsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQKnQDZT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k0wfPszB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQKnQDZT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k0wfPszB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787596816;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=B/mEShnz+LRJaL7R5A0utdh3YaWBpLtCAuKIWGC0FEU=;
	b=WQKnQDZT9cjM4oU7xY8sj5DvwQ3R5yThRdEUfKpMBEWns0FngGp2JvpBec97CXJZqgKq3R
	i0Crtm9KZqXaHo0dnx41bL2msQB6uqSnomR9B+mHpDmVbrlbO5azOwftXEVeOSCTMqF6kd
	6iMTUMsoqeIUxeADAEua7Opo4NrsGqQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-mWMyMA8nM3WkvfDkAti2Bw-1; Mon, 24 Aug 2026 14:40:12 -0400
X-MC-Unique: mWMyMA8nM3WkvfDkAti2Bw-1
X-Mimecast-MFC-AGG-ID: mWMyMA8nM3WkvfDkAti2Bw_1787596812
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90c4da3d504so20235336d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Aug 2026 11:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787596812; x=1788201612; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/mEShnz+LRJaL7R5A0utdh3YaWBpLtCAuKIWGC0FEU=;
        b=k0wfPszBSvJMRhnFa+pnwph2JwI8sxYDNJQJZ9pEV1OMBbk+4rAdERKNmrn7Sa97O2
         qZtrikeSVJSPH553JLQTTa8n4EHIS+UgDQ7r0CLr3BV/+AYwnV9U/94Sv8wB6SIuaydq
         jFD5ZTdwzlWNO26oOOEuuDrV6195yDje2O24bCf0TEvZ6oImUrq0iHUcZspMmlWVb8Np
         sBTWUC141sxZvAdmpAVG+Etm0AMg8mROqou6lovC+J1sRD8/V2HamFzikRV9VkI9QJuo
         Y+PHIUi2doDktqisshEKIoUY4ULwfXPjNXRHFI+17Lbyu4KIrj/nc2NC+I4y3dr0smaO
         aL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596812; x=1788201612;
        h=content-disposition:content-type:mime-version:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B/mEShnz+LRJaL7R5A0utdh3YaWBpLtCAuKIWGC0FEU=;
        b=Qz7gRXqgkNyXhVmrJrbXAg6YQYlhlSMIMV9u33PhA8iSx1JZEfVUwEoFpdzBInNOjP
         qXU9qIJy/4cUvcUUgu+BGwdAhcqYkTxXZXAlCiQDyX6N8BWrfeJoIh1AhMQPUV2rAEfV
         OPUduFF5P6GFdtj90EIuovOJZaVWXwNw1KZ/Zu5N3R8pcyPEoUi/UkU9gIqkLD97SeCW
         0Mo8rvpj7u8y7Nu3BX/ovepbI/hU6fLJ2CIQ1ykfdArLqrmWC5t0U/irZSpkNKkQIQXT
         GVtsjpMN2xJ2bC2uYX6kyAMmUIoLbH8ETY69oUvprXzVYHSBXCG12vmnKXc5QN6wAynN
         1+pg==
X-Gm-Message-State: AFuF++kiFerOIAoxJIGghhLLavnfhG/+NSvvaM7gpboyC3aqsZm/qLl2
	ChRon7rEQX7KgWye6nUrJSmCJYwyQVyUeTD4KQmo/uqECvICkLkPz9SDdZ20n89JxexHGUE4D8i
	JOug7ksW4RBa/Nk12lu69n2YkN5q6iW6uFO25ycO1bUaKOvMBXNx7WcC+DRMRR7XvJHg+SDqVy8
	6n
X-Gm-Gg: AR+sD13xAA7NgN22onLzaEewMO3tkOwjEKGfgh5uUK3cOORLf3alVLpS1ZuiHlt8nwb
	Uu4+9tpjydSTo5CugZ0aznXh2R9JVwYCml4PHkkC17g5hlV48/GitbMWD3uzjDQhVmCfIXkzrAE
	ZzacSMLsvF3vPlNydBU3wR7scR9qt3mPz9AY60zczCWGgBURvRisq1x2vAE/2Q+O9aKmI78NpuV
	fBzj1X+qlF07yz7n4lMxC+tUEBgZUnuNbseNo/vuh6u6ePv8+RYAjhiyj4Ima40pLQSJCP8UFr+
	PnZAv0gIo6rElrsF4FpGRt9sbZ1HAR2PXqIQWZhh+mzbsfX74F8/gVCimURF7PPdk002u5DV6vo
	=
X-Received: by 2002:a05:6214:2d44:b0:8be:1620:a95a with SMTP id 6a1803df08f44-90c80e02f45mr325233756d6.27.1787596812023;
        Mon, 24 Aug 2026 11:40:12 -0700 (PDT)
X-Received: by 2002:a05:6214:2d44:b0:8be:1620:a95a with SMTP id 6a1803df08f44-90c80e02f45mr325233136d6.27.1787596811405;
        Mon, 24 Aug 2026 11:40:11 -0700 (PDT)
Received: from localhost ([2601:18a:8383:fb50:b58a:9574:42e:e066])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a8be17sm67504616d6.46.2026.08.24.11.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:40:09 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:40:04 -0400
From: Sana Sharma <sansshar@redhat.com>
To: jkacur@redhat.com
Cc: linux-rt-users@vger.kernel.org
Subject: [PATCH v3] Adding stressor validation for stress-ng
Message-ID: <aoyQBFpwyNcwessM@fedora>
Reply-To: 20260818231549.224764-1-jkacur@redhat.com
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
index 32e2dbd..9714e75 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -10,6 +10,28 @@ from rteval.Log import Log
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
+    if not valid:
+        return
+    if stressor_name not in valid:
+        raise ValueError(f"Invalid stress-ng stressor: '{stressor_name}'. "
+                        f"Run 'stress-ng --stressors' to see valid options.")
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

