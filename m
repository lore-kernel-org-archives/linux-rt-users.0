From: jordan <triplesquarednine@gmail.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Fri, 17 Sep 2010 02:08:42 -0400
Message-ID: <AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Gautam Thaker <gautam.h.thaker@lmco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42603 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab0IQGIn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Sep 2010 02:08:43 -0400
Received: by ewy23 with SMTP id 23so892006ewy.19
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 23:08:42 -0700 (PDT)
In-Reply-To: <4C92A00C.6050401@atl.lmco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Gautam,

> The above page provides the instruction in =A0a step by step manner, =
but I
> distinctly recall that Ingo Molnar used to have some place a set of
> instruction that were "yum" based and it seemed like it was just =A0a=
 couple
> of commands to build a new RT kernel. Are these still available anywh=
ere?

Correct me if im wrong, but wouldn't you be required to either A: be
using a repository that has packaged rt-kernels,
or B: have the RPMs for the rt-kernel locally, on your machine....?
(to use the yum or rpm methods).

> There is the link below, but it appears to be > 3 years old and itsel=
f
> points to some broken links.
>
> http://wiki.bestpractical.com/view/RPMInstall
>
> It would be nice to have something like "yum install rt ..." to get t=
he
> latest version of RT kernel build.

Ubuntu does something like that. But, it wont give you the latest,
just what is available. IF you want the latest get the sources.....I
don't use Ubuntu, as i use Fedora. But when i did try ubuntu with a
"stock" rt-kernel from the repo, it wasn't all that great.

*  don't you think it is fairly simple task to just get kernel
sources, use the corresponding rt-patch for the given kernel, and then
just compile it?   If you have never done this before, it is actually
quite simple once you go through it, once or twice.  It also has some
advantages, i have always had better quality kernels when i tune and
compile them myself....

Then you could also strip away all of the modules, that your machine
wont need, that would be built into a more generic kernel, available
in a repo.

You could also optimize your kernel further, disable features that you
dont need. maybe compile the kernel specifically for your cpu...

Patching the kernel is not hard, nor is compiling it, nor optimizing it=
=2E

I know for myself, even if i could just install an rt-kernel using
yum, i probably wouldn't.
It wouldn't be as good as doing it myself.

just my opinions

cheerz

jordan
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
