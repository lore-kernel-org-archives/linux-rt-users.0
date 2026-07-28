Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3539B944
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258390; cv=none; b=AJwPkYp0EMqcc4EEk11tmiousSnWBx1kF7s3Dx8Djhm+KjPAaYgeyKVM/+NBMXj9sZLDlOoG9Jkkr4j6C7ty8GaQpv5UCLrvnZXYjXz3wbZDtuAiUix1JkrtTYc/PNB9OdnxbqcVpIkjrrRc3u69v6HWhIltWR+bBSQmfCkrWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258390; c=relaxed/simple;
	bh=Q9xSWpnxlu96jWduTYWpFJkIUgobYlW27bHb55fdYMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAyxwx16gOkQXnwQbVuk9GSr6dwKMJRSGajky5Wk2DtY1ejVCHAadwTqdEUJ0BfmrdDPJ8yC1OPOSgvJIBHpPiDQSBKVZBoz38XMwqe09JsxLot9ya9wHWN6QSCERfzdzsnfTr1wLllXxsygkYmucXyz6qnikESVQxmhw4wnv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gicaU7CF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gicaU7CF"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9063b380982so267126d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258388; x=1785863188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0BmIz/UnsS/llokNortPY+ZBVFjzhEZvCv1Z3e9k0E=;
        b=gicaU7CFNt1o4dML02Ihs7o9DxxD8G98hLhMff99vONIwP02nnp7McrXyD6vGXWiB+
         i/KlbfynBLhDh6ddmkGNQF1MFAeFC80tNWRWTGrDTZoeQo0uf33fp4Hr/WkdCRW7yA3T
         VX+2BucvfNUu1XY1DGCBm99P5Q6/MeCTnhGWpeGBLrvu0g/TtByU8ZtJbQmHH0Z2K8CO
         WghQf2ZLOZj9cPfvMKuGjixUSt4UP2STE1UzjF8BNCOO7NThay7u4Efv7cu+eqxWRqMu
         6gVVII3MouICkh9JCnbFSGCs8zmLGwiJGrJ6mVzPRCi7ELnqnvr+DiyoainV4ZPpnEvf
         Q5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258388; x=1785863188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0BmIz/UnsS/llokNortPY+ZBVFjzhEZvCv1Z3e9k0E=;
        b=dKLt6Yb2G/bYjooa7Gtdz1vpnx/fYBqXrvxRpHhVHzQ0YU3kXKTsLlgTR+2D7xgZvy
         zTRXktSZ0qE21KFdLRg/Cdv6iNfgMtOQMgPXZ60QUjrMTzpMsWFJxqfHfvqhbliIpDfg
         xX3if//Z52O+D4kW3RCalCh+eeXUXgNr+x5z3px3/AM6fKpzL6bcCwtvPRAYWtd6Cy0u
         ZdjBgTxONAAWyqC5dL4PcjU5E133uIsZMabWzSovLK1mUDQurEAJApp0kq2NxzskqrgR
         Qll2xU+CsnKpTh7iAZ1ObdpzDq+SVcZxAxUubR/59ORfJKC08dPfluRd77qwR/4fmDiO
         k5Gw==
X-Gm-Message-State: AOJu0YyG8yTJ7Y0/Ydk8k8Dc0HbTjIIJgOQDlnM+3lgf4oDY6wBaE7w1
	+W4p2UXbUvXf2dlnjFfinwPgpXDv3wdGit28hdkMRxJmO92R6NxMWHKmYome0Q==
X-Gm-Gg: AR+sD10UM7oFLVs5OiX5hh+1psjantCT336775qSWnDhQp4paPsSRPVX0vY6GVlKNKo
	0Elk52FyAuxU0LpipDog3krAqnkwal3eyUSgnNuquMHUYxM+S2k/AEecgs6N7kANUuQUXvj5cHg
	o68iWhXsmTJCYyu53MOuw0+j8bwqi56wAcjlpvH0kJAdOo6N7/Koev53+Mw68tD3MNU+QlUDxoL
	D9pyV1x6A2ax7M4sM3YjWegsfx4OnYDShB2i6vVrV1cT3ARKF+3q5slY8zmWRXu7/X2ktGkTHOE
	WVZ9pqb4uyhUMUkpNSL4iAoaOPm/U/hnHE9Dn0KIN+9UGwuikR7Pn1+21WmkGhlHbVPN54MNCMx
	HbKR5K3OK4IZZOXeSHzia9gTMzeNcXdwBPKMUYe7Vzxef41emiP8beBksMDPSsxD0S63oYr+RoR
	Qcnx5J4C0XLoufzxOU3lb5sqYHLrNwyujjOn5OFhNc8zPq0VtUXzT+3SzBrmoUAemNDqGE
