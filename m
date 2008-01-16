From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt2
Date: Tue, 15 Jan 2008 23:01:42 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801152259200.19680@gandalf.stny.rr.com>
References: <1200336080.318.8.camel@localhost.localdomain>
 <200801150237.44029.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: =?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur <caglar@pardus.org.tr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:63896 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbYAPECQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Jan 2008 23:02:16 -0500
In-Reply-To: <200801150237.44029.caglar@pardus.org.tr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Tue, 15 Jan 2008, [utf-8] S.=C3^Ga=C4^_lar Onur wrote:

>
> 2.6.24-rc7-rt2 (-rt2 patchset on top of Linus's current git commit
> 031f2dcd7075e218e74dd7f942ad015cf82dffab) starts to complain like fol=
lowing
> (full dmesg can be found @ [1]) when try to login from console (the o=
ther
> acpi related errors also existed in 2.6.24-rc5-rt1) and FYI, plain 2.=
6.24-rc7
> (again commit 031f2dcd7075e218e74dd7f942ad015cf82dffab) has no issues=
=2E

Do you get the same issues if you add to -rc7 and not git.

>
> [...]
> sysfs: duplicate filename 'vcs1' can not be created
> WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
> Pid: 1298, comm: mingetty Not tainted 2.6.24-rc7-rt2-99 #1
> [...]
>
> And because of mcount-add-basic-support-for-gcc-profiler-instrum.patc=
h, closed
> source nvidia-new module cannot be used with this release (mcount is =
exported
> GPL only), i know this is not supported but i used it with that [2] p=
atch up
> until now without a single problem.

Ah, sorry about that. I'll try to fix that later on. You should still b=
e
able to use NVidia by turning off function trace.

>
> Please don't misunderstand this, i really do not want to start a disc=
ussion
> for this, i just want to ask the possibility of converting this into
> EXPORT_SYMBOL cause i thought some of the possible -rt users may need=
 this
> closed source module explicitly because of its 3D performance.
>
> If anything else needed for sysfs warnings please just say it...
>
> [1] http://cekirdek.pardus.org.tr/~caglar/dmesg.rt
> [2]
> http://svn.pardus.org.tr/pardus/devel/kernel/drivers/nvidia-new/files=
/rt.patch
>

Thanks for the report. I'll see what I can do for the next release. But
for now this will have to wait till after -rt3.

-- Steve
