Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from barracuda1.shentel.net ([204.111.1.144]:8565 "EHLO
        barracuda2.shentel.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728221AbeGVCHX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Jul 2018 22:07:23 -0400
Received: from smtp2.edbg.cloud.shentel.net (smtp2.edbg.cloud.shentel.net [204.111.2.25]) by barracuda2.shentel.net with ESMTP id aRAylH1UyLKYHGR3 for <linux-rt-users@vger.kernel.org>; Sat, 21 Jul 2018 21:12:37 -0400 (EDT)
Received: from coyote.coyote.den (unknown [204.111.64.149])
        by smtp2.edbg.cloud.shentel.net (Postfix) with ESMTPSA id C930B20736
        for <linux-rt-users@vger.kernel.org>; Sat, 21 Jul 2018 21:12:37 -0400 (EDT)
From: Gene Heskett <gheskett@shentel.net>
Subject: Re: Cautionary tale: how to kill an SDCard with one simple command
Date: Sat, 21 Jul 2018 21:12:37 -0400
References: <piv6eu$pd3$1@pye-srv-01.telemetry.co.uk> <CAOh3dDbmzwTVRJrTTYvBJtVkakt1=n2iJUeLVJrKppwi1ZmY3g@mail.gmail.com> <201807211644.43607.gheskett@shentel.net>
In-Reply-To: <201807211644.43607.gheskett@shentel.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201807212112.37278.gheskett@shentel.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

On Saturday 21 July 2018 16:44:43 Gene Heskett wrote:

> On Saturday 21 July 2018 15:37:24 Alan Corey wrote:
> > Error 2 is file not found, at least in C.  Don't know what it's
> > looking for.
>
> userspace.api the named string in a previous not show stopper failure,
> it is a directory and contains:
> conf.py  index.rst  no_new_privs.rst  seccomp_filter.rst  unshare.rst
>
> Might be a typu in the makefile. Next check at least. But didn't get
> that far, hit conf.py first, & cat conf.py shows---
> conf.py:
> # -*- coding: utf-8; mode: python -*-
>
> project = "The Linux kernel user-space API guide"
>
> tags.add("subproject")
>
> latex_documents = [
>     ('index', 'userspace-api.tex', project,
>      'The kernel development community', 'manual'),
> ]
>
> and userspace-api.tex does not exist.

Yes it does exist, in the Documentation/output/latex directory, where 
there is a .log file also, which declares that iftex.sty is not found. 
Now, I've had to expand on build-essential by at least 250 more packages 
installed to get this far, so I have to assume I'm still short a tex or 
latex file.

Does any body have a clue what I am missing yet?  I know its a 
bookkeeping headache for you folks working on this to keep track of all 
the build tools, but a list of those tools would be a huge help to 
someone who hasn't built a kernel in several years.  Or does it exist 
and I'm too blind to see it? 

Thanks everybody.

Later, I noticed a *.log file for those that did show the error, and 
sorted most of it with another 300 megs or so worth of packages I had to 
install apt-file to find. Still some errors causing loss of highlighting 
etc though.

But networking.log still says pdftex is not available so it fails.
quote:
)) (/usr/share/texlive/texmf-dist/tex/generic/iftex/iftex.sty
Package: iftex 2013/04/04 v0.2 Provides if(tex) conditional for PDFTeX, 
XeTeX,
and LuaTeX
) (/usr/share/texlive/texmf-dist/tex/latex/cmap/cmap.sty
Package: cmap 2008/03/06 v1.0h CMap support: searchable PDF

Package cmap Warning: pdftex not detected - exiting.

I did install it.  Its found and used elsewhere in the docs build.
this finds it:
$> sudo apt-file find pdftex|grep pdftex|wc -l
262 times, so which is the correct package/version?

So I'm stuck. Faint, rusty with age like me, voice in the wilderness 
yelling help!

-- 
Cheers, Gene Heskett
--
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Genes Web page <http://geneslinuxbox.net:6309/gene>
