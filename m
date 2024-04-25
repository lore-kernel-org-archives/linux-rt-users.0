Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE6314F118
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2024 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068468; cv=none; b=cpixubCjtMw2oxkzf2halpo/7DjlAoqj75xWWnDAVaXNOUxP0gFmzCjyExpmhV82Mg7qzxAeAhs7xugou9sH/qzxsNS9QyyecO5d6DVThbD2jZ1+rjfkzMis67YqPCSYeJU6pI+8GCQAZIX3qdlRH5LMMZ3MAPh08zG6N6vLvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068468; c=relaxed/simple;
	bh=ePm/6up5fLhOqSqCorHerJk8LojZDdgaFfmLuaZtXnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX4IFVpTx6gAwvoCYXTE/8vOo9FX3CBAEqIDLF1AV5ugvxukbgvBfsT42oBOZhezzoRF61KcNoXB7NqNQKhsO8nXw/MQR2bxRFmgv3lwzqvirqqhKdPpAvaBJFiOZ88NYKghwB+0nmX5IqKx85jBg67B+6vebTwhOB1/nw06mrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN5uG/CF; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN5uG/CF"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b6d36b71cso8977856d6.3
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Apr 2024 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068464; x=1714673264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ikcKqd3zYYDXNyUhMBWkLtYQk1f4ScT9rkX3RTEbeg=;
        b=dN5uG/CFqnGJT7B/+9B0zr16iIiY5IFg+D3f64B8nfNK7K+3XZQ40fDN/EoM0myJ6h
         hdqrAoGhWp0S0tRRpWETBV4CZupC9mTXh6cNBA0+w4r3PWpT0OAGUHve5hBFKKnIYXZD
         CLkRJjHoB9DavuywQNrfjduYETi+ty9OxoIZb82DVV7+f1hcPRy6sK9u9UtlEJYVLFzm
         FkL7ZYPSgcEOZlLNcb5hQXW/lTkmJ8ZoYn2owwjKNia6SHCuvDj9wh7N2vqFRsDdkaWs
         vVhZTjPD5Ax2zyeWhzDZvcOZmZWn1tje5WHiNBl5my5z/rwogi2riaP48qbZvDjIlM4D
         QytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068464; x=1714673264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ikcKqd3zYYDXNyUhMBWkLtYQk1f4ScT9rkX3RTEbeg=;
        b=OU4T3pp+h5DTb8ukKBycj7vbsm7a04t8CgIcIpLNWoe9yg3FCldWhE5X/Exts9fNsp
         9B9TklJWth66T7mSSPJ/hM0FHKjHfdHRlbpEY5RXYAKeZE0+DCFWnl1MstMcdUnpbUCJ
         rs/n5iATAwX9XrQDctZWtyjcjCfPi6y9PomhBDOIFYK58NBITXS/yGNoXP5umj1vo9Gj
         Ni8ATs7ou6r+h8FjyRz8AXDnScOAr7NhepV7fQwYm1fRcrSLb+ZevCO+iHxI4mTjOubY
         t5Lbk/jrFV0ozsc0vMn22MjZwTTzh1ybZmJfmUHtCV23ts3BoX4YUb7E8Nw6HqNilWnI
         QrGQ==
X-Gm-Message-State: AOJu0Yx047dPvZxkpdE6k52CIvo80/+QWRO/wDadzV4yioargbvbb5QJ
	LH4oDPh63jAGf8eNiFA3tkuCb34jSS4fgJSP4sWtk/C3EPdcCgTuFsV1CA==
X-Google-Smtp-Source: AGHT+IEp4ETfVGB5bhTHqD2VXmaFKJDwLUtdcl0ImdNUyA1fuNRmG/UFlXyHhmCfr/OvHzmSdnkmPA==
X-Received: by 2002:a05:6214:5092:b0:6a0:a7c8:1acb with SMTP id kk18-20020a056214509200b006a0a7c81acbmr589281qvb.2.1714068464243;
        Thu, 25 Apr 2024 11:07:44 -0700 (PDT)
