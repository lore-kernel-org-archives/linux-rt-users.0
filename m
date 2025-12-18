Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14431232395
	for <linux-rt-users@vger.kernel.org>; Thu, 18 Dec 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766025918; cv=none; b=rDpqa3cj5+SvSVa4SL6Clufnr4gTFujDwgFnvQsdg2fhWgiEcRkiYIociyTq3W6t6QeFbctmVx7f2FMJ0MYSiDJPVA5Ye/y6gEEoTKVVZOZ3cadKo4Nfr8glevxUtiHP4lUzx8Kycvuq57GczVH9a1CwmO9dCi42ap2IHFM3Sqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766025918; c=relaxed/simple;
	bh=BkvuruiWNZyEaOoAcAJAB4uIhK5ph1LtL1o25UPnK24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oj2r9qfvJtARYO5TaYTENnZcwPw8AkbxURTAblzGk6rvWO3kf6WQFhwvcx1RMwiz+VCMG+kjg2ywC6KO7i0YYGpm3BAc4JoRdUGbFPv2q+letdoESXS22NuLydJE/Qq8pq/J2RFVYVyUgkWkfOyMAA67pbb/5psj1Uu3IfOCL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZtBfjNrQ; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZtBfjNrQ"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93f5761e09aso122725241.1
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Dec 2025 18:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1766025914; x=1766630714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgiZBeX1dPkU0ieHh/xD02Dhrx9rrUaNhY85jIApCVs=;
        b=ZtBfjNrQ8nEF/dcisyVgZPu74ywrGgL+6LxFgO/3y7uaVd8DetmMoaqs2kSG3EY9a8
         RIseGv2m09TLy2rBootSLPwGwVqgHf6pZ6aGHS8HEFe+ho+x9c+7lf5Y9eWgpJsACx+f
         kIdhCN5YkTEv4tNnsAdVICky4jjj0gB/vQVWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766025914; x=1766630714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VgiZBeX1dPkU0ieHh/xD02Dhrx9rrUaNhY85jIApCVs=;
        b=nJTc55FC2fglAlW3eKwzpMGfnc+jrQWXAdaS6Mratt9hrD68bxB5AMKijpIGlAw/78
         8015MyXyKIAf7WcxwSpWa0Xe/ZuT/YZu6046F7Bohuyk4wcxOhe+Ew6SUoPsTyk7372O
         b/UmGFrHtCEu7Q25sxEAgBydTWt13YpUQu96nFw9u4eUM4zfsAhi9/Z1uOZu4NweK9u8
         oCwyO8/6HzzKltkHrsSatbzScgzAsYadWfZ6aHuGD2uk1NTn7LmBgwUkF3p7pCzIQawJ
         qR69M5P6jABEQwi+2Dsm8HSb/7DGvevj0Uaxy6l5vuKdmKyjrnTCGyP620PbPh1rmdCh
         OSlA==
X-Gm-Message-State: AOJu0Yzxg8xz8gmAqWy6fGim+RF+eht87xVKYzln1a5L45lTa0Vwghc8
	3OIkZ/hCpwYbaUFn8mpkWTfB3f1MWGxd3pl+ko0VwWluePuu+uJBowZrErIbZUZIzOWxPmWpgz7
	jB2CxD+TuAwbl+0Af6XxGQFQzszKbc8KUPaUTSqPbbQ==
X-Gm-Gg: AY/fxX6nW/qIn9pC3arWHuSEnfj4iPCPHqeYwyVQ8iRVdWHQRweaqZucHsjRH5TF2I8
	XpDJzV+O8JViP9CDQHDi05ZUhCkrvaLGpdJhpixcmYBVos6SZ/vwM4UQuwtkyDTwwZBSRr1loGD
	uuP7QtWe8WUQAcvNYVXfQjusKF/HmqopZCaoxL2aeKYc30E4B5DmWpAJ1uiRkAdrB9/Ynjodm5V
	kLh81pb6MVI0i9BKmaP9JZ+mMAzLmO+LTu7/C8PFiZ9aA8aJiftwFxVA1qi6egmxv9JX63gU8Ot
	wjB0bwr/5uqDk4xi5aRjinZygA==
