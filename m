Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E232D9EC7
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541882; cv=none; b=gobp358kTM7hzKKuU5DSVg+cISmVE4BvEQaWHlwtq6GA3iFjJlAkRyOcLJTzD0XM0v/dFG4VHKrahssgX8mPowICbQ0A554KFC8CtjIEYEUfpAFuaDihQ6kYn0ov7xIDw2/2wkKH+tEd/ZZ9a5uoX4wH61mBwqMEivDTnsqPK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541882; c=relaxed/simple;
	bh=17qYfSKV8cPzFzLqy3qOv2EeK/jzm6iiRwTvDssWpFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrsGYphPCWRdm5W93IwMLw43MYGQbiIiDIXFLNuZlpLvSificfXlLRYk1dgexGX++wfSN7xorCAd9srtDo7RDODGBNAoDEa2hQRDvPp4Ihb+t53+RpbjpEg7HAy9NA//wjGTjxwGaedr1YJ4NB7i4MiONRq4CrfOg4MUKV1FkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdHIVdsV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdHIVdsV"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b0f54370ecso115558685a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762541878; x=1763146678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIlbgBj3buoYCtYuwzvecMUnrSA9OgB5X+ZJDujfSQQ=;
        b=WdHIVdsV0webTQDtmBuG4ccRxsFyDmNwu012q+M83UvaCTcEuHTpNgzAzKD6zVL4FD
         a8Y5AAZy3PSLIH/LQGumKJr9Ij6WEznKyS2+z/1jyL7gj44hyvD/zwqPQFl6YSvV5m+l
         S05BmaraQ2OUloO+C0I47qY/cVgTQwssul2gYDVxp2w5v+mbsXcdQCybec9Fw5a6ZsYp
         6sul1ugfTxYqkZM4Bj2uTLEtyDQAwrgQ7Ga1P28Aj88HJnxpNpXkUJ8Pv4Of/B3YrDHh
         mzMJQObRvQmdy2n8KrvgofYsnlWXq7GLf1/EbeiTrbIWgd2L8mxM+5rGg+ZpXtwUOYh9
         wRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762541878; x=1763146678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIlbgBj3buoYCtYuwzvecMUnrSA9OgB5X+ZJDujfSQQ=;
        b=eccCuuah6Uh2r0z26qE6O3L1R8YjzcyRaLLpAG2nFx6mMR1TLUdC8hAWkRpTiGdrla
         BUzVChH6h0FGVa+LiJN76ZPuF9Xl8O+FaHCdp45OWOS2kTKpzaRftW/W95Ggr+EKhKQQ
         XZA0v7u9FLCZqBU+BYFz3oO1cjjHxnr7Fver3z56Zeh1oJgyPYXRIvxywOmddliMOv9z
         iWeglJicKBdGdix9BvSJ8vIzIM3EQsdV6MmKwGq0hYZxGIcMDnJaA+H+jZ330HZkJVcJ
         hLxWGg73jh/UtUPOApb61fGRcckQnBnsFTI62/6In5rnNPoiHXi3aBEV5o/wd3ckfi1s
         8ioA==
X-Gm-Message-State: AOJu0YwmvV/iuFvhv5LmwjkTX9ah3oA8iU3Axmh4ZpGQgPu+eiAMegNs
	XRdBAi5KlFF7fpm0aPfrJW4F2lChy0Kc97Z72Q1kdyByiceX5vowtUbjtxQDX4wk
X-Gm-Gg: ASbGnctJasazgabc6W51xeAAWkle6BcudDNd+m8eMHGmSwcb0FC87EP2rIWXp6lff+d
	iq2VBE/dsmpqDXp1QFaGxnh2QK2RXB1NTSsKhlxqYCeOnjVKwYiitU/odL3k3auXqhtod//yC0x
	sXLzyI0M5E1BPXSq3C7IoUR4ri2FL+Ehf0StznKoROlxe4AUvKpMZeDWYxGrFgI1sH7Z/PwmERZ
	twTwNmARv7CFzfcXbK/fYArRnNEE1TZZ75D0DaEvf9KZKbH+O0mAIecUrrXfJk4BUi0mwIJ1zgj
	15SOHBJKShMKt52W5jFLtkv6Pv2Ulk2jUcdYkA4kVkp6+7mjQPT841rmbrfJzsqv0QId1BEy3Up
	8vj+f/8VJz2X4LnTLsyqnfV79sY65WgjurIFieog0u4N1iTubXNtIrf/LosVFxRMArl409YwEow
	==