Received: from fionn.redhat.com ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id n5-20020a0cdc85000000b0069b7c8ced6asm2103931qvk.12.2024.04.25.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 11:07:43 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Daniel Bristot de Oliveria <bristot@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/4] rteval: timerlat.py Add statistics and generate xml
Date: Thu, 25 Apr 2024 14:07:23 -0400
Message-ID: <20240425180723.66499-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425180723.66499-1-jkacur@redhat.com>
References: <20240425180723.66499-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds calculating statitics such as samples (count), min, max, mean,
median, mode, range, absolute and standard deviations to xml

Currently it combines the kernel thread, IRQs and userspace threads into
one statistic like it does with cyclictest, but in the future we can
separate this out too.

To see this functioning from git, do this,

su -c 'python rteval/modules/measurement/timerlat.py '

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 266 ++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 7 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index d4e78de8d2a2..9fa931043e40 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -8,12 +8,170 @@ import subprocess
 import signal
 import time
 import tempfile
+import math
+import sys
 import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
 from rteval.systopology import cpuinfo, SysTopology
 from rteval.cpulist_utils import expand_cpulist, collapse_cpulist
 
+class TLRunData:
+    ''' class to store instance data from a timerlat run '''
+    def __init__(self, coreid, datatype, priority, logfnc):
+        self.__id = coreid
+        self.__type = datatype
+        self.__priority = int(priority)
+        self.description = ''
+        self._log = logfnc
+        self.duration = ''
+        # histogram data, irqs, kernel threads and user threads per core
+        self.irqs = {}
+        self.thrs = {}
+        self.usrs = {}
+        self.__samples = {}
+        self.__numsamples = 0
+        self.min = 100000000
+        self.max = 0
+        self.__stddev = 0.0
+        self.__mean = 0.0
+        self.__mode = 0.0
+        self.__median = 0.0
+        self.__range = 0.0
+
+    def update_max(self, value):
+        """ highest bucket with a value """
+        if value > self.max:
+            self.max = value
+
+    def update_min(self, value):
+        """ lowest bucket with a value """
+        if value < self.min:
+            self.min = value
+
+    def bucket(self, index, val1, val2, val3):
+        """ Store results index=bucket number, val1=IRQ, val2=thr, val3=usr """
+        values = val1 + val2 + val3
+        self.__samples[index] = self.__samples.setdefault(index, 0) + values
+        self.irqs[index] = val1
+        self.thrs[index] = val2
+        self.usrs[index] = val3
+        if values:
+            self.update_max(index)
+            self.update_min(index)
+        self.__numsamples += values
+
+    def reduce(self):
+        """ Calculate statistics """
+        # Check to see if we have any samples. If there are 1 or 0, return
+        if self.__numsamples <= 1:
+            self._log(Log.DEBUG, f"skipping {self.__id} ({self.__numsamples} sampples)")
+            self.__mad = 0
+            self.__stddev = 0
+            return
+
+        self._log(Log.INFO, f"reducing {self.__id}")
+        total = 0   # total number of samples
+        total_us = 0
+        keys = list(self.__samples.keys())
+        keys.sort()
+
+        # if numsamples is odd, then + 1 gives us the actual mid
+        # if numsamples is even, we avg mid and mid + 1, so we actually
+        # want to know mid + 1 since we will combine it with mid and
+        # the lastkey if the last key is at the end of a previous bucket
+        mid = int(self.__numsamples / 2) + 1
+
+        # mean, mode and median
+        occurances = 0
+        lastkey = -1
+        for i in keys:
+            if mid > total and mid <= total + self.__samples[i]:
+                # Test if numsamples is even and if mid+1 is the next bucket
+                if self.__numsamples & 1 != 0 and mid == total+1:
+                    self.__median = (lastkey + i) / 2
+                else:
+                    self.__median = i
+            lastkey = i
+            total += self.__samples[i]
+            total_us += i * self.__samples[i]
+            if self.__samples[i] > occurances:
+                occurances = self.__samples[i]
+                self.__mode = i
+        self.__mean = float(total_us) / float(self.__numsamples)
+
+        # range
+        for i in keys:
+            if self.__samples[i]:
+                low = i
+                break
+        high = keys[-1]
+        while high and self.__samples.setdefault(high, 0) == 0:
+            high -= 1
+        self.__range = high - low
+
+        # Mean Absolute Deviation and Standard Deviation
+        madsum = 0
+        varsum = 0
+        for i in keys:
+            madsum += float(abs(float(i) - self.__mean) * self.__samples[i])
+            varsum += float(((float(i) - self.__mean) ** 2) * self.__samples[i])
+        self.__mad = madsum / self.__numsamples
+        self.__stddev = math.sqrt(varsum / (self.__numsamples - 1))
+
+
+    def MakeReport(self):
+        rep_n = libxml2.newNode(self.__type)
+
+        if self.__type == 'system':
+            rep_n.newProp('description', self.description)
+        else:
+            rep_n.newProp('id', str(self.__id))
+            rep_n.newProp('priority', str(self.__priority))
+
+        stat_n = rep_n.newChild(None, 'statistics', None)
+        stat_n.newTextChild(None, 'samples', str(self.__numsamples))
+
+        if self.__numsamples > 0:
+            n = stat_n.newTextChild(None, 'minimum', str(self.min))
+            n.newProp('unit', 'us')
+
+            n = stat_n.newTextChild(None, 'maximum', str(self.max))
+            n.newProp('unit', 'us')
+
+            n = stat_n.newTextChild(None, 'median', str(self.__median))
+            n.newProp('unit', 'us')
+
+            n = stat_n.newTextChild(None, 'mode', str(self.__mode))
+            n.newProp('unit', 'us')
+
+            n = stat_n.newTextChild(None, 'range', str(self.__range))
+            n.newProp('unit', 'us')
+
+            n = stat_n.newTextChild(None, 'mean', str(self.__mean))
+            n.newProp('unit', 'us')
+
+            n = stat_n.newTextChild(None, 'mean_absolute_deviation', str(self.__mad))
+            n.newProp('unit', 'us')
+
+            n = stat_n.newTextChild(None, 'standard_deviation', str(self.__stddev))
+            n.newProp('unit', 'us')
+
+        hist_n = rep_n.newChild(None, 'histogram', None)
+        hist_n.newProp('nbuckets', str(len(self.__samples)))
+
+        keys = list(self.__samples.keys())
+        keys.sort()
+        for k in keys:
+            if self.__samples[k] == 0:
+                # Don't report buckets without any samples
+                continue
+            b_n = hist_n.newChild(None, 'bucket', None)
+            b_n.newProp('index', str(k))
+            b_n.newProp('value', str(self.__samples[k]))
+
+        return rep_n
+
 class Timerlat(rtevalModulePrototype):
     """ measurement modules for rteval """
     def __init__(self, config, logger=None):
