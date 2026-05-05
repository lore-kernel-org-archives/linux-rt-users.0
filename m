Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22B48C8D3
	for <linux-rt-users@vger.kernel.org>; Tue,  5 May 2026 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003076; cv=none; b=qphMbIXaP+XClY96YZ8zm8NrEqV38M/tMwNWjVXYwccvlBWhpwDp+e4mD0A4PhwbgLRm1ZVKyPk0W6Vpm3H2dxWe7O7HoHz8UmpKdigz6KLc+rWM0EdQfldxiH32orAOk7phYx1gn+J+N+VXrB7hB0La9r+tCEBEGpTeRiYNemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003076; c=relaxed/simple;
	bh=4zYK0QF1E48DozgQpxkr0Ls/xf+yrnpG+GJ0FDWwocI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZl1bX3qRn9NpJx22MAJtHkWnNION9fX84y3VXIzQjfc+8q3Rs0qetb5QJ8Ms8nIVB0BXg8B5p4uRt24BGGOSnrNSm00IWOLe62I2oEEiMLlI1hlTu9J3Y4BgF4NKBWASmeoQFXwLUxgxFSGogVQTusYct69IVsd9FmeLkOOOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN5oNQpp; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN5oNQpp"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so1229036d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 05 May 2026 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778003073; x=1778607873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wiC418/WZ05N/7VLMpmPbl6dZ6hKp+jQP4fBNdTG/iI=;
        b=eN5oNQpptKYl6pYcNBs8rJYmVHaHjnLheBaQCYg/XGckrJpxbQigKx+jtA+Hj9bXKt
         XSxDJ10TMKIUmBKOMCiuAPxUB8KfM7eoktTDPNplBxxcREhsNPIADDU1AboPdiY7GXNM
         jCBamnCAPHSlgRsYiPNRnTShZ43F1UHjBXALRhPiMnBloPBpnmYtkh+iHs/+cGOx7gRj
         S8sPD0GynGqgzOD5agSFEnl+IQVxnuVHjcoDJ0rSo1brEzljFXf9sWQBvtdXNHUFoan7
         OVbNp/lUTommAshSdacOzz1EGTyREbtMqoRFrqFNq4R/hIh9wHBDeNYG72JhqHZm1sE9
         joiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003073; x=1778607873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiC418/WZ05N/7VLMpmPbl6dZ6hKp+jQP4fBNdTG/iI=;
        b=FSGezyRYqXwzwLmMQ7aMTKZdOU86drmFDrjGZfOFn2TCVmf3mnM5LsAwYAU7IWRDIN
         /OIyj/BT+t8iPGpmX+NjLvawFbzqgiRGqf3JxYEeU54kQGC7wAwkifaz9AmkXahjof6I
         Bj1KunmWDv0YQ4Qcqx5h2PkD/qyFT/osW6jnQxS1oIGeexe/SsF5SVt4a36Ge23baxI8
         0DC5WzouMG1GU+HrPHExGbaZHt8kI8Jtm0JAqcOJhWkjgcd6qwsDKwO0NtTpLYc+3Nzx
         wIBpPQKmUQzUWtxvQR5dkJIXUH8WjI/D4x4I48OI7CsMfSdaZemMpJd8C6LMKh8X/LhI
         yIKg==
X-Gm-Message-State: AOJu0YyD5uESNs/CeBxnEVNGRKd8ru9SeSBOPcO1gR1iybTnLVSkhb4M
	v7ESdhTI+BLJzHg+Y7OvWWt6VD0D8sYyHZO/saqyuSRx0hSbMPyQ0TsczQTg8w==
