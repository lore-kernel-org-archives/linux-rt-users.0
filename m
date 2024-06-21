Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F43186A
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978234; cv=none; b=hUxMTreFkPg/OuB3taUMJpTb2pdYqpukyPMJawnWBkqJvoiadg2qioIPeNLIi8nkMSg8gPs/CrbglWadb6vp2JPb4ghuHIjbnOmMTi5OupU/5RsqyEu1IXoJeNhl2BcnIdYQ5yG6MksLEFraU1T2lQD4w6spDkLQnenozWgs86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978234; c=relaxed/simple;
	bh=cJRsr7ia4K9Dp+klupfkLuBLuZUFjMHFK4+xePf68dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rd7/njgxsKflpSnZoNi1MLiy9zdmI3wBH56+cIAYyimr1IlIMbBvbS05rfjzrS4b1GRf+SWXedYe+Cdf5howspR5akYfIohq9Qvcxm8RHfrVxl5Xl3UA/ZrwFV7JGKhr69/e9/Pb6xtCc42Z979o25zNwZQpfnFOEV6QyKPGsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRrK8y9g; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRrK8y9g"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7955ddc6516so149789485a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 06:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718978231; x=1719583031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=X40wo7yIwM9hieyMQk2+SvAYAERJ17XQAkHG2c++juY=;
        b=JRrK8y9g7JFxvQwz0JNyqsBVZF9MZKxVL2F9dDf6qVPo0vvoPVMBENi6CXf94yW7/H
         ngBYf1IyNODYx8PKg2LxsGNCn9bf8KNFa9vrLaIFyk0UO/PomXTlFHnLHvZELhNxN4pU
         AMsx/5v1fbSoOVjRqUFUgC22d+xGjKfD+5MpqMIiVWCajlrepMnswhJOmFnQVndQmYEm
         L7nNrIljr03VFmAaj1XM6lfEct5POMqmt+F5XCfm0OyXVAk+chPS+o1kfP61pMBkFM/r
         8X0zeyrXkccbEQwiDuY+P73T/Tpg/Q+eljLp+hgiZvTrYXozWrL3jQp+DvrVAB9sZh9S
         7wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718978231; x=1719583031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X40wo7yIwM9hieyMQk2+SvAYAERJ17XQAkHG2c++juY=;
        b=O1gH3UQFXpfYwKmQh5sJBdJUXEUjJzy6v0x+prtYAtcBqluDcE8GEJpOwrvTIjX6lT
         sMkhaTPyDG78rpUBeo2dXg/rPlkTszqlDAWBSVL/tFY0H4vdb0/JfZZjh7cMrP3MoeTH
         /Mnvo+/zBKpRFcGiTt6pGYpag4S7yDtAhJxe+4R7eSBzCop4jZWz5H/2nME58vWi6Sa5
         KXnaNEDDiOhtH3JsJEh76SVaJhJ9QmXE0x7DkGNkYRCmx+LU7e5X7SxxQ+/s2kY1a4qm
         ZiYAjA1Q1JHsOWdq8nB6QEOlkVFVXcZZkCJhCWMDr0O67P7Uo2bn9oyJ9s/OELuhyoy3
         3wKQ==
X-Gm-Message-State: AOJu0Yz6JUm6QLd38XObD9xz+2cdHieBH9hqqEeG+6DpLTW7LZJ3CWhD
	TTZjcASQ8RvQkqRTOsJ//svOmgT8o2x9gLNQyI9QwTvquiMN7xmRjjQyysNl
X-Google-Smtp-Source: AGHT+IFE7Ce/R9GLfGnjRCC9Cj4F+I8IZtPOdbTYcoMo+rOpIe4rz152AxOzGzPSvkI8fcKDLNNsHg==
X-Received: by 2002:ad4:4dc7:0:b0:6b2:da77:9a42 with SMTP id 6a1803df08f44-6b501e24194mr86124866d6.16.1718978231188;
        Fri, 21 Jun 2024 06:57:11 -0700 (PDT)