X-Google-Smtp-Source: AGHT+IHW/uXQFKW6PeiMABXK4DCKrYQeiyJnDeMewEYOuudCRjgsNmCCORMF3uY1X6+vbgdnBTZalQ==
X-Received: by 2002:a05:620a:6914:b0:8b2:1f64:7bc5 with SMTP id af79cd13be357-8b257f69f9emr42821785a.86.1762541878315;
        Fri, 07 Nov 2025 10:57:58 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm458103785a.53.2025.11.07.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:57:57 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 01/23] Add SPDX license identifiers
Date: Fri,  7 Nov 2025 13:57:10 -0500
Message-ID: <20251107185732.23992-2-jkacur@redhat.com>
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

From: Clark Williams <clrkwllms@kernel.org>

use SPDX license identifiers to clarify the licences under which
tuna is released.

Signed-off-by: Clark Williams <williams@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                |  3 +++
 org.tuna.policy         |  1 +
 oscilloscope-cmd.py     | 15 +--------------
 setup.py                |  1 +
 testuna                 | 10 +++++-----
 tuna-cmd.py             |  9 +--------
 tuna.desktop            |  1 +
 tuna/__init__.py        |  2 +-
 tuna/config.py          |  2 ++
 tuna/gui/__init__.py    |  2 ++
 tuna/gui/commonview.py  |  2 ++
 tuna/gui/cpuview.py     |  1 +
 tuna/gui/irqview.py     |  1 +
 tuna/gui/procview.py    |  1 +
 tuna/gui/profileview.py |  1 +
 tuna/gui/util.py        |  1 +
 tuna/new_eth.py         |  1 +
 tuna/oscilloscope.py    | 15 +--------------
 tuna/sysfs.py           |  2 ++
 tuna/tuna.py            |  7 ++++---
 tuna/tuna_gui.py        |  1 +
 tuna/tuna_sched.py      |  1 +
 22 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/Makefile b/Makefile
index 50ded3985743..a3d71d2de896 100644
--- a/Makefile
+++ b/Makefile
@@ -1,3 +1,6 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
 PACKAGE := tuna
 VERSION := $(shell rpm -q --qf '%{VERSION} ' --specfile rpm/SPECS/$(PACKAGE).spec | cut -d' ' -f1)
 
diff --git a/org.tuna.policy b/org.tuna.policy
index 4f71d4ad65f4..b3b3900a4d76 100644
--- a/org.tuna.policy
+++ b/org.tuna.policy
@@ -1,4 +1,5 @@
 <?xml version="1.0" encoding="UTF-8"?>
+<!-- SPDX-License-Identifier: GPL-2.0-only -->
 <!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD polkit Policy Configuration 1.0//EN"
 "http://www.freedesktop.org/software/polkit/policyconfig-1.dtd">
 <policyconfig>
diff --git a/oscilloscope-cmd.py b/oscilloscope-cmd.py
index 2ca87e9edc62..a65117637160 100755
--- a/oscilloscope-cmd.py
+++ b/oscilloscope-cmd.py
@@ -5,20 +5,7 @@
 # http://git.kernel.org/?p=linux/kernel/git/acme/tuna.git;a=tree
 # For newer versions and to see it integrated with tuna
 #
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation;
-# version 2.1 of the License.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
-# USA
+# SPDX-License-Identifier: LGPL-2.1-only
 
 import getopt
 import sys
diff --git a/setup.py b/setup.py
index db0f00735524..f119e75abdeb 100755
--- a/setup.py
+++ b/setup.py
@@ -1,4 +1,5 @@
 #!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0-only
 import os
 import sysconfig
 from os.path import isfile, relpath
diff --git a/testuna b/testuna
index 4bf91ebdb76f..cb98640c0167 100755
--- a/testuna
+++ b/testuna
@@ -2,7 +2,7 @@
 # Regression tests for tuna
 # (c) 2008 Red Hat Inc.
 # Arnaldo Carvalho de Melo <acme@redhat.com>
