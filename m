Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815F3CCA15
	for <linux-rt-users@vger.kernel.org>; Wed,  5 Aug 2026 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950656; cv=none; b=P9u8sbefAO/djMpKjWyxBS4bUe3nSUwF7eZwnWjiiN9vlE5xhAYILGNa/iYvCzwg7rJYUvOO/OHbkfrp5UeXQyVSRfqh/voMoNwq36wwHGUbYUeW1E7jOQUpi6QyvewzRcDaJbi6T3zzMaI3kQkOGNO0cWmEZi6/uigNC/Y4M0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950656; c=relaxed/simple;
	bh=f6Ki9Bs4WdwntAB8L1uuoI8lBWPYo9PckEj6gChHM6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvdIO8pXiigjaXU5s/fk1LL+++KNeLaRa0+xP4KB4SnNMwKR7pp+9yxHEheD7q4lXLEai6EBshdeoaTNrwM/oS2Fzmp+46Gk9nsLNOC3X/VaXIfPgkgmUcYwOp26mnJ8MO7PmJxrRUugV38AWASAh+k/H689PcyhYP5FWWw8suw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ukc48hpY; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukc48hpY"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-907ae240ac3so6074436d6.0
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Aug 2026 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950653; x=1786555453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJrKn0kXvTaLMxBjdMbh3otOomEjpDNvcq81TqM+ihg=;
        b=Ukc48hpYpD6goOUZw+0SokI+gl9UWNz19OfyVDxbw004M9J1hRaulmJPcBV3aZOYu0
         RAZnj7X1dlaE7W3Gk9r9m1mobOOj8LiyOTGMVsP1fflFmkUVyofe2s7oXEU8iMvQEFup
         /mFFEbRWClLGyYMohVpKSWG8nxEJxYBvJf7DOptdcF5fiDcLZ1czbkuLd7ilsaIcxG1L
         ZQun0ehCNJ8GBCcA4gHG2//XqwZpJxws+CW2eQkFRNVy/ncpU78DpQOyUbAWcq0Gv9ei
         2I5m+VwzqViKdwkoc5jnV9lfTS8XPY4EyD+TuVHYXBTAF+frp+0iuv5BRj3DwyfcT4qE
         ExyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950653; x=1786555453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJrKn0kXvTaLMxBjdMbh3otOomEjpDNvcq81TqM+ihg=;
        b=Y5xjA5QKQNKvtiBYnEtCF8U56kU1k62FOMANh7AA/DkIzi/HcgmliA62BsT+7fV6rq
         s/vffPBNXyg8DWv0jnxJsZgldtKVrRbASXL232zMagkgjjIMQ17Iyj4w3kXPgYSzwgHU
         X34TqPRjQ/pMmHnfOWnd8ExH2IfU3t5Avf0VDhxx1cLB00d3A2T3Nhl71X6If1g+PJpF
         APWgp1UVQDJPwuUzUYLYaaTFg/MUxoOoxqJh+lWEoy+UNnfRPcGnURTyBcHBKAX+JtBP
         cODUmmMT5xP78/C/JwjQo69YgZp5gWex2binYcvGlPKdKXj6kINiZUAMsVw8jPPw2ejF
         /3sw==
X-Gm-Message-State: AOJu0YxoSMVQU5vFeNfp+YndkDPIFfOvkD3ce12+17Flvr5s81W/ZG3f
	23kYhXKxQIHacNvsA40TQ6NWAf23WlwlKgQVFfKz3kBxbTZ9gWm2/Auow1W3og==
X-Gm-Gg: AR+sD12Ia/rTiTmX5SihyDcx1Qw8rAOHA79GZcDwVSwLZmaA9oOGs6MxwmPCe884Scd
	LlFAVaeEkvZCgI2ailV8AJs28+YX+x44ZD1TQovosE/BBBK5iBkzMl/hMN29R/sF2F12OA0e/YK
	NYP6NI/j31P6xmsSYoBxQYiY7upG8k+KfTPxmPw6mn7k8+VxC4WT+uO9WNqugL9C+mIln1FoxAd
	T4qn2i0AcC3tohclJLzQ+lsLc3W6lmlRjcLvxw6x7dFjxCT58ewFmjYTSYn5nBkEKn3qMesdr8s
	bkWbcGEyRH5dlBC+xXM/u10zxOk/T5bOUvrK1rwenaxowaOfoPD8O2Yh1aDPhWSKB+H3WHyXcuo
	tTEZYwIVeV/PEAMnsESz+kxnULWlb5Ig43iGpkemBq6qjenqBFE+jawdHKtfBcpYQtVMuJ+rlnw
	AkFJGDfcm+ZYBaF0BevZIzpvmUXHvDY6RWsy+dynH5esnXy+OuEwfRNOQWmX7bAu2fIiTn5kNSo
	CCzBCTojCAW4o2s+jxrNftzKUm+IjLnBfzck4p4221iMXt+rEYlEGE=
X-Received: by 2002:a05:6214:248f:b0:907:dc74:a2ec with SMTP id 6a1803df08f44-908811d5a5amr92458186d6.12.1785950653253;
        Wed, 05 Aug 2026 10:24:13 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffbccd6sm29943596d6.16.2026.08.05.10.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:24:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	David Runge <dave@sleepmap.de>
Subject: [PATCH] tuna: Fix circular import in setup.py during isolated builds
Date: Wed,  5 Aug 2026 13:23:57 -0400
Message-ID: <20260805172357.156378-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setup.py file was importing TUNA_VERSION from tuna.version module,
which caused a ModuleNotFoundError during isolated builds with
python-build because the tuna package isn't installed yet in the
build environment.

This commit replaces the import with a get_version() function that
reads tuna/version.py as a text file and parses the version string
directly. This approach:
- Works in both traditional setup.py builds (CentOS/RHEL RPM style)
- Works with modern isolated builds using python -m build
- Works when setup.py is removed and only pyproject.toml is used (c10s)
- Maintains backward compatibility with all build systems

The version is still sourced from tuna/version.py as the single source
of truth, but without requiring the package to be importable during
the build process.

Reported-by: David Runge <dave@sleepmap.de>
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 setup.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/setup.py b/setup.py
index 8036a647f698..99253600b20e 100755
--- a/setup.py
+++ b/setup.py
@@ -6,7 +6,16 @@ from os.path import isfile, relpath
 from setuptools import setup
 
 # Get the tuna version from a single source
-from tuna.version import TUNA_VERSION
+# Read version without importing to avoid circular dependency during build
+def get_version():
+    version_file = os.path.join(os.path.dirname(__file__), 'tuna', 'version.py')
+    with open(version_file, 'r') as f:
+        for line in f:
+            if line.startswith('TUNA_VERSION'):
+                return line.split('=')[1].strip().strip("'\"")
+    raise RuntimeError("Unable to find version string")
+
+TUNA_VERSION = get_version()
 
 if isfile("MANIFEST"):
     os.unlink("MANIFEST")
-- 
2.55.0

