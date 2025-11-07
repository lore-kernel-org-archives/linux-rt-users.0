Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E433DEE8
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541904; cv=none; b=hZ/OdxHRfaSHZFRVAePQH1hmIp+bGX0LfbOExLfHB96ejCqZA4PIC0bVSxudapTf7Ji2OnYzTyl/LJ9XY58D23khBuQCCKXfCSaaZsGkERUkHCMG6pfKjRXcy4QZ3h7zHQE++V4mZddADCCIupGV8QY0LO6FvMXzatODEWshf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541904; c=relaxed/simple;
	bh=G7+/cygh7RWuGut9SX/8aQa4x1HtqY+3MZJUDvtY2ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGfAH7I433jP0e+LB2MSZbdl9kFT7roHRMOglFh/W8RoM0izYSwB6RSq25StWJMdAb3yEsEJO/JtdruISzBDRp233lR+p2Ix4gO0WPRzxI+/Wrwgeqb6qYanD1aTYgp+3EGiUZOBkB0keYVNoVB0TRHZTXdgOZf0csSB8XnEvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOluuDPA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOluuDPA"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-89c81839de7so65523085a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541901; x=1763146701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVb2jW01H4oQrdCJ5xpZ65fXvHFqRpTtrgPYLgQHckc=;
        b=QOluuDPA6MyXJo93aWo27aqG09880Q+Bsy4vY7EYhgABQ4nJKiX6F05833Jn71rmSm
         o8qebOaJlUoE++Yz35BlBM0q2uB/aNQkWBeciIwZ115j1eKvp+iXDr8yuT2BqV4ph5x3
         PMrvA2vEwBJPWTZMzYs5PaNvq8gw0XlclYsOkOjadnE1CbVb7vPLoLoZAxb1wSohRJGV
         oakacaz7Xm+kag4MSIbR+OFxRDUHGuF/uYhJa3YMgixyb4fy4r8RkummBWUDj0PO0Wfk
         e3Ns+pp2NgBtJ5Onzq07Um0MPn07brXKBVJninoMVoFUSlIKSx/SZi474pSdebNT2ebv
         EXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541901; x=1763146701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVb2jW01H4oQrdCJ5xpZ65fXvHFqRpTtrgPYLgQHckc=;
        b=I4MRyYdz/F+6lgitlTsv1gl208OHsYDhDYvGwa2Y7iKm1Mwn0Ehvm7fFRycjyxcSC4
         VC0TqzyROihlzWBQnL55bQ+2hIpfvfGkQk4bQETzxOkEmmq497rYPgJ5l0ZoDuebrLVv
         9xfFVsQqa3LAe0sM4+1/qczCAINHx9vkKiMR+BoeUEhD5iqa5tNCdLXbkNMGaxQAyCvc
         0CKEl9j9kfJwLkebE2p76rIllltVo5xzUt6LeBVq0s+nGv8hqr/iU3830cP01u/57O53
         bm1Q2y/UPiSlQwn+mUDeLT+V1U8PemTPAOTc2JZwju0Zu2KKIUjq7bCZJdiO1W93kXJO
         oqCw==
X-Gm-Message-State: AOJu0YwhaJW6SJja0nLKJeN85IFhdNzsZ2Q/aaCvInFL8XnVVx9zx3YW
	DkZxvOsT47+GuED1R0LBFVuQv0hx8tv4flDxwTek6fdriZ/bCPzcYauykKrZlc3A
X-Gm-Gg: ASbGncvVnx3LK9qfMAJStG/huQrBJ4BoFpJA+GrLo1M1N5389LmGnZRvK0dMVOPIvgG
	osUCUVgvNEyho7g1KknDW0pQj48o2xI1qpsGQQzJH31B9lGMkYm51vfU436958FI81wwBa3n71a
	NXM5dJtLFurbP4I3cOn819ib+WF6rvf1fu5gzLe9hp863+754jm0db1tF5eR3azoZQfxLgfxhfh
	lxGqoGy4shCm9/9kSE+X/JeZzQr2Oquzc2VVYlpzG3GOkzztY2qM6gFYAXsimLxta4LRdPQ1kVG
	lo/uPk/lfGTKp11/aV5Qq/UnkErjZ+fsSJzvho67qdXnyYIyXTmcSV8Dz1Nmwbw8kzPiwFOi94f
	loDc534Dg//C+8tSS/U3XcM/xezjGfaL8QsQf8DZs3bcPTZ4hGT4SJpPedDz57Y+oSM23VTvwmq
	SvM8BJ6Tp1