X-Gm-Gg: AeBDiespsrLDWJ/zYKdK4Kxi9Qlv2jXjYh6yLRNSFTLP2qDsSfLxjIgrbJDA/dsBzj5
	2Eh0FL1EE99lNFI6i3BBH9Udsx+UNwOhqd2mcdLRdCm6ec12A1dRCI/eVpx8Xk1qSS1HxS1klwx
	OUIGdBnHbSHAyidx+zXB4GDmKOG7qqwDu4DEZjvk23YHpSJkv9HJYBNOEfbk7OHkcWUtTNhawB5
	IVZtv7U+4YGqJ/7atpDrPffiP56ODdTa2MOwUvneqvM7lOwkuZUoDpn7s7Q5foAM6n5L1+AJiTc
	fujEeiTAWDdYV1DPYlnLAmhRcf52SeQgJt4QrgYsOCPajH5Bep13bIhOrmEDKnip565FgBZoipo
	O5XM00Mw7rzBrxQzeFDSe0qZ+qfcN8HSNNp2M4DXaZqC9TjpHo70V42hPSR1B85SHwhhaF7RCu/
	ghOQf5tL3Fm7U4mVA9QYpLcWAj9rdtaBHd60pcpuv/92gZ4S2Ze/bJIO0/M76ehXbmamwgk+uE3
	CJacjOwTOr6owuBA+fz8ipJXtfwUQ==
X-Received: by 2002:a05:6214:4908:b0:8b1:f090:eee0 with SMTP id 6a1803df08f44-8baa06b9f8cmr65813446d6.20.1778003072977;
        Tue, 05 May 2026 10:44:32 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5391e3636sm161817896d6.13.2026.05.05.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:44:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <clark.williams@gmail.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/9] rteval: Fix cyclictest error handling to prevent hangs
Date: Tue,  5 May 2026 13:43:46 -0400
Message-ID: <20260505174410.169442-3-jkacur@redhat.com>
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

Apply the same error handling improvements from timerlat.py to cyclictest.py
to prevent hangs, crashes, and infinite loops (RHEL-140898).

1. Limit SIGINT attempts to avoid infinite loop
   - Send maximum of 5 SIGINT signals with 2s intervals
   - Force SIGKILL if process doesn't respond after 10s
   - Check and log exit status

2. Handle partial output from cyclictest gracefully
   - Wrap histogram parsing in try/except/finally
   - Catch IndexError/ValueError when parsing bucket data
   - Log warnings instead of crashing on malformed output

3. Ensure _setFinished() is always called
   - Use finally block to signal completion even on errors
   - Prevents hang in WaitForCompletion when parsing fails

4. Add exception handling in _parse_max_latencies()
   - Catch IndexError/ValueError when parsing max latencies line
   - Prevents crashes on malformed header data

5. Add exception handling for break value parsing
   - Protect against malformed breaktrace lines

6. Improve exception specificity
   - Changed bare except to catch ValueError specifically

Like timerlat, cyclictest can produce partial output if killed or crashes
mid-execution. These fixes ensure rteval handles such cases gracefully.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 124 +++++++++++++++--------
 1 file changed, 79 insertions(+), 45 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index c3ef4a54677d..8a5123e8af33 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -306,63 +306,97 @@ class Cyclictest(rtevalModulePrototype):
         if not line.startswith('# Max Latencies: '):
             return
 
-        line = line.split(':')[1]
-        vals = [int(x) for x in line.split()]
+        try:
+            line = line.split(':')[1]
+            vals = [int(x) for x in line.split()]
 
-        for i, core in enumerate(self.__cpus):
-            self.__cyclicdata[core].update_max(vals[i])
-            self.__cyclicdata['system'].update_max(vals[i])
+            for i, core in enumerate(self.__cpus):
+                self.__cyclicdata[core].update_max(vals[i])
+                self.__cyclicdata['system'].update_max(vals[i])
+        except (IndexError, ValueError) as e:
+            self._log(Log.WARN, f"Error parsing max latencies: {e}")
 
 
     def _WorkloadCleanup(self):
         if not self.__started:
             return
-        while self.__cyclicprocess.poll() is None:
-            self._log(Log.DEBUG, "Sending SIGINT")
+
+        # Send SIGINT and wait for graceful exit
+        # Limit attempts to avoid infinite loop (RHEL-140898)
+        max_attempts = 5
+        attempt = 0
+        while self.__cyclicprocess.poll() is None and attempt < max_attempts:
+            self._log(Log.DEBUG, f"Sending SIGINT (attempt {attempt + 1}/{max_attempts})")
             os.kill(self.__cyclicprocess.pid, signal.SIGINT)
             time.sleep(2)
