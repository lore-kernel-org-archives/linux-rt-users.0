Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F03B6340
	for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2026 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779222810; cv=none; b=nZx6tEacPaS3BjRODd7pXVRc8i18gykrxeGYODxrj3KmCny++8oNWgogn15ePTbRZY3mbMz30B2LXCZe2copLwxz16a3YPdOAsYPlu1IiTQJLm2cWU8ZC+AFXsKS3C0XCaWaP8KbGv2ctcYWIb9kpPECGfzp5eTU5IhKIQrZuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779222810; c=relaxed/simple;
	bh=xeED7EogPnorphN2Op9ihXOiUXKIRJlrNcY+lYIAnDE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MKne+KcYVzePtp5qHCtEvVGuMxVnmwo20IqahYQc9c/8UleS0xSOmT1RDFjfw3bUJge4a8qH2Blt8gMgFPbOUsf1+J3AA1+4AzyGRdk2CMcAp6J71uoNFvLq3f5xJHKS1iUaaFdp9PtB997V57iZa8A9KmS2/vM564iOHyPi6g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkzJ70eN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkzJ70eN"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso71347156d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2026 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779222808; x=1779827608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=msAE1xDrJc2zXeBjSEwh+WNjbxsd3fadmrv4l/q+L5A=;
        b=HkzJ70eNT5blnCQo7oHjsDgD4VBY4kHsL/2ii5jq9qc6+LiyR9gM62Pux99pgznKUz
         mzKL15sbTJwnGQHKHLYeiVKUIpyJ/SdjvDxewTVf1JaZe6R1/Sitn48ZUWOuUzN3i7jf
         /PEAvQlzki0V2IwbyMNS/Ty8I1nTc2VhKi0FGpVOHdVKo0RQMLf/ZSG+wj86g5EMm49e
         bOJDWJ9eeVbP4NH7zEescgsjYCsgs8KeaPYnrl5kHxJXBY/Z6cXKXr0fl0A8ulQam6HL
         GVPfzvob8ZwUEG/qr1BCPb8ZcQujIKvbZWCreKtzmY0vfiFPBB9rTxJ0BjZ4g2km3IQk
         3pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779222808; x=1779827608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msAE1xDrJc2zXeBjSEwh+WNjbxsd3fadmrv4l/q+L5A=;
        b=P8/88UPERz9WctXZql6+40vZoljyrX7BERjxbQZnDtuHJFOrrgxYc+evJhfUzl+Ffu
         AWyOVXrUpucvMlkC/KUdpMTQSRWU/WhynS4DlzHyZ55835iQ7upvN3U0EaGZgoHq4k26
         STXCmyH2wGJwzmHcijJqmNBYvfs35im4PRIO8ZaBq0SYmxqTnzVYL/Gv6DYRvChIqy4C
         2h6gXS336lAuo7lk7j51M/ITtuGfQwJO0LvRz7ELadbfwZ2A+oJMUw+nAnLKOAU/O5WH
         jroxcgiPwPmcBfclAuHEIFhs5dNGJ6MTdERvdoXA4c8PJ/zz/1saMIl+Vq4baU5j+0+a
         Gr0Q==
X-Gm-Message-State: AOJu0YyIEyK2MDfk8yfUDtzKi7djA/xMbVo8ynskp9Cd3WV0HYI3zgeo
	3p7Wh9Fvp8XZYq+kuuAeRd12AEdUACobh3sVvBG53ROhJ4i2igOHwYawrha4rw==
X-Gm-Gg: Acq92OG+vxfTIfja7p8jLBGmhZwl0paMWMS1M2kdDIJMZSUAJwCiy3hIP/uDX+oOxsd
	lAeyf5RzmR9532/wpnmvDTJOqYRcvWxUcAFdgINnbfkV1lCF7R/1ToGHTQAGwEnLl/38yYkQ+iT
	EA5TRFa8x2ar3nZrTABxJ5b01FkoM1t9R0SE7EJjNjwJyKH5nKCo6FKt+JvAOyW3Xtf3bLa+y9a
	H7xtUrhLBdDgCEuI+F/37piFw18KV76ZhSA5UlV9n4BLdyV33uxIBNkq/dNwu10PMgBHjQAUXqk
	8M6IAz3RvGkSwEkxgYU8g41o+Dj04zAZtfhp+oMlu7X8+14hFz7UdPGjxl6MIPs5loRfFAsP6tH
	L9feQJ7HZRFRGQdtQ12g6TTSvCZ1Zmxa26gEr773d+SqlSypjDUAEqNlv24DuDSt/9Wh1JcelNI
	RlCFwc7Z1fpFTxqRnxWfXfoZ5+Q6dA9o/hpcFPo1/T06XnD84NniZfvaCtTLZFyeDF58bOM1Ekv
	T/6y86V9Hjx99DEFJRD7fTarpFCUF4n9/86ZDC829y3RA3O0MUbLFbmMQveAiGFACSdrX2GjJmS
	9/6lIqCb
X-Received: by 2002:a05:6214:4306:b0:8ac:a689:34ce with SMTP id 6a1803df08f44-8ca0f6e91e4mr355725746d6.45.1779222807822;
        Tue, 19 May 2026 13:33:27 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36097a26sm102248856d6.17.2026.05.19.13.33.26
        for <linux-rt-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 13:33:27 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Subject: [PATCH] tuna: Fix setuptools deprecation warnings for license field
Date: Tue, 19 May 2026 16:33:20 -0400
Message-ID: <20260519203321.174064-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update pyproject.toml to use modern SPDX license expression format
and remove deprecated license classifier. The license field now uses
a simple string "GPL-2.0-only" instead of the deprecated {text = "..."}
format, and the redundant license classifier has been removed from the
classifiers list.

Also add missing SPDX-License-Identifier header to tuna/help.py to
ensure all source files have proper license identification.

These changes eliminate setuptools deprecation warnings about license
field format and license classifiers when building the package, while
maintaining the same GPL-2.0-only license.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 pyproject.toml | 3 +--
 tuna/help.py   | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pyproject.toml b/pyproject.toml
index f0caac6df053..ca149c352df0 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -6,7 +6,7 @@ build-backend = "setuptools.build_meta"
 name = "tuna"
 version = "0.20"
 description = "Application tuning GUI"
-license = {text = "GPL-2.0-only"}
+license = "GPL-2.0-only"
 authors = [
     {name = "Arnaldo Carvalho de Melo", email = "acme@redhat.com"},
     {name = "John Kacur", email = "jkacur@redhat.com"}
@@ -21,7 +21,6 @@ dependencies = [
 classifiers = [
     "Development Status :: 4 - Beta",
     "Intended Audience :: System Administrators",
-    "License :: OSI Approved :: GNU General Public License v2 (GPLv2)",
     "Operating System :: POSIX :: Linux",
     "Programming Language :: Python :: 3",
     "Programming Language :: Python :: 3.10",
diff --git a/tuna/help.py b/tuna/help.py
index db8b4c84df63..1a9473a86875 100644
--- a/tuna/help.py
+++ b/tuna/help.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 
 import gettext
 _ = gettext.gettext
-- 
2.54.0

