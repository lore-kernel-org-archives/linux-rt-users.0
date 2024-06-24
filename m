Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96F13A86A
	for <linux-rt-users@vger.kernel.org>; Mon, 24 Jun 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236520; cv=none; b=HTmWSxbsuRHp5qj4O2K7ftrLPhWt/HpEO5uaOYCNZTobExoDl55rxReJD5LZM/MgKPt8pZHt517i8MBzl/dxKgNxijl0ReKfhummkyFJu4aHEB28waKmYxPN7hB0fKwYC2LApjiFEVGRwj6USE6MfWYCP6yMzNt+87POsJFpxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236520; c=relaxed/simple;
	bh=pYCsN5c/WgMMHi6UKX6E6/ZgdtfGpk7Li7AdxjYvFmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ota1OsNwZuIX4MGxUk7Ood6O4Ng59Xtd7G2qwL+Y4Nf0v+4978jCBDEX6oQHf+tAPqwW2k+eVNV3lTja/dkqBZU3wz1/Z89mSF9yw3DoCphauXdTXI3eXQ09MA1K3Es1ERSK0Xyr5ytUIEAhfB2adBluTRLzaH8/yaUE74cmfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxpSimJV; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxpSimJV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44056295c8cso16664281cf.3
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Jun 2024 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719236517; x=1719841317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Z4Bu5NqfW1DPsYkgtG/IUdrA0Ri1dgcS51mZzUoFKfI=;
        b=DxpSimJVFx/N8uOauWlI6I9lRZNGqKOGw4M+diIgM9ih/9Ljcck0e85sUdFemWtTJM
         5oJrrx4VLnHj6OPzqHV9iycZoj2jXYkdlVtF2Rpk1UkvVaZeEp8RdaNK74sFc/HkFD4f
         StW4UPE3wdGaHcwdnMCjROudpxChnKS4uf3mKwzxykCkxmRvfuYcDSSqYYVcxS8ijC2e
         iI9EvfpM5Zer25gWu3ylgqPpG+678Zxbi6BbitnTL+AADh8ZXE8lpHPjq6ifGsG6uxyQ
         K4YOk5ebGDrsthF7Dp/e1fhsyWDI3PrndqXxqFtW/RHarkffOTJYJD0ho5gLadcpfzKn
         Eolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236517; x=1719841317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4Bu5NqfW1DPsYkgtG/IUdrA0Ri1dgcS51mZzUoFKfI=;
        b=AHaMwrQyyjfmUdGPQ+zGbdvgt7ZDN/FDfNJlQLFJwNZgZr2ZDPM4JboMxmyR7yYVQk
         mPb5TWaOTe0AooqaOoxCJwhqyJh2d327IbnoDNQZG+AInygRev9Xsh3m8GT81rVMYlZu
         Huth9zKCMmHIjMTbWeB5MSwi/HE2a8qHb3zs3gs9vvAPULXriCgkW4yuTFnkaKVrjjeD
         LtsSKBtTKkYayp+V1GHqFdAP7kthakimICKoMaJ3xNe3WNQco8hc/f9N83lk5VFGsrm6
         AFqqGU2S+SGudHOu7U8INLo1nnxTKJ3c1nDgZ76rU9o/otTr25GPN5G3ok0TjznhRfAV
         YljQ==
X-Gm-Message-State: AOJu0YzrE6RDw+xuAqZfwrBs6Y6OASRbR2kZU7+Wco2lcrlFStrV+6+E
	8U4b6jD724bB9t4/AEL/Jh0Sq0o5OxUSZ9tiz7cQGxI8HKmW65h5e71eqJmB
X-Google-Smtp-Source: AGHT+IE0METJb6+SGfVboGH5xfTczsqKvVEN9CgG0LAnTyfh6MJcp9AX/4bT4jCUI91b6UiVEGwh3Q==
X-Received: by 2002:a05:622a:500a:b0:444:dc63:ba1f with SMTP id d75a77b69052e-444dc63bb58mr52369161cf.46.1719236516714;
        Mon, 24 Jun 2024 06:41:56 -0700 (PDT)