@@ -23,6 +181,8 @@ class Timerlat(rtevalModulePrototype):
 
         self.__numanodes = int(self.__cfg.setdefault('numanodes', 0))
         self.__priority = int(self.__cfg.setdefault('priority', 95))
+        default_buckets = ModuleParameters()["buckets"]["default"]
+        self.__buckets = int(self.__cfg.setdefault('buckets', default_buckets))
 
         self.__cpulist = self.__cfg.setdefault('cpulist', "")
         self.__cpus = [str(c) for c in expand_cpulist(self.__cpulist)]
@@ -31,6 +191,20 @@ class Timerlat(rtevalModulePrototype):
         self.__timerlat_out = None
         self.__timerlat_err = None
         self.__started = False
+
+        # Create a TLRunData object for each core we'll measure
+        info = cpuinfo()
+        self.__timerlatdata = {}
+        for core in self.__cpus:
+            self.__timerlatdata[core] = TLRunData(core, 'core', self.__priority,
+                                                logfnc=self._log)
+            self.__timerlatdata[core].description = info[core]['model name']
+
+        # Create a TLRunData object for the overall system
+        self.__timerlatdata['system'] = TLRunData('system', 'system',
+                                                  self.__priority,
+                                                  logfnc=self._log)
+        self.__timerlatdata['system'].description = (f"({self.__numcores} cores) ") + info['0']['model name']
         self._log(Log.DEBUG, f"system using {self.__numcores} cpu cores")
 
 
@@ -43,6 +217,7 @@ class Timerlat(rtevalModulePrototype):
     def _WorkloadPrepare(self):
         self.__cmd = ['rtla', 'timerlat', 'hist', '-P', f'f:{int(self.__priority)}', '-u']
         self.__cmd.append(f'-c{self.__cpulist}')