X-Received: by 2002:a05:6214:5409:b0:907:5e3a:9369 with SMTP id 6a1803df08f44-90817355452mr39744166d6.57.1785258388100;
        Tue, 28 Jul 2026 10:06:28 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd3aac2sm3229676d6.30.2026.07.28.10.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:06:27 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 5/5] tuna: Get the tuna version from a single source
Date: Tue, 28 Jul 2026 13:06:07 -0400
Message-ID: <20260728170607.176811-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170607.176811-1-jkacur@redhat.com>
References: <20260728170607.176811-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create tuna/version.py with a TUNA_VERSION variable as the single source
for the version number.

Changes:
- Add tuna/version.py with a TUNA_VERSION variable
- Update setup.py to import version from tuna.version
- Update tuna-cmd.py to import version from tuna.version
- Update pyproject.toml to use dynamic versioning via setuptools

For future releases, only tuna/version.py needs to be updated.
All other files (setup.py, tuna-cmd.py, pyproject.toml) automatically
pick up the version from this single source.

Version updated from 0.20 to 0.21.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 pyproject.toml  | 5 ++++-
 setup.py        | 5 ++++-
 tuna-cmd.py     | 3 ++-
 tuna/version.py | 7 +++++++
 4 files changed, 17 insertions(+), 3 deletions(-)
 create mode 100644 tuna/version.py

diff --git a/pyproject.toml b/pyproject.toml
index ca149c352df0..6f995cb4c0a8 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -4,7 +4,7 @@ build-backend = "setuptools.build_meta"
 
 [project]
 name = "tuna"
-version = "0.20"
+dynamic = ["version"]
 description = "Application tuning GUI"
 license = "GPL-2.0-only"
 authors = [
@@ -37,5 +37,8 @@ Source = "https://git.kernel.org/pub/scm/utils/tuna/tuna.git/"
 tuna = "tuna.tuna:main"
 oscilloscope = "tuna.oscilloscope:main"
 
+[tool.setuptools.dynamic]
+version = {attr = "tuna.version.TUNA_VERSION"}
+
 [tool.setuptools.packages.find]
 include = ["tuna*"]
diff --git a/setup.py b/setup.py
index a40f29ef3817..8036a647f698 100755
--- a/setup.py
+++ b/setup.py
@@ -5,6 +5,9 @@ import sysconfig
 from os.path import isfile, relpath
 from setuptools import setup
 
+# Get the tuna version from a single source
+from tuna.version import TUNA_VERSION
+
 if isfile("MANIFEST"):
     os.unlink("MANIFEST")
 
@@ -16,7 +19,7 @@ if SCHEME not in sysconfig.get_scheme_names():
 PYTHONLIB = relpath(sysconfig.get_path('platlib', SCHEME), '/usr')
 
 setup(name="tuna",
-      version = "0.20",
+      version = TUNA_VERSION,
       description = "Application tuning GUI",
       author = "Arnaldo Carvalho de Melo, John Kacur",
       author_email = "acme@redhat.com, jkacur@redhat.com",
diff --git a/tuna-cmd.py b/tuna-cmd.py
index 25515d5ddd5a..62972cdd328a 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -23,6 +23,7 @@ import tuna.tuna_sched as tuna_sched
 import procfs
 from tuna import tuna, sysfs, utils
 from tuna import cpuset
+from tuna.version import TUNA_VERSION
 import logging
 import time
 import shutil
@@ -162,7 +163,7 @@ def gen_parser():
     MODS = {
             "logging": dict(dest='loglevel', metavar='LOG-LEVEL', type=get_loglevel, help="Log application details to file for given LOG-LEVEL"),
             "debug" : dict(action='store_true', dest='debug', help='Print DEBUG level logging details to console'),
-            "version": dict(action='version', version='0.20', help="show version"),
+            "version": dict(action='version', version=TUNA_VERSION, help="show version"),
             "warn": dict(action='store_true', dest='warn', help='Warn when thread/IRQ patterns match nothing'),
             "threads": dict(dest='thread_list', default='', metavar='THREAD-LIST', type=str, help="THREAD-LIST affected by commands"),
             "irqs": dict(dest='irq_list', default='', metavar='IRQ-LIST', type=str, help="IRQ-LIST affect by commands"),
diff --git a/tuna/version.py b/tuna/version.py
new file mode 100644
index 000000000000..23f503e6b1bc
--- /dev/null
+++ b/tuna/version.py
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+#   Copyright 2008 - 2009   Arnaldo Carvalho de Melo <acme@redhat.com>
+#   Copyright 2015 - 2026   John Kacur <jkacur@redhat.com>
+#
+
+TUNA_VERSION = '0.21'
-- 
2.55.0

