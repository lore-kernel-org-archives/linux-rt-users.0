Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B2F4921BF
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003075; cv=none; b=bsAYH+f62TxixZc/XG61ghS6TgqoTsEoctFVKkJqzVq1t0xp/PyDKoaMA+Ei8mU8qy07pW58ywLIzEo3e3Ycgf7/b/zqXpm2oFCXkgL1gUwo5oscQ4HHr9oYJ+cEjZ5cNpR08rYh4QICoLrVOquW6ht6sVAx3HprqWvPpoo0FOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003075; c=relaxed/simple;
	bh=397+GBfKCQ5xBxYCOiJIHepGLmt/OOAkyuv+HFnlejg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7EEaEI4Ruqqtqdk7Ta9HobHUvSPNmG2YBMm1gFgn/JEj/mgPwFefjIZMdlyARHZY9iJtJ7wmrNO1pG8ZbZsdQipi1cyzNAmh1zrfsc9AiHKjoih4fOhmhnELgaCdsZOC8QEMqKfzUfwbuP20qZH4F0m7vBjr6iAj+YL55AIWsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJaDiM9W; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJaDiM9W"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8f0a87e23daso557830585a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003072; x=1778607872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uvv5hwm5zw6hGDcmiFJL/raehn3M2q8g0GXjXIRdY9o=;
        b=LJaDiM9W0dDodc4IpK3HSJypwtUu/kmY8IcRo3kDfFOSfn+4DPJwnr2UeCKkdRtE8g
         FSHzXv6G+gTxgCpYcRqgFIEKYGk6NPeZLb1zCRNnAbvh5qE3Yzz3GoyqiJnxGZueohUj
         g5U+5rps1rrAOmlUKzH4GuEWL9fr55kXvm6nC9goYP1CA390e7YULS4BbUGtgpjCECAs
         qmPXM7+sJfbVc60GydmyLMGNjQU+qDoqynF7o34KIu3+8YQyDBGUXkwtvFmLiHq0ywdn
         tt8j9bRQ0TB/PU3oc5XtH9mmpeGwJUSHrhBBhOEYsNUAiX3plMXX77t6Cs+Kh7nI+Shd
         1fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003072; x=1778607872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvv5hwm5zw6hGDcmiFJL/raehn3M2q8g0GXjXIRdY9o=;
        b=ny1IPW/2niRadj2GQgwjQxiNYtrw09zfJHYRPwTd/R9VyZcWEU8DNbgbuPOAu2asPC
         MgTixBALrhZVyj52YjT9vM7UpESuweKX9BJIBy+FVLrdcFCDvFsm1AJnN9B4eG1H5tAu
         lSUC2kinGfpblWlZ8Nc4zcsfr/i5Fh60RZk0I0T4VGwtGl7bQQqxngVcQRA3NpovMIUD
         zYfgvNsqPLQ5SL1bHhCbga2OuMBDlhGP6SPzpTX4TXaLIC90Fl1VRqNcaatCWyqglMBH
         xmDSqgD0zB8awq3PBi/cVq0l8rL2rLpd/N2GLIP7Gj6OA+LsjGbOcN3YlpPUc0B20W8v
         /vdA==
X-Gm-Message-State: AOJu0Yz48cOD3o27Sjft1e0qi19ElWxBJ+Ua4okHPSBU1paIkrGG1fOh
	d7eiu9k+1XfYY2N4xHz6seIYwWpMLilWltUqRJ1aBwEjY3x+kuA/q7DjyKa+KA==
X-Gm-Gg: AeBDiet+k43NP15gMtgApa6my9D5J8TZHRXjibiDUsrFVV0d/jlBiePRU3wtMP3xRMu
	kLtQUK9t1BTDlunB9xvqOYC99agPLZT5bLaBoyNIT3/UkFNZ3mAvboegXNc6lLTDB2nA1V4zsUn
	Vu4sunswtmodHVwGOemC5E80zIqsaZmUMH/QTsD1TCVwwLPW/jqlxGo7shgRJ03L6EZvnxzK+Xl
	4ehfmk/wni+zczbQ/aOIxug5LGAZ1XH3ROfRzg1nn/BPbNK+JIb/s5rpsE4Ch0exKMPSuSuvgAd
	7H2FVM82LBMP5NI/eqp9bmL2oAf24GD8ZQZGuxzVx46+MJCS/rmjLjZEE7iX4w9IKrSEljqwOQ0
	ZjEwjp3bDzdAF2A4VSsbIQuaqnaK2Pc4E6NoyzoV0Fln9QQES42UpDhAYX1+qKJPA25S4rjeM0K
	kQhUtJ19H9aDLMcNd20oZYgrCfRW7dkEcv3jf8vD4M54fKytORyWQBV68Ob27hC9CwJejIDt9hL
	rpq157Mta0ErmfjnLRCKKaADUFYSA==