+        self.__cmd.append(f'-E{self.__buckets}')
         self._log(Log.DEBUG, f'self.__cmd = {self.__cmd}')
         self.__timerlat_out = tempfile.SpooledTemporaryFile(mode='w+b')
         self.__timerlat_err = tempfile.SpooledTemporaryFile(mode='w+b')
@@ -77,16 +252,82 @@ class Timerlat(rtevalModulePrototype):
             os.kill(self.__timerlat_process.pid, signal.SIGINT)
             time.sleep(2)
 
-        self._setFinished()
-        self.__started = False
-
-    def MakeReport(self):
+        # Parse histogram output
         self.__timerlat_out.seek(0)
         for line in self.__timerlat_out:
             line = bytes.decode(line)
-            print(line)
+
+            # Skip any blank lines
+            if not line:
+                continue
+
+            if line.startswith('#'):
+                if line.startswith('# Duration:'):
+                    duration = line.split()[2]
+                    duration += line.split()[3]
+                    self.__timerlatdata['system'].duration = duration
+                continue
+            elif line.startswith('Index'):
+                #print(line)
+                continue
+            elif line.startswith('over:'):
+                #print(line)
+                continue
+            elif line.startswith('count:'):
+                #print(line)
+                continue
+            elif line.startswith('min:'):
+                #print(line)
+                continue
+            elif line.startswith('avg:'):
+                #print(line)
+                continue
+            elif line.startswith('max:'):
+                #print(line)
+                continue
+            else:
+                pass
+                #print(line)
+
+            vals = line.split()
+            if not vals:
+                # If we don't have any values, don't try parsing
+                continue
+            try:
+                # The index corresponds to the bucket number
+                index = int(vals[0])
+            except:
+                self._log(Log.DEBUG, f'timerlat: unexpected output: {line}')
+                continue
+
+            for i, core in enumerate(self.__cpus):
+                self.__timerlatdata[core].bucket(index, int(vals[i*3+1]),
+                                                 int(vals[i*3+2]),
+                                                 int(vals[i*3+3]))
+                self.__timerlatdata['system'].bucket(index, int(vals[i*3+1]),
+                                                 int(vals[i*3+2]),
+                                                 int(vals[i*3+3]))
+        # Generate statistics for each RunData object
+        for n in list(self.__timerlatdata.keys()):
+            self.__timerlatdata[n].reduce()
+
         self.__timerlat_out.close()
 
+        self._setFinished()
+        self.__started = False
+
+    def MakeReport(self):
+        rep_n = libxml2.newNode('timerlat')
+        rep_n.newProp('command_line', ' '.join(self.__cmd))
+
+        rep_n.addChild(self.__timerlatdata['system'].MakeReport())
+        for thr in self.__cpus:
+            if str(thr) not in self.__timerlatdata:
+                continue
+            rep_n.addChild(self.__timerlatdata[str(thr)].MakeReport())
+
+        return rep_n
+
 
 def ModuleInfo():
     """ Required measurement module information """
@@ -97,7 +338,10 @@ def ModuleParameters():
     """ default parameters """
     return {"priority": {"descr": "Run rtla timerlat with this priority",
                          "default": 95,
-                         "metavar": "PRIO" }
+                         "metavar": "PRIO" },
+            "buckets":  {"descr": "Number of buckets",
+                         "default": 3500,
+                         "metavar": "NUM"}
            }
 
 def create(params, logger):
@@ -107,6 +351,10 @@ def create(params, logger):
 if __name__ == '__main__':
     from rteval.rtevalConfig import rtevalConfig
 
+    if os.getuid() != 0:
+        print("Must be root to run timerlat!")
+        sys.exit(1)
+
     l = Log()
     l.SetLogVerbosity(Log.INFO|Log.DEBUG|Log.ERR|Log.WARN)
 
@@ -128,4 +376,8 @@ if __name__ == '__main__':
     tl._WorkloadTask()
     time.sleep(RUNTIME)
     tl._WorkloadCleanup()
-    tl.MakeReport()
+    rep_n = tl.MakeReport()
+
+    xml = libxml2.newDoc('1.0')
+    xml.setRootElement(rep_n)
+    xml.saveFormatFileEnc('-', 'UTF-8', 1)
-- 
2.44.0