Received: from localhost.localdomain ([76.69.33.221])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c4b9c348sm40282331cf.14.2024.06.24.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:41:56 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveria <bristot@kernel.org>,
	Kate Carcia Poulin <kcarcia@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Wyatt <jwyatt@redhat.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: timerlat tracing clean-up
Date: Mon, 24 Jun 2024 09:41:18 -0400
Message-ID: <20240624134118.42371-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch cleans-up the code that stores the timerlat summary into xml,
after a trace is stopped. It does so by grouping similar kinds of output
together for parsing. It also reduces the amount of debug output.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 142 ++++++++++---------------
 rteval/rteval_text.xsl                 |  10 +-
 2 files changed, 62 insertions(+), 90 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 45adec1b33e1..dc6226ccc991 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -273,12 +273,14 @@ class Timerlat(rtevalModulePrototype):
             os.kill(self.__timerlat_process.pid, signal.SIGINT)
             time.sleep(2)
 
+
+        # Parse histogram output
+        self.__timerlat_out.seek(0)
+
         blocking_thread_detected = False
         softirq_interference_detected = False
         irq_interference_detected = False
 
-        # Parse histogram output
-        self.__timerlat_out.seek(0)
         for line in self.__timerlat_out:
             line = bytes.decode(line)
 
@@ -291,6 +293,8 @@ class Timerlat(rtevalModulePrototype):
                 self.__posttrace += line
                 line = line.strip()
                 fields = line.split()
+                if not line:
+                    continue
                 if line.startswith("##") and fields[1] == "CPU":
                     self.stcpu = int(fields[2])
                     self._log(Log.DEBUG, f"self.stcpu = {self.stcpu}")
@@ -304,91 +308,59 @@ class Timerlat(rtevalModulePrototype):
                     softirq_interference_detected = False
                     irq_interference_detected = False
                     continue
