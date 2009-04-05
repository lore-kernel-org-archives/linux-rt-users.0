From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [Announce] 2.6.29.1-rt4
Date: Sun, 5 Apr 2009 12:28:42 +0900
Message-ID: <49b7c2350904042028q8865f80tcf56500e8a009c0d@mail.gmail.com>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>
	 <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903200014320.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903231723090.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903252154040.3397@localhost.localdomain>
	 <alpine.LFD.2.00.0904020155320.12916@localhost.localdomain>
	 <alpine.LFD.2.00.0904031918090.12916@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
	Will Schmidt <will_schmidt@vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:47646 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbZDED2p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Apr 2009 23:28:45 -0400
In-Reply-To: <alpine.LFD.2.00.0904031918090.12916@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Thomas,
>
>The broken out patches are also available at the same download
>locations.
>
>Enjoy !

Thank you for new release announce.
I am using new version ( linux-2.6.29.1-rt4 ) now .
config file is http://leemgs1.googlecode.com/files/i386.2.6.29.1-rt4.ft=
race.config.20090404

I have one question. What is "broken-out" 's meaning  for rt patch file=
?

When I opened  realtime patch  files for vanilla kernel,
I always checked 2 files like belows.
http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29.1-rt4-b=
roken-out.tar.bz2
<-- collection of seperate files for each patch.
http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29.1-rt4.b=
z2
<-- only one patch file.

What is difference  meaning of file-name format
between "patch-2.6.29.1-rt4-broken-out.tar.bz2" and "patch-2.6.29.1-rt4=
=2Ebz2" ?=09
I have always wondered that.
I am sorry for sending this stupid and easy question.

Thanks,
GeunSik Lim,

2009/4/4 Thomas Gleixner <tglx@linutronix.de>:
> We are pleased to announce the next update to our new preempt-rt
> series.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- rebased to 2.6.29.1
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- powerpc64 tlb rework fix by Peter
>
> Download locations:
>
> =C2=A0 =C2=A0 http://rt.et.redhat.com/download/
> =C2=A0 =C2=A0 http://www.kernel.org/pub/linux/kernel/projects/rt/
>
> Information on the RT patch can be found at:
>
> =C2=A0 =C2=A0 http://rt.wiki.kernel.org/index.php/Main_Page
>
> to build the 2.6.29.1-rt4 tree, the following patches should be
> applied:
>
> =C2=A0 =C2=A0 http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.2=
9.1.tar.bz2
> =C2=A0 =C2=A0 http://www.kernel.org/pub/linux/kernel/projects/rt/patc=
h-2.6.29.1-rt4.bz2
>
> The broken out patches are also available at the same download
> locations.
>
> Enjoy !
>
> =C2=A0 =C2=A0 =C2=A0 tglx
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
