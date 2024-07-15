Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42550482EF
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Jul 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067649; cv=none; b=V1LYHy3FD5e4OKQRm1IcRJihxyBaTbdad/aZG46yb55IKys7aiDTCuE9KlycQojE8u6cQs+C0fmxEOW7uLlA1KaIUCDFc75RzfU5EiQi4ZwbYLBAk1h5RjxGUtIONxfi8UurTGqJwrn6s039U1n2pW6AExH1Amed6Vg4CwnsF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067649; c=relaxed/simple;
	bh=B/72FNigha2uauKfLEimEVqyr01EyEroFwtPOH9Wxjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TuOl6YAFZVjSQfNmS0VkNgXArtUuLsTiwAGPKj+Os+8BiVMT5BeM+BtIrPHuL8YerRQ/xq7DjvFuKCl9MMjc6xxGZ4KkHuTK1/xsJT/0L3BZqGIqKcU0WgqttIPqXNI/kZ3bJ83txW81gxp9wkbxxwTU+oYXYIXnlvTVoJGU4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtybsXOA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtybsXOA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721067647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KCouTB7nP7HDQhX0jWqH1ZMzcwoP6dJP8BB90L3WJwg=;
	b=WtybsXOAITYVPKDsACXRi+IsbPPS1A9G3xWRkcVjQiFPWld4mvql+nJhR+2KCOnMRTT8iV
	k4b7rZileM/KCZwy9ow0lJGaigNSqxcUct9BxicUSv02gjMoQVzOU2+v6urZBOa0DShWjl
	A58BLFObcvM38ICgS+dHfSDL+EDY28I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-w7ZOZ1hNPny3E3C8QXPAKw-1; Mon,
 15 Jul 2024 14:20:45 -0400
X-MC-Unique: w7ZOZ1hNPny3E3C8QXPAKw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E2021955D47
	for <linux-rt-users@vger.kernel.org>; Mon, 15 Jul 2024 18:20:45 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.64.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E55119560AE;
	Mon, 15 Jul 2024 18:20:43 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 2/2] rteval: run cyclictest using '--default-system' when setting idle states
Date: Mon, 15 Jul 2024 14:20:36 -0400
Message-ID: <20240715182035.191318-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When running cyclictest in rteval, cyclictest automatically disables
idle states. This means whenever the user sets the idle state of a cpu
list using '--idle-set' it is overridden by cyclictest.

To fix this, the variable 'usingCpupower' is appended to the parameter
dictionary that's passed to the Cyclictest measurement object which executes
cyclictest in rteval.

If '--idle-set' is specified when running rteval,
'usingCpupower' is set to true and the '--default-system' option is
appended to the cyclictest command, which will prevent cyclictest from
disabling cstates.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval-cmd                               | 3 +++
 rteval/__init__.py                       | 1 +
 rteval/modules/measurement/cyclictest.py | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/rteval-cmd b/rteval-cmd
index d9bf16838b6d..f96772c7027e 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -268,6 +268,9 @@ if __name__ == '__main__':
                 | (rtevcfg.debugging and Log.DEBUG)
         logger.SetLogVerbosity(loglev)
 
+        # check if cpupower is being used
+        if sys.argv.count('--idle-set') > 0:
+            rtevcfg.update({'usingCpupower': True})
         # Load modules
         loadmods = LoadModules(config, logger=logger)
         measuremods = MeasurementModules(config, logger=logger)
diff --git a/rteval/__init__.py b/rteval/__init__.py
index 1a61148ef327..ad3de3a04b97 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -123,6 +123,7 @@ class RtEval(rtevalReport):
                   'memsize':self._sysinfo.mem_get_size(),
                   'numanodes':self._sysinfo.mem_get_numa_nodes(),
                   'duration': float(self.__rtevcfg.duration),
+                  'usingCpupower': self.__rtevcfg.usingCpupower
                   }
         self._loadmods.Setup(params)
 
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 3301e1b45e11..80c75d6e857c 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -250,6 +250,9 @@ class Cyclictest(rtevalModulePrototype):
         self.__cmd.append(f'-t{self.__numcores}')
         self.__cmd.append(f'-a{self.__cpulist}')
 
+        if (self.__cfg.usingCpupower):
+            self.__cmd.append('--default-system')
+
         if 'threads' in self.__cfg and self.__cfg.threads:
             self.__cmd.append(f"-t{int(self.__cfg.threads)}")
 
-- 
2.45.2