-# Released under the GPLv2
+# SPDX-License-Identifier: GPL-2.0-only
 
 dprint() {
 	[ -n "$VERBOSE" ] && echo $1
@@ -111,21 +111,21 @@ PID=$(ktpidof "watchdog")
 RTPRIO=$(get_rtprio $PID)
 POLICY=$(get_policy $PID)
 POLICY=$(echo ${POLICY:6:1} | tr 'A-Z' 'a-z')
-chrt -$POLICY -p $((RTPRIO - 1)) $PID 
+chrt -$POLICY -p $((RTPRIO - 1)) $PID
 
 die_if_not_saved 1 'Saving changes to a kernel thread priority'
 
-chrt -$POLICY -p $RTPRIO $PID 
+chrt -$POLICY -p $RTPRIO $PID
 
 die_if_conf_changed 'Restoring kernel thread priority'
 
 new_policy=$(echo $POLICY | tr fr rf)
 
-chrt -$new_policy -p $RTPRIO $PID 
+chrt -$new_policy -p $RTPRIO $PID
 
 die_if_not_saved 1 'Changing kernel thread sched policy'
 
-chrt -$POLICY -p $RTPRIO $PID 
+chrt -$POLICY -p $RTPRIO $PID
 
 die_if_conf_changed 'Restoring kernel thread sched policy'
 
diff --git a/tuna-cmd.py b/tuna-cmd.py
index 6a980598526f..e953869c4f48 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -5,14 +5,7 @@
 #   Copyright (C) 2008, 2009, 2010, 2011 Red Hat Inc.
 #   Arnaldo Carvalho de Melo <acme@redhat.com>
 #
-#   This application is free software; you can redistribute it and/or
-#   modify it under the terms of the GNU General Public License
-#   as published by the Free Software Foundation; version 2.
-#
-#   This application is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-#   General Public License for more details.
+# SPDX-License-Identifier: GPL-2.0-only
 
 """ tuna - Application Tuning Program"""
 
diff --git a/tuna.desktop b/tuna.desktop
index 603011f79467..87ca3a35ce63 100644
--- a/tuna.desktop
+++ b/tuna.desktop
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 [Desktop Entry]
 Name=tuna
 GenericName=Application Tuner
diff --git a/tuna/__init__.py b/tuna/__init__.py
index 30924a00cf96..614e3e4c7ed8 100755
--- a/tuna/__init__.py
+++ b/tuna/__init__.py
@@ -4,4 +4,4 @@ Copyright (c) 2008, 2009 Red Hat Inc.
 Application Tuning GUI
 """
 __author__ = "Arnaldo Carvalho de Melo <acme@redhat.com>"
-__license__ = "GPLv2 License"
+__license__ = "SPDX-License-Identifier: GPL-2.0-only"
diff --git a/tuna/config.py b/tuna/config.py
index 09d26dd87029..63c9f23bb09b 100644
--- a/tuna/config.py
+++ b/tuna/config.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
 import io
 import os
 import re
diff --git a/tuna/gui/__init__.py b/tuna/gui/__init__.py
index ad1191c13d8d..a40f86292e6f 100755
--- a/tuna/gui/__init__.py
+++ b/tuna/gui/__init__.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
 """
 Copyright (c) 2009  Red Hat Inc.
 
diff --git a/tuna/gui/commonview.py b/tuna/gui/commonview.py
index cc8f913819a2..8089ed154dae 100644
--- a/tuna/gui/commonview.py
+++ b/tuna/gui/commonview.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
 from gi.repository import Gtk
 from tuna import tuna
 
diff --git a/tuna/gui/cpuview.py b/tuna/gui/cpuview.py
index cc3f0f905ae7..844705a4bb21 100755
--- a/tuna/gui/cpuview.py
+++ b/tuna/gui/cpuview.py
@@ -1,5 +1,6 @@
 # -*- python -*-
 # -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
 
 from functools import reduce
 
diff --git a/tuna/gui/irqview.py b/tuna/gui/irqview.py
index 5143d6dc0df5..e89fb70197fc 100755
--- a/tuna/gui/irqview.py
+++ b/tuna/gui/irqview.py
@@ -1,5 +1,6 @@
 # -*- python -*-
 # -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
 from tuna import tuna, gui
 import procfs
 from gi.repository import Gdk
diff --git a/tuna/gui/procview.py b/tuna/gui/procview.py
index 440a289a1b29..78d5f573dd49 100755
--- a/tuna/gui/procview.py
+++ b/tuna/gui/procview.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 import re
 import os
 import tuna.tuna_sched as tuna_sched
diff --git a/tuna/gui/profileview.py b/tuna/gui/profileview.py
index 26f58cbc8f4f..7570bc0e57ce 100644
--- a/tuna/gui/profileview.py
+++ b/tuna/gui/profileview.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 import os
 import shutil
 import gi
diff --git a/tuna/gui/util.py b/tuna/gui/util.py
index ec368ae4b2c9..92bd368179cc 100644
--- a/tuna/gui/util.py
+++ b/tuna/gui/util.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
 import errno
 import os
 import gi
diff --git a/tuna/new_eth.py b/tuna/new_eth.py
index 98f9179d5695..e2888d4cef36 100755
--- a/tuna/new_eth.py
+++ b/tuna/new_eth.py
@@ -1,4 +1,5 @@
 # Copyright (C) 2022 John Kacur
+# SPDX-License-Identifier: GPL-2.0-only
 """ A few functions similar to ethtool """
 import os
 import socket
diff --git a/tuna/oscilloscope.py b/tuna/oscilloscope.py
index 317fe4554c60..a44ace53ec27 100755
--- a/tuna/oscilloscope.py
+++ b/tuna/oscilloscope.py
@@ -8,20 +8,7 @@
 # http://git.kernel.org/?p=linux/kernel/git/acme/tuna.git;a=tree
 # For newer versions and to see it integrated with tuna
 #
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation;
-# version 2.1 of the License.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
-# USA
+# SPDX-License-Identifier: LGPL-2.1-only
 
 import os
 import sys
diff --git a/tuna/sysfs.py b/tuna/sysfs.py
index 1c903e106a44..cd2377a8df26 100755
--- a/tuna/sysfs.py
+++ b/tuna/sysfs.py
@@ -1,5 +1,7 @@
 # -*- python -*-
 # -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
+
 """
 classes for /sys/devices/system/cpu/
 so we can get topology information and do CPU hotplug operations
diff --git a/tuna/tuna.py b/tuna/tuna.py
index e527facb151c..bd678e2dc7ae 100755
--- a/tuna/tuna.py
+++ b/tuna/tuna.py
@@ -1,5 +1,6 @@
 # -*- python -*-
 # -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
 
 import copy
 import errno
@@ -647,12 +648,12 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
     f.write('''# Generated by tuna
 #
 # Use it with rtctl:
-# 
+#
 # rtctl --file %s reset
 #
 # Please use 'man rtctl' for more operations
 #
-# Associate processes into named groups with default priority and 
+# Associate processes into named groups with default priority and
 # scheduling policy.
 #
 # Format is: <groupname>:<sched>:<prio>:<regex>
@@ -661,7 +662,7 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
 # sched must be one of: 'f' (fifo)
 #                       'b' (batch)
 #                       'r' (round-robin)
-#                       'o' (other) 
+#                       'o' (other)
 #                       '*' (leave alone)
 # regex is an awk regex
 #
diff --git a/tuna/tuna_gui.py b/tuna/tuna_gui.py
index 459f90303ed5..cefee4a57697 100755
--- a/tuna/tuna_gui.py
+++ b/tuna/tuna_gui.py
@@ -1,5 +1,6 @@
 # -*- python -*-
 # -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-only
 
 import sys
 import os
diff --git a/tuna/tuna_sched.py b/tuna/tuna_sched.py
index de9846bb5fae..1051983e53f9 100644
--- a/tuna/tuna_sched.py
+++ b/tuna/tuna_sched.py
@@ -1,5 +1,6 @@
 #!/usr/bin/python3
 #   Copyright (C) 2022 John Kacur
+# SPDX-License-Identifier: GPL-2.0-only
 """
 Functions to translate a scheduling policy into either a string name or an
 equivalent integer
-- 
2.51.1

