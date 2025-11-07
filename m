Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7663339B24
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540039; cv=none; b=VGoy8L/OHrG/WWJ9pabMTMFL0SZYgJ3AtXJart8s/5VhGlNo3iYAeBj4rb44CYPY+ybEfnqIjIVNIr+o73HKgnL0IYFpKgTEJooQvxF7FHO4qESV4mFDdy/Be5mf+niqe37l3vwjV0G/jERjx35/HBottCxiq28Y4vwQizm9wGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540039; c=relaxed/simple;
	bh=wT7sJs4h/RzBdbjWuFJiXI24mNPY+UjzChWKw/IOBD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS47KJwpwy0t9wQS6KHWXUa2OFwXDbGzN2J27HeRAhZHgamOdnAUpI2utXn3oLpQop7MIzgLWxzPbMUkbgl94z4NIl/jjUz9Lt7hBpH16akpnFcIOfAvVgjIW2FoeqREUO/Jar4ne/L/IbtUcb0YRty4q8GIfgJVS/telyH91SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OomEr3kw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OomEr3kw"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-891667bcd82so109532285a.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540036; x=1763144836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK7xwSeY9q4Olz890eKB6Q6YPCgDm0mkrg7r9a8jQHo=;
        b=OomEr3kwJHrUor9b06SV3dKgqYqX+7SoFEs/PHmCQbtQUxm+4rBpkEY/YD1+LBnaRY
         wNFH4KXTS5yasZjRiouEIHhmE1Hv292BD6xhXz9Qh3xMmHaVsDjvbi5TwCFKJ2i5xPoV
         YVzqYthOYMPCGmMenDpTzCkOVO2Zxa2pIK6PryWHjXkUnQgA+7s9r3Xb+DDnsvXVw7iL
         k7wP6Jcj319RDP7EYbWRXRhS8K1rjRTBM3QU6aTnzRsb/ywkN2XieSUZT4reNwzOxi5J
         piLhsrAjhbC+sqUImaTTs15JXJuuT69kqw2nj+pyQD5CyO2cGJ3cjoCi6cpqptZBd6W4
         Z5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540036; x=1763144836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KK7xwSeY9q4Olz890eKB6Q6YPCgDm0mkrg7r9a8jQHo=;
        b=uzfQ+R+tMtAKhYoU0efBq4y+TD+cCdK3cpDemMzIN+zy8dKGTTdNznhrF0cd2pwsiA
         oYzmmL21eHbshrLE30t7r+FrKDqgrFWqdbNkmdUGfHVfgnpzXRCeAFIz48yQcmccy2WB
         JsUgaS2vipGC3Hg7nCBCeG0zugJjPO9VyRWcNinH3BFtYFbvALsLzW5VAbGP/CvYSTv6
         RsNDPke6t4RjwYQOlm/mkt8rjK3Oz5vt7qBnz1uU3J8FuDzC6uT2B5Nrs04LVW+Fl2dC
         Bt4JlBg9u3ZMYXalF7MKZoVbSdHZM+bPxiMiYHDMoVEXXKWzavsAq3qTOGzw/Vij58LT
         KegA==
X-Gm-Message-State: AOJu0Ywq+sRmo4MPqjWHX3v+p8LfuIX3spu4iCKyNlFapthneLicHmHA
	cYoAttzk4iiZRMo+9MUrXAVTR8eYQ4jWPSQE8sEDIXnSPBCY2STuMa+VA8/dkH1K
X-Gm-Gg: ASbGncs/HTl9a5Rlns0A5cU1DoJ9lSLoTSBsnc63t6CH0XmoNBgG0lYie8G/ZxhD/0E
	dLDv6oifxAkLBBJv6+D2KaO/idrQiL9nfSe1qyJvrfaGH63u4oZFTzv4CxvBaLiKMxqvLh+nTD2
	theaw2fCuwQpDbUzI/VaMtvbtNiq8CEHeyClyZ6wjnmoPdfOutFf1CgmyQA/YTU/N5kqbsyYRh4
	dtLD0POsRW9ZI8BiU9YT+5RAiefexqRuRoTC0MU7STIgXSDuCFjpqtidOxzVAaVX1W2Cmh6vohO
	HJjD0GcoBvNgYntPkIxt7ujlEXPjTA6vjbnC469GBdl1EQRCsOwOlJ9OxoXeWCHb1XrH/J3cC/z
	7vxALQd+1h4o/wYkdpyTcpLa1rrL/T9hqt7mL7p6NyAD7GgxH1bircM6OrEJs76tMej5eb/bkBg
	==
