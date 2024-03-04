Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3E1C680
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587024; cv=none; b=e/Cdl7DPr8W3NXoqCr5oz0twEtFPYzc0iQAqdYt6S1DV6ZpAakQ2k68qjspv4oahu91m/97EPBOFWt9nQ2PzV/Mq8rE+hG6nFUZc+GWS1OKrs9rCA1jojm2c0jn1DZcIiUdeRUYb4de/rCTy4xwLPOnx52J6N81G5lDRpzmUmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587024; c=relaxed/simple;
	bh=uX98SFFgziYiy4+wm1EWQTpJfyWR1kUpB6x2QIijUfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYuoz1gDvDTnGXDNjhE3KCo4s7qs3DJRzmEZhfciDy7qOgkAcI+7N9emUEgEO/TLrP3H99kxGveX4YDdpRdzR6h/EM3koSu4cfiZ28TOXUcKDA1bySHyttUcI04tgYHGNPCDZ/dSMwOqn+jQrfA4zQubmEffKrTTKEPlgaE/Nnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJf62+Lk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJf62+Lk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709587021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkAyzFANXG9Dxa+xAqkZWrxeU8ste9r0xjWjvJxpuX4=;
	b=PJf62+LkgxGnCKFIN9mw5eROR5hhPvvRELnxNKVotqAaEVzAmBqbF2f4H9SQ1XY1X2GHid
	Cx03AesyTzhstetSio7Mv6FNfpGCur5jrdYM47QNS1opO/0BHd8XxzwfuCEob/b1ylKEEy
	ON1CvZMaQcY0Q2v6/IoFzX6f0tbDiBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-LGnLh9XINjaE1GbpB6ovjw-1; Mon, 04 Mar 2024 16:16:58 -0500
X-MC-Unique: LGnLh9XINjaE1GbpB6ovjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED0AD185A789
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 21:16:57 +0000 (UTC)
Received: from p1g2.redhat.com (unknown [10.2.16.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 92FD4C0335E;
	Mon,  4 Mar 2024 21:16:57 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 3/5] rteval: kcompile: Skip mrproper, and re-extract if clean fails
Date: Mon,  4 Mar 2024 15:16:53 -0600
Message-ID: <20240304211655.20174-4-crwood@redhat.com>
In-Reply-To: <20240304211655.20174-1-crwood@redhat.com>
References: <20240304211655.20174-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

We only ever do out-of-tree builds, so the kernel directory should not be
getting damaged except by incomplete extraction (which mrproper would
probably not fix) or external meddling.  So, skip the mrproper and
instead re-extract if a "make clean" fails.

Also, add -j to cleancmd to further speed things up.  Startup speed may
not seem all that important given how long rteval is typically run for,
but this helps make quick tests (e.g. while debugging things, or when
hunting a latency that shows up very quickly) less painful.

On my 12-cpu laptop, this patch saves about 15 seconds of startup time.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval/modules/loads/kcompile.py | 40 ++++++++++++++------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index de1539986723..db1941074157 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -54,7 +54,7 @@ class KBuildJob:
             self.jobs = self.calc_jobs_per_cpu() * cpus_available
 
         self.runcmd = f"make O={self.objdir} -C {self.kdir} -j{self.jobs}"
-        self.cleancmd = f"make O={self.objdir} -C {self.kdir} clean allmodconfig"
+        self.cleancmd = f"make O={self.objdir} -C {self.kdir} clean allmodconfig -j${self.jobs}"
         self.cleancmd += f"&& pushd {self.objdir} && {self.kdir}/scripts/config -d CONFIG_MODULE_SIG_SHA1 -e CONFIG_MODULE_SIG_SHA512 && popd && make O={self.objdir} -C {self.kdir} olddefconfig"
         if self.binder:
             self.runcmd = self.binder + " " + self.runcmd
@@ -90,8 +90,8 @@ class KBuildJob:
     def clean(self, sin=None, sout=None, serr=None):
         """ Runs command to clean any previous builds and configure kernel """
         self.log(Log.DEBUG, f"cleaning objdir {self.objdir}")
-        subprocess.call(self.cleancmd, shell=True,
-                        stdin=sin, stdout=sout, stderr=serr)
+        return subprocess.call(self.cleancmd, shell=True,
+                               stdin=sin, stdout=sout, stderr=serr)
 
     def run(self, sin=None, sout=None, serr=None):
         """ Use Popen to launch a kcompile job """
@@ -234,6 +234,10 @@ class Kcompile(CommandLineLoad):
                 self.logger, self.cpus[n] if self.cpulist else None)
             self.args.append(str(self.buildjobs[n])+";")
 
+    def _repair_tarball(self):
+        self._log(Log.DEBUG, "Invalid state in kernel build tree, reloading")
+        self._remove_build_dirs()
+        self._extract_tarball()
 
     def _WorkloadBuild(self):
         if self._donotrun:
@@ -246,30 +250,22 @@ class Kcompile(CommandLineLoad):
         else:
             out = err = null
 
-        # clean up any damage from previous runs
-        try:
-            cmd = ["make", "-C", self.mydir, "mrproper"]
-            ret = subprocess.call(cmd, stdin=null, stdout=out, stderr=err)
+        # clean up object dirs and make sure each has a config file
+        for n in self.nodes:
+            ret = self.buildjobs[n].clean(sin=null, sout=out, serr=err)
             if ret:
-                # if the above make failed, remove and reinstall the source tree
-                self._log(Log.DEBUG, "Invalid state in kernel build tree, reloading")
-                self._remove_build_dirs()
-                self._extract_tarball()
-                ret = subprocess.call(cmd, stdin=null, stdout=out, stderr=err)
-                if ret:
-                    # give up
-                    raise rtevalRuntimeError(self, f"kcompile setup failed: {ret}")
-        except KeyboardInterrupt as m:
-            self._log(Log.DEBUG, "keyboard interrupt, aborting")
-            return
-        self._log(Log.DEBUG, "ready to run")
+                self._repair_tarball()
+                ret = self.buildjobs[n].clean(sin=null, sout=out, serr=err)
+            if ret:
+                raise rtevalRuntimeError(self, f"kcompile setup failed: {ret}")
+
         if self._logging:
             os.close(out)
             os.close(err)
-        # clean up object dirs and make sure each has a config file
-        for n in self.nodes:
-            self.buildjobs[n].clean(sin=null, sout=null, serr=null)
+
         os.close(null)
+
+        self._log(Log.DEBUG, "ready to run")
         self._setReady()
 
     def _WorkloadPrepare(self):
-- 
2.43.0