-                if line.startswith("Thread latency:"):
-                    thread_latency_percent = fields[-1].strip('()%')
-                    self._log(Log.DEBUG, f"thread_latency_percent = {thread_latency_percent}")
-                    thread_latency = fields[-3]
-                    self._log(Log.DEBUG, f"thread_latency = {thread_latency}")
-                    self.__stdata[self.stcpu]["Thread_latency"] = (thread_latency, thread_latency_percent)
-                elif line.startswith("Previous IRQ interference"):
-                    self._log(Log.DEBUG, f'Previous_IRQ_interference = {fields[-2]}')
-                    self.__stdata[self.stcpu]["Previous_IRQ_interference"] = fields[-2]
-                elif line.startswith("IRQ handler delay:"):
-                    irq_handler_delay_percent = fields[-2].strip('(')
-                    irq_handler_delay = fields[-4]
-                    # Do we have (exit from idle)?
-                    if fields[3] == '(exit':
-                        field_name = "IRQ_handler_delay_exit_from_idle"
-                    else:
-                        field_name = "IRQ_handler_delay"
-                    self._log(Log.DEBUG, f"{field_name} = {irq_handler_delay}")
-                    self._log(Log.DEBUG, f"{field_name}_percent = {irq_handler_delay_percent}")
-                    self.__stdata[self.stcpu][field_name] = (irq_handler_delay, irq_handler_delay_percent)
-                elif line.startswith("IRQ latency:"):
-                    self._log(Log.DEBUG, f"irq_latency = {fields[-2]}")
-                    self.__stdata[self.stcpu]["IRQ_latency"] = fields[-2]
-                elif line.startswith("Timerlat IRQ duration"):
-                    timerlat_irq_duration_percent = fields[-2].strip('(')
-                    self._log(Log.DEBUG, f"timerlat_irq_duration_percent = {timerlat_irq_duration_percent}")
-                    timerlat_irq_duration = fields[-4]
-                    self._log(Log.DEBUG, f"timerlat_irq_duration = {timerlat_irq_duration}")
-                    self.__stdata[self.stcpu]["Timerlat_IRQ_duration"] = (timerlat_irq_duration, timerlat_irq_duration_percent)
-                elif line.startswith("Blocking thread:"):
-                    blocking_thread_percent = fields[-2].strip('(')
-                    self._log(Log.DEBUG, f"blocking_thread_percent = {blocking_thread_percent}")
-                    blocking_thread = fields[-4]
-                    self._log(Log.DEBUG, f"blocking_thread = {blocking_thread}")
-                    self.__stdata[self.stcpu]["Blocking_Thread"] = (blocking_thread, blocking_thread_percent)
-                    blocking_thread_detected = True
-                    irq_interference_detected = False
-                    softirq_interference_detected = False
-                elif line.startswith("IRQ interference"):
-                    irq_interference_percent = fields[-2].strip('(')
-                    self._log(Log.DEBUG, f"irq_interference_percent = {irq_interference_percent}")
-                    irq_interference = fields[-4]
-                    self._log(Log.DEBUG, f"irq_interference = {irq_interference}")
-                    self.__stdata[self.stcpu]["IRQ_interference"] = (irq_interference, irq_interference_percent)
-                    blocking_thread_detected = False
-                    irq_interference_detected = True
-                    softirq_interference_detected = False
-                elif line.startswith("Softirq interference"):
-                    softirq_interference_percent = fields[-2].strip('(')
-                    self._log(Log.DEBUG, f"softirq_interference_percent = {softirq_interference_percent}")
-                    softirq_interference = fields[-4]
-                    self._log(Log.DEBUG, f"softirq_interference = {softirq_interference}")
-                    self.__stdata[self.stcpu]["Softirq_interference"] = (softirq_interference, softirq_interference_percent)
-                    blocking_thread_detected = False
-                    irq_interference_detected = False
-                    softirq_interference_detected = True
-                elif blocking_thread_detected:
-                    self._log(Log.DEBUG, f'line={line}')
-                    blocking_thread = " ".join(fields[0:-2])
-                    self._log(Log.DEBUG, f"blocking_thread = {blocking_thread}")
-                    blocking_threadus = fields[-2]
-                    self._log(Log.DEBUG, f"blocking_threadus = {blocking_threadus}")
-                    self.__stdata[self.stcpu].setdefault("blocking_thread", [])
-                    self.__stdata[self.stcpu]["blocking_thread"] += [(blocking_thread, blocking_threadus)]
-                elif softirq_interference_detected:
-                    softirq = " ".join(fields[0:-2])
-                    softirq_latency = fields[-2]
-                    self._log(Log.DEBUG, f'softirq = {softirq}')
-                    self._log(Log.DEBUG, f'softirq_latency = {softirq_latency}')
-                    self.__stdata[self.stcpu].setdefault("softirq_interference", [])
-                    self.__stdata[self.stcpu]["softirq_interference"] += [(softirq, softirq_latency)]
-                elif irq_interference_detected:
-                    irq_interference_name = " ".join(fields[0:-2])
-                    irq_interference_latency = fields[-2]
-                    self._log(Log.DEBUG, f'irq_interference = {irq_interference_name}, latency = {irq_interference_latency}')
-                    self.__stdata[self.stcpu].setdefault("irq_interference", [])
-                    self.__stdata[self.stcpu]["irq_interference"] += [(irq_interference_name, irq_interference_latency)]
-                elif line.startswith("Max timerlat IRQ latency"):
-                    self._log(Log.DEBUG, f"line={line}")
-                    max_timerlat_irq_latency = fields[-5]
-                    self._log(Log.DEBUG, f"max_timerlat_irq_latency = {max_timerlat_irq_latency}")
+
+                # work around rtla not printing ':' after all names
+                if line.startswith('Softirq interference'):
+                    name = 'Softirq_interference'
+                elif line.startswith('IRQ interference'):
+                    name = 'IRQ_interference'
+                else:
+                    name = ''.join(line.split(':')[0]).replace(' ', '_')
+                self._log(Log.DEBUG, f"name={name}")
+
+                if name in ['Thread_latency']:
+                    latency = fields[-3]
+                    percent = fields[-1].strip('()%')
+                    self._log(Log.DEBUG, f'{name} = ({latency}, {percent})')
+                    self.__stdata[self.stcpu][name] = (latency, percent)
+                    continue
+                if name in ['Timerlat_IRQ_duration', 'IRQ_handler_delay', 'Blocking_thread', 'IRQ_interference', 'Softirq_interference']:
+                    latency = fields[-4]
+                    percent = fields[-2].strip('(')
+                    if name == 'IRQ_handler_delay' and fields[3] == '(exit':
+                        name = 'IRQ_handler_delay_exit_from_idle'
+                    self._log(Log.DEBUG, f'{name} = ({latency}, {percent})')
+                    self.__stdata[self.stcpu][name] = (latency, percent)
+                    detected = {'Blocking_thread' : (True, False, False),
+                                'IRQ_interference' : (False, True, False),
+                                'Softirq_interference' : (False, False, True) }
+                    if name in ('Blocking_thread', 'IRQ_interference', 'Softirq_interference'):
+                        blocking_thread_detected, irq_interference_detected, softirq_interference_detected = detected.get(name)
+                    continue
+                if name in ["IRQ_latency", "Previous_IRQ_interference"]:
+                    latency = fields[-2]
+                    self._log(Log.DEBUG, f'{name} = {fields[-2]}')
+                    self.__stdata[self.stcpu][name] = fields[-2]
+                    continue
+                if blocking_thread_detected or softirq_interference_detected or irq_interference_detected:
+                    if blocking_thread_detected:
+                        field_name = "blocking_thread"
+                    elif softirq_interference_detected:
+                        field_name = "softirq_interference"
+                    elif irq_interference_detected:
+                        field_name = "irq_interference"
+                    thread = " ".join(fields[0:-2])
+                    latency = fields[-2]
+                    self._log(Log.DEBUG, f"{field_name} += [({thread}, {latency})]")
+                    self.__stdata[self.stcpu].setdefault(field_name, [])
+                    self.__stdata[self.stcpu][field_name] += [(thread, latency)]
+                    continue
+                if name == "Max_timerlat_IRQ_latency_from_idle":
+                    latency = fields[-5]
                     max_timerlat_cpu = int(fields[-1])