X-Google-Smtp-Source: AGHT+IETd3OtaI/lHzeRvkpNq9hmheHJg8bZpqOBJDY+X+EE5sxvv11MRIA9tKtCmaP/b/BMX2VavA==
X-Received: by 2002:a05:620a:4095:b0:891:7008:f2e0 with SMTP id af79cd13be357-8b24d697a9bmr303521585a.8.1762540035988;
        Fri, 07 Nov 2025 10:27:15 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:15 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 08/12] rteval: Add pyproject.toml for modern Python packaging
Date: Fri,  7 Nov 2025 13:26:31 -0500
Message-ID: <20251107182645.19545-9-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pyproject.toml to support modern PEP 517/518/621 packaging while
keeping setup.py for backwards compatibility with older distributions.

The pyproject.toml provides project metadata (name, version, dependencies,
authors) and works alongside setup.py which handles script installation
(copying rteval-cmd to rteval).

Add John Kacur to the list of authors and set him as the maintainer
in both pyproject.toml and setup.py metadata.

Requires Python >=3.10 and setuptools >=61.0.

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 pyproject.toml | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 rteval-cmd     |  2 +-
 setup.py       |  6 ++++--
 3 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 pyproject.toml

diff --git a/pyproject.toml b/pyproject.toml
new file mode 100644
index 000000000000..9fc681f3f91b
--- /dev/null
+++ b/pyproject.toml
@@ -0,0 +1,58 @@
+[build-system]
+requires = ["setuptools>=61.0", "wheel"]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "rteval"
+dynamic = ["version"]
+description = "Evaluate system performance for Realtime"
+readme = {text = """\
+The rteval script is used to judge the behavior of a hardware
+platform while running a Realtime Linux kernel under a moderate
+to heavy load.
+
+Provides control logic for starting a system load and then running a
+response time measurement utility (cyclictest) for a specified amount
+of time. When the run is finished, the sample data from cyclictest is
+analyzed for standard statistical measurements (i.e mode, median, range,
+mean, variance and standard deviation) and a report is generated.
+""", content-type = "text/plain"}
+requires-python = ">=3.10"
+license = {text = "GPL-2.0-or-later"}
+dependencies = [
+    "lxml",
+    "requests",
+]
+authors = [
+    {name = "Clark Williams", email = "williams@redhat.com"},
+    {name = "David Sommerseth", email = "davids@redhat.com"},
+    {name = "John Kacur", email = "jkacur@redhat.com"},
+]
+maintainers = [
+    {name = "John Kacur", email = "jkacur@redhat.com"},
+]
+
+[project.urls]
+Homepage = "https://git.kernel.org/pub/scm/utils/rteval/rteval.git"
+
+[tool.setuptools]
+packages = [
+    "rteval",
+    "rteval.modules",
+    "rteval.modules.loads",
+    "rteval.modules.measurement",
+    "rteval.sysinfo"
+]
+
+[tool.setuptools.dynamic]
+version = {attr = "rteval.version.RTEVAL_VERSION"}
+
+[tool.setuptools.package-dir]
+rteval = "rteval"
+"rteval.modules" = "rteval/modules"
+"rteval.modules.loads" = "rteval/modules/loads"
+"rteval.modules.measurement" = "rteval/modules/measurement"
+"rteval.sysinfo" = "rteval/sysinfo"
+
+[tool.setuptools.package-data]
+rteval = ["*.xsl", "rteval.conf"]
diff --git a/rteval-cmd b/rteval-cmd
index 7af179321fe2..8fd37b98b069 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -307,7 +307,7 @@ if __name__ == '__main__':
             default_kernel_file = ModuleParameters().get('source').get('default')
             if os.path.exists(tarfl):
                 if rtevcfg.srcdownload == default_kernel_file:
-                    sys.exit("Default kernel already exists, will not download")
+                    sys.exit(f"Default kernel {default_kernel_file} already exists, will not download")
                 prompt = input("Kernel already exists, download and overwrite anyway? (y/n)  ")
                 prompt = prompt.lower()
                 if prompt in ('no', 'n'):
diff --git a/setup.py b/setup.py
index c2695cb748a0..82db22989a6e 100644
--- a/setup.py
+++ b/setup.py
@@ -44,8 +44,10 @@ mangz.close()
 setup(name="rteval",
       version = RTEVAL_VERSION,
       description = "Evaluate system performance for Realtime",
-      author = "Clark Williams, David Sommerseth",
-      author_email = "williams@redhat.com, davids@redhat.com",
+      author = "Clark Williams, David Sommerseth, John Kacur",
+      author_email = "williams@redhat.com, davids@redhat.com, jkacur@redhat.com",
+      maintainer = "John Kacur",
+      maintainer_email = "jkacur@redhat.com",
       url = "https://git.kernel.org/pub/scm/utils/rteval/rteval.git",
       license = "GPLv2",
       long_description =
-- 
2.51.1