X-Received: by 2002:a05:6214:5d0e:b0:8ae:652b:e3ab with SMTP id 6a1803df08f44-8b669fa23bemr238340296d6.51.1778003072107;
        Tue, 05 May 2026 10:44:32 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/9] rteval: Fix timerlat error handling to prevent hangs
Date: Tue,  5 May 2026 13:43:45 -0400
Message-ID: <20260505174410.169442-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505174410.169442-1-jkacur@redhat.com>
References: <20260505174410.169442-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes multiple issues identified in RHEL-140898:

1. Limit SIGINT attempts to avoid infinite loop
   - Send maximum of 5 SIGINT signals with 2s intervals
   - Force SIGKILL if process doesn't respond after 10s
   - Check and log exit status

2. Handle partial output from rtla gracefully
   - Wrap histogram parsing in try/except/finally
   - Catch IndexError/ValueError when parsing bucket data
   - Log warnings instead of crashing on malformed output

3. Ensure _setFinished() is always called
   - Use finally block to signal completion even on errors
   - Prevents hang in WaitForCompletion when parsing fails

4. Fix bare except clause
   - Changed to catch ValueError specifically

5. Fix typo in docstring (objectd -> object)

The root cause (rtla segfault) is being fixed upstream in RHEL-151475,
but rteval must handle partial output gracefully since new rtla can
still produce incomplete output if force-aborted during cleanup.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/timerlat.py | 318 ++++++++++++++-----------
 1 file changed, 173 insertions(+), 145 deletions(-)

diff --git a/rteval/modules/measurement/timerlat.py b/rteval/modules/measurement/timerlat.py
index 4dfe18cc5492..2172f6ece520 100644
--- a/rteval/modules/measurement/timerlat.py
+++ b/rteval/modules/measurement/timerlat.py
@@ -2,7 +2,7 @@
 #
 #   Copyright 2024  John Kacur <jkacur@redhat.com>
 #
-""" timerlat.py - objectd to manage rtla timerlat """
+""" timerlat.py - object to manage rtla timerlat """
 import os
 import subprocess
 import signal
@@ -282,172 +282,200 @@ class Timerlat(rtevalModulePrototype):
     def _WorkloadCleanup(self):
         if not self.__started:
             return
-        while self.__timerlat_process.poll() is None:
-            self._log(Log.DEBUG, "Sending SIGINT")
+
+        # Send SIGINT and wait for graceful exit
+        # Limit attempts to avoid infinite loop and double-SIGINT issues (RHEL-140898)
+        max_attempts = 5
+        attempt = 0
+        while self.__timerlat_process.poll() is None and attempt < max_attempts:
+            self._log(Log.DEBUG, f"Sending SIGINT (attempt {attempt + 1}/{max_attempts})")
             os.kill(self.__timerlat_process.pid, signal.SIGINT)
             time.sleep(2)
+            attempt += 1
 
+        # Check if process exited
+        exit_code = self.__timerlat_process.returncode
+        if exit_code is None:
+            # Process still running after max attempts, force kill
+            self._log(Log.WARN, "timerlat did not respond to SIGINT, sending SIGKILL")
+            os.kill(self.__timerlat_process.pid, signal.SIGKILL)
+            self.__timerlat_process.wait()
+            exit_code = self.__timerlat_process.returncode
+        elif exit_code != 0:
+            self._log(Log.WARN, f"timerlat exited with non-zero status: {exit_code}")
 
-        # Parse histogram output
-        self.__timerlat_out.seek(0)
 
-        blocking_thread_detected = False
-        softirq_interference_detected = False
-        irq_interference_detected = False
+        # Parse histogram output - use try/finally to ensure _setFinished() is always called
+        # This prevents hangs if parsing fails due to partial output (RHEL-140898)
+        try:
+            self.__timerlat_out.seek(0)
 
