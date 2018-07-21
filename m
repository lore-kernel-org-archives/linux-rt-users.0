From: Gene Heskett <gheskett@shentel.net>
Subject: Re: Cautionary tale: how to kill an SDCard with one simple command
Date: Sat, 21 Jul 2018 16:44:43 -0400
Message-ID: <201807211644.43607.gheskett@shentel.net>
References: <piv6eu$pd3$1@pye-srv-01.telemetry.co.uk> <201807211529.20636.gheskett@shentel.net> <CAOh3dDbmzwTVRJrTTYvBJtVkakt1=n2iJUeLVJrKppwi1ZmY3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users" <linux-rt-users@vger.kernel.org>
To: debian-arm@lists.debian.org
Return-path: <bounce-debian-arm=debian-arm=m.gmane.org@lists.debian.org>
In-Reply-To: <CAOh3dDbmzwTVRJrTTYvBJtVkakt1=n2iJUeLVJrKppwi1ZmY3g@mail.gmail.com>
Content-Disposition: inline
Resent-Message-ID: <fIXVmeMmjrD.A.RMD.at5UbB@bendel>
List-URL: <https://lists.debian.org/debian-arm/>
List-Post: <mailto:debian-arm@lists.debian.org>
List-Help: <mailto:debian-arm-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-arm-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-arm-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/201807211644.43607.gheskett@shentel.net
List-Id: linux-rt-users.vger.kernel.org

On Saturday 21 July 2018 15:37:24 Alan Corey wrote:

> Error 2 is file not found, at least in C.  Don't know what it's
> looking for.
>
userspace.api the named string in a previous not show stopper failure, it 
is a directory and contains:
conf.py  index.rst  no_new_privs.rst  seccomp_filter.rst  unshare.rst

Might be a typu in the makefile. Next check at least. But didn't get that 
far, hit conf.py first, & cat conf.py shows---
conf.py:
# -*- coding: utf-8; mode: python -*-

project = "The Linux kernel user-space API guide"

tags.add("subproject")

latex_documents = [
    ('index', 'userspace-api.tex', project,
     'The kernel development community', 'manual'),
]

and userspace-api.tex does not exist.

linux-rt-users list CC'd.