Received: from localhost.localdomain ([76.71.123.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef678ebsm8925016d6.132.2024.06.21.06.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:57:10 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	Daniel Bristot de Oliveria <bristot@kernel.org>,
	Crystal Wood <crwood@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	John Wyatt <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: timerlat: Add timerlat tracing to rteval
Date: Fri, 21 Jun 2024 09:56:27 -0400
Message-ID: <20240621135627.80609-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds tracing from timerlat to rteval.

These two options are added

  --timerlat-stoptrace USEC
                        Stop trace if thread latency higher than USEC
  --timerlat-trace FILE
                        File to save trace to

This also stores the summary from rtla timerlat in the rteval xml file.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 213 ++++++++++++++++++++++++-
 rteval/rteval_text.xsl                 | 181 ++++++++++++++++++++-
 2 files changed, 389 insertions(+), 5 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index e8345fab1ad7..45adec1b33e1 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -16,6 +16,7 @@ from rteval.modules import rtevalModulePrototype
 from rteval.systopology import cpuinfo, SysTopology
 from rteval.cpulist_utils import expand_cpulist, collapse_cpulist
 
+
 class TLRunData:
     ''' class to store instance data from a timerlat run '''
     def __init__(self, coreid, datatype, priority, logfnc):
@@ -188,6 +189,15 @@ class Timerlat(rtevalModulePrototype):
         self.__cpus = [str(c) for c in expand_cpulist(self.__cpulist)]
         self.__numcores = len(self.__cpus)
 
+        # Has tracing been triggered
+        self.__stoptrace = False
+        # This stores the output from rtla
+        self.__posttrace = ""
+        # Stop Trace Data
+        self.__stdata = {}
+        # Stop Trace Cpu
+        self.stcpu = -1
+
         self.__timerlat_out = None
         self.__timerlat_err = None
         self.__started = False
@@ -218,10 +228,21 @@ class Timerlat(rtevalModulePrototype):
         self.__cmd = ['rtla', 'timerlat', 'hist', '-P', f'f:{int(self.__priority)}', '-u']
         self.__cmd.append(f'-c{self.__cpulist}')
         self.__cmd.append(f'-E{self.__buckets}')
+
+        if self.__cfg.stoptrace:
+            self.__cmd.append(f"-T{int(self.__cfg.stoptrace)}")
+
+        if self.__cfg.trace:
+            if not self.__cfg.stoptrace:
+                self._log(Log.WARN, f'Ignoring trace={self.__cfg.trace}, because stoptrace not invoked')
+            else:
+                self.__cmd.append(f'-t={self.__cfg.trace}')
+
         self._log(Log.DEBUG, f'self.__cmd = {self.__cmd}')
         self.__timerlat_out = tempfile.SpooledTemporaryFile(mode='w+b')
         self.__timerlat_err = tempfile.SpooledTemporaryFile(mode='w+b')
 
+
     def _WorkloadTask(self):
         if self.__started:
             return
@@ -252,6 +273,10 @@ class Timerlat(rtevalModulePrototype):
             os.kill(self.__timerlat_process.pid, signal.SIGINT)
             time.sleep(2)
 
+        blocking_thread_detected = False
+        softirq_interference_detected = False
+        irq_interference_detected = False
+
         # Parse histogram output
         self.__timerlat_out.seek(0)
         for line in self.__timerlat_out:
@@ -261,6 +286,113 @@ class Timerlat(rtevalModulePrototype):
             if not line:
                 continue
 
+            # Parsing if stoptrace has been invoked
+            if self.__stoptrace:
+                self.__posttrace += line
+                line = line.strip()
+                fields = line.split()
+                if line.startswith("##") and fields[1] == "CPU":
+                    self.stcpu = int(fields[2])
+                    self._log(Log.DEBUG, f"self.stcpu = {self.stcpu}")
+                    self.__stdata[self.stcpu] = {}
+                    continue
+                if self.stcpu == -1:
+                    self._log(Log.WARN, "Stop trace has been invoked, but a stop cpu has not been identified.")
+                    continue
+                if line.startswith('------------------'):
+                    blocking_thread_detected = False
+                    softirq_interference_detected = False
+                    irq_interference_detected = False
+                    continue
+                if line.startswith("Thread latency:"):
+                    thread_latency_percent = fields[-1].strip('()%')
+                    self._log(Log.DEBUG, f"thread_latency_percent = {thread_latency_percent}")
+                    thread_latency = fields[-3]
+                    self._log(Log.DEBUG, f"thread_latency = {thread_latency}")
+                    self.__stdata[self.stcpu]["Thread_latency"] = (thread_latency, thread_latency_percent)
+                elif line.startswith("Previous IRQ interference"):
+                    self._log(Log.DEBUG, f'Previous_IRQ_interference = {fields[-2]}')
+                    self.__stdata[self.stcpu]["Previous_IRQ_interference"] = fields[-2]
+                elif line.startswith("IRQ handler delay:"):
+                    irq_handler_delay_percent = fields[-2].strip('(')
+                    irq_handler_delay = fields[-4]
+                    # Do we have (exit from idle)?
+                    if fields[3] == '(exit':
+                        field_name = "IRQ_handler_delay_exit_from_idle"
+                    else:
+                        field_name = "IRQ_handler_delay"
+                    self._log(Log.DEBUG, f"{field_name} = {irq_handler_delay}")
+                    self._log(Log.DEBUG, f"{field_name}_percent = {irq_handler_delay_percent}")
+                    self.__stdata[self.stcpu][field_name] = (irq_handler_delay, irq_handler_delay_percent)
+                elif line.startswith("IRQ latency:"):
+                    self._log(Log.DEBUG, f"irq_latency = {fields[-2]}")
+                    self.__stdata[self.stcpu]["IRQ_latency"] = fields[-2]
+                elif line.startswith("Timerlat IRQ duration"):
+                    timerlat_irq_duration_percent = fields[-2].strip('(')
+                    self._log(Log.DEBUG, f"timerlat_irq_duration_percent = {timerlat_irq_duration_percent}")
+                    timerlat_irq_duration = fields[-4]
+                    self._log(Log.DEBUG, f"timerlat_irq_duration = {timerlat_irq_duration}")
+                    self.__stdata[self.stcpu]["Timerlat_IRQ_duration"] = (timerlat_irq_duration, timerlat_irq_duration_percent)
+                elif line.startswith("Blocking thread:"):
+                    blocking_thread_percent = fields[-2].strip('(')
+                    self._log(Log.DEBUG, f"blocking_thread_percent = {blocking_thread_percent}")
+                    blocking_thread = fields[-4]
+                    self._log(Log.DEBUG, f"blocking_thread = {blocking_thread}")
+                    self.__stdata[self.stcpu]["Blocking_Thread"] = (blocking_thread, blocking_thread_percent)
+                    blocking_thread_detected = True
+                    irq_interference_detected = False
+                    softirq_interference_detected = False
+                elif line.startswith("IRQ interference"):
+                    irq_interference_percent = fields[-2].strip('(')
+                    self._log(Log.DEBUG, f"irq_interference_percent = {irq_interference_percent}")
+                    irq_interference = fields[-4]
+                    self._log(Log.DEBUG, f"irq_interference = {irq_interference}")
+                    self.__stdata[self.stcpu]["IRQ_interference"] = (irq_interference, irq_interference_percent)
+                    blocking_thread_detected = False
+                    irq_interference_detected = True
+                    softirq_interference_detected = False
+                elif line.startswith("Softirq interference"):
+                    softirq_interference_percent = fields[-2].strip('(')
+                    self._log(Log.DEBUG, f"softirq_interference_percent = {softirq_interference_percent}")
+                    softirq_interference = fields[-4]
+                    self._log(Log.DEBUG, f"softirq_interference = {softirq_interference}")
+                    self.__stdata[self.stcpu]["Softirq_interference"] = (softirq_interference, softirq_interference_percent)
+                    blocking_thread_detected = False
+                    irq_interference_detected = False
+                    softirq_interference_detected = True
+                elif blocking_thread_detected:
+                    self._log(Log.DEBUG, f'line={line}')
+                    blocking_thread = " ".join(fields[0:-2])
+                    self._log(Log.DEBUG, f"blocking_thread = {blocking_thread}")
+                    blocking_threadus = fields[-2]
+                    self._log(Log.DEBUG, f"blocking_threadus = {blocking_threadus}")
+                    self.__stdata[self.stcpu].setdefault("blocking_thread", [])
+                    self.__stdata[self.stcpu]["blocking_thread"] += [(blocking_thread, blocking_threadus)]
+                elif softirq_interference_detected:
+                    softirq = " ".join(fields[0:-2])
+                    softirq_latency = fields[-2]
+                    self._log(Log.DEBUG, f'softirq = {softirq}')
+                    self._log(Log.DEBUG, f'softirq_latency = {softirq_latency}')
+                    self.__stdata[self.stcpu].setdefault("softirq_interference", [])
+                    self.__stdata[self.stcpu]["softirq_interference"] += [(softirq, softirq_latency)]
+                elif irq_interference_detected:
+                    irq_interference_name = " ".join(fields[0:-2])
+                    irq_interference_latency = fields[-2]
+                    self._log(Log.DEBUG, f'irq_interference = {irq_interference_name}, latency = {irq_interference_latency}')
+                    self.__stdata[self.stcpu].setdefault("irq_interference", [])
+                    self.__stdata[self.stcpu]["irq_interference"] += [(irq_interference_name, irq_interference_latency)]
+                elif line.startswith("Max timerlat IRQ latency"):
+                    self._log(Log.DEBUG, f"line={line}")
+                    max_timerlat_irq_latency = fields[-5]
+                    self._log(Log.DEBUG, f"max_timerlat_irq_latency = {max_timerlat_irq_latency}")
+                    max_timerlat_cpu = int(fields[-1])
+                    self._log(Log.DEBUG, f"max_timerlat_cpu = {max_timerlat_cpu}")
+                    self.__stdata.setdefault(max_timerlat_cpu, {})
+                    self.__stdata[max_timerlat_cpu]["Max_timerlat_IRQ_latency_from_idle"] = max_timerlat_irq_latency
+                else:
+                    self._log(Log.DEBUG, f'line = {line}')
+                continue
+
             if line.startswith('#'):
                 if line.startswith('# Duration:'):
                     duration = line.split()[2]
@@ -285,9 +417,13 @@ class Timerlat(rtevalModulePrototype):
             elif line.startswith('max:'):
                 #print(line)
                 continue
+            elif line.startswith('rtla timerlat hit stop tracing'):
+                self.__stoptrace = True
+                self.__posttrace += line
+                continue
             else:
-                pass
                 #print(line)
+                pass
 
             vals = line.split()
             if not vals:
@@ -301,12 +437,18 @@ class Timerlat(rtevalModulePrototype):
                 continue
 
             for i, core in enumerate(self.__cpus):
-                self.__timerlatdata[core].bucket(index, int(vals[i*3+1]),
+                # There might not be a count on every cpu if tracing invoked
+                if i*3 + 1 >= len(vals):
+                    self.__timerlatdata[core].bucket(index, 0, 0, 0)
+                    self.__timerlatdata['system'].bucket(index, 0, 0, 0)
+                else:
+                    self.__timerlatdata[core].bucket(index, int(vals[i*3+1]),
                                                  int(vals[i*3+2]),
                                                  int(vals[i*3+3]))
-                self.__timerlatdata['system'].bucket(index, int(vals[i*3+1]),
+                    self.__timerlatdata['system'].bucket(index, int(vals[i*3+1]),
                                                  int(vals[i*3+2]),
                                                  int(vals[i*3+3]))
+
         # Generate statistics for each RunData object
         for n in list(self.__timerlatdata.keys()):
             self.__timerlatdata[n].reduce()
@@ -320,6 +462,62 @@ class Timerlat(rtevalModulePrototype):
         rep_n = libxml2.newNode('timerlat')
         rep_n.newProp('command_line', ' '.join(self.__cmd))
 
+        stoptrace_invoked_n = libxml2.newNode('stoptrace_invoked')
+        if self.stcpu != -1:
+            stoptrace_invoked_n.newProp("invoked", "true")
+        else:
+            stoptrace_invoked_n.newProp("invoked", "")
+        rep_n.addChild(stoptrace_invoked_n)
+
+        if self.stcpu != -1:
+            self._log(Log.DEBUG, f'self.__stdata = {self.__stdata}')
+            for cpu in self.__stdata:
+                # This is  Max timerlat IRQ latency from idle
+                # With no other data from that cpu, so don't create a
+                # stoptrace_report for this
+                if len(self.__stdata[cpu]) == 1:
+                    continue
+                stoptrace_n = libxml2.newNode('stoptrace_report')
+                stoptrace_n.newProp("CPU", str(cpu))
+                for k, v in self.__stdata[cpu].items():
+                    self._log(Log.DEBUG, f"cpu={cpu}, k={k}, v={v}")
+                    if isinstance(v, tuple):
+                        latency = str(v[0])
+                        percent = str(v[1])
+                        cpu_n = stoptrace_n.newTextChild(None, str(k), None)
+                        n = cpu_n.newTextChild(None, "latency", latency)
+                        n.newProp('unit', 'us')
+
+                        n = cpu_n.newTextChild(None, "latency_percent", percent)
+                        n.newProp('unit', '%')
+                    elif isinstance(v, list):
+                        if k in ("blocking_thread", "softirq_interference", "irq_interference"):
+                            for name, latency in v:
+                                cpu_n = stoptrace_n.newTextChild(None, k, None)
+                                n = cpu_n.newTextChild(None, "name", name)
+                                n = cpu_n.newTextChild(None, "latency", latency)
+                                n.newProp('unit', 'us')
+                    else:
+                        if k == "Max_timerlat_IRQ_latency_from_idle":
+                            continue
+                        cpu_n = stoptrace_n.newTextChild(None, str(k), str(v))
+                        cpu_n.newProp('unit', 'us')
+                rep_n.addChild(stoptrace_n)
+
+            self._log(Log.DEBUG, f'timerlat: posttrace = \n{self.__posttrace}')
+            self._log(Log.DEBUG, 'timerlat: posttrace END')
+            for cpu in self.__stdata:
+                for k, v in self.__stdata[cpu].items():
+                    if isinstance(v, tuple):
+                        continue
+                    if k == "Max_timerlat_IRQ_latency_from_idle":
+                        max_timerlat_n = libxml2.newNode('max_timerlat_report')
+                        max_timerlat_n.newProp("CPU", str(cpu))
+                        cpu_n = max_timerlat_n.newTextChild(None, k, str(v))
+                        cpu_n.newProp('unit', 'us')
+                        rep_n.addChild(max_timerlat_n)
+            return rep_n
+
         rep_n.addChild(self.__timerlatdata['system'].MakeReport())
         for thr in self.__cpus:
             if str(thr) not in self.__timerlatdata:
@@ -341,7 +539,13 @@ def ModuleParameters():
                          "metavar": "PRIO" },
             "buckets":  {"descr": "Number of buckets",
                          "default": 3500,
-                         "metavar": "NUM"}
+                         "metavar": "NUM" },
+            "stoptrace": {"descr": "Stop trace if thread latency higher than USEC",
+                          "default": None,
+                          "metavar": "USEC" },
+            "trace":    {"descr": "File to save trace to",
+                         "default": None,
+                         "metavar": "FILE" },
            }
 
 def create(params, logger):
@@ -367,6 +571,7 @@ if __name__ == '__main__':
 
     cfg_tl = cfg.GetSection('timerlat')
     cfg_tl.cpulist = collapse_cpulist(SysTopology().online_cpus())
+    cfg_tl.stoptrace=50
 
     RUNTIME = 10
 
diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index 2f03bda0bb55..70777354efa5 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -316,14 +316,26 @@
     <xsl:value-of select="@command_line"/>
     <xsl:text>&#10;&#10;</xsl:text>
 
-    <xsl:apply-templates select="abort_report"/>
+    <xsl:if test="stoptrace_invoked">
+     <xsl:text>rtla timerlat hit stop tracing</xsl:text>
+     <xsl:text>
+</xsl:text>
+    <xsl:apply-templates select="stoptrace_report"/>
+    <xsl:apply-templates select="max_timerlat_report"/>
+    </xsl:if>
 
+    <!-- Make sure the description is available before printing System: -->
+    <xsl:if test="system/@description">
     <xsl:text>          System:  </xsl:text>
     <xsl:value-of select="system/@description"/>
     <xsl:text>&#10;</xsl:text>
+    </xsl:if>
 
+    <!-- If stoptrace_invoked is true, no Statistics are available -->
+    <xsl:if test="stoptrace_invoked != true">
     <xsl:text>          Statistics: &#10;</xsl:text>
     <xsl:apply-templates select="system/statistics"/>
+    </xsl:if>
 
     <!-- Add CPU core info and stats-->
     <xsl:apply-templates select="core">
@@ -470,4 +482,171 @@
       </xsl:if>
   </xsl:template>
 
+  <!-- Format posttrace information if present -->
+  <xsl:template match="stoptrace_report">
+     <xsl:text>## CPU </xsl:text>
+     <xsl:value-of select="@CPU"/>
+     <xsl:text> hit stop tracing, analyzing it ##</xsl:text>
+     <xsl:text>
+</xsl:text>
+
+
+     <xsl:if test="Previous_IRQ_interference">
+     <xsl:text>Previous IRQ interference:			 up to       </xsl:text>
+     <xsl:value-of select="Previous_IRQ_interference"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Previous_IRQ_interference/@unit"/>
+     <xsl:text>
+</xsl:text>
+     </xsl:if>
+
+     <xsl:if test="IRQ_handler_delay">
+     <xsl:text>IRQ handler delay:		                	</xsl:text>
+     <xsl:value-of select="IRQ_handler_delay/latency"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="IRQ_handler_delay/latency/@unit"/>
+     <xsl:text> (</xsl:text>
+     <xsl:value-of select="IRQ_handler_delay/latency_percent"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="IRQ_handler_delay/latency_percent/@unit"/>
+     <xsl:text>)
+</xsl:text>
+     </xsl:if>
+
+     <xsl:if test="IRQ_handler_delay_exit_from_idle">
+     <xsl:text>IRQ handler delay:		(exit from idle)	</xsl:text>
+     <xsl:value-of select="IRQ_handler_delay_exit_from_idle/latency"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="IRQ_handler_delay_exit_from_idle/latency/@unit"/>
+     <xsl:text> (</xsl:text>
+     <xsl:value-of select="IRQ_handler_delay_exit_from_idle/latency_percent"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="IRQ_handler_delay_exit_from_idle/latency_percent/@unit"/>
+     <xsl:text>)
+</xsl:text>
+     </xsl:if>
+
+     <xsl:text>IRQ latency:</xsl:text>
+     <xsl:text>						</xsl:text>
+     <xsl:value-of select="IRQ_latency"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="IRQ_latency/@unit"/>
+     <xsl:text>
+</xsl:text>
+
+     <xsl:text>Timerlat IRQ duration:</xsl:text>
+     <xsl:text>					</xsl:text>
+     <xsl:value-of select="Timerlat_IRQ_duration/latency"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Timerlat_IRQ_duration/latency/@unit"/>
+     <xsl:text> (</xsl:text>
+     <xsl:value-of select="Timerlat_IRQ_duration/latency_percent"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Timerlat_IRQ_duration/latency_percent/@unit"/>
+     <xsl:text>)
+</xsl:text>
+
+     <xsl:if test="Blocking_Thread">
+     <xsl:text>Blocking thread:</xsl:text>
+     <xsl:text>					</xsl:text>
+     <xsl:value-of select="Blocking_Thread/latency"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Blocking_Thread/latency/@unit"/>
+     <xsl:text> (</xsl:text>
+     <xsl:value-of select="Blocking_Thread/latency_percent"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Blocking_Thread/latency_percent/@unit"/>
+     <xsl:text>)
+</xsl:text>
+     </xsl:if>
+
+     <xsl:for-each select="blocking_thread">
+	     <xsl:text>			</xsl:text>
+	     <xsl:value-of select="name"/>
+	     <xsl:text>			</xsl:text>
+	     <xsl:value-of select="latency"/>
+             <xsl:text> </xsl:text>
+	     <xsl:value-of select="latency/@unit"/>
+             <xsl:text>
+</xsl:text>
+     </xsl:for-each>
+
+     <xsl:if test="Softirq_interference">
+     <xsl:text>Softirq interference:</xsl:text>
+     <xsl:text>					</xsl:text>
+     <xsl:value-of select="Softirq_interference/latency"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Softirq_interference/latency/@unit"/>
+     <xsl:text> (</xsl:text>
+     <xsl:value-of select="Softirq_interference/latency_percent"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Softirq_interference/latency_percent/@unit"/>
+     <xsl:text>)
+</xsl:text>
+     </xsl:if>
+
+     <xsl:for-each select="softirq_interference">
+	     <xsl:text>			</xsl:text>
+	     <xsl:value-of select="name"/>
+	     <xsl:text>			</xsl:text>
+	     <xsl:value-of select="latency"/>
+             <xsl:text> </xsl:text>
+	     <xsl:value-of select="latency/@unit"/>
+             <xsl:text>
+</xsl:text>
+     </xsl:for-each>
+
+     <xsl:if test="IRQ_interference">
+     <xsl:text>IRQ interference:</xsl:text>
+     <xsl:text>					</xsl:text>
+     <xsl:value-of select="IRQ_interference/latency"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="IRQ_interference/latency/@unit"/>
+     <xsl:text> (</xsl:text>
+     <xsl:value-of select="IRQ_interference/latency_percent"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="IRQ_interference/latency_percent/@unit"/>
+     <xsl:text>)
+</xsl:text>
+     </xsl:if>
+
+     <xsl:for-each select="irq_interference">
+	     <xsl:text>			</xsl:text>
+	     <xsl:value-of select="name"/>
+	     <xsl:text>			</xsl:text>
+	     <xsl:value-of select="latency"/>
+             <xsl:text> </xsl:text>
+	     <xsl:value-of select="latency/@unit"/>
+             <xsl:text>
+</xsl:text>
+     </xsl:for-each>
+
+     <xsl:text>--------------------------------------------------------------------------------</xsl:text>
+     <xsl:text>Thread latency:</xsl:text>
+     <xsl:text>						</xsl:text>
+     <xsl:value-of select="Thread_latency/latency"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Thread_latency/latency/@unit"/>
+     <xsl:text> (</xsl:text>
+     <xsl:value-of select="Thread_latency/latency_percent"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Thread_latency/latency_percent/@unit"/>
+     <xsl:text>)
+
+</xsl:text>
+  </xsl:template>
+
+  <xsl:template match="max_timerlat_report">
+     <xsl:text>
+</xsl:text>
+     <xsl:text>Max timerlat IRQ latency from idle:</xsl:text>
+     <xsl:value-of select="Max_timerlat_IRQ_latency_from_idle"/>
+     <xsl:text> </xsl:text>
+     <xsl:value-of select="Max_timerlat_IRQ_latency_from_idle/@unit"/>
+     <xsl:text> in cpu </xsl:text>
+     <xsl:value-of select="@CPU"/>
+     <xsl:text>
+</xsl:text>
+  </xsl:template>
+
 </xsl:stylesheet>
-- 
2.45.2