-        for line in self.__timerlat_out:
-            line = bytes.decode(line)
+            blocking_thread_detected = False
+            softirq_interference_detected = False
+            irq_interference_detected = False
 
-            # Skip any blank lines
-            if not line:
-                continue
+            for line in self.__timerlat_out:
+                line = bytes.decode(line)
 
-            # Parsing if stoptrace has been invoked
-            if self.__stoptrace:
-                self.__posttrace += line
-                line = line.strip()
-                fields = line.split()
+                # Skip any blank lines
                 if not line:
                     continue
-                if line.startswith("##") and fields[1] == "CPU":
-                    self.stcpu = int(fields[2])
-                    self._log(Log.DEBUG, f"self.stcpu = {self.stcpu}")
-                    self.__stdata[self.stcpu] = {}
+
+                # Parsing if stoptrace has been invoked
+                if self.__stoptrace:
+                    self.__posttrace += line
+                    line = line.strip()
+                    fields = line.split()
+                    if not line:
+                        continue
+                    if line.startswith("##") and fields[1] == "CPU":
+                        self.stcpu = int(fields[2])
+                        self._log(Log.DEBUG, f"self.stcpu = {self.stcpu}")
+                        self.__stdata[self.stcpu] = {}
+                        continue
+                    if self.stcpu == -1:
+                        self._log(Log.WARN, "Stop trace has been invoked, but a stop cpu has not been identified.")
+                        continue
+                    if line.startswith('------------------'):
+                        blocking_thread_detected = False
+                        softirq_interference_detected = False
+                        irq_interference_detected = False
+                        continue
+
+                    # work around rtla not printing ':' after all names
+                    if line.startswith('Softirq interference'):
+                        name = 'Softirq_interference'
+                    elif line.startswith('IRQ interference'):
+                        name = 'IRQ_interference'
+                    else:
+                        name = ''.join(line.split(':')[0]).replace(' ', '_')
+                    self._log(Log.DEBUG, f"name={name}")
+
+                    if name in ['Thread_latency']:
+                        latency = fields[-3]
+                        percent = fields[-1].strip('()%')
+                        self._log(Log.DEBUG, f'{name} = ({latency}, {percent})')
+                        self.__stdata[self.stcpu][name] = (latency, percent)
+                        continue
+                    if name in ['Timerlat_IRQ_duration', 'IRQ_handler_delay', 'Blocking_thread', 'IRQ_interference', 'Softirq_interference']:
+                        latency = fields[-4]
+                        percent = fields[-2].strip('(')
+                        if name == 'IRQ_handler_delay' and fields[3] == '(exit':
+                            name = 'IRQ_handler_delay_exit_from_idle'
+                        self._log(Log.DEBUG, f'{name} = ({latency}, {percent})')
+                        self.__stdata[self.stcpu][name] = (latency, percent)
+                        detected = {'Blocking_thread' : (True, False, False),
+                                    'IRQ_interference' : (False, True, False),
+                                    'Softirq_interference' : (False, False, True) }
+                        if name in ('Blocking_thread', 'IRQ_interference', 'Softirq_interference'):
+                            blocking_thread_detected, irq_interference_detected, softirq_interference_detected = detected.get(name)
+                        continue
+                    if name in ["IRQ_latency", "Previous_IRQ_interference"]:
+                        latency = fields[-2]
+                        self._log(Log.DEBUG, f'{name} = {fields[-2]}')
+                        self.__stdata[self.stcpu][name] = fields[-2]
+                        continue
+                    if blocking_thread_detected or softirq_interference_detected or irq_interference_detected:
+                        if blocking_thread_detected:
+                            field_name = "blocking_thread"
+                        elif softirq_interference_detected:
+                            field_name = "softirq_interference"
+                        elif irq_interference_detected:
+                            field_name = "irq_interference"
+                        thread = " ".join(fields[0:-2])
+                        latency = fields[-2]
+                        self._log(Log.DEBUG, f"{field_name} += [({thread}, {latency})]")
+                        self.__stdata[self.stcpu].setdefault(field_name, [])
+                        self.__stdata[self.stcpu][field_name] += [(thread, latency)]
+                        continue
+                    if name == "Max_timerlat_IRQ_latency_from_idle":
+                        latency = fields[-5]
+                        max_timerlat_cpu = int(fields[-1])
+                        self._log(Log.DEBUG, f'self.__stdata[{max_timerlat_cpu}][{name}] = {latency}')
+                        self.__stdata.setdefault(max_timerlat_cpu, {})
+                        self.__stdata[max_timerlat_cpu][name] = latency
+                    else:
+                        self._log(Log.DEBUG, f'line = {line}')
+                    continue
+
+                if line.startswith('#'):
+                    if line.startswith('# Duration:'):
+                        duration = line.split()[2]
+                        duration += line.split()[3]
+                        self.__timerlatdata['system'].duration = duration
                     continue
