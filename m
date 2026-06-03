Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786583D1CA4
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Jun 2026 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519804; cv=none; b=fa4bE4hRdA0gsIir4E8g3USrdk5Y7AGw8cX3YtWvbbrXNGOz8IaqarKCikp9iGyLku64J2jYugx6FiDmwhALZ7sd2u2RuWHtEWljPxJmmELZLSf6/hZ3zviTJ32JjHwvBmKfEB74blUKeg7Zt30j3eCkybdfRfImKxOX5E9iAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519804; c=relaxed/simple;
	bh=n08HS6U1MhboCnaD2JNSCGwIDNwqbnU9DLFV1rn8hVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jld/Jbuu3O8Wa93HykNWrRndkhGTdswTQTDrDnk6IBydH5hd+wf2wEWI/3oTyi6XK0SyMkXzjrC5LEtsWc8gThaziZD1pvsjC7X5v3O2mTh4uDTREx7yTzhK5CTvRu2R7q4CL0L9DM5uF8olgXIYpYqgH8i3tF4UMCMejszIW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxf3JHa1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxf3JHa1"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8cce26ee1e9so93383276d6.2
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Jun 2026 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519802; x=1781124602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fce37GaMkF/ABn+ujfyK55xG3FgaNHriG5Tm1A6wGk=;
        b=lxf3JHa14ruuLhA9XH2A+3vcKPwCG/gQErNrrVebo02Cqurk3cszLK7wuwxF9fPYez
         JQTX0u4G+3fdH+o7ZKQPuCxoUJRex2V/LiEWr0TXyVBdli8fWQ7VKCVTmi4XMR6BJR7I
         q8Eone4NAQ8FsQXeKzvXWKpur10sHGJElSJcPHukH3APWD0m/VsB3O/IYlrq+fRWg5Zd
         GRRMmchACrXt3WkrmzVYoPvHDrTtP11TB1GMW3b/74fMZeNVkD34ZxxIRFsSg0mmKXNh
         xieI5rlpVFW/IpuEMZQuGHOOkDTdgtaZnFXBK7g+G2VTcy7QxiHuuesbikVaVJjNipZ0
         YXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519802; x=1781124602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fce37GaMkF/ABn+ujfyK55xG3FgaNHriG5Tm1A6wGk=;
        b=ZU1e2tZyYb+AHOpY6mhB8J2i2CfjrLlDQ5h8zjR9MGTtmdNXiYs9clxSkxC+FuL6Y5
         d/hMfwy+4sKzdlSjn33zfZdYihXK/Y3ukWKF1z+ULHmrGon27WNgKEgpMfh/YziVuN/l
         6fBLKpx8Tyx2F5S+1ByxIuIAyLZIJ8nICypJYhGIHtzNyci1NeJ9iOmXSjWZvjOQQ17r
         TuyYUk5KTwYGoBn0vGhxUjjDvDz2hW2ujSWQJE9RT2C1B0tE+jjGo/kl7FxfHMV3B0lV
         grEbmnFvB811du6GBvJl8VatqlAClDN9/mEp7I/Kislnt/cFSCpjv6oTXebAz2HWU08R
         RZqQ==
X-Gm-Message-State: AOJu0YzM6wmPgUnpLDe9N5C9kPxmU37q5lBRYjt29dWRpTQZfBnuiOcp
	HsA7aFPs7yZKXmBZrpibPn4oZRGcuPzjVLE/MflhLiXf71DIZLEF1PDYBTZSfw==
X-Gm-Gg: Acq92OEsDuEkzqB+90ETOwx1GnhM9LaB6JC61+gce1uwlt/NGnpzqvrSC8xqfgw3TJU
	rMrNKBDM2WUTC84B3cSHyKkkyvFQz1QSO0ejI22qt6APv20OFjSlcHmx7p7CK7paAeDVgly2ohY
	lnDPv98VxsgKol8wRPNrTetr+Lgj+m0Ygu80JT52AhiTRgVMzpPEJh0k+Lk7FaGJT0ZcHFscwSh
	DwZnioEKxPh3HFPCC4DoL61ZYJoR4BamFY6xRRItvmIFq3fkrabpi1cxWIM7fc3I6eZ1kIW8knb
	Z3iSdxBqgHEZQZ5eqsr59FetT0iwonWdoKK/SjPlOosnjakOdZiQATq+QRBExZYh2Rjq+6oR/oe
	coY/IwLl1Ara5x9wMmsANYNdxn/LnB5RAeTmJRRiYwXhk6FCC3IfWtEMbWU8P/98hmPe0t4IKmh
	ZBGaI7EDQolp7byvYywEL1j5++ijMuI/v2bw1N/DO0sGkhwfs6ZQIdhIuVUFfC8GPJ7c6PJGBfF
	jMKfjnKtpVd8Kd+QgaCbu4HLgBdhhw3VDXBdkbimyiAkPQdvShxtRUrOLe6nqNqKyGqS6/f2fjk
	Cqpm4nSgLk/2ym+NC7k=
