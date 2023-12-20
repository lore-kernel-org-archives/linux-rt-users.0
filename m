Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CDC4E1B3
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2023 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7hGOejt"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42788536cddso898131cf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2023 14:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703113138; x=1703717938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0gjTRcq3CQfpV4Cp74tfDacn2mItIie98i0d5rr0C8=;
        b=V7hGOejtgS6rn9SWJFUSmTe5I6/3IQ96pK4D+aZQ/vI6ARfFw6XinefypE9DlNLmqB
         MujjHIFUc7KbwouTGbqF7WQCKubrEuK5CmxAiPGuSZpdIeXZ5P3vMW5lTrVAER1j1E3t
         yc3ojPnwds2n5v838QimodySIKS7+qX1hML132yCCBIFbLF5ncR/DEWO9x/dmhAepnWD
         TiQiuM9xilJgEXvmAJR1dKT8DFaQ++0NQz/+0JBYhXQpwfOVScsuSHsu58TFl2JSvG4x
         0LQXmIxgKDskIxsNKx2w5JBPtfDjivsVXgpvE01J8DdqJZrO2KIJv4Zc6YslhpHRMNYf
         FsvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703113138; x=1703717938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0gjTRcq3CQfpV4Cp74tfDacn2mItIie98i0d5rr0C8=;
        b=DuGMJvGfnAih15TF3S9LyVBHzbEQsLt2dwOIVz/aQb5OY658Gc1VP072pSd0kSaTbG
         rtKOhaOgQlxmFg0kPQNf6hkh+2iBAy+XQUZBA4trngc7BDZGOYQ0tnRUl335LTSY9NoW
         4VlhmfU9Bd63Yog0js0kMeSO9cLfTxdmXTP+8LfvyLFiiYcU5T2jnK3okvFRfRGHGXLl
         7OO9mzI32nvscdNoyb3m+QkKrMZ+/MylC0JGBgY0R/1D2TIm0rMntagTFqKxfimYy01p
         uCtXSTVhpoMWK5e/YC44rXNS01+OM2Ys7G7NDx7kYTeKsFhuVe892rWXDCjvRPvKf4Wj
         yj+Q==
X-Gm-Message-State: AOJu0YxNjbypIe9xUU2ECZ+OhdruZ22410P+ZaK3nZj1Dkpued38IhiH
	3r5rKL8WEeimP7xa+Xk9b5D/Gy0+24c=
X-Google-Smtp-Source: AGHT+IHQg/0q5rQty2vCl7mjCp4t8HS8WYgcoCu9ruW0M/mdu4cuCARHZAVqHdKbb+YXFj11jZwBSA==
X-Received: by 2002:a05:622a:138b:b0:425:4043:18bf with SMTP id o11-20020a05622a138b00b00425404318bfmr27591210qtk.114.1703113137757;
        Wed, 20 Dec 2023 14:58:57 -0800 (PST)
Received: from fionn.home ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id eo12-20020a05622a544c00b00427692bc384sm277488qtb.66.2023.12.20.14.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:58:57 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/2] rteval: Disable use of python-dmidecode
Date: Wed, 20 Dec 2023 17:58:25 -0500
Message-ID: <20231220225825.171222-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220225825.171222-1-jkacur@redhat.com>
References: <20231220225825.171222-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

python-dmidecode is not being maintained upstream.
For now just disable it's use in rteval since it is useful but not
essential information for running rteval

In the future look at generating this info directly using dmidecode.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 README                | 6 ------
 doc/installing.txt    | 9 ---------
 rteval/sysinfo/dmi.py | 4 ++--
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/README b/README
index a5cf98344a46..b352d7f66ad2 100644
--- a/README
+++ b/README
@@ -19,15 +19,9 @@ Rteval requires the following packages to run:
 Python >= 3.0
     http://www.python.org/download/
 
-python-ethtool
-    git://git.kernel.org/pub/scm/linux/kernel/git/acme/python-ethtool.git
-
 python-lxml
   http://lxml.de/
 
-python-dmidecode
-    http://www.ohloh.net/p/python-dmidecode
-
 libxml2-python
     http://xmlsoft.org/
 
diff --git a/doc/installing.txt b/doc/installing.txt
index ff2d43cb9481..227249bbc9ed 100644
--- a/doc/installing.txt
+++ b/doc/installing.txt
@@ -1,18 +1,10 @@
 The rteval utility requires some external software libraries to run
 properly. These are:
 
-python-ethtool
-  A python library to query network interfaces
-  git://git.kernel.org/pub/scm/linux/kernel/git/acme/python-ethtool.git
-
 python-lxml
   A python library to parse XML files and XSLT stylesheets
   http://lxml.de/
 
-python-dmidecode
-  A python library used to access DMI table information
-  http://www.autonomy.net.au/display/pydmi/Home
-
 libxml2-python
   A python library to parse XML files
   http://xmlsoft.org/
@@ -22,7 +14,6 @@ rt-tests
   git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
 
 
-$ sudo yum install python-{dmidecode,ethtool)
 $ git clone \
   git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
 $ cd rt-tests && sudo make prefix=/usr install
diff --git a/rteval/sysinfo/dmi.py b/rteval/sysinfo/dmi.py
index e8285d263fe6..c01a0eef1435 100644
--- a/rteval/sysinfo/dmi.py
+++ b/rteval/sysinfo/dmi.py
@@ -15,8 +15,8 @@ from rteval import xmlout
 from rteval import rtevalConfig
 
 try:
-    import dmidecode
-    dmidecode_avail = True
+    # import dmidecode
+    dmidecode_avail = False
 except ModuleNotFoundError:
     dmidecode_avail = False
 
-- 
2.42.0