+            attempt += 1
+
+        # Check if process exited
+        exit_code = self.__cyclicprocess.returncode
+        if exit_code is None:
+            # Process still running after max attempts, force kill
+            self._log(Log.WARN, "cyclictest did not respond to SIGINT, sending SIGKILL")
+            os.kill(self.__cyclicprocess.pid, signal.SIGKILL)
+            self.__cyclicprocess.wait()
+            exit_code = self.__cyclicprocess.returncode
+        elif exit_code != 0:
+            self._log(Log.WARN, f"cyclictest exited with non-zero status: {exit_code}")
+
+        # Parse histogram output - use try/finally to ensure _setFinished() is always called
+        # This prevents hangs if parsing fails due to partial output (RHEL-140898)
+        try:
+            self.__cyclicoutput.seek(0)
+            for line in self.__cyclicoutput:
+                line = bytes.decode(line)
+                if line.startswith('#'):
+                    # Catch if cyclictest stopped due to a breaktrace
+                    if line.startswith('# Break value: '):
+                        try:
+                            self.__breaktraceval = int(line.split(':')[1])
+                        except (IndexError, ValueError) as e:
+                            self._log(Log.WARN, f"Error parsing break value: {e}")
+                    elif line.startswith('# Max Latencies: '):
+                        self._parse_max_latencies(line)
+                    continue
 
-        # now parse the histogram output
-        self.__cyclicoutput.seek(0)
-        for line in self.__cyclicoutput:
-            line = bytes.decode(line)
-            if line.startswith('#'):
-                # Catch if cyclictest stopped due to a breaktrace
-                if line.startswith('# Break value: '):
-                    self.__breaktraceval = int(line.split(':')[1])
-                elif line.startswith('# Max Latencies: '):
-                    self._parse_max_latencies(line)
-                continue
-
-            # Skipping blank lines
-            if not line:
-                continue
-
-            vals = line.split()
-            if not vals:
-                # If we don't have any values, don't try parsing
-                continue
-
-            try:
-                index = int(vals[0])
-            except:
-                self._log(Log.DEBUG, f"cyclictest: unexpected output: {line}")
-                continue
+                # Skipping blank lines
+                if not line:
+                    continue
 
-            for i, core in enumerate(self.__cpus):
-                self.__cyclicdata[core].bucket(index, int(vals[i+1]))
-                self.__cyclicdata['system'].bucket(index, int(vals[i+1]))
+                vals = line.split()
+                if not vals:
+                    # If we don't have any values, don't try parsing
+                    continue
 
-        # generate statistics for each RunData object
-        for n in list(self.__cyclicdata.keys()):
-            #print "reducing self.__cyclicdata[%s]" % n
-            self.__cyclicdata[n].reduce()
-            #print self.__cyclicdata[n]
+                try:
+                    index = int(vals[0])
+                except (ValueError, IndexError):
+                    self._log(Log.DEBUG, f"cyclictest: unexpected output: {line}")
+                    continue
 
-        self._setFinished()
-        self.__started = False
-        os.close(self.__nullfp)
-        del self.__nullfp
+                for i, core in enumerate(self.__cpus):
+                    try:
+                        self.__cyclicdata[core].bucket(index, int(vals[i+1]))
+                        self.__cyclicdata['system'].bucket(index, int(vals[i+1]))
+                    except (IndexError, ValueError) as e:
+                        # Handle partial output from cyclictest (can happen on SIGINT during cleanup)
+                        self._log(Log.WARN, f"Error parsing cyclictest bucket data for core {core}: {e}")
+                        continue
+
+            # generate statistics for each RunData object
+            for n in list(self.__cyclicdata.keys()):
+                #print "reducing self.__cyclicdata[%s]" % n
+                self.__cyclicdata[n].reduce()
+                #print self.__cyclicdata[n]
+
+        except Exception as e:
+            self._log(Log.ERR, f"Error parsing cyclictest output: {e}")
+        finally:
+            # Always signal completion to avoid hangs
+            self._setFinished()
+            self.__started = False
+            os.close(self.__nullfp)
+            del self.__nullfp
 
 
     def MakeReport(self):
-- 
2.54.0