X-Received: by 2002:a05:6214:600c:b0:8be:3da0:bba3 with SMTP id 6a1803df08f44-8cece0306admr75358956d6.34.1780519802263;
        Wed, 03 Jun 2026 13:50:02 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb94b5sm31742426d6.15.2026.06.03.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:50:01 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: williams@redhat.com
Subject: [PATCH 2/2] rteval: Add make uninstall target and fix pyproject.toml license
Date: Wed,  3 Jun 2026 16:49:53 -0400
Message-ID: <20260603204953.226473-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603204953.226473-1-jkacur@redhat.com>
References: <20260603204953.226473-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add uninstall target to Makefile:
- Removes rteval script from $(PREFIX)/bin
- Removes man page from share/man/man8
- Removes XSL files and load files from share/rteval
- Uninstalls Python package via pip (if installed from make install)
- Preserves /etc/rteval.conf (user may have customized)
- Respects DESTDIR variable for test installations
- Added to help target and .PHONY declarations

Fix pyproject.toml license deprecation warning:
- Change license from table format {text = "GPL-2.0-or-later"}
  to simple SPDX string "GPL-2.0-or-later"
- Fixes setuptools deprecation warning about project.license format

Add tags to .gitignore to ignore ctags files

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 .gitignore     |  1 +
 Makefile       | 26 +++++++++++++++++++++++++-
 pyproject.toml |  2 +-
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index ee5621e3fa3d..bd20ca2f4a71 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,3 +29,4 @@ stamp-h1
 autom4te.cache/
 rteval-[0-9]*
 local/
+tags
diff --git a/Makefile b/Makefile
index a9d3a871f123..8b540c6c68b4 100644
--- a/Makefile
+++ b/Makefile
@@ -94,6 +94,29 @@ rteval-$(VERSION).tar.bz2:
 	mv dist/rteval-$(VERSION).tar.bz2 .
 	rmdir dist
 
+uninstall:
+	@echo "Uninstalling rteval..."
+	# Remove the rteval script
+	rm -f $(DESTDIR)$(PREFIX)/bin/rteval
+	# Remove man page
+	rm -f $(DESTDIR)$(PREFIX)/share/man/man8/rteval.8.gz
+	# Remove XSL files
+	rm -f $(DATADIR)/rteval/rteval_*.xsl
+	# Note: Leaving /etc/rteval.conf in place (remove manually if needed)
+	# Remove load files
+	rm -rf $(DATADIR)/rteval/loadsource
+	# Remove rteval data directory if empty
+	rmdir $(DATADIR)/rteval 2>/dev/null || true
+	# Uninstall Python package
+	@if $(PYTHON) -m pip show rteval 2>/dev/null | grep -q "Location: /usr"; then \
+		echo "Uninstalling rteval Python package..."; \
+		$(PYTHON) -m pip uninstall -y rteval; \
+	elif $(PYTHON) -m pip show rteval >/dev/null 2>&1; then \
+		echo "rteval found in pip but points to source directory (not removing)"; \
+	else \
+		echo "rteval Python package not found (may have been installed via RPM)"; \
+	fi
+
 help:
 	@echo ""
 	@echo "rteval Makefile targets:"
@@ -106,6 +129,7 @@ help:
 	@echo "        cpuset-tests:     run cpuset integration tests (requires root)"
 	@echo "        tarfile:          create the source tarball"
 	@echo "        install:          install rteval locally"
+	@echo "        uninstall:        uninstall rteval"
 	@echo "        clean:            cleanup generated files"
 	@echo "        realclean:        Same as clean plus directory run"
 	@echo "        sysreport:        do a short testrun and generate sysreport data"
@@ -121,4 +145,4 @@ tags:
 cleantags:
 	rm -f tags
 
-.PHONY: tests unit-tests e2e-tests regression-tests cpuset-tests
+.PHONY: tests unit-tests e2e-tests regression-tests cpuset-tests uninstall
diff --git a/pyproject.toml b/pyproject.toml
index 9fc681f3f91b..b981ca7d7661 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -18,7 +18,7 @@ analyzed for standard statistical measurements (i.e mode, median, range,
 mean, variance and standard deviation) and a report is generated.
 """, content-type = "text/plain"}
 requires-python = ">=3.10"
-license = {text = "GPL-2.0-or-later"}
+license = "GPL-2.0-or-later"
 dependencies = [
     "lxml",
     "requests",
-- 
2.54.0

