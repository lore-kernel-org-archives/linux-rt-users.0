From: John Kacur <jkacur@redhat.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Fri, 17 Sep 2010 09:08:56 +0200
Message-ID: <AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:32971 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab0IQHI5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Sep 2010 03:08:57 -0400
Received: by qyk33 with SMTP id 33so2104337qyk.19
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2010 00:08:56 -0700 (PDT)
In-Reply-To: <AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Sep 17, 2010 at 8:08 AM, jordan <triplesquarednine@gmail.com> w=
rote:
> Hi Gautam,
>
>> The above page provides the instruction in =A0a step by step manner,=
 but I
>> distinctly recall that Ingo Molnar used to have some place a set of
>> instruction that were "yum" based and it seemed like it was just =A0=
a couple
>> of commands to build a new RT kernel. Are these still available anyw=
here?
>
> Correct me if im wrong, but wouldn't you be required to either A: be
> using a repository that has packaged rt-kernels,
> or B: have the RPMs for the rt-kernel locally, on your machine....?
> (to use the yum or rpm methods).
>
>> There is the link below, but it appears to be > 3 years old and itse=
lf
>> points to some broken links.
>>
>> http://wiki.bestpractical.com/view/RPMInstall
>>
>> It would be nice to have something like "yum install rt ..." to get =
the
>> latest version of RT kernel build.
>
> Ubuntu does something like that. But, it wont give you the latest,
> just what is available. IF you want the latest get the sources.....I
> don't use Ubuntu, as i use Fedora. But when i did try ubuntu with a
> "stock" rt-kernel from the repo, it wasn't all that great.
>
> * =A0don't you think it is fairly simple task to just get kernel
> sources, use the corresponding rt-patch for the given kernel, and the=
n
> just compile it? =A0 If you have never done this before, it is actual=
ly
> quite simple once you go through it, once or twice. =A0It also has so=
me
> advantages, i have always had better quality kernels when i tune and
> compile them myself....
>
> Then you could also strip away all of the modules, that your machine
> wont need, that would be built into a more generic kernel, available
> in a repo.
>
> You could also optimize your kernel further, disable features that yo=
u
> dont need. maybe compile the kernel specifically for your cpu...
>
> Patching the kernel is not hard, nor is compiling it, nor optimizing =
it.

You think that optimizing it is easy?

>
> I know for myself, even if i could just install an rt-kernel using
> yum, i probably wouldn't.
> It wouldn't be as good as doing it myself.
>
> just my opinions
>

There is something called Planet CCRMA, which is a set of
repositories for audio packages that run on RedHat, Fedora and CentOS.
They also package the real-time kernel in rpm form. However, it is rath=
er
out of date. If you can compile your own kernel that would be the
preferred option, but if you don't know how and still want to try
out the real-time kernel then you can fetch it from there.

Here is the link
http://ccrma.stanford.edu/planetccrma/software/

Have fun.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
