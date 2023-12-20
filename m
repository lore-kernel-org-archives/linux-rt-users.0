Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CED34D5A4
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2023 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvyBOAst"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-425860bf009so856161cf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Dec 2023 14:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703113136; x=1703717936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Uu+qRp5dyZxY5G9MfTfwH7br7tNcS3khKSnkahlW47k=;
        b=KvyBOAsteSYKVhiWm9IZ/nQy1BJyNkYxLgMFPe+b/Lk8yk1dHUblPpsAVI8rlVdJna
         9zX6RbDGHfSes1vlnBcrSmM3dXx9lE6f2nrfPcBmRpGTpZSjA6tPfbLpyZjfLTVZyTnX
         sVY09rGor5Q3wcxtNXnA+reJ0xjk0r1Ntl9U5sZiFu1S0ybIclaXj6cxT69UijX71n8Z
         gGu4lsYAOGYOFeQ/h/iaRfqsMVWBteB4ke/W3YJT4ExyHp54Lxy2ara3MrZpTpqZlyFU
         UqrhcK+IC52J50GzcFwdih/pgaDc+XwJE6V1vK0uGxPzstYhjItwdx533nZ16gPlrv73
         DJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703113136; x=1703717936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu+qRp5dyZxY5G9MfTfwH7br7tNcS3khKSnkahlW47k=;
        b=Jh0ZRX7kWCBC/kaWi7C6rlRMmig9V3ZdQEqDzPpoG2aUtPTqMCfi05VXF13JZXDZhY
         7DWIdizfT+8C8UpRDN8B69DKFLbEp4aA633BTbRNg3QJTIj0kk1KMR8h43VoiTqD/LeN
         L21hZlbrYMvERYs/zdoxH27w3KhVN3G97RDBgRoRvKwlB25MJJ6DUfTjATtLHsRiiwPP
         rjVZrtNAtx2u9mWO9uzilXyiixKDUtAbcV1sNIFyph9MTsPxTep9T1jiYpne0q55hczB
         e2L6TMalzuYSI35mZSF0SWZDAMK3eFc+NF1Vl8qB1qqTYqCD2581YaKe9W5UZP/0qZjo
         KSlA==
X-Gm-Message-State: AOJu0YyUgNqidnNukHQCo/W4cjz4wnZjcfnMf/kOMAO9qkhw9+Cj9V/Z
	ezalUulZb9oqlVwDutaV4O6V09H0ZAU=
X-Google-Smtp-Source: AGHT+IENeXmVgiq2/LnfRp9BmjK3A2obhKxHCXs/S/KdLpYZvwejCmcY4izvO2PDqaTQY1YRUeLTLw==
X-Received: by 2002:a05:622a:509:b0:423:7dde:35b2 with SMTP id l9-20020a05622a050900b004237dde35b2mr25635370qtx.59.1703113136486;
        Wed, 20 Dec 2023 14:58:56 -0800 (PST)
Received: from fionn.home ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id eo12-20020a05622a544c00b00427692bc384sm277488qtb.66.2023.12.20.14.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:58:55 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rteval: Makefile: More rpm cleanups
Date: Wed, 20 Dec 2023 17:58:24 -0500
Message-ID: <20231220225825.171222-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Afer having removed the upstream specfile, there were still a few
references to rpms in the Makefile. These are not necessary because any
work with rpms can be done with modern rpm tools and are typically done
by distributions

Also test whether directory 'run' exists since it may have been removed
by make realclean, and create it if it does not

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index ee4cca555b95..b8bed643f760 100644
--- a/Makefile
+++ b/Makefile
@@ -31,6 +31,7 @@ load:
 	$(PYTHON) rteval-cmd --onlyload -D -L -v --workdir=./run --loaddir=$(HERE)/loadsource -f $(HERE)/rteval/rteval.conf -i $(HERE)/rteval
 
 sysreport:
+	[ -d $(HERE)/run ] || mkdir run
 	$(PYTHON) rteval-cmd -D -v --workdir=$(HERE)/run --loaddir=$(HERE)/loadsource --duration=$(D) -i $(HERE)/rteval --sysreport
 
 clean:
@@ -39,7 +40,7 @@ clean:
 
 realclean: clean
 	[ -f $(XMLRPCDIR)/Makefile ] && make -C $(XMLRPCDIR) maintainer-clean || echo -n
-	rm -rf run rpm
+	rm -rf run
 
 install: install_loads install_rteval
 
@@ -73,13 +74,6 @@ rteval-xmlrpc-$(XMLRPCVER).tar.gz :
 	make distcheck
 	cp $(XMLRPCDIR)/rteval-xmlrpc-$(XMLRPCVER).tar.gz $(HERE)/
 
-rpm_prep:
-	rm -rf rpm
-	mkdir -p rpm/{BUILD,RPMS,SRPMS,SOURCES,SPECS}
-
-rpms rpm: rpm_prep rtevalrpm loadrpm
-
-
 help:
 	@echo ""
 	@echo "rteval Makefile targets:"
@@ -88,6 +82,7 @@ help:
 	@echo "        tarfile:   create the source tarball"
 	@echo "        install:   install rteval locally"
 	@echo "        clean:     cleanup generated files"
+	@echo "        realclean: Same as clean plus directory run"
 	@echo "        sysreport: do a short testrun and generate sysreport data"
 	@echo "        tags:      generate a ctags file"
 	@echo "        cleantags: remove the ctags file"
-- 
2.42.0

