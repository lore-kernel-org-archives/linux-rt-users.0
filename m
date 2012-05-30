From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] RFC - rt-tools: Detect whether numa is available at build time
Date: Wed, 30 May 2012 21:58:50 +0200
Message-ID: <CAONaPpE0eezsxwmWXV5zkavkEYiYHRXHX6EBBYOVw0W6vuvnCg@mail.gmail.com>
References: <1337989189-17563-1-git-send-email-jkacur@redhat.com>
	<4FC41D20.1010105@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	rt-users <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56665 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab2E3T6w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 May 2012 15:58:52 -0400
Received: by vbbff1 with SMTP id ff1so145131vbb.19
        for <linux-rt-users@vger.kernel.org>; Wed, 30 May 2012 12:58:51 -0700 (PDT)
In-Reply-To: <4FC41D20.1010105@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 29, 2012 at 2:49 AM, Frank Rowand <frank.rowand@am.sony.com=
> wrote:
>
> On 05/25/12 16:39, John Kacur wrote:
> > This is a preliminary hack, I need to clean it up a little, but inc=
ase
> > you
> > want to give it a try, here is the alpha version.
> >
> > Note - I stole this methodology from tools/perf
> >
> > Signed-off-by: John Kacur <jkacur@redhat.com>
>
> I knew I would regret suggesting this fix.
>
> It works fine on my fedora 12 x86_64 system for native build.
>
> It works fine on my fedora 12 x86_64 system for crossbuild for ARM.
>
> The NUMA=3D0 option is still useful (thank you for leaving that
> in place). =A0I have a second ARM target board, where the cross
> linker does not complain about libnuma, so cyclictest is
> build with libnuma. =A0But my run time environment does not have
> a libnuma. =A0Ah the joy of pre-release file systems. =A0The NUMA=3D0
> option allowed me to properly build cyclictest to run on this
> not quite yet finished file system.
>
> Tested-by: Frank Rowand <frank.rowand@am.sony.com>
>

Thank you very much for testing my quick hack. (tglx has anointed it
the beer on the couch hack)
What happens when you run a compiled with libnuma binary on a ARM
target that doesn't have numa, as long as you don't supply the numa
function?

Thanks
John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