X-Google-Smtp-Source: AGHT+IGHhccKNAmE/0sF2jQnsWrWGWzk6cK8+JFenz7zlUCGiEOoABTPS8MedzG24pNmUCRaBKGrL4dnJ8WH2iK2i6E=
X-Received: by 2002:a05:6102:5e87:b0:5db:e373:f0af with SMTP id
 ada2fe7eead31-5e8277e7a95mr6826030137.31.1766025913777; Wed, 17 Dec 2025
 18:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107185732.23992-1-jkacur@redhat.com> <20251107185732.23992-2-jkacur@redhat.com>
In-Reply-To: <20251107185732.23992-2-jkacur@redhat.com>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Wed, 17 Dec 2025 20:45:02 -0600
X-Gm-Features: AQt7F2peBPMzyK4gs6EDgnDMf4_pMOLWfcrUTrtTyYarYpv0_n8F6OF9yNiRQJI
Message-ID: <CAG_66ZRxvig6TZz0Vx6y7gt=F8PrSWx=d3qGr55==1-LHrFyeQ@mail.gmail.com>
Subject: Re: [PATCH 01/23] Add SPDX license identifiers
To: John Kacur <jkacur@redhat.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>, Clark Williams <williams@redhat.com>, 
	Clark Williams <clrkwllms@kernel.org>, linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

adding linux-spdx for review

On Mon, Dec 15, 2025 at 1:52=E2=80=AFPM John Kacur <jkacur@redhat.com> wrot=
e:
>
> From: Clark Williams <clrkwllms@kernel.org>
>
> use SPDX license identifiers to clarify the licences under which
> tuna is released.
>
> Signed-off-by: Clark Williams <williams@redhat.com>
> Signed-off-by: John Kacur <jkacur@redhat.com>
Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>