X-Google-Smtp-Source: AGHT+IGybFupP3oq/kuD60V687N3nIvNf/4VNBbywYzrXudP3PaKUIkbRA4VOpP6xwPcVOz0MWX/uA==
X-Received: by 2002:a05:620a:7105:b0:892:ce2b:f869 with SMTP id af79cd13be357-8b257ef5ceamr46681885a.13.1762541900724;
        Fri, 07 Nov 2025 10:58:20 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:58:20 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 21/23] tuna: Add pyproject.toml for modern Python packaging
Date: Fri,  7 Nov 2025 13:57:30 -0500
Message-ID: <20251107185732.23992-22-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107185732.23992-1-jkacur@redhat.com>
References: <20251107185732.23992-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pyproject.toml to support PEP 517/518 modern Python packaging
while maintaining backwards compatibility with setup.py.

Configuration includes:
- Build system using setuptools>=61.0
- Project metadata (authors, maintainers, version)
- Python version requirement (>=3.10)
- Dependencies (python-linux-procfs)
- Entry points for tuna and oscilloscope commands
- Package classifiers for PyPI

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore     |  1 +
 MANIFEST       | 30 ------------------------------
 pyproject.toml | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 30 deletions(-)
 delete mode 100644 MANIFEST
 create mode 100644 pyproject.toml

diff --git a/.gitignore b/.gitignore
index 29b00a0834ab..d8e20215de9b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,3 +2,4 @@
 *~
 *.swp
 tags
+CLAUDE.md
diff --git a/MANIFEST b/MANIFEST
deleted file mode 100644
index 95ae7c5ddd74..000000000000
--- a/MANIFEST
+++ /dev/null
@@ -1,30 +0,0 @@
-help/kthreads/
-oscilloscope-cmd.py
-tuna-cmd.py
-tuna/__init__.py
-tuna/help.py
-tuna/sysfs.py
-tuna/oscilloscope.py
-tuna/tuna.py
-tuna/config.py
-tuna/tuna_gui.py
-tuna/tuna_gui.glade
-tuna/gui/__init__.py
-tuna/gui/cpuview.py
-tuna/gui/irqview.py
-tuna/gui/procview.py
-tuna/gui/commonview.py
-tuna/gui/profileview.py
-tuna/gui/util.py
-setup.py
-rpm/SPECS/tuna.spec
-MANIFEST
-po/LINGUAS
-po/POTFILES.in
-po/ja.po
-po/pt_BR.po
-po/zh_CN.po
-ChangeLog
-docs/oscilloscope+tuna.html
-docs/oscilloscope+tuna.pdf
-docs/tuna.8
diff --git a/pyproject.toml b/pyproject.toml
new file mode 100644
index 000000000000..8333a1acb913
--- /dev/null
+++ b/pyproject.toml
@@ -0,0 +1,42 @@
+[build-system]
+requires = ["setuptools>=61.0"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "tuna"
+version = "0.19"
+description = "Application tuning GUI"
+license = {text = "GPL-2.0-only"}
+authors = [
+    {name = "Arnaldo Carvalho de Melo", email = "acme@redhat.com"},
+    {name = "John Kacur", email = "jkacur@redhat.com"}
+]
+maintainers = [
+    {name = "John Kacur", email = "jkacur@redhat.com"}
+]
+requires-python = ">=3.10"
+dependencies = [
+    "python-linux-procfs",
+]
+classifiers = [
+    "Development Status :: 4 - Beta",
+    "Intended Audience :: System Administrators",
+    "License :: OSI Approved :: GNU General Public License v2 (GPLv2)",
+    "Operating System :: POSIX :: Linux",
+    "Programming Language :: Python :: 3",
+    "Programming Language :: Python :: 3.10",
+    "Programming Language :: Python :: 3.11",
+    "Programming Language :: Python :: 3.12",
+    "Topic :: System :: Systems Administration",
+]
+
+[project.urls]
+Homepage = "https://www.kernel.org/pub/software/utils/tuna"
+Source = "git.kernel.org/pub/scm/utils/tuna/tuna.git/"
+
+[project.scripts]
+tuna = "tuna.tuna:main"
+oscilloscope = "tuna.oscilloscope:main"
+
+[tool.setuptools.packages.find]
+include = ["tuna*"]
-- 
2.51.1

