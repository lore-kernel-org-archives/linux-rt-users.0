Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69908502A9
	for <linux-rt-users@vger.kernel.org>; Fri, 12 Apr 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947895; cv=none; b=qJAJ09EV0LVxqOeDOo+OVf5DAp09cQm95YOsuv6kCaOWTFscqgXeyCHLtegyxIAv03/gNdjmFcIJhf2vdQCIRYkJSSskyahtpP6ftCsckiOTGjcf63puqB/XDoBHUMkTr4hjc09hG0M9YX1FmY5VE30vxmDfNX/Ol01Okp9/pKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947895; c=relaxed/simple;
	bh=XzGwgVP800Qqt0Lq6nPLDXvFOpY4463WqkJRzjgbiR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0k01kXd5kTvzNeFWmeGH+0ZJlxk6wrjx1POM6d/2PcoqlHXzjI+8sxc3tudmD9DE6rWqpDq53CZq4AH0OPIbLKIUDerTv6WqaeyvjS01ZwFp3FBcAClPNIpN/xHNUHBGzvBw+JzfNrr9HfFSsOt6S0izJaIvUhB5y2aG/B0yD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8i6DuDZ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8i6DuDZ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6150670d372so11856967b3.1
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Apr 2024 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712947892; x=1713552692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP9TvVmT/+srt8gV2VQaWYsPoljM418Ggkc6YqQj+QY=;
        b=X8i6DuDZ91aHGtzKEfGhpXa1c/YHLQV2FcLmmiwuAvGsbNeS7Oi8h4hSvzn6A2DdpY
         4dd5GAJcJcn2Rw0oaWgEoi8yRPdlEHIrys31yZNp2emOR3Z56XFuNbXT2kmO25lwSc4y
         TK569TDYYv3rofpSiaklZMS6L2JNIR5ULwPQ1y2zBtzn8Y4tv36Hxwq/4BhRa7SlDmBP
         P90WTX3TORfkomgYcCioBLhVDM81JXkVhENPNYF4mL7cNVzemOS/0zECO5e+A7gmuhT6
         KddKboYHhFVQxCEutqgTGWraBUQOCGsoqq7fjPaH74/nrvGj06rFur8ayHDl1HUAZmgM
         K16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947892; x=1713552692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PP9TvVmT/+srt8gV2VQaWYsPoljM418Ggkc6YqQj+QY=;
        b=g4JYYnHMdrs7TgOXD9fKf8roQ++odKlZwKN3ckVBTiRLunp095JI5NRQrpzqBAGfyQ
         tdXPoCYF4THuE2SUCTUROzpmwALowSsTM2nJDiKL9TG51hEgJpnQmozOVPFZ3gK+CmRa
         Mg6IQWteWojB4q0/9xQM4g+60SySyaOtWIqbCV562o9OiYK1KoyzBWvEaz7FlYT040sa
         NkPwPk6sR/af6QIjxUEh9iv62rIf8DvY7wHMBtPRT7YrizmCo3GJwK232Vw27AvrYJZU
         CCJYToNRmALXG0rTttYegzjFuCFsClpHgkbtwOxPKHpWdC0szXaA7E4srMCh+he8w/YF
         N2sA==
X-Gm-Message-State: AOJu0Yx8GFMC2b1dTx44/vYjWCeUUp/dRmcXvDB4+ha4huLLCPkVl3BH
	xLdyQNePMjhoJf/tpZ0rgcGPBvFx8gapTupVtLFa9/Sg/WEHuaWW4F7gxw==
X-Google-Smtp-Source: AGHT+IEgjNqWg3JYi2nXzHcF0mFCH7a3J1P7/+NU46Vlzsquuvt/UBUgW1ecvTANcRz5MhDDNwOXlA==
X-Received: by 2002:a81:7e06:0:b0:618:517b:9dcf with SMTP id o6-20020a817e06000000b00618517b9dcfmr3107070ywn.22.1712947891797;
        Fri, 12 Apr 2024 11:51:31 -0700 (PDT)
Received: from fionn.redhat.com ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id dj12-20020a056214090c00b0069b3bfdea09sm2628750qvb.60.2024.04.12.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:51:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveria <bristot@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rteval: Add rtla timerlat as a measurement module
Date: Fri, 12 Apr 2024 14:50:52 -0400
Message-ID: <20240412185052.87056-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412185052.87056-1-jkacur@redhat.com>
References: <20240412185052.87056-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first step to adding timerlat as a measurement module
With this change you can run timerlat as a standalone rteval file like
this (as root)

python rteval/modules/measurement/timerlat.py

You can also modify your rteval.conf to list timerlat in the
[measurement] section, for example like this

[measurement]
cyclictest: module
timerlat: module

and then both measurement moduels will be run from rteval, for example

rteval -D -d5m --measurement-cpulist=1-5

Will run rteval with Debug info, for 5m and cyclictest and timerlat will
run on cpus 1-5 and load modules will run on the other available cpus.

Currently MakeReport just prints to standard out the same information
that timerlat outputs, in otherwords, there is no processing into xml
yet. Also, there is no way to invoke tracing at the time, but that will
be added soon!

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                             |   1 +
 rteval/modules/measurement/timerlat.py | 131 +++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 rteval/modules/measurement/timerlat.py