-                if self.stcpu == -1:
-                    self._log(Log.WARN, "Stop trace has been invoked, but a stop cpu has not been identified.")
+                elif line.startswith('Index'):
+                    #print(line)
                     continue
-                if line.startswith('------------------'):
-                    blocking_thread_detected = False
-                    softirq_interference_detected = False
-                    irq_interference_detected = False
+                elif line.startswith('over:'):
+                    #print(line)
                     continue
-
-                # work around rtla not printing ':' after all names
-                if line.startswith('Softirq interference'):
-                    name = 'Softirq_interference'
-                elif line.startswith('IRQ interference'):
-                    name = 'IRQ_interference'
-                else:
-                    name = ''.join(line.split(':')[0]).replace(' ', '_')
-                self._log(Log.DEBUG, f"name={name}")
-
-                if name in ['Thread_latency']:
-                    latency = fields[-3]
-                    percent = fields[-1].strip('()%')
-                    self._log(Log.DEBUG, f'{name} = ({latency}, {percent})')
-                    self.__stdata[self.stcpu][name] = (latency, percent)
+                elif line.startswith('count:'):
+                    #print(line)
+                    continue
+                elif line.startswith('min:'):
+                    #print(line)
                     continue
-                if name in ['Timerlat_IRQ_duration', 'IRQ_handler_delay', 'Blocking_thread', 'IRQ_interference', 'Softirq_interference']:
-                    latency = fields[-4]
-                    percent = fields[-2].strip('(')
-                    if name == 'IRQ_handler_delay' and fields[3] == '(exit':
-                        name = 'IRQ_handler_delay_exit_from_idle'
-                    self._log(Log.DEBUG, f'{name} = ({latency}, {percent})')
-                    self.__stdata[self.stcpu][name] = (latency, percent)
-                    detected = {'Blocking_thread' : (True, False, False),
-                                'IRQ_interference' : (False, True, False),
-                                'Softirq_interference' : (False, False, True) }
-                    if name in ('Blocking_thread', 'IRQ_interference', 'Softirq_interference'):
-                        blocking_thread_detected, irq_interference_detected, softirq_interference_detected = detected.get(name)
+                elif line.startswith('avg:'):
+                    #print(line)
                     continue
-                if name in ["IRQ_latency", "Previous_IRQ_interference"]:
-                    latency = fields[-2]
-                    self._log(Log.DEBUG, f'{name} = {fields[-2]}')
-                    self.__stdata[self.stcpu][name] = fields[-2]
+                elif line.startswith('max:'):
+                    #print(line)
                     continue
-                if blocking_thread_detected or softirq_interference_detected or irq_interference_detected:
-                    if blocking_thread_detected:
-                        field_name = "blocking_thread"
-                    elif softirq_interference_detected:
-                        field_name = "softirq_interference"
-                    elif irq_interference_detected:
-                        field_name = "irq_interference"
-                    thread = " ".join(fields[0:-2])
-                    latency = fields[-2]
-                    self._log(Log.DEBUG, f"{field_name} += [({thread}, {latency})]")
-                    self.__stdata[self.stcpu].setdefault(field_name, [])
-                    self.__stdata[self.stcpu][field_name] += [(thread, latency)]
+                elif line.startswith('rtla timerlat hit stop tracing'):
+                    self.__stoptrace = True
+                    self.__posttrace += line
+                    continue
+                elif line.startswith('ALL:'):
+                    # We should only see 'ALL:' without timerlat --no-summary
+                    # print(line)
                     continue
-                if name == "Max_timerlat_IRQ_latency_from_idle":
-                    latency = fields[-5]
-                    max_timerlat_cpu = int(fields[-1])
-                    self._log(Log.DEBUG, f'self.__stdata[{max_timerlat_cpu}][{name}] = {latency}')
-                    self.__stdata.setdefault(max_timerlat_cpu, {})
-                    self.__stdata[max_timerlat_cpu][name] = latency
                 else:
-                    self._log(Log.DEBUG, f'line = {line}')
-                continue
+                    #print(line)
+                    pass
 
-            if line.startswith('#'):
-                if line.startswith('# Duration:'):
-                    duration = line.split()[2]
-                    duration += line.split()[3]
-                    self.__timerlatdata['system'].duration = duration
-                continue
-            elif line.startswith('Index'):
-                #print(line)
-                continue
-            elif line.startswith('over:'):
-                #print(line)
-                continue
-            elif line.startswith('count:'):
-                #print(line)
-                continue
-            elif line.startswith('min:'):
-                #print(line)
-                continue
-            elif line.startswith('avg:'):
-                #print(line)
-                continue
-            elif line.startswith('max:'):
-                #print(line)
-                continue
-            elif line.startswith('rtla timerlat hit stop tracing'):
-                self.__stoptrace = True
-                self.__posttrace += line
-                continue
-            elif line.startswith('ALL:'):
-                # We should only see 'ALL:' without timerlat --no-summary
-                # print(line)
-                continue
-            else:
-                #print(line)
-                pass
+                vals = line.split()
+                if not vals:
+                    # If we don't have any values, don't try parsing
+                    continue
+                try:
+                    # The index corresponds to the bucket number
+                    index = int(vals[0])
+                except ValueError:
+                    self._log(Log.DEBUG, f'timerlat: unexpected output: {line}')
+                    continue
 
-            vals = line.split()
-            if not vals:
-                # If we don't have any values, don't try parsing
-                continue
-            try:
-                # The index corresponds to the bucket number
-                index = int(vals[0])
-            except:
-                self._log(Log.DEBUG, f'timerlat: unexpected output: {line}')
-                continue
+                for i, core in enumerate(self.__cpus):
+                    # There might not be a count on every cpu if tracing invoked
+                    try:
+                        if i*3 + 1 >= len(vals):
+                            self.__timerlatdata[core].bucket(index, 0, 0, 0)
+                            self.__timerlatdata['system'].bucket(index, 0, 0, 0)
+                        else:
+                            self.__timerlatdata[core].bucket(index, int(vals[i*3+1]),
+                                                         int(vals[i*3+2]),
+                                                         int(vals[i*3+3]))
+                            self.__timerlatdata['system'].bucket(index, int(vals[i*3+1]),
+                                                         int(vals[i*3+2]),
+                                                         int(vals[i*3+3]))
+                    except (IndexError, ValueError) as e:
+                        # Handle partial output from rtla (can happen on SIGINT during cleanup)
+                        self._log(Log.WARN, f"Error parsing timerlat bucket data for core {core}: {e}")
+                        continue
 
-            for i, core in enumerate(self.__cpus):
-                # There might not be a count on every cpu if tracing invoked
-                if i*3 + 1 >= len(vals):
-                    self.__timerlatdata[core].bucket(index, 0, 0, 0)
-                    self.__timerlatdata['system'].bucket(index, 0, 0, 0)
-                else:
-                    self.__timerlatdata[core].bucket(index, int(vals[i*3+1]),
-                                                 int(vals[i*3+2]),
-                                                 int(vals[i*3+3]))
-                    self.__timerlatdata['system'].bucket(index, int(vals[i*3+1]),
-                                                 int(vals[i*3+2]),
-                                                 int(vals[i*3+3]))
-
-        # Generate statistics for each RunData object
-        for n in list(self.__timerlatdata.keys()):
-            self.__timerlatdata[n].reduce()
-
-        self._setFinished()
-        self.__started = False
+                # Generate statistics for each RunData object
+                for n in list(self.__timerlatdata.keys()):
+                    self.__timerlatdata[n].reduce()
+
+        except Exception as e:
+            self._log(Log.ERR, f"Error parsing timerlat output: {e}")
+        finally:
+            # Always signal completion to avoid hangs
+            self._setFinished()
+            self.__started = False
 
-        self.__timerlat_err.close()
-        self.__timerlat_out.close()
+            self.__timerlat_err.close()
+            self.__timerlat_out.close()
 
     def MakeReport(self):
         rep_n = libxml2.newNode('timerlat')
-- 
2.54.0

