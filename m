Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171DC12B94
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541882; cv=none; b=QCvilUh7iatgKLBqBcaxXvjbQl7a8pEuQ83d2sGr8MSJecwoqn6cf7s7/v6mbR3vF/HtEs4rfV3yIw0K0nxuDalZGYM0qI2aAwA/dXNc29FPQqeCSV4JSQYZbwhluAWuKR4JTPJN4Z5prZEGF3/87DYpTH/ZjXr4HAiR0pwms6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541882; c=relaxed/simple;
	bh=l2uJS5CRrSv5g6LkGNBoaLuWpvzgDAEboDA3iZOeuog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5Nv6Ik7HAoz0Vka0gwdGQuev6y89YeAXNUK0yy82mZsdcYk7fm2Bbj5KV9c1AbzBGG0KnzHV7g1WYg7Wm+75bFrFkROBEn+vrLs3eBtNoD8AtpTOQ79FwDPLpTDE6m+OplwoKdDmCDV+3faFTCNtZ+Len+ZKu7R1qsnbHcTd88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeKbJouZ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeKbJouZ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88f2aebce7fso101307685a.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541879; x=1763146679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YNtF56cryuvEV4HttsO9EN2pRbXxUWrlvg/Gnz734g=;
        b=EeKbJouZOTfAPX+AOFVAC7WCHt4Nuprq4nSmceA81/3I76r8o/gHk0nYXh3WWntS8/
         DzQyMNawkde8I+D23qthwymCklqzehU5HeVIMjxIZRYlKN7NwdYtOA8dLuKGmrXZKb4C
         MH7snlX8IXeFy+zGuiws1p+3rMd14krjR7QS/g1WRHCtpBRFeoupcznb4CxdZfObzYkc
         OghBkLxhyAG7kwir6XsfCwQ4ipQ2uiuSOaNajcqA57b3O06QqOpQPiB+9T2LPGUQ13p4
         eq4CvCunVXVf2PQhF9Z9tO6RiogElB+5dvKRBNTJ9lnmCU4UJwGhH6qfzMgC8vlru2oh
         7s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541879; x=1763146679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YNtF56cryuvEV4HttsO9EN2pRbXxUWrlvg/Gnz734g=;
        b=XoyTwgh2F7yrWoIcNhjMyoQtB1WjBgrBlqUKyC86xQ860q9YKgaDdvT7V26/QwLgqV
         AiM68/pvjiRD3olBaO9kZUvPyY/vOL2kgeYkdUOhv+w/ryW3MEgtlj9pazsP1p+oV19E
         +vQ0wP+hkNcB4e/37Iri8SFgVEmP3hq5QANyJmxsfQ+nyWzGsTcX6bQEOmbQ5vPDhixA
         5NbxyDwhWHCCyUqp/Tu8ubGXu2RfnkBBJivl0MErbaM4JNI+CHPD98j2j/oa0EyH5m1r
         OeCix3UO7i0sYfFrtpxuJZUgR1yuWTXVuU0BTYM47gRIkBnECFF3Mb2UjbPHfZgEUuRZ
         130w==
X-Gm-Message-State: AOJu0Yzpxgc/VH21CI/kY8AH1PbohhdD3wEHNniLhdIcvPehPiL4lwrG
	+Yvvw9q+N1TQ1j7Wjc5UuYM08tJ35qrDQvQeJPJTZEh9w8doH9rwy/CahqHwsRQf
X-Gm-Gg: ASbGnctTy7JeWofSz8hLrtn0vhXG/CRrTTF+p1JLdnZTVGWVmMaaeEzEYPVlVDzGb8J
	+bSP1QaSFDwlYEpMOO6p3QS7CvSe+WvIOLX1+Pzxxoa4REGxp8IoLHAQmftzzna/VrlZOpHeGgJ
	DB5nYPk4KQ6t0wbhj8KwzgQaYXK9AHbphoJdrFTTIrIvJKQhUQcat8w5jZiFB05HSxjyi4EcG1B
	hnshqww8eJSS3icmMTx4QJKwuggWFTifxHyoge+QBdjaY1zTCHFIyj1ClEp+Cn7EzJYD8bvBNA3
	EVq6WimsJDhwIFQSjOXVxuEMWZVj6ewRZ8N1RKD5ScxWT0FMl0pGE1voK1Jrcdi5fYXtcmDFKnF
	wOpO4rI6W3d65uCbNKxlFGWILd+uUHLAQA8W4BkqOUG5o0RFVsA1aFbMRdmZ2el6MFomxeQyPVQ
	==