-                    self._log(Log.DEBUG, f"max_timerlat_cpu = {max_timerlat_cpu}")
+                    self._log(Log.DEBUG, f'self.__stdata[{max_timerlat_cpu}][{name}] = {latency}')
                     self.__stdata.setdefault(max_timerlat_cpu, {})
-                    self.__stdata[max_timerlat_cpu]["Max_timerlat_IRQ_latency_from_idle"] = max_timerlat_irq_latency
+                    self.__stdata[max_timerlat_cpu][name] = latency
                 else:
                     self._log(Log.DEBUG, f'line = {line}')
                 continue
diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index 70777354efa5..7ca0ae3a4c66 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -546,16 +546,16 @@
      <xsl:text>)
 </xsl:text>
 
-     <xsl:if test="Blocking_Thread">
+     <xsl:if test="Blocking_thread">
      <xsl:text>Blocking thread:</xsl:text>
      <xsl:text>					</xsl:text>
-     <xsl:value-of select="Blocking_Thread/latency"/>
+     <xsl:value-of select="Blocking_thread/latency"/>
      <xsl:text> </xsl:text>
-     <xsl:value-of select="Blocking_Thread/latency/@unit"/>
+     <xsl:value-of select="Blocking_thread/latency/@unit"/>
      <xsl:text> (</xsl:text>
-     <xsl:value-of select="Blocking_Thread/latency_percent"/>
+     <xsl:value-of select="Blocking_thread/latency_percent"/>
      <xsl:text> </xsl:text>
-     <xsl:value-of select="Blocking_Thread/latency_percent/@unit"/>
+     <xsl:value-of select="Blocking_thread/latency_percent/@unit"/>
      <xsl:text>)
 </xsl:text>
      </xsl:if>
-- 
2.45.2

