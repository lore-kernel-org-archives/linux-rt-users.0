From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.9-rt13
Date: Fri, 7 Feb 2014 13:54:07 +0100
Message-ID: <20140207125407.GB2382@linutronix.de>
References: <em0e637974-2d88-4d01-b4ea-9a77d457577a@nb-mak>
 <52F0A503.5050100@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthias Klein <matthias.klein@optimeas.de>,
	RT <linux-rt-users@vger.kernel.org>
To: Pavel Vasilyev <pavel@pavlinux.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45002 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbaBGMyT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Feb 2014 07:54:19 -0500
Content-Disposition: inline
In-Reply-To: <52F0A503.5050100@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Pavel Vasilyev | 2014-02-04 12:29:55 [+0400]:

>04.02.2014 11:26, Matthias Klein =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> what is the reason that the file "patch-3.12.9-rt11-rt12.patch.xz" i=
s missing in
>> https://www.kernel.org/pub/linux/kernel/projects/rt/3.12/incr/ ?

There was v3.12.8-rt11 and 3.12.9-rt12. The difference between those tw=
o
is that I moved from stable .8 to stable .9. I increment in such
releases the -RT version but there are usually no changes to the RT
patch set. Usually means there are changes unless the newer stable vers=
ion
clashes with the -RT patch set. In that case the only change is the
conflict fixup.
Since there are _no_ -RT specific changes, these releaes are not
announced here.

>> Which (incremental) patches are needed to move from 3.12.8-rt11 to 3=
=2E12.9-rt13=20
>> (besides the mainline patch) ?

=46or the incremental update you need the stable diff [0] followed by t=
he
-RT diff [1] and you should get the same tree as if you would download
v3.12.9 and the -RT13 release. Well, after you apply [0] you need to
increment the -RT version from 11 to 12 and then you can apply [1] whic=
h
will increment it from 12 to 13. But this is it.

>And  -rt7 to -rt8, and -rt9 to -rt10,...

and those are also missing for the very same reason. Greg usually does
one release a week and so do I.

[0] https://www.kernel.org/pub/linux/kernel/v3.x/incr/patch-3.12.8-9.xz
[1] https://www.kernel.org/pub/linux/kernel/projects/rt/3.12/incr/patch=
-3.12.9-rt12-rt13.patch.xz

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