X-Google-Smtp-Source: AGHT+IEqCZEnewXtOWRKgAUdwEhGfkwwhYSrZvth98Wrg8IJDLW3C/3eiDoj32/olL/7aP2fD5Fodg==
X-Received: by 2002:a05:620a:d88:b0:8b2:4a1b:b80a with SMTP id af79cd13be357-8b257f0aaf5mr44306285a.25.1762541879534;
        Fri, 07 Nov 2025 10:57:59 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:57:58 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 02/23] tuna: Remove spec file from git
Date: Fri,  7 Nov 2025 13:57:11 -0500
Message-ID: <20251107185732.23992-3-jkacur@redhat.com>
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

The specfile should be maintained in the distribution and not upstream
The specfile that is upstream is largely unmaintained anyway.
This change also guts the Makefile which uses the specfile.
Most of the functionality in the Makefile is available through tools
such as rpmbuild anyway. Leaving the Makefile in place for a few
minor things like makeing tagfiles

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile            |  39 +------------
 rpm/SPECS/tuna.spec | 137 --------------------------------------------
 2 files changed, 3 insertions(+), 173 deletions(-)
 delete mode 100644 rpm/SPECS/tuna.spec

diff --git a/Makefile b/Makefile
index a3d71d2de896..a55821a8f908 100644
--- a/Makefile
+++ b/Makefile
@@ -1,42 +1,8 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-PACKAGE := tuna
-VERSION := $(shell rpm -q --qf '%{VERSION} ' --specfile rpm/SPECS/$(PACKAGE).spec | cut -d' ' -f1)
-
-rpmdirs:
-	@[ -d rpm/BUILD ]   || mkdir rpm/BUILD
-	@[ -d rpm/RPMS ]    || mkdir rpm/RPMS
-	@[ -d rpm/SRPMS ]   || mkdir rpm/SRPMS
-	@[ -d rpm/SOURCES ] || mkdir rpm/SOURCES
-
-bz2: rpmdirs
-	git archive --format=tar --prefix=$(PACKAGE)-$(VERSION)/ HEAD | \
-	bzip2 -9 > rpm/SOURCES/$(PACKAGE)-$(VERSION).tar.bz2
-
-rpm: bz2 rpmdirs
-	rpmbuild -ba --define "_topdir $(PWD)/rpm" rpm/SPECS/$(PACKAGE).spec
-
-bz2dev: rpmdirs
-	@mkdir -p /tmp/$(PACKAGE)-$(VERSION)
-	@tar cf - `cat MANIFEST` | (cd /tmp/$(PACKAGE)-$(VERSION) ; tar xf -)
-	@(cd /tmp; tar cf - $(PACKAGE)-$(VERSION)) | bzip2 -9 > rpm/SOURCES/$(PACKAGE)-$(VERSION).tar.bz2
-
-rpmdev: bz2dev rpmdirs
-	rpmbuild -ba --define "_topdir $(PWD)/rpm" rpm/SPECS/$(PACKAGE).spec
-
-po/$(PACKAGE).pot:
-	xgettext -k_ -kN_ -f po/POTFILES.in -o $@
-
-po/%.po: po/$(PACKAGE).pot
-	msgmerge --suffix=.old -U $@ $< && rm -f $@.old
-
-rpmclean:
-	@rm -f rpm/RPMS/*/$(PACKAGE)-$(VERSION)-*.rpm
-	@rm -f rpm/SRPMS/$(PACKAGE)-$(VERSION)-*.src.rpm
-	@rm -f rpm/SOURCES/$(PACKAGE)-$(VERSION).tar.bz2
-	@rm -rf rpm/BUILD/$(PACKAGE)-$(VERSION)*
 
+.PHONY: pyclean
 pyclean:
 	@find . -type f \( -name \*~ -o -name \*.pyc \) -delete
 
@@ -52,4 +18,5 @@ cleantags:
 cleanlogs:
 	rm -rf tuna-20*
 
-clean: pyclean rpmclean
+.PHONY: clean
+clean: pyclean
diff --git a/rpm/SPECS/tuna.spec b/rpm/SPECS/tuna.spec
deleted file mode 100644
index eca96c833265..000000000000
--- a/rpm/SPECS/tuna.spec
+++ /dev/null
@@ -1,137 +0,0 @@
-Name: tuna
-Version: 0.15
-Release: 1%{?dist}
-License: GPLv2
-Summary: Application tuning GUI & command line utility
-Group: Applications/System
-Source: http://userweb.kernel.org/~acme/tuna/%{name}-%{version}.tar.bz2
-URL: http://userweb.kernel.org/~acme/tuna/
-BuildArch: noarch
-BuildRequires: python-devel, gettext, desktop-file-utils
-Requires: python-ethtool
-Requires: python-linux-procfs >= 0.6
-# This really should be a Suggests...
-# Requires: python-inet_diag
-BuildRoot: %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)
-
-%description
-Provides interface for changing scheduler and IRQ tunables, at whole CPU and at
-per thread/IRQ level. Allows isolating CPUs for use by a specific application
-and moving threads and interrupts to a CPU by just dragging and dropping them.
-Operations can be done on CPU sockets, understanding CPU topology.
-
-Can be used as a command line utility without requiring the GUI libraries to be
-installed.
-
-%package -n oscilloscope
-Summary: Generic graphical signal plotting tool
-Group: Applications/System
-Requires: python-matplotlib
-Requires: numpy
-Requires: pygtk2
-Requires: tuna = %{version}-%{release}
-
-%description -n oscilloscope
-Plots stream of values read from standard input on the screen together with
-statistics and a histogram.
-
-Allows to instantly see how a signal generator, such as cyclictest, signaltest
-or even ping, reacts when, for instance, its scheduling policy or real time
-priority is changed, be it using tuna or plain chrt & taskset.
-
-%prep
-%setup -q
-
-%build
-%{python3} setup.py build
-
-%install
-rm -rf %{buildroot}
-%{python3} setup.py install --skip-build --root %{buildroot}
-mkdir -p %{buildroot}/%{_sysconfdir}/tuna/
-mkdir -p %{buildroot}/{%{_bindir},%{_datadir}/tuna/help/kthreads,%{_mandir}/man8}
-mkdir -p %{buildroot}/%{_datadir}/polkit-1/actions/
-install -p -m644 tuna/tuna_gui.glade %{buildroot}/%{_datadir}/tuna/
-install -p -m755 tuna-cmd.py %{buildroot}/%{_bindir}/tuna
-install -p -m755 oscilloscope-cmd.py %{buildroot}/%{_bindir}/oscilloscope
-install -p -m644 help/kthreads/* %{buildroot}/%{_datadir}/tuna/help/kthreads/
-install -p -m644 docs/tuna.8 %{buildroot}/%{_mandir}/man8/
-install -p -m644 etc/tuna/example.conf %{buildroot}/%{_sysconfdir}/tuna/
-install -p -m644 etc/tuna.conf %{buildroot}/%{_sysconfdir}/
-install -p -m644 org.tuna.policy %{buildroot}/%{_datadir}/polkit-1/actions/
-desktop-file-install --dir=%{buildroot}/%{_datadir}/applications tuna.desktop
-
-# l10n-ed message catalogues
-for lng in `cat po/LINGUAS`; do
-        po=po/"$lng.po"
-        mkdir -p %{buildroot}/%{_datadir}/locale/${lng}/LC_MESSAGES
-        msgfmt $po -o %{buildroot}/%{_datadir}/locale/${lng}/LC_MESSAGES/%{name}.mo
-done
-
-%find_lang %name
-
-%clean
-rm -rf %{buildroot}
-
-%files -f %{name}.lang
-%defattr(-,root,root,-)
-%doc ChangeLog
-%if "%{python_ver}" >= "2.5"
-%{python2_sitelib}/*.egg-info
-%endif
-%{_bindir}/tuna
-%{_datadir}/tuna/
-%{python3_sitelib}/tuna/
-%{_mandir}/man8/tuna.8*
-%{_sysconfdir}/tuna.conf
-%{_sysconfdir}/tuna/*
-%{_datadir}/polkit-1/actions/org.tuna.policy
-%{_datadir}/applications/tuna.desktop
-
-%files -n oscilloscope
-%defattr(-,root,root,-)
-%{_bindir}/oscilloscope
-%doc docs/oscilloscope+tuna.html
-%doc docs/oscilloscope+tuna.pdf
-
-%changelog
-* Fri Feb  1 2013 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10.4-1
-- New upstream release
-
-* Fri Aug 24 2012 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10.3-1
-- New upstream release
-
-* Thu Jul 28 2011 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10.2-1
-- New upstream release
-
-* Wed Feb 23 2011 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10.1-1
-- New upstream release
-
-* Wed Feb 23 2011 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.10-1
-- New upstream release
-
-* Mon May 17 2010 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.9.3-1
-- New upstream release
-- Fixes the folowing bugzilla.redhat.com tickets:
-- 563355 error in tuna --help output
-- 574950 cannot use cpu ranges in the tuna GUI
-- 559770 tuna backtrace when moving threads
-- 563352 tuna backtrace when no thread list is given for --priority
-- 563350 tuna backtrace when scheduler is mis-typed.
-
-* Thu Nov 12 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.9.2-1
-- New upstream release
-
-* Thu Sep 03 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.9.1-1
-- New upstream release
-
-* Wed Aug 26 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.9-3
-- Rewrite the oscilloscope package summary
-- Remove the shebang in tuna/oscilloscope.py
-
-* Mon Aug 17 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.9-2
-- Use install -p
-- Add BuildRequires for gettext
-
-* Fri Jul 10 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 0.9-1
-- Fedora package reviewing changes: introduce ChangeLog file
-- 
2.51.1