diff --git a/rteval-cmd b/rteval-cmd
index c72bc614ad78..5cb6d7a44523 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -247,6 +247,7 @@ if __name__ == '__main__':
             if not config.HasSection('measurement'):
                 config.AppendConfig('measurement', {
                     'cyclictest' : 'module',
+                    'timerlat' : 'module',
                     'sysstat' : 'module'})
 
         # Prepare log levels before loading modules, not to have unwanted log messages
diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
new file mode 100644
index 000000000000..d4e78de8d2a2
--- /dev/null
+++ b/rteval/modules/measurement/timerlat.py
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   Copyright 2024  John Kacur <jkacur@redhat.com>
+#
+""" timerlat.py - objectd to manage rtla timerlat """
+import os
+import subprocess
+import signal
+import time
+import tempfile
+import libxml2
+from rteval.Log import Log
+from rteval.modules import rtevalModulePrototype
+from rteval.systopology import cpuinfo, SysTopology
+from rteval.cpulist_utils import expand_cpulist, collapse_cpulist
+
+class Timerlat(rtevalModulePrototype):
+    """ measurement modules for rteval """
+    def __init__(self, config, logger=None):
+        rtevalModulePrototype.__init__(self, 'measurement', 'timerlat', logger)
+
+        self.__cfg = config
+
+        self.__numanodes = int(self.__cfg.setdefault('numanodes', 0))
+        self.__priority = int(self.__cfg.setdefault('priority', 95))
+
+        self.__cpulist = self.__cfg.setdefault('cpulist', "")
+        self.__cpus = [str(c) for c in expand_cpulist(self.__cpulist)]
+        self.__numcores = len(self.__cpus)
+
+        self.__timerlat_out = None
+        self.__timerlat_err = None
+        self.__started = False
+        self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
+
+
+    def _WorkloadSetup(self):
+        self.__timerlat_process = None
+
+    def _WorkloadBuild(self):
+        self._setReady()
+
+    def _WorkloadPrepare(self):
+        self.__cmd = ['rtla', 'timerlat', 'hist', '-P', f'f:{int(self.__priority)}', '-u']
+        self.__cmd.append(f'-c{self.__cpulist}')
+        self._log(Log.DEBUG, f'self.__cmd = {self.__cmd}')
+        self.__timerlat_out = tempfile.SpooledTemporaryFile(mode='w+b')
+        self.__timerlat_err = tempfile.SpooledTemporaryFile(mode='w+b')
+
+    def _WorkloadTask(self):
+        if self.__started:
+            return
+
+        self._log(Log.DEBUG, f'starting with cmd: {" ".join(self.__cmd)}')
+
+        self.__timerlat_out.seek(0)
+        self.__timerlat_err.seek(0)
+        try:
+            self.__timerlat_process = subprocess.Popen(self.__cmd,
+                                                       stdout=self.__timerlat_out,
+                                                       stderr=self.__timerlat_err,
+                                                       stdin=None)
+            self.__started = True
+        except OSError:
+            self.__started = False
+
+    def WorkloadAlive(self):
+        if self.__started:
+            return self.__timerlat_process.poll() is None
+        return False
+
+    def _WorkloadCleanup(self):
+        if not self.__started:
+            return
+        while self.__timerlat_process.poll() is None:
+            self._log(Log.DEBUG, "Sending SIGINT")
+            os.kill(self.__timerlat_process.pid, signal.SIGINT)
+            time.sleep(2)
+
+        self._setFinished()
+        self.__started = False
+
+    def MakeReport(self):
+        self.__timerlat_out.seek(0)
+        for line in self.__timerlat_out:
+            line = bytes.decode(line)
+            print(line)
+        self.__timerlat_out.close()
+
+
+def ModuleInfo():
+    """ Required measurement module information """
+    return {"parallel": True,
+            "loads": True}
+
+def ModuleParameters():
+    """ default parameters """
+    return {"priority": {"descr": "Run rtla timerlat with this priority",
+                         "default": 95,
+                         "metavar": "PRIO" }
+           }
+
+def create(params, logger):
+    """ Instantiate a Timerlat measurement module object"""
+    return Timerlat(params, logger)
+
+if __name__ == '__main__':
+    from rteval.rtevalConfig import rtevalConfig
+
+    l = Log()
+    l.SetLogVerbosity(Log.INFO|Log.DEBUG|Log.ERR|Log.WARN)
+
+    cfg = rtevalConfig({}, logger=l)
+    prms = {}
+    modprms = ModuleParameters()
+    for c, p in list(modprms.items()):
+        prms[c] = p['default']
+    cfg.AppendConfig('timerlat', prms)
+
+    cfg_tl = cfg.GetSection('timerlat')
+    cfg_tl.cpulist = collapse_cpulist(SysTopology().online_cpus())
+
+    RUNTIME = 10
+
+    tl = Timerlat(cfg_tl, l)
+    tl._WorkloadSetup()
+    tl._WorkloadPrepare()
+    tl._WorkloadTask()
+    time.sleep(RUNTIME)
+    tl._WorkloadCleanup()
+    tl.MakeReport()
-- 
2.44.0