> ---
>  Makefile                |  3 +++
>  org.tuna.policy         |  1 +
>  oscilloscope-cmd.py     | 15 +--------------
>  setup.py                |  1 +
>  testuna                 | 10 +++++-----
>  tuna-cmd.py             |  9 +--------
>  tuna.desktop            |  1 +
>  tuna/__init__.py        |  2 +-
>  tuna/config.py          |  2 ++
>  tuna/gui/__init__.py    |  2 ++
>  tuna/gui/commonview.py  |  2 ++
>  tuna/gui/cpuview.py     |  1 +
>  tuna/gui/irqview.py     |  1 +
>  tuna/gui/procview.py    |  1 +
>  tuna/gui/profileview.py |  1 +
>  tuna/gui/util.py        |  1 +
>  tuna/new_eth.py         |  1 +
>  tuna/oscilloscope.py    | 15 +--------------
>  tuna/sysfs.py           |  2 ++
>  tuna/tuna.py            |  7 ++++---
>  tuna/tuna_gui.py        |  1 +
>  tuna/tuna_sched.py      |  1 +
>  22 files changed, 35 insertions(+), 45 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 50ded3985743..a3d71d2de896 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,3 +1,6 @@
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
>  PACKAGE :=3D tuna
>  VERSION :=3D $(shell rpm -q --qf '%{VERSION} ' --specfile rpm/SPECS/$(PA=
CKAGE).spec | cut -d' ' -f1)
>
> diff --git a/org.tuna.policy b/org.tuna.policy
> index 4f71d4ad65f4..b3b3900a4d76 100644
> --- a/org.tuna.policy
> +++ b/org.tuna.policy
> @@ -1,4 +1,5 @@
>  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> +<!-- SPDX-License-Identifier: GPL-2.0-only -->
>  <!DOCTYPE policyconfig PUBLIC "-//freedesktop//DTD polkit Policy Configu=
ration 1.0//EN"
>  "http://www.freedesktop.org/software/polkit/policyconfig-1.dtd">
>  <policyconfig>
> diff --git a/oscilloscope-cmd.py b/oscilloscope-cmd.py
> index 2ca87e9edc62..a65117637160 100755
> --- a/oscilloscope-cmd.py
> +++ b/oscilloscope-cmd.py
> @@ -5,20 +5,7 @@
>  # http://git.kernel.org/?p=3Dlinux/kernel/git/acme/tuna.git;a=3Dtree
>  # For newer versions and to see it integrated with tuna
>  #
> -# This library is free software; you can redistribute it and/or
> -# modify it under the terms of the GNU Lesser General Public
> -# License as published by the Free Software Foundation;
> -# version 2.1 of the License.
> -#
> -# This library is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# Lesser General Public License for more details.
> -#
> -# You should have received a copy of the GNU Lesser General Public
> -# License along with this library; if not, write to the Free Software
> -# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> -# USA
> +# SPDX-License-Identifier: LGPL-2.1-only
>
>  import getopt
>  import sys
> diff --git a/setup.py b/setup.py
> index db0f00735524..f119e75abdeb 100755
> --- a/setup.py
> +++ b/setup.py
> @@ -1,4 +1,5 @@
>  #!/usr/bin/python3
> +# SPDX-License-Identifier: GPL-2.0-only
>  import os
>  import sysconfig
>  from os.path import isfile, relpath
> diff --git a/testuna b/testuna
> index 4bf91ebdb76f..cb98640c0167 100755
> --- a/testuna
> +++ b/testuna
> @@ -2,7 +2,7 @@
>  # Regression tests for tuna
>  # (c) 2008 Red Hat Inc.
>  # Arnaldo Carvalho de Melo <acme@redhat.com>
> -# Released under the GPLv2
> +# SPDX-License-Identifier: GPL-2.0-only
>
>  dprint() {
>         [ -n "$VERBOSE" ] && echo $1
> @@ -111,21 +111,21 @@ PID=3D$(ktpidof "watchdog")
>  RTPRIO=3D$(get_rtprio $PID)
>  POLICY=3D$(get_policy $PID)
>  POLICY=3D$(echo ${POLICY:6:1} | tr 'A-Z' 'a-z')
> -chrt -$POLICY -p $((RTPRIO - 1)) $PID
> +chrt -$POLICY -p $((RTPRIO - 1)) $PID
>
>  die_if_not_saved 1 'Saving changes to a kernel thread priority'
>
> -chrt -$POLICY -p $RTPRIO $PID
> +chrt -$POLICY -p $RTPRIO $PID
>
>  die_if_conf_changed 'Restoring kernel thread priority'
>
>  new_policy=3D$(echo $POLICY | tr fr rf)
>
> -chrt -$new_policy -p $RTPRIO $PID
> +chrt -$new_policy -p $RTPRIO $PID
>
>  die_if_not_saved 1 'Changing kernel thread sched policy'
>
> -chrt -$POLICY -p $RTPRIO $PID
> +chrt -$POLICY -p $RTPRIO $PID
>
>  die_if_conf_changed 'Restoring kernel thread sched policy'
>
> diff --git a/tuna-cmd.py b/tuna-cmd.py
> index 6a980598526f..e953869c4f48 100755
> --- a/tuna-cmd.py
> +++ b/tuna-cmd.py
> @@ -5,14 +5,7 @@
>  #   Copyright (C) 2008, 2009, 2010, 2011 Red Hat Inc.
>  #   Arnaldo Carvalho de Melo <acme@redhat.com>
>  #
> -#   This application is free software; you can redistribute it and/or
> -#   modify it under the terms of the GNU General Public License
> -#   as published by the Free Software Foundation; version 2.
> -#
> -#   This application is distributed in the hope that it will be useful,
> -#   but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -#   General Public License for more details.
> +# SPDX-License-Identifier: GPL-2.0-only
>
>  """ tuna - Application Tuning Program"""
>
> diff --git a/tuna.desktop b/tuna.desktop
> index 603011f79467..87ca3a35ce63 100644
> --- a/tuna.desktop
> +++ b/tuna.desktop
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  [Desktop Entry]
>  Name=3Dtuna
>  GenericName=3DApplication Tuner
> diff --git a/tuna/__init__.py b/tuna/__init__.py
> index 30924a00cf96..614e3e4c7ed8 100755
> --- a/tuna/__init__.py
> +++ b/tuna/__init__.py
> @@ -4,4 +4,4 @@ Copyright (c) 2008, 2009 Red Hat Inc.
>  Application Tuning GUI
>  """
>  __author__ =3D "Arnaldo Carvalho de Melo <acme@redhat.com>"
> -__license__ =3D "GPLv2 License"
> +__license__ =3D "SPDX-License-Identifier: GPL-2.0-only"
> diff --git a/tuna/config.py b/tuna/config.py
> index 09d26dd87029..63c9f23bb09b 100644
> --- a/tuna/config.py
> +++ b/tuna/config.py
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
>  import io
>  import os
>  import re
> diff --git a/tuna/gui/__init__.py b/tuna/gui/__init__.py
> index ad1191c13d8d..a40f86292e6f 100755
> --- a/tuna/gui/__init__.py
> +++ b/tuna/gui/__init__.py
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
>  """
>  Copyright (c) 2009  Red Hat Inc.
>
> diff --git a/tuna/gui/commonview.py b/tuna/gui/commonview.py
> index cc8f913819a2..8089ed154dae 100644
> --- a/tuna/gui/commonview.py
> +++ b/tuna/gui/commonview.py
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
>  from gi.repository import Gtk
>  from tuna import tuna
>
> diff --git a/tuna/gui/cpuview.py b/tuna/gui/cpuview.py
> index cc3f0f905ae7..844705a4bb21 100755
> --- a/tuna/gui/cpuview.py
> +++ b/tuna/gui/cpuview.py
> @@ -1,5 +1,6 @@
>  # -*- python -*-
>  # -*- coding: utf-8 -*-
> +# SPDX-License-Identifier: GPL-2.0-only
>
>  from functools import reduce
>
> diff --git a/tuna/gui/irqview.py b/tuna/gui/irqview.py
> index 5143d6dc0df5..e89fb70197fc 100755
> --- a/tuna/gui/irqview.py
> +++ b/tuna/gui/irqview.py
> @@ -1,5 +1,6 @@
>  # -*- python -*-
>  # -*- coding: utf-8 -*-
> +# SPDX-License-Identifier: GPL-2.0-only
>  from tuna import tuna, gui
>  import procfs
>  from gi.repository import Gdk
> diff --git a/tuna/gui/procview.py b/tuna/gui/procview.py
> index 440a289a1b29..78d5f573dd49 100755
> --- a/tuna/gui/procview.py
> +++ b/tuna/gui/procview.py
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  import re
>  import os
>  import tuna.tuna_sched as tuna_sched
> diff --git a/tuna/gui/profileview.py b/tuna/gui/profileview.py
> index 26f58cbc8f4f..7570bc0e57ce 100644
> --- a/tuna/gui/profileview.py
> +++ b/tuna/gui/profileview.py
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  import os
>  import shutil
>  import gi
> diff --git a/tuna/gui/util.py b/tuna/gui/util.py
> index ec368ae4b2c9..92bd368179cc 100644
> --- a/tuna/gui/util.py
> +++ b/tuna/gui/util.py
> @@ -1,3 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
>  import errno
>  import os
>  import gi
> diff --git a/tuna/new_eth.py b/tuna/new_eth.py
> index 98f9179d5695..e2888d4cef36 100755
> --- a/tuna/new_eth.py
> +++ b/tuna/new_eth.py
> @@ -1,4 +1,5 @@
>  # Copyright (C) 2022 John Kacur
> +# SPDX-License-Identifier: GPL-2.0-only
>  """ A few functions similar to ethtool """
>  import os
>  import socket
> diff --git a/tuna/oscilloscope.py b/tuna/oscilloscope.py
> index 317fe4554c60..a44ace53ec27 100755
> --- a/tuna/oscilloscope.py
> +++ b/tuna/oscilloscope.py
> @@ -8,20 +8,7 @@
>  # http://git.kernel.org/?p=3Dlinux/kernel/git/acme/tuna.git;a=3Dtree
>  # For newer versions and to see it integrated with tuna
>  #
> -# This library is free software; you can redistribute it and/or
> -# modify it under the terms of the GNU Lesser General Public
> -# License as published by the Free Software Foundation;
> -# version 2.1 of the License.
> -#
> -# This library is distributed in the hope that it will be useful,
> -# but WITHOUT ANY WARRANTY; without even the implied warranty of
> -# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -# Lesser General Public License for more details.
> -#
> -# You should have received a copy of the GNU Lesser General Public
> -# License along with this library; if not, write to the Free Software
> -# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
> -# USA
> +# SPDX-License-Identifier: LGPL-2.1-only
>
>  import os
>  import sys
> diff --git a/tuna/sysfs.py b/tuna/sysfs.py
> index 1c903e106a44..cd2377a8df26 100755
> --- a/tuna/sysfs.py
> +++ b/tuna/sysfs.py
> @@ -1,5 +1,7 @@
>  # -*- python -*-
>  # -*- coding: utf-8 -*-
> +# SPDX-License-Identifier: GPL-2.0-only
> +
>  """
>  classes for /sys/devices/system/cpu/
>  so we can get topology information and do CPU hotplug operations
> diff --git a/tuna/tuna.py b/tuna/tuna.py
> index e527facb151c..bd678e2dc7ae 100755
> --- a/tuna/tuna.py
> +++ b/tuna/tuna.py
> @@ -1,5 +1,6 @@
>  # -*- python -*-
>  # -*- coding: utf-8 -*-
> +# SPDX-License-Identifier: GPL-2.0-only
>
>  import copy
>  import errno
> @@ -647,12 +648,12 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
>      f.write('''# Generated by tuna
>  #
>  # Use it with rtctl:
> -#
> +#
>  # rtctl --file %s reset
>  #
>  # Please use 'man rtctl' for more operations
>  #
> -# Associate processes into named groups with default priority and
> +# Associate processes into named groups with default priority and
>  # scheduling policy.
>  #
>  # Format is: <groupname>:<sched>:<prio>:<regex>
> @@ -661,7 +662,7 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
>  # sched must be one of: 'f' (fifo)
>  #                       'b' (batch)
>  #                       'r' (round-robin)
> -#                       'o' (other)
> +#                       'o' (other)
>  #                       '*' (leave alone)
>  # regex is an awk regex
>  #
> diff --git a/tuna/tuna_gui.py b/tuna/tuna_gui.py
> index 459f90303ed5..cefee4a57697 100755
> --- a/tuna/tuna_gui.py
> +++ b/tuna/tuna_gui.py
> @@ -1,5 +1,6 @@
>  # -*- python -*-
>  # -*- coding: utf-8 -*-
> +# SPDX-License-Identifier: GPL-2.0-only
>
>  import sys
>  import os
> diff --git a/tuna/tuna_sched.py b/tuna/tuna_sched.py
> index de9846bb5fae..1051983e53f9 100644
> --- a/tuna/tuna_sched.py
> +++ b/tuna/tuna_sched.py
> @@ -1,5 +1,6 @@
>  #!/usr/bin/python3
>  #   Copyright (C) 2022 John Kacur
> +# SPDX-License-Identifier: GPL-2.0-only
>  """
>  Functions to translate a scheduling policy into either a string name or =
an
>  equivalent integer
> --
> 2.51.1
>
>
