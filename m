Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2C434E4B
	for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700092; cv=none; b=nG7P4L4RuuQYU2P/7gUVDojk3BUE/tfq0jKHv1OxmOggJZ3bYjolsD4cPE5bMsnbTM93FXTpsdFXo9Ek4BxWvybfHlkV2rgKTl8qSX6+ManHOzPUazgq7+kiIEImjOAbh0B9BttE4oSMdE8iHvawOlHxRfs0rhGm76wUCK/Zk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700092; c=relaxed/simple;
	bh=JYgvhxPBfQL9cjpgezp2EipfqeaVsY2NvMkuLGrnVRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOsOKf17esSGsf7tSxTpDKxsqMdqIqEwkoEApl/WGP0OWMZFxcFLm5nXAYlupmMFhxJ8VyThTuuViDxkH8UmHcCj2C7TmR6dGG8bB8zctqKhtMxQff6ThfA4FsnF+l99XHro9BqpvVe2nBNl6wK1oZbaXyVAUM74r17+GqqMO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp3iOC9p; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp3iOC9p"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efec2c28f8so8754606d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2026 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783700088; x=1784304888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jidyz0m2pyBT9HTJJIRRr+C9ZxN+bBe5QqlIStZVsLA=;
        b=Dp3iOC9p1NHQvPvZKfvAV2C29HniMjjLrwAHlHQUnx1o+uV0EzTjmSQP28iqUFC+Vq
         dKX+/NayqPq7MINLsjVf8OLaGpY7zaLYrYGMaPj+KiTs+8NIMnuLRXZmUhkVXuMJEdGX
         W4OSpnN7W4bRBJVwsVAQ5lIhsf87Z55X+t3u9hLdruLunY2skws56OEMN2oF5yh7/vAw
         FskUSGXnqQaNcOI6PU4uMFS4oRIuMTeOtgx/IbLQWzvUUeLskCDadsGe5SaoKf8v6i+i
         jlCA8c8vgNvBsQDmghqAqOc1XjpuMAXxRRHO0LOvbJUPn1F+69TqDHJxZZa7djsJtaNA
         XhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783700088; x=1784304888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jidyz0m2pyBT9HTJJIRRr+C9ZxN+bBe5QqlIStZVsLA=;
        b=kGWHFA3KnFNCe7gDdT0L7LfzHW8Wub9IbNPW2QaBuB8WxAIwwNbWKf5TpCKuE2KCIi
         aj6CiWYd6ozudOtcYP9hMnsfdQiAzLBEM+4c7j7F2SoR+nBmt8U6fC0ZZKdTNMM3V1ai
         ISQtgms7pxqjlWHYZ/uc21NeECDfJ8R6zCBOqiXbDqVux15terWDRDk8yKYkedbPQ+iT
         FzgojdDVxoZvGkJ8nV3Q3KNlukUvw5fJZpbHatuhH8KkeHHxF7y7fTFEB8hKnKUfyx3J
         Ji2UHSttq83Q71z5u8lQr4fbXe0hL8o1wM9y8xFnMAPN1+p2y6zuHBaoIhig22BoWMZq
         W8hA==
X-Gm-Message-State: AOJu0Yz/XX+VusR4cvDHW5ru9gRQcYXbUiJ0+n/PPqOCvbEAkQESRr0C
	JDP1oGGCOmQzaaEYOtFyHJ6uESp+V7GNwgCtY3hpvYEZ5sTotspS+1YzXAlDUA==
X-Gm-Gg: AfdE7cnSgebkBybFd8wKuIcAP2BWWdivqXz4N27nB+IyRa8vvYftizx0VIVGgaDNgP4
	6vWnfh4yT2fsYZEflaRDAch0TvGy03V2M5h2ZGj8AIZRgJmte4sDEF30ioBYQWLby/CixgvHVJe
	UYUIBpCYs9T6FgF/RGXCiuDlHvK2fhWW11rOYUDLEuekxaXYdE9wk9NoSzW/kmH1WAI+8OectQ5
	hu/BztsfQyriUjRMhCKN3Uh2XUF7H5ViPWcJEflBqGOaNXyBwYqZUw4z2YTQS+ev7Nwn8xsV/xv
	DudUKuAIHG2c9x293NfarByWrtf/6KEXfIk+P1qMPrWvcEas8SoDyrr9V/PD9foPNcEJn6xNKsA
	726azukiALaihXhFiCMrUMguIfA+gW1zCNM4j88nYObU9R8beEseuLf2/E15R9WrSKK1dno3t9L
	8UdWu5sXe/mZMl6BgJ8Vu9ZZMuC01mi4EE6qur4FMxwSKyuwPqvg+OE5qD7aNqcVy/eKSmcJ41q
	bdi9UzOBw==
X-Received: by 2002:a05:6214:468a:b0:8ee:871e:f2e0 with SMTP id 6a1803df08f44-8fec179bb97mr159104816d6.27.1783700088100;
        Fri, 10 Jul 2026 09:14:48 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-902de1fdb3bsm17894416d6.23.2026.07.10.09.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:14:47 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH] rteval: Set measurement cpuset to partition=isolated for CPU isolation
Date: Fri, 10 Jul 2026 12:14:32 -0400
Message-ID: <20260710161432.117058-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the rteval_measurement cpuset from partition=member to
partition=isolated to provide kernel-enforced CPU isolation for
measurement workloads.

With partition=isolated, the kernel prevents tasks from being scheduled
on measurement CPUs unless explicitly placed there, eliminating
interference from system tasks and the load balancer. This is essential
for accurate latency measurements.

The existing error handling in write_cpu_exclusive() ensures graceful
fallback to partition=member if isolated partitions are not supported
by the kernel.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/cpusetmanager.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/cpusetmanager.py b/rteval/cpusetmanager.py
index 2fe931cc4574..abf5760db28c 100644
--- a/rteval/cpusetmanager.py
+++ b/rteval/cpusetmanager.py
@@ -125,7 +125,7 @@ class CpusetManager:
         self.measurement_cpuset = Cpuset('rteval_measurement')
         self.measurement_cpuset.write_memnode(self.numa_nodes)
         self.measurement_cpuset.assign_cpus(collapse_cpulist(self.measurement_cpus))
-        self.measurement_cpuset.write_cpu_exclusive(False)  # partition=member
+        self.measurement_cpuset.write_cpu_exclusive(True)  # partition=isolated
 
         self.logger.log(Log.INFO, "Cpusets created successfully")
         return self
-- 
2.54.0

